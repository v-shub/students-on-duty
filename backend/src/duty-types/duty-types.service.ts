import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateDutyTypeDto, UpdateDutyTypeDto } from './dto/duty-type.dto';
import { DutyType } from './entities/duty-type.entity';

@Injectable()
export class DutyTypesService {
  constructor(
    @InjectRepository(DutyType)
    private readonly repo: Repository<DutyType>,
  ) {}

    /** Создать тип дежурства */
    async create(dto: CreateDutyTypeDto): Promise<DutyType> {
    const result = await this.repo.insert(dto);
    const id = result.identifiers[0].id;
    // createQueryBuilder вместо findOneOrFail — не открывает лишних соединений из пула
    const created = await this.repo
      .createQueryBuilder('dt')
      .where('dt.id = :id', { id })
      .getOne();
    if (!created) throw new NotFoundException('Тип дежурства не найден после создания');
    return created;
  }

  /** Список всех типов дежурств */
  async findAll(): Promise<DutyType[]> {
    return this.repo.find();
  }

  /** Получить тип дежурства по ID */
  async findOne(id: number): Promise<DutyType> {
    const dt = await this.repo.findOne({ where: { id } });
    if (!dt) throw new NotFoundException('Тип дежурства не найден');
    return dt;
  }

    /** Обновить тип дежурства */
    async update(id: number, dto: UpdateDutyTypeDto): Promise<DutyType> {
    await this.findOne(id);
    await this.repo.update(id, dto);
    // createQueryBuilder вместо findOneOrFail — не открывает лишних соединений из пула
    const updated = await this.repo
      .createQueryBuilder('dt')
      .where('dt.id = :id', { id })
      .getOne();
    if (!updated) throw new NotFoundException('Тип дежурства не найден после обновления');
    return updated;
  }

  /** Удалить тип дежурства */
  async remove(id: number): Promise<void> {
    await this.findOne(id);
    await this.repo.delete(id);
  }
}