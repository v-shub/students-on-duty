import { IsInt, IsDateString, IsBoolean, IsOptional, Min, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

/** Дни недели для расписания */
export class DutyDaysDto {
  @ApiPropertyOptional({ default: false }) @IsBoolean() @IsOptional() is_monday?: boolean;
  @ApiPropertyOptional({ default: false }) @IsBoolean() @IsOptional() is_tuesday?: boolean;
  @ApiPropertyOptional({ default: false }) @IsBoolean() @IsOptional() is_wednesday?: boolean;
  @ApiPropertyOptional({ default: false }) @IsBoolean() @IsOptional() is_thursday?: boolean;
  @ApiPropertyOptional({ default: false }) @IsBoolean() @IsOptional() is_friday?: boolean;
  @ApiPropertyOptional({ default: false }) @IsBoolean() @IsOptional() is_saturday?: boolean;
  @ApiPropertyOptional({ default: false }) @IsBoolean() @IsOptional() is_sunday?: boolean;
}

export class CreateDutyScheduleDto {
  @ApiProperty({ description: 'ID группы' })
  @IsInt()
  group_id: number;

  @ApiProperty({ description: 'ID типа дежурства (системный или свой)' })
  @IsInt()
  duty_type_id: number;

  @ApiProperty({ description: 'Количество студентов на одно дежурство', minimum: 1, default: 1 })
  @IsInt()
  @Min(1)
  students_per_day: number;

  @ApiProperty({ description: 'Дата начала (YYYY-MM-DD)' })
  @IsDateString()
  start_date: string;

  @ApiPropertyOptional({ description: 'Дата окончания (YYYY-MM-DD), null — бессрочно' })
  @IsDateString()
  @IsOptional()
  end_date?: string;

  @ApiPropertyOptional({ description: 'Дни недели дежурства' })
  @ValidateNested()
  @Type(() => DutyDaysDto)
  @IsOptional()
  duty_days?: DutyDaysDto;
}

export class UpdateDutyScheduleDto {
  @ApiPropertyOptional({ description: 'ID типа дежурства' })
  @IsInt()
  @IsOptional()
  duty_type_id?: number;

  @ApiPropertyOptional({ description: 'Количество студентов на одно дежурство', minimum: 1 })
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

  @ApiPropertyOptional({ description: 'Дни недели дежурства' })
  @ValidateNested()
  @Type(() => DutyDaysDto)
  @IsOptional()
  duty_days?: DutyDaysDto;
}