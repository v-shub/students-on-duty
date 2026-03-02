import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

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

  @ApiProperty({ description: 'Статус', enum: ['cancelled', 'completed', 'reassigned', 'pending'] })
  @Column('varchar')
  status: 'cancelled' | 'completed' | 'reassigned' | 'pending';

  @ApiPropertyOptional({ description: 'Заработанные очки' })
  @Column({ nullable: true })
  score_earned: number;

  @ApiPropertyOptional({ description: 'Заметки' })
  @Column('text', { nullable: true })
  notes: string;

  @ApiProperty({ description: 'Дата назначения' })
  @Column({ default: () => 'CURRENT_TIMESTAMP' })
  assigned_at: Date;
}