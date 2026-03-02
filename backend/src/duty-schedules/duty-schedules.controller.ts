import { Controller, Get, Post, Put, Delete, Body, Param, Query } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiParam } from '@nestjs/swagger';
import { DutySchedulesService } from './duty-schedules.service';
import { CreateDutyScheduleDto, UpdateDutyScheduleDto } from './dto/duty-schedule.dto';

@ApiTags('duty-schedules')
@Controller('duty-schedules')
export class DutySchedulesController {
  constructor(private readonly dutySchedulesService: DutySchedulesService) {}

  @ApiOperation({ summary: 'Создать расписание дежурств' })
  @ApiResponse({ status: 201, description: 'Расписание создано' })
  @Post()
  async create(@Body() createDutyScheduleDto: CreateDutyScheduleDto) {
    return this.dutySchedulesService.create(createDutyScheduleDto);
  }

  @ApiOperation({ summary: 'Получить список расписаний' })
  @ApiResponse({ status: 200, description: 'Список расписаний' })
  @Get()
  async findAll(@Query() query: any) {
    return this.dutySchedulesService.findAll(query);
  }

  @ApiOperation({ summary: 'Получить расписание по ID' })
  @ApiParam({ name: 'id', description: 'ID расписания' })
  @ApiResponse({ status: 200, description: 'Расписание найдено' })
  @ApiResponse({ status: 404, description: 'Расписание не найдено' })
  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.dutySchedulesService.findOne(+id);
  }

  @ApiOperation({ summary: 'Обновить расписание' })
  @ApiParam({ name: 'id', description: 'ID расписания' })
  @ApiResponse({ status: 200, description: 'Расписание обновлено' })
  @ApiResponse({ status: 404, description: 'Расписание не найдено' })
  @Put(':id')
  async update(@Param('id') id: string, @Body() updateDutyScheduleDto: UpdateDutyScheduleDto) {
    return this.dutySchedulesService.update(+id, updateDutyScheduleDto);
  }

  @ApiOperation({ summary: 'Удалить расписание' })
  @ApiParam({ name: 'id', description: 'ID расписания' })
  @ApiResponse({ status: 200, description: 'Расписание удалено' })
  @ApiResponse({ status: 404, description: 'Расписание не найдено' })
  @Delete(':id')
  async remove(@Param('id') id: string) {
    return this.dutySchedulesService.remove(+id);
  }
}