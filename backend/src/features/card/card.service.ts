import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { from, map, Observable, switchMap } from 'rxjs';
import { DeleteDto } from '../../shared/dtos/delete.dto';
import { Card } from './card';
import { CardDto } from './dtos/card.dto';

@Injectable()
export class CardService {
  constructor(
    @InjectRepository(Card)
    private readonly cardRepository: Repository<Card>,
  ) {}

  private async getOne(id: number): Promise<Card> {
    return this.cardRepository.findOneBy({ id });
  }

  getAll(): Observable<Card[]> {
    return from(this.cardRepository.find());
  }

  create(dto: CardDto): Observable<Card> {
    return from(this.cardRepository.save(this.cardRepository.create(dto)));
  }

  change(id: number, dto: CardDto): Observable<Card> {
    return from(this.cardRepository.update({ id }, dto)).pipe(
      switchMap(() => from(this.getOne(id))),
    );
  }

  delete(id: number): Observable<DeleteDto> {
    return from(this.cardRepository.delete({ id })).pipe(map(() => ({ id })));
  }
}
