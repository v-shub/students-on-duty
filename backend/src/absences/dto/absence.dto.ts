import { IsInt, IsDateString, IsString, IsBoolean, IsOptional } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateAbsenceDto {
  @ApiProperty({ description: 'ID студента' })
  @IsInt()
  student_id: number;

  @ApiProperty({ description: 'Дата начала отсутствия (YYYY-MM-DD)' })
  @IsDateString()
  date_from: string;

  @ApiProperty({ description: 'Дата окончания отсутствия (YYYY-MM-DD)' })
  @IsDateString()
  date_to: string;

  @ApiPropertyOptional({ description: 'Причина отсутствия' })
  @IsString()
  @IsOptional()
  reason?: string;

  @ApiPropertyOptional({ description: 'Одобрено ли отсутствие', default: false })
  @IsBoolean()
  @IsOptional()
  is_approved?: boolean;
}

export class UpdateAbsenceDto {
  @ApiPropertyOptional({ description: 'ID студента' })
  @IsInt()
  @IsOptional()
  student_id?: number;

  @ApiPropertyOptional({ description: 'Дата начала отсутствия (YYYY-MM-DD)' })
  @IsDateString()
  @IsOptional()
  date_from?: string;

  @ApiPropertyOptional({ description: 'Дата окончания отсутствия (YYYY-MM-DD)' })
  @IsDateString()
  @IsOptional()
  date_to?: string;

  @ApiPropertyOptional({ description: 'Причина отсутствия' })
  @IsString()
  @IsOptional()
  reason?: string;

  @ApiPropertyOptional({ description: 'Одобрено ли отсутствие' })
  @IsBoolean()
  @IsOptional()
  is_approved?: boolean;
}