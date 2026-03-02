export class CreateStudentsGroupDto {
  group_id: number;
  student_id: number;
}

export class UpdateStudentsGroupDto {
  group_id?: number;
  student_id?: number;
}