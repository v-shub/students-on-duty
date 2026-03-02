export class CreateDutyScheduleDto {
  group_id: number;
  duty_type_id: number;
  students_per_day: number;
  start_date: Date;
  end_date?: Date;
  is_active?: boolean;
}

export class UpdateDutyScheduleDto {
  group_id?: number;
  duty_type_id?: number;
  students_per_day?: number;
  start_date?: Date;
  end_date?: Date;
  is_active?: boolean;
}