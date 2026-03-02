import { Controller, Get, Post, Put, Delete, Body, Param, Query } from '@nestjs/common';
import { DutyDaysService } from './duty-days.service';
import { CreateDutyDayDto } from './dto/duty-day.dto';
import { UpdateDutyDayDto } from './dto/duty-day.dto';

@Controller('duty-days')
export class DutyDaysController {
  constructor(private readonly dutyDaysService: DutyDaysService) {}

  @Post()
  async create(@Body() createDutyDayDto: CreateDutyDayDto) {
    return this.dutyDaysService.create(createDutyDayDto);
  }

  @Get()
  async findAll(@Query() query: any) {
    return this.dutyDaysService.findAll(query);
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.dutyDaysService.findOne(+id);
  }

  @Put(':id')
  async update(@Param('id') id: string, @Body() updateDutyDayDto: UpdateDutyDayDto) {
    return this.dutyDaysService.update(+id, updateDutyDayDto);
  }

  @Delete(':id')
  async remove(@Param('id') id: string) {
    return this.dutyDaysService.remove(+id);
  }
}