# 🎨 EventsOS Component Architecture - MUI v6 Component Mapping

## 📊 Master Component Usage Matrix

### Component Priority Legend
- 🔴 **Critical** - Core functionality depends on it
- 🟡 **Important** - Enhances user experience significantly  
- 🟢 **Nice-to-have** - Polish and additional features

---

## 🏠 Homepage Components

| Section | MUI Components | Priority | Implementation Notes | Performance Tips |
|---------|---------------|----------|---------------------|------------------|
| **Navigation Header** | `AppBar`, `Toolbar`, `IconButton`, `Drawer`, `Menu` | 🔴 | Sticky positioning, transparent on scroll | Use `useMemo` for menu items |
| **Hero Section** | `Box`, `Container`, `Typography`, `Button`, `Fade` | 🔴 | Full viewport height, video background | Lazy load background media |
| **Featured Events** | `Grid`, `Card`, `CardMedia`, `CardContent`, `Chip`, `Skeleton` | 🔴 | 3-column responsive grid | Virtualize if > 20 items |
| **Fashion Calendar** | `Box`, `IconButton`, `Typography`, `Tooltip`, Custom Carousel | 🟡 | Horizontal scroll on mobile | Use CSS scroll-snap |
| **Designer Spotlight** | `Card`, `Avatar`, `Rating`, `CardActions`, Swiper integration | 🟡 | Auto-play carousel | Preload next 2 slides |
| **Statistics** | `Paper`, `Typography`, `Box`, `LinearProgress`, CountUp lib | 🟢 | Animate on viewport entry | Use Intersection Observer |
| **Testimonials** | `Card`, `Avatar`, `Typography`, `Rating`, `Fade` | 🟢 | Quote carousel with dots | Pause on hover |
| **Newsletter** | `TextField`, `Button`, `Alert`, `CircularProgress` | 🟡 | Email validation, loading states | Debounce input |
| **Instagram Feed** | `ImageList`, `ImageListItem`, `Skeleton`, `Box` | 🟢 | 6-image grid, hover overlay | Lazy load images |
| **Footer** | `Box`, `Grid`, `Link`, `IconButton`, `Divider` | 🔴 | Multi-column layout | Static content |

### Homepage Best Practices
```typescript
// Optimal import strategy for homepage
import { 
  AppBar, 
  Toolbar, 
  Container, 
  Grid, 
  Card, 
  Button 
} from '@mui/material';

// Lazy load heavy sections
const Statistics = lazy(() => import('./sections/Statistics'));
const InstagramFeed = lazy(() => import('./sections/InstagramFeed'));
```

---

## 📅 Events Page Components

| Section | MUI Components | Priority | Implementation Notes | Performance Tips |
|---------|---------------|----------|---------------------|------------------|
| **Filter Sidebar** | `Drawer`, `List`, `ListItem`, `Checkbox`, `Slider`, `Autocomplete` | 🔴 | Collapsible on mobile | Memoize filter logic |
| **Search Bar** | `TextField`, `InputAdornment`, `IconButton`, `Autocomplete` | 🔴 | Instant search with debounce | Use React.memo |
| **Event Grid** | `Grid`, `Card`, `CardMedia`, `Chip`, `Pagination` | 🔴 | Responsive 3/2/1 columns | Virtual scrolling |
| **View Toggle** | `ToggleButtonGroup`, `ToggleButton`, `Icon` | 🟡 | Grid/List view switch | Persist preference |
| **Sort Controls** | `Select`, `MenuItem`, `FormControl` | 🟡 | Sort by date/price/popularity | Cache sorted results |
| **Event Cards** | `Card`, `CardMedia`, `CardContent`, `Button`, `Tooltip` | 🔴 | Hover effects, quick actions | Optimize images |
| **No Results** | `Box`, `Typography`, `Button`, `SvgIcon` | 🟢 | Empty state illustration | Static component |
| **Loading States** | `Skeleton`, `CircularProgress`, `LinearProgress` | 🔴 | Show while fetching | Use suspense |

### Events Page Data Grid Example
```typescript
// For admin view of events
import { DataGrid } from '@mui/x-data-grid';

const columns = [
  { field: 'title', headerName: 'Event', width: 200 },
  { field: 'date', headerName: 'Date', width: 130, type: 'date' },
  { field: 'venue', headerName: 'Venue', width: 150 },
  { field: 'capacity', headerName: 'Capacity', width: 100, type: 'number' },
  { field: 'ticketsSold', headerName: 'Sold', width: 100, type: 'number' },
];
```

---

## 🎫 Event Detail Page Components

