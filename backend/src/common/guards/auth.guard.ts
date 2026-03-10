import { CanActivate, ExecutionContext, Injectable, UnauthorizedException } from '@nestjs/common';
import { AuthService } from '../../auth/auth.service';

/** Guard: проверяет JWT Bearer токен в заголовке Authorization */
@Injectable()
export class AuthGuard implements CanActivate {
  constructor(private readonly authService: AuthService) {}

  canActivate(ctx: ExecutionContext): boolean {
    const req = ctx.switchToHttp().getRequest();
    const authHeader: string | undefined = req.headers['authorization'];

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      throw new UnauthorizedException('Токен авторизации отсутствует');
    }

    const token = authHeader.slice(7);

    try {
      const payload = this.authService.verifyToken(token);
      req.user = payload;
      return true;
    } catch {
      throw new UnauthorizedException('Токен недействителен или истёк');
    }
  }
}