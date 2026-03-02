import {
  Injectable,
  NotFoundException,
  ConflictException,
  UnauthorizedException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { RegisterUserDto, LoginUserDto, UpdateUserDto } from './dto/user.dto';
import { User } from './entities/user.entity';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private readonly repo: Repository<User>,
  ) {}

  /** Регистрация нового старосты */
  async register(dto: RegisterUserDto): Promise<Omit<User, 'password_hash'>> {
    const exists = await this.repo.findOne({ where: { username: dto.username } });
    if (exists) throw new ConflictException('Пользователь с таким логином уже существует');

    const password_hash = await bcrypt.hash(dto.password, 10);
    const user = this.repo.create({ username: dto.username, email: dto.email, phone: dto.phone, password_hash });
    const saved = await this.repo.save(user);
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    const { password_hash: _, ...result } = saved;
    return result;
  }

  /** Логин — возвращает пользователя (без хэша) если пароль верный */
  async login(dto: LoginUserDto): Promise<Omit<User, 'password_hash'>> {
    const user = await this.repo.findOne({ where: { username: dto.username } });
    if (!user) throw new UnauthorizedException('Неверный логин или пароль');

    const valid = await bcrypt.compare(dto.password, user.password_hash);
    if (!valid) throw new UnauthorizedException('Неверный логин или пароль');

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    const { password_hash: _, ...result } = user;
    return result;
  }

  /** Получить профиль по ID */
  async findOne(id: number): Promise<Omit<User, 'password_hash'>> {
    const user = await this.repo.findOne({ where: { id } });
    if (!user) throw new NotFoundException('Пользователь не найден');
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    const { password_hash: _, ...result } = user;
    return result;
  }

  /** Обновить профиль */
  async update(id: number, dto: UpdateUserDto): Promise<Omit<User, 'password_hash'>> {
    const user = await this.repo.findOne({ where: { id } });
    if (!user) throw new NotFoundException('Пользователь не найден');

    if (dto.password) {
      user.password_hash = await bcrypt.hash(dto.password, 10);
    }
    if (dto.email !== undefined) user.email = dto.email;
    if (dto.phone !== undefined) user.phone = dto.phone;

    const saved = await this.repo.save(user);
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    const { password_hash: _, ...result } = saved;
    return result;
  }
}
