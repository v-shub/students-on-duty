import { Injectable, NotFoundException, ForbiddenException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { IsNull, Repository } from 'typeorm';
import { CreateDutyScheduleDto, UpdateDutyScheduleDto } from './dto/duty-schedule.dto';
import { DutySchedule } from './entities/duty-schedule.entity';
import { DutyDay } from '../duty-days/entities/duty-day.entity';
import { Group } from '../groups/entities/group.entity';
import { DutyType } from '../duty-types/entities/duty-type.entity';

@Injectable()
export class DutySchedulesService {
  constructor(
    @InjectRepository(DutySchedule)
    private readonly repo: Repository<DutySchedule>,
    @InjectRepository(DutyDay)
    private readonly dutyDayRepo: Repository<DutyDay>,
    @InjectRepository(Group)
    private readonly groupRepo: Repository<Group>,
    @InjectRepository(DutyType)
    private readonly dutyTypeRepo: Repository<DutyType>,
  ) {}

  /** Проверить, что группа принадлежит пользователю */
  private async assertGroupOwner(userId: number, groupId: number): Promise<Group> {
    const group = await this.groupRepo.findOne({ where: { id: groupId } });
    if (!group) throw new NotFoundException('Группа не найдена');
    if (group.user_id !== userId) throw new ForbiddenException();
    return group;
  }

  /** Проверить, что тип дежурства доступен пользователю (системный или свой) */
  private async assertDutyTypeAccess(userId: number, dutyTypeId: number): Promise<void> {
    const dt = await this.dutyTypeRepo.findOne({ where: { id: dutyTypeId } });
    if (!dt) throw new NotFoundException('Тип дежурства не найден');
    if (dt.user_id !== null && dt.user_id !== userId) throw new ForbiddenException();
  }

  /** Получить расписание и проверить владельца */
  async findOneOwned(userId: number, id: number): Promise<DutySchedule> {
    const schedule = await this.repo.findOne({
      where: { id },
      relations: ['group', 'duty_type', 'duty_days'],
    });
    if (!schedule) throw new NotFoundException('Расписание не найдено');
    if (schedule.group.user_id !== userId) throw new ForbiddenException();
    return schedule;
  }

  async create(userId: number, dto: CreateDutyScheduleDto): Promise<DutySchedule> {
    await this.assertGroupOwner(userId, dto.group_id);
    await this.assertDutyTypeAccess(userId, dto.duty_type_id);

    const schedule = this.repo.create({
      group_id: dto.group_id,
      duty_type_id: dto.duty_type_id,
      students_per_day: dto.students_per_day,
      start_date: dto.start_date as unknown as Date,
      end_date: dto.end_date ? (dto.end_date as unknown as Date) : null,
      is_active: true,
      // DutyDay создаётся через cascade после сохранения расписания
      duty_days: this.dutyDayRepo.create({ ...dto.duty_days }),
    });

    return this.repo.save(schedule);
  }

  /** Все расписания пользователя (через его группы) */
  async findAll(userId: number): Promise<DutySchedule[]> {
    return this.repo
      .createQueryBuilder('s')
      .innerJoin('s.group', 'g', 'g.user_id = :userId', { userId })
      .leftJoinAndSelect('s.duty_days', 'dd')
      .leftJoinAndSelect('s.duty_type', 'dt')
      .leftJoinAndSelect('s.group', 'grp')
      .getMany();
  }

  async findOne(userId: number, id: number): Promise<DutySchedule> {
    return this.findOneOwned(userId, id);
  }

  async update(userId: number, id: number, dto: UpdateDutyScheduleDto): Promise<DutySchedule> {
    const schedule = await this.findOneOwned(userId, id);

    if (dto.duty_type_id) await this.assertDutyTypeAccess(userId, dto.duty_type_id);

    const { duty_days, ...rest } = dto;
    Object.assign(schedule, rest);

    if (duty_days && schedule.duty_days) {
      Object.assign(schedule.duty_days, duty_days);
    }

    return this.repo.save(schedule);
  }

  async remove(userId: number, id: number): Promise<void> {
    await this.findOneOwned(userId, id);
    await this.repo.delete(id);
  }
}