import { Controller, Get, Post, Put, Delete, Body, Param, Query } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { StudentsService } from './students.service';
import { CreateStudentDto } from './dto/student.dto';
import { UpdateStudentDto } from './dto/student.dto';

@ApiTags('students')
@Controller('students')
export class StudentsController {
  constructor(private readonly studentsService: StudentsService) {}

  @ApiOperation({ summary: 'Создать студента' })
  @ApiResponse({ status: 201, description: 'Студент создан' })
  @Post()
  async create(@Body() createStudentDto: CreateStudentDto) {
    return this.studentsService.create(createStudentDto);
  }

  @ApiOperation({ summary: 'Получить список студентов' })
  @ApiResponse({ status: 200, description: 'Список студентов' })
  @Get()
  async findAll(@Query() query: any) {
    return this.studentsService.findAll(query);
  }

  @ApiOperation({ summary: 'Получить студента по ID' })
  @ApiResponse({ status: 200, description: 'Студент найден' })
  @ApiResponse({ status: 404, description: 'Студент не найден' })
  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.studentsService.findOne(+id);
  }

  @ApiOperation({ summary: 'Обновить студента' })
  @ApiResponse({ status: 200, description: 'Студент обновлен' })
  @ApiResponse({ status: 404, description: 'Студент не найден' })
  @Put(':id')
  async update(@Param('id') id: string, @Body() updateStudentDto: UpdateStudentDto) {
    return this.studentsService.update(+id, updateStudentDto);
  }

  @ApiOperation({ summary: 'Удалить студента' })
  @ApiResponse({ status: 200, description: 'Студент удален' })
  @ApiResponse({ status: 404, description: 'Студент не найден' })
  @Delete(':id')
  async remove(@Param('id') id: string) {
    return this.studentsService.remove(+id);
  }
}