| Section | MUI Components | Priority | Implementation Notes | Performance Tips |
|---------|---------------|----------|---------------------|------------------|
| **Image Gallery** | `Box`, `ImageList`, `Dialog`, `IconButton`, `Zoom` | 🔴 | Lightbox functionality | Progressive loading |
| **Event Info** | `Typography`, `Chip`, `Box`, `Divider` | 🔴 | Structured data display | Static content |
| **Date/Time** | `Box`, `Icon`, `Typography`, `Tooltip` | 🔴 | Timezone conversion | Cache calculations |
| **Ticket Selection** | `RadioGroup`, `Radio`, `Paper`, `Typography` | 🔴 | Tier comparison | Highlight best value |
| **Quantity Picker** | `ButtonGroup`, `Button`, `Typography` | 🔴 | +/- controls with limits | Validate client-side |
| **Price Summary** | `Table`, `TableRow`, `TableCell`, `Typography` | 🟡 | Dynamic calculation | Use React.useMemo |
| **RSVP Form** | `Dialog`, `TextField`, `Button`, `Stepper` | 🔴 | Multi-step checkout | Save progress |
| **Share Buttons** | `SpeedDial`, `SpeedDialAction`, `Icon` | 🟢 | Social sharing options | Load on interaction |
| **Related Events** | `Box`, `Card`, `Grid`, `Typography` | 🟡 | Similar events carousel | Preload on idle |

---

## 👗 Designers Page Components

| Section | MUI Components | Priority | Implementation Notes | Performance Tips |
|---------|---------------|----------|---------------------|------------------|
| **Designer Search** | `Autocomplete`, `TextField`, `Avatar` | 🔴 | Async search with photos | Debounce 300ms |
| **Filter Tags** | `Chip`, `Box`, `Stack` | 🟡 | Category filters | Toggle multiple |
| **Designer Grid** | `Grid`, `Card`, `CardMedia`, `CardContent` | 🔴 | Photo-heavy layout | Lazy load images |
| **Designer Card** | `Card`, `Avatar`, `Typography`, `Button`, `Rating` | 🔴 | Profile preview | Optimize thumbnails |
| **Quick View** | `Dialog`, `DialogContent`, `IconButton` | 🟡 | Modal preview | Load on demand |
| **Sort Options** | `Select`, `MenuItem`, `FormControl` | 🟢 | A-Z, popularity, new | Simple sort |

---

## 🖼️ Gallery Page Components

| Section | MUI Components | Priority | Implementation Notes | Performance Tips |
|---------|---------------|----------|---------------------|------------------|
| **Filter Bar** | `AppBar`, `Tabs`, `Tab`, `Badge` | 🟡 | Category filters | Show counts |
| **Masonry Grid** | `ImageList` (masonry), `ImageListItem` | 🔴 | Pinterest-style layout | Virtual scrolling |
| **Image Card** | `Card`, `CardMedia`, `IconButton`, `Backdrop` | 🔴 | Hover actions | Low-res placeholders |
| **Lightbox** | `Dialog`, `Box`, `IconButton`, `Zoom` | 🔴 | Full-screen view | Preload adjacent |
| **Download Options** | `Menu`, `MenuItem`, `ListItemIcon` | 🟢 | Resolution choices | Track downloads |

---

## 🤝 Sponsors Page Components

| Section | MUI Components | Priority | Implementation Notes | Performance Tips |
|---------|---------------|----------|---------------------|------------------|
| **Tier Comparison** | `Table`, `TableHead`, `TableBody`, `Chip` | 🔴 | Feature matrix | Static table |
| **Sponsor Logos** | `Grid`, `Paper`, `Box`, `Tooltip` | 🔴 | Logo grid with links | Optimize SVGs |
| **Benefits List** | `List`, `ListItem`, `ListItemIcon`, `Icon` | 🟡 | Checkmark lists | Use CSS grid |
| **CTA Section** | `Box`, `Button`, `Typography` | 🔴 | Contact forms | Track clicks |
| **Testimonials** | `Card`, `Avatar`, `Typography`, `Rating` | 🟢 | Sponsor quotes | Rotate display |

---

## 📰 Press/Blog Components

| Section | MUI Components | Priority | Implementation Notes | Performance Tips |
|---------|---------------|----------|---------------------|------------------|
| **Article List** | `List`, `ListItem`, `ListItemText`, `Divider` | 🔴 | Blog post index | Paginate |
| **Article Card** | `Card`, `CardMedia`, `CardContent`, `Chip` | 🔴 | Preview cards | Excerpt only |
| **Category Filter** | `Tabs`, `Tab`, `Box` | 🟡 | Topic filtering | URL params |
| **Search** | `TextField`, `InputAdornment`, `IconButton` | 🟡 | Full-text search | Server-side |
| **Share Tools** | `SpeedDial`, `SpeedDialAction` | 🟢 | Social sharing | Load on hover |

---

