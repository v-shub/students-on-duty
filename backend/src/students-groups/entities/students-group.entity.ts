import { Entity, PrimaryColumn, ManyToOne, JoinColumn } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';
import { Student } from '../../students/entities/student.entity';
import { Group } from '../../groups/entities/group.entity';

@Entity('students_groups')
export class StudentsGroup {
  @ApiProperty({ description: 'ID группы' })
  @PrimaryColumn()
  group_id: number;

  @ApiProperty({ description: 'ID студента' })
  @PrimaryColumn()
  student_id: number;

  @ManyToOne(() => Student, (s) => s.group_links, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'student_id' })
  student: Student;

  @ManyToOne(() => Group, (g) => g.student_links, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'group_id' })
  group: Group;
}