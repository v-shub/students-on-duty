import { IsString, IsOptional } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateGroupDto {
  @ApiProperty({ description: 'Название группы' })
  @IsString()
  name: string;

  @ApiPropertyOptional({ description: 'Описание группы' })
  @IsString()
  @IsOptional()
  description?: string;
}

export class UpdateGroupDto {
  @ApiPropertyOptional({ description: 'Название группы' })
  @IsString()
  @IsOptional()
  name?: string;

  @ApiPropertyOptional({ description: 'Описание группы' })
  @IsString()
  @IsOptional()
  description?: string;
}