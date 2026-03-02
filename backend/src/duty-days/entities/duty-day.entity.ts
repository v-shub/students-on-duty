import { Entity, PrimaryGeneratedColumn, Column, Index } from 'typeorm';

@Entity('duty_days')
export class DutyDay {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  schedule_id: number;

  @Column({ default: false })
  is_monday: boolean;

  @Column({ default: false })
  is_tuesday: boolean;

  @Column({ default: false })
  is_wednesday: boolean;

  @Column({ default: false })
  is_thursday: boolean;

  @Column({ default: false })
  is_friday: boolean;

  @Column({ default: false })
  is_saturday: boolean;

  @Column({ default: false })
  is_sunday: boolean;
}