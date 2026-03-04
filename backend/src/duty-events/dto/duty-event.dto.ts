import { IsInt, IsDateString, IsString, IsOptional, IsIn } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export const DUTY_STATUSES = ['pending', 'completed', 'missed', 'missed_approved', 'cancelled'] as const;
export type DutyStatus = (typeof DUTY_STATUSES)[number];

/** DTO для ручной генерации событий дежурства */
export class GenerateDutyEventDto {
  @ApiProperty({ description: 'ID расписания' })
  @IsInt()
  schedule_id: number;

  @ApiProperty({ description: 'Дата дежурства (YYYY-MM-DD)' })
  @IsDateString()
  date: string;
}

/** DTO для обновления статуса события */
export class UpdateDutyEventDto {
  @ApiPropertyOptional({
    description: 'Новый статус события',
    enum: DUTY_STATUSES,
  })
  @IsIn(DUTY_STATUSES)
  @IsOptional()
  status?: DutyStatus;

  @ApiPropertyOptional({ description: 'Заметки' })
  @IsString()
  @IsOptional()
  notes?: string;
}