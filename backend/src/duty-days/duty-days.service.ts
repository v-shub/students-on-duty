import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateDutyDayDto } from './dto/duty-day.dto';
import { UpdateDutyDayDto } from './dto/duty-day.dto';
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

  async findAll(query: any): Promise<DutyDay[]> {
    return this.dutyDaysRepository.find();
  }

  async findOne(id: number): Promise<DutyDay> {
    const dutyDay = await this.dutyDaysRepository.findOne(id);
    if (!dutyDay) {
      throw new NotFoundException();
    }
    return dutyDay;
  }

  async update(id: number, updateDutyDayDto: UpdateDutyDayDto): Promise<DutyDay> {
    await this.dutyDaysRepository.update(id, updateDutyDayDto);
    return this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    await this.dutyDaysRepository.delete(id);
  }
}