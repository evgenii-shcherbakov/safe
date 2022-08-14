import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Secret } from './secret';
import { Repository } from 'typeorm';
import { from, map, Observable, switchMap } from 'rxjs';
import { SecretDto } from './dtos/secret.dto';
import { DeleteDto } from '../../shared/dtos/delete.dto';

@Injectable()
export class SecretService {
  constructor(
    @InjectRepository(Secret)
    private readonly secretRepository: Repository<Secret>,
  ) {}

  private async getOne(id: number): Promise<Secret> {
    return this.secretRepository.findOneBy({ id });
  }

  getAll(): Observable<Secret[]> {
    return from(this.secretRepository.find());
  }

  create(dto: SecretDto): Observable<Secret> {
    return from(this.secretRepository.save(this.secretRepository.create(dto)));
  }

  change(id: number, dto: SecretDto): Observable<Secret> {
    return from(this.secretRepository.update({ id }, dto)).pipe(
      switchMap(() => from(this.getOne(id))),
    );
  }

  delete(id: number): Observable<DeleteDto> {
    return from(this.secretRepository.delete({ id })).pipe(map(() => ({ id })));
  }
}
