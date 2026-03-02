import { Module } from '@nestjs/common';
import { DutyDaysController } from './duty-days.controller';
import { DutyDaysService } from './duty-days.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DutyDay } from './entities/duty-day.entity';

@Module({
  imports: [TypeOrmModule.forFeature([DutyDay])],
  controllers: [DutyDaysController],
  providers: [DutyDaysService],
})
export class DutyDaysModule {}