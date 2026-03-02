export class CreateGroupDto {
  user_id: number;
  name: string;
  description?: string;
}

export class UpdateGroupDto {
  user_id?: number;
  name?: string;
  description?: string;
}