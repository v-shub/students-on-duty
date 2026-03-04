// users/users.controller.ts
import { Controller, Get, Post, Put, Body, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { UsersService } from './users.service';
import { 
  RequestCodeDto, 
  VerifyAndRegisterDto, 
  VerifyAndLoginDto,
  AttachContactDto,
  VerifyAndAttachDto 
} from './dto/auth.dto';
import { UpdateUserDto } from './dto/user.dto';
import { AuthGuard } from '../common/guards/auth.guard';
import { CurrentUser } from '../common/decorators/current-user.decorator';

@ApiTags('users')
@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @ApiOperation({ summary: 'Запросить код подтверждения для регистрации' })
  @ApiResponse({ status: 200, description: 'Код отправлен' })
  @ApiResponse({ status: 409, description: 'Контакт уже зарегистрирован' })
  @Post('request-code')
  requestCode(@Body() dto: RequestCodeDto) {
    return this.usersService.requestCode(dto);
  }

  @ApiOperation({ summary: 'Зарегистрироваться с кодом подтверждения' })
  @ApiResponse({ status: 201, description: 'Пользователь создан' })
  @ApiResponse({ status: 400, description: 'Неверный код' })
  @ApiResponse({ status: 409, description: 'Имя пользователя уже занято' })
  @Post('register')
  register(@Body() dto: VerifyAndRegisterDto) {
    return this.usersService.registerWithCode(dto);
  }

  @ApiOperation({ summary: 'Войти с кодом подтверждения' })
  @ApiResponse({ status: 200, description: 'Успешный вход' })
  @ApiResponse({ status: 401, description: 'Неверный код или пользователь не найден' })
  @Post('login')
  login(@Body() dto: VerifyAndLoginDto) {
    return this.usersService.loginWithCode(dto);
  }

  @ApiOperation({ summary: 'Запросить код для привязки нового контакта' })
  @ApiBearerAuth('bearer')
  @ApiResponse({ status: 200, description: 'Код отправлен' })
  @ApiResponse({ status: 409, description: 'Контакт уже используется' })
  @UseGuards(AuthGuard)
  @Post('attach/request')
  requestAttachCode(@CurrentUser() userId: number, @Body() dto: AttachContactDto) {
    return this.usersService.requestAttachCode(userId, dto);
  }

  @ApiOperation({ summary: 'Подтвердить и привязать новый контакт' })
  @ApiBearerAuth('bearer')
  @ApiResponse({ status: 200, description: 'Контакт привязан' })
  @ApiResponse({ status: 400, description: 'Неверный код' })
  @UseGuards(AuthGuard)
  @Post('attach/verify')
  verifyAndAttachContact(@CurrentUser() userId: number, @Body() dto: VerifyAndAttachDto) {
    return this.usersService.verifyAndAttachContact(userId, dto);
  }

  @ApiOperation({ summary: 'Получить свой профиль' })
  @ApiBearerAuth('bearer')
  @ApiResponse({ status: 200, description: 'Профиль пользователя' })
  @UseGuards(AuthGuard)
  @Get('me')
  getMe(@CurrentUser() userId: number) {
    return this.usersService.findOne(userId);
  }

  @ApiOperation({ summary: 'Обновить свой профиль' })
  @ApiBearerAuth('bearer')
  @ApiResponse({ status: 200, description: 'Профиль обновлён' })
  @UseGuards(AuthGuard)
  @Put('me')
  updateMe(@CurrentUser() userId: number, @Body() dto: UpdateUserDto) {
    return this.usersService.update(userId, dto);
  }
}