import { Controller, Get, Post, Put, Delete, Body, Param, Query } from '@nestjs/common';
import { AbsencesService } from './absences.service';
import { CreateAbsenceDto } from './dto/absence.dto';
import { UpdateAbsenceDto } from './dto/absence.dto';

@Controller('absences')
export class AbsencesController {
  constructor(private readonly absencesService: AbsencesService) {}

  @Post()
  async create(@Body() createAbsenceDto: CreateAbsenceDto) {
    return this.absencesService.create(createAbsenceDto);
  }

  @Get()
  async findAll(@Query() query: any) {
    return this.absencesService.findAll(query);
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.absencesService.findOne(+id);
  }

  @Put(':id')
  async update(@Param('id') id: string, @Body() updateAbsenceDto: UpdateAbsenceDto) {
    return this.absencesService.update(+id, updateAbsenceDto);
  }

  @Delete(':id')
  async remove(@Param('id') id: string) {
    return this.absencesService.remove(+id);
  }
}