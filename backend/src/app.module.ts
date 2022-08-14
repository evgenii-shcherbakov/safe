import { Module } from '@nestjs/common';
import { APP_GUARD } from '@nestjs/core';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import { dbConfig } from './configs/db.config';
import { SecretModule } from './features/secret/secret.module';
import { AuthGuard } from './guards/auth.guard';
import { CardModule } from './features/card/card.module';

@Module({
  imports: [ConfigModule.forRoot(), TypeOrmModule.forRoot(dbConfig), SecretModule, CardModule],
  controllers: [AppController],
  providers: [
    AppService,
    {
      provide: APP_GUARD,
      useClass: AuthGuard,
    },
  ],
})
export class AppModule {}
