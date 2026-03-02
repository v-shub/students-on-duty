import { createParamDecorator, ExecutionContext } from '@nestjs/common';

/** Извлекает ID текущего пользователя из заголовка X-User-Id */
export const CurrentUser = createParamDecorator((_data: unknown, ctx: ExecutionContext): number => {
  const request = ctx.switchToHttp().getRequest();
  const raw = request.headers['x-user-id'];
  return parseInt(raw, 10);
});