export class CreateDutyTypeDto {
  name: string;
  description?: string;
  default_score: number;
}

export class UpdateDutyTypeDto {
  name?: string;
  description?: string;
  default_score?: number;
}