import { IsString, IsInt, IsOptional } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateGroupDto {
  @ApiProperty({ description: 'ID пользователя-владельца группы' })
  @IsInt()
  user_id: number;

  @ApiProperty({ description: 'Название группы' })
  @IsString()
  name: string;

  @ApiPropertyOptional({ description: 'Описание группы' })
  @IsString()
  @IsOptional()
  description?: string;
}

export class UpdateGroupDto {
  @ApiPropertyOptional({ description: 'ID пользователя-владельца группы' })
  @IsInt()
  @IsOptional()
  user_id?: number;

  @ApiPropertyOptional({ description: 'Название группы' })
  @IsString()
  @IsOptional()
  name?: string;

  @ApiPropertyOptional({ description: 'Описание группы' })
  @IsString()
  @IsOptional()
  description?: string;
}