import { Entity, PrimaryGeneratedColumn, Column, Index } from 'typeorm';

@Entity('absences')
export class Absence {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  student_id: number;

  @Column('date')
  date_from: Date;

  @Column('date')
  date_to: Date;

  @Column('text', { nullable: true })
  reason: string;

  @Column({ default: false })
  is_approved: boolean;
}