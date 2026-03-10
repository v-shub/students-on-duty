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
    const dutyDay = this.dutyDaysRepository.create(createDutyDayDto);
    return this.dutyDaysRepository.save(dutyDay);
  }

  async findAll(userId: number, query: FindDutyDaysDto): Promise<DutyDay[]> {
    // Строим запрос с проверкой принадлежности пользователю
    const qb = this.dutyDaysRepository
      .createQueryBuilder('duty_day')
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
    const dutyDay = await this.dutyDaysRepository.findOne({ 
      where: { schedule_id: scheduleId } 
    });
    
    if (!dutyDay) {
      throw new NotFoundException(`Дни дежурства для расписания ${scheduleId} не найдены`);
    }
    
    return dutyDay;
  }

  async update(scheduleId: number, updateDutyDayDto: UpdateDutyDayDto): Promise<DutyDay> {
    await this.dutyDaysRepository.update(
      { schedule_id: scheduleId }, 
      updateDutyDayDto
    );
    
    return this.findOne(scheduleId);
  }

  async remove(scheduleId: number): Promise<void> {
    const result = await this.dutyDaysRepository.delete({ schedule_id: scheduleId });
    
    if (result.affected === 0) {
      throw new NotFoundException(`Дни дежурства для расписания ${scheduleId} не найдены`);
    }
  }
}