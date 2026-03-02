import { Controller, Get, Post, Put, Delete, Body, Param, Query } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiParam } from '@nestjs/swagger';
import { GroupsService } from './groups.service';
import { CreateGroupDto, UpdateGroupDto } from './dto/group.dto';

@ApiTags('groups')
@Controller('groups')
export class GroupsController {
  constructor(private readonly groupsService: GroupsService) {}

  @ApiOperation({ summary: 'Создать группу' })
  @ApiResponse({ status: 201, description: 'Группа создана' })
  @Post()
  async create(@Body() createGroupDto: CreateGroupDto) {
    return this.groupsService.create(createGroupDto);
  }

  @ApiOperation({ summary: 'Получить список групп' })
  @ApiResponse({ status: 200, description: 'Список групп' })
  @Get()
  async findAll(@Query() query: any) {
    return this.groupsService.findAll(query);
  }

  @ApiOperation({ summary: 'Получить группу по ID' })
  @ApiParam({ name: 'id', description: 'ID группы' })
  @ApiResponse({ status: 200, description: 'Группа найдена' })
  @ApiResponse({ status: 404, description: 'Группа не найдена' })
  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.groupsService.findOne(+id);
  }

  @ApiOperation({ summary: 'Обновить группу' })
  @ApiParam({ name: 'id', description: 'ID группы' })
  @ApiResponse({ status: 200, description: 'Группа обновлена' })
  @ApiResponse({ status: 404, description: 'Группа не найдена' })
  @Put(':id')
  async update(@Param('id') id: string, @Body() updateGroupDto: UpdateGroupDto) {
    return this.groupsService.update(+id, updateGroupDto);
  }

  @ApiOperation({ summary: 'Удалить группу' })
  @ApiParam({ name: 'id', description: 'ID группы' })
  @ApiResponse({ status: 200, description: 'Группа удалена' })
  @ApiResponse({ status: 404, description: 'Группа не найдена' })
  @Delete(':id')
  async remove(@Param('id') id: string) {
    return this.groupsService.remove(+id);
  }
}