import { IsInt, IsDateString, IsString, IsOptional, IsIn } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

const DUTY_STATUSES = ['cancelled', 'completed', 'reassigned', 'pending'] as const;
export type DutyStatus = (typeof DUTY_STATUSES)[number];

export class CreateDutyEventDto {
  @ApiProperty({ description: 'ID студента' })
  @IsInt()
  student_id: number;

  @ApiProperty({ description: 'ID расписания' })
  @IsInt()
  schedule_id: number;

  @ApiProperty({ description: 'Дата дежурства (YYYY-MM-DD)' })
  @IsDateString()
  duty_date: string;

  @ApiProperty({ description: 'Статус', enum: DUTY_STATUSES })
  @IsIn(DUTY_STATUSES)
  status: DutyStatus;

  @ApiPropertyOptional({ description: 'Заработанные очки' })
  @IsInt()
  @IsOptional()
  score_earned?: number;

  @ApiPropertyOptional({ description: 'Заметки' })
  @IsString()
  @IsOptional()
  notes?: string;
}

export class UpdateDutyEventDto {
  @ApiPropertyOptional({ description: 'ID студента' })
  @IsInt()
  @IsOptional()
  student_id?: number;

  @ApiPropertyOptional({ description: 'ID расписания' })
  @IsInt()
  @IsOptional()
  schedule_id?: number;

  @ApiPropertyOptional({ description: 'Дата дежурства (YYYY-MM-DD)' })
  @IsDateString()
  @IsOptional()
  duty_date?: string;

  @ApiPropertyOptional({ description: 'Статус', enum: DUTY_STATUSES })
  @IsIn(DUTY_STATUSES)
  @IsOptional()
  status?: DutyStatus;

  @ApiPropertyOptional({ description: 'Заработанные очки' })
  @IsInt()
  @IsOptional()
  score_earned?: number;

  @ApiPropertyOptional({ description: 'Заметки' })
  @IsString()
  @IsOptional()
  notes?: string;
}