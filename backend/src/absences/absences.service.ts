import { Injectable, NotFoundException, ForbiddenException, forwardRef, Inject } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateAbsenceDto, UpdateAbsenceDto } from './dto/absence.dto';
import { Absence } from './entities/absence.entity';
import { StudentsGroup } from '../students-groups/entities/students-group.entity';
import { DutyEventsService } from '../duty-events/duty-events.service';

@Injectable()
export class AbsencesService {
      constructor(
    @InjectRepository(Absence)
    private readonly repo: Repository<Absence>,
    @InjectRepository(StudentsGroup)
    private readonly sgRepo: Repository<StudentsGroup>,
    @Inject(forwardRef(() => DutyEventsService))
    private readonly dutyEventsService: DutyEventsService,
  ) {}

  /**
   * Проверить, что студент принадлежит пользователю.
   * Принадлежность — студент состоит хотя бы в одной группе пользователя.
   */
  private async assertStudentOwner(userId: number, studentId: number): Promise<void> {
    const link = await this.sgRepo
      .createQueryBuilder('sg')
      .innerJoin('sg.group', 'g', 'g.user_id = :userId', { userId })
      .where('sg.student_id = :studentId', { studentId })
      .getOne();
    if (!link) throw new ForbiddenException();
  }

    /** Проверить владельца записи об отсутствии через students_groups → group.user_id */
  private async assertOwner(userId: number, id: number): Promise<Absence> {
    // createQueryBuilder вместо findOne — не открывает лишних соединений из пула
    const absence = await this.repo
      .createQueryBuilder('a')
      .where('a.id = :id', { id })
      .getOne();
    if (!absence) throw new NotFoundException('Запись об отсутствии не найдена');
    await this.assertStudentOwner(userId, absence.student_id);
    return absence;
  }

    /** Зарегистрировать отсутствие студента.
   *  После сохранения автоматически переназначает все pending-события
   *  студента, попадающие в диапазон отсутствия.
   */
        async create(userId: number, dto: CreateAbsenceDto): Promise<Absence> {
    await this.assertStudentOwner(userId, dto.student_id);
    const result = await this.repo.insert({
      student_id: dto.student_id,
      date_from: dto.date_from as unknown as Date,
      date_to: dto.date_to as unknown as Date,
      reason: dto.reason ?? null,
      is_approved: dto.is_approved ?? false,
    });
    const id = result.identifiers[0].id;
    // createQueryBuilder вместо findOneOrFail — не открывает лишних соединений из пула
    const saved = await this.repo
      .createQueryBuilder('a')
      .where('a.id = :id', { id })
      .getOne();
    if (!saved) throw new NotFoundException('Запись об отсутствии не найдена после создания');
    await this.dutyEventsService.handleAbsenceUpsert(saved);
    return saved;
  }

    /** Список отсутствий студентов пользователя (через students_groups → group.user_id) */
  async findAll(userId: number, studentId?: number): Promise<Absence[]> {
    const qb = this.repo
      .createQueryBuilder('a')
      .innerJoin('a.student', 's')
      .innerJoin('s.group_links', 'sg')
      .innerJoin('sg.group', 'g', 'g.user_id = :userId', { userId })
      .addSelect(['s.id', 's.name'])
      .orderBy('a.date_from', 'DESC');
    if (studentId) qb.andWhere('a.student_id = :studentId', { studentId });
    return qb.getMany();
  }

  async findOne(userId: number, id: number): Promise<Absence> {
    return this.assertOwner(userId, id);
  }

    /** Обновить запись об отсутствии.
   *  После сохранения автоматически переназначает pending-события
   *  студента в новом диапазоне дат.
   */
        async update(userId: number, id: number, dto: UpdateAbsenceDto): Promise<Absence> {
    const absence = await this.assertOwner(userId, id);
    await this.repo.update(id, {
      date_from: dto.date_from ?? absence.date_from,
      date_to: dto.date_to ?? absence.date_to,
      reason: dto.reason !== undefined ? dto.reason : absence.reason,
      is_approved: dto.is_approved !== undefined ? dto.is_approved : absence.is_approved,
    });
    // createQueryBuilder вместо findOneOrFail — не открывает лишних соединений из пула
    const saved = await this.repo
      .createQueryBuilder('a')
      .where('a.id = :id', { id })
      .getOne();
    if (!saved) throw new NotFoundException('Запись об отсутствии не найдена после обновления');
    await this.dutyEventsService.handleAbsenceUpsert(saved);
    return saved;
  }

  async remove(userId: number, id: number): Promise<void> {
    await this.assertOwner(userId, id);
    await this.repo.delete(id);
  }
}