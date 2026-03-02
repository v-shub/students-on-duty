import { Controller, Get, Post, Put, Delete, Body, Param, Query } from '@nestjs/common';
import { DutyEventsService } from './duty-events.service';
import { CreateDutyEventDto } from './dto/duty-event.dto';
import { UpdateDutyEventDto } from './dto/duty-event.dto';

@Controller('duty-events')
export class DutyEventsController {
  constructor(private readonly dutyEventsService: DutyEventsService) {}

  @Post()
  async create(@Body() createDutyEventDto: CreateDutyEventDto) {
    return this.dutyEventsService.create(createDutyEventDto);
  }

  @Get()
  async findAll(@Query() query: any) {
    return this.dutyEventsService.findAll(query);
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.dutyEventsService.findOne(+id);
  }

  @Put(':id')
  async update(@Param('id') id: string, @Body() updateDutyEventDto: UpdateDutyEventDto) {
    return this.dutyEventsService.update(+id, updateDutyEventDto);
  }

  @Delete(':id')
  async remove(@Param('id') id: string) {
    return this.dutyEventsService.remove(+id);
  }
}