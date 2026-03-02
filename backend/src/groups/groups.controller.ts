import { Controller, Get, Post, Put, Delete, Body, Param, UseGuards, ParseIntPipe, HttpCode } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiParam, ApiHeader } from '@nestjs/swagger';
import { GroupsService } from './groups.service';
import { CreateGroupDto, UpdateGroupDto } from './dto/group.dto';
import { AuthGuard } from '../common/guards/auth.guard';
import { CurrentUser } from '../common/decorators/current-user.decorator';

@ApiTags('groups')
@ApiHeader({ name: 'X-User-Id', description: 'ID текущего пользователя', required: true })
@UseGuards(AuthGuard)
@Controller('groups')
export class GroupsController {
  constructor(private readonly groupsService: GroupsService) {}

  @ApiOperation({ summary: 'Создать группу' })
  @ApiResponse({ status: 201, description: 'Группа создана' })
  @Post()
  create(@CurrentUser() userId: number, @Body() dto: CreateGroupDto) {
    return this.groupsService.create(userId, dto);
  }

  @ApiOperation({ summary: 'Список своих групп' })
  @ApiResponse({ status: 200, description: 'Список групп' })
  @Get()
  findAll(@CurrentUser() userId: number) {
    return this.groupsService.findAll(userId);
  }

  @ApiOperation({ summary: 'Получить группу по ID' })
  @ApiParam({ name: 'id', description: 'ID группы' })
  @ApiResponse({ status: 200, description: 'Группа найдена' })
  @ApiResponse({ status: 404, description: 'Группа не найдена' })
  @Get(':id')
  findOne(@CurrentUser() userId: number, @Param('id', ParseIntPipe) id: number) {
    return this.groupsService.findOne(userId, id);
  }

  @ApiOperation({ summary: 'Обновить группу' })
  @ApiParam({ name: 'id', description: 'ID группы' })
  @ApiResponse({ status: 200, description: 'Группа обновлена' })
  @Put(':id')
  update(@CurrentUser() userId: number, @Param('id', ParseIntPipe) id: number, @Body() dto: UpdateGroupDto) {
    return this.groupsService.update(userId, id, dto);
  }

  @ApiOperation({ summary: 'Удалить группу' })
  @ApiParam({ name: 'id', description: 'ID группы' })
  @ApiResponse({ status: 204, description: 'Группа удалена' })
  @Delete(':id')
  @HttpCode(204)
  remove(@CurrentUser() userId: number, @Param('id', ParseIntPipe) id: number) {
    return this.groupsService.remove(userId, id);
  }
}