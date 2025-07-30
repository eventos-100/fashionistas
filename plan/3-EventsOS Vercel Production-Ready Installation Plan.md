# 🚀 EventsOS Vercel Production-Ready Installation Plan


we are using a fresh directory which is empty
/home/sk/fx/eventos
create the following plan 
## 📑 Table of Contents

1. [Project Overview](#project-overview)
2. [Progress Tracker](#progress-tracker)
3. [Phase 1: Core Monorepo Setup](#phase-1-core-monorepo-setup)
4. [Phase 2: Admin App (Refine + MUI)](#phase-2-admin-app-refine--mui)
5. [Phase 3: Website App (MUI Only)](#phase-3-website-app-mui-only)
6. [Phase 4: Vercel Configuration](#phase-4-vercel-configuration)
7. [Phase 5: Security & Performance](#phase-5-security--performance)
8. [Phase 6: Production Deployment](#phase-6-production-deployment)
9. [Production Readiness Checklist
10. Troubleshooting
11. Error Provention
You must generate:
A phased technical implementation plan
With all steps, commands, and checklists
That is ready for production, testable, and fully traceable
Claude — are you ready? Begin by generating the full outline with Table of Contents and Phase 1 in detail. Then continue sequentially.
do not use code in this plan except for commands
use best practices for 
event management
refine material ui supabase
material ui v 6 next js
supabase
vercel



GitHub  include attached ensure the plan is 100 % correct use artifacts
---

## 🎯 Project Overview

EventsOS is a monorepo containing:
- **Admin Dashboard**: Refine + MUI v6 + Supabase
- **Public Website**: Next.js + MUI v6
- **Shared Packages**: UI components, utilities, types

### Key Requirements
- ✅ Vercel deployment ready
- ✅ Turborepo for monorepo management
- ✅ Next.js 14 App Router
- ✅ Material-UI v6.5.0
- ✅ Supabase integration
- ✅ Production security headers
- ✅ Performance optimization

---

## 📊 Progress Tracker

| Phase | Task | Status | Completion |
|-------|------|--------|------------|
| 1 | Core Monorepo Setup | ⬜ Not Started | 0% |
| 2 | Admin App Setup | ⬜ Not Started | 0% |
| 3 | Website App Setup | ⬜ Not Started | 0% |
| 4 | Vercel Configuration | ⬜ Not Started | 0% |
| 5 | Security & Performance | ⬜ Not Started | 0% |
| 6 | Production Deployment | ⬜ Not Started | 0% |

---

## 🏗️ Phase 1: Core Monorepo Setup

### 📍 Working Directory: `/home/sk/fx/eventos`

### Task 1.1: Initialize Monorepo Structure

#### Commands:
```bash
cd /home/sk/fx/eventos

# Create directory structure
mkdir -p apps/{admin,website}
mkdir -p packages/{ui,database,types,utils}

# Create pnpm workspace configuration
cat > pnpm-workspace.yaml << 'EOF'
packages:
  - 'apps/*'
  - 'packages/*'
EOF
```

#### Success Criteria:
- ✅ All directories created
- ✅ pnpm-workspace.yaml exists

### Task 1.2: Root Package Configuration

#### Commands:
```bash
# Create root package.json with Turborepo
cat > package.json << 'EOF'
{
  "name": "eventos",
  "version": "0.0.1",
  "private": true,
  "packageManager": "pnpm@8.15.1",
  "scripts": {
    "dev": "turbo run dev",
    "build": "turbo run build",
    "start": "turbo run start",
    "lint": "turbo run lint",
    "type-check": "turbo run type-check",
    "clean": "turbo run clean -- && rm -rf node_modules",
    "test": "turbo run test",
    "vercel-build": "turbo run build --filter=!@eventos/admin"
  },
  "devDependencies": {
    "turbo": "^1.13.0",
    "@types/node": "^20.11.5",
    "typescript": "^5.3.3",
    "prettier": "^3.2.5",
    "eslint": "^8.56.0"
  },
  "engines": {
    "node": ">=18.0.0",
    "pnpm": ">=8.0.0"
  }
}
EOF

# Create turbo.json for build pipeline
cat > turbo.json << 'EOF'
{
  "$schema": "https://turbo.build/schema.json",
  "globalDependencies": ["**/.env.*local", ".env"],
  "pipeline": {
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
      "outputs": []
    },
    "type-check": {
      "outputs": []
    },
    "test": {
      "outputs": []
    },
    "clean": {
      "cache": false
    }
  }
}
EOF
```

#### Success Criteria:
- ✅ package.json created with correct scripts
- ✅ turbo.json configured for Vercel
- ✅ vercel-build script excludes admin app

### Task 1.3: Environment Configuration

#### Commands:
```bash
# Create .env.example
cat > .env.example << 'EOF'
# Supabase
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key

# App URLs
NEXT_PUBLIC_APP_URL=https://your-domain.vercel.app
NEXT_PUBLIC_ADMIN_URL=https://admin.your-domain.vercel.app
NEXT_PUBLIC_WEBSITE_URL=https://your-domain.vercel.app

# Vercel
VERCEL_ENV=production
VERCEL_GIT_COMMIT_SHA=
VERCEL_GIT_COMMIT_MESSAGE=

# Optional Services
SENDGRID_API_KEY=
OPENAI_API_KEY=
ANTHROPIC_API_KEY=
EOF

# Create .gitignore
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
```

#### Success Criteria:
- ✅ Environment template created
- ✅ Proper .gitignore with Vercel entries

### Task 1.4: Vercel Configuration

#### Commands:
```bash
# Create vercel.json for monorepo
cat > vercel.json << 'EOF'
{
  "buildCommand": "pnpm turbo build",
  "installCommand": "pnpm install",
  "framework": null,
  "outputDirectory": "apps/website/.next",
  "rewrites": [
    {
      "source": "/admin/:path*",
      "destination": "https://admin.your-domain.vercel.app/:path*"
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
        }
      ]
    }
  ]
}
EOF

# Install root dependencies
pnpm add -D turbo@1.13.0 prettier@3.2.5 eslint@8.56.0
```

#### Success Criteria:
- ✅ vercel.json created
- ✅ Security headers configured
- ✅ Root dependencies installed

### 🧪 Testing Task 1
```bash
# Verify structure
ls -la apps/
ls -la packages/

# Test turbo
pnpm turbo --version
```

### ✅ Production Checklist - Phase 1
- [ ] Monorepo structure created
- [ ] Turborepo configured for caching
- [ ] Environment variables template
- [ ] Security headers in vercel.json
- [ ] .gitignore includes Vercel files
- [ ] Package manager locked to pnpm

---

## 🎨 Phase 2: Admin App (Refine + MUI)

### 📍 Working Directory: `/home/sk/fx/eventos/apps/admin`

### Task 2.1: Initialize Admin App

#### Commands:
```bash
cd /home/sk/fx/eventos/apps/admin

# Create package.json
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
```

#### Success Criteria:
- ✅ package.json created
- ✅ Scripts configured for port 3001

### Task 2.2: Install Admin Dependencies

#### Commands:
```bash
# Core dependencies (exact versions)
pnpm add next@14.2.29 react@18.2.0 react-dom@18.2.0

# TypeScript
pnpm add -D typescript@5.3.3 @types/react@18.2.48 @types/react-dom@18.2.18 @types/node@20.11.5

# MUI v6 suite
pnpm add @mui/material@6.5.0 @emotion/react@11.11.3 @emotion/styled@11.11.0
pnpm add @mui/material-nextjs@6.5.0
pnpm add @mui/x-data-grid@7.22.2
pnpm add @mui/lab@6.0.0-beta.21

# Refine suite (in order)
pnpm add @refinedev/core@4.57.10
pnpm add @refinedev/nextjs-router@6.0.4
pnpm add @refinedev/mui@6.2.2

# Supabase
pnpm add @supabase/supabase-js@2.39.3 @refinedev/supabase@6.0.6

# Forms
pnpm add @refinedev/react-hook-form@4.9.4 react-hook-form@7.49.3

# Additional
pnpm add @fontsource/roboto@5.0.8 @mui/icons-material@6.5.0

# Dev tools
pnpm add -D @refinedev/cli@2.16.46 eslint@8.56.0 eslint-config-next@14.2.29
```

#### Success Criteria:
- ✅ All dependencies installed
- ✅ No peer dependency warnings
- ✅ Correct MUI/DataGrid versions

### Task 2.3: Create Admin Structure

#### Commands:
```bash
# Create directory structure
mkdir -p src/{app,components,providers,hooks,utils,lib,theme,types}
mkdir -p src/app/{dashboard,api}
mkdir -p src/app/dashboard/{events,attendees,sponsors,analytics,settings}
mkdir -p src/app/(auth)/{login,register,forgot-password}
mkdir -p public

# Create next.config.mjs
cat > next.config.mjs << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  transpilePackages: [
    '@refinedev/mui',
    '@mui/material',
    '@mui/x-data-grid'
  ],
  experimental: {
    serverComponentsExternalPackages: ['@supabase/supabase-js']
  },
  images: {
    domains: ['localhost', 'your-supabase-project.supabase.co'],
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
            value: 'origin-when-cross-origin',
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

# Create tsconfig.json
cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "es5",
    "lib": ["dom", "dom.iterable", "esnext"],
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
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
EOF
```

#### Success Criteria:
- ✅ All directories created
- ✅ next.config.mjs with security headers
- ✅ TypeScript configured

### Task 2.4: Core Admin Files

#### Commands:
```bash
# Create middleware.ts for auth
cat > middleware.ts << 'EOF'
import { createMiddlewareClient } from '@supabase/auth-helpers-nextjs'
import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'

export async function middleware(req: NextRequest) {
  const res = NextResponse.next()
  
  // Skip middleware for static files and API routes
  if (
    req.nextUrl.pathname.startsWith('/_next') ||
    req.nextUrl.pathname.startsWith('/api') ||
    req.nextUrl.pathname.includes('.')
  ) {
    return res
  }

  const supabase = createMiddlewareClient({ req, res })

  const {
    data: { session },
  } = await supabase.auth.getSession()

  // Protect dashboard routes
  if (req.nextUrl.pathname.startsWith('/dashboard') && !session) {
    return NextResponse.redirect(new URL('/login', req.url))
  }

  // Redirect logged-in users from auth pages
  if (
    (req.nextUrl.pathname.startsWith('/login') ||
     req.nextUrl.pathname.startsWith('/register')) &&
    session
  ) {
    return NextResponse.redirect(new URL('/dashboard', req.url))
  }

  return res
}

export const config = {
  matcher: ['/((?!_next/static|_next/image|favicon.ico).*)'],
}
EOF

# Create src/app/layout.tsx
cat > src/app/layout.tsx << 'EOF'
import { AppRouterCacheProvider } from '@mui/material-nextjs/v15-appRouter'
import type { Metadata } from 'next'
import '@fontsource/roboto/300.css'
import '@fontsource/roboto/400.css'
import '@fontsource/roboto/500.css'
import '@fontsource/roboto/700.css'

export const metadata: Metadata = {
  title: {
    default: 'EventsOS Admin',
    template: '%s | EventsOS Admin'
  },
  description: 'EventsOS Admin Dashboard',
  robots: 'noindex, nofollow',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>
        <AppRouterCacheProvider options={{ enableCssLayer: true }}>
          {children}
        </AppRouterCacheProvider>
      </body>
    </html>
  )
}
EOF

# Create .env.local
cat > .env.local << 'EOF'
# Copy values from root .env.example
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=
EOF
```

#### Success Criteria:
- ✅ Auth middleware created
- ✅ Root layout with cache provider
- ✅ Environment file template

### 🧪 Testing Task 2
```bash
# Build test
pnpm build

# Development test
pnpm dev

# Type check
pnpm type-check
```

### ✅ Production Checklist - Phase 2
- [ ] Admin app structure complete
- [ ] All dependencies exact versions
- [ ] Security headers configured
- [ ] Auth middleware implemented
- [ ] TypeScript strict mode enabled
- [ ] Build outputs standalone

---

## 🌐 Phase 3: Website App (MUI Only)

### 📍 Working Directory: `/home/sk/fx/eventos/apps/website`

### Task 3.1: Initialize Website App

#### Commands:
```bash
cd /home/sk/fx/eventos/apps/website

# Create package.json
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
```

### Task 3.2: Install Website Dependencies

#### Commands:
```bash
# Core dependencies
pnpm add next@14.2.29 react@18.2.0 react-dom@18.2.0

# TypeScript
pnpm add -D typescript@5.3.3 @types/react@18.2.48 @types/react-dom@18.2.18 @types/node@20.11.5

# MUI v6 (no Refine)
pnpm add @mui/material@6.5.0 @emotion/react@11.11.3 @emotion/styled@11.11.0
pnpm add @mui/material-nextjs@6.5.0

# Additional
pnpm add @fontsource/roboto@5.0.8 @mui/icons-material@6.5.0
pnpm add @supabase/supabase-js@2.39.3

# Dev tools
pnpm add -D eslint@8.56.0 eslint-config-next@14.2.29
```

### Task 3.3: Create Website Structure

#### Commands:
```bash
# Create directories
mkdir -p src/{app,components,providers,theme,lib,hooks,utils}
mkdir -p src/app/{(marketing),events,api}
mkdir -p src/app/(marketing)/{about,features,pricing,contact}
mkdir -p src/components/{layout,sections,ui}
mkdir -p public/{images,fonts}

# Create next.config.mjs
cat > next.config.mjs << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  images: {
    domains: ['localhost', 'your-supabase-project.supabase.co'],
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
            value: 'origin-when-cross-origin'
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
      }
    ];
  },
  async rewrites() {
    return [
      {
        source: '/api/:path*',
        destination: `${process.env.NEXT_PUBLIC_SUPABASE_URL}/rest/v1/:path*`
      }
    ];
  }
}

export default nextConfig
EOF

# Copy tsconfig.json from admin
cp ../admin/tsconfig.json .
```

### Task 3.4: Core Website Files

#### Commands:
```bash
# Create src/app/layout.tsx
cat > src/app/layout.tsx << 'EOF'
import { AppRouterCacheProvider } from '@mui/material-nextjs/v15-appRouter'
import { ThemeProvider } from '@/providers/ThemeProvider'
import { SpeedInsights } from '@vercel/speed-insights/next'
import { Analytics } from '@vercel/analytics/react'
import type { Metadata } from 'next'
import '@fontsource/roboto/300.css'
import '@fontsource/roboto/400.css'
import '@fontsource/roboto/500.css'
import '@fontsource/roboto/700.css'

export const metadata: Metadata = {
  title: {
    default: 'EventsOS - AI-Powered Event Management',
    template: '%s | EventsOS'
  },
  description: 'Professional event management platform with AI automation',
  keywords: ['event management', 'fashion shows', 'corporate events', 'AI'],
  authors: [{ name: 'EventsOS Team' }],
  openGraph: {
    type: 'website',
    locale: 'en_US',
    url: 'https://eventos.vercel.app',
    siteName: 'EventsOS',
    images: [
      {
        url: '/og-image.png',
        width: 1200,
        height: 630,
        alt: 'EventsOS Platform',
      },
    ],
  },
  twitter: {
    card: 'summary_large_image',
    site: '@eventos',
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
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>
        <AppRouterCacheProvider options={{ enableCssLayer: true }}>
          <ThemeProvider>
            {children}
            <SpeedInsights />
            <Analytics />
          </ThemeProvider>
        </AppRouterCacheProvider>
      </body>
    </html>
  )
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

# Install Vercel analytics
pnpm add @vercel/analytics @vercel/speed-insights
```

#### Success Criteria:
- ✅ SEO metadata configured
- ✅ Analytics integrated
- ✅ Security headers set
- ✅ Caching strategy defined

### 🧪 Testing Task 3
```bash
# Build test
pnpm build

# Lighthouse test preparation
pnpm dev
# Visit http://localhost:3000 and run Lighthouse
```

### ✅ Production Checklist - Phase 3
- [ ] Website structure complete
- [ ] SEO optimization configured
- [ ] Analytics tools added
- [ ] Image optimization enabled
- [ ] Cache headers configured
- [ ] Security headers implemented

---

## ⚙️ Phase 4: Vercel Configuration

### 📍 Working Directory: `/home/sk/fx/eventos`

### Task 4.1: Advanced Vercel Setup

#### Commands:
```bash
cd /home/sk/fx/eventos

# Update vercel.json with complete configuration
cat > vercel.json << 'EOF'
{
  "buildCommand": "pnpm turbo build",
  "installCommand": "pnpm install --frozen-lockfile",
  "framework": null,
  "outputDirectory": "apps/website/.next",
  "functions": {
    "apps/website/src/app/api/*.ts": {
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
    }
  ],
  "redirects": [
    {
      "source": "/home",
      "destination": "/",
      "permanent": true
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
          "key": "Content-Security-Policy",
          "value": "default-src 'self'; script-src 'self' 'unsafe-eval' 'unsafe-inline' *.vercel-insights.com *.vercel.app; style-src 'self' 'unsafe-inline' fonts.googleapis.com; font-src 'self' fonts.gstatic.com; img-src 'self' data: https:; connect-src 'self' *.supabase.co *.vercel-insights.com"
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

## Vercel Deployment

### Initial Setup
1. Install Vercel CLI: `npm i -g vercel`
2. Login: `vercel login`
3. Link project: `vercel link`

### Environment Variables (via Vercel Dashboard)
- NEXT_PUBLIC_SUPABASE_URL
- NEXT_PUBLIC_SUPABASE_ANON_KEY
- SUPABASE_SERVICE_ROLE_KEY
- SENDGRID_API_KEY (optional)
- OPENAI_API_KEY (optional)

### Deployment Commands
- Preview: `vercel`
- Production: `vercel --prod`

### Domain Configuration
1. Add custom domain in Vercel dashboard
2. Configure DNS records
3. Enable HTTPS (automatic)

### Monitoring
- Speed Insights: Enabled automatically
- Analytics: Enabled automatically
- Logs: Available in dashboard
EOF
```

#### Success Criteria:
- ✅ Complete vercel.json configuration
- ✅ CSP headers configured
- ✅ Caching strategy implemented
- ✅ Deployment documentation

### Task 4.2: GitHub Actions CI/CD

#### Commands:
```bash
# Create GitHub Actions workflow
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
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - uses: pnpm/action-setup@v2
        with:
          version: 8.15.1
          
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'pnpm'
          
      - run: pnpm install --frozen-lockfile
      
      - run: pnpm lint
      
  type-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - uses: pnpm/action-setup@v2
        with:
          version: 8.15.1
          
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'pnpm'
          
      - run: pnpm install --frozen-lockfile
      
      - run: pnpm type-check
      
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - uses: pnpm/action-setup@v2
        with:
          version: 8.15.1
          
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'pnpm'
          
      - run: pnpm install --frozen-lockfile
      
      - run: pnpm build
        env:
          NEXT_PUBLIC_SUPABASE_URL: ${{ secrets.NEXT_PUBLIC_SUPABASE_URL }}
          NEXT_PUBLIC_SUPABASE_ANON_KEY: ${{ secrets.NEXT_PUBLIC_SUPABASE_ANON_KEY }}
EOF

cat > .github/workflows/preview.yml << 'EOF'
name: Vercel Preview Deployment

env:
  VERCEL_ORG_ID: ${{ secrets.VERCEL_ORG_ID }}
  VERCEL_PROJECT_ID: ${{ secrets.VERCEL_PROJECT_ID }}

on:
  push:
    branches-ignore:
      - main

jobs:
  Deploy-Preview:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - uses: pnpm/action-setup@v2
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
```

#### Success Criteria:
- ✅ CI pipeline created
- ✅ Preview deployments configured
- ✅ Build caching with Turbo

### 🧪 Testing Task 4
```bash
# Test build command
pnpm turbo build

# Test with Vercel CLI (if installed)
vercel build
```

### ✅ Production Checklist - Phase 4
- [ ] Vercel configuration complete
- [ ] CSP headers properly configured
- [ ] Caching strategy implemented
- [ ] CI/CD pipelines created
- [ ] Environment variables documented
- [ ] Deployment regions selected

---

## 🔐 Phase 5: Security & Performance

### 📍 Working Directory: `/home/sk/fx/eventos`

### Task 5.1: Security Enhancements

#### Commands:
```bash
# Create security utilities
mkdir -p packages/utils/src/security

cat > packages/utils/src/security/headers.ts << 'EOF'
export const securityHeaders = {
  'Content-Security-Policy': `
    default-src 'self';
    script-src 'self' 'unsafe-eval' 'unsafe-inline' *.vercel-insights.com;
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
}

export const getCspNonce = () => {
  return Buffer.from(crypto.randomUUID()).toString('base64')
}
EOF

# Create rate limiting middleware
cat > packages/utils/src/security/rateLimit.ts << 'EOF'
import { LRUCache } from 'lru-cache'

type Options = {
  uniqueTokenPerInterval?: number
  interval?: number
}

export function rateLimit(options?: Options) {
  const tokenCache = new LRUCache({
    max: options?.uniqueTokenPerInterval || 500,
    ttl: options?.interval || 60000,
  })

  return {
    check: (res: Response, limit: number, token: string) =>
      new Promise<void>((resolve, reject) => {
        const tokenCount = (tokenCache.get(token) as number[]) || [0]
        if (tokenCount[0] === 0) {
          tokenCache.set(token, [1])
        }
        tokenCount[0] += 1

        const currentUsage = tokenCount[0]
        const isRateLimited = currentUsage >= limit
        res.headers.set('X-RateLimit-Limit', String(limit))
        res.headers.set(
          'X-RateLimit-Remaining',
          String(isRateLimited ? 0 : limit - currentUsage)
        )

        return isRateLimited ? reject() : resolve()
      }),
  }
}
EOF

# Install security dependencies
cd packages/utils
pnpm init -y
pnpm add lru-cache
pnpm add -D @types/node
```

#### Success Criteria:
- ✅ Security headers utility created
- ✅ Rate limiting implemented
- ✅ CSP nonce support

### Task 5.2: Performance Optimization

#### Commands:
```bash
cd /home/sk/fx/eventos

# Create image optimization config
cat > apps/website/src/utils/imageLoader.ts << 'EOF'
export const imageLoader = ({ src, width, quality }: {
  src: string
  width: number
  quality?: number
}) => {
  const params = [`w=${width}`]
  if (quality) {
    params.push(`q=${quality}`)
  }
  
  // Use Vercel image optimization
  if (src.startsWith('/')) {
    return `/_vercel/image?url=${encodeURIComponent(src)}&${params.join('&')}`
  }
  
  // External images
  return `${src}?${params.join('&')}`
}
EOF

# Create performance monitoring
cat > apps/website/src/utils/performance.ts << 'EOF'
export const reportWebVitals = (metric: any) => {
  if (metric.label === 'web-vital') {
    console.log(metric)
    
    // Send to analytics
    if (window.gtag) {
      window.gtag('event', metric.name, {
        event_category: 'Web Vitals',
        event_label: metric.id,
        value: Math.round(metric.name === 'CLS' ? metric.value * 1000 : metric.value),
        non_interaction: true,
      })
    }
  }
}
EOF

# Update website package.json for bundle analysis
cd apps/website
pnpm add -D @next/bundle-analyzer

# Update next.config.mjs for bundle analyzer
cat >> next.config.mjs << 'EOF'

const withBundleAnalyzer = require('@next/bundle-analyzer')({
  enabled: process.env.ANALYZE === 'true',
})

module.exports = withBundleAnalyzer(nextConfig)
EOF
```

#### Success Criteria:
- ✅ Image optimization configured
- ✅ Web Vitals monitoring
- ✅ Bundle analyzer ready

### 🧪 Testing Task 5
```bash
# Security headers test
curl -I https://your-domain.vercel.app

# Bundle analysis
ANALYZE=true pnpm build
```

### ✅ Production Checklist - Phase 5
- [ ] Security headers implemented
- [ ] Rate limiting configured
- [ ] CSP policy defined
- [ ] Image optimization enabled
- [ ] Performance monitoring added
- [ ] Bundle size optimized

---

## 🚀 Phase 6: Production Deployment

### 📍 Working Directory: `/home/sk/fx/eventos`

### Task 6.1: Pre-deployment Checks

#### Commands:
```bash
# Run full test suite
pnpm lint
pnpm type-check
pnpm build

# Check bundle sizes
cd apps/website && ANALYZE=true pnpm build
cd ../admin && ANALYZE=true pnpm build

# Create production checklist
cat > PRODUCTION_CHECKLIST.md << 'EOF'
# Production Deployment Checklist

## Pre-deployment
- [ ] All environment variables set in Vercel
- [ ] Database migrations completed
- [ ] Supabase RLS policies configured
- [ ] API rate limiting enabled
- [ ] Error tracking (Sentry) configured

## Security
- [ ] CSP headers tested
- [ ] HTTPS enforced
- [ ] Secrets rotated
- [ ] Admin routes protected
- [ ] Input validation implemented

## Performance
- [ ] Images optimized
- [ ] Fonts preloaded
- [ ] Critical CSS inlined
- [ ] Bundle size < 500KB
- [ ] Lighthouse score > 90

## Monitoring
- [ ] Vercel Analytics enabled
- [ ] Speed Insights enabled
- [ ] Error logging configured
- [ ] Uptime monitoring set
- [ ] Alerts configured

## Post-deployment
- [ ] Smoke tests passed
- [ ] SSL certificate valid
- [ ] DNS propagated
- [ ] Redirects working
- [ ] Forms tested
EOF
```

#### Success Criteria:
- ✅ All tests passing
- ✅ Bundle sizes acceptable
- ✅ Checklist created

### Task 6.2: Deployment Commands

#### Commands:
```bash
# Install Vercel CLI globally
npm i -g vercel

# Login to Vercel
vercel login

# Link to project (first time)
vercel link

# Deploy to preview
vercel

# Deploy to production
vercel --prod

# Set environment variables
vercel env add NEXT_PUBLIC_SUPABASE_URL
vercel env add NEXT_PUBLIC_SUPABASE_ANON_KEY
vercel env add SUPABASE_SERVICE_ROLE_KEY production

# Configure domains
vercel domains add eventos.com
vercel domains add admin.eventos.com
```

#### Success Criteria:
- ✅ Vercel CLI configured
- ✅ Environment variables set
- ✅ Domains configured

### Task 6.3: Post-deployment Configuration

#### Commands:
```bash
# Enable deployment protection
vercel project settings

# Configure Vercel WAF (via dashboard)
# 1. Go to Project Settings > Security
# 2. Enable WAF
# 3. Configure rate limiting rules

# Set up monitoring alerts
cat > .github/ISSUE_TEMPLATE/incident.md << 'EOF'
---
name: Incident Report
about: Report a production incident
title: '[INCIDENT] '
labels: incident, production
assignees: ''
---

## Incident Details
- **Time**: 
- **Severity**: Critical/High/Medium/Low
- **Services Affected**: 

## Description

## Impact

## Resolution Steps

## Post-mortem Required
- [ ] Yes
- [ ] No
EOF
```

#### Success Criteria:
- ✅ Deployment protection enabled
- ✅ WAF configured
- ✅ Incident process defined

### 🧪 Testing Task 6
```bash
# Production smoke tests
curl https://eventos.vercel.app
curl https://eventos.vercel.app/api/health

# Security headers test
curl -I https://eventos.vercel.app | grep -i "content-security-policy"

# Performance test
lighthouse https://eventos.vercel.app --view
```

### ✅ Production Checklist - Phase 6
- [ ] Deployment successful
- [ ] All environment variables set
- [ ] Custom domains configured
- [ ] SSL certificates active
- [ ] Monitoring enabled
- [ ] Incident response ready

---

## 📋 Production Readiness Checklist

### 🔐 Security
- [ ] CSP headers configured and tested
- [ ] Authentication middleware active
- [ ] Rate limiting implemented
- [ ] Input validation on all forms
- [ ] Secrets properly managed
- [ ] WAF rules configured

### ⚡ Performance
- [ ] Lighthouse score > 90
- [ ] Bundle size optimized
- [ ] Images using next/image
- [ ] Fonts optimized
- [ ] Caching headers set
- [ ] CDN configured

### 🔍 Monitoring
- [ ] Vercel Analytics enabled
- [ ] Speed Insights active
- [ ] Error tracking configured
- [ ] Uptime monitoring set
- [ ] Alerts configured
- [ ] Log drains enabled

### 🚀 Operations
- [ ] CI/CD pipeline working
- [ ] Rollback process tested
- [ ] Backup strategy defined
- [ ] Incident response plan
- [ ] Documentation complete
- [ ] Team access configured

### 🎯 Final Verification
```bash
# Run complete verification
pnpm lint && pnpm type-check && pnpm build && echo "✅ Ready for production!"
```

---

## 🎉 Deployment Complete!

Your EventsOS platform is now:
- ✅ Deployed on Vercel
- ✅ Optimized for performance
- ✅ Secured with best practices
- ✅ Monitored and tracked
- ✅ Ready for scale

### Next Steps:
1. Monitor initial performance metrics
2. Set up custom alerts
3. Plan first feature deployment
4. Schedule security audit

### Support Resources:
- Vercel Dashboard: https://vercel.com/dashboard
- Documentation: /DEPLOYMENT.md
- Incident Template: /.github/ISSUE_TEMPLATE/incident.md