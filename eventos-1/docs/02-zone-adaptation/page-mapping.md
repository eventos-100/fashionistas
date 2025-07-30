# 🗺️ Zone Travel → EventsOS Page Mapping Strategy
## Complete Guide to Safe Template Adaptation

---

## 🎯 **Mapping Philosophy**

**Core Principle**: Maintain all existing functionality while changing only content and styling. Never break the underlying component structure.

**Success Criteria**: 
- ✅ All pages load without errors
- ✅ All interactive elements work  
- ✅ Mobile responsiveness preserved
- ✅ Performance maintained
- ✅ Event content feels natural

---

## 📋 **Complete Page Mapping Matrix**

### Travel Section → Events Section

| Original Path | New Concept | Content Changes | Component Changes | Risk Level |
|---------------|-------------|-----------------|-------------------|------------|
| `/travel/` | Events Homepage | Hero text, images, stats | None | 🟢 Zero |
| `/travel/tours` | Events Listing | Tour cards → Event cards | Card content only | 🟢 Zero |
| `/travel/tours/[id]` | Event Details | Tour info → Event info | Content structure | 🟡 Low |
| `/travel/about` | About Platform | Company story → Platform story | Text only | 🟢 Zero |
| `/travel/contact` | Contact Us | Travel contact → Platform contact | Form labels | 🟢 Zero |
| `/travel/checkout` | Event Registration | Booking → Registration | Form fields | 🟡 Low |
| `/travel/posts` | Fashion News | Travel blog → Fashion news | Content only | 🟢 Zero |

---

## 🏠 **Page 1: Homepage Transformation**

### File: `src/app/travel/(landing)/page.jsx`

#### Hero Section Mapping
```jsx
// BEFORE - Travel Hero
{
  title: "Discover Amazing Destinations",
  subtitle: "Best tours and travel experiences", 
  backgroundImage: "/assets/images/travel/hero-destination.jpg",
  ctaText: "Explore Tours"
}

// AFTER - Events Hero  
{
  title: "Discover Exclusive Fashion Events",
  subtitle: "Premier fashion shows and industry experiences",
  backgroundImage: "/assets/images/events/hero-fashion-show.jpg", 
  ctaText: "Explore Events"
}
```

#### Statistics Section Mapping
```jsx
// BEFORE - Travel Stats
{
  destinations: "120+ Destinations",
  tours: "20k+ Tours", 
  customers: "15+ Countries",
  rating: "4.8/5 Rating"
}

// AFTER - Events Stats
{
  events: "120+ Annual Events",
  attendees: "20k+ Attendees",
  cities: "15+ Fashion Capitals", 
  rating: "4.8/5 Rating"
}
```

#### Features Section Mapping
```jsx
// BEFORE - Travel Features
[
  {
    icon: "🗺️",
    title: "Expert Local Guides",
    description: "Professional guides with local knowledge"
  },
  {
    icon: "💰", 
    title: "Best Price Guarantee",
    description: "We match any competitor's price"
  },
  {
    icon: "🛡️",
    title: "Trusted Platform",
    description: "Secure booking and payment processing"
  }
]

// AFTER - Events Features
[
  {
    icon: "🎭",
    title: "Exclusive Industry Access", 
    description: "Direct access to premier fashion events"
  },
  {
    icon: "🎫",
    title: "Premium Ticket Options",
    description: "VIP packages and backstage experiences"
  },
  {
    icon: "🔒",
    title: "Secure Platform",
    description: "Safe registration and payment processing"
  }
]
```

---

## 📋 **Page 2: Events Listing Transformation**

### File: `src/app/travel/tours/page.jsx`

#### Filter Sidebar Mapping
```jsx
// BEFORE - Travel Filters
{
  destination: ["Europe", "Asia", "Americas", "Africa"],
  duration: ["1-3 days", "4-7 days", "1-2 weeks", "2+ weeks"],
  priceRange: [0, 500, 1000, 2000, 5000],
  rating: [3, 4, 5],
  tourType: ["Adventure", "Cultural", "Relaxation", "Family"]
}

// AFTER - Events Filters  
{
  eventType: ["Fashion Show", "Trade Show", "Gala", "Pop-up"],
  duration: ["2-4 hours", "Half day", "Full day", "Multi-day"],
  priceRange: [0, 100, 300, 500, 1000],
  rating: [3, 4, 5],
  category: ["Runway", "Networking", "Exhibition", "Awards"]
}
```

