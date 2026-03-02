import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { StudentsGroupsController } from './students-groups.controller';
import { StudentsGroupsService } from './students-groups.service';
import { StudentsGroup } from './entities/students-group.entity';
import { Group } from '../groups/entities/group.entity';
import { Student } from '../students/entities/student.entity';

@Module({
  imports: [TypeOrmModule.forFeature([StudentsGroup, Group, Student])],
  controllers: [StudentsGroupsController],
  providers: [StudentsGroupsService],
  exports: [StudentsGroupsService],
})
export class StudentsGroupsModule {}