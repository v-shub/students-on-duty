import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';

export interface JwtPayload {
  sub: number;
  username: string;
}

@Injectable()
export class AuthService {
  constructor(private readonly jwtService: JwtService) {}

  /** Генерирует JWT токен для пользователя */
  generateToken(userId: number, username: string): string {
    const payload: JwtPayload = { sub: userId, username };
    return this.jwtService.sign(payload);
  }

  /** Верифицирует токен и возвращает payload */
  verifyToken(token: string): JwtPayload {
    return this.jwtService.verify<JwtPayload>(token);
  }
}