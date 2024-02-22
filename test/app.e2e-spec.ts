import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import * as pactum from 'pactum';
import { AppModule } from '@/module/app/app.module';
import { serverConfig } from '@/config';

const { SERVER_IP, SERVER_PORT, SERVER_PROTOCOL } = serverConfig();

describe('AppController (e2e)', () => {
    let app: INestApplication;

    beforeAll(async () => {
        const moduleFixture: TestingModule = await Test.createTestingModule({
            imports: [AppModule],
        }).compile();

        app = moduleFixture.createNestApplication();
        await app.init();
        await app.listen(SERVER_PORT);
        pactum.request.setBaseUrl(
            `${SERVER_PROTOCOL}://${SERVER_IP}:${SERVER_PORT}'`,
        );
    });

    afterAll(() => {
        app.close();
    });

    describe('Root', () => {
        it('Should return ok on /', () => {
            return pactum.spec().get('/').expectStatus(200);
        });
    });
});
