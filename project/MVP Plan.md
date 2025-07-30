# Fashionistas MVP Plan Overview & Task Reference Sheet

## 🎯 1. High-Level Overview

### Project Goals
Build a **luxury fashion event directory MVP** that transforms the Zone UI Travel template into an elegant platform for discovering and attending fashion shows, runway events, and designer showcases. The platform must maintain the template's robust functionality while adapting content for the fashion industry.

### Core Tech Stack
- **Framework**: Next.js 14+ with App Router
- **UI Library**: Material UI v7.1.2 (confirmed in package.json)
- **Templates**: Zone Travel + Zone UI components
- **Database**: Supabase (for dynamic content)
- **Media**: Cloudinary (optimized images)
- **Styling**: Emotion + sx prop only
- **Package Manager**: npm (per template)
- **Port**: 3013 (development)

### Page Architecture & Purpose
- **Homepage (`/`)**: Brand introduction with hero, featured events, testimonials
- **Events Directory (`/events`)**: Browse all fashion events with filters
- **Event Details (`/events/[slug]`)**: Individual event pages with booking
- **Designer Directory (`/designers`)**: Browse fashion designers and brands
- **Designer Profiles (`/designers/[slug]`)**: Individual designer portfolios
- **Ticketing (`/tickets`)**: Pricing tiers and benefits comparison
- **Sponsors (`/sponsors`)**: Partnership opportunities and packages
- **About (`/about`)**: Brand story and mission
- **Contact (`/contact`)**: Inquiries and support

### Design System
- **Typography**: 
  - Headlines: Montserrat (sans-serif)
  - Body: Inter (sans-serif)
  - Accents: Bebas Neue (sans-serif)
- **Colors**:
  - Primary: #E91E63 (Fashion Pink)
  - Secondary: #FFD700 (Luxury Gold)
  - Dark: #0A0A0A (Deep Black)
  - Light: #FAFAFA (Off-white)
- **Approach**: Mobile-first, responsive, WCAG 2.1 AA compliant
- **Images**: All via Cloudinary with f_auto, q_auto optimization

---

## 📊 2. Reference Task Table

