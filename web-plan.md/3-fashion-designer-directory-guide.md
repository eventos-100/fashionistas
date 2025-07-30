# Fashion Designer Directory - Complete Implementation Guide

## 📋 Table of Contents

1. [Progress Tracker](#1-progress-tracker)
2. [Designer Card Layout](#2-designer-card-layout)
3. [Filter System Implementation](#3-filter-system-implementation)
4. [Sample Designer Dataset](#4-sample-designer-dataset)
5. [Extended Designer Database](#5-extended-designer-database)
6. [Image Requirements & Styling](#6-image-requirements--styling)
7. [Visual Design System](#7-visual-design-system)
8. [Page Header Content](#8-page-header-content)
9. [Search & Sort Options](#9-search--sort-options)
10. [Mobile Responsive Design](#10-mobile-responsive-design)
11. [Implementation Checklist](#11-implementation-checklist)

---

## 1. Progress Tracker

| Task | Description | Status |
|------|-------------|---------|
| ✅ | Define card layout | Complete |
| ✅ | Create sample designer dataset | Complete |
| ✅ | List filters and UX expectations | Complete |
| ⬜ | Upload designer photos | Not started |
| ⬜ | Apply color and visual styles | Not started |
| ⬜ | Configure filter functionality | Not started |
| ⬜ | Add search functionality | Not started |
| ⬜ | Test mobile responsiveness | Not started |

---

## 2. Designer Card Layout

### Card Structure (Adapting Tour Card)

```
┌─────────────────────────┐
│                         │
│    [Designer Photo]     │  ← 1:1 square ratio
│                         │
├─────────────────────────┤
│ SILVIA TCHERASSI    ✓  │  ← Name + Verified badge
│ Luxury Fashion House    │  ← Category
│ Barranquilla, Colombia  │  ← Location
│ 30 Years Experience     │  ← Experience
│                         │
│ ⭐⭐⭐⭐⭐ (127)          │  ← Rating (if applicable)
│                         │
│ [View Profile] [Contact]│  ← Action buttons
└─────────────────────────┘
```

### Field Mapping from Zone Tours

| Tour Field | Designer Field | Display Format |
|------------|----------------|----------------|
| `tour.image` | `designer.photo` | Square crop, 400x400px |
| `tour.country` | `designer.location` | "City, Colombia" |
| `tour.name` | `designer.name` | Bold, uppercase |
| `tour.duration` | `designer.experience` | "X Years Experience" |
| `tour.price` | `designer.category` | Category badge |
| `tour.rating` | `designer.rating` | 5-star system (optional) |
| `tour.badge` | `designer.verified` | ✓ Verified badge |

### Card States

**Default State:**
- White background
- Subtle shadow: `0 2px 8px rgba(0,0,0,0.08)`
- Border: `1px solid #f0f0f0`

**Hover State:**
- Transform: `translateY(-4px)`
- Shadow: `0 8px 24px rgba(0,0,0,0.12)`
- Border color: Champagne gold (#D4AF37)

**Featured Designer Card:**
- Gold border: `2px solid #D4AF37`
- Featured badge overlay
- Slightly larger size (1.1x scale)

---

## 3. Filter System Implementation

### Filter Groups Layout

```
REFINE YOUR SEARCH
━━━━━━━━━━━━━━━━━

▼ CATEGORY
☐ Luxury
☐ Ready-to-Wear
☐ Sustainable
☐ Emerging
☐ Accessories
☐ Contemporary

▼ LOCATION
☐ Bogotá (45)
☐ Medellín (38)
☐ Cali (22)
☐ Barranquilla (15)
☐ Cartagena (12)
☐ International (8)

▼ EXPERIENCE
☐ Industry Icons (20+ Years)
☐ Established (10-20 Years)
☐ Rising Stars (5-10 Years)
☐ Emerging Talent (<5 Years)

▼ SPECIALITY
☐ Women's Wear
☐ Men's Wear
☐ Unisex Collections
☐ Children's Fashion
☐ Bridal
☐ Accessories

[Clear All Filters]
```

### Filter Behavior

**Desktop (>768px):**
- Left sidebar, 25% width
- All sections expanded by default
- Sticky position on scroll
- Instant results update

**Mobile (<768px):**
- Collapsible accordion style
- Floating filter button
- Full-screen overlay when opened
- "Apply Filters" button required

### Filter Logic

```javascript
// Pseudo-code for client-side filtering
filterDesigners() {
  // Get all checked filters
  const activeFilters = {
    category: getChecked('.filter-category'),
    location: getChecked('.filter-location'),
    experience: getChecked('.filter-experience'),
    speciality: getChecked('.filter-speciality')
  };
  
  // Apply filters (AND between groups, OR within groups)
  const filtered = designers.filter(designer => {
    return matchesCategory(designer, activeFilters.category) &&
           matchesLocation(designer, activeFilters.location) &&
           matchesExperience(designer, activeFilters.experience) &&
           matchesSpeciality(designer, activeFilters.speciality);
  });
  
  // Update results count
  updateResultsCount(filtered.length);
  
  // Re-render cards
  renderDesignerCards(filtered);
}
```

---

## 4. Sample Designer Dataset

### Core Designer Data (5 Featured)

```javascript
const featuredDesigners = [
  {
    id: 1,
    name: "Silvia Tcherassi",
    category: "Luxury",
    location: "Barranquilla",
    country: "Colombia",
    experience: 30,
    experienceLabel: "30 years",
    featured: true,
    verified: true,
    rating: 4.9,
    reviews: 127,
    photo: "/images/designers/silvia-tcherassi.jpg",
    specialities: ["Women's Wear", "Bridal"],
    description: "Internationally recognized for tropical glamour and sophisticated resort wear",
    instagram: "@silviatcherassi",
    website: "www.silviatcherassi.com"
  },
  {
    id: 2,
    name: "Johanna Ortiz",
    category: "Ready-to-Wear",
    location: "Cali",
    country: "Colombia",
    experience: 20,
    experienceLabel: "20 years",
    featured: true,
    verified: true,
    rating: 4.8,
    reviews: 98,
    photo: "/images/designers/johanna-ortiz.jpg",
    specialities: ["Women's Wear", "Unisex"],
    description: "Feminine silhouettes celebrating Latin American heritage",
    instagram: "@johannaortiz",
    website: "www.johannaortiz.com"
  },
  {
    id: 3,
    name: "Esteban Cortázar",
    category: "Contemporary",
    location: "Bogotá",
    country: "Colombia",
    experience: 25,
    experienceLabel: "25 years",
    featured: true,
    verified: true,
    rating: 4.7,
    reviews: 86,
    photo: "/images/designers/esteban-cortazar.jpg",
    specialities: ["Women's Wear", "Men's Wear"],
    description: "Modern minimalism with Latin sensuality",
    instagram: "@estebancortazar",
    website: "www.estebancortazar.com"
  },
  {
    id: 4,
    name: "María Villamil",
    category: "Sustainable",
    location: "Medellín",
    country: "Colombia",
    experience: 15,
    experienceLabel: "15 years",
    featured: false,
    verified: true,
    rating: 4.6,
    reviews: 72,
    photo: "/images/designers/maria-villamil.jpg",
    specialities: ["Women's Wear", "Accessories"],
    description: "Eco-conscious designs with traditional Colombian textiles",
    instagram: "@mariavillamil",
    website: "www.villamil.co"
  },
  {
    id: 5,
    name: "Laura Laurens",
    category: "Urban",
    location: "Bogotá",
    country: "Colombia",
    experience: 12,
    experienceLabel: "12 years",
    featured: false,
    verified: true,
    rating: 4.5,
    reviews: 64,
    photo: "/images/designers/laura-laurens.jpg",
    specialities: ["Women's Wear", "Unisex"],
    description: "Architectural silhouettes for the modern urbanite",
    instagram: "@lauralaurens",
    website: "www.lauralaurens.com"
  }
];
```

---

## 5. Extended Designer Database

### Additional Designers (15 more for total of 20)

```javascript
const additionalDesigners = [
  {
    id: 6,
    name: "Amelia Toro",
    category: "Luxury",
    location: "Cartagena",
    experience: 22,
    verified: true,
    specialities: ["Women's Wear", "Accessories"]
  },
  {
    id: 7,
    name: "Pepa Pombo",
    category: "Ready-to-Wear",
    location: "Bogotá",
    experience: 18,
    verified: true,
    specialities: ["Women's Wear", "Bridal"]
  },
  {
    id: 8,
    name: "Andrés Pajón",
    category: "Contemporary",
    location: "Medellín",
    experience: 8,
    verified: false,
    specialities: ["Men's Wear", "Unisex"]
  },
  {
    id: 9,
    name: "Kika Vargas",
    category: "Luxury",
    location: "Bogotá",
    experience: 28,
    verified: true,
    specialities: ["Women's Wear"]
  },
  {
    id: 10,
    name: "Diana Dazzling",
    category: "Emerging",
    location: "Cali",
    experience: 4,
    verified: false,
    specialities: ["Women's Wear", "Accessories"]
  },
  {
    id: 11,
    name: "Carlos Valenzuela",
    category: "Sustainable",
    location: "Medellín",
    experience: 6,
    verified: true,
    specialities: ["Unisex", "Accessories"]
  },
  {
    id: 12,
    name: "Isabella Santo Domingo",
    category: "Luxury",
    location: "International",
    experience: 15,
    verified: true,
    specialities: ["Women's Wear", "Accessories"]
  },
  {
    id: 13,
    name: "Miguel Caballero",
    category: "Contemporary",
    location: "Bogotá",
    experience: 20,
    verified: true,
    specialities: ["Men's Wear", "Unisex"]
  },
  {
    id: 14,
    name: "Paula Mendoza",
    category: "Accessories",
    location: "Bogotá",
    experience: 12,
    verified: true,
    specialities: ["Accessories"]
  },
  {
    id: 15,
    name: "Beatriz Camacho",
    category: "Ready-to-Wear",
    location: "Cartagena",
    experience: 16,
    verified: true,
    specialities: ["Women's Wear", "Children"]
  },
  {
    id: 16,
    name: "Juan Pablo Socarrás",
    category: "Emerging",
    location: "Barranquilla",
    experience: 3,
    verified: false,
    specialities: ["Men's Wear"]
  },
  {
    id: 17,
    name: "Natalia Londoño",
    category: "Sustainable",
    location: "Cali",
    experience: 9,
    verified: true,
    specialities: ["Women's Wear", "Children"]
  },
  {
    id: 18,
    name: "Ricardo Pava",
    category: "Contemporary",
    location: "International",
    experience: 11,
    verified: true,
    specialities: ["Unisex"]
  },
  {
    id: 19,
    name: "Mónica Holguín",
    category: "Luxury",
    location: "Bogotá",
    experience: 35,
    verified: true,
    specialities: ["Women's Wear", "Bridal"]
  },
  {
    id: 20,
    name: "Felipe Rentería",
    category: "Emerging",
    location: "Medellín",
    experience: 2,
    verified: false,
    specialities: ["Men's Wear", "Unisex"]
  }
];
```

---

## 6. Image Requirements & Styling

### Designer Photo Specifications

**Technical Requirements:**
- Format: JPG or PNG
- Dimensions: 800x800px (1:1 ratio)
- File size: <300KB optimized
- Resolution: 72dpi for web
- Color space: sRGB

**Photography Style:**
- Professional headshots preferred
- Clean, neutral backgrounds
- Soft, even lighting
- Fashion-forward styling
- Consistent editing across all photos

**Image Treatments:**
```css
.designer-photo {
  object-fit: cover;
  object-position: center top;
  filter: brightness(1.05) contrast(1.1);
  transition: all 0.3s ease;
}

.designer-photo:hover {
  filter: brightness(1.1) contrast(1.15);
  transform: scale(1.02);
}
```

### Verified Badge Overlay

```css
.verified-badge {
  position: absolute;
  top: 12px;
  right: 12px;
  background: #D4AF37;
  color: #000;
  padding: 4px 8px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 600;
  display: flex;
  align-items: center;
  gap: 4px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.15);
}

.verified-badge::before {
  content: "✓";
  font-size: 14px;
}
```

---

## 7. Visual Design System

### Color Palette

**Primary Colors:**
- Pure Black: `#000000` (Headers, primary text)
- Crisp White: `#FFFFFF` (Backgrounds)
- Champagne Gold: `#D4AF37` (Accents, CTAs, verified badges)

**Secondary Colors:**
- Warm Grey: `#6B6B6B` (Secondary text)
- Light Grey: `#F5F5F5` (Backgrounds)
- Border Grey: `#E0E0E0` (Dividers)

**Category Colors:**
- Luxury: `#1A1A1A` (Deep black)
- Ready-to-Wear: `#4A5568` (Charcoal)
- Sustainable: `#2F855A` (Forest green)
- Emerging: `#D69E2E` (Amber)
- Contemporary: `#2D3748` (Slate)
- Accessories: `#744210` (Bronze)

### Typography System

```css
/* Designer Name */
.designer-name {
  font-family: 'Helvetica Neue', Arial, sans-serif;
  font-size: 18px;
  font-weight: 700;
  letter-spacing: 0.5px;
  text-transform: uppercase;
  color: #000000;
  margin: 16px 0 4px;
}

/* Category Label */
.designer-category {
  font-family: 'Inter', 'Helvetica Neue', sans-serif;
  font-size: 14px;
  font-weight: 500;
  color: #6B6B6B;
  margin-bottom: 4px;
}

/* Location & Experience */
.designer-meta {
  font-family: 'Inter', 'Helvetica Neue', sans-serif;
  font-size: 13px;
  font-weight: 400;
  color: #6B6B6B;
  line-height: 1.5;
}
```

### Component Styling

**Designer Card:**
```css
.designer-card {
  background: #FFFFFF;
  border: 1px solid #E0E0E0;
  border-radius: 8px;
  overflow: hidden;
  transition: all 0.3s ease;
  cursor: pointer;
  box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}

.designer-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(0,0,0,0.12);
  border-color: #D4AF37;
}

.designer-card.featured {
  border: 2px solid #D4AF37;
  transform: scale(1.02);
}
```

**Action Buttons:**
```css
.btn-primary {
  background: #000000;
  color: #FFFFFF;
  padding: 10px 24px;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  transition: all 0.3s ease;
  border: 1px solid #000000;
}

.btn-primary:hover {
  background: #D4AF37;
  color: #000000;
  border-color: #D4AF37;
  box-shadow: 0 4px 12px rgba(212,175,55,0.3);
}

.btn-secondary {
  background: transparent;
  color: #000000;
  padding: 10px 24px;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  transition: all 0.3s ease;
  border: 1px solid #000000;
}

.btn-secondary:hover {
  background: #000000;
  color: #FFFFFF;
}
```

**Rating Stars:**
```css
.rating {
  display: flex;
  align-items: center;
  gap: 4px;
  margin: 8px 0;
}

.star {
  color: #E0E0E0;
  font-size: 16px;
}

.star.filled {
  color: #D4AF37;
}

.rating-count {
  font-size: 13px;
  color: #6B6B6B;
  margin-left: 8px;
}
```

---

## 8. Page Header Content

### Hero Section

**Title:** "Colombian Fashion Designers"

**Subtitle:** "Discover the creative minds shaping Latin American fashion"

**Description:** "From established luxury houses to emerging sustainable brands, explore our curated directory of Colombia's most talented fashion designers. Connect directly with designers for collaborations, custom pieces, or to feature their collections in your next event."

### Search Bar
```
Placeholder: "Search designers by name, category, or specialty..."
Icon: 🔍
Position: Below hero, above filters
```

### Results Summary
```
"Showing 20 designers" | Sort by: [Featured ▼]
```

---

## 9. Search & Sort Options

### Search Functionality

**Search Fields:**
- Designer name
- Brand name
- Category
- Speciality
- Location

**Search Behavior:**
- Instant search (300ms debounce)
- Highlight matching terms
- "No results" message with suggestions
- Clear search button

### Sort Options

**Dropdown Options:**
1. Featured First (default)
2. Name: A-Z
3. Name: Z-A
4. Experience: Most to Least
5. Experience: Least to Most
6. Recently Added
7. Most Reviewed

---

## 10. Mobile Responsive Design

### Breakpoints

**Desktop (>1024px):**
- 4 cards per row
- Fixed filter sidebar
- Hover effects enabled

**Tablet (768px - 1024px):**
- 2 cards per row
- Collapsible filter sidebar
- Touch-friendly tap targets

**Mobile (<768px):**
- 1 card per row
- Filter button triggers overlay
- Simplified card layout
- Larger fonts and buttons

### Mobile Optimizations

**Filter Overlay:**
```css
@media (max-width: 767px) {
  .filter-sidebar {
    position: fixed;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100vh;
    background: #FFFFFF;
    z-index: 1000;
    transition: left 0.3s ease;
    overflow-y: auto;
  }
  
  .filter-sidebar.active {
    left: 0;
  }
  
  .filter-header {
    position: sticky;
    top: 0;
    background: #FFFFFF;
    padding: 16px;
    border-bottom: 1px solid #E0E0E0;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .filter-apply-btn {
    position: sticky;
    bottom: 0;
    background: #000000;
    color: #FFFFFF;
    width: 100%;
    padding: 16px;
    text-align: center;
    font-weight: 600;
  }
}
```

**Touch Targets:**
- Minimum 48px height for all interactive elements
- Increased padding on filter checkboxes
- Larger close buttons (44px)

---

## 11. Implementation Checklist

### Phase 1: Structure Setup
- [ ] Map Zone tour fields to designer fields
- [ ] Set up card grid layout
- [ ] Configure responsive breakpoints
- [ ] Add filter sidebar structure

### Phase 2: Content Integration
- [ ] Import designer dataset
- [ ] Add designer photos (20 images)
- [ ] Write hero section content
- [ ] Configure search placeholder text

### Phase 3: Visual Styling
- [ ] Apply color palette
- [ ] Style designer cards
- [ ] Add hover effects
- [ ] Style filter components
- [ ] Add verified badges

### Phase 4: Functionality
- [ ] Implement filter logic
- [ ] Add search functionality
- [ ] Configure sort dropdown
- [ ] Test mobile filter overlay
- [ ] Add loading states

### Phase 5: Polish & Launch
- [ ] Test all filter combinations
- [ ] Verify mobile responsiveness
- [ ] Check image loading
- [ ] Add analytics tracking
- [ ] Performance optimization

### Final QA Checklist
- [ ] All 20 designers display correctly
- [ ] Filters work on desktop and mobile
- [ ] Search returns accurate results
- [ ] Images load quickly
- [ ] Verified badges show for featured designers
- [ ] Sort functionality works
- [ ] Page loads in <3 seconds
- [ ] No console errors

---

## 🎯 Success Criteria

The Fashion Designer Directory is complete when:

1. **Visual Impact**: Elegant, luxury aesthetic throughout
2. **Functionality**: All filters, search, and sort work perfectly
3. **Performance**: Fast loading, smooth interactions
4. **Responsive**: Beautiful on all devices
5. **Content**: All 20 designers with complete information

**Ready to transform the Zone Travel tours page into an elegant fashion designer directory!**