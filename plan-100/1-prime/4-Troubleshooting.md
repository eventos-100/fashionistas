# EventsOS Troubleshooting & Error Prevention Guide

## 🎯 Overview

This comprehensive guide helps you identify, diagnose, and resolve common issues during EventsOS development and deployment. Each issue includes root cause analysis, solutions, and prevention strategies.

---

## 🚨 Critical Issues & Solutions

### 1. Next.js Version Compatibility

**Issue**: Refine v4.57.10 not fully compatible with Next.js 15

**Symptoms**:
- Build errors mentioning "Module not found"
- Runtime errors with hooks
- Routing issues in admin panel

**Solution**:
```bash
# Check current Next.js version
grep "next" package.json

# If version is 15.x, downgrade
pnpm remove next
pnpm add next@14.2.3

# Update all apps
cd apps/admin && pnpm add next@14.2.3
cd ../website && pnpm add next@14.2.3

# Clear cache and rebuild
pnpm clean:all
pnpm install --frozen-lockfile
pnpm build
```

**Prevention**:
- Lock Next.js version in root package.json
- Use pnpm overrides to enforce version

---

### 2. Material-UI SSR Hydration Errors

**Issue**: Style mismatches between server and client

**Symptoms**:
- Console warnings about hydration
- Flash of unstyled content
- Styles jumping on page load

**Solution**:
```typescript
// 1. Create proper emotion cache
// packages/ui/src/theme/createEmotionCache.ts
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
    prepend: true // Ensures MUI styles load first
  })
}

// 2. Update app layout
// apps/website/src/app/layout.tsx
export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <head>
        <meta name="emotion-insertion-point" content="" />
      </head>
      <body>{children}</body>
    </html>
  )
}
```

**Prevention**:
- Always use emotion cache for SSR
- Test with JavaScript disabled
- Use React DevTools Profiler

---

### 3. Supabase Authentication Issues

**Issue**: Session not persisting across page refreshes

**Symptoms**:
- Users logged out on refresh
- 401 errors after authentication
- Session cookies not set

**Solution**:
```typescript
// 1. Create proper SSR client
// packages/database/src/client/server.ts
import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'

export function createClient() {
  const cookieStore = cookies()

  return createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        get(name: string) {
          return cookieStore.get(name)?.value
        },
        set(name: string, value: string, options: any) {
          cookieStore.set({ name, value, ...options })
        },
        remove(name: string, options: any) {
          cookieStore.delete({ name, ...options })
        },
      },
    }
  )
}

// 2. Create middleware for session refresh
// middleware.ts
import { createServerClient } from '@supabase/ssr'
import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'

export async function middleware(request: NextRequest) {
  let response = NextResponse.next({
    request: {
      headers: request.headers,
    },
  })

  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        get(name: string) {
          return request.cookies.get(name)?.value
        },
        set(name: string, value: string, options: any) {
          response.cookies.set({
            name,
            value,
            ...options,
          })
        },
        remove(name: string, options: any) {
          response.cookies.set({
            name,
            value: '',
            ...options,
          })
        },
      },
    }
  )

  await supabase.auth.getSession()

  return response
}
```

**Prevention**:
- Use @supabase/ssr for all server-side operations
- Implement proper middleware
- Test auth flow in incognito mode

---

### 4. Environment Variable Issues

**Issue**: Environment variables not loading or undefined

**Symptoms**:
- "undefined" values in production
- Different behavior local vs deployed
- Build failures mentioning env vars

**Solution**:
```bash
# 1. Validate environment setup
node scripts/check-env.js

# 2. Check .env.local exists and is populated
cat .env.local | grep -E "SUPABASE|NEXT_PUBLIC"

# 3. For Vercel deployment
vercel env pull .env.local

# 4. Debug in code
console.log('Env check:', {
  url: process.env.NEXT_PUBLIC_SUPABASE_URL,
  hasKey: !!process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
  nodeEnv: process.env.NODE_ENV,
})
```

**Prevention**:
- Use T3 Env for validation
- Never commit .env files
- Document all required vars

---

### 5. Monorepo Dependency Issues

**Issue**: Package not found or version conflicts

**Symptoms**:
- "Cannot find module @eventos/ui"
- Type errors in imports
- Build failures in CI but not local

**Solution**:
```bash
# 1. Check workspace configuration
cat pnpm-workspace.yaml

# 2. Verify package.json references
grep -r "workspace:" apps/*/package.json

# 3. Rebuild packages
pnpm clean:all
rm -rf node_modules pnpm-lock.yaml
pnpm install
pnpm build:packages

# 4. Check symbolic links
ls -la node_modules/@eventos/

# 5. If still failing, use explicit workspace protocol
pnpm add @eventos/ui@workspace:* --filter=@eventos/website
```

**Prevention**:
- Always use workspace protocol
- Build packages before apps
- Commit pnpm-lock.yaml

---

## ⚠️ Common Development Issues

### 1. Port Already in Use

**Issue**: Development server won't start

**Solution**:
```bash
# Find process using port
lsof -i :3000

# Kill process
kill -9 <PID>

# Or use different port
PORT=3002 pnpm dev
```

### 2. TypeScript Errors in IDE

**Issue**: False positive errors in VS Code

**Solution**:
```bash
# 1. Restart TS server
# Cmd+Shift+P > "TypeScript: Restart TS Server"

# 2. Clear TS cache
rm -rf node_modules/.cache/typescript

# 3. Rebuild
pnpm type-check
```

### 3. Build Memory Issues

**Issue**: JavaScript heap out of memory

**Solution**:
```bash
# Increase Node memory
export NODE_OPTIONS="--max_old_space_size=8192"

# Or in package.json
"scripts": {
  "build": "NODE_OPTIONS='--max_old_space_size=8192' next build"
}
```

