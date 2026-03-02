export class CreateDutyDayDto {
  schedule_id: number;
  is_monday?: boolean;
  is_tuesday?: boolean;
  is_wednesday?: boolean;
  is_thursday?: boolean;
  is_friday?: boolean;
  is_saturday?: boolean;
  is_sunday?: boolean;
}

export class UpdateDutyDayDto {
  schedule_id?: number;
  is_monday?: boolean;
  is_tuesday?: boolean;
  is_wednesday?: boolean;
  is_thursday?: boolean;
  is_friday?: boolean;
  is_saturday?: boolean;
  is_sunday?: boolean;
}