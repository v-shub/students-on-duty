import { Entity, PrimaryGeneratedColumn, Column, Index } from 'typeorm';

@Entity('students')
export class Student {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ length: 255 })
  @Index()
  name: string;

  @Column({ default: true })
  is_active: boolean;

  @Column({ default: 0 })
  duty_score: number;
}