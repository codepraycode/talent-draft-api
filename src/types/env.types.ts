export enum NodeEnvironment {
    LOCAL = 'local',
    DEV = 'development',
    PRODUCTION = 'production',
    TEST = 'test',
}

export enum ServerEnvConfig {
    PORT = 'SERVER_PORT',
    IP = 'SERVER_IP',
    PROTOCOL = 'SERVER_PROTOCOL',
}
export type ServerConfig = Record<ServerEnvConfig, string>;
