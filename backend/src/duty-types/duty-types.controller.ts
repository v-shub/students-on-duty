import { Controller, Get, Post, Put, Delete, Body, Param, Query } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiParam } from '@nestjs/swagger';
import { DutyTypesService } from './duty-types.service';
import { CreateDutyTypeDto, UpdateDutyTypeDto } from './dto/duty-type.dto';

@ApiTags('duty-types')
@Controller('duty-types')
export class DutyTypesController {
  constructor(private readonly dutyTypesService: DutyTypesService) {}

  @ApiOperation({ summary: 'Создать тип дежурства' })
  @ApiResponse({ status: 201, description: 'Тип дежурства создан' })
  @Post()
  async create(@Body() createDutyTypeDto: CreateDutyTypeDto) {
    return this.dutyTypesService.create(createDutyTypeDto);
  }

  @ApiOperation({ summary: 'Получить список типов дежурств' })
  @ApiResponse({ status: 200, description: 'Список типов дежурств' })
  @Get()
  async findAll(@Query() query: any) {
    return this.dutyTypesService.findAll(query);
  }

  @ApiOperation({ summary: 'Получить тип дежурства по ID' })
  @ApiParam({ name: 'id', description: 'ID типа дежурства' })
  @ApiResponse({ status: 200, description: 'Тип дежурства найден' })
  @ApiResponse({ status: 404, description: 'Тип дежурства не найден' })
  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.dutyTypesService.findOne(+id);
  }

  @ApiOperation({ summary: 'Обновить тип дежурства' })
  @ApiParam({ name: 'id', description: 'ID типа дежурства' })
  @ApiResponse({ status: 200, description: 'Тип дежурства обновлен' })
  @ApiResponse({ status: 404, description: 'Тип дежурства не найден' })
  @Put(':id')
  async update(@Param('id') id: string, @Body() updateDutyTypeDto: UpdateDutyTypeDto) {
    return this.dutyTypesService.update(+id, updateDutyTypeDto);
  }

  @ApiOperation({ summary: 'Удалить тип дежурства' })
  @ApiParam({ name: 'id', description: 'ID типа дежурства' })
  @ApiResponse({ status: 200, description: 'Тип дежурства удален' })
  @ApiResponse({ status: 404, description: 'Тип дежурства не найден' })
  @Delete(':id')
  async remove(@Param('id') id: string) {
    return this.dutyTypesService.remove(+id);
  }
}