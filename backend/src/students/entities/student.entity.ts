import { Entity, PrimaryGeneratedColumn, Column, Index } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';

@Entity('students')
export class Student {
  @ApiProperty()
  @PrimaryGeneratedColumn()
  id: number;

  @ApiProperty({ description: 'Имя студента' })
  @Column({ length: 255 })
  @Index()
  name: string;

  @ApiProperty({ description: 'Активен ли студент', default: true })
  @Column({ default: true })
  is_active: boolean;

  @ApiProperty({ description: 'Очки дежурств', default: 0 })
  @Column({ default: 0 })
  duty_score: number;
}