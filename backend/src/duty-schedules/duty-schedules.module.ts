import { Module } from '@nestjs/common';
import { DutySchedulesController } from './duty-schedules.controller';
import { DutySchedulesService } from './duty-schedules.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DutySchedule } from './entities/duty-schedule.entity';

@Module({
  imports: [TypeOrmModule.forFeature([DutySchedule])],
  controllers: [DutySchedulesController],
  providers: [DutySchedulesService],
})
export class DutySchedulesModule {}