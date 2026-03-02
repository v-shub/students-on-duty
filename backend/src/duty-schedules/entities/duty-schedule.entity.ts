import { Entity, PrimaryGeneratedColumn, Column, Index } from 'typeorm';

@Entity('duty_schedules')
export class DutySchedule {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  group_id: number;

  @Column()
  duty_type_id: number;

  @Column({ default: 1 })
  students_per_day: number;

  @Column('date')
  start_date: Date;

  @Column('date', { nullable: true })
  end_date: Date;

  @Column({ default: true })
  is_active: boolean;
}