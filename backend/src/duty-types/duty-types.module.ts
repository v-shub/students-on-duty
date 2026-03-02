import { Module } from '@nestjs/common';
import { DutyTypesController } from './duty-types.controller';
import { DutyTypesService } from './duty-types.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DutyType } from './entities/duty-type.entity';
import { AuthModule } from '../auth/auth.module';

@Module({
  imports: [TypeOrmModule.forFeature([DutyType]), AuthModule],
  controllers: [DutyTypesController],
  providers: [DutyTypesService],
})
export class DutyTypesModule {}