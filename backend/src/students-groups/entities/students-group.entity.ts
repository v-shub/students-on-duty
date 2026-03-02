import { Entity, PrimaryGeneratedColumn, Column, Index } from 'typeorm';

@Entity('students_groups')
export class StudentsGroup {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  group_id: number;

  @Column()
  student_id: number;
}