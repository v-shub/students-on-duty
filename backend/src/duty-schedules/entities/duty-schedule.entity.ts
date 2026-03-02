import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

@Entity('duty_schedules')
export class DutySchedule {
  @ApiProperty()
  @PrimaryGeneratedColumn()
  id: number;

  @ApiProperty({ description: 'ID группы' })
  @Column()
  group_id: number;

  @ApiProperty({ description: 'ID типа дежурства' })
  @Column()
  duty_type_id: number;

  @ApiProperty({ description: 'Количество студентов в день', default: 1 })
  @Column({ default: 1 })
  students_per_day: number;

  @ApiProperty({ description: 'Дата начала' })
  @Column('date')
  start_date: Date;

  @ApiPropertyOptional({ description: 'Дата окончания' })
  @Column('date', { nullable: true })
  end_date: Date;

  @ApiProperty({ description: 'Активен ли график', default: true })
  @Column({ default: true })
  is_active: boolean;
}