import { setEnv } from '@/utils/setEnv';
import * as dotenv from 'dotenv';

const env = setEnv();

export const envConfig = () => {
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    const options = { path: `env/.env.${env}` };
    // ? We're using the copy and past mechanism,
    // ?    otherwise pass options to config
    return dotenv.config();
};
