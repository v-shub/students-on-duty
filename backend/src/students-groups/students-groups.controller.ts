import { Controller, Get, Post, Delete, Param, UseGuards, ParseIntPipe, HttpCode } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiParam, ApiBearerAuth } from '@nestjs/swagger';
import { StudentsGroupsService } from './students-groups.service';
import { AuthGuard } from '../common/guards/auth.guard';
import { CurrentUser } from '../common/decorators/current-user.decorator';

@ApiTags('groups')
@ApiBearerAuth('bearer')
@UseGuards(AuthGuard)
@Controller('groups/:groupId/students')
export class StudentsGroupsController {
  constructor(private readonly studentsGroupsService: StudentsGroupsService) {}

  @ApiOperation({ summary: 'Добавить студента в группу' })
  @ApiParam({ name: 'groupId', description: 'ID группы' })
  @ApiParam({ name: 'studentId', description: 'ID студента' })
  @ApiResponse({ status: 201, description: 'Студент добавлен в группу' })
  @ApiResponse({ status: 409, description: 'Студент уже в группе' })
  @Post(':studentId')
  addStudent(
    @CurrentUser() userId: number,
    @Param('groupId', ParseIntPipe) groupId: number,
    @Param('studentId', ParseIntPipe) studentId: number,
  ) {
    return this.studentsGroupsService.addStudent(userId, groupId, studentId);
  }

  @ApiOperation({ summary: 'Список студентов группы' })
  @ApiParam({ name: 'groupId', description: 'ID группы' })
  @ApiResponse({ status: 200, description: 'Список студентов' })
  @Get()
  findStudents(
    @CurrentUser() userId: number,
    @Param('groupId', ParseIntPipe) groupId: number,
  ) {
    return this.studentsGroupsService.findStudents(userId, groupId);
  }

  @ApiOperation({ summary: 'Удалить студента из группы' })
  @ApiParam({ name: 'groupId', description: 'ID группы' })
  @ApiParam({ name: 'studentId', description: 'ID студента' })
  @ApiResponse({ status: 204, description: 'Студент удалён из группы' })
  @Delete(':studentId')
  @HttpCode(204)
  removeStudent(
    @CurrentUser() userId: number,
    @Param('groupId', ParseIntPipe) groupId: number,
    @Param('studentId', ParseIntPipe) studentId: number,
  ) {
    return this.studentsGroupsService.removeStudent(userId, groupId, studentId);
  }
}