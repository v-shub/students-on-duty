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

  /** Проверяет, что группа и студент принадлежат одному пользователю */
  private async assertOwnership(userId: number, groupId: number, studentId: number): Promise<void> {
    const group = await this.groupRepo.findOne({ where: { id: groupId } });
    if (!group) throw new NotFoundException('Группа не найдена');
    if (group.user_id !== userId) throw new ForbiddenException();

    const student = await this.studentRepo.findOne({ where: { id: studentId } });
    if (!student) throw new NotFoundException('Студент не найден');
    if (student.user_id !== userId) throw new ForbiddenException();
  }

  /** Добавить студента в группу */
  async addStudent(userId: number, groupId: number, studentId: number): Promise<StudentsGroup> {
    await this.assertOwnership(userId, groupId, studentId);
    const exists = await this.repo.findOne({ where: { group_id: groupId, student_id: studentId } });
    if (exists) throw new ConflictException('Студент уже в группе');
    const link = this.repo.create({ group_id: groupId, student_id: studentId });
    return this.repo.save(link);
  }

  /** Список студентов группы */
  async findStudents(userId: number, groupId: number): Promise<StudentsGroup[]> {
    const group = await this.groupRepo.findOne({ where: { id: groupId } });
    if (!group) throw new NotFoundException('Группа не найдена');
    if (group.user_id !== userId) throw new ForbiddenException();
    return this.repo.find({ where: { group_id: groupId }, relations: ['student'] });
  }

  /** Удалить студента из группы */
  async removeStudent(userId: number, groupId: number, studentId: number): Promise<void> {
    await this.assertOwnership(userId, groupId, studentId);
    const link = await this.repo.findOne({ where: { group_id: groupId, student_id: studentId } });
    if (!link) throw new NotFoundException('Студент не состоит в этой группе');
    await this.repo.delete({ group_id: groupId, student_id: studentId });
  }
}