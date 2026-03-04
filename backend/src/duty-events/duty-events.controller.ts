import {
  Controller, Get, Post, Put, Delete,
  Body, Param, Query, UseGuards, ParseIntPipe, HttpCode,
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiParam, ApiBearerAuth, ApiQuery } from '@nestjs/swagger';
import { DutyEventsService } from './duty-events.service';
import { GenerateDutyEventDto, UpdateDutyEventDto } from './dto/duty-event.dto';
import { AuthGuard } from '../common/guards/auth.guard';
import { CurrentUser } from '../common/decorators/current-user.decorator';

@ApiTags('duty-events')
@ApiBearerAuth('bearer')
@UseGuards(AuthGuard)
@Controller('duty-events')
export class DutyEventsController {
  constructor(private readonly dutyEventsService: DutyEventsService) {}

  @ApiOperation({
    summary: 'Ручная генерация событий',
    description: 'Создаёт события дежурства на указанную дату для расписания. Студенты выбираются автоматически по минимальному duty_score с учётом отсутствий.',
  })
  @ApiResponse({ status: 201, description: 'События созданы' })
  @ApiResponse({ status: 400, description: 'Нет доступных студентов или расписание неактивно' })
  @Post('generate')
  generate(@CurrentUser() userId: number, @Body() dto: GenerateDutyEventDto) {
    return this.dutyEventsService.generateManual(userId, dto.schedule_id, dto.date);
  }

  @ApiOperation({ summary: 'Список событий дежурств' })
  @ApiQuery({ name: 'schedule_id', required: false, description: 'Фильтр по расписанию' })
  @ApiResponse({ status: 200, description: 'Список событий' })
  @Get()
  findAll(
    @CurrentUser() userId: number,
    @Query('schedule_id') scheduleId?: string,
  ) {
    return this.dutyEventsService.findAll(userId, scheduleId ? +scheduleId : undefined);
  }

  @ApiOperation({ summary: 'Получить событие по ID' })
  @ApiParam({ name: 'id', description: 'ID события' })
  @ApiResponse({ status: 200, description: 'Событие найдено' })
  @ApiResponse({ status: 404, description: 'Событие не найдено' })
  @Get(':id')
  findOne(@CurrentUser() userId: number, @Param('id', ParseIntPipe) id: number) {
    return this.dutyEventsService.findOne(userId, id);
  }

  @ApiOperation({
    summary: 'Обновить статус события',
    description: 'completed → +score, missed → -score, missed_approved → без изменений score',
  })
  @ApiParam({ name: 'id', description: 'ID события' })
  @ApiResponse({ status: 200, description: 'Статус обновлён, score пересчитан' })
  @Put(':id/status')
  updateStatus(
    @CurrentUser() userId: number,
    @Param('id', ParseIntPipe) id: number,
    @Body() dto: UpdateDutyEventDto,
  ) {
    return this.dutyEventsService.updateStatus(userId, id, dto);
  }
}