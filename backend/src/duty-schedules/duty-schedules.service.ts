import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateDutyScheduleDto } from './dto/duty-schedule.dto';
import { UpdateDutyScheduleDto } from './dto/duty-schedule.dto';
import { DutySchedule } from './entities/duty-schedule.entity';

@Injectable()
export class DutySchedulesService {
  constructor(
    @InjectRepository(DutySchedule)
    private dutySchedulesRepository: Repository<DutySchedule>,
  ) {}

  async create(createDutyScheduleDto: CreateDutyScheduleDto): Promise<DutySchedule> {
    const dutySchedule = this.dutySchedulesRepository.create(createDutyScheduleDto);
    return this.dutySchedulesRepository.save(dutySchedule);
  }

  async findAll(query: any): Promise<DutySchedule[]> {
    return this.dutySchedulesRepository.find();
  }

  async findOne(id: number): Promise<DutySchedule> {
    const dutySchedule = await this.dutySchedulesRepository.findOne(id);
    if (!dutySchedule) {
      throw new NotFoundException();
    }
    return dutySchedule;
  }

  async update(id: number, updateDutyScheduleDto: UpdateDutyScheduleDto): Promise<DutySchedule> {
    await this.dutySchedulesRepository.update(id, updateDutyScheduleDto);
    return this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    await this.dutySchedulesRepository.delete(id);
  }
}