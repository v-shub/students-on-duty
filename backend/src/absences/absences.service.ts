import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateAbsenceDto } from './dto/absence.dto';
import { UpdateAbsenceDto } from './dto/absence.dto';
import { Absence } from './entities/absence.entity';

@Injectable()
export class AbsencesService {
  constructor(
    @InjectRepository(Absence)
    private absencesRepository: Repository<Absence>,
  ) {}

  async create(createAbsenceDto: CreateAbsenceDto): Promise<Absence> {
    const absence = this.absencesRepository.create(createAbsenceDto);
    return this.absencesRepository.save(absence);
  }

  async findAll(query: any): Promise<Absence[]> {
    return this.absencesRepository.find();
  }

  async findOne(id: number): Promise<Absence> {
    const absence = await this.absencesRepository.findOne(id);
    if (!absence) {
      throw new NotFoundException();
    }
    return absence;
  }

  async update(id: number, updateAbsenceDto: UpdateAbsenceDto): Promise<Absence> {
    await this.absencesRepository.update(id, updateAbsenceDto);
    return this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    await this.absencesRepository.delete(id);
  }
}