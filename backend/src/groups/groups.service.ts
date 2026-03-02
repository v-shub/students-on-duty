import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateGroupDto } from './dto/group.dto';
import { UpdateGroupDto } from './dto/group.dto';
import { Group } from './entities/group.entity';

@Injectable()
export class GroupsService {
  constructor(
    @InjectRepository(Group)
    private groupsRepository: Repository<Group>,
  ) {}

  async create(createGroupDto: CreateGroupDto): Promise<Group> {
    const group = this.groupsRepository.create(createGroupDto);
    return this.groupsRepository.save(group);
  }

  async findAll(query: any): Promise<Group[]> {
    return this.groupsRepository.find();
  }

  async findOne(id: number): Promise<Group> {
    const group = await this.groupsRepository.findOne({ where: { id } });
    if (!group) {
      throw new NotFoundException();
    }
    return group;
  }

  async update(id: number, updateGroupDto: UpdateGroupDto): Promise<Group> {
    await this.groupsRepository.update(id, updateGroupDto);
    return this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    await this.groupsRepository.delete(id);
  }
}