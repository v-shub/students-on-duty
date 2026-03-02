import { Controller, Get, Post, Put, Delete, Body, Param, Query } from '@nestjs/common';
import { StudentsGroupsService } from './students-groups.service';
import { CreateStudentsGroupDto } from './dto/create-students-group.dto';
import { UpdateStudentsGroupDto } from './dto/update-students-group.dto';

@Controller('students-groups')
export class StudentsGroupsController {
  constructor(private readonly studentsGroupsService: StudentsGroupsService) {}

  @Post()
  async create(@Body() createStudentsGroupDto: CreateStudentsGroupDto) {
    return this.studentsGroupsService.create(createStudentsGroupDto);
  }

  @Get()
  async findAll(@Query() query: any) {
    return this.studentsGroupsService.findAll(query);
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.studentsGroupsService.findOne(+id);
  }

  @Put(':id')
  async update(@Param('id') id: string, @Body() updateStudentsGroupDto: UpdateStudentsGroupDto) {
    return this.studentsGroupsService.update(+id, updateStudentsGroupDto);
  }

  @Delete(':id')
  async remove(@Param('id') id: string) {
    return this.studentsGroupsService.remove(+id);
  }
}