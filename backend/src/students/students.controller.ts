import { Controller, Get, Post, Put, Delete, Body, Param, UseGuards, ParseIntPipe, HttpCode } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiParam, ApiHeader } from '@nestjs/swagger';
import { StudentsService } from './students.service';
import { CreateStudentDto, UpdateStudentDto } from './dto/student.dto';
import { AuthGuard } from '../common/guards/auth.guard';
import { CurrentUser } from '../common/decorators/current-user.decorator';

@ApiTags('students')
@ApiHeader({ name: 'X-User-Id', description: 'ID текущего пользователя', required: true })
@UseGuards(AuthGuard)
@Controller('students')
export class StudentsController {
  constructor(private readonly studentsService: StudentsService) {}

  @ApiOperation({ summary: 'Создать студента' })
  @ApiResponse({ status: 201, description: 'Студент создан' })
  @Post()
  create(@CurrentUser() userId: number, @Body() dto: CreateStudentDto) {
    return this.studentsService.create(userId, dto);
  }

  @ApiOperation({ summary: 'Список своих студентов' })
  @ApiResponse({ status: 200, description: 'Список студентов' })
  @Get()
  findAll(@CurrentUser() userId: number) {
    return this.studentsService.findAll(userId);
  }

  @ApiOperation({ summary: 'Получить студента по ID' })
  @ApiParam({ name: 'id', description: 'ID студента' })
  @ApiResponse({ status: 200, description: 'Студент найден' })
  @ApiResponse({ status: 404, description: 'Студент не найден' })
  @Get(':id')
  findOne(@CurrentUser() userId: number, @Param('id', ParseIntPipe) id: number) {
    return this.studentsService.findOne(userId, id);
  }

  @ApiOperation({ summary: 'Обновить студента' })
  @ApiParam({ name: 'id', description: 'ID студента' })
  @ApiResponse({ status: 200, description: 'Студент обновлён' })
  @Put(':id')
  update(@CurrentUser() userId: number, @Param('id', ParseIntPipe) id: number, @Body() dto: UpdateStudentDto) {
    return this.studentsService.update(userId, id, dto);
  }

  @ApiOperation({ summary: 'Удалить студента' })
  @ApiParam({ name: 'id', description: 'ID студента' })
  @ApiResponse({ status: 204, description: 'Студент удалён' })
  @Delete(':id')
  @HttpCode(204)
  remove(@CurrentUser() userId: number, @Param('id', ParseIntPipe) id: number) {
    return this.studentsService.remove(userId, id);
  }
}