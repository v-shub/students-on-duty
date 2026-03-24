import { Module, forwardRef } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DutyEventsController } from './duty-events.controller';
import { DutyEventsService } from './duty-events.service';
import { DutyEvent } from './entities/duty-event.entity';
import { DutySchedule } from '../duty-schedules/entities/duty-schedule.entity';
import { DutyDay } from '../duty-days/entities/duty-day.entity';
import { Student } from '../students/entities/student.entity';

import { Absence } from '../absences/entities/absence.entity';
import { Group } from '../groups/entities/group.entity';
import { AuthModule } from '../auth/auth.module';
import { AbsencesModule } from '../absences/absences.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      DutyEvent,
      DutySchedule,
      DutyDay,
            Student,
      Absence,
      Group,
    ]),
    AuthModule,
    forwardRef(() => AbsencesModule),
  ],
  controllers: [DutyEventsController],
  providers: [DutyEventsService],
  exports: [DutyEventsService],
})
export class DutyEventsModule {}