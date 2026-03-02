import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateStudentsGroupDto } from './dto/students-group.dto';
import { UpdateStudentsGroupDto } from './dto/students-group.dto';
import { StudentsGroup } from './entities/students-group.entity';

@Injectable()
export class StudentsGroupsService {
  constructor(
    @InjectRepository(StudentsGroup)
    private studentsGroupsRepository: Repository<StudentsGroup>,
  ) {}

  async create(createStudentsGroupDto: CreateStudentsGroupDto): Promise<StudentsGroup> {
    const studentsGroup = this.studentsGroupsRepository.create(createStudentsGroupDto);
    return this.studentsGroupsRepository.save(studentsGroup);
  }

  async findAll(query: any): Promise<StudentsGroup[]> {
    return this.studentsGroupsRepository.find();
  }

  async findOne(groupId: number, studentId: number): Promise<StudentsGroup> {
    const studentsGroup = await this.studentsGroupsRepository.findOne({
      where: { group_id: groupId, student_id: studentId },
    });
    if (!studentsGroup) {
      throw new NotFoundException();
    }
    return studentsGroup;
  }

  async update(
    groupId: number,
    studentId: number,
    updateStudentsGroupDto: UpdateStudentsGroupDto,
  ): Promise<StudentsGroup> {
    await this.studentsGroupsRepository.update(
      { group_id: groupId, student_id: studentId },
      updateStudentsGroupDto,
    );
    return this.findOne(groupId, studentId);
  }

  async remove(groupId: number, studentId: number): Promise<void> {
    await this.studentsGroupsRepository.delete({ group_id: groupId, student_id: studentId });
  }
}