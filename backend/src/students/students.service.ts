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
    const student = await this.repo.findOne({ where: { id } });
    if (!student) throw new NotFoundException('Студент не найден');
    const link = await this.sgRepo
      .createQueryBuilder('sg')
      .innerJoin('sg.group', 'g', 'g.user_id = :userId', { userId })
      .where('sg.student_id = :id', { id })
      .getOne();
    if (!link) throw new ForbiddenException();
    return student;
  }

        /** Создать студента и сразу добавить в указанную группу */
  async create(userId: number, dto: CreateStudentDto): Promise<Student> {
    const { group_id, ...studentData } = dto;

    // Проверяем, что группа существует и принадлежит пользователю
    const group = await this.groupRepo.findOne({ where: { id: group_id } });
    if (!group) throw new NotFoundException('Группа не найдена');
    if (group.user_id !== userId) throw new ForbiddenException('Нет доступа к этой группе');

        // Создаём студента
    const student = this.repo.create({
      ...studentData,
      is_active: studentData.is_active ?? true,
    });
    // Явно приводим boolean чтобы избежать передачи 0/1 вместо false/true
    student.is_active = Boolean(student.is_active);
    const saved = await this.repo.save(student);

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
    return this.repo.findOneOrFail({ where: { id } });
  }

  async remove(userId: number, id: number): Promise<void> {
    await this.assertOwner(userId, id);
    await this.repo.delete(id);
  }
}