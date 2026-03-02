export class CreateDutyEventDto {
  student_id: number;
  schedule_id: number;
  duty_date: Date;
  status: 'cancelled' | 'completed' | 'reassigned' | 'pending';
  score_earned?: number;
  notes?: string;
}

export class UpdateDutyEventDto {
  student_id?: number;
  schedule_id?: number;
  duty_date?: Date;
  status?: 'cancelled' | 'completed' | 'reassigned' | 'pending';
  score_earned?: number;
  notes?: string;
}