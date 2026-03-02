import { Entity, PrimaryGeneratedColumn, Column, Index } from 'typeorm';

@Entity('duty_types')
export class DutyType {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ length: 255 })
  @Index({ unique: true })
  name: string;

  @Column('text', { nullable: true })
  description: string;

  @Column({ default: 0 })
  default_score: number;
}