# EventsOS Production Deployment Guide

## Production Readiness Checklist

### 1. Build Optimization

```bash
# next.config.js
module.exports = {
  reactStrictMode: true,
  swcMinify: true,
  images: {
    domains: ['wnjudgmhabzhcttgyxou.supabase.co'],
    formats: ['image/avif', 'image/webp'],
  },
  experimental: {
    optimizeCss: true,
  },
  webpack: (config, { isServer }) => {
    if (!isServer) {
      config.resolve.fallback = {
        fs: false,
        net: false,
        tls: false,
      };
    }
    return config;
  },
};
```

### 2. Environment Configuration

```bash
# .env.production
NEXT_PUBLIC_SUPABASE_URL=https://wnjudgmhabzhcttgyxou.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_production_anon_key
NEXT_PUBLIC_APP_URL=https://eventos.fashion
NEXT_PUBLIC_SENTRY_DSN=your_sentry_dsn
ANALYZE=false
```

### 3. Security Headers

```typescript
// src/middleware.ts
import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

export function middleware(request: NextRequest) {
  const response = NextResponse.next();

  response.headers.set('X-Frame-Options', 'DENY');
  response.headers.set('X-Content-Type-Options', 'nosniff');
  response.headers.set('X-XSS-Protection', '1; mode=block');
  response.headers.set('Referrer-Policy', 'strict-origin-when-cross-origin');
  response.headers.set(
    'Content-Security-Policy',
    "default-src 'self'; script-src 'self' 'unsafe-eval' 'unsafe-inline'; style-src 'self' 'unsafe-inline';"
  );

  return response;
}
```

### 4. Performance Monitoring

```typescript
// src/utils/monitoring.ts
import * as Sentry from '@sentry/nextjs';

Sentry.init({
  dsn: process.env.NEXT_PUBLIC_SENTRY_DSN,
  environment: process.env.NODE_ENV,
  tracesSampleRate: 0.1,
  integrations: [
    new Sentry.BrowserTracing(),
    new Sentry.Replay({
      maskAllText: false,
      blockAllMedia: false,
    }),
  ],
});

// Performance monitoring
export const measurePerformance = (metricName: string) => {
  if (typeof window !== 'undefined' && window.performance) {
    const metric = window.performance.measure(metricName);
    
    // Send to analytics
    if (window.gtag) {
      window.gtag('event', 'timing_complete', {
        name: metricName,
        value: Math.round(metric.duration),
      });
    }
  }
};
```

### 5. Deployment Commands

```bash
# Build optimization
pnpm build
pnpm analyze  # Check bundle size

# Pre-deployment checks
pnpm test
pnpm test:e2e
pnpm lint
pnpm type-check

# Deploy to Vercel
vercel --prod

# Post-deployment
vercel env pull .env.production.local
```

## Vercel Configuration

```json
// vercel.json
{
  "functions": {
    "src/pages/api/*.ts": {
      "maxDuration": 30
    }
  },
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
  ],
  "redirects": [
    {
      "source": "/admin",
      "destination": "/",
      "permanent": false
    }
  ]
}
```

## Health Monitoring

```typescript
// src/pages/api/health.ts
import type { NextApiRequest, NextApiResponse } from 'next';
import { supabase } from '../../utils/supabase';

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  try {
    // Check Supabase connection
    const { error } = await supabase.from('events').select('count').limit(1);
    
    const status = {
      status: error ? 'degraded' : 'healthy',
      timestamp: new Date().toISOString(),
      version: process.env.NEXT_PUBLIC_APP_VERSION || '1.0.0',
      services: {
        database: error ? 'error' : 'operational',
        api: 'operational',
      },
      error: error?.message,
    };

    res.status(error ? 503 : 200).json(status);
  } catch (error) {
    res.status(503).json({
      status: 'error',
      timestamp: new Date().toISOString(),
      error: 'Health check failed',
    });
  }
}
```

## Production Monitoring Dashboard

```typescript
// src/pages/api/metrics.ts
export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  const metrics = {
    uptime: process.uptime(),
    memory: process.memoryUsage(),
    timestamp: new Date().toISOString(),
    node_version: process.version,
  };

  res.status(200).json(metrics);
}
```

## Deployment Validation

```bash
#!/bin/bash
# scripts/validate-deployment.sh

echo "🔍 Validating EventsOS deployment..."

# Check health endpoint
HEALTH_CHECK=$(curl -s https://eventos.fashion/api/health)
echo "Health Check: $HEALTH_CHECK"

# Verify critical pages
PAGES=("/" "/events" "/analytics" "/login")
for page in "${PAGES[@]}"; do
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" "https://eventos.fashion$page")
  echo "Page $page: HTTP $STATUS"
done

# Check bundle size
echo "Bundle Analysis:"
ls -lh .next/static/chunks/*.js | head -5

echo "✅ Deployment validation complete!"
```