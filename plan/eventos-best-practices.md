# EventsOS Best Practices & Development Guidelines

## 🎯 Overview

This document establishes coding standards, architectural patterns, and best practices for EventsOS development. Following these guidelines ensures consistency, maintainability, and scalability.

---

## 🏗️ Architecture Principles

### 1. Separation of Concerns

```
apps/
├── website/          # Public-facing marketing and event discovery
│   ├── app/         # Next.js app router pages
│   ├── components/  # Page-specific components
│   └── lib/         # Page-specific utilities
│
├── admin/           # Internal admin dashboard
│   ├── app/         # Refine + Next.js pages
│   ├── components/  # Admin-specific components
│   └── providers/   # Admin-specific providers
│
packages/
├── ui/              # Shared UI components
├── database/        # Shared database client & queries
├── types/           # Shared TypeScript types
├── utils/           # Shared utilities
├── env/             # Environment configuration
└── config/          # Shared configuration
```

**Best Practice**: Keep shared code in packages, app-specific code in apps.

### 2. Data Flow Architecture

```typescript
// ✅ GOOD: Unidirectional data flow
Server (Supabase) 
  → Server Components (RSC)
    → Client Components (Hydration)
      → User Interaction
        → Server Action / API Route
          → Database Update
            → Real-time Update

// ❌ BAD: Direct database access from client
Client Component → Supabase Client → Database
```

### 3. Type Safety First

```typescript
// ✅ GOOD: Fully typed with Zod validation
import { z } from 'zod'

const EventSchema = z.object({
  title: z.string().min(3).max(100),
  description: z.string().optional(),
  startDate: z.date(),
  endDate: z.date(),
  capacity: z.number().int().positive(),
})

type Event = z.infer<typeof EventSchema>

export async function createEvent(data: unknown) {
  const validated = EventSchema.parse(data)
  // ... rest of logic
}

// ❌ BAD: Using 'any' or unvalidated data
export async function createEvent(data: any) {
  await supabase.from('events').insert(data)
}
```

---

## 💻 Coding Standards

### 1. TypeScript Guidelines

```typescript
// ✅ GOOD: Explicit types, no any
interface EventCardProps {
  event: Event
  onSelect?: (event: Event) => void
  variant?: 'default' | 'compact' | 'featured'
}

// ✅ GOOD: Type predicates for type narrowing
function isVIPEvent(event: Event): event is VIPEvent {
  return event.tier === 'vip' && event.vipFeatures != null
}

// ✅ GOOD: Const assertions for literals
const EVENT_TYPES = ['runway', 'trade-show', 'gala', 'pop-up'] as const
type EventType = typeof EVENT_TYPES[number]

// ❌ BAD: Implicit any, loose types
function processEvent(event) {
  return event.data.map(item => item.value)
}
```

### 2. React Best Practices

```typescript
// ✅ GOOD: Server Components by default
// app/events/page.tsx
export default async function EventsPage() {
  const events = await getEvents() // Server-side data fetching
  
  return (
    <div>
      {events.map(event => (
        <EventCard key={event.id} event={event} />
      ))}
    </div>
  )
}

// ✅ GOOD: Client Components only when needed
// components/EventCard.tsx
'use client'

export function EventCard({ event }: EventCardProps) {
  const [liked, setLiked] = useState(false) // Needs state
  
  return (
    <Card onClick={() => setLiked(!liked)}>
      {/* ... */}
    </Card>
  )
}

// ✅ GOOD: Custom hooks for logic reuse
function useEventBooking(eventId: string) {
  const [booking, setBooking] = useState<Booking | null>(null)
  const [isLoading, setIsLoading] = useState(false)
  
  const book = useCallback(async (tickets: number) => {
    setIsLoading(true)
    try {
      const result = await bookEvent(eventId, tickets)
      setBooking(result)
    } finally {
      setIsLoading(false)
    }
  }, [eventId])
  
  return { booking, isLoading, book }
}
```

### 3. State Management

```typescript
// ✅ GOOD: Server state with React Query/SWR
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'

function useEvents() {
  return useQuery({
    queryKey: ['events'],
    queryFn: fetchEvents,
    staleTime: 5 * 60 * 1000, // 5 minutes
  })
}

// ✅ GOOD: Optimistic updates
function useUpdateEvent() {
  const queryClient = useQueryClient()
  
  return useMutation({
    mutationFn: updateEvent,
    onMutate: async (newEvent) => {
      await queryClient.cancelQueries(['events', newEvent.id])
      const previousEvent = queryClient.getQueryData(['events', newEvent.id])
      queryClient.setQueryData(['events', newEvent.id], newEvent)
      return { previousEvent }
    },
    onError: (err, newEvent, context) => {
      queryClient.setQueryData(
        ['events', newEvent.id],
        context.previousEvent
      )
    },
    onSettled: () => {
      queryClient.invalidateQueries(['events'])
    },
  })
}

// ❌ BAD: Managing server state in React state
function EventsList() {
  const [events, setEvents] = useState([])
  
  useEffect(() => {
    fetch('/api/events').then(res => res.json()).then(setEvents)
  }, [])
  
  // No caching, no error handling, no loading state
}
```

