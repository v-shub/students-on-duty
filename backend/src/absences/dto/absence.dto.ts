export class CreateAbsenceDto {
  student_id: number;
  date_from: Date;
  date_to: Date;
  reason?: string;
  is_approved?: boolean;
}

export class UpdateAbsenceDto {
  student_id?: number;
  date_from?: Date;
  date_to?: Date;
  reason?: string;
  is_approved?: boolean;
}