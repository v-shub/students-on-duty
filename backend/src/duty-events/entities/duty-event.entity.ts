import { Entity, PrimaryGeneratedColumn, Column, Index } from 'typeorm';

@Entity('duty_events')
export class DutyEvent {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  student_id: number;

  @Column()
  schedule_id: number;

  @Column('date')
  duty_date: Date;

  @Column('varchar')
  status: 'cancelled' | 'completed' | 'reassigned' | 'pending';

  @Column({ nullable: true })
  score_earned: number;

  @Column('text', { nullable: true })
  notes: string;

  @Column({ default: () => 'CURRENT_TIMESTAMP' })
  assigned_at: Date;
}