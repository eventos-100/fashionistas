# 🎯 Mantine + Next.js Complete Pre-Setup Guide

**Date:** January 2025  
**Status:** Production-Ready ✅  
**Focus:** Zero-Error Setup with Progress Tracking

---

## 📑 Table of Contents

1. [Quick Start Overview](#1-quick-start-overview)
2. [System Requirements](#2-system-requirements)
3. [Official Templates & Versions](#3-official-templates--versions)
4. [Step-by-Step Setup Process](#4-step-by-step-setup-process)
5. [Configuration Deep Dive](#5-configuration-deep-dive)
6. [Common Issues & Solutions](#6-common-issues--solutions)
7. [Validation & Testing](#7-validation--testing)
8. [Production Readiness](#8-production-readiness)
9. [Next Steps & Resources](#9-next-steps--resources)

---

## 🚀 Progress Tracker

Track your setup progress with this checklist:

```
□ 1. System Requirements Check (5 min)
□ 2. Template Selection (2 min)
□ 3. Project Setup (5 min)
□ 4. Dependencies Installation (3 min)
□ 5. Configuration Verification (5 min)
□ 6. Development Server Test (2 min)
□ 7. Build Validation (3 min)
□ 8. Production Check (5 min)

Total Time: ~30 minutes
```

---

## 1. Quick Start Overview

### 🎯 What You'll Achieve
- ✅ Mantine + Next.js project ready for production
- ✅ All dependencies correctly configured
- ✅ Zero version conflicts
- ✅ TypeScript with strict mode
- ✅ PostCSS properly configured
- ✅ Dark/light theme support

### 📊 Success Metrics
| Metric | Target | Verification |
|--------|--------|--------------|
| Setup Time | <30 min | Timer check |
| Build Success | 100% | `pnpm build` passes |
| Type Safety | Zero errors | `pnpm typecheck` |
| Console Warnings | 0 | Browser DevTools |

---

## 2. System Requirements

### 2.1 Essential Prerequisites

| Requirement | Minimum Version | Recommended | Check Command |
|-------------|----------------|-------------|---------------|
| **Node.js** | 18.17.0 | 20.x LTS | `node --version` |
| **npm** | 8.0.0 | 10.x | `npm --version` |
| **pnpm** | 8.0.0 | 8.15.x | `pnpm --version` |
| **Git** | 2.0.0 | Latest | `git --version` |

### 2.2 Quick System Check Script

```bash
#!/bin/bash
# Save as check-system.sh

echo "🔍 Checking System Requirements..."
echo "================================"

# Check Node.js
NODE_VER=$(node -v 2>/dev/null)
if [[ $? -eq 0 ]]; then
  echo "✅ Node.js: $NODE_VER"
else
  echo "❌ Node.js: Not installed"
  echo "   Install from: https://nodejs.org/"
fi

# Check pnpm
PNPM_VER=$(pnpm -v 2>/dev/null)
if [[ $? -eq 0 ]]; then
  echo "✅ pnpm: $PNPM_VER"
else
  echo "⚠️  pnpm: Not installed"
  echo "   Install with: npm install -g pnpm"
fi

# Check Git
GIT_VER=$(git --version 2>/dev/null)
if [[ $? -eq 0 ]]; then
  echo "✅ Git: $GIT_VER"
else
  echo "❌ Git: Not installed"
fi
```

### 2.3 IDE Setup
- **VS Code** with extensions:
  - ESLint
  - Prettier
  - PostCSS Language Support
  - CSS Variable Autocomplete

---

## 3. Official Templates & Versions

### 3.1 Available Mantine Next.js Templates

| Template | Mantine Version | Next.js Version | React Version | Use Case |
|----------|----------------|-----------------|---------------|----------|
| **[next-app-template](https://github.com/mantinedev/next-app-template)** | 7.x | 14.x | 18.x | App Router (Recommended) |
| **[next-pages-template](https://github.com/mantinedev/next-pages-template)** | 7.x | 15.x | 19.x | Pages Router |
| **[next-app-min-template](https://github.com/mantinedev/next-app-min-template)** | 7.x | 14.x | 18.x | Minimal Setup |

### 3.2 Current Stable Versions (January 2025)

Based on the official templates, here are the **production-tested** dependency versions:

#### 🏆 Recommended: App Router Template
```json
{
  "dependencies": {
    "@mantine/core": "^7.x",
    "@mantine/hooks": "^7.x",
    "@tabler/icons-react": "^3.x",
    "next": "^14.x",
    "react": "^18.x",
    "react-dom": "^18.x"
  },
  "devDependencies": {
    "typescript": "^5.x",
    "postcss": "^8.x",
    "postcss-preset-mantine": "^1.x",
    "postcss-simple-vars": "^7.x"
  }
}
```

### 3.3 Version Compatibility Matrix

| Mantine | React | Next.js | Status |
|---------|-------|---------|--------|
| 7.x | 18.x | 13.x-14.x | ✅ Stable |
| 7.x | 19.x | 15.x | ⚠️ Experimental |
| 8.x | 18.x | 14.x-15.x | 🚧 Beta |

---

## 4. Step-by-Step Setup Process

### 4.1 Template Selection
```bash
# Step 1: Choose your template
# Option A: App Router (Recommended)
TEMPLATE_URL="https://github.com/mantinedev/next-app-template"

# Option B: Pages Router
# TEMPLATE_URL="https://github.com/mantinedev/next-pages-template"
```

### 4.2 Project Creation
```bash
# Step 2: Clone the template
git clone $TEMPLATE_URL my-fashionos-app
cd my-fashionos-app

# Step 3: Remove template git history
rm -rf .git
git init
git add .
git commit -m "Initial commit from Mantine template"
```

### 4.3 Dependency Installation
```bash
# Step 4: Install dependencies
pnpm install

# Step 5: Verify Mantine versions match
pnpm list | grep "@mantine"
# All @mantine packages should show the same version
```

### 4.4 Initial Configuration Check
```bash
# Step 6: Verify required files exist
ls -la postcss.config.* next.config.* tsconfig.json

# Step 7: Check package.json scripts
cat package.json | grep -A 10 '"scripts"'
```

### 4.5 Development Server Test
```bash
# Step 8: Start development server
pnpm dev

# Step 9: Open browser
# Visit http://localhost:3000
# Check console for errors (should be none)
```

---

## 5. Configuration Deep Dive

### 5.1 PostCSS Configuration
Location: `postcss.config.mjs`

```javascript
export default {
  plugins: {
    'postcss-preset-mantine': {},
    'postcss-simple-vars': {
      variables: {
        'mantine-breakpoint-xs': '36em',
        'mantine-breakpoint-sm': '48em',
        'mantine-breakpoint-md': '62em',
        'mantine-breakpoint-lg': '75em',
        'mantine-breakpoint-xl': '88em',
      },
    },
  },
};
```

### 5.2 TypeScript Configuration
Location: `tsconfig.json`

Key settings to verify:
- `"strict": true` - Ensures type safety
- `"jsx": "preserve"` - For Next.js
- `"moduleResolution": "bundler"` - Modern resolution

### 5.3 Next.js Configuration
Location: `next.config.mjs`

Essential features:
- React strict mode enabled
- Bundle analyzer configured
- Mantine packages optimized

### 5.4 Layout Configuration
Location: `app/layout.tsx` (App Router)

Critical components:
- MantineProvider wrapper
- ColorSchemeScript in head
- CSS imports

---

## 6. Common Issues & Solutions

### 6.1 Version Mismatch Error
**Symptom:** `Error: Mantine packages version mismatch`

**Solution:**
```bash
# Ensure all Mantine packages use same version
pnpm add @mantine/core@7.13.2 @mantine/hooks@7.13.2 -E
```

### 6.2 PostCSS Not Working
**Symptom:** Styles not applying, CSS variables undefined

**Solution:**
```bash
# Install missing PostCSS dependencies
pnpm add -D postcss postcss-preset-mantine postcss-simple-vars

# Verify postcss.config.mjs exists
test -f postcss.config.mjs && echo "✅ PostCSS config found" || echo "❌ PostCSS config missing"
```

### 6.3 Hydration Errors
**Symptom:** `Hydration failed because the initial UI does not match`

**Solution Checklist:**
1. Add `suppressHydrationWarning` to html tag
2. Ensure ColorSchemeScript is in head
3. Check for browser-only code in SSR

### 6.4 TypeScript Errors
**Symptom:** Red squiggles in VS Code, type errors

**Solution:**
```bash
# Install/update TypeScript types
pnpm add -D @types/react @types/node typescript

# Run type check
pnpm typecheck
```

### 6.5 Build Failures
**Symptom:** `pnpm build` fails

**Diagnostic Steps:**
```bash
# 1. Clean cache
rm -rf .next node_modules

# 2. Reinstall
pnpm install

# 3. Check for syntax errors
pnpm lint

# 4. Rebuild
pnpm build
```

---

## 7. Validation & Testing

### 7.1 Development Validation
```bash
# Run all checks
pnpm typecheck  # TypeScript validation
pnpm lint       # ESLint checks
pnpm prettier:check  # Code formatting
```

### 7.2 Build Validation
```bash
# Production build test
pnpm build

# Expected output:
# ✓ Compiled successfully
# ✓ Collecting page data
# ✓ Generating static pages
# ✓ Finalizing page optimization
```

### 7.3 Production Test
```bash
# Start production server
pnpm start

# Test at http://localhost:3000
# Should match development behavior
```

### 7.4 Bundle Analysis
```bash
# Analyze bundle size
ANALYZE=true pnpm build

# Opens bundle analyzer in browser
# Check for:
# - No duplicate packages
# - Reasonable chunk sizes
# - Tree shaking working
```

---

## 8. Production Readiness

### 8.1 Pre-Production Checklist

| Category | Item | Status | Verification |
|----------|------|--------|--------------|
| **Performance** | Lighthouse score >90 | ⬜ | Run Lighthouse |
| **Security** | Environment variables secured | ⬜ | Check .env.local |
| **SEO** | Meta tags configured | ⬜ | View page source |
| **Accessibility** | WCAG 2.1 compliant | ⬜ | Run axe DevTools |
| **Build** | Zero errors/warnings | ⬜ | `pnpm build` |
| **Types** | TypeScript strict mode | ⬜ | `pnpm typecheck` |

### 8.2 Optimization Tips

1. **Enable SWC minification** in next.config.mjs
2. **Optimize images** with next/image
3. **Enable compression** for static assets
4. **Configure caching** headers

### 8.3 Deployment Ready
```bash
# Final production test
pnpm test  # Runs all validation scripts
pnpm build # Creates production build
pnpm start # Tests production server
```

---

## 9. Next Steps & Resources

### 9.1 Immediate Next Steps

1. **Add Your First Component**
   ```bash
   # Create a component
   mkdir -p components/Button
   touch components/Button/Button.tsx
   ```

2. **Setup Custom Theme**
   - Modify theme in app/layout.tsx
   - Add custom colors
   - Configure typography

3. **Add Pages**
   ```bash
   # Create pages
   mkdir -p app/about app/contact
   ```

### 9.2 Essential Resources

| Resource | URL | Purpose |
|----------|-----|---------|
| **Mantine Docs** | https://mantine.dev/getting-started/ | Core documentation |
| **Next.js Guide** | https://mantine.dev/guides/next/ | Integration guide |
| **Components** | https://mantine.dev/core/button/ | Component library |
| **UI Examples** | https://ui.mantine.dev/ | Pre-built components |
| **GitHub Template** | https://github.com/mantinedev/next-app-template | Official template |

### 9.3 Common Additions
```bash
# Commonly added packages
pnpm add @mantine/dates      # Date pickers
pnpm add @mantine/form       # Form management
pnpm add @mantine/modals     # Modal system
pnpm add @mantine/notifications  # Notifications
```

---

## ✅ Final Verification

Your setup is complete when:

1. ✅ All system requirements met
2. ✅ Template cloned and configured
3. ✅ Dependencies installed without conflicts
4. ✅ Development server runs without errors
5. ✅ Production build succeeds
6. ✅ No console warnings in browser
7. ✅ TypeScript shows no errors
8. ✅ Mantine styles are visible

---

## 🎉 Success!

You now have a production-ready Mantine + Next.js application. Total setup time should be under 30 minutes with this guide.

**Remember:**
- Always use matching Mantine package versions
- Keep dependencies updated regularly
- Follow the official documentation for best practices
- Join the Mantine Discord for community support

---

**Ready to build amazing UIs with Mantine! 🚀**