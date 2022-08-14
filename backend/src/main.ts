import { NestFactory } from '@nestjs/core';
import { SwaggerModule } from '@nestjs/swagger';

import { AppModule } from './app.module';
import { LOCAL_PORT } from './constants/common';
import { swaggerConfig } from './configs/swagger.config';

const port = process.env.PORT || LOCAL_PORT;

async function bootstrap() {
  const app = await NestFactory.create(AppModule, { cors: true });

  const apiDocument = SwaggerModule.createDocument(app, swaggerConfig);
  SwaggerModule.setup('', app, apiDocument);

  await app.listen(port, () => `Server started on ${port} port`);
}

bootstrap();
