import { Entity, PrimaryGeneratedColumn, Column, Index, OneToMany } from 'typeorm';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { DutySchedule } from '../../duty-schedules/entities/duty-schedule.entity';

@Entity('duty_types')
export class DutyType {
  @ApiProperty()
  @PrimaryGeneratedColumn()
  id: number;

  @ApiProperty({ description: 'Название типа дежурства' })
  @Column({ length: 255 })
  @Index()
  name: string;

  @ApiPropertyOptional({ description: 'Описание типа дежурства' })
  @Column('text', { nullable: true })
  description: string;

    @ApiProperty({ description: 'Очки за выполненное дежурство по умолчанию', default: 1 })
  @Column({ type: 'smallint', default: 1 })
  default_score: number;

  @OneToMany(() => DutySchedule, (ds) => ds.duty_type)
  schedules: DutySchedule[];
}