import { Module } from '@nestjs/common';
import { StudentsGroupsController } from './students-groups.controller';
import { StudentsGroupsService } from './students-groups.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { StudentsGroup } from './entities/students-group.entity';

@Module({
  imports: [TypeOrmModule.forFeature([StudentsGroup])],
  controllers: [StudentsGroupsController],
  providers: [StudentsGroupsService],
})
export class StudentsGroupsModule {}