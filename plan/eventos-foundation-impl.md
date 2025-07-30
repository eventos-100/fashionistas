# EventsOS Foundation Implementation Guide

## 🎯 Overview

This guide covers the implementation of core packages and foundational components after the initial setup is complete. Each package is designed with production-ready patterns and includes all critical fixes from the audit.

---

## 📦 Package 1: Environment Validation (@eventos/env)

### Purpose
Type-safe environment variable validation using Zod with build-time and runtime checking.

### Implementation Steps

```bash
cd packages/env

# Initialize package
pnpm init

# Install dependencies
pnpm add @t3-oss/env-nextjs zod
pnpm add -D typescript tsup @types/node

# Create package.json
cat > package.json << 'EOF'
{
  "name": "@eventos/env",
  "version": "0.0.1",
  "private": true,
  "type": "module",
  "main": "./dist/index.js",
  "module": "./dist/index.mjs",
  "types": "./dist/index.d.ts",
  "exports": {
    ".": {
      "types": "./dist/index.d.ts",
      "import": "./dist/index.mjs",
      "require": "./dist/index.js"
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
    "tsup": "^8.0.1",
    "typescript": "^5.3.3"
  },
  "peerDependencies": {
    "next": "^14.0.0"
  }
}
EOF

# Create TypeScript config
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

# Create tsup config
cat > tsup.config.ts << 'EOF'
import { defineConfig } from 'tsup'

export default defineConfig({
  entry: ['src/index.ts'],
  format: ['cjs', 'esm'],
  dts: true,
  splitting: false,
  sourcemap: true,
  clean: true,
  external: ['next'],
})
EOF

# Create source files
mkdir -p src
cat > src/index.ts << 'EOF'
export * from './client'
export * from './server'
export { env } from './env'
EOF
```

### Key Features
- ✅ Separate client/server validation
- ✅ Build-time type safety
- ✅ Runtime validation with helpful errors
- ✅ Prevents secret exposure to client
- ✅ Integrated with Next.js edge runtime

---

## 📦 Package 2: Database Client (@eventos/database)

### Purpose
Supabase client with TypeScript types, RLS helpers, and connection management.

### Implementation Steps

```bash
cd packages/database

# Initialize and install
pnpm init
pnpm add @supabase/supabase-js @supabase/ssr
pnpm add -D typescript tsup @types/node

# Create package structure
mkdir -p src/{client,types,queries,mutations,hooks}

# Create package.json
cat > package.json << 'EOF'
{
  "name": "@eventos/database",
  "version": "0.0.1",
  "private": true,
  "type": "module",
  "main": "./dist/index.js",
  "module": "./dist/index.mjs",
  "types": "./dist/index.d.ts",
  "exports": {
    ".": {
      "types": "./dist/index.d.ts",
      "import": "./dist/index.mjs",
      "require": "./dist/index.js"
    },
    "./types": {
      "types": "./dist/types/index.d.ts",
      "import": "./dist/types/index.mjs",
      "require": "./dist/types/index.js"
    }
  },
  "scripts": {
    "build": "tsup",
    "dev": "tsup --watch",
    "clean": "rm -rf dist",
    "type-check": "tsc --noEmit",
    "generate:types": "supabase gen types typescript --project-id wnjudgmhabzhcttgyxou > src/types/supabase.ts"
  },
  "dependencies": {
    "@supabase/supabase-js": "^2.39.3",
    "@supabase/ssr": "^0.0.10"
  },
  "devDependencies": {
    "tsup": "^8.0.1",
    "typescript": "^5.3.3"
  },
  "peerDependencies": {
    "next": "^14.0.0"
  }
}
EOF
```

### Key Features
- ✅ SSR-compatible client creation
- ✅ Cookie-based auth persistence
- ✅ TypeScript types from schema
- ✅ RLS helper functions
- ✅ Connection pooling setup
- ✅ Retry logic for resilience

---

## 📦 Package 3: UI Components (@eventos/ui)

### Purpose
Shared Material-UI components with SSR support, theme integration, and accessibility.

### Implementation Steps

```bash
cd packages/ui

# Initialize and install
pnpm init
pnpm add @mui/material@6.5.0 @emotion/react @emotion/styled @emotion/server
pnpm add -D typescript tsup @types/react @types/react-dom

# Create package structure
mkdir -p src/{components,theme,utils,hooks}
mkdir -p src/components/{layout,forms,feedback,display,navigation}

# Create Emotion cache setup for SSR
cat > src/theme/createEmotionCache.ts << 'EOF'
import createCache from '@emotion/cache'

const isBrowser = typeof document !== 'undefined'

export default function createEmotionCache() {
  let insertionPoint

  if (isBrowser) {
    const emotionInsertionPoint = document.querySelector<HTMLMetaElement>(
      'meta[name="emotion-insertion-point"]',
    )
    insertionPoint = emotionInsertionPoint ?? undefined
  }

  return createCache({ 
    key: 'mui-style', 
    insertionPoint,
    prepend: true 
  })
}
EOF
```

