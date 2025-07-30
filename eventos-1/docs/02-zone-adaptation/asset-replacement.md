# 🖼️ Asset Replacement Guide
## Images, Logos, and Branding for EventsOS

---

## 🎯 **Asset Strategy Overview**

**Goal**: Replace all travel-related visual assets with high-quality fashion event imagery while maintaining the professional aesthetic and performance of the Zone template.

**Quality Standards**:
- **Resolution**: High-quality but web-optimized
- **Style**: Consistent luxury/premium aesthetic
- **Performance**: Fast loading, properly compressed
- **Responsive**: Works across all device sizes

---

## 📁 **Current Asset Structure Analysis**

Let me examine the existing Zone template assets:

```bash
public/assets/
├── images/
│   ├── travel/           # 🎯 PRIMARY REPLACEMENT TARGET
│   │   ├── hero/         # Hero section backgrounds
│   │   ├── destinations/ # Tour/event thumbnails
│   │   ├── gallery/      # Detailed photo galleries
│   │   └── testimonials/ # Customer photos
│   ├── components/       # UI component images
│   ├── illustrations/    # Vector graphics
│   └── logos/           # Brand assets
├── icons/               # Icon sets
└── favicon/            # Browser icons
```

---

## 🎭 **Fashion Event Image Requirements**

### Hero Section Images
**Specs**: 1920x1080px, High quality, Dramatic lighting

#### Primary Hero Images Needed:
1. **Main Landing Hero** 
   - Subject: Fashion runway with models
   - Setting: Professional fashion show
   - Mood: Elegant, exclusive, dynamic
   - File: `hero-fashion-main.jpg`

2. **Events Listing Hero**
   - Subject: Fashion event audience/venue
   - Setting: Premium event space
   - Mood: Sophisticated, engaged crowd
   - File: `hero-events-listing.jpg`

3. **About Page Hero**
   - Subject: Behind-scenes fashion event
   - Setting: Backstage or event planning
   - Mood: Professional, insider access
   - File: `hero-about-eventsOS.jpg`

### Event Card Thumbnails  
**Specs**: 400x300px, Web-optimized, Consistent style

#### Event Types to Represent:
1. **Fashion Shows** (3-4 images)
   - Paris Fashion Week runway
   - Milan Fashion Week backstage
   - NY Fashion Week front row
   - Designer showcase

2. **Fashion Galas** (2-3 images)
   - Red carpet arrivals
   - Awards ceremony
   - Cocktail networking

3. **Trade Shows** (2-3 images)
   - Fashion trade exhibition
   - Buyer meetings
   - Product showcases

4. **Pop-up Events** (2 images)
   - Exclusive boutique opening
   - Designer meet-and-greet

### Detail Gallery Images
**Specs**: 800x600px, High quality for lightbox viewing

#### For Each Event Type:
- **Wide venue shots** (establishing the space)
- **Action shots** (people engaged)  
- **Detail shots** (fashion, products, atmosphere)
- **Behind-scenes** (exclusive access feeling)

---

## 🎨 **Logo and Branding Assets**

### EventsOS Logo Creation
**Specifications**:
- **Style**: Modern, luxury aesthetic
- **Colors**: Black/gold/purple (matching theme)
- **Formats**: SVG (scalable), PNG (fallback)
- **Sizes**: Multiple sizes for different uses

#### Logo Variants Needed:
```bash
logos/
├── eventsOS-logo-full.svg        # Full logo with text
├── eventsOS-logo-mark.svg        # Icon only
├── eventsOS-logo-white.svg       # White version for dark backgrounds
├── eventsOS-logo-horizontal.svg  # Wide format for headers
└── eventsOS-favicon/             # Browser favicon variants
    ├── favicon-16x16.png
    ├── favicon-32x32.png
    ├── apple-touch-icon.png
    └── favicon.svg
```

