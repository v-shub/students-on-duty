export class CreateUserDto {
  username: string;
  email?: string;
  phone?: string;
  password_hash: string;
}

export class UpdateUserDto {
  username?: string;
  email?: string;
  phone?: string;
  password_hash?: string;
}