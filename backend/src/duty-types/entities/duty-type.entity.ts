import { Entity, PrimaryGeneratedColumn, Column, Index } from 'typeorm';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

@Entity('duty_types')
export class DutyType {
  @ApiProperty()
  @PrimaryGeneratedColumn()
  id: number;

  @ApiProperty({ description: 'Название типа дежурства' })
  @Column({ length: 255 })
  @Index({ unique: true })
  name: string;

  @ApiPropertyOptional({ description: 'Описание типа дежурства' })
  @Column('text', { nullable: true })
  description: string;

  @ApiProperty({ description: 'Очки за дежурство по умолчанию', default: 0 })
  @Column({ default: 0 })
  default_score: number;
}