import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateDutyDayDto, UpdateDutyDayDto, FindDutyDaysDto } from './dto/duty-day.dto';
import { DutyDay } from './entities/duty-day.entity';

@Injectable()
export class DutyDaysService {
  constructor(
    @InjectRepository(DutyDay)
    private dutyDaysRepository: Repository<DutyDay>,
  ) {}

    async create(createDutyDayDto: CreateDutyDayDto): Promise<DutyDay> {
    // insert() не делает лишний SELECT в отличие от save()
    const result = await this.dutyDaysRepository
      .createQueryBuilder()
      .insert()
      .into(DutyDay)
      .values(createDutyDayDto)
      .returning('*')
      .execute();
    return result.generatedMaps[0] as DutyDay;
  }

    async findAll(userId: number, query: FindDutyDaysDto): Promise<DutyDay[]> {
    // Строим запрос с проверкой принадлежности пользователю
    // select('duty_day') обязателен при использовании innerJoin без andSelect
    const qb = this.dutyDaysRepository
      .createQueryBuilder('duty_day')
      .select('duty_day')
      .innerJoin('duty_day.schedule', 'schedule')
      .innerJoin('schedule.group', 'group')
      .where('group.user_id = :userId', { userId });
    
    // Добавляем фильтры из DTO
    if (query.schedule_id) {
      qb.andWhere('duty_day.schedule_id = :scheduleId', { scheduleId: query.schedule_id });
    }
    
    if (query.is_monday !== undefined) {
      qb.andWhere('duty_day.is_monday = :isMonday', { isMonday: query.is_monday });
    }
    
    if (query.is_tuesday !== undefined) {
      qb.andWhere('duty_day.is_tuesday = :isTuesday', { isTuesday: query.is_tuesday });
    }
    
    if (query.is_wednesday !== undefined) {
      qb.andWhere('duty_day.is_wednesday = :isWednesday', { isWednesday: query.is_wednesday });
    }
    
    if (query.is_thursday !== undefined) {
      qb.andWhere('duty_day.is_thursday = :isThursday', { isThursday: query.is_thursday });
    }
    
    if (query.is_friday !== undefined) {
      qb.andWhere('duty_day.is_friday = :isFriday', { isFriday: query.is_friday });
    }
    
    if (query.is_saturday !== undefined) {
      qb.andWhere('duty_day.is_saturday = :isSaturday', { isSaturday: query.is_saturday });
    }
    
    if (query.is_sunday !== undefined) {
      qb.andWhere('duty_day.is_sunday = :isSunday', { isSunday: query.is_sunday });
    }
    
    return qb.getMany();
  }

    async findOne(scheduleId: number): Promise<DutyDay> {
    // createQueryBuilder вместо findOne — не открывает дополнительных соединений
    // из пула (избегаем Connection terminated на облачной БД)
    const dutyDay = await this.dutyDaysRepository
      .createQueryBuilder('dd')
      .where('dd.schedule_id = :scheduleId', { scheduleId })
      .getOne();

    if (!dutyDay) {
      throw new NotFoundException(`Дни дежурства для расписания ${scheduleId} не найдены`);
    }

    return dutyDay;
  }

      async update(scheduleId: number, updateDutyDayDto: UpdateDutyDayDto): Promise<DutyDay> {
    // Фильтруем undefined-поля вручную — update() их пропускает
    const fields = Object.fromEntries(
      Object.entries(updateDutyDayDto).filter(([, v]) => v !== undefined),
    );
    // update() без лишнего SELECT, в отличие от save()
    await this.dutyDaysRepository.update({ schedule_id: scheduleId }, fields);
    return this.findOne(scheduleId);
  }

  async remove(scheduleId: number): Promise<void> {
    const result = await this.dutyDaysRepository.delete({ schedule_id: scheduleId });
    
    if (result.affected === 0) {
      throw new NotFoundException(`Дни дежурства для расписания ${scheduleId} не найдены`);
    }
  }
}