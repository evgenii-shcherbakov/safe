import { Module } from '@nestjs/common';
import { SecretController } from './secret.controller';
import { SecretService } from './secret.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Secret } from './secret';

@Module({
  imports: [TypeOrmModule.forFeature([Secret])],
  controllers: [SecretController],
  providers: [SecretService],
})
export class SecretModule {}
