import { Module } from '@nestjs/common';
import { ScheduleModule } from '@nestjs/schedule';
import { DutyEventsModule } from '../duty-events/duty-events.module';
import { DutySchedulerService } from './scheduler.service';

@Module({
  imports: [
    ScheduleModule.forRoot(),
    DutyEventsModule,
  ],
  providers: [DutySchedulerService],
})
export class DutySchedulerModule {}