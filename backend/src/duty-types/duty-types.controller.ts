import { Controller, Get, Post, Put, Delete, Body, Param, UseGuards, ParseIntPipe, HttpCode } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiParam, ApiHeader } from '@nestjs/swagger';
import { DutyTypesService } from './duty-types.service';
import { CreateDutyTypeDto, UpdateDutyTypeDto } from './dto/duty-type.dto';
import { AuthGuard } from '../common/guards/auth.guard';
import { CurrentUser } from '../common/decorators/current-user.decorator';

@ApiTags('duty-types')
@ApiHeader({ name: 'X-User-Id', description: 'ID текущего пользователя', required: true })
@UseGuards(AuthGuard)
@Controller('duty-types')
export class DutyTypesController {
  constructor(private readonly dutyTypesService: DutyTypesService) {}

  @ApiOperation({ summary: 'Создать пользовательский тип дежурства' })
  @ApiResponse({ status: 201, description: 'Тип дежурства создан' })
  @Post()
  create(@CurrentUser() userId: number, @Body() dto: CreateDutyTypeDto) {
    return this.dutyTypesService.create(userId, dto);
  }

  @ApiOperation({ summary: 'Список типов дежурств (системные + свои)' })
  @ApiResponse({ status: 200, description: 'Список типов дежурств' })
  @Get()
  findAll(@CurrentUser() userId: number) {
    return this.dutyTypesService.findAll(userId);
  }

  @ApiOperation({ summary: 'Получить тип дежурства по ID' })
  @ApiParam({ name: 'id', description: 'ID типа дежурства' })
  @ApiResponse({ status: 200, description: 'Тип дежурства найден' })
  @ApiResponse({ status: 404, description: 'Тип дежурства не найден' })
  @Get(':id')
  findOne(@CurrentUser() userId: number, @Param('id', ParseIntPipe) id: number) {
    return this.dutyTypesService.findOne(userId, id);
  }

  @ApiOperation({ summary: 'Обновить свой тип дежурства' })
  @ApiParam({ name: 'id', description: 'ID типа дежурства' })
  @ApiResponse({ status: 200, description: 'Тип дежурства обновлён' })
  @ApiResponse({ status: 403, description: 'Системные типы нельзя изменять' })
  @Put(':id')
  update(@CurrentUser() userId: number, @Param('id', ParseIntPipe) id: number, @Body() dto: UpdateDutyTypeDto) {
    return this.dutyTypesService.update(userId, id, dto);
  }

  @ApiOperation({ summary: 'Удалить свой тип дежурства' })
  @ApiParam({ name: 'id', description: 'ID типа дежурства' })
  @ApiResponse({ status: 204, description: 'Тип дежурства удалён' })
  @ApiResponse({ status: 403, description: 'Системные типы нельзя удалять' })
  @Delete(':id')
  @HttpCode(204)
  remove(@CurrentUser() userId: number, @Param('id', ParseIntPipe) id: number) {
    return this.dutyTypesService.remove(userId, id);
  }
}