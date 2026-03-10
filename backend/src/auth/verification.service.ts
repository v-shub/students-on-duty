// auth/verification.service.ts
import { Injectable, Logger, BadRequestException } from '@nestjs/common';

interface VerificationCode {
  code: string;
  expiresAt: number;
}

@Injectable()
export class VerificationService {
  private readonly logger = new Logger(VerificationService.name);
  private readonly codes = new Map<string, VerificationCode>();
  constructor() {
    setInterval(() => this.cleanExpiredCodes(), 60 * 1000);
  }

  /**
   * Генерирует и отправляет код подтверждения
   */
  async generateAndSendCode(contact: string, type: 'email' | 'phone'): Promise<void> {
    const code = Math.floor(100000 + Math.random() * 900000).toString();
    const expiresAt = Date.now() + 5 * 60 * 1000;
    this.codes.set(contact, { code, expiresAt });

    // TODO: Здесь отправка кода
    // Для email: использовать nodemailer, SendGrid и т.д.
    // Для phone: использовать SMS-шлюз
    
    this.logger.log(`Код подтверждения для ${contact}: ${code}`);
    
    // Для разработки - выводим в консоль
    console.log(`\n📱 Код для ${contact}: ${code} (действителен 5 минут)\n`);
  }

  /**
   * Проверяет код подтверждения
   */
  async verifyCode(contact: string, code: string): Promise<boolean> {
    const record = this.codes.get(contact);
    if (!record) {
      throw new BadRequestException('Код не найден или истек');
    }
    if (record.expiresAt < Date.now()) {
      this.codes.delete(contact);
      throw new BadRequestException('Код истек');
    }
    if (record.code !== code) {
      throw new BadRequestException('Неверный код');
    }
    this.codes.delete(contact);
    
    return true;
  }

  /**
   * Очищает просроченные коды
   */
  private cleanExpiredCodes(): void {
    const now = Date.now();
    for (const [contact, record] of this.codes.entries()) {
      if (record.expiresAt < now) {
        this.codes.delete(contact);
      }
    }
  }
}