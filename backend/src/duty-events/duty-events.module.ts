import { Module } from '@nestjs/common';
import { DutyEventsController } from './duty-events.controller';
import { DutyEventsService } from './duty-events.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DutyEvent } from './entities/duty-event.entity';

@Module({
  imports: [TypeOrmModule.forFeature([DutyEvent])],
  controllers: [DutyEventsController],
  providers: [DutyEventsService],
})
export class DutyEventsModule {}