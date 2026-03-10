import { Injectable, NotFoundException, ForbiddenException, forwardRef, Inject } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateAbsenceDto, UpdateAbsenceDto } from './dto/absence.dto';
import { Absence } from './entities/absence.entity';
import { Student } from '../students/entities/student.entity';
import { DutyEventsService } from '../duty-events/duty-events.service';

@Injectable()
export class AbsencesService {
    constructor(
    @InjectRepository(Absence)
    private readonly repo: Repository<Absence>,
    @InjectRepository(Student)
    private readonly studentRepo: Repository<Student>,
    @Inject(forwardRef(() => DutyEventsService))
    private readonly dutyEventsService: DutyEventsService,
  ) {}

  /** Проверить, что студент принадлежит пользователю */
  private async assertStudentOwner(userId: number, studentId: number): Promise<void> {
    const student = await this.studentRepo.findOne({ where: { id: studentId } });
    if (!student) throw new NotFoundException('Студент не найден');
    if (student.user_id !== userId) throw new ForbiddenException();
  }

  /** Проверить владельца записи об отсутствии */
  private async assertOwner(userId: number, id: number): Promise<Absence> {
    const absence = await this.repo.findOne({
      where: { id },
      relations: ['student'],
    });
    if (!absence) throw new NotFoundException('Запись об отсутствии не найдена');
    if (absence.student.user_id !== userId) throw new ForbiddenException();
    return absence;
  }

    /** Зарегистрировать отсутствие студента.
   *  После сохранения автоматически переназначает все pending-события
   *  студента, попадающие в диапазон отсутствия.
   */
  async create(userId: number, dto: CreateAbsenceDto): Promise<Absence> {
    await this.assertStudentOwner(userId, dto.student_id);
    const absence = this.repo.create({
      student_id: dto.student_id,
      date_from: dto.date_from as unknown as Date,
      date_to: dto.date_to as unknown as Date,
      reason: dto.reason ?? null,
      is_approved: dto.is_approved ?? false,
    });
    const saved = await this.repo.save(absence);
    await this.dutyEventsService.handleAbsenceUpsert(saved);
    return saved;
  }

  /** Список отсутствий студентов пользователя */
  async findAll(userId: number, studentId?: number): Promise<Absence[]> {
    const qb = this.repo
      .createQueryBuilder('a')
      .innerJoin('a.student', 's', 's.user_id = :userId', { userId })
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
    Object.assign(absence, {
      date_from: dto.date_from ?? absence.date_from,
      date_to: dto.date_to ?? absence.date_to,
      reason: dto.reason !== undefined ? dto.reason : absence.reason,
      is_approved: dto.is_approved !== undefined ? dto.is_approved : absence.is_approved,
    });
    const saved = await this.repo.save(absence);
    await this.dutyEventsService.handleAbsenceUpsert(saved);
    return saved;
  }

  async remove(userId: number, id: number): Promise<void> {
    await this.assertOwner(userId, id);
    await this.repo.delete(id);
  }
}