| #   | Page / Section          | Template Source | Component Used              | Short Content Purpose      | Planned Changes                                                                                                                                  | Imagery / Media Needs                                                                                                                 | Notes / Testing                                                                     |
| --- | ----------------------- | --------------- | --------------------------- | -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| 1   | **Hero Section**        | Travel          | `travel-landing-hero.tsx`   | Intro to Fashionistas 2025 | • Title: "Fashionistas: Runway 2025"<br>• Subtitle: "Medellín's Premier Fashion Event"<br>• CTA: "Book now" → "Get Tickets"                      | • Hero: `runway-hero.jpg`<br>• Video option: `fashion-show-hero.mp4`<br>• Cloudinary optimized                                        | • Test text overlay contrast<br>• Verify mobile text size<br>• Check CTA prominence |
| 2   | **Search Bar**          | Travel          | `travel-search-form.tsx`    | Event discovery tool       | • "Where we go?" → "Search fashion events"<br>• "Guests" → "Number of tickets"<br>• Keep date picker as-is                                       | None needed                                                                                                                           | • Ensure form validation works<br>• Test mobile layout<br>• Verify date picker UX   |
| 3   | **Featured Events**     | Travel          | `travel-tours-featured.tsx` | Showcase top 4 events      | • Section title: "Upcoming Fashion Events"<br>• Card titles: Fashion week names<br>• Locations: Fashion capitals<br>• Price format: "From $299"  | • 4 event images:<br>  - `milan-fashion-week.jpg`<br>  - `paris-couture.jpg`<br>  - `ny-fashion-week.jpg`<br>  - `london-fashion.jpg` | • Keep card hover effects<br>• Test responsive grid<br>• Verify price display       |
| 4   | **Destinations/Cities** | Travel          | `travel-destinations.tsx`   | Events by location         | • Title: "Fashion Capitals"<br>• Cities: Milan, Paris, NYC, London<br>• "196 places" → "15 events"                                               | • City skylines:<br>  - `milan-skyline.jpg`<br>  - `paris-skyline.jpg`<br>  - `nyc-skyline.jpg`<br>  - `london-skyline.jpg`           | • Maintain grid layout<br>• Test touch scrolling<br>• Check image loading           |
| 5   | **Statistics**          | Travel          | `travel-stats.tsx`          | Platform credibility       | • "Air tickets" → "Events hosted"<br>• "Tours booked" → "Tickets sold"<br>• "Site visitors" → "Fashion lovers"<br>• "Hotels" → "Designer brands" | None needed                                                                                                                           | • Verify counter animation<br>• Test number formatting<br>• Check mobile spacing    |
| 6   | **Testimonials**        | Travel          | `travel-testimonials.tsx`   | Social proof               | • Keep structure<br>• Update quotes to fashion context<br>• Names: Fashion influencers                                                           | • Profile photos (8):<br>  - Use fashion influencer portraits<br>  - Cloudinary circle crop                                           | • Test carousel controls<br>• Verify autoplay<br>• Check accessibility              |
| 7   | **Newsletter**          | Travel          | `travel-newsletter.tsx`     | Lead generation            | • Title: "Stay in Fashion"<br>• Subtitle: "Get exclusive event updates"<br>• Button stays same                                                   | None needed                                                                                                                           | • Test form submission<br>• Verify email validation<br>• Check success message      |
| 8   | **Footer**              | Travel          | `travel-footer.tsx`         | Site navigation & info     | • Logo: Fashionistas<br>• About text: Fashion platform<br>• Links: Update to fashion pages<br>• Social: Keep structure                           | • Logo: `fashionistas-logo.png`                                                                                                       | • Test all links<br>• Verify contrast ratio<br>• Check mobile layout                |
| 9   | **Events Page**         | Travel          | `travel-tours-list.tsx`     | Browse all events          | • Title: "Fashion Events Directory"<br>• Filters: Event type, City, Season<br>• Sort: By date, price                                             | • 12+ event cards:<br>  - Fashion show images<br>  - 16:9 aspect ratio<br>  - 600px width                                             | • Test filter functionality<br>• Verify pagination<br>• Check loading states        |
| 10  | **Event Details**       | Travel          | `travel-tour-details.tsx`   | Individual event info      | • Breadcrumbs: Home > Events > [Name]<br>• Tabs: About, Schedule, Venue<br>• CTA: "Book tour" → "Get tickets"                                    | • Gallery (5 images):<br>  - Runway shots<br>  - Venue photos<br>  - Designer previews                                                | • Test image gallery<br>• Verify tab switching<br>• Check booking widget            |
| 11  | **Designers Page**      | Zone            | `team-list.tsx`             | Designer directory         | • Title: "Fashion Designers"<br>• Filter: By specialty, location<br>• Grid of profile cards                                                      | • Designer portraits:<br>  - Square format<br>  - 400x400px min<br>  - Professional shots                                             | • Test grid responsiveness<br>• Verify filter logic<br>• Check card interactions    |
| 12  | **Designer Profile**    | Zone            | `team-member.tsx`           | Designer details           | • Bio section<br>• Collections gallery<br>• Social links<br>• "Book designer" CTA                                                                | • Profile photo<br>• Collection images (6-8)<br>• Brand logo                                                                          | • Test gallery scroll<br>• Verify social links<br>• Check mobile layout             |
| 13  | **Tickets Page**        | Travel          | `travel-pricing.tsx`        | Pricing tiers              | • Tiers: General, VIP, Platinum<br>• Prices: $299, $599, $2999<br>• Benefits list update                                                         | • Tier icons or badges<br>• Optional bg pattern                                                                                       | • Test tier selection<br>• Verify comparison<br>• Check CTA buttons                 |
| 14  | **Sponsors Page**       | Zone            | `pricing.tsx`               | Partnership packages       | • Title: "Become a Sponsor"<br>• Packages: Bronze to Platinum<br>• Benefits comparison table                                                     | • Sponsor logos (existing)<br>• Package visualization                                                                                 | • Test table scroll<br>• Verify CTA placement<br>• Check responsive                 |
| 15  | **About Page**          | Zone            | `about.tsx`                 | Brand story                | • Mission statement<br>• Team section<br>• Timeline                                                                                              | • Team photos<br>• Brand imagery<br>• Timeline graphics                                                                               | • Test text hierarchy<br>• Verify image loading<br>• Check readability              |
| 16  | **Contact Page**        | Zone            | `contact.tsx`               | Get in touch               | • Form fields update<br>• Add venue address<br>• Map integration                                                                                 | • Venue photo<br>• Map screenshot                                                                                                     | • Test form validation<br>• Verify submission<br>• Check map display                |

---

## 🧪 Testing Checklist for Each Component

### Visual Testing
- [ ] Desktop (1920px) - Full layout visible
- [ ] Laptop (1440px) - Standard view
- [ ] Tablet (768px) - Touch-friendly
- [ ] Mobile (375px) - Single column

### Functional Testing
- [ ] All text updated correctly
- [ ] Images loading from Cloudinary
- [ ] Links navigate properly
- [ ] Forms submit successfully
- [ ] Animations perform smoothly

### Performance Testing
- [ ] Lighthouse score > 90
- [ ] First Contentful Paint < 1.5s
- [ ] Images optimized (WebP/AVIF)
- [ ] No console errors
- [ ] Smooth scrolling

### Accessibility Testing
- [ ] Color contrast > 4.5:1
- [ ] Keyboard navigation works
- [ ] Screen reader compatible
- [ ] Focus indicators visible
- [ ] Alt text on all images

---

## 🚀 Implementation Priority

### Phase 1: Core Pages (Week 1)
1. Homepage hero & sections
2. Events listing page
3. Event detail template
4. Basic navigation/footer

### Phase 2: Extended Features (Week 2)
1. Designer directory
2. Designer profiles
3. Ticket pricing
4. Sponsor packages

### Phase 3: Polish & Launch (Week 3)
1. Form integrations
2. Performance optimization
3. SEO implementation
4. Final testing

---

## 📝 Key Reminders

1. **NO structural changes** - Only text, images, colors
2. **Use sx prop exclusively** - No custom CSS
3. **Cloudinary for all images** - With optimization params
4. **Test incrementally** - After each section
5. **Mobile-first approach** - Start with small screens
6. **Keep original functionality** - All features must work

This plan ensures a safe, efficient transformation of the Zone Travel template into a luxury fashion event platform while maintaining all original functionality and performance.