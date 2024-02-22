import { NodeEnvironment } from '@/types';

/**
 * Check and make sure working environment is set
 * @return 	string The node environment
 */
export function setEnv(): string {
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
