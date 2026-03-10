import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateStudentDto, UpdateStudentDto } from './dto/student.dto';
import { Student } from './entities/student.entity';

@Injectable()
export class StudentsService {
  constructor(
    @InjectRepository(Student)
    private readonly repo: Repository<Student>,
  ) {}

  /** Проверяет владельца студента */
  private async assertOwner(userId: number, id: number): Promise<Student> {
    const student = await this.repo.findOne({ where: { id } });
    if (!student) throw new NotFoundException('Студент не найден');
    if (student.user_id !== userId) throw new ForbiddenException();
    return student;
  }

  /** Создать студента (принадлежит текущему пользователю) */
  async create(userId: number, dto: CreateStudentDto): Promise<Student> {
    const student = this.repo.create({ ...dto, user_id: userId });
    return this.repo.save(student);
  }

  /** Все студенты текущего пользователя */
  async findAll(userId: number): Promise<Student[]> {
    return this.repo.find({ where: { user_id: userId } });
  }

  /** Один студент текущего пользователя */
  async findOne(userId: number, id: number): Promise<Student> {
    return this.assertOwner(userId, id);
  }

  async update(userId: number, id: number, dto: UpdateStudentDto): Promise<Student> {
    const student = await this.assertOwner(userId, id);
    Object.assign(student, dto);
    return this.repo.save(student);
  }

  async remove(userId: number, id: number): Promise<void> {
    await this.assertOwner(userId, id);
    await this.repo.delete(id);
  }
}