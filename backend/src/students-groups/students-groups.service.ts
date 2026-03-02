import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateStudentsGroupDto } from './dto/create-students-group.dto';
import { UpdateStudentsGroupDto } from './dto/update-students-group.dto';
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

  async findOne(id: number): Promise<StudentsGroup> {
    const studentsGroup = await this.studentsGroupsRepository.findOne(id);
    if (!studentsGroup) {
      throw new NotFoundException();
    }
    return studentsGroup;
  }

  async update(id: number, updateStudentsGroupDto: UpdateStudentsGroupDto): Promise<StudentsGroup> {
    await this.studentsGroupsRepository.update(id, updateStudentsGroupDto);
    return this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    await this.studentsGroupsRepository.delete(id);
  }
}