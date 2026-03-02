import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateDutyEventDto } from './dto/duty-event.dto';
import { UpdateDutyEventDto } from './dto/duty-event.dto';
import { DutyEvent } from './entities/duty-event.entity';

@Injectable()
export class DutyEventsService {
  constructor(
    @InjectRepository(DutyEvent)
    private dutyEventsRepository: Repository<DutyEvent>,
  ) {}

  async create(createDutyEventDto: CreateDutyEventDto): Promise<DutyEvent> {
    const dutyEvent = this.dutyEventsRepository.create(createDutyEventDto);
    return this.dutyEventsRepository.save(dutyEvent);
  }

  async findAll(query: any): Promise<DutyEvent[]> {
    return this.dutyEventsRepository.find();
  }

  async findOne(id: number): Promise<DutyEvent> {
    const dutyEvent = await this.dutyEventsRepository.findOne({ where: { id } });
    if (!dutyEvent) {
      throw new NotFoundException();
    }
    return dutyEvent;
  }

  async update(id: number, updateDutyEventDto: UpdateDutyEventDto): Promise<DutyEvent> {
    await this.dutyEventsRepository.update(id, updateDutyEventDto);
    return this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    await this.dutyEventsRepository.delete(id);
  }
}