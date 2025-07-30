# EventsOS - Master 

## 🎨 Color Configuration Analysis

### Zone Template Colors (Current)
```css
/* Zone Template Default Colors */
primary: {
  main: '#FA541C',        /* Orange */
  dark: '#B3200E',
  light: '#FDAB76'
}
secondary: {
  main: '#8E33FF',        /* Purple */
  dark: '#5119B7',
  light: '#C684FF'
}
```

### ✅ **SAFE TO CHANGE**: Fashion Color Palette
```css
/* Fashion Color Adaptation (RECOMMENDED) */
primary: {
  main: '#E91E63',        /* Fashion Pink */
  dark: '#C2185B',
  light: '#F48FB1'
}
secondary: {
  main: '#FFD700',        /* Luxury Gold */
  dark: '#FFC107',
  light: '#FFF9C4'
}
/* Additional Fashion Colors */
--dark: #0A0A0A;          /* Deep Black */
--surface: #1A1A1A;       /* Dark Surface */
--light: #FAFAFA;         /* Off-white */
```

### ✅ **SAFE TO CHANGE**: Component Names
```jsx
// BEFORE (Template)
export function TravelLandingHero({ tours, ...props })

// AFTER (Fashion)
export function FashionHero({ events, ...props })
// OR
export function EventsHero({ events, ...props })
```

---

## 📈 MASTER TASK IMPLEMENTATION MATRIX

### 🏠 **HOMEPAGE COMPONENTS**

