import { Controller, Get, Post, Put, Delete, Body, Param, Query } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiParam } from '@nestjs/swagger';
import { DutyDaysService } from './duty-days.service';
import { CreateDutyDayDto, UpdateDutyDayDto } from './dto/duty-day.dto';

@ApiTags('duty-days')
@Controller('duty-days')
export class DutyDaysController {
  constructor(private readonly dutyDaysService: DutyDaysService) {}

  @ApiOperation({ summary: 'Создать дни дежурства для расписания' })
  @ApiResponse({ status: 201, description: 'Дни дежурства созданы' })
  @Post()
  async create(@Body() createDutyDayDto: CreateDutyDayDto) {
    return this.dutyDaysService.create(createDutyDayDto);
  }

  @ApiOperation({ summary: 'Получить список дней дежурств' })
  @ApiResponse({ status: 200, description: 'Список дней дежурств' })
  @Get()
  async findAll(@Query() query: any) {
    return this.dutyDaysService.findAll(query);
  }

  @ApiOperation({ summary: 'Получить дни дежурства по ID расписания' })
  @ApiParam({ name: 'id', description: 'ID расписания (schedule_id)' })
  @ApiResponse({ status: 200, description: 'Дни дежурства найдены' })
  @ApiResponse({ status: 404, description: 'Дни дежурства не найдены' })
  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.dutyDaysService.findOne(+id);
  }

  @ApiOperation({ summary: 'Обновить дни дежурства по ID расписания' })
  @ApiParam({ name: 'id', description: 'ID расписания (schedule_id)' })
  @ApiResponse({ status: 200, description: 'Дни дежурства обновлены' })
  @ApiResponse({ status: 404, description: 'Дни дежурства не найдены' })
  @Put(':id')
  async update(@Param('id') id: string, @Body() updateDutyDayDto: UpdateDutyDayDto) {
    return this.dutyDaysService.update(+id, updateDutyDayDto);
  }

  @ApiOperation({ summary: 'Удалить дни дежурства по ID расписания' })
  @ApiParam({ name: 'id', description: 'ID расписания (schedule_id)' })
  @ApiResponse({ status: 200, description: 'Дни дежурства удалены' })
  @ApiResponse({ status: 404, description: 'Дни дежурства не найдены' })
  @Delete(':id')
  async remove(@Param('id') id: string) {
    return this.dutyDaysService.remove(+id);
  }
}