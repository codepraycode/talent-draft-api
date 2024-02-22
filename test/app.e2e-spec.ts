import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import * as pactum from 'pactum';
import { AppModule } from '@/module/app/app.module';

describe('AppController (e2e)', () => {
    let app: INestApplication;

    beforeAll(async () => {
        const moduleFixture: TestingModule = await Test.createTestingModule({
            imports: [AppModule],
        }).compile();

        app = moduleFixture.createNestApplication();
        await app.init();
        await app.listen(3333); // TODO: Make port dynamic
        pactum.request.setBaseUrl('http://localhost:3333'); // TODO: make url dynamic
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
