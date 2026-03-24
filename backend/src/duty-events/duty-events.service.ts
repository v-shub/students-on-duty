import {
  Injectable,
  NotFoundException,
  ForbiddenException,
  BadRequestException,
  Logger,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, In, DataSource } from 'typeorm';
import { DutyEvent } from './entities/duty-event.entity';
import { DutySchedule } from '../duty-schedules/entities/duty-schedule.entity';
import { DutyDay } from '../duty-days/entities/duty-day.entity';
import { Student } from '../students/entities/student.entity';
import { Absence } from '../absences/entities/absence.entity';
import { Group } from '../groups/entities/group.entity';
import { UpdateDutyEventDto } from './dto/duty-event.dto';

/** Порядковый номер дня недели JS (0=вс) → поле DutyDay */
const DOW_FIELD: Record<number, keyof DutyDay> = {
  1: 'is_monday',
  2: 'is_tuesday',
  3: 'is_wednesday',
  4: 'is_thursday',
  5: 'is_friday',
  6: 'is_saturday',
  0: 'is_sunday',
};

@Injectable()
export class DutyEventsService {
  private readonly logger = new Logger(DutyEventsService.name);

  constructor(
    @InjectRepository(DutyEvent)
    private readonly eventRepo: Repository<DutyEvent>,
    @InjectRepository(DutySchedule)
    private readonly scheduleRepo: Repository<DutySchedule>,
    @InjectRepository(Student)
    private readonly studentRepo: Repository<Student>,
    @InjectRepository(Absence)
    private readonly absenceRepo: Repository<Absence>,
    @InjectRepository(Group)
    private readonly groupRepo: Repository<Group>,
    private readonly dataSource: DataSource,
  ) {}

  // ─── Вспомогательные методы ───────────────────────────────────────────────

  private async assertScheduleOwner(userId: number, scheduleId: number): Promise<DutySchedule> {
    const schedule = await this.scheduleRepo
      .createQueryBuilder('s')
      .innerJoinAndSelect('s.group', 'g')
      .innerJoinAndSelect('s.duty_type', 'dt')
      .leftJoinAndSelect('s.duty_days', 'dd')
      .where('s.id = :scheduleId', { scheduleId })
      .getOne();
    if (!schedule) throw new NotFoundException('Расписание не найдено');
    if (schedule.group.user_id !== userId) throw new ForbiddenException();
    return schedule;
  }

  /**
   * Загрузить всех активных студентов группы вместе с их отсутствиями на дату.
   */
  private async loadStudentsWithAbsences(
    groupId: number,
    dateStr: string,
    excludeScheduleId?: number,
  ): Promise<{ available: Student[]; absent: Array<{ student: Student; absence: Absence }> }> {
    const active = await this.studentRepo
      .createQueryBuilder('st')
      .innerJoin('st.group_links', 'sg', 'sg.group_id = :groupId', { groupId })
      .where('st.is_active = true')
      .getMany();

    if (active.length === 0) {
      throw new BadRequestException('В группе нет активных студентов');
    }

    const activeIds = active.map((s) => s.id);
    
    let busyStudentIds = new Set<number>();
    if (activeIds.length > 0) {
      const busyEventsQb = this.eventRepo
        .createQueryBuilder('e')
        .select('e.student_id')
        .where('e.duty_date = :date', { date: dateStr })
        .andWhere('e.status = :status', { status: 'pending' })
        .andWhere('e.student_id IN (:...ids)', { ids: activeIds });

      if (excludeScheduleId !== undefined) {
        busyEventsQb.andWhere('e.schedule_id != :excludeScheduleId', { excludeScheduleId });
      }

      const busyEvents = await busyEventsQb.getMany();
      busyStudentIds = new Set(busyEvents.map((e) => e.student_id));
    }

    let absences: Absence[] = [];
    if (activeIds.length > 0) {
      absences = await this.absenceRepo
        .createQueryBuilder('a')
        .where('a.student_id IN (:...ids)', { ids: activeIds })
        .andWhere('a.date_from <= :date', { date: dateStr })
        .andWhere('a.date_to >= :date', { date: dateStr })
        .getMany();
    }
    
    const absenceByStudentId = new Map<number, Absence>(absences.map((a) => [a.student_id, a]));

    const available: Student[] = [];
    const absent: Array<{ student: Student; absence: Absence }> = [];

    for (const student of active) {
      if (busyStudentIds.has(student.id)) continue;
      const absence = absenceByStudentId.get(student.id);
      if (absence) {
        absent.push({ student, absence });
      } else {
        available.push(student);
      }
    }

    return { available, absent };
  }

