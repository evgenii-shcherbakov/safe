import { ApiProperty } from '@nestjs/swagger';

export class DeleteDto {
  @ApiProperty()
  readonly id: number;
}
