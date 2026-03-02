import { Controller, Get, Post, Put, Delete, Body, Param, Query } from '@nestjs/common';
import { DutyTypesService } from './duty-types.service';
import { CreateDutyTypeDto } from './dto/duty-type.dto';
import { UpdateDutyTypeDto } from './dto/duty-type.dto';

@Controller('duty-types')
export class DutyTypesController {
  constructor(private readonly dutyTypesService: DutyTypesService) {}

  @Post()
  async create(@Body() createDutyTypeDto: CreateDutyTypeDto) {
    return this.dutyTypesService.create(createDutyTypeDto);
  }

  @Get()
  async findAll(@Query() query: any) {
    return this.dutyTypesService.findAll(query);
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.dutyTypesService.findOne(+id);
  }

  @Put(':id')
  async update(@Param('id') id: string, @Body() updateDutyTypeDto: UpdateDutyTypeDto) {
    return this.dutyTypesService.update(+id, updateDutyTypeDto);
  }

  @Delete(':id')
  async remove(@Param('id') id: string) {
    return this.dutyTypesService.remove(+id);
  }
}