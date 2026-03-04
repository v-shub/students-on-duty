import { Entity, PrimaryGeneratedColumn, Column, Index } from 'typeorm';

@Entity('verification_codes')
export class VerificationCode {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  @Index()
  contact: string; // email или телефон

  @Column({ length: 10 })
  type: 'email' | 'phone';

  @Column({ length: 6 })
  code: string;

  @Column()
  expiresAt: Date;

  @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  createdAt: Date;
}