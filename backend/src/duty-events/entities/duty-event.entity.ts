import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from 'typeorm';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Student } from '../../students/entities/student.entity';
import { DutySchedule } from '../../duty-schedules/entities/duty-schedule.entity';

export const DUTY_STATUSES = ['pending', 'completed', 'missed', 'missed_approved'] as const;
export type DutyStatus = (typeof DUTY_STATUSES)[number];

@Entity('duty_events')
export class DutyEvent {
  @ApiProperty()
  @PrimaryGeneratedColumn()
  id: number;

  @ApiProperty({ description: 'ID студента' })
  @Column()
  student_id: number;

  @ApiProperty({ description: 'ID расписания' })
  @Column()
  schedule_id: number;

  @ApiProperty({ description: 'Дата дежурства' })
  @Column('date')
  duty_date: Date;

  @ApiProperty({
    description: 'Статус: pending — назначено, completed — выполнено, missed — пропущено (штраф), missed_approved — пропущено без штрафа',
    enum: DUTY_STATUSES,
  })
  @Column({ type: 'varchar', default: 'pending' })
  status: DutyStatus;

  @ApiPropertyOptional({ description: 'Начисленные/снятые очки (заполняется автоматически при смене статуса)' })
  @Column({ type: 'int', nullable: true })
  score_delta: number | null;

  @ApiPropertyOptional({ description: 'Заметки' })
  @Column('text', { nullable: true })
  notes: string | null;

  @ApiProperty({ description: 'Дата назначения' })
  @Column({ default: () => 'CURRENT_TIMESTAMP' })
  assigned_at: Date;

  @ManyToOne(() => Student, (s) => s.duty_events, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'student_id' })
  student: Student;

  @ManyToOne(() => DutySchedule, (ds) => ds.events, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'schedule_id' })
  schedule: DutySchedule;
}