#### Event Card Mapping
```jsx
// BEFORE - Tour Card
{
  image: "/assets/images/travel/tour-paris.jpg",
  title: "Paris City Tour", 
  destination: "Paris, France",
  duration: "5 days",
  price: "$899",
  rating: 4.8,
  reviews: 124,
  highlights: ["Eiffel Tower", "Louvre", "Notre Dame"]
}

// AFTER - Event Card
{
  image: "/assets/images/events/paris-fashion-week.jpg", 
  title: "Paris Fashion Week 2025",
  location: "Paris, France", 
  duration: "3 days",
  price: "$599",
  rating: 4.8,
  attendees: 124,
  highlights: ["Runway Shows", "Designer Meetups", "VIP Access"]
}
```

---

## 🎫 **Page 3: Event Details Transformation**

### File: `src/app/travel/tours/[id]/page.jsx`

#### Event Information Mapping
```jsx
// BEFORE - Tour Details
{
  title: "Magical Paris Adventure",
  gallery: ["/tour-1.jpg", "/tour-2.jpg"],
  description: "Explore the beauty of Paris...",
  duration: "5 days, 4 nights",
  groupSize: "Max 12 people", 
  difficulty: "Easy",
  includes: ["Hotel", "Meals", "Guide"],
  itinerary: [
    {day: 1, title: "Arrival", activities: ["Check-in", "City tour"]}
  ]
}

// AFTER - Event Details
{
  title: "Milan Fashion Week Spring 2025",
  gallery: ["/event-1.jpg", "/event-2.jpg"], 
  description: "Experience the latest in fashion...",
  duration: "3 days",
  capacity: "Max 200 attendees",
  dressCode: "Cocktail attire",
  includes: ["Welcome reception", "Show access", "Networking"],
  schedule: [
    {day: 1, title: "Opening Day", activities: ["Registration", "Opening show"]}
  ]
}
```

#### Registration Form Mapping
```jsx
// BEFORE - Booking Form
{
  travelers: {
    adults: {min: 1, max: 8},
    children: {min: 0, max: 4}
  },
  travelDates: {
    departure: "date",
    return: "date"
  },
  roomPreference: ["Single", "Double", "Triple"],
  specialRequests: "textarea"
}

// AFTER - Registration Form
{
  attendees: {
    quantity: {min: 1, max: 4},
    additionalGuests: {min: 0, max: 2}
  },
  eventDates: {
    selectedDays: ["Day 1", "Day 2", "Day 3"]
  },
  ticketType: ["General", "VIP", "Backstage Pass"],
  dietaryRequirements: "textarea",
  specialAccess: "textarea"
}
```

---

## 🛒 **Page 4: Checkout/Registration Transformation**

### File: `src/app/travel/checkout/page.jsx`

#### Booking Summary → Registration Summary
```jsx
// BEFORE - Travel Booking
{
  trip: {
    name: "Paris Adventure",
    dates: "March 15-20, 2024",
    travelers: "2 Adults",
    accommodation: "4-star hotel"
  },
  pricing: {
    tourPrice: 1599,
    taxes: 200,
    total: 1799
  }
}

// AFTER - Event Registration  
{
  event: {
    name: "Milan Fashion Week",
    dates: "March 15-17, 2024", 
    attendees: "2 People",
    ticketType: "VIP Access"
  },
  pricing: {
    ticketPrice: 899,
    fees: 100,
    total: 999
  }
}
```

#### Payment Form Mapping (Keep Structure)
```jsx
// Keep existing payment form structure
// Only change labels and validation messages
{
  billingInfo: "Contact Information", // was "Billing Information"
  cardDetails: "Payment Details",     // unchanged
  specialInstructions: "Event Preferences" // was "Travel Preferences"
}
```

---

## ℹ️ **Page 5: About Page Transformation**

### File: `src/app/travel/about/page.jsx`

#### Company Story → Platform Story
```jsx
// BEFORE - Travel Company
{
  title: "About Our Travel Company",
  mission: "We make travel accessible and memorable",
  story: "Founded in 2020, we've helped thousands explore...",
  values: ["Adventure", "Safety", "Authenticity"],
  team: "25+ travel experts"
}

// AFTER - Platform Story
{
  title: "About EventsOS Platform", 
  mission: "We connect fashion enthusiasts with exclusive events",
  story: "Founded in 2025, we've revolutionized fashion event access...",
  values: ["Exclusivity", "Quality", "Innovation"],
  team: "25+ fashion industry experts"
}
```

---

## 📞 **Page 6: Contact Page Transformation**

