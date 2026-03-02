import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { FindOptionsWhere, IsNull, Or } from 'typeorm';
import { Repository } from 'typeorm';
import { CreateDutyTypeDto, UpdateDutyTypeDto } from './dto/duty-type.dto';
import { DutyType } from './entities/duty-type.entity';

@Injectable()
export class DutyTypesService {
  constructor(
    @InjectRepository(DutyType)
    private readonly repo: Repository<DutyType>,
  ) {}

  /** Создать пользовательский тип дежурства */
  async create(userId: number, dto: CreateDutyTypeDto): Promise<DutyType> {
    const dutyType = this.repo.create({ ...dto, user_id: userId });
    return this.repo.save(dutyType);
  }

  /**
   * Список типов дежурств:
   * — системные (user_id = null) доступны всем
   * — пользовательские (user_id = userId) только владельцу
   */
  async findAll(userId: number): Promise<DutyType[]> {
    return this.repo.find({
      where: [
        { user_id: userId },
        { user_id: IsNull() },
      ] as FindOptionsWhere<DutyType>[],
    });
  }

  /** Получить один тип — системный или свой */
  async findOne(userId: number, id: number): Promise<DutyType> {
    const dt = await this.repo.findOne({ where: { id } });
    if (!dt) throw new NotFoundException('Тип дежурства не найден');
    if (dt.user_id !== null && dt.user_id !== userId) throw new ForbiddenException();
    return dt;
  }

  /** Обновить только свой тип (не системный) */
  async update(userId: number, id: number, dto: UpdateDutyTypeDto): Promise<DutyType> {
    const dt = await this.repo.findOne({ where: { id } });
    if (!dt) throw new NotFoundException('Тип дежурства не найден');
    if (dt.user_id === null) throw new ForbiddenException('Системные типы нельзя изменять');
    if (dt.user_id !== userId) throw new ForbiddenException();
    Object.assign(dt, dto);
    return this.repo.save(dt);
  }

  /** Удалить только свой тип (не системный) */
  async remove(userId: number, id: number): Promise<void> {
    const dt = await this.repo.findOne({ where: { id } });
    if (!dt) throw new NotFoundException('Тип дежурства не найден');
    if (dt.user_id === null) throw new ForbiddenException('Системные типы нельзя удалять');
    if (dt.user_id !== userId) throw new ForbiddenException();
    await this.repo.delete(id);
  }
}