import { Entity, PrimaryColumn } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';

@Entity('students_groups')
export class StudentsGroup {
  @ApiProperty({ description: 'ID группы' })
  @PrimaryColumn()
  group_id: number;

  @ApiProperty({ description: 'ID студента' })
  @PrimaryColumn()
  student_id: number;
}