  /**
   * Назначить студентов на дежурство - без явной транзакции, с повторными попытками
   */
  private async assignStudents(
    schedule: DutySchedule,
    dateStr: string,
    count: number,
  ): Promise<DutyEvent[]> {
    return await this.executeWithRetry(async () => {
      const { available, absent } = await this.loadStudentsWithAbsences(
        schedule.group_id, 
        dateStr, 
        schedule.id
      );
      
      const defaultScore = schedule.duty_type.default_score;
      
      const allStudents = [
        ...available.map((s) => ({ student: s, absence: null as Absence | null, type: 'available' as const })),
        ...absent.map(({ student, absence }) => ({ student, absence, type: 'absent' as const })),
      ].sort((a, b) => a.student.duty_score - b.student.duty_score);

      const eventsToInsert: any[] = [];
      const usedAvailableIds = new Set<number>();
      const processedIds = new Set<number>();
      const pendingAssignments: Student[] = [];
      const penaltiesToApply: Array<{ id: number; penalty: number }> = [];
      
      for (let slot = 0; slot < count; slot++) {
        for (const entry of allStudents) {
          if (processedIds.has(entry.student.id)) continue;
          processedIds.add(entry.student.id);

          if (entry.type === 'absent') {
            let scoreEarned = 0;
            if (!entry.absence!.is_approved) {
              scoreEarned = -defaultScore;
              penaltiesToApply.push({ id: entry.student.id, penalty: scoreEarned });
            }
            
            eventsToInsert.push({
              student_id: entry.student.id,
              schedule_id: schedule.id,
              duty_date: dateStr,
              status: 'reassigned',
              score_earned: scoreEarned,
              notes: entry.absence!.is_approved
                ? 'Отсутствие одобрено'
                : 'Отсутствие не одобрено — штраф',
            });
            
            const replacement = available.find(s => !usedAvailableIds.has(s.id) && !processedIds.has(s.id));
            if (replacement) {
              usedAvailableIds.add(replacement.id);
              processedIds.add(replacement.id);
              pendingAssignments.push(replacement);
            }
            break;
          } else {
            if (usedAvailableIds.has(entry.student.id)) continue;
            usedAvailableIds.add(entry.student.id);
            pendingAssignments.push(entry.student);
            break;
          }
        }
      }
      
      for (const student of pendingAssignments) {
        eventsToInsert.push({
          student_id: student.id,
          schedule_id: schedule.id,
          duty_date: dateStr,
          status: 'pending',
          score_earned: null,
          notes: null,
        });
      }
      
      let insertedEvents: DutyEvent[] = [];
      
      // Выполняем операции последовательно, без транзакции
      // При ошибке retry повторит всю операцию целиком
      if (eventsToInsert.length > 0) {
        const result = await this.eventRepo
          .createQueryBuilder()
          .insert()
          .into(DutyEvent)
          .values(eventsToInsert)
          .returning('*')
          .execute();
        insertedEvents = result.generatedMaps as DutyEvent[];
      }
      
      if (penaltiesToApply.length > 0) {
        // Обновляем каждого студента отдельно, но с retry на уровне всей операции
        for (const { id, penalty } of penaltiesToApply) {
          await this.studentRepo.increment({ id }, 'duty_score', penalty);
        }
      }
      
      return insertedEvents;
    });
  }

  /** Создать события для одной даты */
  private async generateForDate(schedule: DutySchedule, date: Date): Promise<DutyEvent[]> {
    const dateStr = date.toISOString().split('T')[0];

    const existing = await this.eventRepo.find({
      where: {
        schedule_id: schedule.id,
        duty_date: dateStr as unknown as Date,
      },
      take: 1,
    });
    
    if (existing.length > 0) return existing;

    return this.assignStudents(schedule, dateStr, schedule.students_per_day);
  }

  // ─── Публичные методы ─────────────────────────────────────────────────────

