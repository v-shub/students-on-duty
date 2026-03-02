import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AbsencesController } from './absences.controller';
import { AbsencesService } from './absences.service';
import { Absence } from './entities/absence.entity';
import { Student } from '../students/entities/student.entity';
import { AuthModule } from '../auth/auth.module';

@Module({
  imports: [TypeOrmModule.forFeature([Absence, Student]), AuthModule],
  controllers: [AbsencesController],
  providers: [AbsencesService],
})
export class AbsencesModule {}