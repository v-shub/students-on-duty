import { Controller, Get, Post, Put, Delete, Body, Param, Query } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiParam } from '@nestjs/swagger';
import { DutyEventsService } from './duty-events.service';
import { CreateDutyEventDto, UpdateDutyEventDto } from './dto/duty-event.dto';

@ApiTags('duty-events')
@Controller('duty-events')
export class DutyEventsController {
  constructor(private readonly dutyEventsService: DutyEventsService) {}

  @ApiOperation({ summary: 'Создать событие дежурства' })
  @ApiResponse({ status: 201, description: 'Событие создано' })
  @Post()
  async create(@Body() createDutyEventDto: CreateDutyEventDto) {
    return this.dutyEventsService.create(createDutyEventDto);
  }

  @ApiOperation({ summary: 'Получить список событий дежурств' })
  @ApiResponse({ status: 200, description: 'Список событий' })
  @Get()
  async findAll(@Query() query: any) {
    return this.dutyEventsService.findAll(query);
  }

  @ApiOperation({ summary: 'Получить событие по ID' })
  @ApiParam({ name: 'id', description: 'ID события' })
  @ApiResponse({ status: 200, description: 'Событие найдено' })
  @ApiResponse({ status: 404, description: 'Событие не найдено' })
  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.dutyEventsService.findOne(+id);
  }

  @ApiOperation({ summary: 'Обновить событие дежурства' })
  @ApiParam({ name: 'id', description: 'ID события' })
  @ApiResponse({ status: 200, description: 'Событие обновлено' })
  @ApiResponse({ status: 404, description: 'Событие не найдено' })
  @Put(':id')
  async update(@Param('id') id: string, @Body() updateDutyEventDto: UpdateDutyEventDto) {
    return this.dutyEventsService.update(+id, updateDutyEventDto);
  }

  @ApiOperation({ summary: 'Удалить событие дежурства' })
  @ApiParam({ name: 'id', description: 'ID события' })
  @ApiResponse({ status: 200, description: 'Событие удалено' })
  @ApiResponse({ status: 404, description: 'Событие не найдено' })
  @Delete(':id')
  async remove(@Param('id') id: string) {
    return this.dutyEventsService.remove(+id);
  }
}