| #     | Component/Page         | Template Source                                                                        | Content Changes                                                                                                                                                                                                                                                                                                                                       | Image Requirements                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | Success Criteria                                                                                                                                                                                                                     | Production Tests                                                                                                                                                                                | Status             |
| ----- | ---------------------- | -------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------ |
| **1** | **Hero Section**       | `/zone-template/src/sections/_travel/landing/travel-landing-hero.jsx`                  | **Component Name**: `TravelLandingHero` → `FashionHero`<br>**Props**: `tours` → `events`<br>**Button Text**: "Book now" → "Get Tickets"<br>**Data Structure**: Travel tours → Fashion events<br>**Pricing Format**: Currency → Fashion pricing<br>**Review Text**: "reviews" → "attendees"                                                            | **Hero Carousel Images (1920x1080px)**:<br>```jsx<br>// Exact Cloudinary URLs<br>const heroImages = [<br>  'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_16:9,c_fill/v1/fashion/milan-fashion-week-hero',<br>  'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_16:9,c_fill/v1/fashion/paris-couture-hero',<br>  'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_16:9,c_fill/v1/fashion/nyfw-hero'<br>];<br>```<br>**Thumbnail Images (400x300px)**:<br>```jsx<br>thumbnailUrl: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_4:3,c_fill,w_400/v1/fashion/event-thumbnails/'<br>```          | ✅ Carousel functions with fashion events data<br>✅ Thumbnail navigation preserved<br>✅ "Get Tickets" CTA leads to booking<br>✅ Mobile dots navigation works<br>✅ Fashion pricing displays correctly<br>✅ Event details show properly | 🔍 Carousel animation 60fps<br>🔍 Images load WebP format<br>🔍 Touch gestures responsive<br>🔍 Lighthouse Performance > 90<br>🔍 Mobile text readable (16px+)<br>🔍 CTA contrast ratio > 4.5:1 | 🔄 **Not Started** |
| **2** | **Featured Events**    | `/zone-template/src/sections/_travel/landing/travel-landing-tour-featured.jsx`         | **Component Name**: `TravelLandingTourFeatured` → `FeaturedEvents`<br>**Section Title**: "Featured tours" → "Upcoming Fashion Events"<br>**Subtitle**: "Most popular destinations" → "Experience luxury fashion worldwide"<br>**Props**: `tours` → `events`<br>**Card Content**: Tour details → Event details<br>**CTA**: "Book tour" → "Get Tickets" | **Featured Event Cards (800x600px)**:<br>```jsx<br>// Event card images<br>const eventImages = {<br>  milanFW: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_4:3,c_fill,w_800/v1/fashion/milan-fashion-week-card',<br>  parisCouture: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_4:3,c_fill,w_800/v1/fashion/paris-couture-card',<br>  nyfw: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_4:3,c_fill,w_800/v1/fashion/nyfw-card',<br>  londonFW: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_4:3,c_fill,w_800/v1/fashion/london-fashion-card'<br>};<br>```                        | ✅ 4 events display in responsive grid<br>✅ Card hover effects preserved<br>✅ Event cards link to event details<br>✅ Fashion pricing format consistent<br>✅ Event dates and locations display<br>✅ Grid responsive at all breakpoints | 🔍 Grid layout responsive (xs:1, sm:2, md:4)<br>🔍 Hover animations smooth<br>🔍 Image lazy loading works<br>🔍 Cards accessible via keyboard<br>🔍 Touch targets > 44px mobile                 | 🔄 **Not Started** |
| **3** | **Fashion Capitals**   | `/zone-template/src/sections/_travel/landing/travel-landing-favorite-destinations.jsx` | **Component Name**: `TravelLandingFavoriteDestinations` → `FashionCapitals`<br>**Section Title**: "Favorite destinations" → "Fashion Capitals of the World"<br>**Subtitle**: Update to fashion context<br>**Cities Data**: Travel destinations → Fashion capitals<br>**Event Counts**: Hotel counts → Event counts per city                           | **Fashion Capital Images (600x400px)**:<br>```jsx<br>// City images with fashion context<br>const capitalImages = {<br>  milan: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_3:2,c_fill,w_600/v1/fashion/milan-fashion-district',<br>  paris: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_3:2,c_fill,w_600/v1/fashion/paris-fashion-avenue',<br>  nyc: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_3:2,c_fill,w_600/v1/fashion/nyc-fashion-week-venue',<br>  london: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_3:2,c_fill,w_600/v1/fashion/london-fashion-street'<br>};<br>``` | ✅ Cities display with fashion event counts<br>✅ Horizontal scroll preserved<br>✅ Touch gestures work on mobile<br>✅ City links navigate to events<br>✅ Event counts accurate and dynamic                                             | 🔍 Horizontal scroll smooth<br>🔍 Swipe gestures responsive<br>🔍 Cities load progressively<br>🔍 Navigation links functional<br>🔍 Mobile touch optimization                                   | 🔄 **Not Started** |
| **4** | **Statistics Counter** | `/zone-template/src/sections/_travel/landing/travel-landing-summary.jsx`               | **Component Name**: `TravelLandingSummary` → `FashionStats`<br>**Counters Update**:<br>• "Tours" → "Events Hosted" (50+)<br>• "Reviews" → "Fashion Lovers" (25,000+)<br>• "Countries" → "Cities" (15+)<br>• "Hotels" → "Designer Brands" (200+)<br>**Icons**: Travel icons → Fashion icons                                                            | **Statistic Icons (64x64px)**:<br>```jsx<br>// Fashion-themed icons<br>const statIcons = {<br>  events: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,w_64/v1/fashion/icons/calendar-fashion',<br>  lovers: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,w_64/v1/fashion/icons/heart-fashion',<br>  cities: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,w_64/v1/fashion/icons/globe-fashion',<br>  brands: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,w_64/v1/fashion/icons/diamond-fashion'<br>};<br>```                                                                                     | ✅ Counter animations trigger on scroll<br>✅ Numbers format with commas<br>✅ Fashion metrics display correctly<br>✅ Icons updated for fashion context<br>✅ Mobile layout preserved                                                    | 🔍 Intersection Observer works<br>🔍 Counter animation smooth<br>🔍 Numbers accessible (aria-label)<br>🔍 Icons load optimized<br>🔍 Mobile spacing correct                                     | 🔄 **Not Started** |
| **5** | **Newsletter Signup**  | `/zone-template/src/sections/_travel/newsletter/travel-newsletter.jsx`                 | **Component Name**: `TravelNewsletter` → `FashionNewsletter`<br>**Title**: "Get special offers" → "Stay in Fashion"<br>**Subtitle**: Travel context → "Get exclusive fashion event updates"<br>**Form Integration**: Add Supabase connection<br>**GDPR Compliance**: Add privacy notice<br>**Success Message**: Fashion-themed                        | **Newsletter Background (1200x400px)**:<br>```jsx<br>// Optional background pattern<br>const newsletterBg = 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_3:1,c_fill,w_1200,o_20/v1/fashion/patterns/luxury-pattern';<br><br>// Newsletter icon<br>const newsletterIcon = 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,w_80/v1/fashion/icons/envelope-fashion';<br>```                                                                                                                                                                                                                                                                      | ✅ Email validation works correctly<br>✅ Supabase integration functional<br>✅ Success/error messages display<br>✅ GDPR compliance notice shown<br>✅ Double opt-in email flow ready                                                    | 🔍 Form validation robust<br>🔍 Supabase insert works<br>🔍 Email regex validation<br>🔍 Error handling complete<br>🔍 Privacy compliance verified                                              | 🔴 **High Risk**   |

