# Fashion Designer Directory - Task Matrix & Component Mapping

## 📋 Table of Contents

1. [Master Progress Tracker](#1-master-progress-tracker)
2. [Component Mapping Analysis](#2-component-mapping-analysis)
3. [Task Matrix - Designer Listing Page](#3-task-matrix---designer-listing-page)
4. [Task Matrix - Designer Profile Page](#4-task-matrix---designer-profile-page)
5. [Implementation Timeline](#5-implementation-timeline)
6. [Quick Reference Guide](#6-quick-reference-guide)

---

## 1. Master Progress Tracker

| Component Section | Zone Source | Fashion Target | Priority | Status | % Complete |
|-------------------|-------------|----------------|----------|---------|------------|
| **LISTING PAGE** |
| 🔴 Page Layout | `/travel/tours` | `/designers` | P0 | Not Started | 0% |
| 🔴 Hero Section | `TravelToursHero` | `DesignersHero` | P0 | Not Started | 0% |
| 🔴 Filter Sidebar | `TravelToursFilters` | `DesignerFilters` | P0 | Not Started | 0% |
| 🔴 Search Bar | `TravelToursSearch` | `DesignerSearch` | P0 | Not Started | 0% |
| 🔴 Designer Cards | `TravelTourItem` | `DesignerCard` | P0 | Not Started | 0% |
| 🔴 Grid Layout | `TravelToursList` | `DesignersList` | P0 | Not Started | 0% |
| 🔴 Pagination | `TravelToursPagination` | `DesignersPagination` | P1 | Not Started | 0% |
| **PROFILE PAGE** |
| 🔴 Page Layout | `/travel/tours/details` | `/designers/[slug]` | P0 | Not Started | 0% |
| 🔴 Hero Banner | `TravelTourDetailsHero` | `DesignerProfileHero` | P0 | Not Started | 0% |
| 🔴 Info Tabs | `TravelTourDetailsTabs` | `DesignerInfoTabs` | P0 | Not Started | 0% |
| 🔴 Gallery | `TravelTourDetailsGallery` | `DesignerPortfolio` | P0 | Not Started | 0% |
| 🔴 About Section | `TravelTourDetailsOverview` | `DesignerAbout` | P0 | Not Started | 0% |
| 🔴 Contact Form | `TravelTourDetailsReserve` | `DesignerBooking` | P0 | Not Started | 0% |
| 🔴 Social Share | `TravelShareButton` | `DesignerShare` | P2 | Not Started | 0% |

**Legend:** 🔴 Not Started | 🟡 In Progress | 🟢 Completed & Tested

---

## 2. Component Mapping Analysis

### 🔍 Zone Travel Tours → Fashion Designers Mapping

| Zone Component | Location | Fashion Usage | Changes Required |
|----------------|----------|---------------|------------------|
| **TOURS LISTING PAGE** | `/travel/tours` | **DESIGNERS DIRECTORY** | |
| `TravelToursPage` | `app/travel/tours/page.tsx` | Main listing page structure | Update metadata only |
| `TravelToursHero` | `sections/_travel/tour/travel-tours-hero.tsx` | Designer directory hero | Text & image only |
| `TravelToursFilters` | `sections/_travel/tour/travel-tours-filters.tsx` | Filter designers by category | Labels & options |
| `TravelToursSearch` | `sections/_travel/tour/travel-tours-search.tsx` | Search designers | Placeholder text |
| `TravelTourItem` | `sections/_travel/tour/travel-tour-item.tsx` | Designer card component | Map fields |
| `TravelToursList` | `sections/_travel/tour/travel-tours-list.tsx` | Designer grid container | No changes |
| `TravelToursSort` | `sections/_travel/tour/travel-tours-sort.tsx` | Sort designers | Option labels |
| **TOUR DETAILS PAGE** | `/travel/tours/details` | **DESIGNER PROFILE** | |
| `TravelTourDetailsPage` | `app/travel/tours/[id]/page.tsx` | Profile page structure | Route params |
| `TravelTourDetailsHero` | `sections/_travel/tour/travel-tour-details-hero.tsx` | Designer hero section | Add social links |
| `TravelTourDetailsTabs` | `sections/_travel/tour/travel-tour-details-tabs.tsx` | Profile sections | Tab labels |
| `TravelTourDetailsGallery` | `sections/_travel/tour/travel-tour-details-gallery.tsx` | Portfolio gallery | Categories |
| `TravelTourDetailsOverview` | `sections/_travel/tour/travel-tour-details-overview.tsx` | About designer | Content fields |
| `TravelTourDetailsReserve` | `sections/_travel/tour/travel-tour-details-reserve.tsx` | Booking form | Form fields |

---

## 3. Task Matrix - Designer Listing Page

### 📋 Phase 1: Page Setup (Day 1 Morning)

| Task ID | Component | Action | Commands | Time | Status |
|---------|-----------|--------|----------|------|---------|
| **1.1** | Directory Structure | Create fashion designers folders | `DC: create_directory src/app/(fashion)/designers` | 15min | 🔴 |
| **1.2** | Route Setup | Copy tours page to designers | `DC: execute_command "cp src/app/travel/tours/page.tsx src/app/(fashion)/designers/page.tsx"` | 15min | 🔴 |
| **1.3** | Component Directory | Create fashion tour sections | `DC: execute_command "cp -r src/sections/_travel/tour src/sections/_fashion/designers"` | 30min | 🔴 |
| **1.4** | Import Updates | Update all import paths | Update `_travel/tour` → `_fashion/designers` | 1hr | 🔴 |

### 📋 Phase 2: Hero Section (Day 1 Afternoon)

| Task ID | Component | Action | Changes | Time | Status |
|---------|-----------|--------|---------|------|---------|
| **2.1** | Hero Banner | Update hero content | Title: "Colombian Fashion Designers"<br>Subtitle: "Discover talented designers shaping Latin American fashion" | 30min | 🔴 |
| **2.2** | Hero Image | Replace background | Use fashion runway or designer workspace image | 30min | 🔴 |
| **2.3** | CTA Buttons | Update actions | "Submit Profile" → "Join Directory"<br>"View All" → "Browse Designers" | 15min | 🔴 |
| **2.4** | Test Hero | Verify responsive | Check mobile/tablet/desktop views | 15min | 🔴 |

### 📋 Phase 3: Filter System (Day 2 Morning)

| Task ID | Component | Filter Type | Options to Add | Time | Status |
|---------|-----------|-------------|----------------|------|---------|
| **3.1** | Style Category | Replace destinations | Luxury, Ready-to-Wear, Sustainable, Emerging, Accessories | 45min | 🔴 |
| **3.2** | Price Range | Replace budget | Ultra Luxury, Luxury, Premium, Mid-Range, Accessible | 30min | 🔴 |
| **3.3** | Experience | Replace duration | 20+ Years, 10-20 Years, 5-10 Years, Emerging (0-5) | 30min | 🔴 |
| **3.4** | Location | Add Colombian cities | Bogotá, Medellín, Cali, Cartagena, Barranquilla | 30min | 🔴 |
| **3.5** | Hide Unused | Remove travel filters | Hide: Languages, Group Size, Activities | 30min | 🔴 |

### 📋 Phase 4: Designer Cards (Day 2 Afternoon)

| Task ID | Zone Field | Designer Field | Mapping | Time | Status |
|---------|------------|----------------|---------|------|---------|
| **4.1** | `tour.coverImg` | `designer.profile_image` | Designer photo/logo | 30min | 🔴 |
| **4.2** | `tour.location` | `designer.location` | City, Colombia | 15min | 🔴 |
| **4.3** | `tour.name` | `designer.brand_name` | Brand name | 15min | 🔴 |
| **4.4** | `tour.duration` | `designer.years_experience` | "15 Years Experience" | 30min | 🔴 |
| **4.5** | `tour.price` | `designer.price_range` | "Luxury" badge | 30min | 🔴 |
| **4.6** | `tour.rating` | `designer.verification` | Verified badge | 45min | 🔴 |
| **4.7** | `tour.reviews` | Hide | Remove completely | 15min | 🔴 |

### 📋 Phase 5: Search & Sort (Day 3 Morning)

| Task ID | Component | Update | New Value | Time | Status |
|---------|-----------|--------|-----------|------|---------|
| **5.1** | Search Placeholder | Update text | "Search designers, brands, or styles..." | 15min | 🔴 |
| **5.2** | Sort Options | Update labels | Most Popular → Featured First<br>Newest → Recently Added<br>Price → Experience Level | 30min | 🔴 |
| **5.3** | Results Count | Update text | "Showing X of Y designers" | 15min | 🔴 |
| **5.4** | Empty State | Update message | "No designers match your criteria" | 15min | 🔴 |

---

## 4. Task Matrix - Designer Profile Page

### 📋 Phase 6: Profile Route Setup (Day 3 Afternoon)

| Task ID | Component | Action | Commands | Time | Status |
|---------|-----------|--------|----------|------|---------|
| **6.1** | Create Route | Dynamic designer pages | `DC: create_directory src/app/(fashion)/designers/[slug]` | 15min | 🔴 |
| **6.2** | Copy Details Page | Use tour details template | `DC: execute_command "cp src/app/travel/tours/[id]/page.tsx src/app/(fashion)/designers/[slug]/page.tsx"` | 15min | 🔴 |
| **6.3** | Update Params | Change id to slug | Replace `params.id` with `params.slug` | 30min | 🔴 |
| **6.4** | Test Routes | Verify dynamic routing | Test `/designers/silvia-tcherassi` | 30min | 🔴 |

### 📋 Phase 7: Profile Hero Section (Day 4 Morning)

| Task ID | Zone Element | Designer Element | Implementation | Time | Status |
|---------|--------------|------------------|----------------|------|---------|
| **7.1** | Tour Title | Brand Name | Large typography for brand | 30min | 🔴 |
| **7.2** | Tour Subtitle | Designer Name | Smaller text below brand | 15min | 🔴 |
| **7.3** | Location Badge | Origin + Experience | "Bogotá • 20 Years Experience" | 30min | 🔴 |
| **7.4** | Price Badge | Price Range | "Luxury" or "Premium" badge | 15min | 🔴 |
| **7.5** | Rating Stars | Verification Badge | Show verified checkmark | 45min | 🔴 |
| **7.6** | Share Button | Social Links | Add Instagram, Website icons | 45min | 🔴 |

### 📋 Phase 8: Profile Tabs Content (Day 4 Afternoon)

| Task ID | Tab Name | Content Mapping | Elements | Time | Status |
|---------|----------|-----------------|----------|------|---------|
| **8.1** | Overview → About | Designer bio & philosophy | Brand story, design approach, sustainability | 1hr | 🔴 |
| **8.2** | Itinerary → Collections | Seasonal collections | Collection names, launch dates, themes | 45min | 🔴 |
| **8.3** | Inclusions → Services | What designer offers | Custom designs, consultations, collaborations | 30min | 🔴 |
| **8.4** | Add Tab | Press & Awards | New tab for achievements | Awards list, press mentions, features | 1hr | 🔴 |

### 📋 Phase 9: Portfolio Gallery (Day 5 Morning)

| Task ID | Gallery Section | Content Type | Implementation | Time | Status |
|---------|-----------------|--------------|----------------|------|---------|
| **9.1** | Main Gallery | Portfolio Images | Latest collection photos | 45min | 🔴 |
| **9.2** | Categories | Image Filters | Collection, Runway, Campaign, Behind Scenes | 30min | 🔴 |
| **9.3** | Lightbox | Full View | Keep existing lightbox functionality | 15min | 🔴 |
| **9.4** | Captions | Image Info | Collection name, season, year | 30min | 🔴 |

### 📋 Phase 10: Booking Form (Day 5 Afternoon)

| Task ID | Form Field | Designer Field | Validation | Time | Status |
|---------|------------|----------------|------------|------|---------|
| **10.1** | Tour Date → Event Date | When designer needed | Date picker for events | 30min | 🔴 |
| **10.2** | Guests → Event Type | Type of engagement | Runway, Showroom, Collaboration | 30min | 🔴 |
| **10.3** | Add Field | Budget Range | Expected investment | Select dropdown | 30min | 🔴 |
| **10.4** | Message Field | Project Details | Describe collaboration | Textarea required | 15min | 🔴 |
| **10.5** | Submit Action | Send Inquiry | Email to designer | 45min | 🔴 |

---

## 5. Implementation Timeline

### 📅 5-Day Sprint Schedule

| Day | Morning (4 hrs) | Afternoon (4 hrs) | Deliverable |
|-----|-----------------|-------------------|-------------|
| **Day 1** | ✓ Page setup<br>✓ Directory structure<br>✓ Import updates | ✓ Hero section<br>✓ Basic layout<br>✓ Initial testing | Listing page structure |
| **Day 2** | ✓ Filter system<br>✓ All filter options<br>✓ Hide unused | ✓ Designer cards<br>✓ Field mapping<br>✓ Grid layout | Complete listing page |
| **Day 3** | ✓ Search & sort<br>✓ Pagination<br>✓ Testing | ✓ Profile route<br>✓ Dynamic pages<br>✓ Basic structure | Profile page foundation |
| **Day 4** | ✓ Profile hero<br>✓ Verification badge<br>✓ Social links | ✓ Tab content<br>✓ About section<br>✓ Services | Complete profile content |
| **Day 5** | ✓ Portfolio gallery<br>✓ Image categories<br>✓ Lightbox | ✓ Booking form<br>✓ Form validation<br>✓ Final testing | Full deployment ready |

### 🎯 Daily Goals

**Day 1**: Foundation - Both pages accessible with basic structure
**Day 2**: Listing Complete - Full designer directory functional
**Day 3**: Profile Routes - Individual designer pages working
**Day 4**: Content Rich - All designer information displaying
**Day 5**: Polish & Deploy - Gallery, forms, and production ready

---

## 6. Quick Reference Guide

### 🚀 Essential Commands

```bash
# Start development
cd /home/sk/fx/fashionos && pnpm dev

# View pages in development
http://localhost:3000/designers              # Listing page
http://localhost:3000/designers/[slug]       # Profile page

# Component locations
src/sections/_fashion/designers/             # All designer components
src/app/(fashion)/designers/                 # Page routes

# Quick deploy
git add . && git commit -m "feat: designer directory" && git push
```

### 📁 File Structure After Implementation

```
fashionos/
├── src/
│   ├── app/
│   │   └── (fashion)/
│   │       └── designers/
│   │           ├── page.tsx                 # Listing page
│   │           └── [slug]/
│   │               └── page.tsx             # Profile page
│   └── sections/
│       └── _fashion/
│           └── designers/
│               ├── fashion-designers-hero.tsx
│               ├── fashion-designers-filters.tsx
│               ├── fashion-designers-search.tsx
│               ├── fashion-designer-item.tsx
│               ├── fashion-designers-list.tsx
│               ├── fashion-designer-details-hero.tsx
│               ├── fashion-designer-details-tabs.tsx
│               ├── fashion-designer-details-gallery.tsx
│               └── fashion-designer-details-booking.tsx
```

### ✅ Testing Checklist

**Listing Page:**
- [ ] All designers display in grid
- [ ] Filters update results
- [ ] Search returns matches
- [ ] Pagination works
- [ ] Mobile responsive

**Profile Page:**
- [ ] Dynamic routes work
- [ ] All tabs have content
- [ ] Gallery displays images
- [ ] Booking form submits
- [ ] Social links open

### 🎯 Success Metrics

| Metric | Target | Measure |
|--------|--------|---------|
| Page Load | < 3s | Lighthouse |
| Mobile Score | > 95 | PageSpeed |
| Components Reused | > 90% | Code review |
| Custom Code | < 10% | New files |
| Time to Complete | 5 days | Sprint tracking |

---

**This task matrix guarantees success by:**
1. Breaking down every component change
2. Providing exact time estimates
3. Maintaining Zone UI structure
4. Testing at each phase
5. Following proven patterns

**Total Implementation Time: 40 hours (5 days × 8 hours)**