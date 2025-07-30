# Original location: /public/assets/images/travel/
# New location: /public/assets/images/events/

# Hero images needed:
hero-fashion-show.jpg        # Replace: hero-destination.jpg
hero-milan-fashion-week.jpg  # Replace: hero-paris.jpg
hero-gala-event.jpg         # Replace: hero-adventure.jpg
```

### Event Card Images
```bash
# Event listing thumbnails
paris-fashion-week-thumb.jpg    # Replace: paris-tour-thumb.jpg
milan-runway-show-thumb.jpg     # Replace: rome-tour-thumb.jpg
ny-fashion-gala-thumb.jpg       # Replace: london-tour-thumb.jpg
designer-showcase-thumb.jpg     # Replace: barcelona-tour-thumb.jpg
```

### Detail Page Galleries
```bash
# Event detail galleries (3-5 images per event)
event-gallery/
├── pfw-2025/
│   ├── runway-1.jpg
│   ├── backstage-2.jpg
│   ├── attendees-3.jpg
│   └── venue-4.jpg
├── milan-show/
│   ├── catwalk-1.jpg
│   ├── designers-2.jpg
│   └── crowd-3.jpg
```

### Icon Replacements
```jsx
// BEFORE - Travel icons
"🗺️" → "🎭"  // Map → Fashion mask
"✈️" → "🎫"  // Plane → Ticket
"🏨" → "🏛️"  // Hotel → Venue
"📍" → "📍"  // Location (keep same)
"⭐" → "⭐"  // Star (keep same)
"💰" → "💳"  // Money → Credit card
```

---

## 🎨 **Styling and Theme Updates**

### Color Palette Adjustments
```javascript
// File: src/theme/palette.js

// Fashion industry colors
const fashionPalette = {
  primary: {
    main: '#1a1a1a',      // Elegant black
    light: '#333333',     
    dark: '#000000',
  },
  secondary: {
    main: '#c9a96e',      // Luxury gold
    light: '#d4b77a',
    dark: '#b8956a',
  },
  accent: {
    main: '#9c27b0',      // Fashion purple
    light: '#ba68c8',
    dark: '#7b1fa2',
  }
}
```

### Typography Updates
```javascript
// File: src/theme/typography.js

// Fashion-focused text styles
const fashionTypography = {
  fontFamily: '"Playfair Display", "Georgia", serif', // More elegant for fashion
  h1: {
    fontWeight: 700,
    letterSpacing: '-0.02em',
  },
  h2: {
    fontWeight: 600,
    letterSpacing: '-0.01em',
  }
}
```

---

## 🔧 **Component-Level Changes**

### Navigation Updates
```jsx
// File: src/layouts/main/nav/desktop/nav-desktop.jsx

// BEFORE
navItems = [
  { title: 'Home', path: '/' },
  { title: 'Tours', path: '/travel/tours' },
  { title: 'About', path: '/travel/about' },
  { title: 'Contact', path: '/travel/contact' },
  { title: 'Blog', path: '/travel/posts' }
]

// AFTER
navItems = [
  { title: 'Home', path: '/' },
  { title: 'Events', path: '/travel/tours' },
  { title: 'About', path: '/travel/about' },
  { title: 'Contact', path: '/travel/contact' },
  { title: 'News', path: '/travel/posts' }
]
```

### Footer Updates
```jsx
// File: src/layouts/main/footer.jsx

// BEFORE
footerContent = {
  company: {
    name: "Zone Travel",
    description: "Your trusted travel companion for amazing adventures worldwide.",
    links: ["About Us", "Careers", "Press", "Partners"]
  },
  services: ["Tour Packages", "Custom Tours", "Group Travel", "Travel Insurance"]
}

// AFTER  
footerContent = {
  company: {
    name: "EventsOS",
    description: "Your gateway to exclusive fashion events and industry experiences.",
    links: ["About Us", "Careers", "Press", "Partners"]
  },
  services: ["Event Tickets", "VIP Packages", "Corporate Events", "Group Registration"]
}
```

---

## 📱 **Mobile-Specific Content**

### Mobile Navigation
```jsx
// Shorter labels for mobile
const mobileNavLabels = {
  // BEFORE
  "Tour Packages" → "Events"
  "Travel Blog" → "News"
  "Contact Us" → "Contact"
  "About Travel" → "About"
}
```

### Mobile Card Content
```jsx
// Truncated content for mobile cards
const mobileCardContent = {
  maxTitleLength: 30,     // "Paris Fashion Week Spring..." 
  maxDescriptionLength: 80, // Brief event description
  showOnlyEssentials: true  // Price, date, location only
}
```

---

## 🔍 **SEO and Meta Content**

### Page Titles
```jsx
// File: src/app/travel/(landing)/page.jsx
// Update metadata object

// BEFORE
export const metadata = {
  title: 'Travel Tours | Amazing Destinations Worldwide',
  description: 'Discover incredible travel experiences and tours to amazing destinations worldwide. Book your next adventure today.',
  keywords: 'travel, tours, destinations, vacation, adventure'
}

