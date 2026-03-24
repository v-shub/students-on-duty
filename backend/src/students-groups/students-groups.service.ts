import { Injectable, NotFoundException, ForbiddenException, ConflictException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { StudentsGroup } from './entities/students-group.entity';
import { Group } from '../groups/entities/group.entity';
import { Student } from '../students/entities/student.entity';

@Injectable()
export class StudentsGroupsService {
  constructor(
    @InjectRepository(StudentsGroup)
    private readonly repo: Repository<StudentsGroup>,
    @InjectRepository(Group)
    private readonly groupRepo: Repository<Group>,
    @InjectRepository(Student)
    private readonly studentRepo: Repository<Student>,
  ) {}

    /**
   * Проверяет, что группа принадлежит пользователю и студент существует.
   * Студент не имеет прямого владельца — принадлежность определяется через группы.
   */
  private async assertOwnership(userId: number, groupId: number, studentId: number): Promise<void> {
    const group = await this.groupRepo.findOne({ where: { id: groupId } });
    if (!group) throw new NotFoundException('Группа не найдена');
    if (group.user_id !== userId) throw new ForbiddenException();

    const student = await this.studentRepo.findOne({ where: { id: studentId } });
    if (!student) throw new NotFoundException('Студент не найден');
  }

    /** Добавить студента в группу */
  async addStudent(userId: number, groupId: number, studentId: number): Promise<StudentsGroup> {
    await this.assertOwnership(userId, groupId, studentId);
    // createQueryBuilder вместо findOne — не открывает лишних соединений из пула
    const exists = await this.repo
      .createQueryBuilder('sg')
      .where('sg.group_id = :groupId', { groupId })
      .andWhere('sg.student_id = :studentId', { studentId })
      .getOne();
    if (exists) throw new ConflictException('Студент уже в группе');
    // insert() вместо save() — не делает лишний SELECT
    await this.repo
      .createQueryBuilder()
      .insert()
      .into(StudentsGroup)
      .values({ group_id: groupId, student_id: studentId })
      .execute();
    // Один финальный SELECT вместо findOneOrFail
    const result = await this.repo
      .createQueryBuilder('sg')
      .where('sg.group_id = :groupId', { groupId })
      .andWhere('sg.student_id = :studentId', { studentId })
      .getOne();
    if (!result) throw new NotFoundException('Связь не найдена после создания');
    return result;
  }

    /** Список студентов группы */
  async findStudents(userId: number, groupId: number): Promise<StudentsGroup[]> {
    // createQueryBuilder вместо findOne+find+relations — один запрос без лишних соединений
    const group = await this.groupRepo
      .createQueryBuilder('g')
      .where('g.id = :groupId', { groupId })
      .getOne();
    if (!group) throw new NotFoundException('Группа не найдена');
    if (group.user_id !== userId) throw new ForbiddenException();
    return this.repo
      .createQueryBuilder('sg')
      .leftJoinAndSelect('sg.student', 'st')
      .where('sg.group_id = :groupId', { groupId })
      .getMany();
  }

  /** Удалить студента из группы */
  async removeStudent(userId: number, groupId: number, studentId: number): Promise<void> {
    await this.assertOwnership(userId, groupId, studentId);
    const link = await this.repo.findOne({ where: { group_id: groupId, student_id: studentId } });
    if (!link) throw new NotFoundException('Студент не состоит в этой группе');
    await this.repo.delete({ group_id: groupId, student_id: studentId });
  }
}