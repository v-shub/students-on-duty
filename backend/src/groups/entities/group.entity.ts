import { Entity, PrimaryGeneratedColumn, Column, Index, ManyToOne, OneToMany, JoinColumn } from 'typeorm';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { User } from '../../users/entities/user.entity';
import { StudentsGroup } from '../../students-groups/entities/students-group.entity';
import { DutySchedule } from '../../duty-schedules/entities/duty-schedule.entity';

@Entity('groups')
export class Group {
  @ApiProperty()
  @PrimaryGeneratedColumn()
  id: number;

  @ApiProperty({ description: 'ID пользователя-владельца' })
  @Column()
  user_id: number;

  @ApiProperty({ description: 'Название группы' })
  @Column({ length: 255 })
  @Index()
  name: string;

  @ApiPropertyOptional({ description: 'Описание группы' })
  @Column('text', { nullable: true })
  description: string;

  @ManyToOne(() => User, (u) => u.groups, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user: User;

  @OneToMany(() => StudentsGroup, (sg) => sg.group)
  student_links: StudentsGroup[];

  @OneToMany(() => DutySchedule, (ds) => ds.group)
  schedules: DutySchedule[];
}