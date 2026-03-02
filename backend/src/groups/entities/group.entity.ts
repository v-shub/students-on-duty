import { Entity, PrimaryGeneratedColumn, Column, Index } from 'typeorm';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

@Entity('groups')
export class Group {
  @ApiProperty()
  @PrimaryGeneratedColumn()
  id: number;

  @ApiProperty({ description: 'ID пользователя-владельца' })
  @Column()
  user_id: number;

  @ApiProperty({ description: 'Название группы' })
  @Column({ length: 255 })
  @Index()
  name: string;

  @ApiPropertyOptional({ description: 'Описание группы' })
  @Column('text', { nullable: true })
  description: string;
}