  async generateForToday(): Promise<void> {
    const today = new Date();
    const field = DOW_FIELD[today.getDay()];
    const todayStr = today.toISOString().split('T')[0];

    const schedules = await this.scheduleRepo
      .createQueryBuilder('s')
      .innerJoinAndSelect('s.duty_days', 'dd')
      .innerJoinAndSelect('s.group', 'g')
      .innerJoinAndSelect('s.duty_type', 'dt')
      .where('s.is_active = true')
      .andWhere(`dd.${field} = true`)
      .andWhere('s.start_date <= :today', { today: todayStr })
      .andWhere('(s.end_date IS NULL OR s.end_date >= :today)', { today: todayStr })
      .getMany();

    for (const schedule of schedules) {
      try {
        await this.generateForDate(schedule, today);
      } catch (error) {
        this.logger.error(`Failed to generate for schedule ${schedule.id}: ${error.message}`);
      }
    }
  }

  async generateManual(userId: number, scheduleId: number, dateStr: string): Promise<DutyEvent[]> {
    const schedule = await this.assertScheduleOwner(userId, scheduleId);
    if (!schedule.is_active) throw new BadRequestException('Расписание неактивно');
    const date = new Date(dateStr);
    if (isNaN(date.getTime())) throw new BadRequestException('Неверный формат даты');
    return this.generateForDate(schedule, date);
  }

  /**
   * Вызывается при создании или обновлении записи об отсутствии.
   */
  async handleAbsenceUpsert(absence: Absence): Promise<void> {
    await this.executeWithRetry(async () => {
      // 1. Найти все pending-события студента в диапазоне отсутствия
      const pendingEvents = await this.eventRepo
        .createQueryBuilder('e')
        .innerJoinAndSelect('e.schedule', 's')
        .innerJoinAndSelect('s.duty_type', 'dt')
        .innerJoinAndSelect('s.group', 'g')
        .where('e.student_id = :studentId', { studentId: absence.student_id })
        .andWhere('e.status = :status', { status: 'pending' })
        .andWhere('e.duty_date >= :from', { from: absence.date_from })
        .andWhere('e.duty_date <= :to', { to: absence.date_to })
        .getMany();

      if (pendingEvents.length === 0) return;

      const defaultScore = pendingEvents[0]?.schedule?.duty_type?.default_score || 0;
      const shouldPenalty = !absence.is_approved && defaultScore > 0;
      const eventIds = pendingEvents.map(e => e.id);
      
      // 2. Обновляем события
      await this.eventRepo.update(
        { id: In(eventIds) },
        {
          status: 'reassigned',
          score_earned: shouldPenalty ? -defaultScore : null,
          notes: absence.is_approved
            ? 'Отсутствие одобрено — переназначено'
            : 'Отсутствие не одобрено — переназначено со штрафом',
        }
      );
      
      // 3. Применяем штраф
      if (shouldPenalty) {
        await this.studentRepo.increment(
          { id: absence.student_id },
          'duty_score',
          -defaultScore
        );
      }
      
      // 4. Группируем события по schedule_id и duty_date
      const eventsByScheduleAndDate = new Map<string, { 
        schedule: DutySchedule; 
        dateStr: string; 
        count: number;
      }>();
      
      for (const event of pendingEvents) {
        const key = `${event.schedule_id}_${event.duty_date}`;
        if (!eventsByScheduleAndDate.has(key)) {
          eventsByScheduleAndDate.set(key, {
            schedule: event.schedule,
            dateStr: (event.duty_date as unknown as string).slice(0, 10),
            count: 0,
          });
        }
        eventsByScheduleAndDate.get(key)!.count++;
      }
      
      // 5. Ищем замены
      const replacementEvents: any[] = [];
      
      for (const { schedule, dateStr, count } of eventsByScheduleAndDate.values()) {
        const { available } = await this.loadStudentsWithAbsences(
          schedule.group_id,
          dateStr,
          schedule.id
        );
        
        if (available.length > 0) {
          const neededReplacements = Math.min(count, available.length);
          
          for (let i = 0; i < neededReplacements; i++) {
            replacementEvents.push({
              student_id: available[i].id,
              schedule_id: schedule.id,
              duty_date: dateStr,
              status: 'pending',
              score_earned: null,
              notes: `Замена для студента ID:${absence.student_id} (${absence.is_approved ? 'одобрено' : 'не одобрено'})`,
            });
          }
        }
      }
      
      // 6. Вставляем замены
      if (replacementEvents.length > 0) {
        await this.eventRepo
          .createQueryBuilder()
          .insert()
          .into(DutyEvent)
          .values(replacementEvents)
          .execute();
      }
    });
  }

