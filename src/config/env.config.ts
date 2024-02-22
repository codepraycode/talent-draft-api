import { ServerConfig } from '@/types';
import { checkServerEnv, workingEnv } from '@/utils/env.utils';
import * as dotenv from 'dotenv';

/**
 * Load environment variables
 * @return dotenv.DotenvConfigOutput
 */
export const envConfig = () => {
    const env = workingEnv();
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    const options = { path: `env/.env.${env}` };
    // ? We're using the copy and past mechanism,
    // ?    otherwise pass options to config
    return dotenv.config();
};

/**
 * Returns configurations specific to server
 * @return 	ServerConfig
 */
export function serverConfig(): ServerConfig {
    envConfig();
    return checkServerEnv();
}
