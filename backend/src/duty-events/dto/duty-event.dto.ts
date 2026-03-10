import { IsInt, IsDateString, IsString, IsOptional, IsIn } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { USER_DUTY_STATUSES } from '../entities/duty-event.entity';

export type UserDutyStatus = (typeof USER_DUTY_STATUSES)[number];

/** DTO для ручной генерации событий дежурства */
export class GenerateDutyEventDto {
  @ApiProperty({ description: 'ID расписания' })
  @IsInt()
  schedule_id: number;

  @ApiProperty({ description: 'Дата дежурства (YYYY-MM-DD)' })
  @IsDateString()
  date: string;
}

/** DTO для обновления статуса события пользователем.
 *  Доступные статусы: completed (выполнено) и cancelled (отменено).
 *  Статус reassigned выставляется только автоматически системой.
 */
export class UpdateDutyEventDto {
  @ApiProperty({
    description: 'Новый статус события. completed — студент выполнил дежурство (+score). cancelled — отменено, score не меняется.',
    enum: USER_DUTY_STATUSES,
  })
  @IsIn(USER_DUTY_STATUSES)
  status: UserDutyStatus;

  @ApiPropertyOptional({ description: 'Заметки' })
  @IsString()
  @IsOptional()
  notes?: string;
}