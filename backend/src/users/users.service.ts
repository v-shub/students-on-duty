import {
  Injectable,
  NotFoundException,
  ConflictException,
  UnauthorizedException,
  BadRequestException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { User } from './entities/user.entity';
import { AuthService } from '../auth/auth.service';
import { VerificationService } from '../auth/verification.service';
import {
  RequestCodeDto,
  VerifyAndRegisterDto,
  VerifyAndLoginDto,
  AttachContactDto,
  VerifyAndAttachDto,
  RefreshTokenDto,
  LogoutDto,
} from './dto/auth.dto';
import { RegisterUserDto, LoginUserDto, UpdateUserDto } from './dto/user.dto';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private readonly repo: Repository<User>,
    private readonly authService: AuthService,
    private readonly verificationService: VerificationService,
  ) {}

  /** Запрос кода подтверждения */
  async requestCode(dto: RequestCodeDto): Promise<{ message: string }> {
  const contact = dto.email || dto.phone;
  if (!contact) {
    throw new BadRequestException('Укажите email или телефон');
  }

  // Просто отправляем код, без проверок существования
  await this.verificationService.generateAndSendCode(contact, dto.email ? 'email' : 'phone');
  return { message: `Код подтверждения отправлен на ${contact}` };
}

    /** Регистрация с подтверждением */
  async registerWithCode(dto: VerifyAndRegisterDto): Promise<{ accessToken: string; refreshToken: string; user: Omit<User, 'password_hash'> }> {
    const contact = dto.email || dto.phone;
    if (!contact) {
      throw new BadRequestException('Укажите email или телефон');
    }
    await this.verificationService.verifyCode(contact, dto.code);
    const existingUser = await this.repo.findOne({ where: { username: dto.username } });
    if (existingUser) {
      throw new ConflictException('Имя пользователя уже занято');
    }
        const password_hash = await bcrypt.hash(dto.password, 10);
    const userData: Partial<User> = { username: dto.username, password_hash };
    if (dto.email) userData.email = dto.email;
    if (dto.phone) userData.phone = dto.phone;
    const insertResult = await this.repo.insert(userData);
    const saved = await this.repo.findOneOrFail({ where: { id: insertResult.identifiers[0].id } });
    const accessToken = this.authService.generateToken(saved.id, saved.username);
    const refreshToken = this.authService.generateRefreshToken(saved.id, saved.username);
    const { password_hash: _, ...result } = saved;
    return { accessToken, refreshToken, user: result };
  }

  /** Вход по коду */
  async loginWithCode(dto: VerifyAndLoginDto): Promise<{ accessToken: string; refreshToken: string; user: Omit<User, 'password_hash'> }> {
    const contact = dto.email || dto.phone;
    if (!contact) {
      throw new BadRequestException('Укажите email или телефон');
    }
    await this.verificationService.verifyCode(contact, dto.code);
    const user = await this.repo.findOne({
      where: dto.email ? { email: dto.email } : { phone: dto.phone }
    });
    if (!user) {
      throw new UnauthorizedException('Пользователь не найден');
    }
        const accessToken = this.authService.generateToken(user.id, user.username);
    const refreshToken = this.authService.generateRefreshToken(user.id, user.username);
    const { password_hash: _, ...result } = user;
    return { accessToken, refreshToken, user: result };
  }

  /** Запрос кода для привязки нового контакта */
  async requestAttachCode(userId: number, dto: AttachContactDto): Promise<{ message: string }> {
    const contact = dto.email || dto.phone;
    if (!contact) {
      throw new BadRequestException('Укажите email или телефон');
    }
    const existingUser = await this.repo.findOne({
      where: dto.email ? { email: dto.email } : { phone: dto.phone }
    });
    if (existingUser) {
      throw new ConflictException(`${dto.email ? 'Email' : 'Телефон'} уже привязан к другому аккаунту`);
    }
    const currentUser = await this.repo.findOne({ where: { id: userId } });
    if (!currentUser) {
      throw new NotFoundException('Пользователь не найден');
    }
    if (dto.email && currentUser.email === dto.email) {
      throw new ConflictException('Этот email уже привязан к вашему аккаунту');
    }
    if (dto.phone && currentUser.phone === dto.phone) {
      throw new ConflictException('Этот телефон уже привязан к вашему аккаунту');
    }
    await this.verificationService.generateAndSendCode(contact, dto.email ? 'email' : 'phone');
    return { message: `Код подтверждения отправлен на ${contact}` };
  }

  /** Подтверждение и привязка нового контакта */
  async verifyAndAttachContact(userId: number, dto: VerifyAndAttachDto): Promise<Omit<User, 'password_hash'>> {
    const contact = dto.email || dto.phone;
    if (!contact) {
      throw new BadRequestException('Укажите email или телефон');
    }
    await this.verificationService.verifyCode(contact, dto.code);
    const existingUser = await this.repo.findOne({
      where: dto.email ? { email: dto.email } : { phone: dto.phone }
    });
    if (existingUser && existingUser.id !== userId) {
      throw new ConflictException(`${dto.email ? 'Email' : 'Телефон'} уже привязан к другому аккаунту`);
    }
        const user = await this.repo.findOne({ where: { id: userId } });
    if (!user) throw new NotFoundException('Пользователь не найден');
    const updateData: Partial<User> = {};
    if (dto.email) updateData.email = dto.email;
    if (dto.phone) updateData.phone = dto.phone;
    await this.repo.update(userId, updateData);
    const saved = await this.repo.findOneOrFail({ where: { id: userId } });
    const { password_hash: _, ...result } = saved;
    return result;
  }

  /** Регистрация нового старосты */
    async register(dto: RegisterUserDto): Promise<Omit<User, 'password_hash'>> {
    const exists = await this.repo.findOne({ where: { username: dto.username } });
    if (exists) throw new ConflictException('Пользователь с таким логином уже существует');
    const password_hash = await bcrypt.hash(dto.password, 10);
    const result = await this.repo.insert({ username: dto.username, email: dto.email, phone: dto.phone, password_hash });
    const saved = await this.repo.findOneOrFail({ where: { id: result.identifiers[0].id } });
    const { password_hash: _, ...user } = saved;
    return user;
  }

    /** Логин — возвращает JWT токен и данные пользователя */
  async login(dto: LoginUserDto): Promise<{ accessToken: string; refreshToken: string; user: Omit<User, 'password_hash'> }> {
    const user = await this.repo.findOne({ where: { username: dto.username } });
    if (!user) throw new UnauthorizedException('Неверный логин или пароль');
    const valid = await bcrypt.compare(dto.password, user.password_hash);
    if (!valid) throw new UnauthorizedException('Неверный логин или пароль');
    const accessToken = this.authService.generateToken(user.id, user.username);
    const refreshToken = this.authService.generateRefreshToken(user.id, user.username);
    const { password_hash: _, ...result } = user;
    return { accessToken, refreshToken, user: result };
  }

  /** Обновить пару токенов по refresh токену */
  refreshTokens(dto: RefreshTokenDto): { accessToken: string; refreshToken: string } {
    return this.authService.refreshAccessToken(dto.refreshToken);
  }

  /** Выйти — отозвать refresh токен и занести access в blacklist */
  logout(dto: LogoutDto, accessToken?: string): { message: string } {
    this.authService.logout(dto.refreshToken, accessToken);
    return { message: 'Вы успешно вышли из системы' };
  }

  /** Получить профиль по ID */
  async findOne(id: number): Promise<Omit<User, 'password_hash'>> {
    const user = await this.repo.findOne({ where: { id } });
    if (!user) throw new NotFoundException('Пользователь не найден');
    const { password_hash: _, ...result } = user;
    return result;
  }

  /** Обновить профиль */
    async update(id: number, dto: UpdateUserDto): Promise<Omit<User, 'password_hash'>> {
    const user = await this.repo.findOne({ where: { id } });
    if (!user) throw new NotFoundException('Пользователь не найден');
    const updateData: Partial<User> = {};
    if (dto.password) updateData.password_hash = await bcrypt.hash(dto.password, 10);
    if (dto.email !== undefined) updateData.email = dto.email;
    if (dto.phone !== undefined) updateData.phone = dto.phone;
    await this.repo.update(id, updateData);
    const saved = await this.repo.findOneOrFail({ where: { id } });
    const { password_hash: _, ...result } = saved;
    return result;
  }
}