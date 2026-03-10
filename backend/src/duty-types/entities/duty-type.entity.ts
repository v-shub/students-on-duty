import { Entity, PrimaryGeneratedColumn, Column, Index, ManyToOne, OneToMany, JoinColumn } from 'typeorm';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { User } from '../../users/entities/user.entity';
import { DutySchedule } from '../../duty-schedules/entities/duty-schedule.entity';

@Entity('duty_types')
export class DutyType {
  @ApiProperty()
  @PrimaryGeneratedColumn()
  id: number;

  @ApiPropertyOptional({ description: 'ID владельца — null означает системный тип' })
  @Column({ nullable: true })
  user_id: number | null;

  @ApiProperty({ description: 'Название типа дежурства' })
  @Column({ length: 255 })
  @Index()
  name: string;

  @ApiPropertyOptional({ description: 'Описание типа дежурства' })
  @Column('text', { nullable: true })
  description: string;

  @ApiProperty({ description: 'Очки за выполненное дежурство по умолчанию', default: 1 })
  @Column({ default: 1 })
  default_score: number;

  /** null — системный тип, доступный всем */
  @ManyToOne(() => User, { nullable: true, onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user: User | null;

  @OneToMany(() => DutySchedule, (ds) => ds.duty_type)
  schedules: DutySchedule[];
}