import { Controller, Get, Post, Put, Delete, Body, Param, Query } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiParam } from '@nestjs/swagger';
import { AbsencesService } from './absences.service';
import { CreateAbsenceDto, UpdateAbsenceDto } from './dto/absence.dto';

@ApiTags('absences')
@Controller('absences')
export class AbsencesController {
  constructor(private readonly absencesService: AbsencesService) {}

  @ApiOperation({ summary: 'Зарегистрировать отсутствие студента' })
  @ApiResponse({ status: 201, description: 'Отсутствие зарегистрировано' })
  @Post()
  async create(@Body() createAbsenceDto: CreateAbsenceDto) {
    return this.absencesService.create(createAbsenceDto);
  }

  @ApiOperation({ summary: 'Получить список отсутствий' })
  @ApiResponse({ status: 200, description: 'Список отсутствий' })
  @Get()
  async findAll(@Query() query: any) {
    return this.absencesService.findAll(query);
  }

  @ApiOperation({ summary: 'Получить отсутствие по ID' })
  @ApiParam({ name: 'id', description: 'ID записи об отсутствии' })
  @ApiResponse({ status: 200, description: 'Отсутствие найдено' })
  @ApiResponse({ status: 404, description: 'Отсутствие не найдено' })
  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.absencesService.findOne(+id);
  }

  @ApiOperation({ summary: 'Обновить запись об отсутствии' })
  @ApiParam({ name: 'id', description: 'ID записи об отсутствии' })
  @ApiResponse({ status: 200, description: 'Отсутствие обновлено' })
  @ApiResponse({ status: 404, description: 'Отсутствие не найдено' })
  @Put(':id')
  async update(@Param('id') id: string, @Body() updateAbsenceDto: UpdateAbsenceDto) {
    return this.absencesService.update(+id, updateAbsenceDto);
  }

  @ApiOperation({ summary: 'Удалить запись об отсутствии' })
  @ApiParam({ name: 'id', description: 'ID записи об отсутствии' })
  @ApiResponse({ status: 200, description: 'Отсутствие удалено' })
  @ApiResponse({ status: 404, description: 'Отсутствие не найдено' })
  @Delete(':id')
  async remove(@Param('id') id: string) {
    return this.absencesService.remove(+id);
  }
}