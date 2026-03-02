import { Entity, PrimaryColumn, Column } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';

@Entity('duty_days')
export class DutyDay {
  @ApiProperty({ description: 'ID расписания (PK)' })
  @PrimaryColumn()
  schedule_id: number;

  @ApiProperty({ default: false }) @Column({ default: false }) is_monday: boolean;
  @ApiProperty({ default: false }) @Column({ default: false }) is_tuesday: boolean;
  @ApiProperty({ default: false }) @Column({ default: false }) is_wednesday: boolean;
  @ApiProperty({ default: false }) @Column({ default: false }) is_thursday: boolean;
  @ApiProperty({ default: false }) @Column({ default: false }) is_friday: boolean;
  @ApiProperty({ default: false }) @Column({ default: false }) is_saturday: boolean;
  @ApiProperty({ default: false }) @Column({ default: false }) is_sunday: boolean;
}