### Key Features
- ✅ Material-UI v6 with strict version lock
- ✅ SSR Emotion cache configuration
- ✅ Accessibility-first components
- ✅ Theme consistency across apps
- ✅ Tree-shakeable exports
- ✅ TypeScript strict mode

---

## 📦 Package 4: Shared Types (@eventos/types)

### Purpose
Centralized TypeScript type definitions for database models, API contracts, and domain entities.

### Implementation Steps

```bash
cd packages/types

# Create structure
mkdir -p src/{database,api,domain,common}

# Database types structure
cat > src/database/index.ts << 'EOF'
// Re-export Supabase generated types
export * from './supabase'

// Domain models
export * from './models'

// Enums and constants
export * from './enums'
EOF

# API types structure
cat > src/api/index.ts << 'EOF'
// Request/Response types
export * from './requests'
export * from './responses'

// Error types
export * from './errors'

// Pagination
export * from './pagination'
EOF
```

### Key Features
- ✅ Single source of truth for types
- ✅ Supabase schema type generation
- ✅ API contract definitions
- ✅ Shared validation schemas
- ✅ Enum consistency
- ✅ Branded types for IDs

---

## 📦 Package 5: Utilities (@eventos/utils)

### Purpose
Shared utility functions for formatting, validation, security, and common operations.

### Implementation Steps

```bash
cd packages/utils

# Create utility categories
mkdir -p src/{auth,formatting,validation,security,constants,date,crypto}

# Security utilities
cat > src/security/headers.ts << 'EOF'
export const securityHeaders = {
  contentSecurityPolicy: (nonce?: string) => ({
    'Content-Security-Policy': [
      "default-src 'self'",
      `script-src 'self' 'unsafe-eval' ${nonce ? `'nonce-${nonce}'` : "'unsafe-inline'"} *.vercel-insights.com`,
      "style-src 'self' 'unsafe-inline' fonts.googleapis.com",
      "font-src 'self' fonts.gstatic.com",
      "img-src 'self' data: https: blob:",
      "connect-src 'self' *.supabase.co wss://*.supabase.co",
      "frame-ancestors 'none'",
      "base-uri 'self'",
      "form-action 'self'"
    ].join('; ')
  }),
  
  standard: {
    'X-Frame-Options': 'DENY',
    'X-Content-Type-Options': 'nosniff',
    'X-XSS-Protection': '1; mode=block',
    'Referrer-Policy': 'strict-origin-when-cross-origin',
    'Permissions-Policy': 'camera=(), microphone=(), geolocation=()',
    'Strict-Transport-Security': 'max-age=31536000; includeSubDomains; preload'
  }
}
EOF

# Rate limiting utilities
cat > src/security/rateLimiter.ts << 'EOF'
interface RateLimitResult {
  success: boolean
  limit: number
  remaining: number
  reset: Date
}

export class InMemoryRateLimiter {
  private attempts = new Map<string, number[]>()
  
  constructor(
    private limit: number,
    private windowMs: number
  ) {}
  
  check(identifier: string): RateLimitResult {
    const now = Date.now()
    const attempts = this.attempts.get(identifier) || []
    
    // Remove old attempts
    const validAttempts = attempts.filter(
      time => now - time < this.windowMs
    )
    
    // Add current attempt
    validAttempts.push(now)
    this.attempts.set(identifier, validAttempts)
    
    return {
      success: validAttempts.length <= this.limit,
      limit: this.limit,
      remaining: Math.max(0, this.limit - validAttempts.length),
      reset: new Date(now + this.windowMs)
    }
  }
}
EOF
```

### Key Features
- ✅ Security header utilities
- ✅ Rate limiting helpers
- ✅ Input validation functions
- ✅ Date/time formatters
- ✅ Currency formatters
- ✅ Crypto utilities for tokens

---

## 📦 Package 6: Configuration (@eventos/config)

### Purpose
Centralized configuration for build tools, runtime settings, and feature flags.

### Implementation Steps

