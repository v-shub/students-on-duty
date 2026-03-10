import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { JwtPayload } from '../../auth/auth.service';

/** Извлекает ID текущего пользователя из JWT payload */
export const CurrentUser = createParamDecorator((_data: unknown, ctx: ExecutionContext): number => {
  const request = ctx.switchToHttp().getRequest();
  const user: JwtPayload = request.user;
  return user?.sub;
});