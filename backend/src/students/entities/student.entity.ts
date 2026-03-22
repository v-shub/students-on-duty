import { Entity, PrimaryGeneratedColumn, Column, Index, OneToMany } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';
import { StudentsGroup } from '../../students-groups/entities/students-group.entity';
import { DutyEvent } from '../../duty-events/entities/duty-event.entity';
import { Absence } from '../../absences/entities/absence.entity';

@Entity('students')
export class Student {
      @ApiProperty()
  @PrimaryGeneratedColumn()
  id: number;

    @ApiProperty({ description: 'Имя студента' })
  @Column({ length: 500 })
  @Index()
  name: string;

  @ApiProperty({ description: 'Активен ли студент (участвует в назначениях)', default: true })
  @Column({ default: true })
  is_active: boolean;

  @ApiProperty({ description: 'Очки дежурств (изменяется только бизнес-логикой)', default: 0 })
  @Column({ default: 0 })
  duty_score: number;

    /** Привязки к группам */
  @OneToMany(() => StudentsGroup, (sg) => sg.student)
  group_links: StudentsGroup[];

  @OneToMany(() => DutyEvent, (de) => de.student)
  duty_events: DutyEvent[];

  @OneToMany(() => Absence, (a) => a.student)
  absences: Absence[];
}