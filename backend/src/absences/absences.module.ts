import { Module, forwardRef } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AbsencesController } from './absences.controller';
import { AbsencesService } from './absences.service';
import { Absence } from './entities/absence.entity';
import { StudentsGroup } from '../students-groups/entities/students-group.entity';
import { AuthModule } from '../auth/auth.module';
import { DutyEventsModule } from '../duty-events/duty-events.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([Absence, StudentsGroup]),
    AuthModule,
    forwardRef(() => DutyEventsModule),
  ],
  controllers: [AbsencesController],
  providers: [AbsencesService],
  exports: [AbsencesService],
})
export class AbsencesModule {}