# 🚀 EventsOS Fresh Implementation Guide - Complete Production Setup

## 📑 Table of Contents

1. [Project Overview](#project-overview)
2. [Progress Tracker](#progress-tracker)
3. [Phase 1: Core Monorepo Setup](#phase-1-core-monorepo-setup)
4. [Phase 2: Admin App (Refine + MUI)](#phase-2-admin-app-refine--mui)
5. [Phase 3: Website App (MUI Only)](#phase-3-website-app-mui-only)
6. [Phase 4: Vercel Configuration](#phase-4-vercel-configuration)
7. [Phase 5: Security & Performance](#phase-5-security--performance)
8. [Phase 6: Production Deployment](#phase-6-production-deployment)
9. [Production Readiness Checklist](#production-readiness-checklist)
10. [Troubleshooting](#troubleshooting)
11. [Error Prevention](#error-prevention)

---

## 🎯 Project Overview

**EventsOS**: AI-powered fashion event management platform with comprehensive multi-tenant architecture
**Starting Point**: Fresh empty directory `/home/sk/fx/eventos`
**Target Architecture**: Production-ready monorepo with best practices
**Database**: Existing Supabase with 60+ tables (project: wnjudgmhabzhcttgyxou)

### Technology Stack
- **Monorepo**: Turborepo v2.0.0 with pnpm workspaces
- **Admin Dashboard**: Refine v4.57.10 + Material-UI v6.5.0 + Supabase
- **Public Website**: Next.js 14 + Material-UI v6.5.0
- **Backend**: Supabase PostgreSQL + Auth + RLS + Real-time
- **Deployment**: Vercel with GitHub Actions CI/CD

### Key References
- [Material-UI v6 Documentation](https://v6.mui.com/material-ui/getting-started/installation/)
- [Material-UI Next.js Integration](https://v6.mui.com/material-ui/integrations/nextjs/)
- [Refine Documentation](https://refine.dev/docs/)
- [Supabase Documentation](https://supabase.com/docs)
- [Vercel Documentation](https://vercel.com/docs)

---

## 📊 Progress Tracker

| Phase | Task | Status | Owner | Completion % | Reference |
|-------|------|--------|-------|--------------|-----------|
| 1 | Monorepo Structure Setup | 🔴 Not Started | DevOps Lead | 0% | [Turborepo Docs](https://turbo.build/repo/docs) |
| 1 | Package Manager Configuration | 🔴 Not Started | DevOps Lead | 0% | [pnpm Workspaces](https://pnpm.io/workspaces) |
| 1 | TypeScript Configuration | 🔴 Not Started | Tech Lead | 0% | [TypeScript Docs](https://www.typescriptlang.org/docs/) |
| 1 | Environment Setup | 🔴 Not Started | Tech Lead | 0% | [T3 Env](https://env.t3.gg/) |
| 2 | Refine Admin Setup | ⚠️ Pending | Frontend Lead | 0% | [Refine Quick Start](https://refine.dev/docs/getting-started/quickstart/) |
| 2 | MUI v6 Integration | ⚠️ Pending | Frontend Lead | 0% | [MUI Refine Integration](https://refine.dev/docs/ui-integrations/material-ui/introduction/) |
| 2 | Supabase Data Provider | ⚠️ Pending | Backend Lead | 0% | [Refine Supabase](https://refine.dev/docs/data/packages/supabase/) |
| 3 | Website Next.js Setup | 🟡 Future | Frontend Lead | 0% | [Next.js 14 Docs](https://nextjs.org/docs) |
| 3 | MUI v6 Website Integration | 🟡 Future | Frontend Lead | 0% | [MUI Next.js Example](https://github.com/mui/material-ui/tree/v6.x/examples/material-ui-nextjs-ts) |
| 4 | Vercel Project Configuration | 🟡 Future | DevOps Lead | 0% | [Vercel Monorepo](https://vercel.com/docs/monorepos) |
| 5 | Security Hardening | 🟡 Future | Security Lead | 0% | [Security Best Practices](https://vercel.com/docs/security) |
| 6 | Production Deployment | 🟡 Future | Platform Lead | 0% | [Vercel Deployment](https://vercel.com/docs/deployments) |

---

## 🏗️ Phase 1: Core Monorepo Setup

### Phase Overview
Establish the foundational monorepo structure with Turborepo, configure package management with pnpm, set up TypeScript, and create environment validation.

---

### Task 1.1: Initialize Monorepo Structure

**Purpose**: Create the foundational directory structure and workspace configuration for EventsOS monorepo

**Dependencies**: Fresh directory `/home/sk/fx/eventos`

**Reference Links**:
- [Turborepo Handbook](https://turbo.build/repo/docs/handbook)
- [pnpm Workspace Configuration](https://pnpm.io/workspaces)

**Step-by-Step Instructions**:

1. **Navigate to Project Directory**
   - Change to the empty project directory
   - Verify directory is clean and ready for initialization

2. **Initialize Git Repository**
   - Initialize git repository for version control
   - Create initial commit structure
   - Set up proper git configuration

3. **Create Monorepo Directory Structure**
   - Create applications directory for main apps
   - Create packages directory for shared libraries
   - Create configuration directories for tools and scripts

4. **Initialize Package Manager Configuration**
   - Create pnpm workspace configuration file
   - Set up package resolution and dependency management
   - Configure workspace-level scripts and commands

5. **Create Root Package Configuration**
   - Initialize root package.json with workspace configuration
   - Set up monorepo management scripts
   - Configure package manager version constraints

**Commands**:
```bash
# Navigate to project directory
cd /home/sk/fx/eventos

# Initialize git repository
git init
git config user.name "EventsOS Team"
git config user.email "team@eventos.dev"

# Create monorepo structure
mkdir -p apps/{admin,website}
mkdir -p packages/{ui,types,utils,database}
mkdir -p docs
mkdir -p scripts

# Create pnpm workspace configuration
cat > pnpm-workspace.yaml << 'EOF'
packages:
  - 'apps/*'
  - 'packages/*'
EOF

# Initialize root package.json
pnpm init

# Create initial .gitignore
cat > .gitignore << 'EOF'
# Dependencies
node_modules
.pnp
.pnp.js

# Testing
coverage
.nyc_output

# Next.js
.next/
out/
build
dist

# Production
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.pnpm-debug.log*

# Environment
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Vercel
.vercel

# Typescript
*.tsbuildinfo

# Turbo
.turbo

# IDE
.vscode/*
!.vscode/extensions.json
.idea
.DS_Store

# Supabase
**/supabase/.branches
**/supabase/.temp
EOF

# Create README.md
cat > README.md << 'EOF'
# EventsOS - AI-Powered Event Management Platform

A comprehensive event management platform built with modern technologies.

## Apps
- **Admin**: Refine + Material-UI v6 admin dashboard
- **Website**: Next.js 14 + Material-UI v6 public website

## Packages
- **UI**: Shared UI components
- **Types**: TypeScript type definitions
- **Utils**: Utility functions
- **Database**: Supabase client and types

## Getting Started
```bash
pnpm install
pnpm dev
```
EOF
```

**Success Criteria**:
- ✅ Directory structure created correctly
- ✅ pnpm workspace configuration valid
- ✅ Git repository initialized with proper configuration
- ✅ Root package.json created

**Validation Tests**:
```bash
# Verify directory structure
ls -la apps/ packages/

# Validate pnpm workspace
pnpm list --depth=0

# Check git status
git status
```

---

### Task 1.2: Package Manager and Turborepo Configuration

**Purpose**: Configure pnpm package manager with proper version constraints and install Turborepo for monorepo build orchestration

**Dependencies**: Task 1.1 completed successfully

**Reference Links**:
- [Turborepo Installation](https://turbo.build/repo/docs/installing)
- [Turborepo Configuration](https://turbo.build/repo/docs/core-concepts/monorepos/configuring-workspaces)
- [pnpm Package Management](https://pnpm.io/package_json)

**Step-by-Step Instructions**:

1. **Configure Root Package.json**
   - Set up package metadata and version constraints
   - Configure workspace-level scripts
   - Add engine requirements for Node.js and pnpm

2. **Install Turborepo**
   - Add Turborepo as development dependency
   - Configure Turborepo pipeline for build orchestration
   - Set up caching and dependency management

3. **Create Turborepo Configuration**
   - Define build pipeline with proper task dependencies
   - Configure caching strategy for optimal performance
   - Set up environment variable handling

4. **Configure Package Manager Settings**
   - Create .npmrc for consistent package resolution
   - Set up proper dependency hoisting
   - Configure registry and authentication settings

5. **Set Up Development Scripts**
   - Create development workflow scripts
   - Add build and test orchestration
   - Configure workspace management commands

**Commands**:
```bash
# Update root package.json with proper configuration
cat > package.json << 'EOF'
{
  "name": "eventos",
  "version": "0.0.1",
  "private": true,
  "packageManager": "pnpm@8.15.1",
  "engines": {
    "node": ">=18.0.0",
    "pnpm": ">=8.0.0"
  },
  "scripts": {
    "dev": "turbo run dev",
    "build": "turbo run build",
    "start": "turbo run start",
    "lint": "turbo run lint",
    "type-check": "turbo run type-check",
    "test": "turbo run test",
    "test:e2e": "turbo run test:e2e",
    "clean": "turbo run clean",
    "format": "prettier --write \"**/*.{ts,tsx,md}\"",
    "vercel-build": "turbo run build --filter=@eventos/website"
  },
  "devDependencies": {
    "turbo": "^2.0.0",
    "prettier": "^3.2.5",
    "typescript": "^5.3.3",
    "@types/node": "^20.11.5"
  }
}
EOF

# Install dependencies
pnpm install

# Create Turborepo configuration
cat > turbo.json << 'EOF'
{
  "$schema": "https://turbo.build/schema.json",
  "ui": "tui",
  "tasks": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": [".next/**", "!.next/cache/**", "dist/**"],
      "env": [
        "NEXT_PUBLIC_SUPABASE_URL",
        "NEXT_PUBLIC_SUPABASE_ANON_KEY",
        "VERCEL_ENV"
      ]
    },
    "dev": {
      "cache": false,
      "persistent": true
    },
    "lint": {
      "dependsOn": ["^build"]
    },
    "type-check": {
      "dependsOn": ["^build"]
    },
    "test": {
      "dependsOn": ["^build"]
    },
    "test:e2e": {
      "dependsOn": ["build"]
    },
    "clean": {
      "cache": false
    }
  }
}
EOF

# Create .npmrc for package manager configuration
cat > .npmrc << 'EOF'
engine-strict=true
auto-install-peers=true
shamefully-hoist=false
strict-peer-dependencies=false
prefer-frozen-lockfile=true
EOF

# Create environment template
cat > .env.example << 'EOF'
# Supabase Configuration
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key

# App URLs
NEXT_PUBLIC_APP_URL=https://eventos.vercel.app
NEXT_PUBLIC_ADMIN_URL=https://admin.eventos.vercel.app

# Vercel
VERCEL_ENV=development
VERCEL_GIT_COMMIT_SHA=
VERCEL_GIT_COMMIT_MESSAGE=

# Optional Services
SENDGRID_API_KEY=
OPENAI_API_KEY=
ANTHROPIC_API_KEY=
EOF
```

**Success Criteria**:
- ✅ Turborepo v2.0.0 installed and configured
- ✅ Package manager constraints enforced
- ✅ Build pipeline defined with proper dependencies
- ✅ Environment template created

**Validation Tests**:
```bash
# Verify Turborepo installation
pnpm turbo --version

# Validate configuration
pnpm turbo build --dry-run

# Check package manager
pnpm --version
```

---

### Task 1.3: TypeScript and Shared Packages Setup

**Purpose**: Configure TypeScript with strict settings and create shared packages for UI components, types, utilities, and database client

**Dependencies**: Task 1.2 completed successfully

**Reference Links**:
- [TypeScript Configuration](https://www.typescriptlang.org/docs/handbook/tsconfig-json.html)
- [TypeScript Monorepo Setup](https://turbo.build/repo/docs/handbook/linting/typescript)

**Step-by-Step Instructions**:

1. **Create Root TypeScript Configuration**
   - Set up base TypeScript configuration for the monorepo
   - Configure strict type checking and modern target
   - Set up path mapping and module resolution

2. **Initialize Shared Packages**
   - Create UI package for shared components
   - Set up types package for TypeScript definitions
   - Create utils package for utility functions
   - Initialize database package for Supabase client

3. **Configure Package TypeScript Settings**
   - Create individual tsconfig.json for each package
   - Set up proper compilation targets and module formats
   - Configure build outputs and declaration generation

4. **Set Up Package Build Configuration**
   - Install and configure tsup for package bundling
   - Set up build scripts for each shared package
   - Configure proper entry points and exports

5. **Create Package Templates**
   - Add basic package structure and exports
   - Create index files for each package
   - Set up proper package.json configurations

**Commands**:
```bash
# Create root TypeScript configuration
cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "es2022",
    "lib": ["dom", "dom.iterable", "es6"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "baseUrl": ".",
    "paths": {
      "@eventos/ui": ["./packages/ui/src"],
      "@eventos/types": ["./packages/types/src"],
      "@eventos/utils": ["./packages/utils/src"],
      "@eventos/database": ["./packages/database/src"]
    }
  },
  "include": ["**/*.ts", "**/*.tsx"],
  "exclude": ["node_modules", ".next", "dist"]
}
EOF

# Initialize packages/ui
cd packages/ui
pnpm init
cat > package.json << 'EOF'
{
  "name": "@eventos/ui",
  "version": "0.0.1",
  "private": true,
  "main": "./dist/index.js",
  "types": "./dist/index.d.ts",
  "exports": {
    ".": {
      "types": "./dist/index.d.ts",
      "default": "./dist/index.js"
    }
  },
  "scripts": {
    "build": "tsup",
    "dev": "tsup --watch",
    "clean": "rm -rf dist",
    "lint": "eslint src/",
    "type-check": "tsc --noEmit"
  },
  "devDependencies": {
    "tsup": "^8.0.0",
    "typescript": "^5.3.3",
    "@types/react": "^18.2.48",
    "@types/react-dom": "^18.2.18"
  },
  "peerDependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  }
}
EOF

mkdir -p src
cat > src/index.ts << 'EOF'
export * from './components';
export * from './theme';
export * from './utils';
EOF

mkdir -p src/components src/theme src/utils
touch src/components/index.ts src/theme/index.ts src/utils/index.ts

cat > tsconfig.json << 'EOF'
{
  "extends": "../../tsconfig.json",
  "compilerOptions": {
    "outDir": "./dist",
    "rootDir": "./src"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
EOF

cat > tsup.config.ts << 'EOF'
import { defineConfig } from 'tsup'

export default defineConfig({
  entry: ['src/index.ts'],
  format: ['cjs', 'esm'],
  dts: true,
  splitting: false,
  sourcemap: true,
  clean: true,
  external: ['react', 'react-dom']
})
EOF

# Initialize packages/types
cd ../types
pnpm init
cat > package.json << 'EOF'
{
  "name": "@eventos/types",
  "version": "0.0.1",
  "private": true,
  "main": "./dist/index.js",
  "types": "./dist/index.d.ts",
  "exports": {
    ".": {
      "types": "./dist/index.d.ts",
      "default": "./dist/index.js"
    }
  },
  "scripts": {
    "build": "tsup",
    "dev": "tsup --watch",
    "clean": "rm -rf dist",
    "type-check": "tsc --noEmit"
  },
  "devDependencies": {
    "tsup": "^8.0.0",
    "typescript": "^5.3.3"
  }
}
EOF

mkdir -p src
cat > src/index.ts << 'EOF'
export * from './database';
export * from './api';
export * from './common';
EOF

mkdir -p src/database src/api src/common
touch src/database/index.ts src/api/index.ts src/common/index.ts

cp ../ui/tsconfig.json .
cp ../ui/tsup.config.ts .

# Initialize packages/utils
cd ../utils
pnpm init
cat > package.json << 'EOF'
{
  "name": "@eventos/utils",
  "version": "0.0.1",
  "private": true,
  "main": "./dist/index.js",
  "types": "./dist/index.d.ts",
  "exports": {
    ".": {
      "types": "./dist/index.d.ts",
      "default": "./dist/index.js"
    }
  },
  "scripts": {
    "build": "tsup",
    "dev": "tsup --watch",
    "clean": "rm -rf dist",
    "lint": "eslint src/",
    "type-check": "tsc --noEmit"
  },
  "devDependencies": {
    "tsup": "^8.0.0",
    "typescript": "^5.3.3"
  }
}
EOF

mkdir -p src
cat > src/index.ts << 'EOF'
export * from './auth';
export * from './formatting';
export * from './validation';
export * from './constants';
EOF

mkdir -p src/auth src/formatting src/validation src/constants
touch src/auth/index.ts src/formatting/index.ts src/validation/index.ts src/constants/index.ts

cp ../ui/tsconfig.json .
cp ../ui/tsup.config.ts .

# Initialize packages/database
cd ../database
pnpm init
cat > package.json << 'EOF'
{
  "name": "@eventos/database",
  "version": "0.0.1",
  "private": true,
  "main": "./dist/index.js",
  "types": "./dist/index.d.ts",
  "exports": {
    ".": {
      "types": "./dist/index.d.ts",
      "default": "./dist/index.js"
    }
  },
  "scripts": {
    "build": "tsup",
    "dev": "tsup --watch",
    "clean": "rm -rf dist",
    "type-check": "tsc --noEmit",
    "generate-types": "supabase gen types typescript --local > src/types/database.ts"
  },
  "dependencies": {
    "@supabase/supabase-js": "^2.39.3"
  },
  "devDependencies": {
    "tsup": "^8.0.0",
    "typescript": "^5.3.3"
  }
}
EOF

mkdir -p src/types
cat > src/index.ts << 'EOF'
export * from './client';
export * from './types';
export * from './queries';
export * from './mutations';
EOF

mkdir -p src/client src/queries src/mutations
touch src/client/index.ts src/types/index.ts src/queries/index.ts src/mutations/index.ts

cp ../ui/tsconfig.json .
cp ../ui/tsup.config.ts .

# Return to root and install package dependencies
cd ../../
pnpm install
```

**Success Criteria**:
- ✅ TypeScript configuration with strict settings
- ✅ All shared packages initialized with proper structure
- ✅ Build system configured with tsup
- ✅ Package exports and imports working

**Validation Tests**:
```bash
# Build all packages
pnpm turbo build --filter=packages/*

# Type check all packages
pnpm turbo type-check

# Verify package structure
ls -la packages/*/dist/
```

---

### Task 1.4: Environment Validation and Security Setup

**Purpose**: Implement type-safe environment variable validation using T3 Env and set up security foundations

**Dependencies**: Task 1.3 completed successfully

**Reference Links**:
- [T3 Environment Variables](https://env.t3.gg/)
- [Zod Validation](https://zod.dev/)
- [Next.js Environment Variables](https://nextjs.org/docs/app/building-your-application/configuring/environment-variables)

**Step-by-Step Instructions**:

1. **Install Environment Validation Dependencies**
   - Add T3 Env for type-safe environment validation
   - Install Zod for schema validation
   - Configure validation as workspace dependency

2. **Create Environment Schema Package**
   - Create packages/env for shared environment validation
   - Define comprehensive environment variable schema
   - Set up client and server environment separation

3. **Configure Environment Validation**
   - Create schema for all required environment variables
   - Add validation for URL formats and API keys
   - Set up runtime validation with helpful error messages

4. **Set Up Security Configuration**
   - Create security utility functions
   - Configure content security policy helpers
   - Set up rate limiting utilities

5. **Create Documentation**
   - Document all environment variables
   - Create setup instructions
   - Add troubleshooting guide

**Commands**:
```bash
# Install environment validation dependencies
pnpm add @t3-oss/env-nextjs zod --workspace-root

# Create packages/env
cd packages
mkdir env
cd env
pnpm init

cat > package.json << 'EOF'
{
  "name": "@eventos/env",
  "version": "0.0.1",
  "private": true,
  "main": "./dist/index.js",
  "types": "./dist/index.d.ts",
  "exports": {
    ".": {
      "types": "./dist/index.d.ts",
      "default": "./dist/index.js"
    }
  },
  "scripts": {
    "build": "tsup",
    "dev": "tsup --watch",
    "clean": "rm -rf dist",
    "type-check": "tsc --noEmit"
  },
  "dependencies": {
    "@t3-oss/env-nextjs": "^0.7.1",
    "zod": "^3.22.4"
  },
  "devDependencies": {
    "tsup": "^8.0.0",
    "typescript": "^5.3.3"
  }
}
EOF

mkdir -p src
cat > src/index.ts << 'EOF'
import { createEnv } from "@t3-oss/env-nextjs";
import { z } from "zod";

export const env = createEnv({
  /**
   * Specify your server-side environment variables schema here. This way you can ensure the app
   * isn't built with invalid env vars.
   */
  server: {
    SUPABASE_SERVICE_ROLE_KEY: z.string().min(1),
    SENDGRID_API_KEY: z.string().optional(),
    OPENAI_API_KEY: z.string().optional(),
    ANTHROPIC_API_KEY: z.string().optional(),
  },

  /**
   * Specify your client-side environment variables schema here. This way you can ensure the app
   * isn't built with invalid env vars. To expose them to the client, prefix them with
   * `NEXT_PUBLIC_`.
   */
  client: {
    NEXT_PUBLIC_SUPABASE_URL: z.string().url(),
    NEXT_PUBLIC_SUPABASE_ANON_KEY: z.string().min(1),
    NEXT_PUBLIC_APP_URL: z.string().url(),
    NEXT_PUBLIC_ADMIN_URL: z.string().url().optional(),
    NEXT_PUBLIC_VERCEL_ENV: z.enum(["development", "preview", "production"]).optional(),
  },

  /**
   * You can't destruct `process.env` as a regular object in the Next.js edge runtimes (e.g.
   * middlewares) or client-side so we need to destruct manually.
   */
  runtimeEnv: {
    SUPABASE_SERVICE_ROLE_KEY: process.env.SUPABASE_SERVICE_ROLE_KEY,
    SENDGRID_API_KEY: process.env.SENDGRID_API_KEY,
    OPENAI_API_KEY: process.env.OPENAI_API_KEY,
    ANTHROPIC_API_KEY: process.env.ANTHROPIC_API_KEY,
    NEXT_PUBLIC_SUPABASE_URL: process.env.NEXT_PUBLIC_SUPABASE_URL,
    NEXT_PUBLIC_SUPABASE_ANON_KEY: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
    NEXT_PUBLIC_APP_URL: process.env.NEXT_PUBLIC_APP_URL,
    NEXT_PUBLIC_ADMIN_URL: process.env.NEXT_PUBLIC_ADMIN_URL,
    NEXT_PUBLIC_VERCEL_ENV: process.env.NEXT_PUBLIC_VERCEL_ENV,
  },
  /**
   * Run `build` or `dev` with SKIP_ENV_VALIDATION to skip env validation. This is especially
   * useful for Docker builds.
   */
  skipValidation: !!process.env.SKIP_ENV_VALIDATION,
  /**
   * Makes it so that empty strings are treated as undefined. `SOME_VAR: z.string()` and
   * `SOME_VAR=''` will throw an error.
   */
  emptyStringAsUndefined: true,
});
EOF

cat > tsconfig.json << 'EOF'
{
  "extends": "../../tsconfig.json",
  "compilerOptions": {
    "outDir": "./dist",
    "rootDir": "./src"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
EOF

cat > tsup.config.ts << 'EOF'
import { defineConfig } from 'tsup'

export default defineConfig({
  entry: ['src/index.ts'],
  format: ['cjs', 'esm'],
  dts: true,
  splitting: false,
  sourcemap: true,
  clean: true,
})
EOF

# Create security utilities
cd ../utils/src
mkdir security
cat > security/index.ts << 'EOF'
export * from './headers';
export * from './rateLimit';
export * from './validation';
EOF

cat > security/headers.ts << 'EOF'
export const securityHeaders = {
  'Content-Security-Policy': `
    default-src 'self';
    script-src 'self' 'unsafe-eval' 'unsafe-inline' *.vercel-insights.com *.vercel.app;
    style-src 'self' 'unsafe-inline' fonts.googleapis.com;
    font-src 'self' fonts.gstatic.com;
    img-src 'self' data: https: blob:;
    media-src 'self';
    connect-src 'self' *.supabase.co *.vercel-insights.com wss://*.supabase.co;
    frame-ancestors 'none';
    base-uri 'self';
    form-action 'self';
    upgrade-insecure-requests;
  `.replace(/\n/g, ' ').trim(),
  'X-Content-Type-Options': 'nosniff',
  'X-Frame-Options': 'DENY',
  'X-XSS-Protection': '1; mode=block',
  'Referrer-Policy': 'strict-origin-when-cross-origin',
  'Permissions-Policy': 'camera=(), microphone=(), geolocation=()',
  'Strict-Transport-Security': 'max-age=31536000; includeSubDomains; preload',
};

export const getCspNonce = (): string => {
  return Buffer.from(crypto.randomUUID()).toString('base64');
};
EOF

cat > security/rateLimit.ts << 'EOF'
interface RateLimitOptions {
  uniqueTokenPerInterval?: number;
  interval?: number;
}

export class RateLimit {
  private cache = new Map<string, number[]>();
  private options: Required<RateLimitOptions>;

  constructor(options: RateLimitOptions = {}) {
    this.options = {
      uniqueTokenPerInterval: options.uniqueTokenPerInterval || 500,
      interval: options.interval || 60000,
    };
  }

  check(limit: number, token: string): boolean {
    const now = Date.now();
    const tokenCount = this.cache.get(token) || [0, now];
    
    if (now - tokenCount[1] > this.options.interval) {
      tokenCount[0] = 1;
      tokenCount[1] = now;
    } else {
      tokenCount[0]++;
    }

    this.cache.set(token, tokenCount);
    
    return tokenCount[0] <= limit;
  }
}
EOF

cat > security/validation.ts << 'EOF'
export const validateEmail = (email: string): boolean => {
  const emailRegex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
  return emailRegex.test(email);
};

export const validateUrl = (url: string): boolean => {
  try {
    new URL(url);
    return true;
  } catch {
    return false;
  }
};

export const sanitizeInput = (input: string): string => {
  return input.replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '');
};
EOF

# Update utils index to include security
cd ..
cat > index.ts << 'EOF'
export * from './auth';
export * from './formatting';
export * from './validation';
export * from './constants';
export * from './security';
EOF

# Create documentation
cd ../../../docs
mkdir -p environment security

cat > environment/README.md << 'EOF'
# Environment Configuration

## Required Environment Variables

### Supabase Configuration
- `NEXT_PUBLIC_SUPABASE_URL`: Your Supabase project URL
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`: Your Supabase anonymous key
- `SUPABASE_SERVICE_ROLE_KEY`: Your Supabase service role key (server-side only)

### Application URLs
- `NEXT_PUBLIC_APP_URL`: The main application URL
- `NEXT_PUBLIC_ADMIN_URL`: The admin dashboard URL (optional)

### Optional Services
- `SENDGRID_API_KEY`: For email notifications
- `OPENAI_API_KEY`: For AI features
- `ANTHROPIC_API_KEY`: For AI features

## Setup Instructions

1. Copy `.env.example` to `.env.local`
2. Fill in all required values
3. Run `pnpm build` to validate configuration

## Validation

Environment variables are validated at build time using Zod schemas. Invalid configurations will prevent the application from building.
EOF

cat > security/README.md << 'EOF'
# Security Configuration

## Security Headers

EventsOS implements comprehensive security headers including:
- Content Security Policy (CSP)
- X-Frame-Options
- X-Content-Type-Options
- Strict Transport Security

## Rate Limiting

API endpoints are protected with rate limiting to prevent abuse.

## Input Validation

All user inputs are validated and sanitized to prevent XSS and injection attacks.
EOF

# Return to root and install dependencies
cd ..
pnpm install
```

**Success Criteria**:
- ✅ Environment validation configured with T3 Env
- ✅ Security utilities created and configured
- ✅ Documentation created for setup and security
- ✅ Build-time validation working

**Validation Tests**:
```bash
# Test environment validation
SKIP_ENV_VALIDATION=true pnpm turbo build --filter=packages/env

# Build all packages
pnpm turbo build --filter=packages/*

# Verify security utilities
node -e "console.log(require('./packages/utils/dist').securityHeaders)"
```

---

## 🎨 Phase 2: Admin App (Refine + MUI)

### Phase Overview
Create the admin dashboard application using Refine framework with Material-UI v6, integrate Supabase data provider, and configure authentication.

---

### Task 2.1: Initialize Refine Admin Application

**Purpose**: Set up the admin dashboard application with Refine framework, Next.js 14 App Router, and Material-UI v6 integration

**Dependencies**: Phase 1 completed successfully

**Reference Links**:
- [Refine Quick Start](https://refine.dev/docs/getting-started/quickstart/)
- [Refine Material-UI Integration](https://refine.dev/docs/ui-integrations/material-ui/introduction/)
- [Material-UI Next.js Integration](https://v6.mui.com/material-ui/integrations/nextjs/)
- [Refine Next.js Router](https://www.npmjs.com/package/@refinedev/nextjs-router)

**Step-by-Step Instructions**:

1. **Initialize Admin Application Structure**
   - Create Next.js 14 application with App Router
   - Set up proper directory structure for admin dashboard
   - Configure TypeScript with strict settings

2. **Install Refine and Material-UI Dependencies**
   - Install Refine core and Next.js router integration
   - Add Material-UI v6 components and styling
   - Install Supabase data provider and authentication

3. **Configure Next.js Application**
   - Set up next.config.js with proper transpilation
   - Configure TypeScript with path mappings
   - Set up proper build and development scripts

4. **Create Refine Application Bootstrap**
   - Initialize Refine with Material-UI provider
   - Configure routing with Next.js App Router
   - Set up authentication provider with Supabase

5. **Set Up Material-UI Theme Integration**
   - Configure Material-UI theme with Refine
   - Set up SSR-compatible styling
   - Create custom theme for EventsOS branding

**Commands**:
```bash
# Navigate to admin app directory
cd apps/admin

# Initialize Next.js application
pnpm init

# Configure admin package.json
cat > package.json << 'EOF'
{
  "name": "@eventos/admin",
  "version": "0.0.1",
  "private": true,
  "scripts": {
    "dev": "next dev -p 3001",
    "build": "next build",
    "start": "next start -p 3001",
    "lint": "next lint",
    "type-check": "tsc --noEmit",
    "clean": "rm -rf .next .turbo node_modules"
  }
}
EOF

# Install Next.js and React dependencies
pnpm add next@14.2.29 react@18.2.0 react-dom@18.2.0

# Install TypeScript dependencies
pnpm add -D typescript@5.3.3 @types/react@18.2.48 @types/react-dom@18.2.18 @types/node@20.11.5

# Install Material-UI v6 dependencies
pnpm add @mui/material@6.5.0 @emotion/react@11.11.3 @emotion/styled@11.11.0
pnpm add @mui/material-nextjs@6.5.0
pnpm add @mui/x-data-grid@7.22.2
pnpm add @mui/lab@6.0.0-beta.21
pnpm add @mui/icons-material@6.5.0

# Install Refine dependencies
pnpm add @refinedev/core@4.57.10
pnpm add @refinedev/nextjs-router@6.0.4
pnpm add @refinedev/mui@6.2.2
pnpm add @refinedev/supabase@6.0.6
pnpm add @refinedev/react-hook-form@4.9.4

# Install additional dependencies
pnpm add react-hook-form@7.49.3
pnpm add @fontsource/roboto@5.0.8
pnpm add @supabase/supabase-js@2.39.3

# Install development dependencies
pnpm add -D @refinedev/cli@2.16.46 eslint@8.56.0 eslint-config-next@14.2.29

# Create directory structure
mkdir -p src/{app,components,providers,hooks,utils,lib,theme,types}
mkdir -p src/app/{dashboard,api}
mkdir -p src/app/dashboard/{events,attendees,sponsors,analytics,settings}
mkdir -p src/app/(auth)/{login,register,forgot-password}
mkdir -p public

# Create Next.js configuration
cat > next.config.mjs << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  transpilePackages: [
    '@refinedev/mui',
    '@refinedev/core',
    '@refinedev/nextjs-router',
    '@mui/material',
    '@mui/x-data-grid',
    '@mui/icons-material'
  ],
  experimental: {
    serverComponentsExternalPackages: ['@supabase/supabase-js']
  },
  images: {
    domains: ['localhost', 'wnjudgmhabzhcttgyxou.supabase.co'],
  },
  async headers() {
    return [
      {
        source: '/:path*',
        headers: [
          {
            key: 'X-Frame-Options',
            value: 'DENY',
          },
          {
            key: 'X-Content-Type-Options',
            value: 'nosniff',
          },
          {
            key: 'X-XSS-Protection',
            value: '1; mode=block',
          },
          {
            key: 'Referrer-Policy',
            value: 'strict-origin-when-cross-origin',
          },
          {
            key: 'Permissions-Policy',
            value: 'camera=(), microphone=(), geolocation=()',
          },
        ],
      },
    ];
  },
}

export default nextConfig
EOF

# Create TypeScript configuration
cat > tsconfig.json << 'EOF'
{
  "extends": "../../tsconfig.json",
  "compilerOptions": {
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./src/*"],
      "@eventos/ui": ["../../packages/ui/src"],
      "@eventos/types": ["../../packages/types/src"],
      "@eventos/utils": ["../../packages/utils/src"],
      "@eventos/database": ["../../packages/database/src"],
      "@eventos/env": ["../../packages/env/src"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
EOF

# Create ESLint configuration
cat > .eslintrc.json << 'EOF'
{
  "extends": ["next/core-web-vitals"]
}
EOF

# Create environment file
cat > .env.local << 'EOF'
# Copy values from root .env.example
NEXT_PUBLIC_SUPABASE_URL=https://wnjudgmhabzhcttgyxou.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=
NEXT_PUBLIC_APP_URL=http://localhost:3001
EOF
```

**Success Criteria**:
- ✅ Next.js 14 application initialized with App Router
- ✅ All Refine and Material-UI dependencies installed
- ✅ TypeScript configuration with proper path mappings
- ✅ Development server can start on port 3001

**Validation Tests**:
```bash
# Verify installation
pnpm list @refinedev/core @mui/material

# Type check
pnpm type-check

# Start development server
pnpm dev
```

---

### Task 2.2: Configure Material-UI v6 with SSR Support

**Purpose**: Set up Material-UI v6 with proper server-side rendering support, emotion cache configuration, and theme integration

**Dependencies**: Task 2.1 completed successfully

**Reference Links**:
- [Material-UI Next.js App Router](https://v6.mui.com/material-ui/integrations/nextjs/)
- [Material-UI SSR Setup](https://github.com/mui/material-ui/tree/v6.x/examples/material-ui-nextjs-ts)
- [Emotion Cache Configuration](https://emotion.sh/docs/ssr)

**Step-by-Step Instructions**:

1. **Create Emotion Cache Configuration**
   - Set up client-side emotion cache
   - Configure server-side rendering cache
   - Create cache provider for proper SSR hydration

2. **Set Up Theme Provider**
   - Create custom Material-UI theme for EventsOS
   - Configure theme with proper TypeScript types
   - Set up dark/light mode support

3. **Configure Root Layout**
   - Set up Material-UI cache provider in layout
   - Add font loading and CSS baseline
   - Configure proper SSR hydration

4. **Create Theme Configuration**
   - Define EventsOS brand colors and typography
   - Configure component overrides
   - Set up responsive breakpoints

5. **Test SSR Compatibility**
   - Verify no hydration mismatches
   - Test theme switching functionality
   - Validate font loading optimization

**Commands**:
```bash
# Install additional Material-UI SSR dependencies
pnpm add @emotion/cache @emotion/server

# Create theme configuration
mkdir -p src/theme
cat > src/theme/index.ts << 'EOF'
import { createTheme, ThemeOptions } from '@mui/material/styles';

declare module '@mui/material/styles' {
  interface Theme {
    eventos: {
      colors: {
        primary: string;
        secondary: string;
        accent: string;
      };
    };
  }

  interface ThemeOptions {
    eventos?: {
      colors?: {
        primary?: string;
        secondary?: string;
        accent?: string;
      };
    };
  }
}

const themeOptions: ThemeOptions = {
  palette: {
    mode: 'light',
    primary: {
      main: '#1976d2',
      light: '#42a5f5',
      dark: '#1565c0',
    },
    secondary: {
      main: '#dc004e',
      light: '#ff6b9d',
      dark: '#c51162',
    },
    background: {
      default: '#fafafa',
      paper: '#ffffff',
    },
  },
  typography: {
    fontFamily: 'Roboto, "Helvetica Neue", Arial, sans-serif',
    h1: {
      fontSize: '2.5rem',
      fontWeight: 600,
    },
    h2: {
      fontSize: '2rem',
      fontWeight: 600,
    },
    h3: {
      fontSize: '1.75rem',
      fontWeight: 600,
    },
  },
  eventos: {
    colors: {
      primary: '#1976d2',
      secondary: '#dc004e',
      accent: '#ff9800',
    },
  },
  components: {
    MuiButton: {
      styleOverrides: {
        root: {
          textTransform: 'none',
          borderRadius: '8px',
        },
      },
    },
    MuiCard: {
      styleOverrides: {
        root: {
          borderRadius: '12px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
        },
      },
    },
  },
};

export const theme = createTheme(themeOptions);
EOF

# Create emotion cache utilities
cat > src/lib/createEmotionCache.ts << 'EOF'
import createCache from '@emotion/cache';

const isBrowser = typeof document !== 'undefined';

// On the client side, Create a meta tag at the top of the <head> and set it as insertionPoint.
// This assures that MUI styles are loaded first.
// It allows developers to easily override MUI styles with other styling solutions, like CSS modules.
export default function createEmotionCache() {
  let insertionPoint;

  if (isBrowser) {
    const emotionInsertionPoint = document.querySelector<HTMLMetaElement>(
      'meta[name="emotion-insertion-point"]',
    );
    insertionPoint = emotionInsertionPoint ?? undefined;
  }

  return createCache({ key: 'mui-style', insertionPoint });
}
EOF

# Create theme provider
cat > src/providers/ThemeProvider.tsx << 'EOF'
'use client';

import * as React from 'react';
import { ThemeProvider as MuiThemeProvider } from '@mui/material/styles';
import CssBaseline from '@mui/material/CssBaseline';
import { theme } from '@/theme';

interface ThemeProviderProps {
  children: React.ReactNode;
}

export function ThemeProvider({ children }: ThemeProviderProps) {
  return (
    <MuiThemeProvider theme={theme}>
      <CssBaseline />
      {children}
    </MuiThemeProvider>
  );
}
EOF

# Create root layout
cat > src/app/layout.tsx << 'EOF'
import * as React from 'react';
import { AppRouterCacheProvider } from '@mui/material-nextjs/v15-appRouter';
import { ThemeProvider } from '@/providers/ThemeProvider';
import type { Metadata } from 'next';
import '@fontsource/roboto/300.css';
import '@fontsource/roboto/400.css';
import '@fontsource/roboto/500.css';
import '@fontsource/roboto/700.css';

export const metadata: Metadata = {
  title: {
    default: 'EventsOS Admin',
    template: '%s | EventsOS Admin'
  },
  description: 'EventsOS Admin Dashboard - Manage your fashion events',
  robots: 'noindex, nofollow',
  viewport: 'initial-scale=1, width=device-width',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <head>
        <meta name="emotion-insertion-point" content="" />
      </head>
      <body>
        <AppRouterCacheProvider options={{ enableCssLayer: true }}>
          <ThemeProvider>
            {children}
          </ThemeProvider>
        </AppRouterCacheProvider>
      </body>
    </html>
  );
}
EOF

# Create a test page
cat > src/app/page.tsx << 'EOF'
import * as React from 'react';
import { Container, Typography, Box, Button } from '@mui/material';

export default function HomePage() {
  return (
    <Container maxWidth="lg">
      <Box
        sx={{
          my: 4,
          display: 'flex',
          flexDirection: 'column',
          justifyContent: 'center',
          alignItems: 'center',
          minHeight: '50vh',
        }}
      >
        <Typography variant="h1" component="h1" gutterBottom>
          EventsOS Admin
        </Typography>
        <Typography variant="h5" component="h2" gutterBottom color="text.secondary">
          Fashion Event Management Platform
        </Typography>
        <Box sx={{ mt: 4 }}>
          <Button variant="contained" size="large" sx={{ mr: 2 }}>
            Get Started
          </Button>
          <Button variant="outlined" size="large">
            Learn More
          </Button>
        </Box>
      </Box>
    </Container>
  );
}
EOF

# Create providers index
cat > src/providers/index.ts << 'EOF'
export * from './ThemeProvider';
EOF
```

**Success Criteria**:
- ✅ Material-UI theme configured with EventsOS branding
- ✅ SSR working without hydration errors
- ✅ Emotion cache properly configured
- ✅ Fonts loading optimally

**Validation Tests**:
```bash
# Build and test SSR
pnpm build
pnpm start

# Check for hydration errors in browser console
# Visit http://localhost:3001

# Test development mode
pnpm dev
```

---

### Task 2.3: Integrate Refine with Supabase Data Provider

**Purpose**: Configure Refine framework with Supabase data provider to connect to the existing EventsOS database with 60+ tables

**Dependencies**: Task 2.2 completed successfully

**Reference Links**:
- [Refine Supabase Data Provider](https://refine.dev/docs/data/packages/supabase/)
- [Refine Authentication](https://refine.dev/docs/authentication/auth-provider/)
- [Supabase Auth Helpers](https://supabase.com/docs/guides/auth/auth-helpers/nextjs)

**Step-by-Step Instructions**:

1. **Configure Supabase Client**
   - Set up Supabase client with proper configuration
   - Configure authentication helpers for Next.js
   - Set up proper error handling and retries

2. **Create Refine Data Provider**
   - Configure Supabase data provider for Refine
   - Set up proper resource mappings
   - Configure data provider options

3. **Set Up Authentication Provider**
   - Create Supabase authentication provider
   - Configure login, logout, and session management
   - Set up proper permission checking

4. **Create Refine Application Wrapper**
   - Set up Refine with Material-UI integration
   - Configure routing with Next.js App Router
   - Add error boundaries and loading states

5. **Test Database Connection**
   - Verify connection to existing Supabase database
   - Test data fetching from events table
   - Validate authentication flow

**Commands**:
```bash
# Install Supabase auth helpers
pnpm add @supabase/auth-helpers-nextjs @supabase/auth-helpers-react

# Create Supabase client configuration
mkdir -p src/lib
cat > src/lib/supabase.ts << 'EOF'
import { createClientComponentClient, createServerComponentClient } from '@supabase/auth-helpers-nextjs';
import { cookies } from 'next/headers';

// Client-side Supabase client
export const createClient = () => createClientComponentClient();

// Server-side Supabase client
export const createServerClient = () => {
  const cookieStore = cookies();
  return createServerComponentClient({ cookies: () => cookieStore });
};

// Database types (you can generate these with: npx supabase gen types typescript --local)
export type Database = {
  public: {
    Tables: {
      events: {
        Row: {
          id: string;
          title: string;
          description: string | null;
          start_date: string;
          end_date: string;
          organization_id: string;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          title: string;
          description?: string | null;
          start_date: string;
          end_date: string;
          organization_id: string;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          title?: string;
          description?: string | null;
          start_date?: string;
          end_date?: string;
          organization_id?: string;
          created_at?: string;
          updated_at?: string;
        };
      };
      organizations: {
        Row: {
          id: string;
          name: string;
          slug: string;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          name: string;
          slug: string;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          name?: string;
          slug?: string;
          created_at?: string;
          updated_at?: string;
        };
      };
    };
  };
};
EOF

# Create authentication provider
cat > src/providers/AuthProvider.tsx << 'EOF'
'use client';

import { AuthProvider } from '@refinedev/core';
import { createClient } from '@/lib/supabase';

export const authProvider: AuthProvider = {
  login: async ({ email, password }) => {
    const supabase = createClient();
    
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    });

    if (error) {
      return {
        success: false,
        error: {
          message: error.message,
          name: 'Login Error',
        },
      };
    }

    if (data?.user) {
      return {
        success: true,
        redirectTo: '/dashboard',
      };
    }

    return {
      success: false,
      error: {
        message: 'Login failed',
        name: 'Login Error',
      },
    };
  },

  logout: async () => {
    const supabase = createClient();
    const { error } = await supabase.auth.signOut();

    if (error) {
      return {
        success: false,
        error: {
          message: error.message,
          name: 'Logout Error',
        },
      };
    }

    return {
      success: true,
      redirectTo: '/login',
    };
  },

  check: async () => {
    const supabase = createClient();
    const { data: { session } } = await supabase.auth.getSession();

    if (session?.user) {
      return {
        authenticated: true,
      };
    }

    return {
      authenticated: false,
      error: {
        message: 'Check failed',
        name: 'Authentication Error',
      },
      redirectTo: '/login',
    };
  },

  getPermissions: async () => {
    const supabase = createClient();
    const { data: { user } } = await supabase.auth.getUser();

    if (user) {
      return user.user_metadata?.role || 'user';
    }

    return null;
  },

  getIdentity: async () => {
    const supabase = createClient();
    const { data: { user } } = await supabase.auth.getUser();

    if (user) {
      return {
        id: user.id,
        name: user.user_metadata?.full_name || user.email,
        email: user.email,
        avatar: user.user_metadata?.avatar_url,
      };
    }

    return null;
  },

  onError: async (error) => {
    console.error('Auth error:', error);
    return { error };
  },
};
EOF

# Create Refine providers
cat > src/providers/RefineProvider.tsx << 'EOF'
'use client';

import { Refine } from '@refinedev/core';
import { RefineKbar, RefineKbarProvider } from '@refinedev/kbar';
import { notificationProvider, RefineSnackbarProvider } from '@refinedev/mui';
import routerProvider from '@refinedev/nextjs-router';
import { dataProvider } from '@refinedev/supabase';
import { authProvider } from './AuthProvider';
import { createClient } from '@/lib/supabase';

interface RefineProviderProps {
  children: React.ReactNode;
}

export function RefineProvider({ children }: RefineProviderProps) {
  const supabase = createClient();

  return (
    <RefineKbarProvider>
      <RefineSnackbarProvider>
        <Refine
          routerProvider={routerProvider}
          dataProvider={dataProvider(supabase)}
          authProvider={authProvider}
          notificationProvider={notificationProvider}
          resources={[
            {
              name: 'events',
              list: '/dashboard/events',
              create: '/dashboard/events/create',
              edit: '/dashboard/events/edit/:id',
              show: '/dashboard/events/show/:id',
              meta: {
                canDelete: true,
              },
            },
            {
              name: 'attendees',
              list: '/dashboard/attendees',
              create: '/dashboard/attendees/create',
              edit: '/dashboard/attendees/edit/:id',
              show: '/dashboard/attendees/show/:id',
              meta: {
                canDelete: true,
              },
            },
            {
              name: 'sponsors',
              list: '/dashboard/sponsors',
              create: '/dashboard/sponsors/create',
              edit: '/dashboard/sponsors/edit/:id',
              show: '/dashboard/sponsors/show/:id',
              meta: {
                canDelete: true,
              },
            },
            {
              name: 'organizations',
              list: '/dashboard/organizations',
              create: '/dashboard/organizations/create',
              edit: '/dashboard/organizations/edit/:id',
              show: '/dashboard/organizations/show/:id',
              meta: {
                canDelete: true,
              },
            },
          ]}
          options={{
            syncWithLocation: true,
            warnWhenUnsavedChanges: true,
            projectId: 'eventos-admin',
          }}
        >
          {children}
          <RefineKbar />
        </Refine>
      </RefineSnackbarProvider>
    </RefineKbarProvider>
  );
}
EOF

# Update providers index
cat > src/providers/index.ts << 'EOF'
export * from './ThemeProvider';
export * from './AuthProvider';
export * from './RefineProvider';
EOF

# Update root layout to include Refine
cat > src/app/layout.tsx << 'EOF'
import * as React from 'react';
import { AppRouterCacheProvider } from '@mui/material-nextjs/v15-appRouter';
import { ThemeProvider } from '@/providers/ThemeProvider';
import { RefineProvider } from '@/providers/RefineProvider';
import type { Metadata } from 'next';
import '@fontsource/roboto/300.css';
import '@fontsource/roboto/400.css';
import '@fontsource/roboto/500.css';
import '@fontsource/roboto/700.css';

export const metadata: Metadata = {
  title: {
    default: 'EventsOS Admin',
    template: '%s | EventsOS Admin'
  },
  description: 'EventsOS Admin Dashboard - Manage your fashion events',
  robots: 'noindex, nofollow',
  viewport: 'initial-scale=1, width=device-width',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <head>
        <meta name="emotion-insertion-point" content="" />
      </head>
      <body>
        <AppRouterCacheProvider options={{ enableCssLayer: true }}>
          <ThemeProvider>
            <RefineProvider>
              {children}
            </RefineProvider>
          </ThemeProvider>
        </AppRouterCacheProvider>
      </body>
    </html>
  );
}
EOF

# Create middleware for authentication
cat > middleware.ts << 'EOF'
import { createMiddlewareClient } from '@supabase/auth-helpers-nextjs';
import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

export async function middleware(req: NextRequest) {
  const res = NextResponse.next();
  
  // Skip middleware for static files and API routes
  if (
    req.nextUrl.pathname.startsWith('/_next') ||
    req.nextUrl.pathname.startsWith('/api') ||
    req.nextUrl.pathname.includes('.')
  ) {
    return res;
  }

  const supabase = createMiddlewareClient({ req, res });

  const {
    data: { session },
  } = await supabase.auth.getSession();

  // Protect dashboard routes
  if (req.nextUrl.pathname.startsWith('/dashboard') && !session) {
    return NextResponse.redirect(new URL('/login', req.url));
  }

  // Redirect logged-in users from auth pages
  if (
    (req.nextUrl.pathname.startsWith('/login') ||
     req.nextUrl.pathname.startsWith('/register')) &&
    session
  ) {
    return NextResponse.redirect(new URL('/dashboard', req.url));
  }

  return res;
}

export const config = {
  matcher: ['/((?!_next/static|_next/image|favicon.ico).*)'],
}
EOF
```

**Success Criteria**:
- ✅ Refine configured with Supabase data provider
- ✅ Authentication provider working with existing database
- ✅ Material-UI integration with Refine components
- ✅ Middleware protecting dashboard routes

**Validation Tests**:
```bash
# Test build
pnpm build

# Test development with database connection
pnpm dev

# Verify Supabase connection
# Check browser console for any connection errors
```

---

### Task 2.4: Create Admin Dashboard Layout and Navigation

**Purpose**: Build the admin dashboard layout with navigation, header, sidebar, and responsive design using Refine and Material-UI components

**Dependencies**: Task 2.3 completed successfully

**Reference Links**:
- [Refine Layout Examples](https://refine.dev/docs/ui-integrations/material-ui/components/basic-layout/)
- [Material-UI Navigation Components](https://v6.mui.com/material-ui/all-components/)

**Step-by-Step Instructions**:

1. **Create Dashboard Layout Structure**
   - Build responsive sidebar navigation
   - Create header with user menu and notifications
   - Set up main content area with proper spacing

2. **Implement Navigation Menu**
   - Create navigation items for all EventsOS modules
   - Add icons and proper hierarchy
   - Implement active state and breadcrumbs

3. **Add User Authentication UI**
   - Create login and registration pages
   - Add user profile management
   - Implement logout functionality

4. **Create Dashboard Pages**
   - Build event management pages
   - Create attendee management interface
   - Add sponsor management dashboard

5. **Test Responsive Design**
   - Verify mobile navigation works
   - Test tablet and desktop layouts
   - Ensure accessibility compliance

**Commands**:
```bash
# Create dashboard layout
cat > src/app/dashboard/layout.tsx << 'EOF'
'use client';

import React from 'react';
import { ThemedLayoutV2, ThemedSiderV2, ThemedHeaderV2 } from '@refinedev/mui';
import { Box } from '@mui/material';

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <ThemedLayoutV2
      Header={() => <ThemedHeaderV2 sticky />}
      Sider={(props) => <ThemedSiderV2 {...props} fixed />}
    >
      <Box sx={{ p: 2 }}>
        {children}
      </Box>
    </ThemedLayoutV2>
  );
}
EOF

# Create dashboard home page
cat > src/app/dashboard/page.tsx << 'EOF'
'use client';

import React from 'react';
import {
  Grid,
  Card,
  CardContent,
  Typography,
  Box,
  Button,
} from '@mui/material';
import {
  Event as EventIcon,
  People as PeopleIcon,
  Business as BusinessIcon,
  Analytics as AnalyticsIcon,
} from '@mui/icons-material';
import { useList } from '@refinedev/core';

export default function DashboardPage() {
  const { data: eventsData } = useList({
    resource: 'events',
    pagination: { pageSize: 5 },
  });

  const { data: attendeesData } = useList({
    resource: 'attendees',
    pagination: { pageSize: 5 },
  });

  const { data: sponsorsData } = useList({
    resource: 'sponsors',
    pagination: { pageSize: 5 },
  });

  const stats = [
    {
      title: 'Total Events',
      value: eventsData?.total || 0,
      icon: <EventIcon sx={{ fontSize: 40 }} />,
      color: 'primary.main',
      href: '/dashboard/events',
    },
    {
      title: 'Total Attendees',
      value: attendeesData?.total || 0,
      icon: <PeopleIcon sx={{ fontSize: 40 }} />,
      color: 'secondary.main',
      href: '/dashboard/attendees',
    },
    {
      title: 'Active Sponsors',
      value: sponsorsData?.total || 0,
      icon: <BusinessIcon sx={{ fontSize: 40 }} />,
      color: 'success.main',
      href: '/dashboard/sponsors',
    },
    {
      title: 'Analytics',
      value: 'View',
      icon: <AnalyticsIcon sx={{ fontSize: 40 }} />,
      color: 'warning.main',
      href: '/dashboard/analytics',
    },
  ];

  return (
    <Box>
      <Typography variant="h4" component="h1" gutterBottom>
        EventsOS Dashboard
      </Typography>
      <Typography variant="subtitle1" color="text.secondary" gutterBottom sx={{ mb: 4 }}>
        Welcome to your fashion event management platform
      </Typography>

      <Grid container spacing={3}>
        {stats.map((stat, index) => (
          <Grid item xs={12} sm={6} md={3} key={index}>
            <Card sx={{ height: '100%' }}>
              <CardContent>
                <Box display="flex" alignItems="center" justifyContent="space-between">
                  <Box>
                    <Typography color="text.secondary" gutterBottom>
                      {stat.title}
                    </Typography>
                    <Typography variant="h4" component="div">
                      {stat.value}
                    </Typography>
                  </Box>
                  <Box sx={{ color: stat.color }}>
                    {stat.icon}
                  </Box>
                </Box>
                <Box sx={{ mt: 2 }}>
                  <Button
                    variant="outlined"
                    size="small"
                    href={stat.href}
                    fullWidth
                  >
                    View Details
                  </Button>
                </Box>
              </CardContent>
            </Card>
          </Grid>
        ))}
      </Grid>

      <Grid container spacing={3} sx={{ mt: 2 }}>
        <Grid item xs={12} md={8}>
          <Card>
            <CardContent>
              <Typography variant="h6" gutterBottom>
                Recent Events
              </Typography>
              {eventsData?.data?.slice(0, 5).map((event: any) => (
                <Box key={event.id} sx={{ py: 1, borderBottom: '1px solid #eee' }}>
                  <Typography variant="subtitle1">{event.title}</Typography>
                  <Typography variant="body2" color="text.secondary">
                    {new Date(event.start_date).toLocaleDateString()}
                  </Typography>
                </Box>
              )) || (
                <Typography color="text.secondary">No events found</Typography>
              )}
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={4}>
          <Card>
            <CardContent>
              <Typography variant="h6" gutterBottom>
                Quick Actions
              </Typography>
              <Box sx={{ display: 'flex', flexDirection: 'column', gap: 1 }}>
                <Button variant="contained" href="/dashboard/events/create">
                  Create New Event
                </Button>
                <Button variant="outlined" href="/dashboard/attendees">
                  Manage Attendees
                </Button>
                <Button variant="outlined" href="/dashboard/sponsors">
                  Manage Sponsors
                </Button>
              </Box>
            </CardContent>
          </Card>
        </Grid>
      </Grid>
    </Box>
  );
}
EOF

# Create events list page
mkdir -p src/app/dashboard/events
cat > src/app/dashboard/events/page.tsx << 'EOF'
'use client';

import React from 'react';
import { List, useDataGrid, CreateButton } from '@refinedev/mui';
import { DataGrid, GridColDef } from '@mui/x-data-grid';
import { Chip, Box } from '@mui/material';

export default function EventsList() {
  const { dataGridProps } = useDataGrid({
    resource: 'events',
    pagination: {
      pageSize: 25,
    },
  });

  const columns: GridColDef[] = [
    {
      field: 'title',
      headerName: 'Event Title',
      minWidth: 250,
      flex: 1,
    },
    {
      field: 'start_date',
      headerName: 'Start Date',
      minWidth: 150,
      type: 'date',
      valueGetter: (params) => new Date(params.row.start_date),
    },
    {
      field: 'end_date',
      headerName: 'End Date',
      minWidth: 150,
      type: 'date',
      valueGetter: (params) => new Date(params.row.end_date),
    },
    {
      field: 'status',
      headerName: 'Status',
      minWidth: 120,
      renderCell: (params) => (
        <Chip
          label={params.value || 'Draft'}
          color={
            params.value === 'published' ? 'success' :
            params.value === 'live' ? 'primary' :
            params.value === 'completed' ? 'default' :
            'warning'
          }
          size="small"
        />
      ),
    },
    {
      field: 'created_at',
      headerName: 'Created',
      minWidth: 150,
      type: 'dateTime',
      valueGetter: (params) => new Date(params.row.created_at),
    },
  ];

  return (
    <List
      headerButtons={({ defaultButtons }) => (
        <Box>
          {defaultButtons}
          <CreateButton />
        </Box>
      )}
    >
      <DataGrid
        {...dataGridProps}
        columns={columns}
        autoHeight
        pageSizeOptions={[10, 25, 50, 100]}
      />
    </List>
  );
}
EOF

# Create login page
mkdir -p src/app/(auth)/login
cat > src/app/(auth)/login/page.tsx << 'EOF'
'use client';

import React from 'react';
import { AuthPage } from '@refinedev/mui';

export default function LoginPage() {
  return (
    <AuthPage
      type="login"
      title="EventsOS Admin"
      formProps={{
        defaultValues: {
          email: '',
          password: '',
        },
      }}
    />
  );
}
EOF

# Create register page
mkdir -p src/app/(auth)/register
cat > src/app/(auth)/register/page.tsx << 'EOF'
'use client';

import React from 'react';
import { AuthPage } from '@refinedev/mui';

export default function RegisterPage() {
  return (
    <AuthPage
      type="register"
      title="EventsOS Admin"
      formProps={{
        defaultValues: {
          email: '',
          password: '',
        },
      }}
    />
  );
}
EOF

# Update home page to redirect to dashboard
cat > src/app/page.tsx << 'EOF'
'use client';

import { useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { useIsAuthenticated } from '@refinedev/core';
import { CircularProgress, Box } from '@mui/material';

export default function HomePage() {
  const router = useRouter();
  const { data: isAuthenticated, isLoading } = useIsAuthenticated();

  useEffect(() => {
    if (!isLoading) {
      if (isAuthenticated) {
        router.replace('/dashboard');
      } else {
        router.replace('/login');
      }
    }
  }, [isAuthenticated, isLoading, router]);

  return (
    <Box
      display="flex"
      justifyContent="center"
      alignItems="center"
      minHeight="100vh"
    >
      <CircularProgress />
    </Box>
  );
}
EOF
```

**Success Criteria**:
- ✅ Dashboard layout with navigation working
- ✅ Authentication pages functional
- ✅ Event list displaying data from Supabase
- ✅ Responsive design working on all screen sizes

**Validation Tests**:
```bash
# Test authentication flow
pnpm dev
# Visit http://localhost:3001 and test login/logout

# Test dashboard navigation
# Verify all menu items work correctly

# Test data grid functionality
# Check events list loads and displays properly
```

---

## 🌐 Phase 3: Website App (MUI Only)

### Phase Overview
Create the public-facing website using Next.js 14 with Material-UI v6, implement SEO optimization, and create marketing pages for the EventsOS platform.

---

### Task 3.1: Initialize Website Application

**Purpose**: Set up the public website application with Next.js 14 App Router and Material-UI v6 for EventsOS marketing and public event display

**Dependencies**: Phase 2 completed successfully

**Reference Links**:
- [Next.js 14 Documentation](https://nextjs.org/docs)
- [Material-UI Next.js Example](https://github.com/mui/material-ui/tree/v6.x/examples/material-ui-nextjs-ts)
- [Next.js SEO Best Practices](https://nextjs.org/docs/app/building-your-application/optimizing/metadata)

**Step-by-Step Instructions**:

1. **Initialize Website Application Structure**
   - Create Next.js 14 application with App Router
   - Set up proper directory structure for marketing website
   - Configure TypeScript with strict settings

2. **Install Next.js and Material-UI Dependencies**
   - Install Next.js 14 with React 18
   - Add Material-UI v6 components and styling
   - Install additional dependencies for website features

3. **Configure Next.js for Website**
   - Set up next.config.js with SEO optimizations
   - Configure TypeScript with path mappings
   - Set up proper build and development scripts

4. **Create Basic Website Structure**
   - Set up routing for marketing pages
   - Create layout components
   - Configure SEO metadata and Open Graph

5. **Set Up Material-UI Theme for Website**
   - Configure custom theme for public website
   - Set up responsive design system
   - Create component library structure

**Commands**:
```bash
# Navigate to website app directory
cd apps/website

# Initialize package.json
pnpm init

cat > package.json << 'EOF'
{
  "name": "@eventos/website",
  "version": "0.0.1",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "type-check": "tsc --noEmit",
    "clean": "rm -rf .next .turbo node_modules"
  }
}
EOF

# Install Next.js and React dependencies
pnpm add next@14.2.29 react@18.2.0 react-dom@18.2.0

# Install TypeScript dependencies
pnpm add -D typescript@5.3.3 @types/react@18.2.48 @types/react-dom@18.2.18 @types/node@20.11.5

# Install Material-UI v6 dependencies (no Refine for website)
pnpm add @mui/material@6.5.0 @emotion/react@11.11.3 @emotion/styled@11.11.0
pnpm add @mui/material-nextjs@6.5.0
pnpm add @mui/icons-material@6.5.0
pnpm add @fontsource/roboto@5.0.8

# Install additional website dependencies
pnpm add @supabase/supabase-js@2.39.3
pnpm add @vercel/analytics@1.1.1 @vercel/speed-insights@1.0.9

# Install development dependencies
pnpm add -D eslint@8.56.0 eslint-config-next@14.2.29

# Create directory structure
mkdir -p src/{app,components,providers,theme,lib,hooks,utils,types}
mkdir -p src/app/{(marketing),events,blog,api}
mkdir -p src/app/(marketing)/{about,features,pricing,contact}
mkdir -p src/components/{layout,sections,ui,forms}
mkdir -p public/{images,icons,fonts}

# Create Next.js configuration
cat > next.config.mjs << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  images: {
    domains: ['localhost', 'wnjudgmhabzhcttgyxou.supabase.co'],
    formats: ['image/avif', 'image/webp'],
  },
  async headers() {
    return [
      {
        source: '/:path*',
        headers: [
          {
            key: 'X-DNS-Prefetch-Control',
            value: 'on'
          },
          {
            key: 'Strict-Transport-Security',
            value: 'max-age=63072000; includeSubDomains; preload'
          },
          {
            key: 'X-Frame-Options',
            value: 'SAMEORIGIN'
          },
          {
            key: 'X-Content-Type-Options',
            value: 'nosniff'
          },
          {
            key: 'Referrer-Policy',
            value: 'strict-origin-when-cross-origin'
          },
          {
            key: 'Permissions-Policy',
            value: 'camera=(), microphone=(), geolocation=()'
          }
        ]
      },
      {
        source: '/fonts/(.*)',
        headers: [
          {
            key: 'Cache-Control',
            value: 'public, max-age=31536000, immutable'
          }
        ]
      },
      {
        source: '/images/(.*)',
        headers: [
          {
            key: 'Cache-Control',
            value: 'public, max-age=31536000, immutable'
          }
        ]
      }
    ];
  },
  async rewrites() {
    return [
      {
        source: '/sitemap.xml',
        destination: '/api/sitemap'
      }
    ];
  }
}

export default nextConfig
EOF

# Create TypeScript configuration
cat > tsconfig.json << 'EOF'
{
  "extends": "../../tsconfig.json",
  "compilerOptions": {
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./src/*"],
      "@eventos/ui": ["../../packages/ui/src"],
      "@eventos/types": ["../../packages/types/src"],
      "@eventos/utils": ["../../packages/utils/src"],
      "@eventos/database": ["../../packages/database/src"],
      "@eventos/env": ["../../packages/env/src"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
EOF

# Create ESLint configuration
cat > .eslintrc.json << 'EOF'
{
  "extends": ["next/core-web-vitals"]
}
EOF

# Create environment file
cat > .env.local << 'EOF'
# Copy values from root .env.example
NEXT_PUBLIC_SUPABASE_URL=https://wnjudgmhabzhcttgyxou.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=
NEXT_PUBLIC_APP_URL=http://localhost:3000
NEXT_PUBLIC_ADMIN_URL=http://localhost:3001
EOF
```

**Success Criteria**:
- ✅ Next.js 14 application initialized with App Router
- ✅ Material-UI v6 dependencies installed (no Refine)
- ✅ TypeScript configuration with proper path mappings
- ✅ Development server can start on port 3000

**Validation Tests**:
```bash
# Verify installation
pnpm list @mui/material next

# Type check
pnpm type-check

# Start development server
pnpm dev
```

---

### Task 3.2: Configure Website Theme and Layout

**Purpose**: Set up Material-UI theme, create responsive layout components, and implement the main website navigation structure

**Dependencies**: Task 3.1 completed successfully

**Reference Links**:
- [Material-UI Theming](https://v6.mui.com/material-ui/customization/theming/)
- [Material-UI Layout Components](https://v6.mui.com/material-ui/all-components/)

**Step-by-Step Instructions**:

1. **Create Website Theme Configuration**
   - Set up custom Material-UI theme for public website
   - Configure brand colors, typography, and components
   - Add responsive breakpoints and spacing

2. **Set Up Theme Provider with SSR**
   - Configure emotion cache for server-side rendering
   - Set up theme provider with proper hydration
   - Add CSS baseline and font loading

3. **Create Layout Components**
   - Build responsive header with navigation
   - Create footer with links and information
   - Set up main layout wrapper

4. **Implement Navigation System**
   - Create main navigation menu
   - Add mobile navigation drawer
   - Implement breadcrumbs and page structure

5. **Add Analytics and Performance Monitoring**
   - Integrate Vercel Analytics and Speed Insights
   - Set up proper error boundaries
   - Configure SEO optimization

**Commands**:
```bash
# Create website theme
cat > src/theme/index.ts << 'EOF'
import { createTheme, ThemeOptions } from '@mui/material/styles';

declare module '@mui/material/styles' {
  interface Theme {
    eventos: {
      gradients: {
        primary: string;
        secondary: string;
      };
    };
  }

  interface ThemeOptions {
    eventos?: {
      gradients?: {
        primary?: string;
        secondary?: string;
      };
    };
  }
}

const themeOptions: ThemeOptions = {
  palette: {
    mode: 'light',
    primary: {
      main: '#6366f1', // Indigo
      light: '#8b87f9',
      dark: '#4f46e5',
      contrastText: '#ffffff',
    },
    secondary: {
      main: '#ec4899', // Pink
      light: '#f472b6',
      dark: '#db2777',
      contrastText: '#ffffff',
    },
    background: {
      default: '#ffffff',
      paper: '#ffffff',
    },
    text: {
      primary: '#1f2937',
      secondary: '#6b7280',
    },
  },
  typography: {
    fontFamily: 'Roboto, "Helvetica Neue", Arial, sans-serif',
    h1: {
      fontSize: '3.5rem',
      fontWeight: 700,
      lineHeight: 1.1,
      '@media (max-width:600px)': {
        fontSize: '2.5rem',
      },
    },
    h2: {
      fontSize: '3rem',
      fontWeight: 600,
      lineHeight: 1.2,
      '@media (max-width:600px)': {
        fontSize: '2rem',
      },
    },
    h3: {
      fontSize: '2.25rem',
      fontWeight: 600,
      lineHeight: 1.3,
      '@media (max-width:600px)': {
        fontSize: '1.75rem',
      },
    },
    h4: {
      fontSize: '1.875rem',
      fontWeight: 600,
      lineHeight: 1.4,
    },
    h5: {
      fontSize: '1.5rem',
      fontWeight: 600,
      lineHeight: 1.4,
    },
    h6: {
      fontSize: '1.25rem',
      fontWeight: 600,
      lineHeight: 1.4,
    },
    body1: {
      fontSize: '1rem',
      lineHeight: 1.7,
    },
    body2: {
      fontSize: '0.875rem',
      lineHeight: 1.6,
    },
  },
  eventos: {
    gradients: {
      primary: 'linear-gradient(135deg, #6366f1 0%, #8b87f9 100%)',
      secondary: 'linear-gradient(135deg, #ec4899 0%, #f472b6 100%)',
    },
  },
  components: {
    MuiButton: {
      styleOverrides: {
        root: {
          textTransform: 'none',
          borderRadius: '12px',
          fontWeight: 600,
          padding: '12px 24px',
        },
        containedPrimary: {
          background: 'linear-gradient(135deg, #6366f1 0%, #8b87f9 100%)',
          boxShadow: '0 4px 20px rgba(99, 102, 241, 0.3)',
          '&:hover': {
            background: 'linear-gradient(135deg, #4f46e5 0%, #6366f1 100%)',
            boxShadow: '0 6px 25px rgba(99, 102, 241, 0.4)',
          },
        },
      },
    },
    MuiCard: {
      styleOverrides: {
        root: {
          borderRadius: '16px',
          boxShadow: '0 4px 20px rgba(0, 0, 0, 0.1)',
          border: '1px solid rgba(0, 0, 0, 0.05)',
        },
      },
    },
    MuiContainer: {
      styleOverrides: {
        root: {
          paddingLeft: '24px',
          paddingRight: '24px',
          '@media (max-width:600px)': {
            paddingLeft: '16px',
            paddingRight: '16px',
          },
        },
      },
    },
  },
};

export const theme = createTheme(themeOptions);
EOF

# Create theme provider
cat > src/providers/ThemeProvider.tsx << 'EOF'
'use client';

import * as React from 'react';
import { ThemeProvider as MuiThemeProvider } from '@mui/material/styles';
import CssBaseline from '@mui/material/CssBaseline';
import { theme } from '@/theme';

interface ThemeProviderProps {
  children: React.ReactNode;
}

export function ThemeProvider({ children }: ThemeProviderProps) {
  return (
    <MuiThemeProvider theme={theme}>
      <CssBaseline />
      {children}
    </MuiThemeProvider>
  );
}
EOF

# Create header component
cat > src/components/layout/Header.tsx << 'EOF'
'use client';

import React, { useState } from 'react';
import {
  AppBar,
  Toolbar,
  Typography,
  Button,
  Box,
  IconButton,
  Drawer,
  List,
  ListItem,
  ListItemText,
  useMediaQuery,
  useTheme,
  Container,
} from '@mui/material';
import {
  Menu as MenuIcon,
  Close as CloseIcon,
} from '@mui/icons-material';
import Link from 'next/link';

const navigationItems = [
  { label: 'Home', href: '/' },
  { label: 'Events', href: '/events' },
  { label: 'Features', href: '/features' },
  { label: 'Pricing', href: '/pricing' },
  { label: 'About', href: '/about' },
  { label: 'Contact', href: '/contact' },
];

export function Header() {
  const [mobileOpen, setMobileOpen] = useState(false);
  const theme = useTheme();
  const isMobile = useMediaQuery(theme.breakpoints.down('md'));

  const handleDrawerToggle = () => {
    setMobileOpen(!mobileOpen);
  };

  const drawer = (
    <Box sx={{ width: 250 }}>
      <Box sx={{ display: 'flex', justifyContent: 'flex-end', p: 1 }}>
        <IconButton onClick={handleDrawerToggle}>
          <CloseIcon />
        </IconButton>
      </Box>
      <List>
        {navigationItems.map((item) => (
          <ListItem key={item.label} component={Link} href={item.href} onClick={handleDrawerToggle}>
            <ListItemText primary={item.label} />
          </ListItem>
        ))}
        <ListItem>
          <Button
            variant="contained"
            fullWidth
            component={Link}
            href="/admin"
            target="_blank"
          >
            Admin Dashboard
          </Button>
        </ListItem>
      </List>
    </Box>
  );

  return (
    <>
      <AppBar 
        position="sticky" 
        sx={{ 
          backgroundColor: 'background.paper',
          color: 'text.primary',
          boxShadow: '0 1px 3px rgba(0, 0, 0, 0.1)',
        }}
      >
        <Container maxWidth="xl">
          <Toolbar>
            <Typography
              variant="h6"
              component={Link}
              href="/"
              sx={{
                flexGrow: 1,
                fontWeight: 700,
                color: 'primary.main',
                textDecoration: 'none',
              }}
            >
              EventsOS
            </Typography>

            {!isMobile ? (
              <Box sx={{ display: 'flex', alignItems: 'center', gap: 3 }}>
                {navigationItems.map((item) => (
                  <Button
                    key={item.label}
                    component={Link}
                    href={item.href}
                    color="inherit"
                    sx={{ fontWeight: 500 }}
                  >
                    {item.label}
                  </Button>
                ))}
                <Button
                  variant="contained"
                  component={Link}
                  href="/admin"
                  target="_blank"
                  sx={{ ml: 1 }}
                >
                  Admin Dashboard
                </Button>
              </Box>
            ) : (
              <IconButton
                color="inherit"
                aria-label="open drawer"
                edge="start"
                onClick={handleDrawerToggle}
              >
                <MenuIcon />
              </IconButton>
            )}
          </Toolbar>
        </Container>
      </AppBar>

      <Drawer
        variant="temporary"
        anchor="right"
        open={mobileOpen}
        onClose={handleDrawerToggle}
        ModalProps={{
          keepMounted: true,
        }}
        sx={{
          display: { xs: 'block', md: 'none' },
          '& .MuiDrawer-paper': { boxSizing: 'border-box', width: 250 },
        }}
      >
        {drawer}
      </Drawer>
    </>
  );
}
EOF

# Create footer component
cat > src/components/layout/Footer.tsx << 'EOF'
'use client';

import React from 'react';
import {
  Box,
  Container,
  Grid,
  Typography,
  Link as MuiLink,
  IconButton,
  Divider,
} from '@mui/material';
import {
  GitHub as GitHubIcon,
  Twitter as TwitterIcon,
  LinkedIn as LinkedInIcon,
  Instagram as InstagramIcon,
} from '@mui/icons-material';
import Link from 'next/link';

const footerLinks = {
  product: [
    { label: 'Features', href: '/features' },
    { label: 'Pricing', href: '/pricing' },
    { label: 'Security', href: '/security' },
    { label: 'Roadmap', href: '/roadmap' },
  ],
  company: [
    { label: 'About', href: '/about' },
    { label: 'Blog', href: '/blog' },
    { label: 'Careers', href: '/careers' },
    { label: 'Press', href: '/press' },
  ],
  support: [
    { label: 'Help Center', href: '/help' },
    { label: 'Contact', href: '/contact' },
    { label: 'API Docs', href: '/docs' },
    { label: 'Status', href: '/status' },
  ],
  legal: [
    { label: 'Privacy', href: '/privacy' },
    { label: 'Terms', href: '/terms' },
    { label: 'Cookies', href: '/cookies' },
    { label: 'Licenses', href: '/licenses' },
  ],
};

const socialLinks = [
  { icon: <GitHubIcon />, href: 'https://github.com/eventos', label: 'GitHub' },
  { icon: <TwitterIcon />, href: 'https://twitter.com/eventos', label: 'Twitter' },
  { icon: <LinkedInIcon />, href: 'https://linkedin.com/company/eventos', label: 'LinkedIn' },
  { icon: <InstagramIcon />, href: 'https://instagram.com/eventos', label: 'Instagram' },
];

export function Footer() {
  return (
    <Box
      component="footer"
      sx={{
        backgroundColor: 'grey.900',
        color: 'white',
        py: 6,
        mt: 'auto',
      }}
    >
      <Container maxWidth="xl">
        <Grid container spacing={4}>
          <Grid item xs={12} md={3}>
            <Typography variant="h6" gutterBottom sx={{ fontWeight: 700 }}>
              EventsOS
            </Typography>
            <Typography variant="body2" sx={{ mb: 3, color: 'grey.400' }}>
              The ultimate AI-powered platform for managing fashion events and creating unforgettable experiences.
            </Typography>
            <Box sx={{ display: 'flex', gap: 1 }}>
              {socialLinks.map((social) => (
                <IconButton
                  key={social.label}
                  component="a"
                  href={social.href}
                  target="_blank"
                  rel="noopener noreferrer"
                  sx={{ color: 'grey.400', '&:hover': { color: 'primary.main' } }}
                >
                  {social.icon}
                </IconButton>
              ))}
            </Box>
          </Grid>

          <Grid item xs={6} md={2}>
            <Typography variant="h6" gutterBottom sx={{ fontWeight: 600 }}>
              Product
            </Typography>
            {footerLinks.product.map((link) => (
              <MuiLink
                key={link.label}
                component={Link}
                href={link.href}
                display="block"
                sx={{
                  color: 'grey.400',
                  textDecoration: 'none',
                  mb: 1,
                  '&:hover': { color: 'primary.main' },
                }}
              >
                {link.label}
              </MuiLink>
            ))}
          </Grid>

          <Grid item xs={6} md={2}>
            <Typography variant="h6" gutterBottom sx={{ fontWeight: 600 }}>
              Company
            </Typography>
            {footerLinks.company.map((link) => (
              <MuiLink
                key={link.label}
                component={Link}
                href={link.href}
                display="block"
                sx={{
                  color: 'grey.400',
                  textDecoration: 'none',
                  mb: 1,
                  '&:hover': { color: 'primary.main' },
                }}
              >
                {link.label}
              </MuiLink>
            ))}
          </Grid>

          <Grid item xs={6} md={2}>
            <Typography variant="h6" gutterBottom sx={{ fontWeight: 600 }}>
              Support
            </Typography>
            {footerLinks.support.map((link) => (
              <MuiLink
                key={link.label}
                component={Link}
                href={link.href}
                display="block"
                sx={{
                  color: 'grey.400',
                  textDecoration: 'none',
                  mb: 1,
                  '&:hover': { color: 'primary.main' },
                }}
              >
                {link.label}
              </MuiLink>
            ))}
          </Grid>

          <Grid item xs={6} md={2}>
            <Typography variant="h6" gutterBottom sx={{ fontWeight: 600 }}>
              Legal
            </Typography>
            {footerLinks.legal.map((link) => (
              <MuiLink
                key={link.label}
                component={Link}
                href={link.href}
                display="block"
                sx={{
                  color: 'grey.400',
                  textDecoration: 'none',
                  mb: 1,
                  '&:hover': { color: 'primary.main' },
                }}
              >
                {link.label}
              </MuiLink>
            ))}
          </Grid>
        </Grid>

        <Divider sx={{ my: 4, borderColor: 'grey.800' }} />

        <Box
          sx={{
            display: 'flex',
            flexDirection: { xs: 'column', md: 'row' },
            justifyContent: 'space-between',
            alignItems: 'center',
            gap: 2,
          }}
        >
          <Typography variant="body2" sx={{ color: 'grey.400' }}>
            © {new Date().getFullYear()} EventsOS. All rights reserved.
          </Typography>
          <Typography variant="body2" sx={{ color: 'grey.400' }}>
            Made with ❤️ for the fashion industry
          </Typography>
        </Box>
      </Container>
    </Box>
  );
}
EOF

# Create main layout component
cat > src/components/layout/Layout.tsx << 'EOF'
'use client';

import React from 'react';
import { Box } from '@mui/material';
import { Header } from './Header';
import { Footer } from './Footer';

interface LayoutProps {
  children: React.ReactNode;
}

export function Layout({ children }: LayoutProps) {
  return (
    <Box sx={{ display: 'flex', flexDirection: 'column', minHeight: '100vh' }}>
      <Header />
      <Box component="main" sx={{ flexGrow: 1 }}>
        {children}
      </Box>
      <Footer />
    </Box>
  );
}
EOF

# Create layout index
cat > src/components/layout/index.ts << 'EOF'
export * from './Header';
export * from './Footer';
export * from './Layout';
EOF

# Create providers index
cat > src/providers/index.ts << 'EOF'
export * from './ThemeProvider';
EOF

# Create root layout with analytics
cat > src/app/layout.tsx << 'EOF'
import * as React from 'react';
import { AppRouterCacheProvider } from '@mui/material-nextjs/v15-appRouter';
import { ThemeProvider } from '@/providers/ThemeProvider';
import { Layout } from '@/components/layout/Layout';
import { SpeedInsights } from '@vercel/speed-insights/next';
import { Analytics } from '@vercel/analytics/react';
import type { Metadata } from 'next';
import '@fontsource/roboto/300.css';
import '@fontsource/roboto/400.css';
import '@fontsource/roboto/500.css';
import '@fontsource/roboto/700.css';

export const metadata: Metadata = {
  title: {
    default: 'EventsOS - AI-Powered Fashion Event Management',
    template: '%s | EventsOS'
  },
  description: 'The ultimate platform for managing fashion events with AI automation, real-time analytics, and seamless attendee experiences.',
  keywords: ['fashion events', 'event management', 'AI automation', 'fashion shows', 'event planning'],
  authors: [{ name: 'EventsOS Team', url: 'https://eventos.com' }],
  creator: 'EventsOS',
  publisher: 'EventsOS',
  metadataBase: new URL('https://eventos.vercel.app'),
  openGraph: {
    type: 'website',
    locale: 'en_US',
    url: 'https://eventos.vercel.app',
    siteName: 'EventsOS',
    title: 'EventsOS - AI-Powered Fashion Event Management',
    description: 'The ultimate platform for managing fashion events with AI automation, real-time analytics, and seamless attendee experiences.',
    images: [
      {
        url: '/images/og-image.png',
        width: 1200,
        height: 630,
        alt: 'EventsOS Platform',
      },
    ],
  },
  twitter: {
    card: 'summary_large_image',
    site: '@eventos',
    creator: '@eventos',
    title: 'EventsOS - AI-Powered Fashion Event Management',
    description: 'The ultimate platform for managing fashion events with AI automation.',
    images: ['/images/twitter-card.png'],
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-video-preview': -1,
      'max-image-preview': 'large',
      'max-snippet': -1,
    },
  },
  verification: {
    google: 'google-site-verification-code',
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <head>
        <meta name="emotion-insertion-point" content="" />
        <link rel="icon" href="/favicon.ico" />
        <link rel="apple-touch-icon" href="/apple-touch-icon.png" />
      </head>
      <body>
        <AppRouterCacheProvider options={{ enableCssLayer: true }}>
          <ThemeProvider>
            <Layout>
              {children}
            </Layout>
            <SpeedInsights />
            <Analytics />
          </ThemeProvider>
        </AppRouterCacheProvider>
      </body>
    </html>
  );
}
EOF

# Create robots.txt
cat > public/robots.txt << 'EOF'
User-agent: *
Allow: /
Disallow: /api/
Disallow: /admin/

Sitemap: https://eventos.vercel.app/sitemap.xml
EOF
```

**Success Criteria**:
- ✅ Material-UI theme configured with EventsOS branding
- ✅ Responsive header and footer components working
- ✅ Navigation system functional on mobile and desktop
- ✅ Analytics and performance monitoring integrated

**Validation Tests**:
```bash
# Test responsive design
pnpm dev
# Visit http://localhost:3000 and test on different screen sizes

# Check navigation functionality
# Test mobile menu and desktop navigation

# Verify analytics integration
# Check browser network tab for analytics calls
```

---

### Task 3.3: Create Marketing Pages and Content

**Purpose**: Build comprehensive marketing pages including homepage, features, pricing, and about pages with compelling content and SEO optimization

**Dependencies**: Task 3.2 completed successfully

**Reference Links**:
- [Next.js App Router](https://nextjs.org/docs/app)
- [Material-UI Components](https://v6.mui.com/material-ui/all-components/)

**Step-by-Step Instructions**:

1. **Create Homepage with Hero Section**
   - Build compelling hero section with value proposition
   - Add feature highlights and social proof
   - Include call-to-action sections

2. **Build Features Page**
   - Showcase EventsOS key features
   - Add detailed feature descriptions
   - Include screenshots and demonstrations

3. **Create Pricing Page**
   - Display pricing tiers and plans
   - Add feature comparisons
   - Include FAQ section

4. **Build About and Contact Pages**
   - Tell the EventsOS story
   - Add team information
   - Create contact forms and information

5. **Implement SEO Optimization**
   - Add structured data markup
   - Optimize meta tags and descriptions
   - Create sitemap and proper URL structure

**Commands**:
```bash
# Create homepage
cat > src/app/page.tsx << 'EOF'
'use client';

import React from 'react';
import {
  Box,
  Container,
  Typography,
  Button,
  Grid,
  Card,
  CardContent,
  Avatar,
  Rating,
  Chip,
} from '@mui/material';
import {
  Event as EventIcon,
  Analytics as AnalyticsIcon,
  Security as SecurityIcon,
  Speed as SpeedIcon,
  People as PeopleIcon,
  Business as BusinessIcon,
} from '@mui/icons-material';

const features = [
  {
    icon: <EventIcon sx={{ fontSize: 40 }} />,
    title: 'Event Management',
    description: 'Complete lifecycle management for fashion shows, trade shows, and corporate events.',
  },
  {
    icon: <AnalyticsIcon sx={{ fontSize: 40 }} />,
    title: 'Real-time Analytics',
    description: 'Track performance, attendance, and engagement with powerful analytics dashboards.',
  },
  {
    icon: <SecurityIcon sx={{ fontSize: 40 }} />,
    title: 'Enterprise Security',
    description: 'Bank-grade security with multi-tenant architecture and role-based access control.',
  },
  {
    icon: <SpeedIcon sx={{ fontSize: 40 }} />,
    title: 'AI Automation',
    description: 'Automated workflows, smart scheduling, and intelligent recommendations.',
  },
  {
    icon: <PeopleIcon sx={{ fontSize: 40 }} />,
    title: 'Attendee Experience',
    description: 'Seamless registration, check-in, and networking with mobile-first design.',
  },
  {
    icon: <BusinessIcon sx={{ fontSize: 40 }} />,
    title: 'Sponsor Management',
    description: 'Complete sponsor lifecycle management with ROI tracking and automation.',
  },
];

const testimonials = [
  {
    name: 'Sarah Johnson',
    role: 'Fashion Week Director',
    company: 'Milano Fashion Group',
    rating: 5,
    content: 'EventsOS transformed our fashion week operations. The AI automation saved us 40+ hours per event.',
    avatar: '/images/testimonials/sarah.jpg',
  },
  {
    name: 'Marcus Chen',
    role: 'Event Producer',
    company: 'Elite Events Co.',
    rating: 5,
    content: 'The real-time analytics and sponsor management features are game-changing for our business.',
    avatar: '/images/testimonials/marcus.jpg',
  },
  {
    name: 'Isabella Rodriguez',
    role: 'Creative Director',
    company: 'Runway Collective',
    rating: 5,
    content: 'Finally, a platform built specifically for the fashion industry. The attention to detail is incredible.',
    avatar: '/images/testimonials/isabella.jpg',
  },
];

export default function HomePage() {
  return (
    <Box>
      {/* Hero Section */}
      <Box
        sx={{
          background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
          color: 'white',
          py: { xs: 8, md: 12 },
          textAlign: 'center',
        }}
      >
        <Container maxWidth="lg">
          <Typography
            variant="h1"
            component="h1"
            gutterBottom
            sx={{ fontWeight: 700, mb: 3 }}
          >
            The Future of Fashion Event Management
          </Typography>
          <Typography
            variant="h5"
            component="h2"
            gutterBottom
            sx={{ mb: 4, opacity: 0.9, maxWidth: 800, mx: 'auto' }}
          >
            AI-powered platform for managing fashion shows, trade events, and corporate gatherings 
            with real-time analytics, automated workflows, and seamless attendee experiences.
          </Typography>
          <Box sx={{ display: 'flex', gap: 2, justifyContent: 'center', flexWrap: 'wrap' }}>
            <Button
              variant="contained"
              size="large"
              sx={{
                backgroundColor: 'white',
                color: 'primary.main',
                px: 4,
                py: 1.5,
                fontSize: '1.1rem',
                '&:hover': {
                  backgroundColor: 'grey.100',
                },
              }}
              href="/admin"
              target="_blank"
            >
              Start Free Trial
            </Button>
            <Button
              variant="outlined"
              size="large"
              sx={{
                borderColor: 'white',
                color: 'white',
                px: 4,
                py: 1.5,
                fontSize: '1.1rem',
                '&:hover': {
                  borderColor: 'white',
                  backgroundColor: 'rgba(255, 255, 255, 0.1)',
                },
              }}
              href="/events"
            >
              View Demo
            </Button>
          </Box>
          <Box sx={{ mt: 6, display: 'flex', justifyContent: 'center', gap: 4, flexWrap: 'wrap' }}>
            <Chip label="500+ Events Managed" sx={{ backgroundColor: 'rgba(255,255,255,0.2)', color: 'white' }} />
            <Chip label="50K+ Attendees" sx={{ backgroundColor: 'rgba(255,255,255,0.2)', color: 'white' }} />
            <Chip label="99.9% Uptime" sx={{ backgroundColor: 'rgba(255,255,255,0.2)', color: 'white' }} />
          </Box>
        </Container>
      </Box>

      {/* Features Section */}
      <Box sx={{ py: { xs: 8, md: 12 } }}>
        <Container maxWidth="lg">
          <Typography
            variant="h2"
            component="h2"
            textAlign="center"
            gutterBottom
            sx={{ mb: 6 }}
          >
            Everything You Need for Perfect Events
          </Typography>
          <Grid container spacing={4}>
            {features.map((feature, index) => (
              <Grid item xs={12} md={4} key={index}>
                <Card sx={{ height: '100%', textAlign: 'center', p: 2 }}>
                  <CardContent>
                    <Box sx={{ color: 'primary.main', mb: 2 }}>
                      {feature.icon}
                    </Box>
                    <Typography variant="h6" component="h3" gutterBottom>
                      {feature.title}
                    </Typography>
                    <Typography variant="body1" color="text.secondary">
                      {feature.description}
                    </Typography>
                  </CardContent>
                </Card>
              </Grid>
            ))}
          </Grid>
        </Container>
      </Box>

      {/* Testimonials Section */}
      <Box sx={{ py: { xs: 8, md: 12 }, backgroundColor: 'grey.50' }}>
        <Container maxWidth="lg">
          <Typography
            variant="h2"
            component="h2"
            textAlign="center"
            gutterBottom
            sx={{ mb: 6 }}
          >
            Trusted by Fashion Industry Leaders
          </Typography>
          <Grid container spacing={4}>
            {testimonials.map((testimonial, index) => (
              <Grid item xs={12} md={4} key={index}>
                <Card sx={{ height: '100%' }}>
                  <CardContent sx={{ p: 3 }}>
                    <Box sx={{ display: 'flex', alignItems: 'center', mb: 2 }}>
                      <Avatar
                        src={testimonial.avatar}
                        alt={testimonial.name}
                        sx={{ width: 50, height: 50, mr: 2 }}
                      />
                      <Box>
                        <Typography variant="h6" component="h4">
                          {testimonial.name}
                        </Typography>
                        <Typography variant="body2" color="text.secondary">
                          {testimonial.role} at {testimonial.company}
                        </Typography>
                      </Box>
                    </Box>
                    <Rating value={testimonial.rating} readOnly sx={{ mb: 2 }} />
                    <Typography variant="body1">
                      "{testimonial.content}"
                    </Typography>
                  </CardContent>
                </Card>
              </Grid>
            ))}
          </Grid>
        </Container>
      </Box>

      {/* CTA Section */}
      <Box
        sx={{
          py: { xs: 8, md: 12 },
          background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
          color: 'white',
          textAlign: 'center',
        }}
      >
        <Container maxWidth="md">
          <Typography
            variant="h2"
            component="h2"
            gutterBottom
            sx={{ mb: 3 }}
          >
            Ready to Transform Your Events?
          </Typography>
          <Typography
            variant="h6"
            component="p"
            gutterBottom
            sx={{ mb: 4, opacity: 0.9 }}
          >
            Join hundreds of event organizers who have revolutionized their fashion events with EventsOS.
          </Typography>
          <Button
            variant="contained"
            size="large"
            sx={{
              backgroundColor: 'white',
              color: 'primary.main',
              px: 4,
              py: 1.5,
              fontSize: '1.1rem',
              '&:hover': {
                backgroundColor: 'grey.100',
              },
            }}
            href="/admin"
            target="_blank"
          >
            Start Your Free Trial
          </Button>
        </Container>
      </Box>
    </Box>
  );
}
EOF

# Create features page
mkdir -p src/app/(marketing)/features
cat > src/app/(marketing)/features/page.tsx << 'EOF'
'use client';

import React from 'react';
import {
  Box,
  Container,
  Typography,
  Grid,
  Card,
  CardContent,
  List,
  ListItem,
  ListItemIcon,
  ListItemText,
} from '@mui/material';
import {
  CheckCircle as CheckIcon,
  Event as EventIcon,
  Analytics as AnalyticsIcon,
  Security as SecurityIcon,
  Speed as SpeedIcon,
  People as PeopleIcon,
  Business as BusinessIcon,
  Phone as PhoneIcon,
  Email as EmailIcon,
} from '@mui/icons-material';

const featureCategories = [
  {
    icon: <EventIcon sx={{ fontSize: 48 }} />,
    title: 'Event Management',
    description: 'Complete event lifecycle management built for fashion industry professionals.',
    features: [
      'Multi-venue event planning and scheduling',
      'Fashion show runway management',
      'Trade show booth coordination',
      'VIP and press accreditation',
      'Real-time event monitoring',
      'Mobile-first event apps',
    ],
  },
  {
    icon: <AnalyticsIcon sx={{ fontSize: 48 }} />,
    title: 'Analytics & Reporting',
    description: 'Comprehensive analytics and insights to optimize your event performance.',
    features: [
      'Real-time attendance tracking',
      'Engagement analytics and heat maps',
      'Sponsor ROI measurement',
      'Social media integration and tracking',
      'Custom dashboard creation',
      'Automated performance reports',
    ],
  },
  {
    icon: <PeopleIcon sx={{ fontSize: 48 }} />,
    title: 'Attendee Experience',
    description: 'Create unforgettable experiences with seamless attendee journey management.',
    features: [
      'QR code-based check-in system',
      'Personalized event schedules',
      'Networking and matchmaking',
      'Live voting and Q&A',
      'Digital business card exchange',
      'Post-event feedback collection',
    ],
  },
  {
    icon: <BusinessIcon sx={{ fontSize: 48 }} />,
    title: 'Sponsor Management',
    description: 'End-to-end sponsor lifecycle management with automated workflows.',
    features: [
      'Sponsor onboarding automation',
      'Digital asset management',
      'Brand guidelines enforcement',
      'Performance tracking dashboards',
      'Automated billing and invoicing',
      'Contract management system',
    ],
  },
  {
    icon: <SpeedIcon sx={{ fontSize: 48 }} />,
    title: 'AI Automation',
    description: 'Intelligent automation to streamline operations and reduce manual work.',
    features: [
      'Smart scheduling optimization',
      'Automated email campaigns',
      'Predictive attendance modeling',
      'Dynamic pricing recommendations',
      'Content auto-generation',
      'Risk assessment algorithms',
    ],
  },
  {
    icon: <SecurityIcon sx={{ fontSize: 48 }} />,
    title: 'Security & Compliance',
    description: 'Enterprise-grade security with multi-tenant architecture and compliance.',
    features: [
      'SOC 2 Type II certified',
      'GDPR and CCPA compliant',
      'Multi-factor authentication',
      'Role-based access control',
      'Data encryption at rest and transit',
      'Regular security audits',
    ],
  },
];

const integrations = [
  'Stripe for payments',
  'SendGrid for email automation',
  'Salesforce CRM integration',
  'Zoom for virtual events',
  'Social media platforms',
  'Calendar synchronization',
  'Accounting software',
  'Marketing automation tools',
];

export default function FeaturesPage() {
  return (
    <Box>
      {/* Hero Section */}
      <Box sx={{ py: { xs: 6, md: 10 }, backgroundColor: 'grey.50' }}>
        <Container maxWidth="lg">
          <Typography
            variant="h1"
            component="h1"
            textAlign="center"
            gutterBottom
            sx={{ mb: 3 }}
          >
            Powerful Features for Modern Events
          </Typography>
          <Typography
            variant="h5"
            component="h2"
            textAlign="center"
            color="text.secondary"
            sx={{ maxWidth: 800, mx: 'auto' }}
          >
            Everything you need to plan, execute, and analyze successful fashion events. 
            Built with industry expertise and cutting-edge technology.
          </Typography>
        </Container>
      </Box>

      {/* Features Grid */}
      <Box sx={{ py: { xs: 8, md: 12 } }}>
        <Container maxWidth="lg">
          <Grid container spacing={6}>
            {featureCategories.map((category, index) => (
              <Grid item xs={12} md={6} key={index}>
                <Card sx={{ height: '100%', p: 2 }}>
                  <CardContent>
                    <Box sx={{ display: 'flex', alignItems: 'center', mb: 3 }}>
                      <Box sx={{ color: 'primary.main', mr: 2 }}>
                        {category.icon}
                      </Box>
                      <Box>
                        <Typography variant="h4" component="h3" gutterBottom>
                          {category.title}
                        </Typography>
                        <Typography variant="body1" color="text.secondary">
                          {category.description}
                        </Typography>
                      </Box>
                    </Box>
                    <List>
                      {category.features.map((feature, featureIndex) => (
                        <ListItem key={featureIndex} sx={{ px: 0 }}>
                          <ListItemIcon>
                            <CheckIcon color="primary" />
                          </ListItemIcon>
                          <ListItemText primary={feature} />
                        </ListItem>
                      ))}
                    </List>
                  </CardContent>
                </Card>
              </Grid>
            ))}
          </Grid>
        </Container>
      </Box>

      {/* Integrations Section */}
      <Box sx={{ py: { xs: 8, md: 12 }, backgroundColor: 'grey.50' }}>
        <Container maxWidth="lg">
          <Typography
            variant="h2"
            component="h2"
            textAlign="center"
            gutterBottom
            sx={{ mb: 6 }}
          >
            Seamless Integrations
          </Typography>
          <Typography
            variant="h6"
            component="p"
            textAlign="center"
            color="text.secondary"
            sx={{ mb: 6, maxWidth: 600, mx: 'auto' }}
          >
            EventsOS integrates with your favorite tools to create a unified event management ecosystem.
          </Typography>
          <Grid container spacing={2}>
            {integrations.map((integration, index) => (
              <Grid item xs={12} sm={6} md={3} key={index}>
                <Card sx={{ textAlign: 'center', p: 2 }}>
                  <CardContent>
                    <Typography variant="body1" sx={{ fontWeight: 500 }}>
                      {integration}
                    </Typography>
                  </CardContent>
                </Card>
              </Grid>
            ))}
          </Grid>
        </Container>
      </Box>
    </Box>
  );
}
EOF

# Create pricing page
mkdir -p src/app/(marketing)/pricing
cat > src/app/(marketing)/pricing/page.tsx << 'EOF'
'use client';

import React from 'react';
import {
  Box,
  Container,
  Typography,
  Grid,
  Card,
  CardContent,
  CardActions,
  Button,
  List,
  ListItem,
  ListItemIcon,
  ListItemText,
  Chip,
  Divider,
} from '@mui/material';
import {
  CheckCircle as CheckIcon,
  Star as StarIcon,
} from '@mui/icons-material';

const pricingTiers = [
  {
    name: 'Starter',
    price: 49,
    period: 'month',
    description: 'Perfect for small fashion events and emerging designers',
    features: [
      'Up to 100 attendees per event',
      '3 events per month',
      'Basic analytics dashboard',
      'Email support',
      'Mobile check-in app',
      'Basic sponsor management',
    ],
    buttonText: 'Start Free Trial',
    buttonVariant: 'outlined' as const,
    popular: false,
  },
  {
    name: 'Professional',
    price: 149,
    period: 'month',
    description: 'Ideal for established fashion brands and event agencies',
    features: [
      'Up to 1,000 attendees per event',
      'Unlimited events',
      'Advanced analytics & reporting',
      'Priority support',
      'Custom branding',
      'Advanced sponsor management',
      'API access',
      'Integrations',
    ],
    buttonText: 'Start Free Trial',
    buttonVariant: 'contained' as const,
    popular: true,
  },
  {
    name: 'Enterprise',
    price: 449,
    period: 'month',
    description: 'For large fashion weeks and multi-venue events',
    features: [
      'Unlimited attendees',
      'Unlimited events',
      'White-label solution',
      'Dedicated success manager',
      'Custom integrations',
      'Advanced security features',
      'Multi-tenant architecture',
      'SLA guarantee',
      'On-premise deployment option',
    ],
    buttonText: 'Contact Sales',
    buttonVariant: 'outlined' as const,
    popular: false,
  },
];

const faqs = [
  {
    question: 'What is included in the free trial?',
    answer: 'The 14-day free trial includes full access to all features in your chosen plan, with no restrictions. No credit card required.',
  },
  {
    question: 'Can I change plans at any time?',
    answer: 'Yes, you can upgrade or downgrade your plan at any time. Changes take effect immediately, and billing is prorated.',
  },
  {
    question: 'Do you offer custom pricing for large organizations?',
    answer: 'Yes, we offer custom enterprise pricing for organizations with specific needs or high-volume requirements. Contact our sales team for a quote.',
  },
  {
    question: 'What payment methods do you accept?',
    answer: 'We accept all major credit cards, ACH transfers, and wire transfers for enterprise customers.',
  },
  {
    question: 'Is there a setup fee?',
    answer: 'No, there are no setup fees. You only pay the monthly subscription fee for your chosen plan.',
  },
  {
    question: 'Can I cancel my subscription at any time?',
    answer: 'Yes, you can cancel your subscription at any time. Your account will remain active until the end of your billing period.',
  },
];

export default function PricingPage() {
  return (
    <Box>
      {/* Hero Section */}
      <Box sx={{ py: { xs: 6, md: 10 }, backgroundColor: 'grey.50' }}>
        <Container maxWidth="lg">
          <Typography
            variant="h1"
            component="h1"
            textAlign="center"
            gutterBottom
            sx={{ mb: 3 }}
          >
            Simple, Transparent Pricing
          </Typography>
          <Typography
            variant="h5"
            component="h2"
            textAlign="center"
            color="text.secondary"
            sx={{ maxWidth: 600, mx: 'auto' }}
          >
            Choose the perfect plan for your fashion events. Start with a free trial, no credit card required.
          </Typography>
        </Container>
      </Box>

      {/* Pricing Cards */}
      <Box sx={{ py: { xs: 8, md: 12 } }}>
        <Container maxWidth="lg">
          <Grid container spacing={4} alignItems="stretch">
            {pricingTiers.map((tier, index) => (
              <Grid item xs={12} md={4} key={index}>
                <Card
                  sx={{
                    height: '100%',
                    display: 'flex',
                    flexDirection: 'column',
                    position: 'relative',
                    ...(tier.popular && {
                      border: '2px solid',
                      borderColor: 'primary.main',
                      transform: 'scale(1.05)',
                    }),
                  }}
                >
                  {tier.popular && (
                    <Chip
                      label="Most Popular"
                      color="primary"
                      icon={<StarIcon />}
                      sx={{
                        position: 'absolute',
                        top: -12,
                        left: '50%',
                        transform: 'translateX(-50%)',
                      }}
                    />
                  )}
                  <CardContent sx={{ flexGrow: 1, p: 4 }}>
                    <Typography variant="h4" component="h3" gutterBottom>
                      {tier.name}
                    </Typography>
                    <Box sx={{ display: 'flex', alignItems: 'baseline', mb: 2 }}>
                      <Typography variant="h3" component="span" color="primary">
                        ${tier.price}
                      </Typography>
                      <Typography variant="h6" component="span" color="text.secondary">
                        /{tier.period}
                      </Typography>
                    </Box>
                    <Typography variant="body1" color="text.secondary" sx={{ mb: 3 }}>
                      {tier.description}
                    </Typography>
                    <List>
                      {tier.features.map((feature, featureIndex) => (
                        <ListItem key={featureIndex} sx={{ px: 0, py: 0.5 }}>
                          <ListItemIcon sx={{ minWidth: 36 }}>
                            <CheckIcon color="primary" fontSize="small" />
                          </ListItemIcon>
                          <ListItemText 
                            primary={feature} 
                            primaryTypographyProps={{ variant: 'body2' }}
                          />
                        </ListItem>
                      ))}
                    </List>
                  </CardContent>
                  <CardActions sx={{ p: 4, pt: 0 }}>
                    <Button
                      variant={tier.buttonVariant}
                      color="primary"
                      size="large"
                      fullWidth
                      href={tier.buttonText === 'Contact Sales' ? '/contact' : '/admin'}
                      target={tier.buttonText === 'Contact Sales' ? '_self' : '_blank'}
                    >
                      {tier.buttonText}
                    </Button>
                  </CardActions>
                </Card>
              </Grid>
            ))}
          </Grid>
        </Container>
      </Box>

      {/* FAQ Section */}
      <Box sx={{ py: { xs: 8, md: 12 }, backgroundColor: 'grey.50' }}>
        <Container maxWidth="md">
          <Typography
            variant="h2"
            component="h2"
            textAlign="center"
            gutterBottom
            sx={{ mb: 6 }}
          >
            Frequently Asked Questions
          </Typography>
          <Grid container spacing={3}>
            {faqs.map((faq, index) => (
              <Grid item xs={12} key={index}>
                <Card>
                  <CardContent sx={{ p: 3 }}>
                    <Typography variant="h6" component="h4" gutterBottom>
                      {faq.question}
                    </Typography>
                    <Typography variant="body1" color="text.secondary">
                      {faq.answer}
                    </Typography>
                  </CardContent>
                </Card>
              </Grid>
            ))}
          </Grid>
        </Container>
      </Box>

      {/* CTA Section */}
      <Box
        sx={{
          py: { xs: 8, md: 12 },
          background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
          color: 'white',
          textAlign: 'center',
        }}
      >
        <Container maxWidth="md">
          <Typography variant="h2" component="h2" gutterBottom>
            Ready to Get Started?
          </Typography>
          <Typography variant="h6" component="p" sx={{ mb: 4, opacity: 0.9 }}>
            Join thousands of event organizers who trust EventsOS for their fashion events.
          </Typography>
          <Button
            variant="contained"
            size="large"
            sx={{
              backgroundColor: 'white',
              color: 'primary.main',
              px: 4,
              py: 1.5,
              '&:hover': { backgroundColor: 'grey.100' },
            }}
            href="/admin"
            target="_blank"
          >
            Start Your Free Trial
          </Button>
        </Container>
      </Box>
    </Box>
  );
}
EOF

# Create about page
mkdir -p src/app/(marketing)/about
cat > src/app/(marketing)/about/page.tsx << 'EOF'
'use client';

import React from 'react';
import {
  Box,
  Container,
  Typography,
  Grid,
  Card,
  CardContent,
  Avatar,
  Chip,
} from '@mui/material';
import {
  LinkedIn as LinkedInIcon,
  Twitter as TwitterIcon,
} from '@mui/icons-material';

const team = [
  {
    name: 'Alex Thompson',
    role: 'CEO & Co-Founder',
    bio: 'Former fashion week director with 15+ years in event management. Led digital transformation at major fashion houses.',
    avatar: '/images/team/alex.jpg',
    linkedin: 'https://linkedin.com/in/alexthompson',
    twitter: 'https://twitter.com/alexthompson',
  },
  {
    name: 'Maria Garcia',
    role: 'CTO & Co-Founder',
    bio: 'Ex-Google engineer specializing in AI and scalable systems. Built event platforms used by millions.',
    avatar: '/images/team/maria.jpg',
    linkedin: 'https://linkedin.com/in/mariagarcia',
    twitter: 'https://twitter.com/mariagarcia',
  },
  {
    name: 'David Chen',
    role: 'Head of Product',
    bio: 'Product leader from Airbnb with expertise in marketplace and event experiences. Fashion industry veteran.',
    avatar: '/images/team/david.jpg',
    linkedin: 'https://linkedin.com/in/davidchen',
    twitter: 'https://twitter.com/davidchen',
  },
  {
    name: 'Sophie Laurent',
    role: 'Head of Design',
    bio: 'Award-winning designer from Figma. Passionate about creating beautiful, accessible experiences.',
    avatar: '/images/team/sophie.jpg',
    linkedin: 'https://linkedin.com/in/sophielaurent',
    twitter: 'https://twitter.com/sophielaurent',
  },
];

const values = [
  {
    title: 'Innovation First',
    description: 'We push the boundaries of what\'s possible in event technology, always staying ahead of industry trends.',
  },
  {
    title: 'Fashion-Focused',
    description: 'Built by fashion industry veterans who understand the unique challenges and opportunities.',
  },
  {
    title: 'User-Centric',
    description: 'Every feature is designed with our users in mind, prioritizing simplicity and effectiveness.',
  },
  {
    title: 'Global Scale',
    description: 'Supporting events worldwide with enterprise-grade reliability and security.',
  },
];

const milestones = [
  { year: '2020', event: 'EventsOS founded by fashion industry veterans' },
  { year: '2021', event: 'First major fashion week partnership' },
  { year: '2022', event: 'AI automation platform launched' },
  { year: '2023', event: 'Series A funding raised, 500+ events managed' },
  { year: '2024', event: 'Global expansion and enterprise partnerships' },
  { year: '2025', event: 'Leading platform for fashion event management' },
];

export default function AboutPage() {
  return (
    <Box>
      {/* Hero Section */}
      <Box sx={{ py: { xs: 6, md: 10 }, backgroundColor: 'grey.50' }}>
        <Container maxWidth="lg">
          <Typography
            variant="h1"
            component="h1"
            textAlign="center"
            gutterBottom
            sx={{ mb: 3 }}
          >
            Revolutionizing Fashion Events
          </Typography>
          <Typography
            variant="h5"
            component="h2"
            textAlign="center"
            color="text.secondary"
            sx={{ maxWidth: 800, mx: 'auto', mb: 6 }}
          >
            EventsOS was born from the vision to transform how fashion events are planned, 
            executed, and experienced. We combine industry expertise with cutting-edge technology 
            to create unforgettable moments.
          </Typography>
        </Container>
      </Box>

      {/* Story Section */}
      <Box sx={{ py: { xs: 8, md: 12 } }}>
        <Container maxWidth="lg">
          <Grid container spacing={6} alignItems="center">
            <Grid item xs={12} md={6}>
              <Typography variant="h2" component="h2" gutterBottom>
                Our Story
              </Typography>
              <Typography variant="body1" paragraph sx={{ fontSize: '1.1rem', lineHeight: 1.7 }}>
                EventsOS was founded in 2020 by a team of fashion industry veterans and 
                technology experts who experienced firsthand the challenges of managing 
                complex fashion events. From runway shows to trade exhibitions, we saw 
                how outdated tools and manual processes were holding back the industry.
              </Typography>
              <Typography variant="body1" paragraph sx={{ fontSize: '1.1rem', lineHeight: 1.7 }}>
                Our mission is simple: to provide fashion professionals with the most 
                advanced, intuitive, and reliable event management platform available. 
                We believe that great events should be seamless experiences, powered by 
                intelligent automation and real-time insights.
              </Typography>
              <Typography variant="body1" sx={{ fontSize: '1.1rem', lineHeight: 1.7 }}>
                Today, EventsOS powers hundreds of fashion events worldwide, from intimate 
                designer showcases to major international fashion weeks. We're proud to be 
                the technology partner that helps bring creative visions to life.
              </Typography>
            </Grid>
            <Grid item xs={12} md={6}>
              <Box
                sx={{
                  height: 400,
                  backgroundImage: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
                  borderRadius: 2,
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  color: 'white',
                }}
              >
                <Typography variant="h4" textAlign="center">
                  Fashion Event Excellence<br />Since 2020
                </Typography>
              </Box>
            </Grid>
          </Grid>
        </Container>
      </Box>

      {/* Values Section */}
      <Box sx={{ py: { xs: 8, md: 12 }, backgroundColor: 'grey.50' }}>
        <Container maxWidth="lg">
          <Typography
            variant="h2"
            component="h2"
            textAlign="center"
            gutterBottom
            sx={{ mb: 6 }}
          >
            Our Values
          </Typography>
          <Grid container spacing={4}>
            {values.map((value, index) => (
              <Grid item xs={12} md={6} key={index}>
                <Card sx={{ height: '100%' }}>
                  <CardContent sx={{ p: 4 }}>
                    <Typography variant="h5" component="h3" gutterBottom>
                      {value.title}
                    </Typography>
                    <Typography variant="body1" color="text.secondary">
                      {value.description}
                    </Typography>
                  </CardContent>
                </Card>
              </Grid>
            ))}
          </Grid>
        </Container>
      </Box>

      {/* Team Section */}
      <Box sx={{ py: { xs: 8, md: 12 } }}>
        <Container maxWidth="lg">
          <Typography
            variant="h2"
            component="h2"
            textAlign="center"
            gutterBottom
            sx={{ mb: 6 }}
          >
            Meet Our Team
          </Typography>
          <Grid container spacing={4}>
            {team.map((member, index) => (
              <Grid item xs={12} sm={6} md={3} key={index}>
                <Card sx={{ textAlign: 'center', height: '100%' }}>
                  <CardContent sx={{ p: 3 }}>
                    <Avatar
                      src={member.avatar}
                      alt={member.name}
                      sx={{ width: 120, height: 120, mx: 'auto', mb: 2 }}
                    />
                    <Typography variant="h6" component="h4" gutterBottom>
                      {member.name}
                    </Typography>
                    <Chip
                      label={member.role}
                      color="primary"
                      variant="outlined"
                      sx={{ mb: 2 }}
                    />
                    <Typography variant="body2" color="text.secondary" paragraph>
                      {member.bio}
                    </Typography>
                  </CardContent>
                </Card>
              </Grid>
            ))}
          </Grid>
        </Container>
      </Box>

      {/* Timeline Section */}
      <Box sx={{ py: { xs: 8, md: 12 }, backgroundColor: 'grey.50' }}>
        <Container maxWidth="md">
          <Typography
            variant="h2"
            component="h2"
            textAlign="center"
            gutterBottom
            sx={{ mb: 6 }}
          >
            Our Journey
          </Typography>
          <Box sx={{ position: 'relative' }}>
            {milestones.map((milestone, index) => (
              <Box
                key={index}
                sx={{
                  display: 'flex',
                  alignItems: 'center',
                  mb: 4,
                  '&:last-child': { mb: 0 },
                }}
              >
                <Box
                  sx={{
                    width: 60,
                    height: 60,
                    borderRadius: '50%',
                    backgroundColor: 'primary.main',
                    color: 'white',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    fontWeight: 600,
                    mr: 3,
                  }}
                >
                  {milestone.year}
                </Box>
                <Typography variant="body1" sx={{ fontSize: '1.1rem' }}>
                  {milestone.event}
                </Typography>
              </Box>
            ))}
          </Box>
        </Container>
      </Box>
    </Box>
  );
}
EOF

# Create contact page
mkdir -p src/app/(marketing)/contact
cat > src/app/(marketing)/contact/page.tsx << 'EOF'
'use client';

import React, { useState } from 'react';
import {
  Box,
  Container,
  Typography,
  Grid,
  Card,
  CardContent,
  TextField,
  Button,
  Alert,
} from '@mui/material';
import {
  Email as EmailIcon,
  Phone as PhoneIcon,
  LocationOn as LocationIcon,
  Chat as ChatIcon,
} from '@mui/icons-material';

const contactMethods = [
  {
    icon: <EmailIcon sx={{ fontSize: 40 }} />,
    title: 'Email Support',
    description: 'Get help from our support team',
    contact: 'support@eventos.com',
    action: 'Send Email',
  },
  {
    icon: <PhoneIcon sx={{ fontSize: 40 }} />,
    title: 'Phone Support',
    description: 'Speak directly with our team',
    contact: '+1 (555) 123-4567',
    action: 'Call Now',
  },
  {
    icon: <ChatIcon sx={{ fontSize: 40 }} />,
    title: 'Live Chat',
    description: 'Chat with us in real-time',
    contact: 'Available 24/7',
    action: 'Start Chat',
  },
  {
    icon: <LocationIcon sx={{ fontSize: 40 }} />,
    title: 'Office',
    description: 'Visit our headquarters',
    contact: 'San Francisco, CA',
    action: 'Get Directions',
  },
];

export default function ContactPage() {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    company: '',
    subject: '',
    message: '',
  });
  const [submitted, setSubmitted] = useState(false);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    // Handle form submission here
    console.log('Form submitted:', formData);
    setSubmitted(true);
  };

  return (
    <Box>
      {/* Hero Section */}
      <Box sx={{ py: { xs: 6, md: 10 }, backgroundColor: 'grey.50' }}>
        <Container maxWidth="lg">
          <Typography
            variant="h1"
            component="h1"
            textAlign="center"
            gutterBottom
            sx={{ mb: 3 }}
          >
            Get in Touch
          </Typography>
          <Typography
            variant="h5"
            component="h2"
            textAlign="center"
            color="text.secondary"
            sx={{ maxWidth: 600, mx: 'auto' }}
          >
            Have questions about EventsOS? We're here to help you create amazing fashion events.
          </Typography>
        </Container>
      </Box>

      {/* Contact Methods */}
      <Box sx={{ py: { xs: 8, md: 12 } }}>
        <Container maxWidth="lg">
          <Grid container spacing={4}>
            {contactMethods.map((method, index) => (
              <Grid item xs={12} sm={6} md={3} key={index}>
                <Card sx={{ textAlign: 'center', height: '100%', p: 2 }}>
                  <CardContent>
                    <Box sx={{ color: 'primary.main', mb: 2 }}>
                      {method.icon}
                    </Box>
                    <Typography variant="h6" component="h3" gutterBottom>
                      {method.title}
                    </Typography>
                    <Typography variant="body2" color="text.secondary" paragraph>
                      {method.description}
                    </Typography>
                    <Typography variant="body1" sx={{ fontWeight: 500, mb: 2 }}>
                      {method.contact}
                    </Typography>
                    <Button variant="outlined" size="small">
                      {method.action}
                    </Button>
                  </CardContent>
                </Card>
              </Grid>
            ))}
          </Grid>
        </Container>
      </Box>

      {/* Contact Form */}
      <Box sx={{ py: { xs: 8, md: 12 }, backgroundColor: 'grey.50' }}>
        <Container maxWidth="md">
          <Typography
            variant="h2"
            component="h2"
            textAlign="center"
            gutterBottom
            sx={{ mb: 6 }}
          >
            Send us a Message
          </Typography>
          
          {submitted ? (
            <Alert severity="success" sx={{ mb: 4 }}>
              Thank you for your message! We'll get back to you within 24 hours.
            </Alert>
          ) : (
            <Card>
              <CardContent sx={{ p: 4 }}>
                <form onSubmit={handleSubmit}>
                  <Grid container spacing={3}>
                    <Grid item xs={12} sm={6}>
                      <TextField
                        fullWidth
                        label="Full Name"
                        name="name"
                        value={formData.name}
                        onChange={handleChange}
                        required
                      />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                      <TextField
                        fullWidth
                        label="Email Address"
                        name="email"
                        type="email"
                        value={formData.email}
                        onChange={handleChange}
                        required
                      />
                    </Grid>
                    <Grid item xs={12}>
                      <TextField
                        fullWidth
                        label="Company"
                        name="company"
                        value={formData.company}
                        onChange={handleChange}
                      />
                    </Grid>
                    <Grid item xs={12}>
                      <TextField
                        fullWidth
                        label="Subject"
                        name="subject"
                        value={formData.subject}
                        onChange={handleChange}
                        required
                      />
                    </Grid>
                    <Grid item xs={12}>
                      <TextField
                        fullWidth
                        label="Message"
                        name="message"
                        value={formData.message}
                        onChange={handleChange}
                        multiline
                        rows={6}
                        required
                      />
                    </Grid>
                    <Grid item xs={12}>
                      <Button
                        type="submit"
                        variant="contained"
                        size="large"
                        fullWidth
                      >
                        Send Message
                      </Button>
                    </Grid>
                  </Grid>
                </form>
              </CardContent>
            </Card>
          )}
        </Container>
      </Box>
    </Box>
  );
}
EOF

# Create sitemap API route
mkdir -p src/app/api/sitemap
cat > src/app/api/sitemap/route.ts << 'EOF'
import { NextResponse } from 'next/server';

export async function GET() {
  const baseUrl = process.env.NEXT_PUBLIC_APP_URL || 'https://eventos.vercel.app';
  
  const routes = [
    '',
    '/features',
    '/pricing',
    '/about',
    '/contact',
    '/events',
    '/blog',
  ];

  const sitemap = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  ${routes
    .map(
      (route) => `
    <url>
      <loc>${baseUrl}${route}</loc>
      <lastmod>${new Date().toISOString()}</lastmod>
      <changefreq>weekly</changefreq>
      <priority>${route === '' ? '1.0' : '0.8'}</priority>
    </url>`
    )
    .join('')}
</urlset>`;

  return new NextResponse(sitemap, {
    headers: {
      'Content-Type': 'application/xml',
    },
  });
}
EOF
```

**Success Criteria**:
- ✅ Homepage with compelling hero section and features
- ✅ Features page showcasing EventsOS capabilities
- ✅ Pricing page with clear tiers and FAQ
- ✅ About page with team and company story
- ✅ Contact page with multiple contact methods
- ✅ SEO optimization with sitemap and metadata

**Validation Tests**:
```bash
# Test all pages
pnpm dev
# Visit each page and verify content and functionality

# Test responsive design
# Check mobile and desktop layouts

# Test SEO
# Visit /sitemap.xml and verify structure
```

---

## ⚙️ Phase 4: Vercel Configuration

### Phase Overview
Configure Vercel deployment settings, set up monorepo deployment, implement security headers, and prepare for production deployment.

---

### Task 4.1: Configure Vercel Monorepo Deployment

**Purpose**: Set up Vercel configuration for monorepo deployment with proper build commands, environment variables, and routing

**Dependencies**: Phase 3 completed successfully

**Reference Links**:
- [Vercel Monorepo Documentation](https://vercel.com/docs/monorepos)
- [Vercel Configuration Reference](https://vercel.com/docs/projects/project-configuration)

**Step-by-Step Instructions**:

1. **Create Vercel Configuration**
   - Set up vercel.json for monorepo deployment
   - Configure build commands and output directories
   - Set up proper routing and redirects

2. **Configure Environment Variables**
   - Set up environment variable templates
   - Configure different environments (preview, production)
   - Add security for sensitive variables

3. **Set Up Domain Configuration**
   - Configure custom domains for both apps
   - Set up SSL certificates and security headers
   - Configure CDN and edge optimization

4. **Implement Security Headers**
   - Add comprehensive security headers
   - Configure Content Security Policy
   - Set up proper CORS and security policies

5. **Test Deployment Configuration**
   - Verify build commands work correctly
   - Test environment variable injection
   - Validate security headers and policies

**Commands**:
```bash
# Return to root directory
cd /home/sk/fx/eventos

# Create comprehensive Vercel configuration
cat > vercel.json << 'EOF'
{
  "buildCommand": "pnpm turbo build",
  "installCommand": "pnpm install --frozen-lockfile",
  "framework": null,
  "outputDirectory": "apps/website/.next",
  "functions": {
    "apps/website/src/app/api/**/*.ts": {
      "maxDuration": 10
    },
    "apps/admin/src/app/api/**/*.ts": {
      "maxDuration": 10
    }
  },
  "crons": [
    {
      "path": "/api/cron/cleanup",
      "schedule": "0 2 * * *"
    }
  ],
  "rewrites": [
    {
      "source": "/sitemap.xml",
      "destination": "/api/sitemap"
    },
    {
      "source": "/admin/:path*",
      "destination": "https://admin-eventos.vercel.app/:path*"
    }
  ],
  "redirects": [
    {
      "source": "/home",
      "destination": "/",
      "permanent": true
    },
    {
      "source": "/dashboard",
      "destination": "/admin",
      "permanent": false
    }
  ],
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Content-Type-Options",
          "value": "nosniff"
        },
        {
          "key": "X-Frame-Options",
          "value": "DENY"
        },
        {
          "key": "X-XSS-Protection",
          "value": "1; mode=block"
        },
        {
          "key": "Referrer-Policy",
          "value": "strict-origin-when-cross-origin"
        },
        {
          "key": "Permissions-Policy",
          "value": "camera=(), microphone=(), geolocation=(), interest-cohort=()"
        },
        {
          "key": "Strict-Transport-Security",
          "value": "max-age=31536000; includeSubDomains; preload"
        },
        {
          "key": "Content-Security-Policy",
          "value": "default-src 'self'; script-src 'self' 'unsafe-eval' 'unsafe-inline' *.vercel-insights.com *.vercel.app; style-src 'self' 'unsafe-inline' fonts.googleapis.com; font-src 'self' fonts.gstatic.com; img-src 'self' data: https: blob:; media-src 'self'; connect-src 'self' *.supabase.co *.vercel-insights.com wss://*.supabase.co; frame-ancestors 'none'; base-uri 'self'; form-action 'self'"
        }
      ]
    },
    {
      "source": "/fonts/(.*)",
      "headers": [
        {
          "key": "Cache-Control",
          "value": "public, max-age=31536000, immutable"
        }
      ]
    },
    {
      "source": "/images/(.*)",
      "headers": [
        {
          "key": "Cache-Control",
          "value": "public, max-age=31536000, immutable"
        }
      ]
    },
    {
      "source": "/_next/static/(.*)",
      "headers": [
        {
          "key": "Cache-Control",
          "value": "public, max-age=31536000, immutable"
        }
      ]
    }
  ],
  "regions": ["iad1"],
  "env": {
    "NEXT_PUBLIC_VERCEL_ENV": "@vercel_env"
  }
}
EOF

# Create deployment documentation
cat > DEPLOYMENT.md << 'EOF'
# EventsOS Deployment Guide

## Architecture

EventsOS is deployed as a monorepo with two applications:
- **Website**: Public-facing marketing site and event listings
- **Admin**: Private admin dashboard for event management

## Vercel Deployment

### Prerequisites
1. Vercel account with team/organization access
2. GitHub repository connected to Vercel
3. Supabase project with proper environment variables

### Environment Variables

#### Required Variables (All Environments)
```
NEXT_PUBLIC_SUPABASE_URL=https://wnjudgmhabzhcttgyxou.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
```

#### Application URLs
```
NEXT_PUBLIC_APP_URL=https://eventos.vercel.app
NEXT_PUBLIC_ADMIN_URL=https://admin-eventos.vercel.app
```

#### Optional Services
```
SENDGRID_API_KEY=your-sendgrid-key
OPENAI_API_KEY=your-openai-key
ANTHROPIC_API_KEY=your-anthropic-key
```

### Deployment Process

#### Website (Main Project)
1. Connect repository to Vercel
2. Set framework preset to "Next.js"
3. Set build command: `pnpm turbo build`
4. Set output directory: `apps/website/.next`
5. Configure environment variables
6. Deploy

#### Admin (Separate Project)
1. Create new Vercel project for admin
2. Set framework preset to "Next.js"
3. Set build command: `cd ../.. && pnpm turbo build --filter=@eventos/admin`
4. Set output directory: `apps/admin/.next`
5. Configure environment variables
6. Deploy

### Domain Configuration

#### Custom Domains
- Website: `eventos.com`
- Admin: `admin.eventos.com`

#### DNS Configuration
```
Type: CNAME
Name: @
Value: eventos.vercel.app

Type: CNAME
Name: admin
Value: admin-eventos.vercel.app
```

### Security Configuration

#### Security Headers
All security headers are configured in `vercel.json` including:
- Content Security Policy (CSP)
- X-Frame-Options
- Strict Transport Security
- Content Type Options

#### Environment Security
- Use Vercel's encrypted environment variables
- Never commit sensitive keys to repository
- Use different keys for preview and production

### Monitoring and Analytics

#### Vercel Analytics
- Speed Insights enabled on website
- Analytics enabled for performance monitoring
- Error tracking through Vercel dashboard

#### Custom Monitoring
- Supabase dashboard for database metrics
- Custom API endpoints for health checks
- Real-time error tracking and alerting

### Deployment Commands

#### CLI Deployment
```bash
# Install Vercel CLI
npm i -g vercel

# Login
vercel login

# Deploy to preview
vercel

# Deploy to production
vercel --prod

# Set environment variables
vercel env add NEXT_PUBLIC_SUPABASE_URL production
vercel env add NEXT_PUBLIC_SUPABASE_ANON_KEY production
```

#### GitHub Integration
- Automatic deployments on push to main branch
- Preview deployments for all pull requests
- Environment variables synced from Vercel dashboard

### Troubleshooting

#### Common Issues
1. **Build Failures**: Check pnpm version and lockfile
2. **Environment Variables**: Verify all required vars are set
3. **Supabase Connection**: Check database URL and keys
4. **Memory Issues**: Increase Node.js memory limit

#### Debug Commands
```bash
# Check build locally
pnpm turbo build

# Verify environment
pnpm env:validate

# Test deployment
vercel build
```

### Performance Optimization

#### Image Optimization
- Next.js Image component with Vercel optimization
- WebP and AVIF format support
- Responsive images with proper sizing

#### Caching Strategy
- Static assets: 1 year cache
- Dynamic content: Proper revalidation
- API responses: Smart caching based on data type

#### Bundle Optimization
- Code splitting for optimal loading
- Tree shaking to remove unused code
- Bundle analysis for size monitoring
EOF

# Create GitHub Actions workflows
mkdir -p .github/workflows

cat > .github/workflows/ci.yml << 'EOF'
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

env:
  TURBO_TOKEN: ${{ secrets.TURBO_TOKEN }}
  TURBO_TEAM: ${{ secrets.TURBO_TEAM }}

jobs:
  lint-and-type-check:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Setup pnpm
        uses: pnpm/action-setup@v2
        with:
          version: 8.15.1
          
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'pnpm'
          
      - name: Install dependencies
        run: pnpm install --frozen-lockfile
      
      - name: Lint
        run: pnpm turbo lint
        
      - name: Type check
        run: pnpm turbo type-check

  build:
    runs-on: ubuntu-latest
    needs: lint-and-type-check
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Setup pnpm
        uses: pnpm/action-setup@v2
        with:
          version: 8.15.1
          
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'pnpm'
          
      - name: Install dependencies
        run: pnpm install --frozen-lockfile
      
      - name: Build packages
        run: pnpm turbo build --filter=packages/*
        
      - name: Build applications
        run: pnpm turbo build --filter=apps/*
        env:
          NEXT_PUBLIC_SUPABASE_URL: ${{ secrets.NEXT_PUBLIC_SUPABASE_URL }}
          NEXT_PUBLIC_SUPABASE_ANON_KEY: ${{ secrets.NEXT_PUBLIC_SUPABASE_ANON_KEY }}
          SKIP_ENV_VALIDATION: true

  test:
    runs-on: ubuntu-latest
    needs: lint-and-type-check
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Setup pnpm
        uses: pnpm/action-setup@v2
        with:
          version: 8.15.1
          
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'pnpm'
          
      - name: Install dependencies
        run: pnpm install --frozen-lockfile
      
      - name: Run tests
        run: pnpm turbo test
        env:
          SKIP_ENV_VALIDATION: true
EOF

cat > .github/workflows/preview-deployment.yml << 'EOF'
name: Preview Deployment

env:
  VERCEL_ORG_ID: ${{ secrets.VERCEL_ORG_ID }}
  VERCEL_PROJECT_ID: ${{ secrets.VERCEL_PROJECT_ID }}

on:
  push:
    branches-ignore:
      - main

jobs:
  deploy-preview:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Setup pnpm
        uses: pnpm/action-setup@v2
        with:
          version: 8.15.1
          
      - name: Install Vercel CLI
        run: npm install --global vercel@latest
        
      - name: Pull Vercel Environment Information
        run: vercel pull --yes --environment=preview --token=${{ secrets.VERCEL_TOKEN }}
        
      - name: Build Project Artifacts
        run: vercel build --token=${{ secrets.VERCEL_TOKEN }}
        
      - name: Deploy Project Artifacts to Vercel
        run: vercel deploy --prebuilt --token=${{ secrets.VERCEL_TOKEN }}
EOF

# Create production readiness checklist
cat > .github/ISSUE_TEMPLATE/production-checklist.md << 'EOF'
---
name: Production Deployment Checklist
about: Complete checklist before production deployment
title: 'Production Deployment - [Date]'
labels: deployment, production
assignees: ''
---

## Pre-deployment Checklist

### Environment Configuration
- [ ] All environment variables set in Vercel dashboard
- [ ] Supabase connection tested and working
- [ ] Environment validation working in both apps
- [ ] Production URLs configured correctly

### Security
- [ ] Security headers configured and tested
- [ ] CSP policy tested with no violations
- [ ] HTTPS enforced on all routes
- [ ] Authentication working properly
- [ ] RLS policies tested and verified

### Performance
- [ ] Lighthouse score > 90 for all critical pages
- [ ] Bundle sizes within acceptable limits
- [ ] Images optimized and loading properly
- [ ] Fonts loading efficiently
- [ ] CDN caching working correctly

### Testing
- [ ] All CI/CD tests passing
- [ ] Manual testing completed
- [ ] Cross-browser testing done
- [ ] Mobile testing completed
- [ ] Error boundaries tested

### Monitoring
- [ ] Vercel Analytics enabled
- [ ] Speed Insights configured
- [ ] Error tracking working
- [ ] Health check endpoints responding
- [ ] Alerts configured for critical issues

### Documentation
- [ ] Deployment documentation updated
- [ ] API documentation current
- [ ] Environment variable documentation complete
- [ ] Troubleshooting guide updated

## Post-deployment Tasks

- [ ] Smoke tests passed
- [ ] DNS propagation verified
- [ ] SSL certificate valid
- [ ] All redirects working
- [ ] Analytics tracking verified
- [ ] Performance baseline established

## Rollback Plan

- [ ] Rollback procedure documented
- [ ] Previous version identified
- [ ] Rollback tested in staging
- [ ] Team notified of rollback procedure

## Sign-off

- [ ] Technical Lead approval
- [ ] Product Owner approval
- [ ] Security review completed
- [ ] Performance review completed
EOF
```

**Success Criteria**:
- ✅ Vercel configuration complete with proper routing
- ✅ Security headers implemented and tested
- ✅ CI/CD pipeline configured with GitHub Actions
- ✅ Documentation complete with deployment procedures

**Validation Tests**:
```bash
# Test build configuration
pnpm turbo build

# Validate environment variables
pnpm turbo build --filter=@eventos/env

# Test security headers locally
curl -I http://localhost:3000
```

---

## 🔐 Phase 5: Security & Performance

### Phase Overview
Implement comprehensive security measures, performance optimizations, testing framework, and monitoring to ensure production readiness.

---

### Task 5.1: Implement Testing Framework

**Purpose**: Set up comprehensive testing framework with unit tests, integration tests, and end-to-end testing for both applications

**Dependencies**: Phase 4 completed successfully

**Reference Links**:
- [Vitest Documentation](https://vitest.dev/)
- [Playwright Testing](https://playwright.dev/)
- [Testing Library](https://testing-library.com/)

**Step-by-Step Instructions**:

1. **Install Testing Dependencies**
   - Add Vitest for unit and integration testing
   - Install Playwright for end-to-end testing
   - Set up Testing Library for React component testing

2. **Configure Testing Environment**
   - Set up Vitest configuration for each app
   - Configure Playwright for browser testing
   - Set up test coverage reporting

3. **Create Test Infrastructure**
   - Set up test utilities and helpers
   - Create mock data and fixtures
   - Configure test database if needed

4. **Write Essential Tests**
   - Add unit tests for critical components
   - Create integration tests for API routes
   - Set up E2E tests for user flows

5. **Integrate Testing into CI/CD**
   - Add test execution to GitHub Actions
   - Set up coverage reporting
   - Configure test result notifications

**Commands**:
```bash
# Install testing dependencies
pnpm add -D vitest @testing-library/react @testing-library/jest-dom @testing-library/user-event --workspace-root
pnpm add -D playwright @playwright/test --workspace-root
pnpm add -D jsdom happy-dom --workspace-root

# Create testing configuration for website
cd apps/website
cat > vitest.config.ts << 'EOF'
import { defineConfig } from 'vitest/config'
import react from '@vitejs/plugin-react'
import { resolve } from 'path'

export default defineConfig({
  plugins: [react()],
  test: {
    environment: 'jsdom',
    setupFiles: ['./src/test/setup.ts'],
    include: ['src/**/*.{test,spec}.{js,mjs,cjs,ts,mts,cts,jsx,tsx}'],
    coverage: {
      reporter: ['text', 'json', 'html'],
      exclude: [
        'node_modules/',
        'src/test/',
        '**/*.d.ts',
        '**/*.config.*',
      ],
    },
  },
  resolve: {
    alias: {
      '@': resolve(__dirname, './src'),
    },
  },
})
EOF

mkdir -p src/test
cat > src/test/setup.ts << 'EOF'
import '@testing-library/jest-dom'

// Mock Next.js router
jest.mock('next/navigation', () => ({
  useRouter() {
    return {
      push: jest.fn(),
      replace: jest.fn(),
      prefetch: jest.fn(),
      back: jest.fn(),
      forward: jest.fn(),
      refresh: jest.fn(),
    }
  },
  useSearchParams() {
    return new URLSearchParams()
  },
  usePathname() {
    return '/'
  },
}))

// Mock Supabase
jest.mock('@/lib/supabase', () => ({
  createClient: () => ({
    auth: {
      getSession: jest.fn().mockResolvedValue({ data: { session: null }, error: null }),
      getUser: jest.fn().mockResolvedValue({ data: { user: null }, error: null }),
    },
    from: jest.fn(() => ({
      select: jest.fn().mockReturnThis(),
      insert: jest.fn().mockReturnThis(),
      update: jest.fn().mockReturnThis(),
      delete: jest.fn().mockReturnThis(),
      eq: jest.fn().mockReturnThis(),
      single: jest.fn().mockResolvedValue({ data: null, error: null }),
    })),
  }),
}))
EOF

# Create example component test
mkdir -p src/components/__tests__
cat > src/components/__tests__/Header.test.tsx << 'EOF'
import { render, screen } from '@testing-library/react'
import { Header } from '../layout/Header'

// Mock Material-UI theme
jest.mock('@mui/material/styles', () => ({
  useTheme: () => ({
    breakpoints: {
      down: () => false,
    },
  }),
  useMediaQuery: () => false,
}))

describe('Header', () => {
  it('renders the EventsOS logo', () => {
    render(<Header />)
    expect(screen.getByText('EventsOS')).toBeInTheDocument()
  })

  it('renders navigation items', () => {
    render(<Header />)
    expect(screen.getByText('Home')).toBeInTheDocument()
    expect(screen.getByText('Events')).toBeInTheDocument()
    expect(screen.getByText('Features')).toBeInTheDocument()
    expect(screen.getByText('Pricing')).toBeInTheDocument()
  })

  it('renders admin dashboard link', () => {
    render(<Header />)
    expect(screen.getByText('Admin Dashboard')).toBeInTheDocument()
  })
})
EOF

# Update website package.json with test scripts
cat > package.json << 'EOF'
{
  "name": "@eventos/website",
  "version": "0.0.1",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "type-check": "tsc --noEmit",
    "test": "vitest",
    "test:watch": "vitest --watch",
    "test:coverage": "vitest --coverage",
    "test:ui": "vitest --ui",
    "clean": "rm -rf .next .turbo node_modules"
  },
  "dependencies": {
    "next": "14.2.29",
    "react": "18.2.0",
    "react-dom": "18.2.0",
    "@mui/material": "6.5.0",
    "@emotion/react": "11.11.3",
    "@emotion/styled": "11.11.0",
    "@mui/material-nextjs": "6.5.0",
    "@mui/icons-material": "6.5.0",
    "@fontsource/roboto": "5.0.8",
    "@supabase/supabase-js": "2.39.3",
    "@vercel/analytics": "1.1.1",
    "@vercel/speed-insights": "1.0.9"
  },
  "devDependencies": {
    "typescript": "5.3.3",
    "@types/react": "18.2.48",
    "@types/react-dom": "18.2.18",
    "@types/node": "20.11.5",
    "eslint": "8.56.0",
    "eslint-config-next": "14.2.29",
    "vitest": "^1.2.0",
    "@testing-library/react": "^14.1.2",
    "@testing-library/jest-dom": "^6.2.0",
    "@testing-library/user-event": "^14.5.2",
    "@vitejs/plugin-react": "^4.2.1",
    "jsdom": "^23.2.0"
  }
}
EOF

# Set up Playwright for E2E testing
cd ../../
pnpm playwright install

cat > playwright.config.ts << 'EOF'
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests/e2e',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',
  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] },
    },
    {
      name: 'webkit',
      use: { ...devices['Desktop Safari'] },
    },
    {
      name: 'Mobile Chrome',
      use: { ...devices['Pixel 5'] },
    },
  ],
  webServer: {
    command: 'pnpm turbo dev --filter=@eventos/website',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
  },
});
EOF

mkdir -p tests/e2e
cat > tests/e2e/homepage.spec.ts << 'EOF'
import { test, expect } from '@playwright/test';

test.describe('Homepage', () => {
  test('should display hero section', async ({ page }) => {
    await page.goto('/');
    
    await expect(page.getByRole('heading', { name: /The Future of Fashion Event Management/i })).toBeVisible();
    await expect(page.getByText(/AI-powered platform for managing fashion shows/i)).toBeVisible();
  });

  test('should navigate to features page', async ({ page }) => {
    await page.goto('/');
    
    await page.getByRole('link', { name: 'Features' }).click();
    await expect(page).toHaveURL('/features');
    await expect(page.getByRole('heading', { name: /Powerful Features for Modern Events/i })).toBeVisible();
  });

  test('should navigate to pricing page', async ({ page }) => {
    await page.goto('/');
    
    await page.getByRole('link', { name: 'Pricing' }).click();
    await expect(page).toHaveURL('/pricing');
    await expect(page.getByRole('heading', { name: /Simple, Transparent Pricing/i })).toBeVisible();
  });

  test('should have working contact form', async ({ page }) => {
    await page.goto('/contact');
    
    await page.fill('input[name="name"]', 'Test User');
    await page.fill('input[name="email"]', 'test@example.com');
    await page.fill('input[name="subject"]', 'Test Subject');
    await page.fill('textarea[name="message"]', 'Test message');
    
    await page.click('button[type="submit"]');
    
    await expect(page.getByText(/Thank you for your message/i)).toBeVisible();
  });

  test('should be responsive on mobile', async ({ page }) => {
    await page.setViewportSize({ width: 375, height: 667 });
    await page.goto('/');
    
    await expect(page.getByRole('heading', { name: /The Future of Fashion Event Management/i })).toBeVisible();
    
    // Test mobile menu
    await page.click('[aria-label="open drawer"]');
    await expect(page.getByRole('link', { name: 'Features' })).toBeVisible();
  });
});
EOF

# Update root package.json with test scripts
cat > package.json << 'EOF'
{
  "name": "eventos",
  "version": "0.0.1",
  "private": true,
  "packageManager": "pnpm@8.15.1",
  "engines": {
    "node": ">=18.0.0",
    "pnpm": ">=8.0.0"
  },
  "scripts": {
    "dev": "turbo run dev",
    "build": "turbo run build",
    "start": "turbo run start",
    "lint": "turbo run lint",
    "type-check": "turbo run type-check",
    "test": "turbo run test",
    "test:e2e": "playwright test",
    "test:e2e:ui": "playwright test --ui",
    "test:coverage": "turbo run test:coverage",
    "clean": "turbo run clean",
    "format": "prettier --write \"**/*.{ts,tsx,md}\"",
    "vercel-build": "turbo run build --filter=@eventos/website"
  },
  "devDependencies": {
    "turbo": "^2.0.0",
    "prettier": "^3.2.5",
    "typescript": "^5.3.3",
    "@types/node": "^20.11.5",
    "vitest": "^1.2.0",
    "@testing-library/react": "^14.1.2",
    "@testing-library/jest-dom": "^6.2.0",
    "@testing-library/user-event": "^14.5.2",
    "playwright": "^1.41.0",
    "@playwright/test": "^1.41.0",
    "jsdom": "^23.2.0"
  }
}
EOF

# Update turbo.json to include test tasks
cat > turbo.json << 'EOF'
{
  "$schema": "https://turbo.build/schema.json",
  "ui": "tui",
  "tasks": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": [".next/**", "!.next/cache/**", "dist/**"],
      "env": [
        "NEXT_PUBLIC_SUPABASE_URL",
        "NEXT_PUBLIC_SUPABASE_ANON_KEY",
        "VERCEL_ENV"
      ]
    },
    "dev": {
      "cache": false,
      "persistent": true
    },
    "lint": {
      "dependsOn": ["^build"]
    },
    "type-check": {
      "dependsOn": ["^build"]
    },
    "test": {
      "dependsOn": ["^build"],
      "outputs": ["coverage/**"]
    },
    "test:coverage": {
      "dependsOn": ["^build"],
      "outputs": ["coverage/**"]
    },
    "clean": {
      "cache": false
    }
  }
}
EOF
```

**Success Criteria**:
- ✅ Vitest configured for unit and integration testing
- ✅ Playwright configured for end-to-end testing
- ✅ Test coverage reporting working
- ✅ CI/CD pipeline includes test execution

**Validation Tests**:
```bash
# Run unit tests
pnpm turbo test

# Run E2E tests
pnpm test:e2e

# Generate coverage report
pnpm test:coverage

# Test in watch mode
pnpm turbo test:watch --filter=@eventos/website
```

---

### Task 5.2: Performance Optimization and Monitoring

**Purpose**: Implement comprehensive performance optimizations, bundle analysis, and monitoring to ensure optimal user experience

**Dependencies**: Task 5.1 completed successfully

**Reference Links**:
- [Next.js Performance](https://nextjs.org/docs/app/building-your-application/optimizing)
- [Vercel Analytics](https://vercel.com/docs/analytics)

**Step-by-Step Instructions**:

1. **Implement Bundle Analysis**
   - Set up webpack bundle analyzer
   - Configure bundle size monitoring
   - Add bundle optimization strategies

2. **Optimize Images and Assets**
   - Configure next/image optimization
   - Set up font optimization
   - Implement asset compression

3. **Add Performance Monitoring**
   - Set up Core Web Vitals tracking
   - Configure performance budgets
   - Add custom performance metrics

4. **Implement Caching Strategies**
   - Configure API response caching
   - Set up static asset caching
   - Implement service worker if needed

5. **Set Up Monitoring Dashboard**
   - Configure Vercel Analytics
   - Set up custom performance tracking
   - Add alert thresholds

**Commands**:
```bash
# Install performance monitoring dependencies
pnpm add -D @next/bundle-analyzer --filter=apps/website
pnpm add -D @next/bundle-analyzer --filter=apps/admin

# Update website next.config.mjs with bundle analyzer
cd apps/website
cat > next.config.mjs << 'EOF'
import bundleAnalyzer from '@next/bundle-analyzer';

const withBundleAnalyzer = bundleAnalyzer({
  enabled: process.env.ANALYZE === 'true',
});

/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  images: {
    domains: ['localhost', 'wnjudgmhabzhcttgyxou.supabase.co'],
    formats: ['image/avif', 'image/webp'],
    deviceSizes: [640, 750, 828, 1080, 1200, 1920, 2048, 3840],
    imageSizes: [16, 32, 48, 64, 96, 128, 256, 384],
  },
  experimental: {
    optimizeCss: true,
  },
  async headers() {
    return [
      {
        source: '/:path*',
        headers: [
          {
            key: 'X-DNS-Prefetch-Control',
            value: 'on'
          },
          {
            key: 'Strict-Transport-Security',
            value: 'max-age=63072000; includeSubDomains; preload'
          },
          {
            key: 'X-Frame-Options',
            value: 'SAMEORIGIN'
          },
          {
            key: 'X-Content-Type-Options',
            value: 'nosniff'
          },
          {
            key: 'Referrer-Policy',
            value: 'strict-origin-when-cross-origin'
          },
          {
            key: 'Permissions-Policy',
            value: 'camera=(), microphone=(), geolocation=()'
          }
        ]
      },
      {
        source: '/fonts/(.*)',
        headers: [
          {
            key: 'Cache-Control',
            value: 'public, max-age=31536000, immutable'
          }
        ]
      },
      {
        source: '/images/(.*)',
        headers: [
          {
            key: 'Cache-Control',
            value: 'public, max-age=31536000, immutable'
          }
        ]
      }
    ];
  },
  async rewrites() {
    return [
      {
        source: '/sitemap.xml',
        destination: '/api/sitemap'
      }
    ];
  }
}

export default withBundleAnalyzer(nextConfig);
EOF

# Create performance monitoring utilities
mkdir -p src/lib/performance
cat > src/lib/performance/index.ts << 'EOF'
export const reportWebVitals = (metric: any) => {
  if (metric.label === 'web-vital') {
    console.log(metric);
    
    // Send to Vercel Analytics
    if (window.va) {
      window.va('event', {
        name: metric.name,
        data: {
          value: Math.round(metric.name === 'CLS' ? metric.value * 1000 : metric.value),
          rating: metric.rating,
          delta: metric.delta,
        },
      });
    }

    // Send to Google Analytics if available
    if (window.gtag) {
      window.gtag('event', metric.name, {
        event_category: 'Web Vitals',
        event_label: metric.id,
        value: Math.round(metric.name === 'CLS' ? metric.value * 1000 : metric.value),
        non_interaction: true,
      });
    }
  }
};

export const measurePerformance = (name: string, fn: () => void) => {
  const start = performance.now();
  fn();
  const end = performance.now();
  console.log(`${name} took ${end - start} milliseconds`);
};

export const trackCustomMetric = (name: string, value: number, unit = 'ms') => {
  if (window.va) {
    window.va('event', {
      name: `custom_${name}`,
      data: { value, unit },
    });
  }
};
EOF

# Create image optimization utility
cat > src/lib/imageLoader.ts << 'EOF'
export const eventosImageLoader = ({ src, width, quality }: {
  src: string;
  width: number;
  quality?: number;
}) => {
  const params = [`w=${width}`];
  if (quality) {
    params.push(`q=${quality}`);
  }
  
  // Use Vercel image optimization for local images
  if (src.startsWith('/')) {
    return `/_vercel/image?url=${encodeURIComponent(src)}&${params.join('&')}`;
  }
  
  // For external images (like Supabase), use the original URL
  // You might want to proxy these through your API for optimization
  return `${src}?${params.join('&')}`;
};
EOF

# Create bundle size monitoring script
cat > scripts/check-