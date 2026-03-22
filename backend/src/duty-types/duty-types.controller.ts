import { Controller, Get, Post, Put, Delete, Body, Param, UseGuards, ParseIntPipe, HttpCode } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiParam, ApiBearerAuth } from '@nestjs/swagger';
import { DutyTypesService } from './duty-types.service';
import { CreateDutyTypeDto, UpdateDutyTypeDto } from './dto/duty-type.dto';
import { AuthGuard } from '../common/guards/auth.guard';

@ApiTags('duty-types')
@ApiBearerAuth('bearer')
@UseGuards(AuthGuard)
@Controller('duty-types')
export class DutyTypesController {
  constructor(private readonly dutyTypesService: DutyTypesService) {}

    @ApiOperation({ summary: 'Создать тип дежурства' })
  @ApiResponse({ status: 201, description: 'Тип дежурства создан' })
  @Post()
  create(@Body() dto: CreateDutyTypeDto) {
    return this.dutyTypesService.create(dto);
  }

  @ApiOperation({ summary: 'Список всех типов дежурств' })
  @ApiResponse({ status: 200, description: 'Список типов дежурств' })
  @Get()
  findAll() {
    return this.dutyTypesService.findAll();
  }

  @ApiOperation({ summary: 'Получить тип дежурства по ID' })
  @ApiParam({ name: 'id', description: 'ID типа дежурства' })
  @ApiResponse({ status: 200, description: 'Тип дежурства найден' })
  @ApiResponse({ status: 404, description: 'Тип дежурства не найден' })
  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.dutyTypesService.findOne(id);
  }

  @ApiOperation({ summary: 'Обновить тип дежурства' })
  @ApiParam({ name: 'id', description: 'ID типа дежурства' })
  @ApiResponse({ status: 200, description: 'Тип дежурства обновлён' })
  @Put(':id')
  update(@Param('id', ParseIntPipe) id: number, @Body() dto: UpdateDutyTypeDto) {
    return this.dutyTypesService.update(id, dto);
  }

  @ApiOperation({ summary: 'Удалить тип дежурства' })
  @ApiParam({ name: 'id', description: 'ID типа дежурства' })
  @ApiResponse({ status: 204, description: 'Тип дежурства удалён' })
  @Delete(':id')
  @HttpCode(204)
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.dutyTypesService.remove(id);
  }
}