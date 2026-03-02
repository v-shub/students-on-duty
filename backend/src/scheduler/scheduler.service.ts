import { Injectable, Logger } from '@nestjs/common';
import { Cron, CronExpression } from '@nestjs/schedule';
import { DutyEventsService } from '../duty-events/duty-events.service';

@Injectable()
export class DutySchedulerService {
  private readonly logger = new Logger(DutySchedulerService.name);

  constructor(private readonly dutyEventsService: DutyEventsService) {}

  /** Каждый день в 06:00 — генерируем события дежурств на сегодня */
  @Cron(CronExpression.EVERY_DAY_AT_6AM)
  async handleDailyGeneration(): Promise<void> {
    this.logger.log('Запуск авто-генерации событий дежурств...');
    try {
      await this.dutyEventsService.generateForToday();
      this.logger.log('Авто-генерация завершена');
    } catch (err) {
      this.logger.error('Ошибка авто-генерации событий', err);
    }
  }
}