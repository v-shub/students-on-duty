import { Entity, PrimaryGeneratedColumn, Column, Index } from 'typeorm';

@Entity('groups')
export class Group {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  user_id: number;

  @Column({ length: 255 })
  @Index()
  name: string;

  @Column('text', { nullable: true })
  description: string;
}