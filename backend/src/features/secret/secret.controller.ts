import { Body, Controller, Delete, Get, Param, ParseIntPipe, Post, Put } from '@nestjs/common';
import { EndPoint, Selector } from '../../constants/enums';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { SecretService } from './secret.service';
import { Observable } from 'rxjs';
import { Secret } from './secret';
import { SecretsOperation } from '../../constants/swagger';
import { SecretDto } from './dtos/secret.dto';
import { DeleteDto } from '../../shared/dtos/delete.dto';

@ApiTags(EndPoint.SECRETS)
@Controller(EndPoint.SECRETS)
export class SecretController {
  constructor(private readonly secretService: SecretService) {}

  @ApiOperation({ summary: SecretsOperation.GET })
  @ApiResponse({ type: [Secret] })
  @Get()
  getAll(): Observable<Secret[]> {
    return this.secretService.getAll();
  }

  @ApiOperation({ summary: SecretsOperation.POST })
  @ApiResponse({ type: Secret })
  @Post()
  create(@Body() dto: SecretDto): Observable<Secret> {
    return this.secretService.create(dto);
  }

  @ApiOperation({ summary: SecretsOperation.PUT })
  @ApiResponse({ type: Secret })
  @Put(Selector.ID)
  change(@Param('id', ParseIntPipe) id: number, @Body() dto: SecretDto): Observable<Secret> {
    return this.secretService.change(id, dto);
  }

  @ApiOperation({ summary: SecretsOperation.DELETE })
  @ApiResponse({ type: DeleteDto })
  @Delete(Selector.ID)
  delete(@Param('id', ParseIntPipe) id: number): Observable<DeleteDto> {
    return this.secretService.delete(id);
  }
}
