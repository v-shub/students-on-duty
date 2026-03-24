import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateStudentDto, UpdateStudentDto } from './dto/student.dto';
import { Student } from './entities/student.entity';
import { StudentsGroup } from '../students-groups/entities/students-group.entity';
import { Group } from '../groups/entities/group.entity';

@Injectable()
export class StudentsService {
    constructor(
    @InjectRepository(Student)
    private readonly repo: Repository<Student>,
    @InjectRepository(StudentsGroup)
    private readonly sgRepo: Repository<StudentsGroup>,
    @InjectRepository(Group)
    private readonly groupRepo: Repository<Group>,
  ) {}

  /**
   * Проверяет, что студент существует и принадлежит пользователю.
   * Принадлежность определяется через students_groups → group.user_id.
   * Студент считается «своим», если он состоит хотя бы в одной группе пользователя.
   */
    private async assertOwner(userId: number, id: number): Promise<Student> {
    // Один запрос вместо двух (findOne + createQueryBuilder) — не открывает лишних соединений
    const student = await this.repo
      .createQueryBuilder('s')
      .innerJoin('s.group_links', 'sg')
      .innerJoin('sg.group', 'g', 'g.user_id = :userId', { userId })
      .where('s.id = :id', { id })
      .getOne();
    if (!student) throw new NotFoundException('Студент не найден');
    // Проверка доступа: если студент найден через innerJoin по user_id — он наш
    const hasAccess = await this.sgRepo
      .createQueryBuilder('sg')
      .innerJoin('sg.group', 'g', 'g.user_id = :userId', { userId })
      .where('sg.student_id = :id', { id })
      .getCount();
    if (!hasAccess) throw new ForbiddenException();
    return student;
  }

        /** Создать студента и сразу добавить в указанную группу */
  async create(userId: number, dto: CreateStudentDto): Promise<Student> {
    const { group_id, ...studentData } = dto;

    // Проверяем, что группа существует и принадлежит пользователю
    const group = await this.groupRepo.findOne({ where: { id: group_id } });
    if (!group) throw new NotFoundException('Группа не найдена');
    if (group.user_id !== userId) throw new ForbiddenException('Нет доступа к этой группе');

            // insert() не делает лишний SELECT в отличие от save()
    const result = await this.repo
      .createQueryBuilder()
      .insert()
      .into(Student)
      .values({
        ...studentData,
        // Явно приводим boolean чтобы избежать передачи 0/1 вместо false/true
        is_active: Boolean(studentData.is_active ?? true),
      })
      .returning('*')
      .execute();
    const saved = result.generatedMaps[0] as Student;

    // Создаём связь студент ↔ группа (insert без предварительного SELECT)
    await this.sgRepo.insert({ group_id, student_id: saved.id });

    return saved;
  }

  /**
   * Все студенты пользователя — уникальные студенты из всех его групп.
   */
  async findAll(userId: number): Promise<Student[]> {
    return this.repo
      .createQueryBuilder('s')
      .innerJoin('s.group_links', 'sg')
      .innerJoin('sg.group', 'g', 'g.user_id = :userId', { userId })
      .distinct(true)
      .getMany();
  }

  /** Один студент пользователя */
  async findOne(userId: number, id: number): Promise<Student> {
    return this.assertOwner(userId, id);
  }

        async update(userId: number, id: number, dto: UpdateStudentDto): Promise<Student> {
    await this.assertOwner(userId, id);
    await this.repo.update(id, dto);
    // createQueryBuilder вместо findOneOrFail — не открывает лишних соединений из пула
    const updated = await this.repo
      .createQueryBuilder('s')
      .where('s.id = :id', { id })
      .getOne();
    if (!updated) throw new NotFoundException('Студент не найден после обновления');
    return updated;
  }

  async remove(userId: number, id: number): Promise<void> {
    await this.assertOwner(userId, id);
    await this.repo.delete(id);
  }
}