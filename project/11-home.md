# FashionOS Homepage Implementation Plan - Zone Travel Template

## 📋 Table of Contents
1. [Progress Tracker](#progress-tracker)
2. [Task Matrix](#task-matrix)
3. [Component Mapping](#component-mapping)
4. [Components to Hide/Remove](#components-to-hideremove)
5. [Detailed Implementation](#detailed-implementation)
6. [Homepage Success Metrics](#homepage-success-metrics)
7. [Overall Project Success Criteria](#overall-project-success-criteria)
8. [Deployment Strategy](#deployment-strategy)

---

## Progress Tracker

| Section | Component | Status | Priority | Estimated Time |
|---------|-----------|--------|----------|----------------|
| Navigation | Header with Menu 
| Hero Banner | Landing Hero 
| Event Highlights | Featured Events 
| Designer Showcase | Designer Profiles 
| Ticket Pricing | Pricing Tiers 
| Partners | Sponsor Grid 
| Footer | Contact & Social 
---

## Task Matrix

| Zone Travel Component | Fashion Adaptation | Changes Required | Success Criteria |
|----------------------|-------------------|------------------|------------------|
| `TravelHeader` | Fashion Navigation | Menu items, logo, remove search | All links work, mobile responsive |
| `TravelLandingHero` | Fashion Event Hero | Title, background, CTA buttons | Video loads, CTAs functional |
| `TravelTourFeatured` | Event Highlights | Event cards, images, content | 3 events display properly |
| `TravelTeam` | Designer Showcase | Designer profiles, portfolios | 3 designers show with images |
| `PricingSection` | Ticket Tiers | Pricing structure, features | All tiers display correctly |
| `TravelClients` | Partners/Sponsors | Logo grid, brand content | Sponsor logos load properly |
| `TravelFooter` | Fashion Footer | Social links, contact info | All links active, WhatsApp works |

---

## Component Mapping

### 1. Navigation Header
Zone Component: `src/layouts/main/header.tsx`
Target: Fashion event navigation

```typescript
// Required Changes:
const navItems = [
  { label: 'Home', path: '/' },
  { label: 'Events', path: '/events' },        // Was 'Tours'
  { label: 'Tickets', path: '/tickets' },      // Was 'Destinations'  
  { label: 'Partners', path: '/partners' },    // Was 'Hotels'
  { label: 'About', path: '/about' },
  { label: 'Contact', path: '/contact' }
];

// Logo Update:
<img src="/images/fashionistas-logo.svg" alt="Fashionistas" />

// Remove: Travel search bar
// Keep: Mobile menu, sticky behavior
```

### 2. Hero Banner
Zone Component: `src/sections/_travel/landing/travel-landing-hero.tsx`
Target: Fashion event hero with countdown

```typescript
// Content Changes:
title: "Fashionistas: A Night of Glamour & Fashion"
subtitle: "Medellín's most glamorous fashion event"
description: "Experience elegance and luxury at our exclusive Valentine's fashion show"

// Event Details:
date: "August 14, 2025"
location: "Medellín, Colombia"
countdown: true

// Background:
backgroundImage: "https://res.cloudinary.com/dviirzynk/image/upload/v1/fashion/hero/runway-main.jpg"

// CTAs:
primaryCTA: "Get Tickets"
secondaryCTA: "Learn More"

// Remove: Travel search form
// Remove: Duration/rating indicators
```


### 3. Event Highlights Section
Zone Component: `src/sections/_travel/landing/travel-landing-tour-featured.tsx`
Target: Featured fashion events (3 cards)

```typescript
// Event Cards Data:
const events = [
  {
    id: 1,
    title: "Runway Collection",
    description: fashion show ",
    image:https://res.cloudinary.com/dzqy2ixl0/image/upload/v1738223985/cruise-fashion_f1gaxb.jpg
    category: "Runway Show",
    buttonText: "Learn More"
  },
  {
    id: 2,
    title: "Fashion Party",
    description: "Elegant intimate apparel collection showcasing contemporary design and luxury materials",
    image: "https://res.cloudinary.com/dzqy2ixl0/image/upload/v1738223218/june-fashion_jya3sr.jpg",
    category: "Fashion Show",
    buttonText: "Learn More"
  },
  {
    id: 3,
    title: "Backstage Glamour",
    description: "Behind-the-scenes exclusive access to fashion preparations and model experiences",
    image: https://res.cloudinary.com/dzqy2ixl0/image/upload/v1738223082/May-fashion_kbkveb.jpg
    category: "VIP Experience",
    buttonText: "Learn More"
  }
];

// Remove: Duration indicators ("3 days 2 nights")
// Remove: Rating stars
// Remove: Price display (save for tickets section)
// Keep: Card layout, hover effects, responsive grid
```
event details 


### 4. Designer Showcase Section
Zone Component: `src/sections/_travel/travel-team.tsx`
Target: Featured designers (3 profiles)

```typescript
// Designer Profiles:
const designers = [
  {
    id: 1,
    name: "Isabella Rodriguez",
    title: "Creative Director",
    description: "Join the runway and showcase your talent at Medellín's most glamorous event",
    image: "https://res.cloudinary.com/dviirzynk/image/upload/v1/fashion/designers/isabella-rodriguez.jpg",
    role: "Register as a Model",
    buttonText: "Sign Up Now"
  },
  {
    id: 2,
    name: "Sofia Martínez",
    title: "Fashion Designer", 
    description: "Showcase your lingerie designs to an exclusive audience of fashion enthusiasts",
    image: "https://res.cloudinary.com/dviirzynk/image/upload/v1/fashion/designers/sofia-martinez.jpg",
    role: "Sign Up as a Designer",
    buttonText: "Sign Up Now"
  },
  {
    id: 3,
    name: "Victoria Chen",
    title: "Brand Ambassador",
    description: "Partner with us to reach luxury fashion consumers and industry leaders",
    image: "https://res.cloudinary.com/dviirzynk/image/upload/v1/fashion/designers/victoria-chen.jpg", 
    role: "Become a Sponsor",
    buttonText: "Sign Up Now"
  }
];

// Keep: Card layout, profile structure
// Update: Content to fashion focus, images to fashion professionals
```

### 5. Ticket Pricing Section
Zone Component: `src/sections/pricing/pricing-01.tsx`
Target: Fashion event tickets (3 tiers)

```typescript
// Pricing Tiers:
const ticketTiers = [
  {
    name: "General Admission",
    price: "$99",
    period: "/person",
    description: "Standard access to the Fashionistas Valentine's Event",
    features: [
      "Standard seating",
      "Welcome drink", 
      "Event program",
      "Access to general areas",
      "Basic networking opportunities"
    ],
    buttonText: "Select Ticket",
    popular: false
  },
  {
    name: "VIP Experience", 
    price: "$249",
    period: "/person",
    description: "Premium access with exclusive perks and privileges",
    features: [
      "Front-row seating",
      "Welcome champagne",
      "VIP lounge access", 
      "Meet & Greet opportunities",
      "After-party entry"
    ],
    buttonText: "Select Ticket",
    popular: true,
    badge: "VIP"
  },
  {
    name: "Sponsor Package",
    price: "$499", 
    period: "/person",
    description: "Ultimate experience with maximum visibility",
    features: [
      "Premium seating",
      "Unlimited premium drinks",
      "Private suite access",
      "Brand visibility opportunities", 
      "Private after-party suite"
    ],
    buttonText: "Select Ticket", 
    popular: false,
    badge: "VIP"
  }
];

// Add: Countdown timer
// Add: Limited availability indicators
// Keep: Pricing card layout, hover effects
```

### 6. Partners Section
Zone Component: `src/sections/_travel/travel-our-clients.tsx`
Target: Sponsor and partner logos

```typescript
// Partner Logos:
const partners = [
  {
    name: "Luxury Brand 1",
    logo: "https://res.cloudinary.com/dviirzynk/image/upload/v1/fashion/partners/luxury-brand-1.png"
  },
  {
    name: "Fashion House 2", 
    logo: "https://res.cloudinary.com/dviirzynk/image/upload/v1/fashion/partners/fashion-house-2.png"
  },
  {
    name: "Beauty Partner 3",
    logo: "https://res.cloudinary.com/dviirzynk/image/upload/v1/fashion/partners/beauty-partner-3.png"
  },
  {
    name: "Venue Partner 4",
    logo: "https://res.cloudinary.com/dviirzynk/image/upload/v1/fashion/partners/venue-partner-4.png"
  }
];

// Section Title: "Our Prestigious Partners"
// Keep: Grid layout, hover effects, responsive design
```

### 7. Footer Section
Zone Component: `src/layouts/main/footer.tsx`
Target: Fashion event footer with social links

```typescript
// Footer Content:
const footerContent = {
  brand: {
    name: "Fashionistas",
    description: "Experience elegance and glamour in Medellín's ultimate Valentine's event.",
    logo: "/images/fashionistas-logo.svg"
  },
  
  navigation: {
    "Quick Links": ["Home", "Event Highlights", "Designer Showcase", "Tickets"],
    "Support": ["Sponsors", "Contact", "Terms of Service", "Privacy Policy"]
  },
  
  contact: {
    location: "Skybox Medellín, Colombia",
    phone: "(+57) 123-456-7890", 
    email: "contact@fashionistas.com"
  },
  
  social: [
    { platform: "Facebook", url: "#", icon: "facebook" },
    { platform: "Instagram", url: "#", icon: "instagram" },
    { platform: "Twitter", url: "#", icon: "twitter" },
    { platform: "WhatsApp", url: "https://wa.me/573123456789", icon: "whatsapp" }
  ],
  
  newsletter: {
    title: "Stay Updated",
    description: "Subscribe to receive exclusive event updates and VIP offers",
    placeholder: "Enter your email"
  }
};

// Add: WhatsApp link prominently
// Keep: Newsletter signup, responsive layout
```

---

## Components to Hide/Remove

### Travel-Specific Components to Hide:
```typescript
// Comment out these sections:
// <TravelLandingIntroduce />        // Travel introduction
// <TravelLandingSummary />          // Travel statistics  
// <TravelLandingToursByCity />      // Tours by city
// <TravelLandingPosts />            // Travel blog posts
// <TravelTestimonial />             // Travel testimonials

// Within components, hide:
// - Duration indicators ("3 days 2 nights")
// - Travel ratings/reviews
// - Flight/hotel booking elements
// - Weather information
// - Currency converters
// - Location/destination dropdowns
```

### Method to Hide Components:
```jsx
// Option 1: Comment out
{/ <TravelLandingSummary /> /}

// Option 2: Conditional rendering  
{false && <TravelLandingIntroduce />}

// Option 3: CSS display none
<Box sx={{ display: 'none' }}>
  <TravelLandingToursByCity />
</Box>
```

---

## Detailed Implementation

### Section 1: Navigation Header (2 hours)
```typescript
// File: src/layouts/main/header.tsx

STEP 1: Update logo (15 min)
- Replace zone-travel-logo.svg with fashionistas-logo.svg  
- Update alt text and aria-labels

STEP 2: Update navigation items (30 min)
- Change menu items to fashion-focused
- Update routing paths
- Test all navigation links

STEP 3: Remove travel search (45 min)
- Comment out search bar component
- Remove search-related state and handlers
- Clean up empty space in header

STEP 4: Test responsive behavior (30 min)
- Verify mobile menu works
- Test sticky header functionality
- Check all breakpoints (375px, 768px, 1440px)
```

### Section 2: Hero Banner (3 hours)
```typescript
// File: src/sections/_travel/landing/travel-landing-hero.tsx

STEP 1: Update content (45 min)
- Change title and subtitle text
- Update description copy
- Add event date and location

STEP 2: Replace background media (60 min)
- Add fashion show background image
- Integrate background video (optional)
- Ensure proper aspect ratios

STEP 3: Update CTAs (30 min)
- Change button text to "Get Tickets" and "Learn More"
- Update button routing
- Test button functionality

STEP 4: Remove travel elements (45 min)
- Hide travel search form
- Remove duration/rating displays
- Clean up travel-specific content
```

### Section 3: Event Highlights (4 hours)
```typescript
// File: src/sections/_travel/landing/travel-landing-tour-featured.tsx

STEP 1: Create event data (90 min)
- Define 3 fashion events
- Add Cloudinary image URLs
- Write compelling descriptions

STEP 2: Update card layout (60 min)
- Hide travel-specific elements (duration, ratings)
- Update card content structure
- Maintain responsive grid

STEP 3: Style customization (60 min)
- Apply dark theme colors
- Update hover effects
- Ensure image loading

STEP 4: Test functionality (30 min)
- Verify all cards display
- Test responsive behavior
- Check button interactions
```

### Section 4: Designer Showcase (3 hours)
```typescript
// File: src/sections/_travel/travel-team.tsx

STEP 1: Create designer profiles (90 min)
- Add 3 fashion professional profiles
- Upload designer photos to Cloudinary
- Write professional descriptions

STEP 2: Update content structure (60 min)
- Change from team to designer focus
- Update role descriptions
- Modify CTA buttons

STEP 3: Style and layout (30 min)
- Apply fashion theme styling
- Ensure responsive grid
- Test image loading
```

### Section 5: Ticket Pricing (2 hours)
```typescript
// File: src/sections/pricing/pricing-01.tsx

STEP 1: Define pricing tiers (45 min)
- Set up 3 ticket levels ($99, $249, $499)
- Define feature lists for each tier
- Add availability indicators

STEP 2: Add countdown timer (45 min)
- Integrate countdown to event date
- Style timer display
- Ensure proper date calculation

STEP 3: Update styling (30 min)
- Apply dark theme
- Add VIP badges
- Test responsive layout
```

### Section 6: Partners (2 hours)
```typescript
// File: src/sections/_travel/travel-our-clients.tsx

STEP 1: Gather partner logos (60 min)
- Source fashion brand logos
- Upload to Cloudinary
- Optimize for web display

STEP 2: Update content (30 min)
- Change section title
- Update partner information
- Add hover effects

STEP 3: Test and refine (30 min)
- Verify all logos load
- Test responsive grid
- Check link functionality
```

### Section 7: Footer (1 hour)
```typescript
// File: src/layouts/main/footer.tsx

STEP 1: Update content (30 min)
- Change company information
- Update contact details
- Add WhatsApp link

STEP 2: Update social links (15 min)
- Add fashion-focused social accounts
- Ensure all links work
- Test WhatsApp integration

STEP 3: Newsletter section (15 min)
- Update newsletter copy
- Test subscription functionality
- Verify email integration
```

---

## Homepage Success Metrics

| Section | Success Criteria | Verification Method |
|---------|------------------|---------------------|
| Navigation | ✓ All menu items functional<br>✓ Logo displays correctly<br>✓ Mobile menu works<br>✓ Sticky behavior active | Manual testing on all devices |
| Hero Banner | ✓ Fashion content displays<br>✓ Background media loads<br>✓ CTAs link correctly<br>✓ Event info visible | Visual inspection + interaction test |
| Event Highlights | ✓ 3 events display in grid<br>✓ Images load from Cloudinary<br>✓ Cards responsive<br>✓ Hover effects work | Grid layout check + responsive test |
| Designer Showcase | ✓ 3 designers show properly<br>✓ Images load correctly<br>✓ Content readable<br>✓ CTAs functional | Visual check + click testing |
| Ticket Pricing | ✓ All 3 tiers display<br>✓ Prices correct<br>✓ Features listed<br>✓ Buttons work | Component rendering + interaction |
| Partners | ✓ Logos load and scale<br>✓ Grid responsive<br>✓ Hover effects active | Image loading + responsive check |
| Footer | ✓ All links functional<br>✓ WhatsApp works<br>✓ Newsletter signup<br>✓ Contact info accurate | Comprehensive link testing |

---

## Overall Project Success Criteria

### Performance Metrics
- Lighthouse Performance Score: > 85
- Page Load Time: < 3 seconds  
- First Contentful Paint: < 2 seconds
- No Console Errors: Zero JavaScript errors
- Mobile Responsive: Perfect on 375px, 768px, 1440px

### Functionality Requirements
- Navigation: All menu items link correctly
- Forms: Newsletter signup submits properly
- Images: All Cloudinary images load optimally
- Buttons: Every CTA button functional
- Responsive: Perfect mobile/tablet/desktop experience

### Content Quality
- No Lorem Ipsum: All placeholder text replaced
- Fashion Focus: All content fashion-event specific
- Contact Info: Accurate business information
- Professional: High-quality images throughout

---

## Deployment Strategy

### Pre-Deployment Checklist
```bash
# 1. Local build test
cd /home/sk/fx/fashionos
pnpm build
pnpm start

# 2. Visual verification
- Check all 7 sections render correctly
- Test mobile responsive design
- Verify all images load
- Test all interactive elements

# 3. Performance check  
- Run Lighthouse audit
- Check bundle size
- Verify no console errors
- Test load times

# 4. Content verification
- All fashion content present
- No travel references remaining
- Contact information accurate
- All links functional
```

### Vercel Deployment
```bash
# 1. Commit changes
git add .
git commit -m "feat: complete fashion homepage with Zone Travel template"
git push origin main

# 2. Vercel auto-deploys from main branch
# Check: https://fashionistas-chi.vercel.app/

# 3. Post-deployment verification
- Test live site functionality
- Verify Cloudinary images load
- Check mobile responsiveness
- Test all navigation and CTAs
```

### Environment Variables (Vercel)
```env
NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME=dviirzynk
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_key
```

---

## Color Scheme (Dark Theme - No Pink)

Based on the template and request to avoid pink, using elegant dark theme:

```css
:root {
  / Primary Colors /
  --primary: #000000;        / Pure Black /
  --secondary: #C0C0C0;      / Silver /
  --accent: #808080;         / Grey /
  
  / Background /
  --background: #0A0A0A;     / Deep Black /
  --surface: #1A1A1A;       / Dark Surface /
  --card: #2A2A2A;          / Card Background /
  
  / Text /
  --text-primary: #FFFFFF;   / White Text /
  --text-secondary: #B0B0B0; / Light Grey Text /
  --text-muted: #808080;     / Muted Text /
  
  / Accents /
  --gold: #FFD700;          / Luxury Gold Accents /
  --success: #4CAF50;       / Success Green /
  --error: #F44336;         / Error Red /
}
```

This plan provides a systematic approach to transform the Zone Travel template into a sophisticated fashion event platform while maintaining all existing functionality and following minimal modification principles.
