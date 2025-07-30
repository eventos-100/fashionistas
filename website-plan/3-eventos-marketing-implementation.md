# EventsOS Marketing Page Implementation Guide

## 📋 Table of Contents

1. [Version Compatibility Matrix](#version-compatibility-matrix)
2. [Pre-Implementation Checklist](#pre-implementation-checklist)
3. [Step-by-Step Implementation](#step-by-step-implementation)
4. [Progress Tracker](#progress-tracker)
5. [Testing Criteria](#testing-criteria)
6. [Production Readiness Checklist](#production-readiness-checklist)
7. [Troubleshooting Guide](#troubleshooting-guide)

---

## 🔧 Version Compatibility Matrix

### Critical Version Alignment (MUST MATCH)

| Package | Version | Source | Notes |
|---------|---------|--------|--------|
| **React** | 18.3.1 | Refine Admin | ⚠️ MUST match admin exactly |
| **React DOM** | 18.3.1 | Refine Admin | ⚠️ MUST match admin exactly |
| **@mui/material** | 6.5.0 | EventsOS Spec | ✅ NOT v7, locked to v6.5.0 |
| **@emotion/react** | 11.11.4 | Shared | Required by MUI v6 |
| **@emotion/styled** | 11.11.5 | Shared | Required by MUI v6 |
| **Next.js** | 14.2.30 | Refine Admin | App Router compatible |

### Version Lock Command
```bash
cd /home/sk/fx/eventos/apps/website
../../pnpm add react@18.3.1 react-dom@18.3.1 @mui/material@6.5.0 @emotion/react@11.11.4 @emotion/styled@11.11.5 next@14.2.30 -E
```

---

## ✅ Pre-Implementation Checklist

### System Requirements
- [ ] Node.js >= 18.0.0 installed
- [ ] pnpm available at `/home/sk/fx/eventos/pnpm`
- [ ] Memory optimization set: `export NODE_OPTIONS="--max_old_space_size=4096"`
- [ ] Git initialized in project root

### Directory Structure Verification
```bash
# Run this command to verify structure
cd /home/sk/fx/eventos && tree -L 2 apps/
```

Expected:
```
apps/
├── admin/     # Refine dashboard (existing)
├── website/   # Marketing site (to create)
└── api/       # Backend (future)
```

---

## 🚀 Step-by-Step Implementation

### Step 1: Create Website App Structure
```bash
# Navigate to apps directory
cd /home/sk/fx/eventos/apps

# Create website directory
mkdir -p website/src/{components,pages,sections,layouts,hooks,utils}
mkdir -p website/public/{images,fonts}
mkdir -p website/src/styles
```

### Step 2: Initialize Website Package
```bash
cd /home/sk/fx/eventos/apps/website

# Create package.json
cat > package.json << 'EOF'
{
  "name": "@eventos/website",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev -p 3000",
    "build": "next build",
    "start": "next start -p 3000",
    "lint": "next lint"
  },
  "dependencies": {
    "react": "18.3.1",
    "react-dom": "18.3.1",
    "next": "14.2.30",
    "@mui/material": "6.5.0",
    "@mui/icons-material": "6.5.0",
    "@mui/lab": "6.5.0",
    "@emotion/react": "11.11.4",
    "@emotion/styled": "11.11.5",
    "@emotion/cache": "11.11.0"
  },
  "devDependencies": {
    "@types/node": "^18.16.2",
    "@types/react": "^18.0.0",
    "@types/react-dom": "^18.0.0",
    "typescript": "^5.4.2",
    "eslint": "^8",
    "eslint-config-next": "14.2.30"
  }
}
EOF
```

### Step 3: Install Dependencies
```bash
cd /home/sk/fx/eventos/apps/website
../../pnpm install
```

### Step 4: Create Next.js Configuration
```bash
# Create next.config.mjs
cat > next.config.mjs << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  modularizeImports: {
    '@mui/icons-material': {
      transform: '@mui/icons-material/{{member}}',
    },
    '@mui/material': {
      transform: '@mui/material/{{member}}',
    },
  },
  images: {
    domains: ['cloudinary.com', 'res.cloudinary.com'],
  },
}

export default nextConfig
EOF
```

### Step 5: Create TypeScript Configuration
```bash
# Create tsconfig.json
cat > tsconfig.json << 'EOF'
{
  "extends": "../../tsconfig.json",
  "compilerOptions": {
    "target": "ES2022",
    "lib": ["dom", "dom.iterable", "esnext"],
    "jsx": "preserve",
    "module": "esnext",
    "moduleResolution": "bundler",
    "allowJs": true,
    "strict": true,
    "noEmit": true,
    "incremental": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "paths": {
      "@/*": ["./src/*"],
      "@eventos/ui": ["../../packages/ui/src"],
      "@eventos/utils": ["../../packages/utils/src"]
    },
    "plugins": [
      {
        "name": "next"
      }
    ]
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
EOF
```

### Step 6: Create App Router Structure
```bash
# Create app directory structure
mkdir -p src/app/{(marketing),api}

# Create root layout
cat > src/app/layout.tsx << 'EOF'
import type { Metadata } from 'next'
import { AppRouterCacheProvider } from '@mui/material-nextjs/v14-appRouter'
import { ThemeProvider } from '@mui/material/styles'
import CssBaseline from '@mui/material/CssBaseline'
import theme from '@/styles/theme'

export const metadata: Metadata = {
  title: 'EventsOS - AI-Powered Event Management',
  description: 'Transform your fashion events with intelligent automation',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>
        <AppRouterCacheProvider>
          <ThemeProvider theme={theme}>
            <CssBaseline />
            {children}
          </ThemeProvider>
        </AppRouterCacheProvider>
      </body>
    </html>
  )
}
EOF
```

### Step 7: Create MUI Theme Configuration
```bash
# Create theme file
mkdir -p src/styles
cat > src/styles/theme.ts << 'EOF'
'use client'

import { createTheme } from '@mui/material/styles'
import { Inter } from 'next/font/google'

const inter = Inter({
  weight: ['300', '400', '500', '700'],
  subsets: ['latin'],
  display: 'swap',
})

const theme = createTheme({
  palette: {
    mode: 'light',
    primary: {
      main: '#1976d2',
    },
    secondary: {
      main: '#dc004e',
    },
  },
  typography: {
    fontFamily: inter.style.fontFamily,
  },
  components: {
    MuiButton: {
      styleOverrides: {
        root: {
          textTransform: 'none',
        },
      },
    },
  },
})

export default theme
EOF
```

### Step 8: Create Marketing Page Components
```bash
# Create Hero Section
cat > src/components/Hero.tsx << 'EOF'
import { Box, Container, Typography, Button, Stack } from '@mui/material'
import { ArrowForward } from '@mui/icons-material'

export default function Hero() {
  return (
    <Box
      sx={{
        bgcolor: 'background.paper',
        pt: 8,
        pb: 6,
      }}
    >
      <Container maxWidth="md">
        <Typography
          component="h1"
          variant="h2"
          align="center"
          color="text.primary"
          gutterBottom
        >
          EventsOS
        </Typography>
        <Typography variant="h5" align="center" color="text.secondary" paragraph>
          AI-Powered Event Management for Fashion & Corporate Events
        </Typography>
        <Stack
          sx={{ pt: 4 }}
          direction="row"
          spacing={2}
          justifyContent="center"
        >
          <Button variant="contained" endIcon={<ArrowForward />}>
            Get Started
          </Button>
          <Button variant="outlined">Learn More</Button>
        </Stack>
      </Container>
    </Box>
  )
}
EOF
```

### Step 9: Create Main Page
```bash
# Create main marketing page
cat > src/app/page.tsx << 'EOF'
import Hero from '@/components/Hero'
import Features from '@/components/Features'
import Pricing from '@/components/Pricing'
import Footer from '@/components/Footer'

export default function Home() {
  return (
    <>
      <Hero />
      <Features />
      <Pricing />
      <Footer />
    </>
  )
}
EOF
```

### Step 10: Add MUI Next.js Integration Package
```bash
cd /home/sk/fx/eventos/apps/website
../../pnpm add @mui/material-nextjs@6.5.0
```

---

## 📊 Progress Tracker

### Phase 1: Setup ✅
- [x] Create directory structure
- [x] Initialize package.json
- [x] Install dependencies
- [x] Configure Next.js
- [x] Set up TypeScript

### Phase 2: Core Implementation 🔄
- [x] Create App Router layout
- [x] Configure MUI theme
- [x] Build Hero component
- [ ] Build Features section
- [ ] Build Pricing section
- [ ] Build Footer component

### Phase 3: Integration 📋
- [ ] Connect to Supabase
- [ ] Add authentication
- [ ] Integrate with admin dashboard
- [ ] Set up analytics

### Phase 4: Optimization 🚀
- [ ] Performance optimization
- [ ] SEO enhancement
- [ ] Accessibility audit
- [ ] Mobile responsiveness

---

## 🧪 Testing Criteria

### Compatibility Tests
```bash
# 1. Version alignment check
cd /home/sk/fx/eventos
./pnpm list react react-dom @mui/material --filter "@eventos/*"

# Expected output:
# @eventos/admin: react@18.3.1, react-dom@18.3.1, @mui/material@6.5.0
# @eventos/website: react@18.3.1, react-dom@18.3.1, @mui/material@6.5.0
```

### Development Server Test
```bash
# Start both servers
cd /home/sk/fx/eventos
./pnpm dev:admin    # Should run on port 3001
./pnpm dev:website  # Should run on port 3000
```

### Build Test
```bash
cd /home/sk/fx/eventos/apps/website
../../pnpm build

# Success criteria:
# - No version mismatch warnings
# - Build completes in < 60s
# - Bundle size < 200KB (First Load JS)
```

### Component Tests
- [ ] All MUI components render without hydration errors
- [ ] Theme applies correctly across all components
- [ ] Responsive breakpoints work as expected
- [ ] No console errors in development or production

---

## 🚢 Production Readiness Checklist

### Performance
- [ ] Lighthouse score > 90 for all metrics
- [ ] First Contentful Paint < 1.8s
- [ ] Time to Interactive < 3.8s
- [ ] Bundle size optimized with tree shaking

### SEO & Accessibility
- [ ] All pages have unique meta tags
- [ ] Structured data implemented
- [ ] ARIA labels on all interactive elements
- [ ] Keyboard navigation fully functional

### Security
- [ ] Environment variables properly configured
- [ ] CSP headers implemented
- [ ] API routes protected
- [ ] Input validation on all forms

### Deployment
- [ ] Vercel configuration complete
- [ ] Environment variables set in Vercel
- [ ] Custom domain configured
- [ ] SSL certificate active

### Monitoring
- [ ] Error tracking configured (Sentry)
- [ ] Analytics installed (GA4/Mixpanel)
- [ ] Performance monitoring active
- [ ] Uptime monitoring configured

---

## 🔧 Troubleshooting Guide

### Common Issues & Solutions

#### Issue: Version Mismatch Warning
```bash
# Solution: Ensure exact versions
cd /home/sk/fx/eventos/apps/website
../../pnpm add react@18.3.1 react-dom@18.3.1 -E
```

#### Issue: Hydration Errors
```typescript
// Add 'use client' directive to interactive components
'use client'
import { useState } from 'react'
// ... component code
```

#### Issue: Theme Not Applying
```typescript
// Ensure theme provider wraps entire app
import { AppRouterCacheProvider } from '@mui/material-nextjs/v14-appRouter'
```

#### Issue: Build Failures
```bash
# Clear cache and rebuild
rm -rf .next node_modules
../../pnpm install
../../pnpm build
```

---

## 📝 Final Implementation Commands

```bash
# Complete setup sequence
cd /home/sk/fx/eventos

# 1. Install all dependencies
./pnpm install

# 2. Start development servers
./pnpm dev

# 3. Build for production
./pnpm build

# 4. Run production build
./pnpm start
```

## 🎯 Success Criteria

✅ **Version Alignment**: React 18.3.1 across all apps  
✅ **MUI Compatibility**: v6.5.0 (not v7)  
✅ **Performance**: < 2s initial load  
✅ **Zero Errors**: No console warnings in production  
✅ **Responsive**: Works on all devices  
✅ **Accessible**: WCAG 2.1 AA compliant