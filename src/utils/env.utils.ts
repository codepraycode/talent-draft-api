import { NodeEnvironment, ServerConfig, ServerEnvConfig } from '@/types';

/**
 * Check and make sure working environment is set
 * @return 	string The node environment
 */
export function workingEnv(): string {
    const currentEnv = process.env.NODE_ENV as NodeEnvironment;
    const envList = Object.values(NodeEnvironment);

    if (!envList.includes(currentEnv)) {
        const error = currentEnv
            ? 'Environment has to be either ' + String(envList)
            : 'NODE_ENV was not set';
        // TODO: log the error as a warning
        throw new Error(error);
    }
    // TODO: log indication
    return currentEnv;
}

/**
 * Check and make sure server configurations are set
 * @return 	string The server configurations
 */
export function checkServerEnv(): ServerConfig {
    const envList = Object.values(ServerEnvConfig);

    const configs = {};

    for (const item of envList) {
        const val = process.env[item];

        if (!val) {
            const error = `'${item}' was not provided`;
            // TODO: log the error as a warning
            throw new Error(error);
        }

        configs[item] = val;
    }

    // TODO: log indication
    return configs as ServerConfig;
}
