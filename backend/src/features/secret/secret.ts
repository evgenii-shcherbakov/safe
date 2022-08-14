import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';

@Entity()
export class Secret {
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
  url: string;

  @ApiProperty()
  @Column({ default: '' })
  email: string;

  @ApiProperty()
  @Column({ default: '' })
  phone: string;

  @ApiProperty()
  @Column({ default: '' })
  login: string;

  @ApiProperty()
  @Column({ default: '' })
  password: string;
}
