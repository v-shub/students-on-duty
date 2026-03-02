import { CanActivate, ExecutionContext, Injectable, UnauthorizedException } from '@nestjs/common';

/** Простой guard: проверяет наличие числового X-User-Id в заголовке */
@Injectable()
export class AuthGuard implements CanActivate {
  canActivate(ctx: ExecutionContext): boolean {
    const req = ctx.switchToHttp().getRequest();
    const raw = req.headers['x-user-id'];
    const id = parseInt(raw, 10);
    if (!raw || isNaN(id)) throw new UnauthorizedException('Заголовок X-User-Id обязателен');
    return true;
  }
}