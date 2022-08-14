import { Body, Controller, Delete, Get, Param, ParseIntPipe, Post, Put } from '@nestjs/common';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { EndPoint, Selector } from '../../constants/enums';
import { CardsOperation } from '../../constants/swagger';
import { Observable } from 'rxjs';
import { DeleteDto } from '../../shared/dtos/delete.dto';
import { CardService } from './card.service';
import { Card } from './card';
import { CardDto } from './dtos/card.dto';

@ApiTags(EndPoint.CARDS)
@Controller(EndPoint.CARDS)
export class CardController {
  constructor(private readonly cardService: CardService) {}

  @ApiOperation({ summary: CardsOperation.GET })
  @ApiResponse({ type: [Card] })
  @Get()
  getAll(): Observable<Card[]> {
    return this.cardService.getAll();
  }

  @ApiOperation({ summary: CardsOperation.POST })
  @ApiResponse({ type: Card })
  @Post()
  create(@Body() dto: CardDto): Observable<Card> {
    return this.cardService.create(dto);
  }

  @ApiOperation({ summary: CardsOperation.PUT })
  @ApiResponse({ type: Card })
  @Put(Selector.ID)
  change(@Param('id', ParseIntPipe) id: number, @Body() dto: CardDto): Observable<Card> {
    return this.cardService.change(id, dto);
  }

  @ApiOperation({ summary: CardsOperation.DELETE })
  @ApiResponse({ type: DeleteDto })
  @Delete(Selector.ID)
  delete(@Param('id', ParseIntPipe) id: number): Observable<DeleteDto> {
    return this.cardService.delete(id);
  }
}
