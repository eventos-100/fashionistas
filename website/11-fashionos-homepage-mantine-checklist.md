# FashionOS Homepage Implementation Checklist - Mantine Components

## Executive Summary

This checklist focuses on implementing the FashionOS homepage using specific Mantine UI components. Based on the reference screenshots showing a luxury fashion/lingerie event website, we'll create an elegant, dark-themed homepage with smooth animations and premium aesthetics.

**Theme**: Dark luxury fashion theme with pink/purple accents  
**Key Features**: Exclusive collections showcase, event highlights, tiered ticketing, CTAs for models/designers/sponsors

---

## Progress Tracker

| Section | Mantine Component | Status | Implementation |
|---------|------------------|---------|----------------|
| 🔴 Navbar | HeaderMenu | Not Started | 0% |
| 🔴 Hero | HeroTitle | Not Started | 0% |
| 🔴 About/Collections | Custom Grid | Not Started | 0% |
| 🔴 Event Details | FeaturesCards | Not Started | 0% |
| 🔴 Designer Showcase | ArticlesCardsGrid | Not Started | 0% |
| 🔴 Tickets | FeaturesCards | Not Started | 0% |
| 🔴 Partners CTA | FeaturesCards | Not Started | 0% |
| 🔴 Footer | FooterLinks | Not Started | 0% |

---

## Theme Configuration

### Task 0: Mantine Provider Setup

**Purpose:** Configure dark luxury theme matching the reference design

**Implementation:**
```typescript
// lib/theme.ts
```

