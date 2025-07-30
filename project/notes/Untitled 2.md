# FashionOS Custom Instructions V2 - Production MVP Guide

## 📋 Table of Contents

1. [Project Overview & Links](#1-project-overview--links)
2. [Core Principles - KEEP IT SIMPLE](#2-core-principles---keep-it-simple)
3. [Tech Stack & Versions](#3-tech-stack--versions)
4. [Essential Commands](#4-essential-commands)
5. [MVP Pages & Features](#5-mvp-pages--features)
6. [Zone Template Component Usage](#6-zone-template-component-usage)
7. [Success Criteria](#7-success-criteria)
8. [Production Ready Checklist](#8-production-ready-checklist)
9. [Implementation Workflow](#9-implementation-workflow)
10. [Testing & Deployment](#10-testing--deployment)
11. [Critical Rules](#11-critical-rules)
12. [Quick Reference](#12-quick-reference)
13. [Artifacts Usage Rules](#13-artifacts-usage-rules)

---

## 1. Project Overview & Links

**Project**: FashionOS - Fashion Event Management Platform  
Directory: `/home/sk/fx/fashionos`  
**Repository**: https://github.com/eventos-100/fashionistas  
**reference site  Site**: https://fashionistas-chi.vercel.app/  
Vercel -  https://fashionistas-iw8j45opr-sanjiv-khullars-projects-47652e0d.vercel.app/
**Database**: Supabase (`wnjudgmhabzhcttgyxou`)  
**Template**: Zone UI Travel (https://zone-ui.vercel.app/travel/)

### 🎯 MVP Goal
Create a working production fashion event platform in 7-10 days using ONLY Zone Travel template components with minimal changes.

### Platform Architecture
```
fashion
├── Home (/)                    # Brand showcase & primary conversion
├── Events (/events)            # Event listings & schedule
├── Event Details (/events/[id]) # Individual event pages
├── Tickets (/tickets)          # Ticketing & registration
├── Sponsors (/sponsors)        # Sponsor showcase & packages
├── Designers (/designers)      # Designer profiles & collections
├── About (/#about)            # Brand story & mission
└── Contact (/#contact)        # Contact forms & information
```

---

## 2. Core Principles - KEEP IT SIMPLE

### The KISS Method
1. **Use what exists** - Zone components work perfectly
2. **Change minimally** - Text, images, colors ONLY
3. **Test immediately** - After every single change
4. **Deploy frequently** - Push working code daily
5. **Document simply** - Clear, concise notes

### Development Rules
```
IF Zone has it → USE IT
IF it works → DON'T TOUCH IT  
IF unsure → ASK FIRST
IF complex → SIMPLIFY
ALWAYS use Zone Travel components
ONLY minimal changes to Zone components
```

---

## 3. Tech Stack & Versions

```yaml
# EXACT VERSIONS - DO NOT CHANGE
website:
  framework: "Next.js 14.2.5"
  ui: "@mui/material@7.2.0"      # Zone template version
  emotion: "@emotion/react@11.13.5"
  
admin:
  framework: "refine@4.57.10"
  ui: "@mui/material@6.5.0"      # Refine requirement
  
core:
  node: "18.20.0"
  pnpm: "9.14.4"
  typescript: "5.6.3"
```

---

## 4. Essential Commands

### 🚀 Development Commands

```bash
# Clone and Setup
git clone https://github.com/eventos-100/fashionistas.git
cd fashionistas
pnpm install

# Development
pnpm dev                    # Start website (http://localhost:3000)
pnpm dev:admin             # Start admin panel
pnpm dev:all               # Start both

# Check Changes
git status                 # See what changed
git diff                   # Review changes
pnpm test                  # Run tests
```

### 📁 File Operations

```bash
# Read Zone Template Files
DC: read_file src/sections/_travel/landing/travel-landing-hero.tsx
DC: list_directory src/sections/_travel/

# Copy for Fashion
DC: execute_command "cp -r src/sections/_travel src/sections/_fashion"
DC: write_file src/sections/_fashion/landing/fashion-landing-hero.tsx

# View Current Site
playwright:browser_navigate "http://localhost:3000"
playwright:browser_snapshot
```

### 🔄 Git Workflow

```bash
# Save Work
git add .
git commit -m "feat: update hero section text"
git push origin main

# Check Deployment
# Visit: https://fashionistas-chi.vercel.app/
# Vercel auto-deploys from main branch
```

---

## 5. MVP Pages & Features

### 🎯 Phase 1: Core Pages (Days 1-3)

| Page | Route | Zone Component | Features | Status |
|------|-------|----------------|----------|---------|
| **Home** | `/` | `travel-landing` | Hero banner, Featured events, Newsletter | 🔄 |
| **Events** | `/events` | `travel-tours` | Event grid, Filters, Search, Pagination | 🔄 |
| **Event Details** | `/events/[id]` | `travel-tour-details` | Gallery, Info tabs, Booking widget | 🔄 |
| **Tickets** | `/tickets` | `travel-checkout` | Tier display, Cart, Checkout flow | 🔄 |

### 📋 Phase 2: Essential Pages (Days 4-5)

| Page | Route | Zone Component | Features | Status |
|------|-------|----------------|----------|---------|
| **About** | `/about` | `travel-about` | Timeline, Team, Mission, Awards | 🔄 |
| **Contact** | `/contact` | `travel-contact` | Form, Map, Hours, FAQ | 🔄 |
| **Sponsors** | `/sponsors` | `travel-partners` | Logo grid, Benefits, CTA | 🔄 |

### 🌟 Phase 3: Fashion Features (Days 6-7)

| Page | Route | Zone Component | Features | Status |
|------|-------|----------------|----------|---------|
| **Designers** | `/designers` | `travel-team` | Profile cards, Portfolio, Bio | 🔄 |
| **Blog** | `/blog` | `travel-posts` | Fashion news, Articles | 🔄 |
| **Gallery** | `/gallery` | `travel-destinations` | Fashion photos, Collections | 🔄 |

---

## 6. Zone Template Component Usage

### 🏠 Homepage Sections

```typescript
// 1. Navigation Header
Zone: TravelHeader
Use: Sticky navigation with fashion menu items
Change: Menu labels, logo, remove travel search

// 2. Hero Banner  
Zone: TravelLandingHero
Use: Full-screen fashion event hero
Change: Title "Discover Fashion Events", background image/video

// 3. Featured Events
Zone: TravelLandingTourFeatured
Use: Showcase 4-6 upcoming fashion events
Change: Event cards content, hide duration/ratings

// 4. Upcoming Shows Grid
Zone: TravelLandingToursByCity
Use: Events organized by fashion capitals
Change: Cities (Milan, Paris, NYC, London)

// 5. Newsletter Signup
Zone: TravelNewsletter
Use: Fashion newsletter subscription
Change: Title "Stay in Fashion", copy text

// 6. Footer
Zone: TravelFooter
Use: Company info and links
Change: Fashion content, social links
```

### 📅 Events Page Sections

```typescript
// 1. Event Filtering System
Zone: TravelToursFilters
Use: Filter by Date/Type/Designer
Change: Filter options to fashion categories

// 2. Event Cards Grid
Zone: TravelToursList
Use: Responsive event card grid
Change: Card content, images, CTAs

// 3. Search Bar
Zone: TravelToursSearch
Use: Event search functionality
Change: Placeholder text "Search fashion events"

// 4. Pagination
Zone: TravelToursPagination
Use: Load more events
Change: Text to "Show more events"
```

### 🎫 Tickets Page Sections

```typescript
// 1. Ticket Tiers
Zone: TravelCheckoutPricing
Use: Display ticket options
Change: General ($99), VIP ($249), Platinum ($499)

// 2. Shopping Cart
Zone: TravelCheckoutCart
Use: Selected tickets summary
Change: Labels and terminology

// 3. Checkout Form
Zone: TravelCheckoutPayment
Use: Payment collection
Change: Form labels only

// 4. Confirmation
Zone: TravelCheckoutComplete
Use: Order confirmation
Change: Success messaging
```

---

## 7. Success Criteria

### ✅ MVP Success Metrics

| Criteria | Target | Measurement |
|----------|--------|-------------|
| **Pages Complete** | 8 core pages | Visual check |
| **Mobile Responsive** | 100% | All breakpoints |
| **Load Time** | <3 seconds | Lighthouse |
| **Functionality** | All links work | Manual test |
| **Forms** | Submit correctly | Test submissions |
| **Images** | All loading | No broken images |
| **Deployment** | Live on Vercel | Public URL works |

### 🎯 User Flow Success

```
1. User lands on homepage ✓
2. Views featured events ✓
3. Browses all events ✓
4. Clicks event details ✓
5. Selects ticket tier ✓
6. Completes checkout ✓
7. Receives confirmation ✓
```

### 📊 Page-Specific Success Criteria

#### Homepage
- [ ] Hero banner loads with fashion image/video
- [ ] Featured events show 4-6 items
- [ ] Newsletter signup works
- [ ] All CTAs functional

#### Events Page
- [ ] Grid displays all events
- [ ] Filters work correctly
- [ ] Search returns results
- [ ] Pagination loads more

#### Tickets Page
- [ ] All tiers display prices
- [ ] Cart updates correctly
- [ ] Checkout form validates
- [ ] Payment integration ready

---

## 8. Production Ready Checklist

### 📋 Pre-Launch Checklist

#### Content & Assets
- [ ] Logo uploaded (header & footer)
- [ ] Hero images/video ready (min 1920x1080)
- [ ] Event images uploaded (min 10 events)
- [ ] Designer photos added
- [ ] All Lorem ipsum replaced
- [ ] Contact info accurate
- [ ] Social media links working

#### Functionality
- [ ] Navigation works on all devices
- [ ] Events page loads with data
- [ ] Event details display correctly
- [ ] Contact form submits
- [ ] Newsletter signup works
- [ ] Search returns results
- [ ] All internal links working
- [ ] No console errors

#### Performance
- [ ] Lighthouse Performance >85
- [ ] Images optimized (<200kb)
- [ ] Mobile usable 100%
- [ ] No layout shifts
- [ ] Fonts loading correctly
- [ ] Cloudinary configured

#### SEO & Meta
- [ ] Page titles unique
- [ ] Meta descriptions set
- [ ] OG images configured
- [ ] Favicon uploaded
- [ ] Robots.txt allows indexing
- [ ] Sitemap generated

---

## 9. Implementation Workflow

### 📝 Daily Workflow

```bash
# Morning Setup (5 min)
cd /home/sk/fx/fashionos
git pull origin main
pnpm install
pnpm dev

# Work Session (2-3 hours)
1. Pick ONE component/section
2. Read Zone template file
3. Copy to fashion folder
4. Update ONLY text/images/colors
5. Test in browser
6. Commit if working

# End of Day (10 min)
git add .
git commit -m "feat: complete [component]"
git push origin main
# Check https://fashionistas-chi.vercel.app/
```

### 🔄 Component Adaptation Process

```typescript
// 1. Find Zone Component
DC: read_file src/sections/_travel/component-name.tsx

// 2. Identify Changes Needed
- Text strings to update
- Image paths to replace
- Sections to hide

// 3. Make Minimal Changes
- Update text content
- Replace image URLs with Cloudinary
- Comment out travel-specific features

// 4. Test Immediately
- Check localhost:3000
- Verify responsive design
- Test interactions
```

---

## 10. Testing & Deployment

### 🧪 Testing Commands

```bash
# Local Testing
pnpm dev
# Open http://localhost:3000
# Test each page manually

# Visual Testing
playwright:browser_navigate "http://localhost:3000"
playwright:browser_snapshot
playwright:browser_click element="Events Link"

# Mobile Testing
# Use browser DevTools
# Test at 375px, 768px, 1440px
```

### 🚀 Deployment Process

```bash
# Automatic via Vercel
git push origin main
# Wait 2-3 minutes
# Check: https://fashionistas-chi.vercel.app/

# Verify Deployment
- Visit each page
- Test on mobile
- Check forms
- Verify images load
```

---

## 11. Critical Rules

### 🚫 NEVER DO
1. Create new components from scratch
2. Modify Zone component structure
3. Change component props or logic
4. Add complex features
5. Skip testing after changes
6. Mix MUI v6 code in website (Zone uses v7)

### ✅ ALWAYS DO
1. Use existing Zone components
2. Test after EVERY change
3. Commit working code frequently
4. Keep changes minimal
5. Ask before adding features
6. Use Cloudinary for all images

### 🎯 Decision Matrix

```
Is it in Zone template? → YES → Use it
                       → NO  → Skip it or adapt existing

Does it work now?      → YES → Don't touch it
                       → NO  → Fix minimally

Is it complex?         → YES → Simplify or skip
                       → NO  → Implement carefully
```

---

## 12. Quick Reference

### 🔥 Most Used Commands

```bash
# Start development
cd /home/sk/fx/fashionos && pnpm dev

# View Zone component
DC: read_file src/sections/_travel/[component].tsx

# Test site
playwright:browser_navigate "http://localhost:3000"

# Deploy
git add . && git commit -m "update" && git push
```

### 📁 Key File Locations

```
Zone Components:
src/sections/_travel/         # Original templates
src/app/travel/              # Original pages

Fashion Adaptations:
src/sections/_fashion/        # Your modifications
src/app/(fashion)/           # Your pages
public/images/fashion/       # Fashion images
```

### 🎨 Brand Colors

```css
/* Fashion Brand Palette - Minimal & Elegant */
--primary: #000000;      /* Pure Black */
--secondary: #C0C0C0;    /* Silver */
--accent: #808080;       /* Grey */
--background: #FFFFFF;   /* White */
--text: #333333;        /* Dark Grey */
```

### 📸 Cloudinary Image URLs

```javascript
// Image URL Pattern
https://res.cloudinary.com/[CLOUD_NAME]/image/upload/
  f_auto,q_auto,           // Auto format & quality
  w_1920,h_1080,          // Dimensions
  c_fill,g_center/        // Crop & gravity
  v1/fashion/[folder]/[image-name].jpg

// Examples
Hero: /v1/fashion/hero/runway-main.jpg
Events: /v1/fashion/events/milan-week.jpg
Designers: /v1/fashion/designers/designer-1.jpg
```

---

## 13. Artifacts Usage Rules

### 📝 When to Use Artifacts

**ALWAYS use artifacts when:**
- Response is over 50 lines of code/content
- Creating or modifying components
- Writing configuration files
- Generating documentation
- Creating structured content (JSON, YAML, etc.)
- Building complete page templates

**Artifact Types to Use:**
- `application/vnd.ant.code` - For code snippets
- `text/markdown` - For documentation
- `text/html` - For HTML templates
- `application/vnd.ant.react` - For React components

### Example Usage

```typescript
// If creating/modifying a component over 50 lines
// Use artifact with type: application/vnd.ant.code
// Language: typescript or javascript

// If creating documentation/instructions
// Use artifact with type: text/markdown

// If building a complete page
// Use artifact with type: application/vnd.ant.react
```

---

## 🏁 MVP Completion Targets

### Day 1-2: Foundation
- [ ] Setup and deploy blank site
- [ ] Update navigation menu
- [ ] Complete homepage hero
- [ ] Add featured events section

### Day 3-4: Core Pages  
- [ ] Events listing page
- [ ] Event details template
- [ ] Basic ticket/pricing page

### Day 5-6: Essential Features
- [ ] Contact page with form
- [ ] About page content
- [ ] Sponsors page
- [ ] Footer with all links

### Day 7: Polish & Deploy
- [ ] Test all pages
- [ ] Fix any broken links
- [ ] Optimize images
- [ ] Final deployment check

---

## 📌 Remember

**GOAL**: Working MVP in 7 days, not perfection  
**METHOD**: Use Zone components as-is  
**CHANGES**: Text, images, colors only  
**TESTING**: After every single change  
**DEPLOYMENT**: Daily to show progress  
**ARTIFACTS**: Use for responses over 50 lines

> "The best MVP is a working one. Ship it, then improve it."