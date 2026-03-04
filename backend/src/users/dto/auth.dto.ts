import { IsString, IsEmail, IsOptional, MinLength, IsPhoneNumber, ValidateIf } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class RequestCodeDto {
  @ApiPropertyOptional({ description: 'Email для регистрации/входа' })
  @IsEmail()
  @ValidateIf(o => !o.phone)
  email?: string;

  @ApiPropertyOptional({ description: 'Телефон для регистрации/входа' })
  @IsPhoneNumber('RU')
  @ValidateIf(o => !o.email)
  phone?: string;
}

export class VerifyAndRegisterDto {
  @ApiPropertyOptional({ description: 'Email для регистрации' })
  @IsEmail()
  @ValidateIf(o => !o.phone)
  email?: string;

  @ApiPropertyOptional({ description: 'Телефон для регистрации' })
  @IsPhoneNumber('RU')
  @ValidateIf(o => !o.email)
  phone?: string;

  @ApiProperty({ description: 'Код подтверждения' })
  @IsString()
  @MinLength(6)
  code: string;

  @ApiProperty({ description: 'Имя пользователя' })
  @IsString()
  username: string;

  @ApiProperty({ description: 'Пароль' })
  @IsString()
  @MinLength(6)
  password: string;
}

export class VerifyAndLoginDto {
  @ApiPropertyOptional({ description: 'Email для входа' })
  @IsEmail()
  @ValidateIf(o => !o.phone)
  email?: string;

  @ApiPropertyOptional({ description: 'Телефон для входа' })
  @IsPhoneNumber('RU')
  @ValidateIf(o => !o.email)
  phone?: string;

  @ApiProperty({ description: 'Код подтверждения' })
  @IsString()
  @MinLength(6)
  code: string;
}

export class AttachContactDto {
  @ApiPropertyOptional({ description: 'Email для привязки' })
  @IsEmail()
  @ValidateIf(o => !o.phone)
  email?: string;

  @ApiPropertyOptional({ description: 'Телефон для привязки' })
  @IsPhoneNumber('RU')
  @ValidateIf(o => !o.email)
  phone?: string;
}

export class VerifyAndAttachDto extends AttachContactDto {
  @ApiProperty({ description: 'Код подтверждения' })
  @IsString()
  @MinLength(6)
  code: string;
}