### 📅 **EVENTS SYSTEM**

| # | Component/Page | Template Source | Content Changes | Image Requirements | Success Criteria | Production Tests | Status |
|---|----------------|-----------------|-----------------|-------------------|------------------|------------------|---------|
| **6** | **Events Directory** | `/zone-template/src/app/travel/tours.jsx` | **Page Component**: `Tours` → `Events`<br>**Page Title**: "Tours" → "Fashion Events Directory"<br>**Filters**: Destination/Type → Event Type/City/Date<br>**Search Placeholder**: "Search tours" → "Search fashion events"<br>**Sort Options**: Travel-specific → Date/Price/Popularity<br>**Load More**: "Load more tours" → "Show more events" | **Event Card Images (600x400px)**:<br>```jsx<br>// Event listing images<br>const eventCardImages = (eventId) => <br>  `https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_3:2,c_fill,w_600/v1/fashion/events/${eventId}-card`;<br><br>// Filter category icons<br>const filterIcons = {<br>  runway: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,w_32/v1/fashion/icons/runway',<br>  exhibition: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,w_32/v1/fashion/icons/exhibition',<br>  gala: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,w_32/v1/fashion/icons/gala'<br>};<br>``` | ✅ Events load with pagination<br>✅ Filters work for Event Type/City/Date<br>✅ Search functionality active<br>✅ Sort options functional<br>✅ Event cards link to details<br>✅ Mobile filter UI optimized | 🔍 Filter combinations work correctly<br>🔍 Search debounced (300ms)<br>🔍 Loading states during filter<br>🔍 URL updates with filter state<br>🔍 Mobile filter drawer smooth | 🔴 **High Risk** |
| **7** | **Event Details** | `/zone-template/src/app/travel/tour.jsx` | **Page Component**: `Tour` → `Event`<br>**Dynamic Route**: `/tour/[slug]` → `/events/[slug]`<br>**Breadcrumbs**: Tours → Events<br>**Tabs**: Tour tabs → About/Schedule/Venue/Tickets<br>**Gallery**: Tour gallery → Event gallery<br>**Booking**: Tour booking → Ticket booking<br>**Related**: Related tours → Related events | **Event Detail Images**:<br>```jsx<br>// Hero image (1600x900px)<br>const eventHero = (eventSlug) => <br>  `https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_16:9,c_fill,w_1600/v1/fashion/events/${eventSlug}-hero`;<br><br>// Gallery images (1200x800px)<br>const eventGallery = (eventSlug, imageId) => <br>  `https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_3:2,c_fill,w_1200/v1/fashion/events/${eventSlug}/gallery-${imageId}`;<br><br>// Venue images (800x600px)<br>const venueImages = (venueId) => <br>  `https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_4:3,c_fill,w_800/v1/fashion/venues/${venueId}`;<br>``` | ✅ Dynamic content loads from database<br>✅ SEO metadata generates correctly<br>✅ Image gallery functional with lightbox<br>✅ Ticket booking widget works<br>✅ Related events display<br>✅ Social sharing functional | 🔍 Dynamic metadata generation<br>🔍 Schema.org structured data<br>🔍 Gallery lightbox accessible<br>🔍 Booking flow complete<br>🔍 Page speed < 2s | 🔴 **High Risk** |

