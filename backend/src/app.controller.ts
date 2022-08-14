import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import { EndPoint } from './constants/enums';
import { HealthCheckDto } from './shared/dtos/health-check.dto';
import { ApiOperation, ApiResponse } from '@nestjs/swagger';
import { MainOperation } from './constants/swagger';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @ApiOperation({ summary: MainOperation.TEST })
  @ApiResponse({ type: HealthCheckDto })
  @Get(EndPoint.TEST)
  healthCheck(): HealthCheckDto {
    return this.appService.healthCheck();
  }
}