### File: `src/app/travel/contact/page.jsx`

#### Contact Form Mapping
```jsx
// BEFORE - Travel Inquiries
{
  subjects: [
    "General Inquiry",
    "Booking Support", 
    "Custom Tour Request",
    "Travel Insurance"
  ],
  departments: [
    "Sales", "Support", "Partnerships"
  ]
}

// AFTER - Event Inquiries
{
  subjects: [
    "General Inquiry",
    "Event Information",
    "VIP Package Request", 
    "Corporate Events"
  ],
  departments: [
    "Sales", "Support", "Event Planning"
  ]
}
```

---

## 📰 **Page 7: Blog/News Transformation** 

### File: `src/app/travel/posts/page.jsx`

#### Content Categories Mapping
```jsx
// BEFORE - Travel Blog
{
  categories: [
    "Destinations", 
    "Travel Tips",
    "Cultural Experiences", 
    "Food & Dining"
  ],
  postTypes: ["Guide", "Review", "Tips", "Story"]
}

// AFTER - Fashion News
{
  categories: [
    "Fashion Weeks",
    "Industry News", 
    "Designer Profiles",
    "Event Highlights" 
  ],
  postTypes: ["Report", "Interview", "Review", "Trend"]
}
```

---

## 🔧 **Implementation Strategy**

### Phase 1: Safe Text Replacements (Day 1)
```bash
# Global find and replace (safe)
cd /home/sk/fx/eventos/zone-template/src

# Replace common terms
find . -name "*.jsx" -type f -exec sed -i 's/Travel/Fashion Events/g' {} \;
find . -name "*.jsx" -type f -exec sed -i 's/Tour/Event/g' {} \;
find . -name "*.jsx" -type f -exec sed -i 's/Destination/Location/g' {} \;

# Note: Test after each change
```

### Phase 2: Content Structure Updates (Day 2-3)
1. **Update data objects** in each page component
2. **Modify form field labels** and validation
3. **Change navigation text** and breadcrumbs
4. **Update meta tags** and SEO content

### Phase 3: Asset Replacement (Day 4-5)
1. **Replace hero images** with fashion event photos
2. **Update card images** for event listings
3. **Change icons** to fashion-relevant symbols
4. **Update logos** and branding elements

---

## ✅ **Quality Assurance Checklist**

### After Each Page Adaptation

#### Functionality Check
- [ ] Page loads without errors
- [ ] All links work correctly
- [ ] Forms submit properly (test with dummy data)
- [ ] Navigation between pages works
- [ ] Search and filter functions work
- [ ] Mobile view displays correctly

#### Content Check
- [ ] All travel references changed to events
- [ ] Images are appropriate for fashion events
- [ ] Text flows naturally (no awkward phrasing)
- [ ] Call-to-action buttons make sense
- [ ] Contact information is updated
- [ ] Legal/terms pages reference events not travel

#### Performance Check
- [ ] Page load time under 3 seconds
- [ ] Images optimized and loading
- [ ] No console errors in browser
- [ ] Lighthouse score maintained (90+)
- [ ] Mobile performance good

---

## 🚨 **Common Pitfalls to Avoid**

### Don't Change These
❌ **Component file structure** - Keep all files in same locations  
❌ **Function names** - Keep existing function signatures  
❌ **CSS class names** - Don't modify existing classes  
❌ **Route structure** - Keep URL paths unless absolutely necessary  
❌ **State management** - Don't change how data flows  

### Safe to Change
✅ **Text content** - All copy and labels  
✅ **Image sources** - Replace with event photos  
✅ **Data objects** - Update object properties  
✅ **Form field options** - Change dropdown values  
✅ **Color variables** - Update theme colors  

---

## 📊 **Progress Tracking**

### Week 1 Goals
- [ ] Homepage completely adapted to events
- [ ] Events listing page functional
- [ ] Event details page shows correct content
- [ ] About page tells EventsOS story
- [ ] Contact form works for event inquiries

### Week 2 Goals  
- [ ] Registration/checkout flow complete
- [ ] All navigation updated
- [ ] Mobile experience optimized
- [ ] Performance scores maintained
- [ ] Ready for user testing

**🎯 Success Metric**: A new user should see a fashion events platform, not a travel site, but all functionality should work exactly the same.

---

**📝 Next Steps**:
1. [Content Replacement Guide](content-guide.md) - Detailed content changes
2. [Asset Replacement Guide](asset-replacement.md) - Images and branding
3. [Component Modifications](component-changes.md) - Safe component updates
