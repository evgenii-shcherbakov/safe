import { ApiProperty } from '@nestjs/swagger';

export class HealthCheckDto {
  @ApiProperty()
  readonly status: string;
}
