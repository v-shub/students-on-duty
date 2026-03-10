import { IsInt } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateStudentsGroupDto {
  @ApiProperty({ description: 'ID группы' })
  @IsInt()
  group_id: number;

  @ApiProperty({ description: 'ID студента' })
  @IsInt()
  student_id: number;
}

// Составной ключ не меняется — UpdateStudentsGroupDto намеренно пустой
export class UpdateStudentsGroupDto {}