  /** Список событий пользователя */
  async findAll(userId: number, scheduleId?: number): Promise<DutyEvent[]> {
    const qb = this.eventRepo
      .createQueryBuilder('e')
      .innerJoin('e.schedule', 's')
      .innerJoin('s.group', 'g', 'g.user_id = :userId', { userId })
      .leftJoinAndSelect('e.student', 'st')
      .orderBy('e.duty_date', 'DESC');
    if (scheduleId) qb.andWhere('e.schedule_id = :scheduleId', { scheduleId });
    return qb.getMany();
  }

  /** Получить одно событие */
  async findOne(userId: number, id: number): Promise<DutyEvent> {
    const event = await this.eventRepo
      .createQueryBuilder('e')
      .innerJoinAndSelect('e.schedule', 's')
      .innerJoinAndSelect('s.group', 'g')
      .innerJoinAndSelect('s.duty_type', 'dt')
      .leftJoinAndSelect('e.student', 'st')
      .where('e.id = :id', { id })
      .getOne();
    if (!event) throw new NotFoundException('Событие не найдено');
    if (event.schedule.group.user_id !== userId) throw new ForbiddenException();
    return event;
  }

  /** Обновление статуса */
  async updateStatus(userId: number, id: number, dto: UpdateDutyEventDto): Promise<DutyEvent> {
    return await this.executeWithRetry(async () => {
      const event = await this.findOne(userId, id);

      if (event.status === dto.status) {
        throw new BadRequestException('Статус уже установлен');
      }

      if (event.status === 'reassigned') {
        throw new BadRequestException('Нельзя изменить статус переназначенного события');
      }

      const defaultScore = event.schedule.duty_type.default_score;

      // Откатить ранее начисленный score если был
      if (event.score_earned !== null && event.score_earned !== 0) {
        await this.studentRepo.increment(
          { id: event.student_id },
          'duty_score',
          -event.score_earned,
        );
      }

      let newScoreEarned: number | null = null;

      if (dto.status === 'completed') {
        newScoreEarned = defaultScore;
        await this.studentRepo.increment(
          { id: event.student_id },
          'duty_score',
          newScoreEarned,
        );
      }

      await this.eventRepo.update(id, {
        status: dto.status,
        score_earned: newScoreEarned,
        notes: dto.notes !== undefined ? dto.notes : event.notes,
      });

      return await this.eventRepo.findOne({ where: { id } }) as DutyEvent;
    });
  }

  /**
   * Универсальный метод для выполнения операций с повторными попытками
   */
  private async executeWithRetry<T>(
    operation: () => Promise<T>,
    maxRetries: number = 3,
    delay: number = 1000
  ): Promise<T> {
    let lastError: Error;
    
    for (let attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        return await operation();
      } catch (error) {
        lastError = error as Error;
        const errorMessage = error.message?.toLowerCase() || '';
        
        // Проверяем, связана ли ошибка с соединением
        const isConnectionError = 
          errorMessage.includes('connection terminated') ||
          errorMessage.includes('connection closed') ||
          errorMessage.includes('connection lost') ||
          errorMessage.includes('timeout') ||
          errorMessage.includes('could not connect') ||
          errorMessage.includes('query runner already released');
        
        if (!isConnectionError || attempt === maxRetries) {
          this.logger.error(
            `Operation failed after ${attempt} attempt(s): ${error.message}`,
            error.stack
          );
          throw error;
        }
        
        // Экспоненциальная задержка
        const waitTime = delay * Math.pow(2, attempt - 1);
        this.logger.warn(
          `Connection error, retrying in ${waitTime}ms (attempt ${attempt}/${maxRetries}): ${error.message}`
        );
        
        await new Promise(resolve => setTimeout(resolve, waitTime));
      }
    }
    
    throw lastError!;
  }
}