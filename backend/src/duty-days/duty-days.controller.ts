import { 
  Controller, Get, Post, Put, Delete, Body, Param, 
  Query, UseGuards, ParseIntPipe, HttpCode 
} from '@nestjs/common';
import { 
  ApiTags, ApiOperation, ApiResponse, ApiParam, 
  ApiBearerAuth, ApiQuery, ApiBody 
} from '@nestjs/swagger';
import { AuthGuard } from '../common/guards/auth.guard';
import { CurrentUser } from '../common/decorators/current-user.decorator';
import { DutyDaysService } from './duty-days.service';
import { DutySchedulesService } from '../duty-schedules/duty-schedules.service';
import { CreateDutyDayDto, UpdateDutyDayDto, FindDutyDaysDto } from './dto/duty-day.dto';

@ApiTags('duty-days')
@ApiBearerAuth('bearer')
@UseGuards(AuthGuard)
@Controller('duty-days')
export class DutyDaysController {
  constructor(
    private readonly dutyDaysService: DutyDaysService,
    private readonly dutySchedulesService: DutySchedulesService
  ) {}

  @Post()
  @ApiOperation({ 
    summary: 'Создать дни дежурства для расписания',
    description: 'Создает запись с днями недели для указанного расписания. Расписание должно принадлежать текущему пользователю.'
  })
  @ApiResponse({ status: 201, description: 'Дни дежурства созданы' })
  @ApiResponse({ status: 403, description: 'Доступ запрещен - расписание не принадлежит пользователю' })
  @ApiResponse({ status: 404, description: 'Расписание не найдено' })
  @ApiBody({ type: CreateDutyDayDto })
    async create(
    @CurrentUser() userId: number,
    @Body() createDutyDayDto: CreateDutyDayDto
  ) {
    // Проверяем доступ — сервис сам бросает NotFoundException / ForbiddenException
    await this.dutySchedulesService.findOne(userId, createDutyDayDto.schedule_id);
    return this.dutyDaysService.create(createDutyDayDto);
  }

  @Get()
  @ApiOperation({ 
    summary: 'Получить список дней дежурств',
    description: 'Возвращает все дни дежурств для расписаний, принадлежащих текущему пользователю. Поддерживает фильтрацию по параметрам.'
  })
  @ApiResponse({ status: 200, description: 'Список дней дежурств' })
  async findAll(
    @CurrentUser() userId: number,
    @Query() query: FindDutyDaysDto
  ) {
    // Передаем userId в сервис для фильтрации по принадлежности пользователю
    return this.dutyDaysService.findAll(userId, query);
  }

  @Get(':id')
  @ApiOperation({ 
    summary: 'Получить дни дежурства по ID расписания',
    description: 'Возвращает дни дежурства для конкретного расписания, если оно принадлежит текущему пользователю.'
  })
  @ApiParam({ name: 'id', description: 'ID расписания (schedule_id)', type: Number })
  @ApiResponse({ status: 200, description: 'Дни дежурства найдены' })
  @ApiResponse({ status: 403, description: 'Доступ запрещен - расписание не принадлежит пользователю' })
  @ApiResponse({ status: 404, description: 'Дни дежурства не найдены' })
  async findOne(
    @CurrentUser() userId: number,
    @Param('id', ParseIntPipe) id: number
  ) {
    // Проверяем, что расписание принадлежит пользователю
    await this.checkScheduleAccess(userId, id);
    
    return this.dutyDaysService.findOne(id);
  }

  @Put(':id')
  @ApiOperation({ 
    summary: 'Обновить дни дежурства по ID расписания',
    description: 'Обновляет дни недели для указанного расписания, если оно принадлежит текущему пользователю.'
  })
  @ApiParam({ name: 'id', description: 'ID расписания (schedule_id)', type: Number })
  @ApiResponse({ status: 200, description: 'Дни дежурства обновлены' })
  @ApiResponse({ status: 403, description: 'Доступ запрещен - расписание не принадлежит пользователю' })
  @ApiResponse({ status: 404, description: 'Дни дежурства не найдены' })
  @ApiBody({ type: UpdateDutyDayDto })
  async update(
    @CurrentUser() userId: number,
    @Param('id', ParseIntPipe) id: number,
    @Body() updateDutyDayDto: UpdateDutyDayDto
  ) {
    // Проверяем, что расписание принадлежит пользователю
    await this.checkScheduleAccess(userId, id);
    
    return this.dutyDaysService.update(id, updateDutyDayDto);
  }

  @Delete(':id')
  @HttpCode(204)
  @ApiOperation({ 
    summary: 'Удалить дни дежурства по ID расписания',
    description: 'Удаляет запись с днями дежурства для указанного расписания, если оно принадлежит текущему пользователю.'
  })
  @ApiParam({ name: 'id', description: 'ID расписания (schedule_id)', type: Number })
  @ApiResponse({ status: 204, description: 'Дни дежурства удалены' })
  @ApiResponse({ status: 403, description: 'Доступ запрещен - расписание не принадлежит пользователю' })
  @ApiResponse({ status: 404, description: 'Дни дежурства не найдены' })
  async remove(
    @CurrentUser() userId: number,
    @Param('id', ParseIntPipe) id: number
  ) {
    // Проверяем, что расписание принадлежит пользователю
    await this.checkScheduleAccess(userId, id);
    
    await this.dutyDaysService.remove(id);
  }

    /**
   * Вспомогательный метод для проверки доступа к расписанию.
   * DutySchedulesService.findOne сам бросает NotFoundException или ForbiddenException —
   * пробрасываем их без перехвата.
   */
  private async checkScheduleAccess(userId: number, scheduleId: number): Promise<void> {
    await this.dutySchedulesService.findOne(userId, scheduleId);
  }
}