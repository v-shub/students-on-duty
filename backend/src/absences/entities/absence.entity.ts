import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

@Entity('absences')
export class Absence {
  @ApiProperty()
  @PrimaryGeneratedColumn()
  id: number;

  @ApiProperty({ description: 'ID студента' })
  @Column()
  student_id: number;

  @ApiProperty({ description: 'Дата начала отсутствия' })
  @Column('date')
  date_from: Date;

  @ApiProperty({ description: 'Дата окончания отсутствия' })
  @Column('date')
  date_to: Date;

  @ApiPropertyOptional({ description: 'Причина отсутствия' })
  @Column('text', { nullable: true })
  reason: string;

  @ApiProperty({ description: 'Одобрено ли отсутствие', default: false })
  @Column({ default: false })
  is_approved: boolean;
}