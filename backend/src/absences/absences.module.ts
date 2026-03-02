import { Module } from '@nestjs/common';
import { AbsencesController } from './absences.controller';
import { AbsencesService } from './absences.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Absence } from './entities/absence.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Absence])],
  controllers: [AbsencesController],
  providers: [AbsencesService],
})
export class AbsencesModule {}