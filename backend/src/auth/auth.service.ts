import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as crypto from 'crypto';

export interface JwtPayload {
  sub: number;
  username: string;
}

interface RefreshTokenRecord {
  userId: number;
  username: string;
  expiresAt: number;
}

@Injectable()
export class AuthService {
  /** Хранилище refresh токенов: tokenHash -> данные */
  private readonly refreshTokens = new Map<string, RefreshTokenRecord>();

  /** Blacklist отозванных access токенов: tokenHash -> время истечения */
  private readonly revokedTokens = new Map<string, number>();

  constructor(private readonly jwtService: JwtService) {
    // Очистка просроченных записей каждые 10 минут
    setInterval(() => this.cleanExpired(), 10 * 60 * 1000);
  }

  /** Генерирует access JWT токен (15 минут) */
  generateToken(userId: number, username: string): string {
    const payload: JwtPayload = { sub: userId, username };
    return this.jwtService.sign(payload, { expiresIn: '15m' });
  }

  /** Генерирует refresh токен (30 дней) и сохраняет в памяти */
  generateRefreshToken(userId: number, username: string): string {
    const token = crypto.randomBytes(64).toString('hex');
    const hash = this.hashToken(token);
    const expiresAt = Date.now() + 30 * 24 * 60 * 60 * 1000;
    this.refreshTokens.set(hash, { userId, username, expiresAt });
    return token;
  }

  /** Обновляет пару токенов по refresh токену (rotate) */
  refreshAccessToken(refreshToken: string): { accessToken: string; refreshToken: string } {
    const hash = this.hashToken(refreshToken);
    const record = this.refreshTokens.get(hash);

    if (!record) {
      throw new UnauthorizedException('Refresh токен не найден или отозван');
    }
    if (record.expiresAt < Date.now()) {
      this.refreshTokens.delete(hash);
      throw new UnauthorizedException('Refresh токен истёк');
    }

    // Rotate: удаляем старый, выдаём новую пару
    this.refreshTokens.delete(hash);
    const accessToken = this.generateToken(record.userId, record.username);
    const newRefreshToken = this.generateRefreshToken(record.userId, record.username);
    return { accessToken, refreshToken: newRefreshToken };
  }

  /** Отзывает refresh токен и добавляет access токен в blacklist */
  logout(refreshToken: string, accessToken?: string): void {
    const hash = this.hashToken(refreshToken);
    this.refreshTokens.delete(hash);

    if (accessToken) {
      try {
        const payload = this.jwtService.verify<JwtPayload>(accessToken);
        const exp = (payload as any).exp as number;
        const accessHash = this.hashToken(accessToken);
        this.revokedTokens.set(accessHash, exp * 1000);
      } catch {
        // Токен уже невалиден — ничего не делаем
      }
    }
  }

  /** Верифицирует access токен и проверяет blacklist */
  verifyToken(token: string): JwtPayload {
    const payload = this.jwtService.verify<JwtPayload>(token);
    const hash = this.hashToken(token);
    if (this.revokedTokens.has(hash)) {
      throw new UnauthorizedException('Токен отозван');
    }
    return payload;
  }

  /** Проверяет, не отозван ли токен */
  isTokenRevoked(token: string): boolean {
    return this.revokedTokens.has(this.hashToken(token));
  }

  /** SHA-256 хэш токена */
  private hashToken(token: string): string {
    return crypto.createHash('sha256').update(token).digest('hex');
  }

  /** Очищает просроченные записи из памяти */
  private cleanExpired(): void {
    const now = Date.now();
    for (const [hash, record] of this.refreshTokens.entries()) {
      if (record.expiresAt < now) this.refreshTokens.delete(hash);
    }
    for (const [hash, exp] of this.revokedTokens.entries()) {
      if (exp < now) this.revokedTokens.delete(hash);
    }
  }
}