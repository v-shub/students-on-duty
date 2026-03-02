export class CreateStudentDto {
  name: string;
  is_active?: boolean;
  duty_score?: number;
}

export class UpdateStudentDto {
  name?: string;
  is_active?: boolean;
  duty_score?: number;
}