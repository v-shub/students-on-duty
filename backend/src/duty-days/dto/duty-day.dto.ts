import { IsInt, IsBoolean, IsOptional } from 'class-validator';
import { Transform } from 'class-transformer';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateDutyDayDto {
  @ApiProperty({ description: 'ID расписания' })
  @IsInt()
  schedule_id: number;

  @ApiPropertyOptional({ default: false }) @IsBoolean() @IsOptional() is_monday?: boolean;
  @ApiPropertyOptional({ default: false }) @IsBoolean() @IsOptional() is_tuesday?: boolean;
  @ApiPropertyOptional({ default: false }) @IsBoolean() @IsOptional() is_wednesday?: boolean;
  @ApiPropertyOptional({ default: false }) @IsBoolean() @IsOptional() is_thursday?: boolean;
  @ApiPropertyOptional({ default: false }) @IsBoolean() @IsOptional() is_friday?: boolean;
  @ApiPropertyOptional({ default: false }) @IsBoolean() @IsOptional() is_saturday?: boolean;
  @ApiPropertyOptional({ default: false }) @IsBoolean() @IsOptional() is_sunday?: boolean;
}

export class UpdateDutyDayDto {
  @ApiPropertyOptional() @IsBoolean() @IsOptional() is_monday?: boolean;
  @ApiPropertyOptional() @IsBoolean() @IsOptional() is_tuesday?: boolean;
  @ApiPropertyOptional() @IsBoolean() @IsOptional() is_wednesday?: boolean;
  @ApiPropertyOptional() @IsBoolean() @IsOptional() is_thursday?: boolean;
  @ApiPropertyOptional() @IsBoolean() @IsOptional() is_friday?: boolean;
  @ApiPropertyOptional() @IsBoolean() @IsOptional() is_saturday?: boolean;
  @ApiPropertyOptional() @IsBoolean() @IsOptional() is_sunday?: boolean;
}

export class FindDutyDaysDto {
  @ApiPropertyOptional({ description: 'Фильтр по ID расписания' })
  @IsOptional()
  @IsInt()
  @Transform(({ value }) => parseInt(value))
  schedule_id?: number;

  @ApiPropertyOptional({ description: 'Фильтр по понедельнику' })
  @IsOptional()
  @IsBoolean()
  @Transform(({ value }) => value === 'true')
  is_monday?: boolean;

  @ApiPropertyOptional({ description: 'Фильтр по вторнику' })
  @IsOptional()
  @IsBoolean()
  @Transform(({ value }) => value === 'true')
  is_tuesday?: boolean;

  @ApiPropertyOptional({ description: 'Фильтр по среде' })
  @IsOptional()
  @IsBoolean()
  @Transform(({ value }) => value === 'true')
  is_wednesday?: boolean;

  @ApiPropertyOptional({ description: 'Фильтр по четвергу' })
  @IsOptional()
  @IsBoolean()
  @Transform(({ value }) => value === 'true')
  is_thursday?: boolean;

  @ApiPropertyOptional({ description: 'Фильтр по пятнице' })
  @IsOptional()
  @IsBoolean()
  @Transform(({ value }) => value === 'true')
  is_friday?: boolean;

  @ApiPropertyOptional({ description: 'Фильтр по субботе' })
  @IsOptional()
  @IsBoolean()
  @Transform(({ value }) => value === 'true')
  is_saturday?: boolean;

  @ApiPropertyOptional({ description: 'Фильтр по воскресенью' })
  @IsOptional()
  @IsBoolean()
  @Transform(({ value }) => value === 'true')
  is_sunday?: boolean;
}