**Key Theme Elements:**
- Dark background (#0a0a0a or similar)
- Pink/Purple accent colors
- Elegant typography (serif for headings)
- Smooth transitions
- Glass morphism effects

**Resources:**
- [Mantine Provider](https://mantine.dev/theming/mantine-provider/)
- [Styles Overview](https://mantine.dev/styles/styles-overview/)
- [Theme Object](https://mantine.dev/theming/theme-object/)

**Success Criteria:**
- ✅ Dark theme configured
- ✅ Custom colors defined
- ✅ Typography hierarchy set
- ✅ Component defaults styled

---

## Section 1: Navigation Bar

### Component: HeaderMenu
**Reference:** https://ui.mantine.dev/category/headers/#header-menu

**Purpose:** Create elegant navigation with transparent background over hero

**Implementation Requirements:**
- Logo/Brand on left
- Centered navigation links
- Right-side CTAs (Tickets, Contact)
- Transparent background with blur on scroll
- Mobile responsive drawer

**Customizations Needed:**
- Remove background color initially
- Add backdrop-filter: blur on scroll
- Style links with hover effects
- Add gradient borders on CTAs

**Success Criteria:**
- ✅ Navigation transparent over hero
- ✅ Smooth scroll behavior
- ✅ Mobile menu functional
- ✅ CTA buttons prominent

---

## Section 2: Hero Section

### Component: HeroTitle
**Reference:** https://ui.mantine.dev/category/hero/#hero-title

**Purpose:** Dramatic hero with event announcement

**Implementation Requirements:**
- Full viewport height
- Background image/video capability
- Large elegant typography
- Event date/countdown
- Primary CTA buttons
- Subtle animations

**Content Structure:**
```
- Tagline: "Exclusive Fashion Experience"
- Title: "Dulcinea Swimwear Fashion Show"
- Date: "July 29, 2025"
- CTAs: "Get Tickets" | "Become a Partner"
```

**Customizations Needed:**
- Overlay gradient for text readability
- Animate text on load
- Parallax scroll effect
- Pink/purple accent buttons

**Success Criteria:**
- ✅ Full viewport impact
- ✅ Clear event information
- ✅ Compelling CTAs
- ✅ Smooth animations

---

## Section 3: Exclusive Collections

### Component: Custom Grid Layout
**Reference:** Based on screenshot showing 3 collection cards

**Purpose:** Showcase featured collections/designers

**Implementation Requirements:**
- 3-column grid (responsive)
- Image cards with overlay text
- Designer attribution
- Hover effects revealing details
- "Explore" and "Details" buttons

**Card Structure:**
```
- Background image
- Overlay gradient
- Collection name
- Designer name
- Description
- Dual CTA buttons
```

**Mantine Components:**
- Card
- Image
- Text
- Button
- Grid
- Overlay

**Success Criteria:**
- ✅ Images load smoothly
- ✅ Hover effects elegant
- ✅ Mobile responsive
- ✅ CTAs clear

---

## Section 4: Event Details & Schedule

### Component: FeaturesCards
**Reference:** https://ui.mantine.dev/category/features/#features-cards

**Purpose:** Display event highlights and schedule

**Implementation Requirements:**
- Icon-based feature cards
- Event timeline
- Key highlights (models, designers, venue)
- Stats/numbers display

**Content Ideas:**
- 15+ Professional Models
- 3 Featured Designers  
- Premium Venue
- Exclusive After-party
- Gourmet Catering
- Professional Photography

**Customizations Needed:**
- Dark card backgrounds
- Pink/purple icon colors
- Subtle animations
- Number counters

**Success Criteria:**
- ✅ Information hierarchy clear
- ✅ Icons meaningful
- ✅ Mobile optimized
- ✅ Engaging visuals

---

## Section 5: Designer Showcase

### Component: ArticlesCardsGrid
**Reference:** https://ui.mantine.dev/category/article-cards/#articles-cards-grid

**Purpose:** Feature participating designers

**Implementation Requirements:**
- Designer profile cards
- Collection preview images
- Brief descriptions
- Social media links
- "View Collection" CTAs

**Card Elements:**
- Designer photo/logo
- Name and brand
- Collection theme
- Instagram handle
- Preview images

**Customizations Needed:**
- Masonry or grid layout
- Image galleries
- Hover state previews
- Modal popups for details

**Success Criteria:**
- ✅ Designer profiles attractive
- ✅ Collections previewed
- ✅ Social links functional
- ✅ Load performance good

---

## Section 6: Ticket Tiers

### Component: FeaturesCards (Pricing variant)
**Reference:** https://ui.mantine.dev/category/features/#features-cards

**Purpose:** Display ticket options with countdown timer

**Implementation Requirements:**
- Countdown timer component
- 3 ticket tiers (based on screenshot)
- Price display
- Benefits list
- "Select Ticket" CTAs
- Availability indicators

**Ticket Tiers from Screenshot:**
1. **General Admission** - $99
2. **VIP Experience** - $249
3. **Sponsor Package** - $499

**Features per Tier:**
- Seating type
- Welcome drinks
- VIP perks
- After-party access
- Meet & greet

**Customizations Needed:**
- Gradient borders for VIP
- Animated countdown
- Hover effects
- Stripe integration ready

**Success Criteria:**
- ✅ Pricing clear
- ✅ Benefits compared
- ✅ Urgency created
- ✅ Purchase flow started

---

## Section 7: Partners/Join CTA

### Component: FeaturesCards
**Reference:** https://ui.mantine.dev/category/features/#features-cards

**Purpose:** Call-to-action for models, designers, sponsors

**Implementation Requirements:**
- 3 equal columns
- Background images
- Clear CTAs
- Brief descriptions
- Form links

**Three CTAs (from screenshot):**
1. **Register as a Model**
   - "Join the runway and showcase your talent"
   - Pink CTA button

2. **Sign Up as a Designer**
   - "Showcase your lingerie designs"
   - Purple CTA button

3. **Become a Sponsor**
   - "Partner with us to reach luxury consumers"
   - Pink CTA button

**Customizations Needed:**
- Full-width section
- Overlay text on images
- Hover animations
- Modal forms

**Success Criteria:**
- ✅ CTAs compelling
- ✅ Images relevant
- ✅ Forms accessible
- ✅ Mobile responsive

---

## Section 8: Footer

### Component: FooterLinks
**Reference:** https://ui.mantine.dev/category/footers/#footer-links

**Purpose:** Comprehensive footer with links and info

**Implementation Requirements:**
- Multi-column layout
- Logo and tagline
- Quick links
- Contact information
- Social media icons
- Newsletter signup
- Legal links

**Footer Sections:**
1. Brand column (logo, description, social)
2. Event links
3. Information links
4. Contact details
5. Newsletter form

**Customizations Needed:**
- Dark background
- Subtle dividers
- Icon integration
- Form styling

**Success Criteria:**
- ✅ All links functional
- ✅ Newsletter works
- ✅ Social links open
- ✅ Mobile stacked properly

---

## Implementation Checklist

### Phase 1: Setup & Theme
- [ ] Configure MantineProvider with dark theme
- [ ] Set up color palette (blacks, pinks, purples)
- [ ] Configure typography (elegant serif + clean sans)
- [ ] Create global styles
- [ ] Set up CSS variables

### Phase 2: Layout Components
- [ ] Implement HeaderMenu with customizations
- [ ] Create FooterLinks component
- [ ] Build reusable Card components
- [ ] Set up Grid system

### Phase 3: Homepage Sections
- [ ] Hero section with background
- [ ] Collections showcase grid
- [ ] Event details cards
- [ ] Designer showcase
- [ ] Ticket pricing section
- [ ] CTA section
- [ ] Footer implementation

### Phase 4: Interactions & Polish
- [ ] Add scroll animations
- [ ] Implement hover effects
- [ ] Create loading states
- [ ] Add countdown timer
- [ ] Test responsive design
- [ ] Optimize images

### Phase 5: Integration
- [ ] Connect forms to backend
- [ ] Add analytics tracking
- [ ] Implement SEO tags
- [ ] Test payment flow
- [ ] Performance optimization

---

## Key Mantine Resources

### Core Documentation
- [Getting Started](https://mantine.dev/getting-started/)
- [Theming Guide](https://mantine.dev/theming/theme-object/)
- [Styles API](https://mantine.dev/styles/styles-api/)
- [Components](https://mantine.dev/core/button/)

### Specific Components
- [Card Component](https://mantine.dev/core/card/)
- [Grid System](https://mantine.dev/core/grid/)
- [Overlay](https://mantine.dev/core/overlay/)
- [Image](https://mantine.dev/core/image/)
- [Button](https://mantine.dev/core/button/)
- [Text](https://mantine.dev/core/text/)
- [Container](https://mantine.dev/core/container/)

### UI Components
- [Mantine UI](https://ui.mantine.dev/)
- [Headers Collection](https://ui.mantine.dev/category/headers/)
- [Hero Sections](https://ui.mantine.dev/category/hero/)
- [Features](https://ui.mantine.dev/category/features/)
- [Footers](https://ui.mantine.dev/category/footers/)

---

## Success Metrics

### Visual Design
- ✅ Matches luxury fashion aesthetic
- ✅ Dark theme properly implemented
- ✅ Typography hierarchy clear
- ✅ Images high quality
- ✅ Animations smooth

### User Experience
- ✅ Navigation intuitive
- ✅ Information findable
- ✅ CTAs prominent
- ✅ Forms simple
- ✅ Mobile experience excellent

### Performance
- ✅ Page load < 3s
- ✅ Images optimized
- ✅ Animations 60fps
- ✅ No layout shifts
- ✅ Responsive at all sizes

### Business Goals
- ✅ Ticket purchase clear
- ✅ Partner CTAs visible
- ✅ Event info complete
- ✅ Contact accessible
- ✅ Brand message strong

---

## Next Steps

1. **Immediate Actions:**
   - Set up dark theme in MantineProvider
   - Install required Mantine packages
   - Create component structure

2. **Development Priority:**
   - Hero section (first impression)
   - Ticket section (conversion)
   - Navigation (usability)
   - Collections (visual impact)

3. **Testing Focus:**
   - Mobile responsiveness
   - Dark mode consistency
   - Form functionality
   - Performance metrics

This checklist ensures systematic implementation of a luxury fashion event homepage using Mantine components while maintaining the elegant aesthetic shown in the reference screenshots.