### Brand Color Palette
```scss
// EventsOS brand colors
$brand-black: #1a1a1a;      // Primary brand color
$brand-gold: #c9a96e;       // Luxury accent
$brand-purple: #9c27b0;     // Fashion accent
$brand-white: #ffffff;      // Clean contrast
$brand-gray: #f5f5f5;       // Subtle backgrounds
```

---

## 📋 **File-by-File Replacement Plan**

### Landing Page Assets

#### Current Travel Assets → EventsOS Replacements

```bash
# Hero section
/travel/hero-destination.jpg → /events/hero-fashion-main.jpg

# Features section
/travel/feature-guide.jpg → /events/feature-access.jpg
/travel/feature-price.jpg → /events/feature-tickets.jpg  
/travel/feature-trust.jpg → /events/feature-platform.jpg

# Statistics section background
/travel/stats-bg.jpg → /events/stats-bg.jpg
```

### Events Listing Page Assets

```bash
# Page header background
/travel/tours-header.jpg → /events/events-header.jpg

# Event card thumbnails (replace destination images)
/travel/destinations/
├── paris-tour.jpg → /events/paris-fashion-week.jpg
├── rome-tour.jpg → /events/milan-runway-show.jpg
├── london-tour.jpg → /events/london-fashion-gala.jpg
├── barcelona-tour.jpg → /events/ny-fashion-trade.jpg
├── tokyo-tour.jpg → /events/tokyo-fashion-popup.jpg
└── dubai-tour.jpg → /events/designer-showcase.jpg
```

### Event Details Gallery

```bash
# Replace tour galleries with event galleries
/travel/gallery/
├── tour-1/ → /events/gallery/paris-fw-2025/
│   ├── image-1.jpg → runway-show-1.jpg
│   ├── image-2.jpg → backstage-access-2.jpg
│   ├── image-3.jpg → vip-lounge-3.jpg
│   └── image-4.jpg → networking-4.jpg
├── tour-2/ → /events/gallery/milan-gala/
└── tour-3/ → /events/gallery/ny-trade-show/
```

---

## 🛠️ **Implementation Process**

### Step 1: Asset Audit and Collection

```bash
# Create EventsOS assets directory
cd /home/sk/fx/eventos/zone-template/public/assets
mkdir -p images/events/{hero,cards,gallery,features}
mkdir -p logos/eventsOS
```

### Step 2: Download and Prepare Images

#### Image Sources (Legal, High-Quality):
1. **Unsplash Collections**:
   - Fashion Week photography
   - Event photography
   - Professional fashion shows

2. **Pexels Fashion Category**:
   - Runway shows
   - Fashion events
   - Industry gatherings

3. **Custom Photography** (If budget allows):
   - Original event photography
   - Brand-specific imagery

#### Image Optimization:
```bash
# Install image optimization tools
npm install -g imagemin imagemin-webp imagemin-mozjpeg

# Optimize images for web
for image in *.jpg; do
  imagemin "$image" --out-dir=optimized/ --plugins=mozjpeg
done
```

### Step 3: Logo Creation Process

#### DIY Logo Creation:
```bash
# Using free tools:
# 1. Canva (canva.com) - Professional templates
# 2. LogoMakr (logomakr.com) - Simple logo creation
# 3. Figma (figma.com) - Professional design tool

# Logo requirements:
# - Text: "EventsOS" in elegant font
# - Icon: Fashion-related symbol (mask, runway, etc.)
# - Colors: Black, gold, purple
# - Formats: SVG, PNG (multiple sizes)
```

#### Professional Logo Alternative:
```bash
# If budget allows:
# - Fiverr: $25-100 for professional logo
# - 99designs: Design contest for multiple options
# - Local designer: Custom brand identity
```

### Step 4: File Replacement Implementation

```bash
# Replace hero images
cp /path/to/new/hero-fashion-main.jpg public/assets/images/events/
cp /path/to/new/hero-events-listing.jpg public/assets/images/events/

# Replace card thumbnails
cp /path/to/new/event-cards/* public/assets/images/events/cards/

# Replace gallery images  
cp /path/to/new/gallery-images/* public/assets/images/events/gallery/

# Update logo files
cp /path/to/new/eventsOS-logo.svg public/assets/logos/
```

