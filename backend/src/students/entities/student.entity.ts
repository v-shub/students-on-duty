import { Entity, PrimaryGeneratedColumn, Column, Index, OneToMany, ManyToOne, JoinColumn } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';
import { User } from '../../users/entities/user.entity';
import { StudentsGroup } from '../../students-groups/entities/students-group.entity';
import { DutyEvent } from '../../duty-events/entities/duty-event.entity';
import { Absence } from '../../absences/entities/absence.entity';

@Entity('students')
export class Student {
  @ApiProperty()
  @PrimaryGeneratedColumn()
  id: number;

  @ApiProperty({ description: 'ID пользователя-владельца (старосты)' })
  @Column()
  user_id: number;

  @ApiProperty({ description: 'Имя студента' })
  @Column({ length: 255 })
  @Index()
  name: string;

  @ApiProperty({ description: 'Активен ли студент (участвует в назначениях)', default: true })
  @Column({ default: true })
  is_active: boolean;

  @ApiProperty({ description: 'Очки дежурств (изменяется только бизнес-логикой)', default: 0 })
  @Column({ default: 0 })
  duty_score: number;

  /** Владелец-староста */
  @ManyToOne(() => User, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user: User;

  /** Привязки к группам (студент может состоять в нескольких группах одного старосты) */
  @OneToMany(() => StudentsGroup, (sg) => sg.student)
  group_links: StudentsGroup[];

  @OneToMany(() => DutyEvent, (de) => de.student)
  duty_events: DutyEvent[];

  @OneToMany(() => Absence, (a) => a.student)
  absences: Absence[];
}