import { IsInt, IsDateString, IsBoolean, IsOptional, Min } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateDutyScheduleDto {
  @ApiProperty({ description: 'ID группы' })
  @IsInt()
  group_id: number;

  @ApiProperty({ description: 'ID типа дежурства' })
  @IsInt()
  duty_type_id: number;

  @ApiProperty({ description: 'Количество студентов в день', minimum: 1 })
  @IsInt()
  @Min(1)
  students_per_day: number;

  @ApiProperty({ description: 'Дата начала (YYYY-MM-DD)' })
  @IsDateString()
  start_date: string;

  @ApiPropertyOptional({ description: 'Дата окончания (YYYY-MM-DD)' })
  @IsDateString()
  @IsOptional()
  end_date?: string;

  @ApiPropertyOptional({ description: 'Активен ли график', default: true })
  @IsBoolean()
  @IsOptional()
  is_active?: boolean;
}

export class UpdateDutyScheduleDto {
  @ApiPropertyOptional({ description: 'ID группы' })
  @IsInt()
  @IsOptional()
  group_id?: number;

  @ApiPropertyOptional({ description: 'ID типа дежурства' })
  @IsInt()
  @IsOptional()
  duty_type_id?: number;

  @ApiPropertyOptional({ description: 'Количество студентов в день' })
  @IsInt()
  @Min(1)
  @IsOptional()
  students_per_day?: number;

  @ApiPropertyOptional({ description: 'Дата начала (YYYY-MM-DD)' })
  @IsDateString()
  @IsOptional()
  start_date?: string;

  @ApiPropertyOptional({ description: 'Дата окончания (YYYY-MM-DD)' })
  @IsDateString()
  @IsOptional()
  end_date?: string;

  @ApiPropertyOptional({ description: 'Активен ли график' })
  @IsBoolean()
  @IsOptional()
  is_active?: boolean;
}