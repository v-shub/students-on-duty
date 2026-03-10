import {
  Injectable,
  NotFoundException,
  ForbiddenException,
  BadRequestException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, EntityManager, Repository } from 'typeorm';
import { DutyEvent } from './entities/duty-event.entity';
import { DutySchedule } from '../duty-schedules/entities/duty-schedule.entity';
import { DutyDay } from '../duty-days/entities/duty-day.entity';
import { Student } from '../students/entities/student.entity';
import { StudentsGroup } from '../students-groups/entities/students-group.entity';
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
  constructor(
    @InjectRepository(DutyEvent)
    private readonly eventRepo: Repository<DutyEvent>,
    @InjectRepository(DutySchedule)
    private readonly scheduleRepo: Repository<DutySchedule>,
    @InjectRepository(Student)
    private readonly studentRepo: Repository<Student>,
    @InjectRepository(StudentsGroup)
    private readonly sgRepo: Repository<StudentsGroup>,
    @InjectRepository(Absence)
    private readonly absenceRepo: Repository<Absence>,
    @InjectRepository(Group)
    private readonly groupRepo: Repository<Group>,
    private readonly dataSource: DataSource,
  ) {}

  // ─── Вспомогательные методы ───────────────────────────────────────────────

  private async assertScheduleOwner(userId: number, scheduleId: number): Promise<DutySchedule> {
    const schedule = await this.scheduleRepo.findOne({
      where: { id: scheduleId },
      relations: ['group', 'duty_type', 'duty_days'],
    });
    if (!schedule) throw new NotFoundException('Расписание не найдено');
    if (schedule.group.user_id !== userId) throw new ForbiddenException();
    return schedule;
  }

    /**
   * Загрузить всех активных студентов группы вместе с их отсутствиями на дату.
   * Возвращает два списка: доступные (не отсутствуют) и отсутствующие.
   */
  private async loadStudentsWithAbsences(
    groupId: number,
    dateStr: string,
  ): Promise<{ available: Student[]; absent: Array<{ student: Student; absence: Absence }> }> {
    const links = await this.sgRepo.find({
      where: { group_id: groupId },
      relations: ['student'],
    });
    const active = links.map((l) => l.student).filter((s) => s.is_active);

    if (active.length === 0) throw new BadRequestException('В группе нет активных студентов');

    const absences = await this.absenceRepo
      .createQueryBuilder('a')
      .where('a.student_id IN (:...ids)', { ids: active.map((s) => s.id) })
      .andWhere('a.date_from <= :date', { date: dateStr })
      .andWhere('a.date_to >= :date', { date: dateStr })
      .getMany();

    const absenceByStudentId = new Map<number, Absence>(absences.map((a) => [a.student_id, a]));

    const available: Student[] = [];
    const absent: Array<{ student: Student; absence: Absence }> = [];

    for (const student of active) {
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
   * Назначить студентов на дежурство с учётом отсутствий.
   *
   * Алгоритм для каждого из `count` слотов:
   * 1. Берём студента с наименьшим duty_score из ещё не выбранных (включая отсутствующих).
   * 2. Если студент отсутствует — создаём событие со статусом `reassigned`,
   *    применяем штраф (-score) если отсутствие не одобрено,
   *    затем продолжаем поиск замены среди оставшихся доступных студентов.
   * 3. Первый доступный студент (не отсутствует) получает статус `pending`.
   *
   * Таким образом все студенты (включая отсутствующих) участвуют в очереди по score,
   * и никто не «пропускает» свою очередь бесплатно без уважительной причины.
   */
  private async assignStudents(
    manager: EntityManager,
    schedule: DutySchedule,
    dateStr: string,
    count: number,
  ): Promise<DutyEvent[]> {
    const eventRepo = manager.getRepository(DutyEvent);
    const studentRepo = manager.getRepository(Student);

    const { available, absent } = await this.loadStudentsWithAbsences(schedule.group_id, dateStr);
    const defaultScore = schedule.duty_type.default_score;

    // Объединяем всех студентов, сортируем по duty_score (наименьший — первый)
    const allStudents = [
      ...available.map((s) => ({ student: s, absence: null as Absence | null })),
      ...absent.map(({ student, absence }) => ({ student, absence })),
    ].sort((a, b) => a.student.duty_score - b.student.duty_score);

    const createdEvents: DutyEvent[] = [];
    // Индексы студентов из available, которые уже назначены на pending
    const usedAvailableIds = new Set<number>();
    // Индексы уже обработанных студентов (reassigned + pending)
    const processedIds = new Set<number>();

    for (let slot = 0; slot < count; slot++) {
      // Перебираем очередь: ищем первого ещё не обработанного студента
      for (const entry of allStudents) {
        if (processedIds.has(entry.student.id)) continue;

        processedIds.add(entry.student.id);

        if (entry.absence !== null) {
          // Студент отсутствует — создаём reassigned событие
          let scoreEarned = 0;
          if (!entry.absence.is_approved) {
            // Неодобренное отсутствие — штраф
            scoreEarned = -defaultScore;
            await studentRepo.increment({ id: entry.student.id }, 'duty_score', scoreEarned);
          }

          const reassignedEvent = eventRepo.create({
            student_id: entry.student.id,
            schedule_id: schedule.id,
            duty_date: dateStr as unknown as Date,
            status: 'reassigned',
            score_earned: scoreEarned === 0 ? null : scoreEarned,
            notes: entry.absence.is_approved
              ? 'Отсутствие одобрено'
              : 'Отсутствие не одобрено — штраф',
          });
          createdEvents.push(await eventRepo.save(reassignedEvent));

          // Ищем замену среди доступных (не отсутствующих), ещё не назначенных
          const replacement = available.find(
            (s) => !usedAvailableIds.has(s.id) && !processedIds.has(s.id),
          );

          if (replacement) {
            usedAvailableIds.add(replacement.id);
            processedIds.add(replacement.id);

            const pendingEvent = eventRepo.create({
              student_id: replacement.id,
              schedule_id: schedule.id,
              duty_date: dateStr as unknown as Date,
              status: 'pending',
              score_earned: null,
              notes: null,
            });
            createdEvents.push(await eventRepo.save(pendingEvent));
          }
          // Слот закрыт (либо с заменой, либо без — если доступных не осталось)
          break;
        } else {
          // Студент доступен — назначаем на pending
          if (usedAvailableIds.has(entry.student.id)) continue;

          usedAvailableIds.add(entry.student.id);

          const pendingEvent = eventRepo.create({
            student_id: entry.student.id,
            schedule_id: schedule.id,
            duty_date: dateStr as unknown as Date,
            status: 'pending',
            score_earned: null,
            notes: null,
          });
          createdEvents.push(await eventRepo.save(pendingEvent));
          break;
        }
      }
    }

    return createdEvents;
  }

  /** Создать события для одной даты (пропускает если уже существуют) */
  private async generateForDate(schedule: DutySchedule, date: Date): Promise<DutyEvent[]> {
    const dateStr = date.toISOString().split('T')[0];

    const existing = await this.eventRepo.find({
      where: { schedule_id: schedule.id, duty_date: dateStr as unknown as Date },
    });
    if (existing.length > 0) return existing;

    return this.dataSource.transaction((manager) =>
      this.assignStudents(manager, schedule, dateStr, schedule.students_per_day),
    );
  }

  // ─── Публичные методы ─────────────────────────────────────────────────────

  /**
   * Авто-генерация: вызывается cron-задачей каждый день.
   * Создаёт события на сегодня для всех активных расписаний,
   * у которых сегодня — рабочий день по duty_days.
   */
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
      } catch {
        // Пропускаем расписания без доступных студентов — не прерываем цикл
      }
    }
  }

  /**
   * Ручная генерация событий на указанную дату для расписания.
   * Пользователь сам выбирает дату, студенты подбираются автоматически
   * по минимальному duty_score с учётом отсутствий.
   */
  async generateManual(userId: number, scheduleId: number, dateStr: string): Promise<DutyEvent[]> {
    const schedule = await this.assertScheduleOwner(userId, scheduleId);
    if (!schedule.is_active) throw new BadRequestException('Расписание неактивно');
    const date = new Date(dateStr);
    if (isNaN(date.getTime())) throw new BadRequestException('Неверный формат даты');
    return this.generateForDate(schedule, date);
  }

    /**
   * Вызывается при создании или обновлении записи об отсутствии.
   * Находит все pending-события студента в диапазоне дат отсутствия
   * и переназначает их: переводит в `reassigned` (с штрафом если не одобрено),
   * затем для каждого расписания создаёт новое pending-событие для замены.
   */
  async handleAbsenceUpsert(absence: Absence): Promise<void> {
    // Найти все pending-события студента в диапазоне отсутствия
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

    await this.dataSource.transaction(async (manager) => {
      const eventRepo = manager.getRepository(DutyEvent);
      const studentRepo = manager.getRepository(Student);

      for (const event of pendingEvents) {
        const defaultScore = event.schedule.duty_type.default_score;
        const dateStr = (event.duty_date as unknown as string).slice(0, 10);

        // Штраф только если отсутствие не одобрено
        let scoreEarned: number | null = null;
        if (!absence.is_approved && defaultScore > 0) {
          scoreEarned = -defaultScore;
          await studentRepo.increment({ id: absence.student_id }, 'duty_score', scoreEarned);
        }

        // Переводим текущее событие в reassigned
        event.status = 'reassigned';
        event.score_earned = scoreEarned;
        event.notes = absence.is_approved
          ? 'Отсутствие одобрено'
          : 'Отсутствие не одобрено — штраф';
        await eventRepo.save(event);

        // Ищем замену: активный студент той же группы, не отсутствующий в эту дату,
        // ещё не имеющий события в этом расписании на эту дату, с наименьшим duty_score
        const links = await manager.getRepository(StudentsGroup).find({
          where: { group_id: event.schedule.group_id },
          relations: ['student'],
        });
        const activeStudents = links.map((l) => l.student).filter((s) => s.is_active);

        // Студенты уже имеющие событие на эту дату в этом расписании
        const existingEvents = await eventRepo
          .createQueryBuilder('e')
          .where('e.schedule_id = :scheduleId', { scheduleId: event.schedule_id })
          .andWhere('e.duty_date = :date', { date: dateStr })
          .getMany();
        const assignedStudentIds = new Set(existingEvents.map((e) => e.student_id));

        // Студенты отсутствующие в эту дату
        const absencesOnDate = await manager.getRepository(Absence)
          .createQueryBuilder('a')
          .where('a.student_id IN (:...ids)', { ids: activeStudents.map((s) => s.id) })
          .andWhere('a.date_from <= :date', { date: dateStr })
          .andWhere('a.date_to >= :date', { date: dateStr })
          .getMany();
        const absentIds = new Set(absencesOnDate.map((a) => a.student_id));

        // Кандидаты на замену: не отсутствуют и ещё не назначены на эту дату/расписание
        const candidates = activeStudents
          .filter((s) => !absentIds.has(s.id) && !assignedStudentIds.has(s.id))
          .sort((a, b) => a.duty_score - b.duty_score);

        if (candidates.length > 0) {
          const replacement = candidates[0];
          const newEvent = eventRepo.create({
            student_id: replacement.id,
            schedule_id: event.schedule_id,
            duty_date: dateStr as unknown as Date,
            status: 'pending',
            score_earned: null,
            notes: null,
          });
          await eventRepo.save(newEvent);
        }
        // Если замены нет — оставляем только reassigned без нового pending
      }
    });
  }

  /** Список событий пользователя с фильтром по расписанию */
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

  /** Получить одно событие (только владельца) */
  async findOne(userId: number, id: number): Promise<DutyEvent> {
    const event = await this.eventRepo.findOne({
      where: { id },
      relations: ['schedule', 'schedule.group', 'schedule.duty_type', 'student'],
    });
    if (!event) throw new NotFoundException('Событие не найдено');
    if (event.schedule.group.user_id !== userId) throw new ForbiddenException();
    return event;
  }

    /**
   * Изменить статус события пользователем.
   *
   * Допустимые переходы (только из pending):
   *   pending → completed:  студент выполнил дежурство, начисляется +default_score
   *   pending → cancelled:  дежурство отменено, score не меняется
   *
   * Статус reassigned выставляется только автоматически системой при назначении.
   * Повторная смена статуса с completed откатывает ранее начисленный score_earned.
   */
  async updateStatus(userId: number, id: number, dto: UpdateDutyEventDto): Promise<DutyEvent> {
    const event = await this.findOne(userId, id);

    if (event.status === dto.status) {
      throw new BadRequestException('Статус уже установлен');
    }

    if (event.status === 'reassigned') {
      throw new BadRequestException('Нельзя изменить статус переназначенного события');
    }

    if (event.status === 'cancelled' || event.status === 'completed') {
      // Разрешаем смену статуса между completed и cancelled (с откатом очков)
      if (dto.status !== 'completed' && dto.status !== 'cancelled') {
        throw new BadRequestException('Недопустимый переход статуса');
      }
    }

    return this.dataSource.transaction(async (manager) => {
      const eventRepo = manager.getRepository(DutyEvent);
      const studentRepo = manager.getRepository(Student);
      const defaultScore = event.schedule.duty_type.default_score;

      // Откатить ранее начисленный score_earned если был
      if (event.score_earned !== null && event.score_earned !== 0) {
        await studentRepo.increment({ id: event.student_id }, 'duty_score', -event.score_earned);
      }

      let newScoreEarned: number | null = null;

      if (dto.status === 'completed') {
        newScoreEarned = defaultScore;
        await studentRepo.increment({ id: event.student_id }, 'duty_score', newScoreEarned);
      }
      // cancelled → score не меняется, score_earned остаётся null

      event.status = dto.status;
      event.score_earned = newScoreEarned;
      if (dto.notes !== undefined) event.notes = dto.notes;

      return eventRepo.save(event);
    });
  }
}