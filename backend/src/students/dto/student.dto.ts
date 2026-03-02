import { IsString, IsBoolean, IsOptional } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateStudentDto {
  @ApiProperty({ description: 'Имя студента' })
  @IsString()
  name: string;

  @ApiPropertyOptional({ description: 'Активен ли студент (участвует в назначениях)', default: true })
  @IsBoolean()
  @IsOptional()
  is_active?: boolean;
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
}