import { Controller, Get, Post, Put, Delete, Body, Param, Query } from '@nestjs/common';
import { DutySchedulesService } from './duty-schedules.service';
import { CreateDutyScheduleDto } from './dto/create-duty-schedule.dto';
import { UpdateDutyScheduleDto } from './dto/update-duty-schedule.dto';

@Controller('duty-schedules')
export class DutySchedulesController {
  constructor(private readonly dutySchedulesService: DutySchedulesService) {}

  @Post()
  async create(@Body() createDutyScheduleDto: CreateDutyScheduleDto) {
    return this.dutySchedulesService.create(createDutyScheduleDto);
  }

  @Get()
  async findAll(@Query() query: any) {
    return this.dutySchedulesService.findAll(query);
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.dutySchedulesService.findOne(+id);
  }

  @Put(':id')
  async update(@Param('id') id: string, @Body() updateDutyScheduleDto: UpdateDutyScheduleDto) {
    return this.dutySchedulesService.update(+id, updateDutyScheduleDto);
  }

  @Delete(':id')
  async remove(@Param('id') id: string) {
    return this.dutySchedulesService.remove(+id);
  }
}