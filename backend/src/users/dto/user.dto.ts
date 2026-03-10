import { IsString, IsEmail, IsOptional, MinLength } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class RegisterUserDto {
  @ApiProperty({ description: 'Логин пользователя' })
  @IsString()
  username: string;

  @ApiPropertyOptional({ description: 'Email' })
  @IsEmail()
  @IsOptional()
  email?: string;

  @ApiPropertyOptional({ description: 'Телефон' })
  @IsString()
  @IsOptional()
  phone?: string;

  @ApiProperty({ description: 'Пароль (минимум 6 символов)' })
  @IsString()
  @MinLength(6)
  password: string;
}

export class LoginUserDto {
  @ApiProperty({ description: 'Логин пользователя' })
  @IsString()
  username: string;

  @ApiProperty({ description: 'Пароль' })
  @IsString()
  password: string;
}

export class UpdateUserDto {
  @ApiPropertyOptional({ description: 'Email' })
  @IsEmail()
  @IsOptional()
  email?: string;

  @ApiPropertyOptional({ description: 'Телефон' })
  @IsString()
  @IsOptional()
  phone?: string;

  @ApiPropertyOptional({ description: 'Новый пароль (минимум 6 символов)' })
  @IsString()
  @MinLength(6)
  @IsOptional()
  password?: string;
}