---

## 🚀 Deployment Issues

### 1. Vercel Build Failures

**Issue**: Build works locally but fails on Vercel

**Common Causes**:
- Missing environment variables
- Different Node version
- Case-sensitive imports

**Solution**:
```bash
# 1. Match Node version
echo "18.17.0" > .nvmrc

# 2. Check case sensitivity
find . -name "*.tsx" -exec grep -l "from '@Eventos" {} \;

# 3. Test production build locally
pnpm build
pnpm start

# 4. Check Vercel logs
vercel logs eventos-website --follow
```

### 2. Database Connection Issues

**Issue**: Can't connect to Supabase in production

**Solution**:
```bash
# 1. Verify connection string
curl https://wnjudgmhabzhcttgyxou.supabase.co/rest/v1/

# 2. Check service role key
# Should start with "eyJ"

# 3. Test connection
node -e "
const { createClient } = require('@supabase/supabase-js')
const client = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
)
client.from('events').select('count').then(console.log)
"
```

---

## 🛡️ Security Issues

### 1. Exposed API Keys

**Issue**: Sensitive keys in client-side code

**Detection**:
```bash
# Search for exposed keys
grep -r "CLOUDINARY_API_SECRET\|SERVICE_ROLE" apps/*/src --include="*.tsx"

# Check bundle for secrets
pnpm build
grep -r "eyJ" apps/*/.next/static
```

**Solution**:
- Move to server-only API routes
- Use environment validation
- Implement API proxy

### 2. RLS Policy Failures

**Issue**: Users can access unauthorized data

**Testing**:
```sql
-- Test as anonymous user
SET ROLE anon;
SELECT * FROM events WHERE organization_id != 'public';

-- Should return 0 rows
```

**Solution**:
```sql
-- Fix RLS policy
ALTER TABLE events ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can only see their org events"
ON events FOR SELECT
USING (
  organization_id = auth.uid() 
  OR 
  is_public = true
);
```

---

## 📊 Performance Issues

### 1. Slow Initial Load

**Issue**: High Time to First Byte (TTFB)

**Diagnosis**:
```bash
# Run Lighthouse
pnpm lighthouse

# Check bundle size
pnpm analyze
```

**Solutions**:
- Enable SWC minification
- Implement dynamic imports
- Optimize images with next/image
- Use static generation where possible

### 2. Memory Leaks

**Issue**: Application slows down over time

**Detection**:
```javascript
// Add to development
if (process.env.NODE_ENV === 'development') {
  setInterval(() => {
    console.log('Memory:', process.memoryUsage())
  }, 30000)
}
```

**Common Causes**:
- Event listeners not cleaned up
- Intervals/timeouts not cleared
- Large objects in closure scope

---

## 🔍 Debugging Tools & Techniques

### 1. Debug Configuration

```json
// .vscode/launch.json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Debug Next.js",
      "runtimeExecutable": "pnpm",
      "runtimeArgs": ["dev"],
      "port": 9229,
      "env": {
        "NODE_OPTIONS": "--inspect"
      }
    }
  ]
}
```

### 2. Logging Strategy

```typescript
// packages/utils/src/logger.ts
export const logger = {
  debug: (...args: any[]) => {
    if (process.env.NODE_ENV === 'development') {
      console.log('[DEBUG]', ...args)
    }
  },
  error: (...args: any[]) => {
    console.error('[ERROR]', ...args)
    // Send to Sentry in production
  },
  info: (...args: any[]) => {
    console.log('[INFO]', ...args)
  },
}
```

### 3. Error Boundaries

```typescript
// apps/website/src/app/error.tsx
'use client'

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  useEffect(() => {
    // Log to error reporting service
    console.error(error)
  }, [error])

  return (
    <div>
      <h2>Something went wrong!</h2>
      <button onClick={() => reset()}>Try again</button>
    </div>
  )
}
```

---

## 📋 Prevention Checklist

### Before Every Commit
- [ ] Run `pnpm type-check`
- [ ] Run `pnpm lint`
- [ ] Run `pnpm test`
- [ ] Check for console.logs
- [ ] Verify no secrets exposed

### Before Every Deploy
- [ ] Test production build locally
- [ ] Run Lighthouse audit
- [ ] Check bundle size
- [ ] Verify env vars in Vercel
- [ ] Test critical user flows

### Weekly Maintenance
- [ ] Update dependencies
- [ ] Run security audit
- [ ] Check error logs
- [ ] Review performance metrics
- [ ] Update documentation

---

## 🆘 Getting Help

### Resources
1. **Documentation**: Check `/docs` folder
2. **GitHub Issues**: Search existing issues
3. **Discord**: Join EventsOS community
4. **Stack Overflow**: Tag with `eventos`

### Debug Information to Provide
```bash
# System info
npx envinfo --system --npmPackages --binaries

# Project info
pnpm list --depth=0
git log --oneline -10
cat .env.local | grep -v SECRET | grep -v KEY

# Error details
# Include full error message
# Include steps to reproduce
# Include expected vs actual behavior
```

---

## 🚀 Quick Fixes Reference

| Issue | Quick Fix |
|-------|-----------|
| Module not found | `pnpm build:packages` |
| Hydration error | Check for dynamic content |
| Auth not working | Check middleware.ts |
| Env var undefined | Run `pnpm dev` not `next dev` |
| Type errors | Restart TS server |
| Port in use | `kill -9 $(lsof -ti:3000)` |
| Build OOM | `NODE_OPTIONS='--max_old_space_size=8192'` |

Remember: Most issues are configuration-related. When in doubt, clean and rebuild! 🎉