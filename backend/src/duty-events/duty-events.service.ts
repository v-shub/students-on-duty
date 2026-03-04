import {
  Injectable,
  NotFoundException,
  ForbiddenException,
  BadRequestException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { DutyEvent } from './entities/duty-event.entity';
import { DutySchedule } from '../duty-schedules/entities/duty-schedule.entity';
import { DutyDay } from '../duty-days/entities/duty-day.entity';
import { Student } from '../students/entities/student.entity';
import { StudentsGroup } from '../students-groups/entities/students-group.entity';
import { Absence } from '../absences/entities/absence.entity';
import { Group } from '../groups/entities/group.entity';
import { UpdateDutyEventDto } from './dto/duty-event.dto';
import type { DutyStatus } from './dto/duty-event.dto';

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
   * Выбрать активных студентов группы с наименьшим duty_score,
   * исключая отсутствующих в указанную дату.
   */
  private async pickStudents(groupId: number, date: Date, count: number): Promise<Student[]> {
    const dateStr = date.toISOString().split('T')[0];

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
    const absentIds = new Set(absences.map((a) => a.student_id));

    const available = active.filter((s) => !absentIds.has(s.id));
    if (available.length === 0) throw new BadRequestException('Нет доступных студентов (все отсутствуют)');

    available.sort((a, b) => a.duty_score - b.duty_score);
    return available.slice(0, count);
  }

  /** Создать события для одной даты (пропускает если уже существуют) */
  private async generateForDate(schedule: DutySchedule, date: Date): Promise<DutyEvent[]> {
    const dateStr = date.toISOString().split('T')[0];
    const existing = await this.eventRepo.find({
      where: { schedule_id: schedule.id, duty_date: dateStr as unknown as Date },
    });
    if (existing.length > 0) return existing;

    const students = await this.pickStudents(schedule.group_id, date, schedule.students_per_day);
    const events = students.map((s) =>
      this.eventRepo.create({
        student_id: s.id,
        schedule_id: schedule.id,
        duty_date: dateStr as unknown as Date,
        status: 'pending',
        score_delta: null,
        notes: null,
      }),
    );
    return this.eventRepo.save(events);
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
   * Изменить статус события + пересчитать duty_score студента.
   *
   * pending → completed:      +default_score (выполнил)
   * pending → missed:         -default_score (пропустил без уважительной причины)
   * pending → missed_approved: 0             (пропустил, но одобрено)
   * pending → cancelled:       0             (отменено)
   *
   * Повторная смена статуса откатывает предыдущий score_delta.
   */
  async updateStatus(userId: number, id: number, dto: UpdateDutyEventDto): Promise<DutyEvent> {
    const event = await this.findOne(userId, id);

    if (dto.status && dto.status === event.status) {
      throw new BadRequestException('Статус уже установлен');
    }

    return this.dataSource.transaction(async (manager) => {
      const eventRepo = manager.getRepository(DutyEvent);
      const studentRepo = manager.getRepository(Student);

      // Откатить предыдущий score_delta
      if (event.score_delta !== null && event.score_delta !== 0) {
        await studentRepo.increment({ id: event.student_id }, 'duty_score', -event.score_delta);
      }

      let newDelta = 0;
      const defaultScore = event.schedule.duty_type.default_score;

      if (dto.status === 'completed') {
        newDelta = defaultScore;
        await studentRepo.increment({ id: event.student_id }, 'duty_score', newDelta);
      } else if (dto.status === 'missed') {
        newDelta = -defaultScore;
        await studentRepo.increment({ id: event.student_id }, 'duty_score', newDelta);
      }
      // missed_approved → newDelta = 0, score не меняется
      // cancelled       → newDelta = 0, score не меняется

      if (dto.status) event.status = dto.status;
      event.score_delta = newDelta;
      if (dto.notes !== undefined) event.notes = dto.notes;

      return eventRepo.save(event);
    });
  }
}