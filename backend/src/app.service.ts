import { Injectable } from '@nestjs/common';
import { HealthCheckDto } from './shared/dtos/health-check.dto';

@Injectable()
export class AppService {
  healthCheck(): HealthCheckDto {
    return { status: 'ok' };
  }
}