### 🎫 **TICKETING & BUSINESS**

| # | Component/Page | Template Source | Content Changes | Image Requirements | Success Criteria | Production Tests | Status |
|---|----------------|-----------------|-----------------|-------------------|------------------|------------------|---------|
| **8** | **Ticket Pricing** | `/zone-template/src/app/travel/checkout.jsx` | **Page Component**: `Checkout` → `Tickets`<br>**Page Title**: "Checkout" → "Ticket Pricing"<br>**Pricing Tiers**: Travel packages → Fashion tiers<br>• General Admission: $299<br>• VIP Experience: $599<br>• Platinum Access: $2999<br>**Benefits Table**: Travel perks → Fashion perks<br>**Payment Integration**: Stripe setup | **Pricing Tier Graphics**:<br>```jsx<br>// Tier badges (300x300px)<br>const tierBadges = {<br>  general: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,w_300/v1/fashion/tiers/general-badge',<br>  vip: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,w_300/v1/fashion/tiers/vip-badge',<br>  platinum: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,w_300/v1/fashion/tiers/platinum-badge'<br>};<br><br>// Benefits icons (48x48px)<br>const benefitIcons = (iconName) => <br>  `https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,w_48/v1/fashion/icons/benefits/${iconName}`;<br>``` | ✅ Pricing tiers display clearly<br>✅ Benefits comparison table responsive<br>✅ Stripe integration ready<br>✅ Mobile pricing tables scroll<br>✅ CTA buttons functional<br>✅ Popular tier highlighted | 🔍 Stripe payment flow tested<br>🔍 Price calculations correct<br>🔍 Mobile table horizontal scroll<br>🔍 Accessibility compliance<br>🔍 SSL checkout secure | 🔴 **High Risk** |
| **9** | **About Page** | `/zone-template/src/app/travel/about.jsx` | **Page Component**: `TravelAbout` → `About`<br>**Page Title**: Travel about → "About Fashionistas"<br>**Content Sections**: <br>• Mission: Fashion event platform<br>• Story: Company journey<br>• Team: Key team members<br>• Values: Fashion community focus | **About Page Images**:<br>```jsx<br>// Hero image (1600x600px)<br>const aboutHero = 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_8:3,c_fill,w_1600/v1/fashion/about/company-hero';<br><br>// Team photos (400x400px)<br>const teamPhotos = (memberId) => <br>  `https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_1:1,c_fill,w_400/v1/fashion/team/${memberId}`;<br><br>// Company story images<br>const storyImages = (imageId) => <br>  `https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_16:9,c_fill,w_800/v1/fashion/story/${imageId}`;<br>``` | ✅ Brand story compelling and clear<br>✅ Team section properly populated<br>✅ Content hierarchy logical<br>✅ Images optimized and loading<br>✅ Mobile layout excellent | 🔍 Content readability high<br>🔍 Images optimized for web<br>🔍 Text hierarchy clear<br>🔍 Mobile experience smooth<br>🔍 Page speed optimized | 🟢 **Low Risk** |
| **10** | **Contact Page** | `/zone-template/src/app/travel/contact.jsx` | **Page Component**: `TravelContact` → `Contact`<br>**Contact Form**: Travel inquiries → Fashion inquiries<br>**Address**: Update to Medellín location<br>**Contact Methods**: Phone, email, social<br>**FAQ Section**: Fashion-specific questions<br>**Map Integration**: Medellín venue location | **Contact Page Images**:<br>```jsx<br>// Office/venue photos (800x600px)<br>const venuePhotos = 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,ar_4:3,c_fill,w_800/v1/fashion/venue/medellin-office';<br><br>// Contact icons (64x64px)<br>const contactIcons = {<br>  phone: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,w_64/v1/fashion/icons/phone-fashion',<br>  email: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,w_64/v1/fashion/icons/email-fashion',<br>  location: 'https://res.cloudinary.com/[CLOUD_NAME]/image/upload/f_auto,q_auto,w_64/v1/fashion/icons/location-fashion'<br>};<br>``` | ✅ Contact form validation works<br>✅ Form submission to database<br>✅ Map displays Medellín location<br>✅ Contact information accurate<br>✅ Multi-channel support clear | 🔍 Form validation complete<br>🔍 Submission handling robust<br>🔍 Map interactive features<br>🔍 Response times documented<br>🔍 Mobile form optimized | 🟡 **Medium Risk** |

