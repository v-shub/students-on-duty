import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DutyDay } from './entities/duty-day.entity';
import { DutyDaysController } from './duty-days.controller';
import { DutyDaysService } from './duty-days.service';
import { DutySchedule } from '../duty-schedules/entities/duty-schedule.entity';
import { Group } from '../groups/entities/group.entity';
import { DutySchedulesModule } from '../duty-schedules/duty-schedules.module';
import { AuthModule } from '../auth/auth.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([DutyDay, DutySchedule, Group]),
    DutySchedulesModule,
    AuthModule,
  ],
  controllers: [DutyDaysController],
  providers: [DutyDaysService],
  exports: [DutyDaysService],
})
export class DutyDaysModule {}