### 4. Performance Patterns

```typescript
// ✅ GOOD: Lazy loading heavy components
const HeavyChart = dynamic(() => import('./HeavyChart'), {
  loading: () => <Skeleton />,
  ssr: false,
})

// ✅ GOOD: Image optimization
import Image from 'next/image'

export function EventHero({ image }: { image: string }) {
  return (
    <Image
      src={image}
      alt="Event"
      width={1200}
      height={600}
      priority
      placeholder="blur"
      blurDataURL={generateBlurDataURL()}
    />
  )
}

// ✅ GOOD: Debounced search
function SearchEvents() {
  const [query, setQuery] = useState('')
  const debouncedQuery = useDebounce(query, 300)
  
  const { data } = useQuery({
    queryKey: ['events', 'search', debouncedQuery],
    queryFn: () => searchEvents(debouncedQuery),
    enabled: debouncedQuery.length > 2,
  })
  
  return (
    <input
      value={query}
      onChange={(e) => setQuery(e.target.value)}
      placeholder="Search events..."
    />
  )
}
```

---

## 🔒 Security Best Practices

### 1. Authentication & Authorization

```typescript
// ✅ GOOD: Server-side auth check
// app/api/events/route.ts
export async function POST(request: Request) {
  const session = await getServerSession()
  
  if (!session) {
    return new Response('Unauthorized', { status: 401 })
  }
  
  const { user } = session
  const data = await request.json()
  
  // Validate user has permission
  if (!canCreateEvent(user)) {
    return new Response('Forbidden', { status: 403 })
  }
  
  // Validate and sanitize input
  const validated = EventSchema.parse(data)
  
  // Associate with user
  const event = await createEvent({
    ...validated,
    organizationId: user.organizationId,
    createdBy: user.id,
  })
  
  return Response.json(event)
}

// ❌ BAD: Client-side only auth
function CreateEvent() {
  const { user } = useAuth() // Client-side check only
  
  if (!user) return null // Easily bypassed
  
  // ... rest of component
}
```

### 2. Data Validation

```typescript
// ✅ GOOD: Validate at every boundary
// 1. Client-side for UX
const schema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
})

// 2. API route for security
export async function POST(req: Request) {
  const body = await req.json()
  const validated = schema.parse(body) // Throws on invalid
  
  // 3. Database constraints as final guard
  // Defined in Supabase/PostgreSQL
}

// ✅ GOOD: Sanitize user content
import DOMPurify from 'isomorphic-dompurify'

function EventDescription({ html }: { html: string }) {
  const clean = DOMPurify.sanitize(html, {
    ALLOWED_TAGS: ['p', 'br', 'strong', 'em', 'a'],
    ALLOWED_ATTR: ['href', 'target'],
  })
  
  return <div dangerouslySetInnerHTML={{ __html: clean }} />
}
```

### 3. API Security

```typescript
// ✅ GOOD: Rate limiting with proper headers
import { rateLimit } from '@/lib/rate-limit'

const limiter = rateLimit({
  interval: 60 * 1000, // 1 minute
  uniqueTokenPerInterval: 500,
})

export async function POST(request: Request) {
  const ip = request.headers.get('x-forwarded-for') ?? 'unknown'
  
  try {
    await limiter.check(10, ip) // 10 requests per minute
  } catch {
    return new Response('Too Many Requests', {
      status: 429,
      headers: {
        'Retry-After': '60',
        'X-RateLimit-Limit': '10',
        'X-RateLimit-Remaining': '0',
        'X-RateLimit-Reset': new Date(Date.now() + 60000).toISOString(),
      },
    })
  }
  
  // Process request
}
```

---

## 🚀 Performance Guidelines

### 1. Database Queries

```typescript
// ✅ GOOD: Optimized queries with proper indexes
const events = await supabase
  .from('events')
  .select(`
    id,
    title,
    start_date,
    organization:organizations(name, logo)
  `)
  .eq('status', 'published')
  .gte('start_date', new Date().toISOString())
  .order('start_date', { ascending: true })
  .limit(20)

// ✅ GOOD: Batch operations
const bookings = await supabase
  .from('bookings')
  .insert(multipleBookings)
  .select()

// ❌ BAD: N+1 queries
const events = await supabase.from('events').select('*')
for (const event of events.data) {
  const org = await supabase
    .from('organizations')
    .select('*')
    .eq('id', event.organization_id)
    .single()
  event.organization = org.data
}
```

### 2. Caching Strategy

```typescript
// ✅ GOOD: Multi-layer caching
// 1. Browser cache for static assets
export const config = {
  api: {
    responseLimit: false,
  },
}

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url)
  const eventId = searchParams.get('id')
  
  // 2. Edge cache for dynamic content
  const headers = {
    'Cache-Control': 's-maxage=60, stale-while-revalidate=59',
  }
  
  // 3. Database cache via Redis
  const cached = await redis.get(`event:${eventId}`)
  if (cached) {
    return new Response(cached, { headers })
  }
  
  // 4. Fetch and cache
  const event = await getEvent(eventId)
  await redis.set(`event:${eventId}`, JSON.stringify(event), 'EX', 60)
  
  return Response.json(event, { headers })
}
```

