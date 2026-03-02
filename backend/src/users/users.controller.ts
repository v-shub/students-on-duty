import { Controller, Get, Post, Put, Body, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiHeader } from '@nestjs/swagger';
import { UsersService } from './users.service';
import { RegisterUserDto, LoginUserDto, UpdateUserDto } from './dto/user.dto';
import { AuthGuard } from '../common/guards/auth.guard';
import { CurrentUser } from '../common/decorators/current-user.decorator';

@ApiTags('users')
@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @ApiOperation({ summary: 'Регистрация нового старосты' })
  @ApiResponse({ status: 201, description: 'Пользователь создан' })
  @ApiResponse({ status: 409, description: 'Логин уже занят' })
  @Post('register')
  register(@Body() dto: RegisterUserDto) {
    return this.usersService.register(dto);
  }

  @ApiOperation({ summary: 'Войти в систему (получить свой ID)' })
  @ApiResponse({ status: 200, description: 'Успешный вход, возвращает пользователя' })
  @ApiResponse({ status: 401, description: 'Неверный логин или пароль' })
  @Post('login')
  login(@Body() dto: LoginUserDto) {
    return this.usersService.login(dto);
  }

  @ApiOperation({ summary: 'Получить свой профиль' })
  @ApiHeader({ name: 'X-User-Id', description: 'ID текущего пользователя', required: true })
  @ApiResponse({ status: 200, description: 'Профиль пользователя' })
  @UseGuards(AuthGuard)
  @Get('me')
  getMe(@CurrentUser() userId: number) {
    return this.usersService.findOne(userId);
  }

  @ApiOperation({ summary: 'Обновить свой профиль' })
  @ApiHeader({ name: 'X-User-Id', description: 'ID текущего пользователя', required: true })
  @ApiResponse({ status: 200, description: 'Профиль обновлён' })
  @UseGuards(AuthGuard)
  @Put('me')
  updateMe(@CurrentUser() userId: number, @Body() dto: UpdateUserDto) {
    return this.usersService.update(userId, dto);
  }
}