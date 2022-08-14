import { DocumentBuilder } from '@nestjs/swagger';

export const swaggerConfig = new DocumentBuilder()
  .setTitle('Safe api reference')
  .setDescription('The Safe API description')
  .setVersion('1.0')
  .build();