### 3. Bundle Optimization

```typescript
// ✅ GOOD: Tree-shakeable exports
// packages/ui/src/index.ts
export { Button } from './components/Button'
export { Card } from './components/Card'
// NOT: export * from './components'

// ✅ GOOD: Lazy load heavy dependencies
const QRCode = dynamic(() => import('react-qr-code'), {
  loading: () => <div>Loading QR...</div>,
})

// ✅ GOOD: Optimize third-party imports
import debounce from 'lodash/debounce' // ❌ 70KB
import debounce from 'lodash-es/debounce' // ✅ 3KB
```

---

## 🧪 Testing Standards

### 1. Test Structure

```typescript
// ✅ GOOD: AAA pattern with clear naming
describe('EventBooking', () => {
  describe('when booking VIP tickets', () => {
    it('should apply VIP discount for early birds', async () => {
      // Arrange
      const event = createMockEvent({ tier: 'vip' })
      const user = createMockUser({ isEarlyBird: true })
      
      // Act
      const booking = await bookEvent(event, user, { tickets: 2 })
      
      // Assert
      expect(booking.discount).toBe(0.2)
      expect(booking.total).toBe(160) // $200 - 20%
    })
  })
})

// ✅ GOOD: Test business logic, not implementation
it('should prevent overbooking', async () => {
  const event = createMockEvent({ capacity: 100, booked: 99 })
  
  await expect(
    bookEvent(event, user, { tickets: 2 })
  ).rejects.toThrow('Insufficient capacity')
})
```

### 2. Component Testing

```typescript
// ✅ GOOD: Test user behavior, not implementation
import { render, screen, userEvent } from '@/test/utils'

test('user can filter events by date', async () => {
  const user = userEvent.setup()
  render(<EventList />)
  
  // User opens filter
  await user.click(screen.getByRole('button', { name: /filter/i }))
  
  // User selects date range
  await user.click(screen.getByLabelText(/start date/i))
  await user.click(screen.getByRole('gridcell', { name: '15' }))
  
  // User applies filter
  await user.click(screen.getByRole('button', { name: /apply/i }))
  
  // Verify filtered results
  expect(screen.getByText(/showing 5 events/i)).toBeInTheDocument()
})
```

---

## 📁 File Organization

### 1. Component Structure

```
components/
├── EventCard/
│   ├── EventCard.tsx           # Main component
│   ├── EventCard.test.tsx      # Tests
│   ├── EventCard.stories.tsx   # Storybook
│   ├── EventCard.module.css    # Styles (if needed)
│   └── index.ts               # Barrel export
```

### 2. Feature Structure

```
app/
├── (marketing)/               # Route group
│   ├── layout.tsx            # Shared layout
│   ├── page.tsx              # Homepage
│   └── about/
│       └── page.tsx
├── (dashboard)/              # Auth-protected group
│   ├── layout.tsx           # Dashboard layout
│   ├── events/
│   │   ├── page.tsx         # List view
│   │   ├── [id]/
│   │   │   └── page.tsx     # Detail view
│   │   └── create/
│   │       └── page.tsx     # Create form
```

---

## 🔄 Git Workflow

### 1. Branch Strategy

```bash
main          # Production-ready code
├── develop   # Integration branch
    ├── feature/add-payment-flow
    ├── fix/event-date-validation
    └── chore/update-dependencies
```

### 2. Commit Messages

```bash
# ✅ GOOD: Conventional commits
feat(events): add QR code generation for tickets
fix(auth): resolve session timeout on mobile
docs(api): update event endpoint documentation
test(booking): add edge case tests for capacity
refactor(ui): extract EventCard to shared package
perf(images): implement lazy loading for galleries

# ❌ BAD: Unclear commits
updated stuff
fix
WIP
```

### 3. Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex logic
- [ ] Documentation updated
- [ ] No console.logs left
```

---

## 🚀 Deployment Best Practices

### 1. Environment Management

```typescript
// ✅ GOOD: Validated environment variables
import { env } from '@eventos/env'

// Type-safe, validated at build time
const supabaseUrl = env.NEXT_PUBLIC_SUPABASE_URL

// ❌ BAD: Direct process.env access
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || ''
```

### 2. Feature Flags

```typescript
// ✅ GOOD: Gradual rollout with feature flags
import { flags } from '@eventos/config'

export function EventPage() {
  return (
    <div>
      <EventDetails />
      {flags.enableComments && <EventComments />}
      {flags.enableLiveStream && <LiveStreamPlayer />}
    </div>
  )
}
```

### 3. Error Handling

```typescript
// ✅ GOOD: Graceful degradation
export default function EventsPage() {
  return (
    <ErrorBoundary
      fallback={<EventsErrorFallback />}
      onError={(error) => {
        console.error('Events page error:', error)
        Sentry.captureException(error)
      }}
    >
      <Suspense fallback={<EventsSkeleton />}>
        <EventsList />
      </Suspense>
    </ErrorBoundary>
  )
}
```

---

## 📚 Resources & References

### Official Documentation
- [Next.js 14 Docs](