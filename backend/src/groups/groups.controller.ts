import { Controller, Get, Post, Put, Delete, Body, Param, Query } from '@nestjs/common';
import { GroupsService } from './groups.service';
import { CreateGroupDto } from './dto/create-group.dto';
import { UpdateGroupDto } from './dto/update-group.dto';

@Controller('groups')
export class GroupsController {
  constructor(private readonly groupsService: GroupsService) {}

  @Post()
  async create(@Body() createGroupDto: CreateGroupDto) {
    return this.groupsService.create(createGroupDto);
  }

  @Get()
  async findAll(@Query() query: any) {
    return this.groupsService.findAll(query);
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.groupsService.findOne(+id);
  }

  @Put(':id')
  async update(@Param('id') id: string, @Body() updateGroupDto: UpdateGroupDto) {
    return this.groupsService.update(+id, updateGroupDto);
  }

  @Delete(':id')
  async remove(@Param('id') id: string) {
    return this.groupsService.remove(+id);
  }
}