import { Controller, Get, Post, Put, Delete, Body, Param, Query } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiParam } from '@nestjs/swagger';
import { StudentsGroupsService } from './students-groups.service';
import { CreateStudentsGroupDto } from './dto/students-group.dto';
import { UpdateStudentsGroupDto } from './dto/students-group.dto';

@ApiTags('students-groups')
@Controller('students-groups')
export class StudentsGroupsController {
  constructor(private readonly studentsGroupsService: StudentsGroupsService) {}

  @ApiOperation({ summary: 'Привязать студента к группе' })
  @ApiResponse({ status: 201, description: 'Студент привязан к группе' })
  @Post()
  async create(@Body() createStudentsGroupDto: CreateStudentsGroupDto) {
    return this.studentsGroupsService.create(createStudentsGroupDto);
  }

  @ApiOperation({ summary: 'Получить список привязок студентов к группам' })
  @ApiResponse({ status: 200, description: 'Список привязок' })
  @Get()
  async findAll(@Query() query: any) {
    return this.studentsGroupsService.findAll(query);
  }

  @ApiOperation({ summary: 'Получить привязку студента к группе' })
  @ApiParam({ name: 'groupId', description: 'ID группы' })
  @ApiParam({ name: 'studentId', description: 'ID студента' })
  @ApiResponse({ status: 200, description: 'Привязка найдена' })
  @ApiResponse({ status: 404, description: 'Привязка не найдена' })
  @Get(':groupId/:studentId')
  async findOne(@Param('groupId') groupId: string, @Param('studentId') studentId: string) {
    return this.studentsGroupsService.findOne(+groupId, +studentId);
  }

  @ApiOperation({ summary: 'Обновить привязку студента к группе' })
  @ApiParam({ name: 'groupId', description: 'ID группы' })
  @ApiParam({ name: 'studentId', description: 'ID студента' })
  @ApiResponse({ status: 200, description: 'Привязка обновлена' })
  @ApiResponse({ status: 404, description: 'Привязка не найдена' })
  @Put(':groupId/:studentId')
  async update(
    @Param('groupId') groupId: string,
    @Param('studentId') studentId: string,
    @Body() updateStudentsGroupDto: UpdateStudentsGroupDto,
  ) {
    return this.studentsGroupsService.update(+groupId, +studentId, updateStudentsGroupDto);
  }

  @ApiOperation({ summary: 'Удалить студента из группы' })
  @ApiParam({ name: 'groupId', description: 'ID группы' })
  @ApiParam({ name: 'studentId', description: 'ID студента' })
  @ApiResponse({ status: 200, description: 'Студент удален из группы' })
  @ApiResponse({ status: 404, description: 'Привязка не найдена' })
  @Delete(':groupId/:studentId')
  async remove(@Param('groupId') groupId: string, @Param('studentId') studentId: string) {
    return this.studentsGroupsService.remove(+groupId, +studentId);
  }
}