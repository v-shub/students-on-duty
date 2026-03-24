import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateGroupDto, UpdateGroupDto } from './dto/group.dto';
import { Group } from './entities/group.entity';

@Injectable()
export class GroupsService {
  constructor(
    @InjectRepository(Group)
    private readonly repo: Repository<Group>,
  ) {}

    /** Создать группу для текущего пользователя */
    async create(userId: number, dto: CreateGroupDto): Promise<Group> {
    const result = await this.repo.insert({ ...dto, user_id: userId });
    const id = result.identifiers[0].id;
    // createQueryBuilder вместо findOneOrFail — не открывает лишних соединений из пула
    const created = await this.repo
      .createQueryBuilder('g')
      .where('g.id = :id', { id })
      .getOne();
    if (!created) throw new NotFoundException('Группа не найдена после создания');
    return created;
  }

  /** Получить все группы текущего пользователя */
  async findAll(userId: number): Promise<Group[]> {
    return this.repo.find({ where: { user_id: userId } });
  }

  /** Получить одну группу (только своя) */
  async findOne(userId: number, id: number): Promise<Group> {
    const group = await this.repo.findOne({ where: { id } });
    if (!group) throw new NotFoundException('Группа не найдена');
    if (group.user_id !== userId) throw new ForbiddenException();
    return group;
  }

        async update(userId: number, id: number, dto: UpdateGroupDto): Promise<Group> {
    await this.findOne(userId, id);
    await this.repo.update(id, dto);
    // createQueryBuilder вместо findOneOrFail — не открывает лишних соединений из пула
    const updated = await this.repo
      .createQueryBuilder('g')
      .where('g.id = :id', { id })
      .getOne();
    if (!updated) throw new NotFoundException('Группа не найдена после обновления');
    return updated;
  }

  async remove(userId: number, id: number): Promise<void> {
    await this.findOne(userId, id);
    await this.repo.delete(id);
  }
}