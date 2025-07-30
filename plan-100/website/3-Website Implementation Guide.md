# EventsOS Website Implementation Guide - Production Ready

## 📚 Table of Contents

1. [Overview](#1-overview)
2. [Project Setup](#2-project-setup)
3. [Material-UI v6 SSR Configuration](#3-material-ui-v6-ssr-configuration)
4. [Security & Environment Setup](#4-security--environment-setup)
5. [Core Components](#5-core-components)
6. [Event Features](#6-event-features)
7. [Additional Pages](#7-additional-pages)
8. [Error Handling & Recovery](#8-error-handling--recovery)
9. [SEO & Accessibility](#9-seo--accessibility)
10. [Performance Optimization](#10-performance-optimization)
11. [Testing Strategy](#11-testing-strategy)
12. [Monitoring & Analytics](#12-monitoring--analytics)
13. [Production Checklist](#13-production-checklist)

---

## 📋 Progress Tracker

| Phase | Status | Tasks | Progress | Priority |
|-------|--------|-------|----------|----------|
| **Setup & Config** | 🟢 Ready | 12 | 0/12 | Critical |
| **Security** | 🟢 Ready | 8 | 0/8 | Critical |
| **Core Pages** | 🟢 Ready | 15 | 0/15 | High |
| **Features** | 🟢 Ready | 10 | 0/10 | High |
| **Error Handling** | 🟢 Ready | 6 | 0/6 | Critical |
| **SEO & A11y** | 🟢 Ready | 10 | 0/10 | High |
| **Performance** | 🟢 Ready | 8 | 0/8 | Medium |
| **Testing** | 🟢 Ready | 12 | 0/12 | High |
| **Monitoring** | 🟢 Ready | 6 | 0/6 | Medium |
| **Deployment** | 🟢 Ready | 10 | 0/10 | Critical |

**Total Tasks**: 97

---

## 1. Overview

Building a production-ready public-facing event website for EventsOS with enterprise-grade security, performance, and accessibility.

### Tech Stack Requirements
- **Framework**: Next.js 14+ (App Router)
- **UI Library**: Material-UI v6.5.0 (STRICT - NO v7)
- **SSR Package**: @mui/material-nextjs v15
- **Database**: Supabase (with RLS enforced)
- **Styling**: Emotion (MUI default)
- **Package Manager**: pnpm ONLY
- **Node Version**: 18+ with memory flag

### Key Features
- Fashion event showcase (runway shows, trade shows, galas)
- Event registration with payment integration
- Designer and model directories
- Sponsor management
- Real-time updates
- Multi-tenant architecture with RLS

---

## 2. Project Setup

### Task 2.1: Initialize Next.js Application

```bash
cd /home/sk/fx/eventos/apps

# Create Next.js app with specific configuration
pnpm create next-app@latest website \
  --typescript \
  --app \
  --no-src-dir \
  --tailwind=false \
  --import-alias "@/*"

cd website
```

### Task 2.2: Install Core Dependencies

```bash
# MUI v6 with exact versions
pnpm add @mui/material@6.5.0 @emotion/react@11.11.4 @emotion/styled@11.11.5

# Critical: SSR integration package for MUI v6
pnpm add @mui/material-nextjs@15.11.0 @emotion/cache@11.11.0 @emotion/server@11.11.0

# Additional MUI components
pnpm add @mui/icons-material@6.5.0 @mui/lab@6.0.0-beta.20 @mui/x-data-grid@6.19.0

# Form handling and validation
pnpm add react-hook-form@7.51.0 @hookform/resolvers@3.3.4 zod@3.22.4

# Supabase with SSR support
pnpm add @supabase/supabase-js@2.39.8 @supabase/ssr@0.1.0

# Date handling
pnpm add date-fns@3.3.1

# Development dependencies
pnpm add -D @types/react@18.2.55 @types/node@20.11.19
```

### Task 2.3: Lock Package Versions

```bash
# Create .npmrc to prevent accidental updates
echo "save-exact=true" > .npmrc
echo "engine-strict=true" >> .npmrc

# Commit lockfile immediately
git add pnpm-lock.yaml .npmrc
git commit -m "Lock package versions"
```

### Task 2.4: Configure TypeScript

Create tsconfig.json with strict settings:

```bash
# TypeScript configuration task
# File: tsconfig.json
# Strict mode enabled
# Path aliases configured
# Next.js 14 optimizations
```

### Task 2.5: Project Structure Setup

```bash
# Create organized directory structure
mkdir -p {components/{layout,home,events,common,forms},lib/{supabase,theme,utils,hooks},hooks,types,utils}
mkdir -p app/{events,designers,models,sponsors,api/{auth,events,register}}
mkdir -p public/images
```

### ✅ Setup Success Criteria
- [ ] Next.js 14 with App Router installed
- [ ] MUI v6.5.0 exact version verified
- [ ] @mui/material-nextjs v15 installed
- [ ] All dependencies locked
- [ ] TypeScript strict mode
- [ ] Directory structure created
- [ ] No npm/yarn files present

---

## 3. Material-UI v6 SSR Configuration

### Task 3.1: Create Emotion Cache

```bash
# Create emotion cache configuration
# File: lib/emotion/createEmotionCache.ts
# Prevents style injection issues
```

### Task 3.2: Theme Configuration with CSS Variables

```bash
# Create theme with CSS variables enabled
# File: lib/theme/theme.ts
# CSS variables for better SSR performance
# Fashion-focused color palette
```

### Task 3.3: Root Layout with SSR

```bash
# Configure root layout with proper SSR
# File: app/layout.tsx
# AppRouterCacheProvider from v15 package
# Font optimization with CSS variables
```

### Task 3.4: Client Theme Provider

```bash
# Create client-side theme provider
# File: components/providers/ThemeProvider.tsx
# Handles theme switching if needed
```

### ✅ SSR Success Criteria
- [ ] AppRouterCacheProvider from v15 package used
- [ ] CSS variables enabled in theme
- [ ] Font CSS variable configured
- [ ] No hydration errors
- [ ] No style flash on load
- [ ] Emotion cache properly configured

---

## 4. Security & Environment Setup

### Task 4.1: Environment Variable Validation

```bash
# Install environment validation
pnpm add @t3-oss/env-nextjs@0.9.2

# Create env validation schema
# File: lib/env.mjs
# Validates all environment variables at build time
```

### Task 4.2: Secure Environment Configuration

```bash
# Create .env.local with proper variables
# NEVER include SUPABASE_SERVICE_KEY in client code
# File: .env.local
```

### Task 4.3: Supabase Client Configuration

```bash
# Create separate server and client Supabase instances
# File: lib/supabase/server.ts - Server-only client
# File: lib/supabase/client.ts - Browser-safe client
# File: lib/supabase/middleware.ts - Edge-ready client
```

### Task 4.4: Content Security Policy

```bash
# Configure CSP headers
# File: middleware.ts
# Strict CSP for XSS prevention
```

### Task 4.5: RLS Enforcement Hook

```bash
# Create organization filter hook
# File: hooks/useOrganizationFilter.ts
# Enforces multi-tenant data isolation
```

### ✅ Security Success Criteria
- [ ] Environment variables validated with Zod
- [ ] Service key NEVER exposed to client
- [ ] Separate server/client Supabase instances
- [ ] CSP headers configured
- [ ] RLS enforcement implemented
- [ ] Session management setup

---

## 5. Core Components

### Task 5.1: Navigation Component

```bash
# Create responsive navigation
# File: components/layout/Navbar.tsx
# Mobile-first with drawer
# Skip navigation for accessibility
```

### Task 5.2: Hero Section

```bash
# Create hero component
# File: components/home/Hero.tsx
# Optimized background image
# Accessible CTAs
```

### Task 5.3: Event Card Component

```bash
# Create event card
# File: components/events/EventCard.tsx
# Type-safe props
# Loading skeleton included
```

### Task 5.4: Registration Form

```bash
# Create registration form with validation
# File: components/events/RegistrationForm.tsx
# Zod validation
# Error handling
# Duplicate email check
# Success feedback
```

### Task 5.5: Image Component with Fallback

```bash
# Create image wrapper component
# File: components/common/SafeImage.tsx
# Error fallback handling
# Loading state
```

### ✅ Component Success Criteria
- [ ] All components type-safe
- [ ] Loading states implemented
- [ ] Error boundaries added
- [ ] Mobile responsive
- [ ] Accessibility labels
- [ ] Skeleton loaders

---

## 6. Event Features

### Task 6.1: Event Listing Page

```bash
# Create event listing with filters
# File: app/events/page.tsx
# Server-side data fetching
# RLS-aware queries
# Pagination support
```

### Task 6.2: Event Detail Page

```bash
# Create event detail page
# File: app/events/[id]/page.tsx
# Dynamic metadata
# Schema.org structured data
# Registration integration
```

### Task 6.3: Event Search & Filters

```bash
# Create search and filter components
# File: components/events/EventFilters.tsx
# URL state management
# Accessible form controls
```

### Task 6.4: Registration Success Page

```bash
# Create registration success page
# File: app/events/[id]/success/page.tsx
# Confirmation details
# Next steps guidance
```

### ✅ Event Feature Success Criteria
- [ ] Server-side rendering working
- [ ] RLS filters applied
- [ ] Search functionality
- [ ] Filter persistence in URL
- [ ] Success feedback
- [ ] Loading states

---

## 7. Additional Pages

### Task 7.1: Home Page with All Sections

```bash
# Create complete home page
# File: app/page.tsx
# All required sections:
# - Navigation
# - Hero
# - About
# - Event highlights
# - Designers showcase
# - Ticketing CTA
# - Partners
# - Footer
```

### Task 7.2: Designers Directory

```bash
# Create designers page
# File: app/designers/page.tsx
# Grid layout
# Profile cards
# Filter by specialty
```

### Task 7.3: Models Directory

```bash
# Create models page
# File: app/models/page.tsx
# Portfolio gallery
# Booking information
```

### Task 7.4: Sponsors Page

```bash
# Create sponsors page
# File: app/sponsors/page.tsx
# Tier display
# Benefits showcase
```

### ✅ Additional Pages Success Criteria
- [ ] All sections implemented
- [ ] Data fetching optimized
- [ ] SEO metadata added
- [ ] Loading states
- [ ] Error handling
- [ ] Mobile responsive

---

## 8. Error Handling & Recovery

### Task 8.1: Error Boundary Component

```bash
# Create error boundary
# File: components/providers/ErrorBoundary.tsx
# Graceful error recovery
# Error logging to monitoring
```

### Task 8.2: Not Found Page

```bash
# Create 404 page
# File: app/not-found.tsx
# Helpful navigation options
# Search functionality
```

### Task 8.3: Error Page

```bash
# Create error page
# File: app/error.tsx
# User-friendly error messages
# Recovery actions
```

### Task 8.4: Loading States

```bash
# Create loading components
# File: app/loading.tsx
# File: app/events/loading.tsx
# Skeleton screens
```

### Task 8.5: Offline Support

```bash
# Add offline detection
# File: hooks/useOnlineStatus.ts
# Offline UI indicators
```

### ✅ Error Handling Success Criteria
- [ ] Error boundaries implemented
- [ ] 404 page created
- [ ] Error page with recovery
- [ ] Loading skeletons
- [ ] Offline handling
- [ ] Error logging setup

---

## 9. SEO & Accessibility

### Task 9.1: Dynamic Metadata

```bash
# Implement dynamic metadata
# File: app/events/[id]/metadata.ts
# OpenGraph tags
# Twitter cards
# Schema.org markup
```

### Task 9.2: Sitemap Generation

```bash
# Install and configure sitemap
pnpm add next-sitemap@4.2.3

# Create sitemap config
# File: next-sitemap.config.js
```

### Task 9.3: Robots.txt

```bash
# Create robots.txt
# File: public/robots.txt
# Proper crawl directives
```

### Task 9.4: Accessibility Testing Setup

```bash
# Install accessibility testing
pnpm add -D @axe-core/playwright@4.8.5

# Create a11y test suite
# File: tests/accessibility.spec.ts
```

### Task 9.5: Skip Navigation

```bash
# Add skip navigation link
# File: components/layout/SkipNav.tsx
# Keyboard navigation support
```

### Task 9.6: ARIA Labels

```bash
# Add proper ARIA labels
# Update all interactive components
# Form labels and descriptions
```

### ✅ SEO & A11y Success Criteria
- [ ] Dynamic OG tags working
- [ ] Sitemap generated
- [ ] Robots.txt configured
- [ ] Schema.org markup
- [ ] WCAG 2.1 AA compliant
- [ ] Keyboard navigation
- [ ] Screen reader tested

---

## 10. Performance Optimization

### Task 10.1: Image Optimization

```bash
# Configure Next.js image optimization
# File: next.config.js
# Cloudinary integration
# Format selection
# Lazy loading
```

### Task 10.2: Font Optimization

```bash
# Optimize font loading
# File: app/layout.tsx
# Font subsetting
# Display swap
# Preloading
```

### Task 10.3: Bundle Analysis

```bash
# Install bundle analyzer
pnpm add -D @next/bundle-analyzer@14.1.0

# Configure webpack
# File: next.config.js
```

### Task 10.4: Code Splitting

```bash
# Implement dynamic imports
# Heavy components lazy loaded
# Route-based splitting
```

### Task 10.5: Performance Monitoring

```bash
# Add web vitals tracking
# File: app/layout.tsx
# Report to analytics
```

### ✅ Performance Success Criteria
- [ ] Lighthouse score > 90
- [ ] LCP < 2.5s
- [ ] FID < 100ms
- [ ] CLS < 0.1
- [ ] Bundle size < 200KB
- [ ] Images optimized

---

## 11. Testing Strategy

### Task 11.1: Unit Test Setup

```bash
# Install testing dependencies
pnpm add -D @testing-library/react@14.2.1 @testing-library/jest-dom@6.4.2
pnpm add -D jest@29.7.0 jest-environment-jsdom@29.7.0 @types/jest@29.5.12

# Configure Jest
# File: jest.config.js
# File: jest.setup.js
```

### Task 11.2: Component Tests

```bash
# Create component tests
# Test EventCard, RegistrationForm
# Mock Supabase client
# Test error states
```

### Task 11.3: Integration Tests

```bash
# Create integration tests
# Test form submission flow
# Test data fetching
# Test error handling
```

### Task 11.4: E2E Test Setup

```bash
# Install Playwright
pnpm add -D @playwright/test@1.41.2

# Configure Playwright
# File: playwright.config.ts
```

### Task 11.5: E2E Test Scenarios

```bash
# Create E2E tests
# File: e2e/registration.spec.ts
# File: e2e/event-browsing.spec.ts
# File: e2e/critical-paths.spec.ts
```

### Task 11.6: Visual Regression Tests

```bash
# Set up visual testing
# Playwright screenshots
# Diff detection
```

### Task 11.7: Accessibility Tests

```bash
# Create a11y test suite
# File: tests/a11y/wcag.spec.ts
# Automated WCAG checks
```

### Task 11.8: Performance Tests

```bash
# Create performance tests
# Lighthouse CI setup
# Bundle size checks
```

### ✅ Testing Success Criteria
- [ ] Unit test coverage > 80%
- [ ] Integration tests passing
- [ ] E2E critical paths tested
- [ ] Visual regression setup
- [ ] A11y tests passing
- [ ] Performance budgets met
- [ ] CI/CD integration

---

## 12. Monitoring & Analytics

### Task 12.1: Error Monitoring

```bash
# Install Sentry
pnpm add @sentry/nextjs@7.102.0

# Configure Sentry
# File: sentry.client.config.ts
# File: sentry.server.config.ts
```

### Task 12.2: Analytics Setup

```bash
# Install analytics
pnpm add @vercel/analytics@1.1.2

# Configure analytics
# File: app/layout.tsx
```

### Task 12.3: Performance Monitoring

```bash
# Add web vitals reporting
# Custom performance marks
# Real user monitoring
```

### Task 12.4: Uptime Monitoring

```bash
# Configure health checks
# File: app/api/health/route.ts
# External monitoring setup
```

### ✅ Monitoring Success Criteria
- [ ] Error tracking active
- [ ] Analytics configured
- [ ] Performance monitoring
- [ ] Uptime checks
- [ ] Alert rules defined
- [ ] Dashboard created

---

## 13. Production Checklist

### Pre-Deployment Tasks

#### Task 13.1: Environment Validation
- [ ] All environment variables set
- [ ] No service keys in client code
- [ ] Environment validation passing

#### Task 13.2: Security Audit
- [ ] CSP headers configured
- [ ] RLS policies tested
- [ ] Authentication flows verified
- [ ] Rate limiting implemented
- [ ] CORS properly configured

#### Task 13.3: Build Verification
```bash
# Type checking
pnpm tsc --noEmit

# Linting
pnpm lint

# Test suite
pnpm test

# Build test
pnpm build

# Bundle analysis
ANALYZE=true pnpm build
```

#### Task 13.4: Database Preparation
- [ ] RLS policies active
- [ ] Indexes optimized
- [ ] Backup strategy confirmed
- [ ] Migration scripts ready

#### Task 13.5: Performance Validation
- [ ] Lighthouse CI passing
- [ ] Bundle size within budget
- [ ] Image optimization verified
- [ ] Caching headers set

#### Task 13.6: SEO & Accessibility
- [ ] Meta tags verified
- [ ] Sitemap accessible
- [ ] Schema markup valid
- [ ] WCAG compliance checked

#### Task 13.7: Monitoring Setup
- [ ] Error tracking live
- [ ] Analytics installed
- [ ] Alerts configured
- [ ] Logging enabled

#### Task 13.8: Documentation
- [ ] README updated
- [ ] API documentation
- [ ] Deployment guide
- [ ] Runbook created

#### Task 13.9: Deployment
```bash
# Final deployment steps
vercel --prod

# Verify deployment
curl https://eventos-website.vercel.app/api/health
```

#### Task 13.10: Post-Deployment
- [ ] Smoke tests passing
- [ ] Monitoring confirmed
- [ ] Team notified
- [ ] Backup verified

### ✅ Production Success Criteria
- [ ] All security measures active
- [ ] Performance targets met
- [ ] Zero console errors
- [ ] SEO validation passed
- [ ] Accessibility compliant
- [ ] Monitoring active
- [ ] Documentation complete
- [ ] Team trained

---

## 🎯 Final Notes

This guide ensures 100% production readiness by addressing:
- All security vulnerabilities identified in the audit
- Complete SEO and accessibility implementation
- Comprehensive error handling and recovery
- Performance optimization with monitoring
- Full test coverage including visual and a11y tests
- Proper environment configuration and validation

Follow each task sequentially and verify success criteria before proceeding to the next phase.