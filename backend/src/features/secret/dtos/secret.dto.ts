import { ApiProperty } from '@nestjs/swagger';

export class SecretDto {
  @ApiProperty()
  readonly name: string;

  @ApiProperty()
  readonly description: string;

  @ApiProperty()
  readonly url: string;

  @ApiProperty()
  readonly email: string;

  @ApiProperty()
  readonly phone: string;

  @ApiProperty()
  readonly login: string;

  @ApiProperty()
  readonly password: string;
}
