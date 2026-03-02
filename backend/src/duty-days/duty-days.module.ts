import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DutyDay } from './entities/duty-day.entity';

/** DutyDay управляется через DutySchedulesModule (cascade), отдельный CRUD не нужен */
@Module({
  imports: [TypeOrmModule.forFeature([DutyDay])],
})
export class DutyDaysModule {}