import {
  Entity, PrimaryGeneratedColumn, Column,
  ManyToOne, OneToOne, OneToMany, JoinColumn,
} from 'typeorm';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Group } from '../../groups/entities/group.entity';
import { DutyType } from '../../duty-types/entities/duty-type.entity';
import { DutyDay } from '../../duty-days/entities/duty-day.entity';
import { DutyEvent } from '../../duty-events/entities/duty-event.entity';

@Entity('duty_schedules')
export class DutySchedule {
  @ApiProperty()
  @PrimaryGeneratedColumn()
  id: number;

  @ApiProperty({ description: 'ID группы' })
  @Column()
  group_id: number;

  @ApiProperty({ description: 'ID типа дежурства' })
  @Column()
  duty_type_id: number;

  @ApiProperty({ description: 'Количество студентов на одно дежурство', default: 1 })
  @Column({ default: 1 })
  students_per_day: number;

  @ApiProperty({ description: 'Дата начала' })
  @Column('date')
  start_date: Date;

  @ApiPropertyOptional({ description: 'Дата окончания (null — бессрочно)' })
  @Column('date', { nullable: true })
  end_date: Date | null;

  @ApiProperty({ description: 'Активен ли график', default: true })
  @Column({ default: true })
  is_active: boolean;

  @ManyToOne(() => Group, (g) => g.schedules, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'group_id' })
  group: Group;

  @ManyToOne(() => DutyType, (dt) => dt.schedules, { onDelete: 'RESTRICT' })
  @JoinColumn({ name: 'duty_type_id' })
  duty_type: DutyType;

  /** Дни недели расписания (1:1, создаются вместе с расписанием) */
  @OneToOne(() => DutyDay, (dd) => dd.schedule, { cascade: true, eager: true })
  duty_days: DutyDay;

  @OneToMany(() => DutyEvent, (de) => de.schedule)
  events: DutyEvent[];
}