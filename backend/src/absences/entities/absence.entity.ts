import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from 'typeorm';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Student } from '../../students/entities/student.entity';

@Entity('absences')
export class Absence {
  @ApiProperty()
  @PrimaryGeneratedColumn()
  id: number;

  @ApiProperty({ description: 'ID студента' })
  @Column()
  student_id: number;

  @ApiProperty({ description: 'Дата начала отсутствия (YYYY-MM-DD)' })
  @Column('date')
  date_from: Date;

  @ApiProperty({ description: 'Дата окончания отсутствия (YYYY-MM-DD)' })
  @Column('date')
  date_to: Date;

  @ApiPropertyOptional({ description: 'Причина отсутствия' })
  @Column('text', { nullable: true })
  reason: string | null;

  @ApiProperty({ description: 'Одобрено ли отсутствие (одобренное — не влияет на score)', default: false })
  @Column({ default: false })
  is_approved: boolean;

  @ManyToOne(() => Student, (s) => s.absences, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'student_id' })
  student: Student;
}