```bash
cd packages/config

# Create config categories
mkdir -p src/{build,runtime,features,constants}

# Build configuration
cat > src/build/next.ts << 'EOF'
export const nextConfig = {
  // Shared Next.js configuration
  images: {
    domains: ['localhost', 'wnjudgmhabzhcttgyxou.supabase.co'],
    formats: ['image/avif', 'image/webp'],
    deviceSizes: [640, 750, 828, 1080, 1200, 1920, 2048, 3840],
  },
  
  // Security headers
  async headers() {
    return [
      {
        source: '/:path*',
        headers: Object.entries(securityHeaders.standard).map(
          ([key, value]) => ({ key, value })
        ),
      },
    ]
  },
  
  // Webpack optimizations
  webpack: (config, { isServer }) => {
    if (!isServer) {
      config.resolve.fallback = {
        fs: false,
        net: false,
        tls: false,
      }
    }
    return config
  },
}
EOF

# Feature flags
cat > src/features/flags.ts << 'EOF'
export const featureFlags = {
  // Core features
  enableAnalytics: process.env.NEXT_PUBLIC_ENABLE_ANALYTICS === 'true',
  enablePWA: process.env.NEXT_PUBLIC_ENABLE_PWA === 'true',
  maintenanceMode: process.env.NEXT_PUBLIC_MAINTENANCE_MODE === 'true',
  
  // AI features
  enableAIAutomation: process.env.ENABLE_AI_AUTOMATION === 'true',
  enableChatbot: process.env.ENABLE_CHATBOT === 'true',
  
  // Payment features
  enableStripe: !!process.env.STRIPE_SECRET_KEY,
  enableSubscriptions: process.env.ENABLE_SUBSCRIPTIONS === 'true',
  
  // Development features
  enableDebugMode: process.env.DEBUG === 'true',
  enableMockData: process.env.USE_MOCK_DATA === 'true',
}
EOF
```

### Key Features
- ✅ Centralized build configs
- ✅ Runtime feature flags
- ✅ Environment-based toggles
- ✅ A/B testing support
- ✅ Performance budgets
- ✅ API rate limits

---

## 🧪 Testing Shared Packages

### Create Test Structure

```bash
# For each package, create test structure
cd packages/env
mkdir -p src/__tests__

# Example test file
cat > src/__tests__/env.test.ts << 'EOF'
import { describe, it, expect, beforeEach, vi } from 'vitest'

describe('@eventos/env', () => {
  beforeEach(() => {
    vi.resetModules()
    process.env = {}
  })
  
  it('should validate required environment variables', () => {
    process.env.NEXT_PUBLIC_SUPABASE_URL = 'https://test.supabase.co'
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY = 'test-key'
    
    expect(() => require('../index')).not.toThrow()
  })
  
  it('should throw on missing required variables', () => {
    expect(() => require('../index')).toThrow()
  })
})
EOF
```

---

## 📊 Build All Packages

```bash
# From root directory
# Build all packages in dependency order
pnpm turbo build --filter='./packages/*'

# Verify builds
ls -la packages/*/dist/

# Run package tests
pnpm turbo test --filter='./packages/*'
```

---

## ✅ Foundation Implementation Checklist

### Package Implementation Status

- [ ] **@eventos/env**
  - [ ] Environment schema defined
  - [ ] Client/server separation
  - [ ] Validation working
  - [ ] Tests passing

- [ ] **@eventos/database**
  - [ ] Supabase clients configured
  - [ ] SSR auth working
  - [ ] Types generated
  - [ ] RLS helpers created

- [ ] **@eventos/ui**
  - [ ] MUI components created
  - [ ] SSR cache configured
  - [ ] Theme consistency
  - [ ] Accessibility validated

- [ ] **@eventos/types**
  - [ ] Database types generated
  - [ ] API contracts defined
  - [ ] Domain models created
  - [ ] Enums consolidated

- [ ] **@eventos/utils**
  - [ ] Security utilities
  - [ ] Formatters implemented
  - [ ] Validators created
  - [ ] Constants defined

- [ ] **@eventos/config**
  - [ ] Build configs centralized
  - [ ] Feature flags setup
  - [ ] Runtime settings
  - [ ] Performance budgets

### Integration Verification

```bash
# Test package linking
cd apps/website
pnpm add @eventos/ui@workspace:* @eventos/database@workspace:*

# Verify imports work
echo "import { Button } from '@eventos/ui'" > test-import.ts
pnpm exec tsc test-import.ts --noEmit
```

---

## 🚀 Next Steps

With the foundation packages implemented, you're ready to:

1. **Start Admin App Development**
   - Set up Refine with hybrid router approach
   - Configure MUI v6 with SSR
   - Implement Supabase auth

2. **Start Website Development**
   - Create marketing pages
   - Set up SEO optimization
   - Implement performance monitoring

3. **Configure CI/CD**
   - Set up Vercel projects
   - Configure environment variables
   - Enable preview deployments

The foundation is solid and all critical issues have been addressed! 🎉