# Talent Draft API - Environment variables

Directory: `/env/*`

This directory is for managing configurations specific to environments

## Overview

Environment files used for the working environment.

### Environment types

- `.env.development` - For development environment.
- `.env.production` - For production environment.
- `.env.testing` - For testing.

## How it works

A *.env* file is create in the root directory which is used by the app. Contents of *.env* file is determined by the environment variable file type used [as stated](#environment-types).

The app auto detects the environment and copies the corresponding configuratiosn. This is determined by *NODE_ENV* environment variable set during execution of the project, and a *.env* file is created in the root directory which serves as the configuration for the running context.

## Using the scripts

Certain scipts are available at `/scripts/dev` to automatically create and sync environment variables

### How to use the scripts

Scripts can be ran standalone, or using *npm*, there are

To create files according to [file types](#environment-types), use:

```bash
# Create environment variable
npm run env:create
```

To update or create `.env.example` file from your `.env.development` file

```bash
# Create/Update .env.example
npm run env:set-example
```

To send production configurations (i.e `.env.production`), use:

```bash
# Create/Update .env.example
npm run env:send
```

> Make sure to update the production server with the production environment variables manually.

For more information, reach out to @codepraycode.