---

## 🛠️ Implementation Code Patterns

### Safe Component Renaming Pattern
```jsx
// BEFORE (Template)
export function TravelLandingHero({ tours, sx, ...other }) {
  return (
    <Box sx={sx} {...other}>
      {tours.map((tour) => (
        <CarouselItem key={tour.id} tour={tour} />
      ))}
    </Box>
  );
}

// AFTER (Fashion)
export function FashionHero({ events, sx, ...other }) {
  return (
    <Box sx={sx} {...other}>
      {events.map((event) => (
        <CarouselItem key={event.id} tour={event} /> {/* Keep tour prop name for compatibility */}
      ))}
    </Box>
  );
}
```

### Cloudinary Image Integration
```jsx
// Fashion Events Data Structure
const fashionEvents = [
  {
    id: 'milan-fashion-week-2025',
    title: 'Milan Fashion Week',
    location: 'Milan, Italy',
    price: 299,
    // Hero image with transformations
    coverUrl: `https://res.cloudinary.com/${CLOUDINARY_CLOUD_NAME}/image/upload/f_auto,q_auto,ar_16:9,c_fill,w_1920/v1/fashion/events/milan-fashion-week-hero`,
    // Thumbnail for carousel
    thumbnailUrl: `https://res.cloudinary.com/${CLOUDINARY_CLOUD_NAME}/image/upload/f_auto,q_auto,ar_4:3,c_fill,w_400/v1/fashion/events/milan-fashion-week-thumb`,
    // Gallery images
    images: [
      `https://res.cloudinary.com/${CLOUDINARY_CLOUD_NAME}/image/upload/f_auto,q_auto,ar_3:2,c_fill,w_1200/v1/fashion/events/milan-fashion-week/gallery-1`,
      `https://res.cloudinary.com/${CLOUDINARY_CLOUD_NAME}/image/upload/f_auto,q_auto,ar_3:2,c_fill,w_1200/v1/fashion/events/milan-fashion-week/gallery-2`
    ]
  }
];
```

### Theme Color Integration
```jsx
// Update theme-config.js in website app
export const fashionTheme = {
  ...baseTheme,
  palette: {
    ...baseTheme.palette,
    primary: {
      main: '#E91E63',     // Fashion Pink
      dark: '#C2185B',
      light: '#F48FB1',
      contrastText: '#FFFFFF'
    },
    secondary: {
      main: '#FFD700',     // Luxury Gold
      dark: '#FFC107',
      light: '#FFF9C4',
      contrastText: '#000000'
    }
  }
};
```

---

## ✅ **IMPLEMENTATION STATUS LEGEND**

- 🔄 **Not Started** - Ready for development
- 🟢 **Low Risk** - Simple content changes, minimal complexity
- 🟡 **Medium Risk** - Some integration required, moderate complexity  
- 🔴 **High Risk** - Complex functionality, database integration, payment systems

**Total Components**: 10 core components
**High Priority**: Hero, Featured Events, Events Directory, Event Details, Ticketing
**Medium Priority**: Fashion Capitals, Statistics, Newsletter
**Low Priority**: About, Contact

This matrix provides exact implementation specifications with proper Cloudinary integration and safe component modification patterns.