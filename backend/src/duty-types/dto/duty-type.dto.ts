import { IsString, IsInt, IsOptional, Min } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateDutyTypeDto {
  @ApiProperty({ description: 'Название типа дежурства' })
  @IsString()
  name: string;

  @ApiPropertyOptional({ description: 'Описание типа дежурства' })
  @IsString()
  @IsOptional()
  description?: string;

  @ApiProperty({ description: 'Очки за дежурство по умолчанию' })
  @IsInt()
  @Min(0)
  default_score: number;
}

export class UpdateDutyTypeDto {
  @ApiPropertyOptional({ description: 'Название типа дежурства' })
  @IsString()
  @IsOptional()
  name?: string;

  @ApiPropertyOptional({ description: 'Описание типа дежурства' })
  @IsString()
  @IsOptional()
  description?: string;

  @ApiPropertyOptional({ description: 'Очки за дежурство по умолчанию' })
  @IsInt()
  @Min(0)
  @IsOptional()
  default_score?: number;
}