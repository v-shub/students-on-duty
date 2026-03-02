import { IsString, IsBoolean, IsInt, IsOptional, Min } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateStudentDto {
  @ApiProperty({ description: 'Имя студента' })
  @IsString()
  name: string;

  @ApiPropertyOptional({ description: 'Активен ли студент', default: true })
  @IsBoolean()
  @IsOptional()
  is_active?: boolean;

  @ApiPropertyOptional({ description: 'Очки дежурств', default: 0 })
  @IsInt()
  @Min(0)
  @IsOptional()
  duty_score?: number;
}

export class UpdateStudentDto {
  @ApiPropertyOptional({ description: 'Имя студента' })
  @IsString()
  @IsOptional()
  name?: string;

  @ApiPropertyOptional({ description: 'Активен ли студент' })
  @IsBoolean()
  @IsOptional()
  is_active?: boolean;

  @ApiPropertyOptional({ description: 'Очки дежурств' })
  @IsInt()
  @Min(0)
  @IsOptional()
  duty_score?: number;
}