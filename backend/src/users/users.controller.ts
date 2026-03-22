import { Controller, Post, Body, UseGuards, Get, Put, Req } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth, ApiBody } from '@nestjs/swagger';
import { UsersService } from './users.service';
import {
  RequestCodeDto,
  VerifyAndRegisterDto,
  VerifyAndLoginDto,
  AttachContactDto,
  VerifyAndAttachDto,
  RefreshTokenDto,
  LogoutDto,
} from './dto/auth.dto';
import { LoginUserDto, UpdateUserDto } from './dto/user.dto';
import { AuthGuard } from '../common/guards/auth.guard';
import { CurrentUser } from '../common/decorators/current-user.decorator';

@ApiTags('users')
@ApiBearerAuth('bearer')
@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  // Регистрация
  @Post('request-code')
  requestCode(@Body() dto: RequestCodeDto) {
    return this.usersService.requestCode(dto);
  }

  @Post('register')
  register(@Body() dto: VerifyAndRegisterDto) {
    return this.usersService.registerWithCode(dto);
  }

  // Вход (два варианта)
  @Post('login/password')
  loginWithPassword(@Body() dto: LoginUserDto) {
    return this.usersService.login(dto);
  }

  @Post('login/code')
  loginWithCode(@Body() dto: VerifyAndLoginDto) {
    return this.usersService.loginWithCode(dto);
  }

  // Токены
  @Post('refresh')
  refresh(@Body() dto: RefreshTokenDto) {
    return this.usersService.refreshTokens(dto);
  }

  @Post('logout')
  @UseGuards(AuthGuard)
  logout(@Body() dto: LogoutDto, @Req() req: any) {
    const authHeader = req.headers['authorization'] ?? '';
    const accessToken = authHeader.startsWith('Bearer ') ? authHeader.slice(7) : undefined;
    return this.usersService.logout(dto, accessToken);
  }

  // Привязка контактов
  @Post('attach/request')
  @UseGuards(AuthGuard)
  requestAttachCode(@CurrentUser() userId: number, @Body() dto: AttachContactDto) {
    return this.usersService.requestAttachCode(userId, dto);
  }

  @Post('attach/verify')
  @UseGuards(AuthGuard)
  verifyAndAttachContact(@CurrentUser() userId: number, @Body() dto: VerifyAndAttachDto) {
    return this.usersService.verifyAndAttachContact(userId, dto);
  }

  // Профиль
  @Get('me')
  @UseGuards(AuthGuard)
  getMe(@CurrentUser() userId: number) {
    return this.usersService.findOne(userId);
  }

  @Put('me')
  @UseGuards(AuthGuard)
  updateMe(@CurrentUser() userId: number, @Body() dto: UpdateUserDto) {
    return this.usersService.update(userId, dto);
  }
}