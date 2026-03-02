import { IsInt, IsBoolean, IsOptional } from 'class-validator';
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