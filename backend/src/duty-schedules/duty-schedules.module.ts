import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DutySchedulesController } from './duty-schedules.controller';
import { DutySchedulesService } from './duty-schedules.service';
import { DutySchedule } from './entities/duty-schedule.entity';
import { DutyDay } from '../duty-days/entities/duty-day.entity';
import { Group } from '../groups/entities/group.entity';
import { DutyType } from '../duty-types/entities/duty-type.entity';

@Module({
  imports: [TypeOrmModule.forFeature([DutySchedule, DutyDay, Group, DutyType])],
  controllers: [DutySchedulesController],
  providers: [DutySchedulesService],
  exports: [DutySchedulesService],
})
export class DutySchedulesModule {}