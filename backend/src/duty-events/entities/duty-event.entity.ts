import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from 'typeorm';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Student } from '../../students/entities/student.entity';
import { DutySchedule } from '../../duty-schedules/entities/duty-schedule.entity';

/** Статусы, которые может выставить пользователь вручную */
export const USER_DUTY_STATUSES = ['completed', 'cancelled'] as const;
/** Все возможные статусы события дежурства */
export const DUTY_STATUSES = ['pending', 'completed', 'cancelled', 'reassigned'] as const;
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
    description:
      'Статус: pending — назначено (ожидает), completed — выполнено (+score), ' +
      'cancelled — отменено пользователем (без изменения score), ' +
      'reassigned — переназначено из-за отсутствия (автоматически, -score если отсутствие не одобрено)',
    enum: DUTY_STATUSES,
  })
  @Column({ type: 'varchar', default: 'pending' })
  status: DutyStatus;

  @ApiPropertyOptional({
    description:
      'Изменение очков: +score при completed, -score при reassigned с неодобренным отсутствием, ' +
      'null или 0 в остальных случаях',
  })
  @Column({ type: 'int', nullable: true, name: 'score_earned' })
  score_earned: number | null;

  @ApiPropertyOptional({ description: 'Заметки' })
  @Column('text', { nullable: true })
  notes: string | null;

    @ApiProperty({ description: 'Дата назначения' })
  @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  assigned_at: Date;

  @ManyToOne(() => Student, (s) => s.duty_events, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'student_id' })
  student: Student;

  @ManyToOne(() => DutySchedule, (ds) => ds.events, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'schedule_id' })
  schedule: DutySchedule;
}