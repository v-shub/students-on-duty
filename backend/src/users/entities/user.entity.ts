import { Entity, PrimaryGeneratedColumn, Column, Index, OneToMany } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';
import { Group } from '../../groups/entities/group.entity';

@Entity('users')
export class User {
  @ApiProperty()
  @PrimaryGeneratedColumn()
  id: number;

  @ApiProperty()
  @Column({ length: 100 })
  @Index({ unique: true })
  username: string;

  @ApiProperty({ required: false })
  @Column({ length: 255, nullable: true })
  email: string;

  @ApiProperty({ required: false })
  @Column({ length: 50, nullable: true })
  phone: string;

  @Column({ length: 255 })
  password_hash: string;

  @OneToMany(() => Group, (g) => g.user)
  groups: Group[];
}