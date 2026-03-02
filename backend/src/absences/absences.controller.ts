import { Controller, Get, Post, Put, Delete, Body, Param, Query, UseGuards, ParseIntPipe, HttpCode } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiParam, ApiBearerAuth, ApiQuery } from '@nestjs/swagger';
import { AbsencesService } from './absences.service';
import { CreateAbsenceDto, UpdateAbsenceDto } from './dto/absence.dto';
import { AuthGuard } from '../common/guards/auth.guard';
import { CurrentUser } from '../common/decorators/current-user.decorator';

@ApiTags('absences')
@ApiBearerAuth('bearer')
@UseGuards(AuthGuard)
@Controller('absences')
export class AbsencesController {
  constructor(private readonly absencesService: AbsencesService) {}

  @ApiOperation({ summary: 'Зарегистрировать отсутствие студента' })
  @ApiResponse({ status: 201, description: 'Отсутствие зарегистрировано' })
  @Post()
  create(@CurrentUser() userId: number, @Body() dto: CreateAbsenceDto) {
    return this.absencesService.create(userId, dto);
  }

  @ApiOperation({ summary: 'Список отсутствий своих студентов' })
  @ApiQuery({ name: 'student_id', required: false, description: 'Фильтр по студенту' })
  @ApiResponse({ status: 200, description: 'Список отсутствий' })
  @Get()
  findAll(
    @CurrentUser() userId: number,
    @Query('student_id') studentId?: string,
  ) {
    return this.absencesService.findAll(userId, studentId ? +studentId : undefined);
  }

  @ApiOperation({ summary: 'Получить отсутствие по ID' })
  @ApiParam({ name: 'id', description: 'ID записи об отсутствии' })
  @ApiResponse({ status: 200, description: 'Отсутствие найдено' })
  @ApiResponse({ status: 404, description: 'Отсутствие не найдено' })
  @Get(':id')
  findOne(@CurrentUser() userId: number, @Param('id', ParseIntPipe) id: number) {
    return this.absencesService.findOne(userId, id);
  }

  @ApiOperation({ summary: 'Обновить запись об отсутствии' })
  @ApiParam({ name: 'id', description: 'ID записи об отсутствии' })
  @ApiResponse({ status: 200, description: 'Отсутствие обновлено' })
  @Put(':id')
  update(
    @CurrentUser() userId: number,
    @Param('id', ParseIntPipe) id: number,
    @Body() dto: UpdateAbsenceDto,
  ) {
    return this.absencesService.update(userId, id, dto);
  }

  @ApiOperation({ summary: 'Удалить запись об отсутствии' })
  @ApiParam({ name: 'id', description: 'ID записи об отсутствии' })
  @ApiResponse({ status: 204, description: 'Отсутствие удалено' })
  @Delete(':id')
  @HttpCode(204)
  remove(@CurrentUser() userId: number, @Param('id', ParseIntPipe) id: number) {
    return this.absencesService.remove(userId, id);
  }
}