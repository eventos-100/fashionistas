# 🎭 Fashionistas Frontend Implementation Plan - MUI v6 + Next.js 14

## 📘 Table of Contents

1. [Project Overview & Architecture](#1-project-overview--architecture)
2. [Pre-Implementation Checklist](#2-pre-implementation-checklist)
3. [Installation & Setup Guide](#3-installation--setup-guide)
4. [Component System Architecture](#4-component-system-architecture)
5. [Homepage Implementation](#5-homepage-implementation)
6. [Additional Pages & Templates](#6-additional-pages--templates)
7. [MUI v6 Component Selection](#7-mui-v6-component-selection)
8. [Integration Requirements](#8-integration-requirements)
9. [Progress Tracker & Phases](#9-progress-tracker--phases)
10. [User Journey Optimization](#10-user-journey-optimization)
11. [Performance & Testing Strategy](#11-performance--testing-strategy)
12. [Troubleshooting Guide](#12-troubleshooting-guide)
13. [Production Deployment Checklist](#13-production-deployment-checklist)

---

## 1. Project Overview & Architecture

### 🎯 Project Goals
Build a luxury fashion event platform that showcases:
- High-end fashion shows and runway events
- Designer collections and profiles
- VIP experiences and ticketing
- Sponsor partnerships
- Social media integration

### 🏗️ Technical Architecture
```
fashionistas/
├── apps/
│   ├── website/          # Marketing frontend (this plan)
│   └── admin/           # EventsOS dashboard
├── packages/
│   ├── ui/             # Shared components
│   └── utils/          # Shared utilities
└── infrastructure/
    └── vercel/         # Deployment configs
```

### 📦 Core Technology Stack
- **Framework**: Next.js 14.2.30 (App Router)
- **UI Library**: Material UI v6.5.0
- **Styling**: Emotion + MUI Theme
- **Package Manager**: pnpm
- **Media**: Cloudinary
- **Backend**: Supabase
- **Deployment**: Vercel

---

## 2. Pre-Implementation Checklist

### 🔍 Environment Verification

| Requirement | Command | Expected Output |
|------------|---------|-----------------|
| Node Version | `node --version` | v18.19.1 or higher |
| pnpm Available | `which pnpm` | `/home/sk/fx/eventos/pnpm` |
| Memory Config | `echo $NODE_OPTIONS` | `--max_old_space_size=4096` |
| Project Structure | `ls -la apps/` | Shows admin folder |

### ⚠️ Critical Version Alignment

| Package | Required Version | Reason |
|---------|-----------------|--------|
| React | 18.3.1 | Must match admin app |
| React DOM | 18.3.1 | Must match admin app |
| @mui/material | 6.5.0 | NOT v7 - locked version |
| @emotion/react | 11.11.4 | MUI v6 requirement |
| Next.js | 14.2.30 | App Router support |

### 📋 Pre-Development Tasks
- [ ] Verify all environment requirements
- [ ] Create project directories
- [ ] Set up Git repository
- [ ] Configure VS Code settings
- [ ] Install required VS Code extensions

---

## 3. Installation & Setup Guide

### 📁 Step 1: Project Structure Creation

**Prompt for Claude:**
```
Create the website app structure at /home/sk/fx/eventos/apps/website with these directories:
- src/app/(marketing) for marketing pages
- src/components for all components
- src/hooks for custom hooks
- src/utils for utilities
- src/types for TypeScript types
- public/images for static assets
```

### 📦 Step 2: Package Configuration

**Prompt for Claude:**
```
Create package.json at /home/sk/fx/eventos/apps/website with:
- Exact versions: react@18.3.1, react-dom@18.3.1, @mui/material@6.5.0
- Scripts for dev (port 3009), build, start
- Dependencies for MUI v6, Cloudinary, Supabase
- Dev dependencies for TypeScript and testing
```

### ⚙️ Step 3: Next.js Configuration

**Prompt for Claude:**
```
Create next.config.mjs with:
- Cloudinary image domains
- MUI modularizeImports optimization
- App Router experimental features
- Performance optimizations
```

### 🎨 Step 4: Theme Setup

**Prompt for Claude:**
```
Create MUI v6 dark fashion theme at src/styles/theme.ts with:
- Primary: #E91E63 (Fashion Pink)
- Secondary: #FFD700 (Luxury Gold)
- Background: #0A0A0A
- Typography: Playfair Display + Inter
- Glass morphism effects for cards
```

---

## 4. Component System Architecture

### 🧩 Component Categories & Structure

| Category | Components | MUI Usage | Location |
|----------|------------|-----------|----------|
| **Layout** | `Header`, `Footer`, `Layout` | AppBar, Container | `/components/layout/` |
| **Navigation** | `NavMenu`, `MobileDrawer`, `Breadcrumbs` | Drawer, Tabs, Link | `/components/navigation/` |
| **Sections** | `HeroSection`, `FeaturedEvents`, `Statistics` | Box, Grid, Typography | `/components/sections/` |
| **Cards** | `EventCard`, `DesignerCard`, `TestimonialCard` | Card, CardMedia | `/components/cards/` |
| **UI Elements** | `CTAButton`, `FloatingImage`, `CountUp` | Button, Fab, Chip | `/components/ui/` |
| **Forms** | `NewsletterForm`, `ContactForm`, `RSVPForm` | TextField, Autocomplete | `/components/forms/` |
| **Carousel** | `EventCarousel`, `TestimonialSlider` | Custom + Swiper | `/components/carousel/` |
| **Gallery** | `ImageGallery`, `Lightbox`, `FilterableGrid` | ImageList, Dialog | `/components/gallery/` |

### 🏗️ Component Implementation Strategy

**Base Component Template Prompt:**
```
Create a TypeScript React component with:
- MUI v6 sx prop for styling
- Responsive design using theme breakpoints
- Proper TypeScript interfaces
- Accessibility attributes (ARIA)
- Performance optimization (memo where needed)
```

---

## 5. Homepage Implementation

### 🏠 Homepage Section Breakdown

| Section | Purpose | Key Features | Implementation Priority |
|---------|---------|--------------|------------------------|
| **Hero** | First impression | Video bg, floating images, CTAs | P0 - Critical |
| **Featured Events** | Showcase top 3 events | Card grid, hover effects | P0 - Critical |
| **Fashion Calendar** | Monthly event overview | Horizontal scroll, filters | P1 - High |
| **Designer Spotlight** | Featured designers | Carousel, profiles | P1 - High |
| **Statistics** | Social proof | Animated counters | P2 - Medium |
| **Gallery Preview** | Visual showcase | Masonry grid | P2 - Medium |
| **Testimonials** | Trust building | Quote carousel | P2 - Medium |
| **Newsletter** | Lead capture | Email form, validation | P1 - High |
| **Instagram Feed** | Social proof | API integration | P3 - Low |

### 📋 Section Implementation Tasks

#### Hero Section
**Prompt for Claude:**
```
Implement Hero section with:
- Full viewport height with Cloudinary background
- Floating fashion images using absolute positioning
- Parallax effect on scroll
- Two CTAs: "Get Tickets" and "Become a Partner"
- Mobile responsive with reduced animations
```

#### Featured Events Section
**Prompt for Claude:**
```
Create Featured Events grid with:
- 3-column responsive layout using MUI Grid
- EventCard components with glass morphism
- Hover animations showing event details
- Integration with Supabase for dynamic data
- Skeleton loading states
```

#### Fashion Calendar Section
**Prompt for Claude:**
```
Build Fashion Calendar with:
- 12 month cards in horizontal scroll
- Each card shows month name and event count
- Filter by event type (runway, gala, exhibition)
- Smooth scroll with touch support
- Active month highlighting
```

---

## 6. Additional Pages & Templates

### 📄 Marketing Page Template Usage

From MUI v6 templates, we should leverage:

| Template | Our Usage | Components to Extract |
|----------|-----------|---------------------|
| **Landing Page** | Homepage base | Hero, Features, Testimonials |
| **Pricing Page** | Ticket tiers | PricingCard, ComparisonTable |
| **Blog Template** | Press/News section | ArticleCard, CategoryFilter |
| **About Page** | Designer profiles | TeamCard, Timeline |
| **Product Page** | Event details | Gallery, Specifications |

### 🎯 Page Implementation Priority

| Priority | Page | Path | Template Base | Key Sections |
|----------|------|------|--------------|--------------|
| **P0** | Homepage | `/` | Landing Page | All sections |
| **P0** | Events | `/events` | Product Page | Filter, Grid, Map |
| **P1** | Event Detail | `/events/[id]` | Product Page | Gallery, Info, RSVP |
| **P1** | Designers | `/designers` | About Page | Directory, Profiles |
| **P2** | Gallery | `/gallery` | Blog Template | Filterable Grid |
| **P2** | Sponsors | `/sponsors` | Pricing Page | Tiers, Benefits |
| **P3** | Press | `/press` | Blog Template | Articles, Downloads |
| **P3** | Contact | `/contact` | Custom | Form, Map, FAQ |

---

## 7. MUI v6 Component Selection

### 🎨 Essential MUI Components for Fashion Events

| Component | Our Usage | Customization Needed |
|-----------|-----------|---------------------|
| **DataGrid** | Guest lists, event management | Dark theme, custom columns |
| **Autocomplete** | Designer/venue search | Async loading, avatars |
| **DatePicker** | Event scheduling | Blackout dates, time slots |
| **Dialog** | Event details, RSVP forms | Full-screen mobile |
| **Tabs** | Event categories, galleries | Scrollable, icons |
| **Stepper** | RSVP process, checkout | Custom connectors |
| **Snackbar** | Notifications, confirmations | Branded styling |
| **Card** | Events, designers, testimonials | Glass morphism |
| **ImageList** | Gallery, lookbooks | Masonry layout |
| **Skeleton** | Loading states | Custom animations |

### 🔧 Advanced Components Implementation

**DataGrid for Guest Management:**
```
Prompt: Implement MUI DataGrid for VIP guest list with:
- Sortable columns (name, status, table)
- Quick filters for VIP levels
- Export to Excel functionality
- Real-time check-in status
```

**Autocomplete for Designer Search:**
```
Prompt: Create designer search with:
- Async search from Supabase
- Custom option rendering with avatars
- Recent searches in localStorage
- Mobile-optimized dropdown
```

---

## 8. Integration Requirements

### 🔌 Essential Integrations

| Integration | Purpose | Implementation Priority |
|-------------|---------|------------------------|
| **Supabase** | Database, Auth, Realtime | P0 - Critical |
| **Cloudinary** | Image optimization, CDN | P0 - Critical |
| **Stripe** | Ticket payments | P1 - High |
| **SendGrid** | Email notifications | P1 - High |
| **Instagram API** | Social feed | P2 - Medium |
| **Google Maps** | Venue locations | P2 - Medium |
| **Analytics** | User tracking | P1 - High |

### 🛠️ Integration Setup Tasks

**Supabase Integration:**
```
Prompt: Set up Supabase client with:
- Environment variables configuration
- Auth helpers for Next.js App Router
- Real-time subscriptions for events
- Row Level Security policies
```

**Cloudinary Setup:**
```
Prompt: Configure Cloudinary with:
- Next.js image optimization
- Responsive image transforms
- Upload widget for admin
- Gallery management
```

---

## 9. Progress Tracker & Phases

### 📊 Development Phases

| Phase | Duration | Deliverables | Success Criteria |
|-------|----------|--------------|------------------|
| **Phase 1: Foundation** | 3 days | Setup, theme, layout | Dev environment running |
| **Phase 2: Core Pages** | 5 days | Homepage, events | 3 pages functional |
| **Phase 3: Features** | 4 days | Auth, search, filters | User flows complete |
| **Phase 4: Polish** | 3 days | Animations, optimization | Lighthouse > 90 |
| **Phase 5: Launch** | 2 days | Deployment, monitoring | Production stable |

### ✅ Task Progress Tracker

#### Phase 1: Foundation (Days 1-3)
- [ ] Project setup and configuration
- [ ] MUI theme implementation
- [ ] Layout components (Header, Footer)
- [ ] Navigation system
- [ ] Responsive grid system

#### Phase 2: Core Pages (Days 4-8)
- [ ] Homepage all sections
- [ ] Events listing page
- [ ] Event detail page
- [ ] Designer directory
- [ ] Basic filtering

#### Phase 3: Features (Days 9-12)
- [ ] Authentication flow
- [ ] Search functionality
- [ ] RSVP system
- [ ] Newsletter integration
- [ ] Social media feeds

#### Phase 4: Polish (Days 13-15)
- [ ] Animations and transitions
- [ ] Performance optimization
- [ ] SEO implementation
- [ ] Accessibility audit
- [ ] Mobile fine-tuning

#### Phase 5: Launch (Days 16-17)
- [ ] Production deployment
- [ ] Domain configuration
- [ ] Monitoring setup
- [ ] Launch checklist
- [ ] Post-launch fixes

---

## 10. User Journey Optimization

### 🎯 Primary User Journeys

| Journey | Steps | Key Touchpoints | Optimization Focus |
|---------|-------|-----------------|-------------------|
| **Event Discovery** | Home → Events → Detail → RSVP | Search, filters, preview | Fast loading, clear CTAs |
| **Designer Exploration** | Home → Designers → Profile → Contact | Browse, filter, connect | Visual showcase, social links |
| **Ticket Purchase** | Event → Select → Checkout → Confirm | Pricing, seats, payment | Trust signals, smooth flow |
| **Partner Inquiry** | Home → Sponsors → Contact | Benefits, tiers, form | Value proposition, testimonials |

### 🔄 Conversion Optimization

**Homepage Optimization:**
```
Prompt: Optimize homepage for conversions with:
- Above-fold CTAs within 3 seconds
- Social proof (attendee count, testimonials)
- Urgency indicators (limited tickets)
- Trust badges (secure payment, partners)
```

**Event Page Optimization:**
```
Prompt: Enhance event pages with:
- Sticky RSVP button on mobile
- Quick preview on hover
- Social sharing buttons
- Related events suggestions
```

---

## 11. Performance & Testing Strategy

### 🚀 Performance Targets

| Metric | Target | Mobile | Desktop |
|--------|--------|--------|---------|
| First Contentful Paint | < 1.8s | < 2.1s | < 1.5s |
| Largest Contentful Paint | < 2.5s | < 3.0s | < 2.0s |
| Time to Interactive | < 3.8s | < 4.5s | < 3.0s |
| Cumulative Layout Shift | < 0.1 | < 0.15 | < 0.05 |
| Lighthouse Score | > 90 | > 85 | > 95 |

### 🧪 Testing Implementation

**Playwright Test Setup:**
```
Prompt: Configure Playwright with:
- Tests for all user journeys
- Visual regression tests
- Mobile device testing
- Accessibility checks
- Performance benchmarks
```

**Test Categories:**
1. **Component Tests**: Individual component functionality
2. **Integration Tests**: Page interactions and flows
3. **E2E Tests**: Complete user journeys
4. **Performance Tests**: Load times and metrics
5. **Accessibility Tests**: WCAG compliance

---

## 12. Troubleshooting Guide

### 🐛 Common Issues & Solutions

| Issue | Symptoms | Solution | Prevention |
|-------|----------|----------|------------|
| **React Version Mismatch** | Hydration errors | Lock versions with pnpm | Use exact versions in package.json |
| **MUI Theme Not Applied** | Default styles showing | Check ThemeProvider wrap | Import theme in layout.tsx |
| **Image Loading Issues** | Slow or broken images | Configure Cloudinary domains | Use next/image properly |
| **Build Failures** | TypeScript errors | Fix type definitions | Run type check pre-commit |
| **Mobile Layout Breaks** | Overflow, broken grid | Test all breakpoints | Use MUI responsive utilities |

### 🔧 Debugging Commands

```bash
# Version verification
pnpm list react react-dom @mui/material

# Clear cache and rebuild
rm -rf .next node_modules
pnpm install
pnpm build

# Type checking
pnpm tsc --noEmit

# Bundle analysis
ANALYZE=true pnpm build
```

### 📝 Error Resolution Flowchart

1. **Check Console** → Identify error type
2. **Verify Versions** → Match with admin app
3. **Clear Caches** → Remove .next and node_modules
4. **Check Imports** → Ensure correct paths
5. **Test Isolation** → Create minimal reproduction
6. **Review Docs** → Check MUI v6 migration guide

---

## 13. Production Deployment Checklist

### 🚀 Pre-Deployment Tasks

#### Code Quality
- [ ] All TypeScript errors resolved
- [ ] ESLint warnings addressed
- [ ] No console.log statements
- [ ] Environment variables documented
- [ ] Error boundaries implemented

#### Performance
- [ ] Images optimized with Cloudinary
- [ ] Bundle size < 500KB initial
- [ ] Code splitting implemented
- [ ] Fonts optimized with next/font
- [ ] Critical CSS inlined

#### Security
- [ ] Environment variables secured
- [ ] API routes protected
- [ ] Input validation on forms
- [ ] Content Security Policy set
- [ ] HTTPS enforced

#### SEO & Accessibility
- [ ] Meta tags on all pages
- [ ] Open Graph images set
- [ ] Sitemap.xml generated
- [ ] Robots.txt configured
- [ ] ARIA labels complete

### 📦 Vercel Deployment

**Deployment Configuration:**
```
Prompt: Configure Vercel deployment with:
- Environment variables from .env.local
- Custom domain setup
- Preview deployments for branches
- Performance monitoring
- Error tracking integration
```

### 🎯 Post-Launch Tasks

1. **Monitor Performance**
   - Set up Vercel Analytics
   - Configure error tracking
   - Monitor Core Web Vitals
   - Track user journeys

2. **Gather Feedback**
   - User testing sessions
   - Analytics review
   - Performance bottlenecks
   - Accessibility audit

3. **Iterate & Improve**
   - Fix identified issues
   - Optimize slow pages
   - Enhance conversions
   - Add requested features

---

## 🎉 Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Page Load Time | < 3 seconds | Lighthouse |
| Conversion Rate | > 5% | Analytics |
| Accessibility Score | > 95 | axe DevTools |
| User Satisfaction | > 4.5/5 | Feedback forms |
| SEO Performance | Top 3 for "fashion events Medellín" | Search Console |

---

## 📚 Resources & References

- **MUI v6 Docs**: https://mui.com/material-ui/
- **Next.js 14 Docs**: https://nextjs.org/docs
- **Cloudinary Next.js**: https://next.cloudinary.dev/
- **Supabase Docs**: https://supabase.com/docs
- **Vercel Docs**: https://vercel.com/docs

---

This comprehensive plan provides clear guidance for implementing a production-ready fashion events platform using Material UI v6 and Next.js 14, with detailed prompts for Claude to execute each phase effectively.