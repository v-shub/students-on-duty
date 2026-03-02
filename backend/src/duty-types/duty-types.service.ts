import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateDutyTypeDto } from './dto/duty-type.dto';
import { UpdateDutyTypeDto } from './dto/duty-type.dto';
import { DutyType } from './entities/duty-type.entity';

@Injectable()
export class DutyTypesService {
  constructor(
    @InjectRepository(DutyType)
    private dutyTypesRepository: Repository<DutyType>,
  ) {}

  async create(createDutyTypeDto: CreateDutyTypeDto): Promise<DutyType> {
    const dutyType = this.dutyTypesRepository.create(createDutyTypeDto);
    return this.dutyTypesRepository.save(dutyType);
  }

  async findAll(query: any): Promise<DutyType[]> {
    return this.dutyTypesRepository.find();
  }

  async findOne(id: number): Promise<DutyType> {
    const dutyType = await this.dutyTypesRepository.findOne({ where: { id } });
    if (!dutyType) {
      throw new NotFoundException();
    }
    return dutyType;
  }

  async update(id: number, updateDutyTypeDto: UpdateDutyTypeDto): Promise<DutyType> {
    await this.dutyTypesRepository.update(id, updateDutyTypeDto);
    return this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    await this.dutyTypesRepository.delete(id);
  }
}