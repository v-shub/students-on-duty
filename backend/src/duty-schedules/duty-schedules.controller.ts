import { Controller, Get, Post, Put, Delete, Body, Param, UseGuards, ParseIntPipe, HttpCode } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiParam, ApiHeader } from '@nestjs/swagger';
import { DutySchedulesService } from './duty-schedules.service';
import { CreateDutyScheduleDto, UpdateDutyScheduleDto } from './dto/duty-schedule.dto';
import { AuthGuard } from '../common/guards/auth.guard';
import { CurrentUser } from '../common/decorators/current-user.decorator';

@ApiTags('duty-schedules')
@ApiHeader({ name: 'X-User-Id', description: 'ID текущего пользователя', required: true })
@UseGuards(AuthGuard)
@Controller('duty-schedules')
export class DutySchedulesController {
  constructor(private readonly dutySchedulesService: DutySchedulesService) {}

  @ApiOperation({ summary: 'Создать расписание дежурств (с днями недели)' })
  @ApiResponse({ status: 201, description: 'Расписание создано' })
  @Post()
  create(@CurrentUser() userId: number, @Body() dto: CreateDutyScheduleDto) {
    return this.dutySchedulesService.create(userId, dto);
  }

  @ApiOperation({ summary: 'Список своих расписаний' })
  @ApiResponse({ status: 200, description: 'Список расписаний' })
  @Get()
  findAll(@CurrentUser() userId: number) {
    return this.dutySchedulesService.findAll(userId);
  }

  @ApiOperation({ summary: 'Получить расписание по ID' })
  @ApiParam({ name: 'id', description: 'ID расписания' })
  @ApiResponse({ status: 200, description: 'Расписание найдено' })
  @ApiResponse({ status: 404, description: 'Расписание не найдено' })
  @Get(':id')
  findOne(@CurrentUser() userId: number, @Param('id', ParseIntPipe) id: number) {
    return this.dutySchedulesService.findOne(userId, id);
  }

  @ApiOperation({ summary: 'Обновить расписание' })
  @ApiParam({ name: 'id', description: 'ID расписания' })
  @ApiResponse({ status: 200, description: 'Расписание обновлено' })
  @Put(':id')
  update(@CurrentUser() userId: number, @Param('id', ParseIntPipe) id: number, @Body() dto: UpdateDutyScheduleDto) {
    return this.dutySchedulesService.update(userId, id, dto);
  }

  @ApiOperation({ summary: 'Удалить расписание' })
  @ApiParam({ name: 'id', description: 'ID расписания' })
  @ApiResponse({ status: 204, description: 'Расписание удалено' })
  @Delete(':id')
  @HttpCode(204)
  remove(@CurrentUser() userId: number, @Param('id', ParseIntPipe) id: number) {
    return this.dutySchedulesService.remove(userId, id);
  }
}