## 📞 Contact Page Components

| Section | MUI Components | Priority | Implementation Notes | Performance Tips |
|---------|---------------|----------|---------------------|------------------|
| **Contact Form** | `TextField`, `Button`, `Alert`, `Box` | 🔴 | Multi-field form | Client validation |
| **Map** | `Box`, `Paper`, External map lib | 🟡 | Venue location | Lazy load map |
| **Info Cards** | `Card`, `CardContent`, `Icon`, `Typography` | 🔴 | Address, hours, phone | Static content |
| **FAQ Accordion** | `Accordion`, `AccordionSummary`, `AccordionDetails` | 🟡 | Common questions | Expand one only |
| **Social Links** | `IconButton`, `Tooltip`, `Box` | 🟢 | Social media icons | External links |

---

## 🔐 Authentication Components

| Section | MUI Components | Priority | Implementation Notes | Performance Tips |
|---------|---------------|----------|---------------------|------------------|
| **Login Modal** | `Dialog`, `TextField`, `Button`, `Link` | 🔴 | Email/password form | Auto-focus |
| **Social Login** | `Button`, `Box`, `Divider` | 🟡 | OAuth providers | Load on demand |
| **Register Form** | `Stepper`, `TextField`, `Checkbox` | 🔴 | Multi-step signup | Save progress |
| **Password Reset** | `Dialog`, `TextField`, `Alert` | 🟡 | Email verification | Clear messaging |
| **Profile Menu** | `Menu`, `MenuItem`, `Avatar`, `Divider` | 🔴 | User dropdown | Cache avatar |

---

## 🎯 Component Usage Best Practices

### 1. Import Optimization
```typescript
// ❌ Bad - Imports entire library
import * as MUI from '@mui/material';

// ✅ Good - Tree-shakeable imports
import Button from '@mui/material/Button';
import { Card, CardContent } from '@mui/material';
```

### 2. Theme-Aware Components
```typescript
// Use sx prop for theme-aware styling
<Button
  sx={{
    bgcolor: 'primary.main',
    '&:hover': {
      bgcolor: 'primary.dark',
    },
    // Responsive styles
    px: { xs: 2, sm: 3, md: 4 },
  }}
>
  RSVP Now
</Button>
```

### 3. Performance Patterns
```typescript
// Lazy load heavy components
const DataGrid = lazy(() => 
  import('@mui/x-data-grid').then(module => ({ 
    default: module.DataGrid 
  }))
);

// Memoize expensive renders
const ExpensiveList = memo(({ items }) => (
  <List>
    {items.map(item => (
      <ListItem key={item.id}>{item.name}</ListItem>
    ))}
  </List>
));
```

### 4. Accessibility Requirements
```typescript
// Always include ARIA labels
<IconButton
  aria-label="open navigation menu"
  onClick={handleMenuOpen}
>
  <MenuIcon />
</IconButton>

// Keyboard navigation
<Dialog
  onClose={handleClose}
  onKeyDown={(e) => {
    if (e.key === 'Escape') handleClose();
  }}
>
```

### 5. Mobile-First Approach
```typescript
// Responsive breakpoints
<Grid container spacing={{ xs: 2, sm: 3, md: 4 }}>
  <Grid item xs={12} sm={6} md={4}>
    <Card />
  </Grid>
</Grid>

// Touch-friendly targets (min 48px)
<Button
  sx={{
    minHeight: 48,
    minWidth: 48,
  }}
>
```

---

## 📦 Bundle Size Optimization

### Component Bundle Impact
| Component | Size (gzipped) | Alternative |
|-----------|---------------|-------------|
| DataGrid | ~90KB | Table + custom pagination |
| DatePicker | ~45KB | Native input type="date" |
| Autocomplete | ~25KB | TextField + Popper |
| Icons (all) | ~170KB | Use individual imports |

### Optimization Strategies
1. **Dynamic Imports**: Load DataGrid only on admin pages
2. **Icon Optimization**: Import only used icons
3. **Code Splitting**: Separate vendor chunks
4. **Tree Shaking**: Ensure proper imports

---

## 🚀 Vercel Deployment Optimizations

### Build Configuration
```javascript
// next.config.js
module.exports = {
  transpilePackages: ['@mui/material', '@mui/icons-material'],
  modularizeImports: {
    '@mui/material': {
      transform: '@mui/material/{{member}}',
    },
    '@mui/icons-material': {
      transform: '@mui/icons-material/{{member}}',
    },
  },
};
```

### Performance Monitoring
- Enable Vercel Analytics
- Set up Speed Insights
- Monitor Core Web Vitals
- Track component render times

This comprehensive component mapping ensures optimal use of MUI v6 components across all EventsOS pages while maintaining performance and following best practices for Vercel deployment.