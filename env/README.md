# Talent Draft API - Environment variables

Directory: `/env/*`

This directory is for managing configurations specific to environments

## Notes

Please create and env file for the working environment, files are:

- `.env.development` - For development environment.
- `.env.production` - For production environment.
- `.env.testing` - For testing.

This is determined by *NODE_ENV* environment variable, and a *.env* file is created in the root directory which serves as the configuration for the running context.

> Make sure to update the production server with the production environment variables manually.

For more information, reach out to @codepraycode.