### Step 5: Update Image References in Code

#### Landing Page Image Updates:
```jsx
// File: src/app/travel/(landing)/page.jsx

// BEFORE
const heroImage = "/assets/images/travel/hero-destination.jpg"

// AFTER  
const heroImage = "/assets/images/events/hero-fashion-main.jpg"
```

#### Events Listing Updates:
```jsx
// File: src/app/travel/tours/page.jsx

// Update event card images
const events = [
  {
    id: 1,
    image: "/assets/images/events/cards/paris-fashion-week.jpg", // was: travel/destinations/paris.jpg
    title: "Paris Fashion Week Spring 2025"
  },
  {
    id: 2, 
    image: "/assets/images/events/cards/milan-runway-show.jpg", // was: travel/destinations/rome.jpg
    title: "Milan Fashion Week"
  }
]
```

#### Logo Updates:
```jsx
// File: src/layouts/main/header.jsx

// BEFORE
<img src="/assets/images/logos/logo.svg" alt="Zone Travel" />

// AFTER
<img src="/assets/logos/eventsOS/eventsOS-logo.svg" alt="EventsOS" />
```

---

## 📱 **Responsive Image Implementation**

### Next.js Image Component Usage
```jsx
import Image from 'next/image'

// Responsive hero images
<Image
  src="/assets/images/events/hero-fashion-main.jpg"
  alt="Exclusive Fashion Events"
  width={1920}
  height={1080}
  priority={true}
  sizes="(max-width: 768px) 100vw, (max-width: 1200px) 80vw, 70vw"
/>

// Event card images with lazy loading
<Image
  src="/assets/images/events/cards/paris-fashion-week.jpg"
  alt="Paris Fashion Week"
  width={400}
  height={300}
  loading="lazy"
  sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 25vw"
/>
```

### WebP Format Support
```jsx
// Modern image formats for better performance
const ImageWithWebP = ({ src, alt, ...props }) => {
  return (
    <picture>
      <source srcSet={`${src}.webp`} type="image/webp" />
      <Image src={`${src}.jpg`} alt={alt} {...props} />
    </picture>
  )
}
```

---

## 🎨 **Styling and Visual Consistency**

### Image Overlays and Effects
```scss
// Fashion-focused image styling
.fashion-hero {
  position: relative;
  
  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(
      45deg, 
      rgba(26, 26, 26, 0.3) 0%,
      rgba(156, 39, 176, 0.1) 100%
    );
  }
}

.event-card-image {
  transition: transform 0.3s ease;
  border-radius: 8px;
  
  &:hover {
    transform: scale(1.05);
  }
}
```

### Color Overlays for Brand Consistency
```scss
// Consistent brand color overlays
.brand-overlay {
  position: relative;
  
  &::after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(
      135deg,
      rgba(201, 169, 110, 0.1) 0%,
      rgba(26, 26, 26, 0.2) 100%
    );
    pointer-events: none;
  }
}
```

---

## ⚡ **Performance Optimization**

### Image Compression Settings
```bash
# JPEG compression for photos
quality: 85%
progressive: true
format: baseline

# WebP compression  
quality: 80%
method: 6
lossless: false

# PNG compression for logos
optimization_level: 7
```

### Lazy Loading Implementation
```jsx
// Implement intersection observer for custom lazy loading
const LazyImage = ({ src, alt, className }) => {
  const [isLoaded, setIsLoaded] = useState(false)
  const [isInView, setIsInView] = useState(false)
  const imgRef = useRef()

  useEffect(() => {
    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          setIsInView(true)
          observer.disconnect()
        }
      },
      { threshold: 0.1 }
    )

    if (imgRef.current) {
      observer.observe(imgRef.current)
    }

    return () => observer.disconnect()
  }, [])

  return (
    <div ref={imgRef} className={className}>
      {isInView && (
        <Image
          src={src}
          alt={alt}
          onLoad={() => setIsLoaded(true)}
          className={isLoaded ? 'loaded' : 'loading'}
        />
      )}
    </div>
  )
}
```

