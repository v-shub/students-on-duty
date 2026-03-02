import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DutyEventsController } from './duty-events.controller';
import { DutyEventsService } from './duty-events.service';
import { DutyEvent } from './entities/duty-event.entity';
import { DutySchedule } from '../duty-schedules/entities/duty-schedule.entity';
import { DutyDay } from '../duty-days/entities/duty-day.entity';
import { Student } from '../students/entities/student.entity';
import { StudentsGroup } from '../students-groups/entities/students-group.entity';
import { Absence } from '../absences/entities/absence.entity';
import { Group } from '../groups/entities/group.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      DutyEvent,
      DutySchedule,
      DutyDay,
      Student,
      StudentsGroup,
      Absence,
      Group,
    ]),
  ],
  controllers: [DutyEventsController],
  providers: [DutyEventsService],
  exports: [DutyEventsService],
})
export class DutyEventsModule {}