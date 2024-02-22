import { NestFactory } from '@nestjs/core';
import { AppModule } from './module/app/app.module';
import { serverConfig } from './config';

const { SERVER_PORT } = serverConfig();

async function bootstrap() {
    const app = await NestFactory.create(AppModule);
    await app.listen(SERVER_PORT);
}
bootstrap();