// AFTER
export const metadata = {
  title: 'Fashion Events | Exclusive Industry Experiences',
  description: 'Discover exclusive fashion events, runway shows, and industry experiences worldwide. Register for premium fashion events today.',
  keywords: 'fashion events, runway shows, fashion week, industry events, VIP fashion'
}
```

### Open Graph Tags
```jsx
// Social media sharing content
const openGraphContent = {
  // BEFORE
  title: "Amazing Travel Destinations",
  description: "Book incredible tours and travel experiences",
  image: "/assets/images/travel/og-travel.jpg"
  
  // AFTER
  title: "Exclusive Fashion Events",
  description: "Access premier fashion events and runway shows", 
  image: "/assets/images/events/og-fashion-events.jpg"
}
```

---

## 🧪 **Testing Your Changes**

### Content Testing Checklist

#### Text Content
- [ ] All travel references changed to fashion events
- [ ] Navigation makes sense for events platform
- [ ] Call-to-action buttons are appropriate
- [ ] Form labels match event context
- [ ] Error messages updated for events
- [ ] Success messages reference events

#### Visual Content  
- [ ] Hero images show fashion events
- [ ] Card images are event-related
- [ ] Icons match fashion industry context
- [ ] Colors feel premium/fashion-appropriate
- [ ] Typography is elegant and readable

#### Functionality
- [ ] All links work after content changes
- [ ] Forms submit with new field labels
- [ ] Search works with event terminology
- [ ] Filters make sense for events
- [ ] Mobile experience feels natural

---

## 🚀 **Implementation Commands**

### Step 1: Create Backup
```bash
cd /home/sk/fx/eventos/zone-template
cp -r src src-backup-$(date +%Y%m%d)
```

### Step 2: Global Text Replacements
```bash
# Safe global replacements (test each one)
find src -name "*.jsx" -type f -exec sed -i 's/Travel Tours/Fashion Events/g' {} \;
find src -name "*.jsx" -type f -exec sed -i 's/Amazing Destinations/Exclusive Fashion Events/g' {} \;
find src -name "*.jsx" -type f -exec sed -i 's/Tour Packages/Event Experiences/g' {} \;

# Test after each command:
npm run dev
```

### Step 3: File-by-File Updates
```bash
# Update specific files one at a time
# 1. Landing page
nano src/app/travel/(landing)/page.jsx

# 2. Tours listing  
nano src/app/travel/tours/page.jsx

# 3. Tour details
nano src/app/travel/tours/[id]/page.jsx

# Test after each file change
```

### Step 4: Asset Updates
```bash
# Create events asset directory
mkdir -p public/assets/images/events

# Copy and rename travel assets as starting point
cp public/assets/images/travel/* public/assets/images/events/

# Replace with actual fashion event images
# (Download appropriate images and replace)
```

---

## ⚠️ **Safety Guidelines**

### Always Test These After Changes

1. **Page Loading**: Every page loads without errors
2. **Navigation**: All menu items work correctly  
3. **Forms**: Contact and registration forms submit
4. **Mobile**: Responsive design still works
5. **Performance**: No significant slowdown

### Rollback Process
```bash
# If something breaks, restore from backup
cd /home/sk/fx/eventos/zone-template
rm -rf src
mv src-backup-[date] src
npm run dev
```

### Change One Thing at a Time
- ✅ **Good**: Change hero text → test → change navigation → test
- ❌ **Bad**: Change everything at once → test (hard to debug)

---

## 📊 **Progress Tracking**

### Daily Goals

#### Day 1: Landing Page
- [ ] Hero section updated to fashion events
- [ ] Statistics reflect event metrics  
- [ ] Features list updated for events
- [ ] Newsletter signup updated
- [ ] Page tested on mobile

#### Day 2: Events Listing
- [ ] Page title and description updated
- [ ] Filter categories changed to events
- [ ] Sort options updated
- [ ] Sample event cards display correctly
- [ ] Search functionality works

#### Day 3: Event Details  
- [ ] Event information structure updated
- [ ] Schedule replaces itinerary
- [ ] Registration form updated
- [ ] Gallery shows event images
- [ ] Related events section works

#### Day 4: Supporting Pages
- [ ] About page tells EventsOS story
- [ ] Contact form updated for events
- [ ] Blog/news section updated
- [ ] Footer content updated
- [ ] Navigation fully consistent

#### Day 5: Polish & Testing
- [ ] All images replaced with fashion content
- [ ] SEO metadata updated
- [ ] Mobile experience optimized
- [ ] Performance maintained
- [ ] Ready for stakeholder review

---

## 🎯 **Success Criteria**

### Completion Checklist
- [ ] **Zero Travel References**: No mentions of travel, tours, destinations
- [ ] **Consistent Terminology**: Events, fashion, attendees used throughout
- [ ] **Appropriate Imagery**: All images relate to fashion events
- [ ] **Functional Integrity**: Everything works exactly as before
- [ ] **Mobile Excellence**: Mobile experience feels native to events
- [ ] **Performance Maintained**: Page speeds and Lighthouse scores unchanged

**🏆 Final Test**: A new user should immediately understand this is a fashion events platform without any confusion.

---

**📝 Next Guide**: [Asset Replacement Guide](asset-replacement.md) - Images, logos, and branding updates
