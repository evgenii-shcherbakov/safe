import { ApiProperty } from '@nestjs/swagger';

export class CardDto {
  @ApiProperty()
  readonly name: string;

  @ApiProperty()
  readonly description: string;

  @ApiProperty()
  readonly type: string;

  @ApiProperty()
  readonly number: string;

  @ApiProperty()
  readonly vcc: string;

  @ApiProperty()
  readonly pin: string;

  @ApiProperty()
  readonly securityCode: string;

  @ApiProperty()
  readonly expiredAt: string;

  @ApiProperty()
  readonly price: number;
}