---

## 🧪 **Testing Your Asset Changes**

### Visual Testing Checklist

#### Image Quality
- [ ] All images load correctly on desktop
- [ ] Images display properly on mobile devices  
- [ ] No broken image links (404 errors)
- [ ] Images maintain quality at different screen sizes
- [ ] Loading times are acceptable (<3 seconds)

#### Brand Consistency
- [ ] All logos display correctly
- [ ] Color scheme feels cohesive
- [ ] Image style is consistent across pages
- [ ] Fashion event theme is clear and professional
- [ ] Mobile logo/imagery works well

#### Performance Impact
- [ ] Page load speeds maintained or improved
- [ ] Images don't cause layout shift
- [ ] Lazy loading works correctly
- [ ] WebP format served when supported
- [ ] Lighthouse image scores remain high

### Testing Commands
```bash
# Test image loading
npm run dev
# Check browser network tab for image loading

# Test mobile responsiveness  
# Use browser dev tools device simulation

# Performance testing
npm run build
npm run start
# Use Lighthouse to test performance impact
```

---

## 📊 **Asset Management System**

### Organized File Structure
```bash
public/assets/images/events/
├── hero/
│   ├── main-hero.jpg (1920x1080)
│   ├── main-hero.webp
│   ├── events-listing-hero.jpg
│   └── about-hero.jpg
├── cards/
│   ├── thumbnails/ (400x300)
│   │   ├── paris-fw.jpg
│   │   ├── milan-show.jpg
│   │   └── ny-gala.jpg
│   └── webp/ (WebP versions)
├── gallery/
│   ├── paris-fw-2025/ (800x600)
│   ├── milan-gala/
│   └── ny-trade-show/
├── features/ (600x400)
│   ├── exclusive-access.jpg
│   ├── vip-tickets.jpg
│   └── secure-platform.jpg
└── optimized/ (compressed versions)
```

### Asset Naming Convention
```bash
# Consistent naming pattern
[event-type]-[location]-[year]-[variation].jpg

# Examples:
fashion-show-paris-2025-main.jpg
gala-milan-2025-red-carpet.jpg  
trade-show-ny-2025-exhibition.jpg
popup-london-2025-boutique.jpg
```

---

## 🔄 **Asset Update Workflow**

### Regular Asset Maintenance

#### Monthly Review
- [ ] Check for broken image links
- [ ] Update seasonal event images
- [ ] Add new event photography
- [ ] Optimize any new additions
- [ ] Review performance impact

#### Quarterly Updates
- [ ] Refresh hero images for current season
- [ ] Update event card thumbnails
- [ ] Add gallery images from recent events
- [ ] Review brand consistency
- [ ] Optimize entire image library

### Future Asset Needs
```bash
# Plan for upcoming features
├── user-generated-content/ # User photos from events
├── video-thumbnails/       # Video content previews  
├── social-media/          # Optimized for sharing
├── email-templates/       # Marketing materials
└── print-ready/          # High-res for print materials
```

---

## 🎯 **Success Metrics**

### Completion Criteria
- [ ] **Zero Travel Imagery**: No travel/destination photos remain
- [ ] **Brand Consistency**: All images reflect fashion events theme
- [ ] **Performance Maintained**: No negative impact on load times
- [ ] **Responsive Excellence**: Perfect display across all devices
- [ ] **Professional Quality**: Images meet luxury fashion standards

### Performance Targets
- **Hero image load**: <1.5 seconds
- **Card thumbnails**: <1 second
- **Gallery images**: <2 seconds  
- **Total page size**: <2MB
- **Lighthouse image score**: 90+

---

**🎉 Completion Test**: When someone visits your site, they should immediately recognize it as a premium fashion events platform with no hint of travel content.

**📝 Next Guide**: [Component Modifications](component-changes.md) - Safe component updates
