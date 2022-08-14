import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';

@Entity()
export class Card {
  @ApiProperty()
  @PrimaryGeneratedColumn()
  readonly id: number;

  @ApiProperty()
  @Column({ unique: true })
  name: string;

  @ApiProperty()
  @Column({ default: '' })
  description: string;

  @ApiProperty()
  @Column({ default: '' })
  type: string;

  @ApiProperty()
  @Column({ default: '' })
  number: string;

  @ApiProperty()
  @Column({ default: '' })
  vcc: string;

  @ApiProperty()
  @Column({ default: '' })
  pin: string;

  @ApiProperty()
  @Column({ default: '' })
  securityCode: string;

  @ApiProperty()
  @Column({ default: '' })
  expiredAt: string;

  @ApiProperty()
  @Column({ default: 0 })
  price: number;
}
