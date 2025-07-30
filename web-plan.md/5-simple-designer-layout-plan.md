# Fashion Designer Directory - Simple Layout Plan

## 📋 Table of Contents

1. [Progress Tracker](#1-progress-tracker)
2. [What We're Building](#2-what-were-building)
3. [Task 1: Designer Listing Page](#3-task-1-designer-listing-page)
4. [Task 2: Designer Profile Page](#4-task-2-designer-profile-page)
5. [Sample Designer Data](#5-sample-designer-data)
6. [Quick Implementation](#6-quick-implementation)

---

## 1. Progress Tracker

| Task | Description | Time | Status |
|------|-------------|------|---------|
| 🔴 Task 1 | Designer listing page | 3 hours | 0% |
| 🔴 Task 2 | Designer profile page | 2 hours | 0% |

**Total: 5 hours**

---

## 2. What We're Building

### Simple 2-Page Designer Directory:
1. **Listing Page** (`/designers`) - Grid of designer cards
2. **Profile Page** (`/designers/[name]`) - Individual designer details

### Using Zone Components:
- Travel Tours → Designer Listing
- Tour Details → Designer Profile

---

## 3. Task 1: Designer Listing Page

### Layout
```
Fashion Designers
─────────────────

┌─────┐ ┌─────┐ ┌─────┐
│Card │ │Card │ │Card │
└─────┘ └─────┘ └─────┘

┌─────┐ ┌─────┐ ┌─────┐
│Card │ │Card │ │Card │
└─────┘ └─────┘ └─────┘
```

### Designer Card
```
┌─────────────────┐
│   [Photo]       │
│                 │
│ Silvia T.    ✓ │
│ Luxury Fashion  │
│ Barranquilla    │
└─────────────────┘
```

### Implementation Steps

#### Step 1: Copy Zone Tours Page
```bash
# Copy tours to designers
cp -r src/app/travel/tours src/app/(fashion)/designers
cp -r src/sections/_travel/tour src/sections/_fashion/designers
```

#### Step 2: Update Text Only
```javascript
// In designer listing page:
"Find Tours" → "Fashion Designers"
"tours" → "designers"
"destination" → "location"
"price" → "category"
```

#### Step 3: Simple Card Changes
```javascript
// Map tour fields to designer:
tour.image → designer.photo
tour.name → designer.name
tour.location → designer.city
tour.price → designer.category
tour.rating → verified badge (✓)
```

---

## 4. Task 2: Designer Profile Page

### Layout
```
[Designer Photo]

Silvia Tcherassi ✓
Luxury Fashion House
Barranquilla • 30 Years

About
─────
Brand story and philosophy...

Portfolio
─────────
[Image] [Image] [Image]
[Image] [Image] [Image]

Contact
───────
Email: contact@designer.com
Instagram: @designer
Website: designer.com
```

### Implementation Steps

#### Step 1: Copy Tour Details Page
```bash
# Copy tour details to designer profile
cp src/app/travel/tours/[id] src/app/(fashion)/designers/[slug]
```

#### Step 2: Update Sections
```javascript
// Change tabs:
"Overview" → "About"
"Itinerary" → "Portfolio"
"Location" → "Contact"

// Hide unused:
- Pricing table
- Booking calendar
- Map
```

---

## 5. Sample Designer Data

### 5 Colombian Designers

```javascript
const designers = [
  {
    id: 1,
    slug: "silvia-tcherassi",
    name: "Silvia Tcherassi",
    category: "Luxury Fashion",
    city: "Barranquilla",
    verified: true,
    photo: "/images/silvia.jpg",
    about: "Known for tropical glamour and resort wear",
    instagram: "@silviatcherassi",
    website: "silviatcherassi.com"
  },
  {
    id: 2,
    slug: "johanna-ortiz",
    name: "Johanna Ortiz",
    category: "Ready-to-Wear",
    city: "Cali",
    verified: true,
    photo: "/images/johanna.jpg",
    about: "Feminine designs with Latin American flair",
    instagram: "@johannaortiz",
    website: "johannaortiz.com"
  },
  {
    id: 3,
    slug: "esteban-cortazar",
    name: "Esteban Cortázar",
    category: "Contemporary",
    city: "Bogotá",
    verified: true,
    photo: "/images/esteban.jpg",
    about: "Modern minimalism with fluid draping",
    instagram: "@estebancortazar",
    website: "estebancortazar.com"
  },
  {
    id: 4,
    slug: "maria-villamil",
    name: "María Villamil",
    category: "Sustainable",
    city: "Medellín",
    verified: false,
    photo: "/images/maria.jpg",
    about: "Eco-conscious designs with traditional textiles",
    instagram: "@mariavillamil",
    website: "villamil.co"
  },
  {
    id: 5,
    slug: "laura-laurens",
    name: "Laura Laurens",
    category: "Urban Fashion",
    city: "Bogotá",
    verified: false,
    photo: "/images/laura.jpg",
    about: "Architectural silhouettes for modern women",
    instagram: "@lauralaurens",
    website: "laurens.com.co"
  }
];
```

---

## 6. Quick Implementation

### All Commands in Order

```bash
# 1. Setup directories
cd /home/sk/fx/fashionos
mkdir -p src/app/\(fashion\)/designers/\[slug\]
mkdir -p src/sections/_fashion/designers

# 2. Copy Zone components
cp -r src/app/travel/tours/* src/app/\(fashion\)/designers/
cp -r src/sections/_travel/tour/* src/sections/_fashion/designers/

# 3. Start development
pnpm dev

# 4. Test pages
# http://localhost:3000/designers
# http://localhost:3000/designers/silvia-tcherassi
```

### Text Changes Checklist

**Listing Page:**
- [ ] Page title: "Fashion Designers"
- [ ] Remove tour-specific filters
- [ ] Update card labels
- [ ] Add verified badges

**Profile Page:**
- [ ] Designer name as title
- [ ] "About" instead of "Overview"
- [ ] "Portfolio" instead of "Itinerary"
- [ ] Contact info instead of booking

### That's It! 

No complex layouts. No custom components. Just:
1. Copy Zone tour pages
2. Change text and labels
3. Add designer data
4. Test and deploy

**Time: 5 hours total** ✅