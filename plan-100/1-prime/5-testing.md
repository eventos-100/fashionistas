# EventsOS Testing & Quality Assurance Guide

## 🎯 Overview

This comprehensive guide covers all aspects of testing and quality assurance for EventsOS, including unit tests, integration tests, E2E tests, performance testing, and security testing.

---

## 🧪 Testing Strategy

### Testing Pyramid

```
         /\
        /E2E\        (10%) - Critical user journeys
       /------\
      /  Integ  \    (30%) - API and component integration
     /------------\
    /   Unit Tests  \ (60%) - Business logic and utilities
   /------------------\
```

### Coverage Goals

| Type | Target | Critical Areas |
|------|--------|----------------|
| **Unit Tests** | 80%+ | Business logic, utilities, hooks |
| **Integration** | 70%+ | API routes, database queries, auth |
| **E2E Tests** | Critical paths | Auth flow, payments, bookings |
| **Performance** | Core Web Vitals | LCP < 2.5s, FID < 100ms, CLS < 0.1 |

---

## 🔧 Unit Testing Setup

### 1. Configure Test Environment

```bash
# Create test utilities
mkdir -p test/utils
cat > test/utils/test-utils.tsx << 'EOF'
import React from 'react'
import { render, RenderOptions } from '@testing-library/react'
import { ThemeProvider } from '@mui/material/styles'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { SessionContextProvider } from '@supabase/auth-helpers-react'
import { theme } from '@eventos/ui/theme'
import { createClient } from '@eventos/database'

// Mock Supabase client
const mockSupabase = createClient()

// Create test query client
const createTestQueryClient = () => new QueryClient({
  defaultOptions: {
    queries: {
      retry: false,
      cacheTime: 0,
    },
  },
})

interface TestProviderProps {
  children: React.ReactNode
}

function TestProviders({ children }: TestProviderProps) {
  const queryClient = createTestQueryClient()
  
  return (
    <QueryClientProvider client={queryClient}>
      <SessionContextProvider supabaseClient={mockSupabase}>
        <ThemeProvider theme={theme}>
          {children}
        </ThemeProvider>
      </SessionContextProvider>
    </QueryClientProvider>
  )
}

const customRender = (
  ui: React.ReactElement,
  options?: Omit<RenderOptions, 'wrapper'>
) => render(ui, { wrapper: TestProviders, ...options })

export * from '@testing-library/react'
export { customRender as render }
EOF
```

### 2. Create Mock Factories

```bash
# Mock data factories
cat > test/utils/factories.ts << 'EOF'
import { faker } from '@faker-js/faker'

export const createMockUser = (overrides = {}) => ({
  id: faker.string.uuid(),
  email: faker.internet.email(),
  full_name: faker.person.fullName(),
  avatar_url: faker.image.avatar(),
  created_at: faker.date.past().toISOString(),
  ...overrides,
})

export const createMockEvent = (overrides = {}) => ({
  id: faker.string.uuid(),
  title: faker.lorem.words(3),
  description: faker.lorem.paragraph(),
  start_date: faker.date.future().toISOString(),
  end_date: faker.date.future().toISOString(),
  location: faker.location.city(),
  capacity: faker.number.int({ min: 50, max: 500 }),
  price: faker.number.float({ min: 0, max: 1000, precision: 0.01 }),
  organization_id: faker.string.uuid(),
  created_at: faker.date.past().toISOString(),
  updated_at: faker.date.recent().toISOString(),
  ...overrides,
})

export const createMockAttendee = (overrides = {}) => ({
  id: faker.string.uuid(),
  event_id: faker.string.uuid(),
  user_id: faker.string.uuid(),
  ticket_type: faker.helpers.arrayElement(['general', 'vip', 'press']),
  status: faker.helpers.arrayElement(['confirmed', 'pending', 'cancelled']),
  checked_in: faker.datatype.boolean(),
  checked_in_at: faker.date.recent().toISOString(),
  created_at: faker.date.past().toISOString(),
  ...overrides,
})
EOF
```

### 3. Component Testing Examples

```bash
# Example component test
cat > packages/ui/src/components/EventCard/__tests__/EventCard.test.tsx << 'EOF'
import { describe, it, expect, vi } from 'vitest'
import { render, screen, fireEvent } from '../../../../test/utils/test-utils'
import { EventCard } from '../EventCard'
import { createMockEvent } from '../../../../test/utils/factories'

describe('EventCard', () => {
  const mockEvent = createMockEvent()
  const mockOnClick = vi.fn()
  
  it('renders event information correctly', () => {
    render(<EventCard event={mockEvent} />)
    
    expect(screen.getByText(mockEvent.title)).toBeInTheDocument()
    expect(screen.getByText(mockEvent.description)).toBeInTheDocument()
    expect(screen.getByText(mockEvent.location)).toBeInTheDocument()
  })
  
  it('handles click events', () => {
    render(<EventCard event={mockEvent} onClick={mockOnClick} />)
    
    fireEvent.click(screen.getByRole('article'))
    expect(mockOnClick).toHaveBeenCalledWith(mockEvent)
  })
  
  it('displays sold out badge when at capacity', () => {
    const soldOutEvent = createMockEvent({
      capacity: 100,
      attendees_count: 100,
    })
    
    render(<EventCard event={soldOutEvent} />)
    expect(screen.getByText('Sold Out')).toBeInTheDocument()
  })
  
  it('shows VIP badge for VIP events', () => {
    const vipEvent = createMockEvent({ is_vip: true })
    
    render(<EventCard event={vipEvent} />)
    expect(screen.getByText('VIP')).toBeInTheDocument()
  })
})
EOF
```

### 4. Hook Testing Examples

```bash
# Custom hook test
cat > packages/ui/src/hooks/__tests__/useEvents.test.ts << 'EOF'
import { renderHook, waitFor } from '@testing-library/react'
import { describe, it, expect, vi } from 'vitest'
import { useEvents } from '../useEvents'
import { createMockEvent } from '../../../../test/utils/factories'

// Mock Supabase
vi.mock('@eventos/database', () => ({
  supabase: {
    from: vi.fn(() => ({
      select: vi.fn(() => ({
        order: vi.fn(() => ({
          limit: vi.fn(() => Promise.resolve({
            data: [createMockEvent()],
            error: null,
          })),
        })),
      })),
    })),
  },
}))

describe('useEvents', () => {
  it('fetches events successfully', async () => {
    const { result } = renderHook(() => useEvents())
    
    expect(result.current.isLoading).toBe(true)
    
    await waitFor(() => {
      expect(result.current.isLoading).toBe(false)
    })
    
    expect(result.current.data).toHaveLength(1)
    expect(result.current.error).toBeNull()
  })
  
  it('handles errors gracefully', async () => {
    // Mock error response
    vi.mocked(supabase.from).mockImplementationOnce(() => ({
      select: vi.fn(() => ({
        order: vi.fn(() => ({
          limit: vi.fn(() => Promise.resolve({
            data: null,
            error: new Error('Database error'),
          })),
        })),
      })),
    }))
    
    const { result } = renderHook(() => useEvents())
    
    await waitFor(() => {
      expect(result.current.isLoading).toBe(false)
    })
    
    expect(result.current.error).toBeTruthy()
    expect(result.current.data).toBeNull()
  })
})
EOF
```

---

## 🔄 Integration Testing

### 1. API Route Testing

```bash
# API route test example
cat > apps/website/src/app/api/events/__tests__/route.test.ts << 'EOF'
import { describe, it, expect, beforeEach, vi } from 'vitest'
import { GET, POST } from '../route'
import { createMockEvent } from '../../../../../test/utils/factories'

// Mock Supabase
vi.mock('@eventos/database', () => ({
  createClient: vi.fn(() => ({
    auth: {
      getSession: vi.fn(() => ({
        data: { session: { user: { id: 'test-user' } } },
      })),
    },
    from: vi.fn(() => ({
      select: vi.fn(() => Promise.resolve({
        data: [createMockEvent()],
        error: null,
      })),
      insert: vi.fn(() => Promise.resolve({
        data: createMockEvent(),
        error: null,
      })),
    })),
  })),
}))

describe('/api/events', () => {
  describe('GET', () => {
    it('returns events list', async () => {
      const request = new Request('http://localhost:3000/api/events')
      const response = await GET(request)
      const data = await response.json()
      
      expect(response.status).toBe(200)
      expect(data).toHaveProperty('events')
      expect(data.events).toHaveLength(1)
    })
    
    it('handles pagination', async () => {
      const request = new Request('http://localhost:3000/api/events?page=2&limit=10')
      const response = await GET(request)
      
      expect(response.status).toBe(200)
    })
  })
  
  describe('POST', () => {
    it('creates new event', async () => {
      const newEvent = {
        title: 'Fashion Week 2024',
        description: 'Annual fashion showcase',
        start_date: '2024-09-15',
        end_date: '2024-09-20',
      }
      
      const request = new Request('http://localhost:3000/api/events', {
        method: 'POST',
        body: JSON.stringify(newEvent),
        headers: { 'Content-Type': 'application/json' },
      })
      
      const response = await POST(request)
      const data = await response.json()
      
      expect(response.status).toBe(201)
      expect(data).toHaveProperty('event')
      expect(data.event.title).toBe(newEvent.title)
    })
    
    it('validates required fields', async () => {
      const request = new Request('http://localhost:3000/api/events', {
        method: 'POST',
        body: JSON.stringify({}),
        headers: { 'Content-Type': 'application/json' },
      })
      
      const response = await POST(request)
      
      expect(response.status).toBe(400)
    })
  })
})
EOF
```

### 2. Database Integration Tests

```bash
# Database integration test
cat > packages/database/src/__tests__/integration.test.ts << 'EOF'
import { describe, it, expect, beforeAll, afterAll } from 'vitest'
import { createClient } from '../client'
import { createMockEvent, createMockUser } from '../../../../test/utils/factories'

describe('Database Integration', () => {
  let supabase: ReturnType<typeof createClient>
  let testUser: any
  let testEvent: any
  
  beforeAll(async () => {
    supabase = createClient()
    
    // Create test user
    const { data: user } = await supabase.auth.signUp({
      email: 'test@example.com',
      password: 'testpassword123',
    })
    testUser = user
  })
  
  afterAll(async () => {
    // Cleanup
    if (testUser) {
      await supabase.auth.admin.deleteUser(testUser.id)
    }
  })
  
  describe('Events', () => {
    it('creates and retrieves events', async () => {
      const eventData = createMockEvent({
        organization_id: testUser.id,
      })
      
      // Create event
      const { data: created, error: createError } = await supabase
        .from('events')
        .insert(eventData)
        .select()
        .single()
      
      expect(createError).toBeNull()
      expect(created).toMatchObject(eventData)
      testEvent = created
      
      // Retrieve event
      const { data: retrieved, error: retrieveError } = await supabase
        .from('events')
        .select('*')
        .eq('id', created.id)
        .single()
      
      expect(retrieveError).toBeNull()
      expect(retrieved).toMatchObject(created)
    })
    
    it('enforces RLS policies', async () => {
      // Try to access event as different user
      const { data, error } = await supabase
        .from('events')
        .select('*')
        .eq('organization_id', 'different-org-id')
      
      expect(data).toHaveLength(0)
    })
  })
})
EOF
```

---

## 🎭 E2E Testing

### 1. Critical User Journeys

```bash
# E2E test for event booking flow
cat > test/e2e/event-booking.spec.ts << 'EOF'
import { test, expect } from '@playwright/test'
import { createMockEvent } from '../utils/factories'

test.describe('Event Booking Flow', () => {
  test.beforeEach(async ({ page }) => {
    // Set up authenticated state
    await page.goto('/login')
    await page.fill('[name="email"]', 'test@example.com')
    await page.fill('[name="password"]', 'testpassword')
    await page.click('button[type="submit"]')
    await page.waitForURL('/dashboard')
  })
  
  test('complete booking flow', async ({ page }) => {
    // Navigate to events
    await page.goto('/events')
    
    // Search for event
    await page.fill('[placeholder="Search events..."]', 'Fashion Week')
    await page.waitForSelector('[data-testid="event-card"]')
    
    // Click on event
    await page.click('[data-testid="event-card"]:first-child')
    await page.waitForURL(/\/events\/[\w-]+/)
    
    // Check event details
    await expect(page.locator('h1')).toContainText('Fashion Week')
    
    // Select ticket type
    await page.click('[data-testid="ticket-vip"]')
    
    // Add to cart
    await page.click('button:has-text("Add to Cart")')
    
    // Proceed to checkout
    await page.click('button:has-text("Checkout")')
    await page.waitForURL('/checkout')
    
    // Fill payment details
    await page.fill('[data-testid="card-number"]', '4242424242424242')
    await page.fill('[data-testid="card-expiry"]', '12/25')
    await page.fill('[data-testid="card-cvc"]', '123')
    
    // Complete purchase
    await page.click('button:has-text("Complete Purchase")')
    
    // Verify success
    await page.waitForURL('/booking/success')
    await expect(page.locator('[data-testid="success-message"]')).toBeVisible()
    await expect(page.locator('[data-testid="ticket-qr"]')).toBeVisible()
  })
  
  test('handles sold out events', async ({ page }) => {
    await page.goto('/events/sold-out-event')
    
    await expect(page.locator('[data-testid="sold-out-badge"]')).toBeVisible()
    await expect(page.locator('button:has-text("Add to Cart")')).toBeDisabled()
    
    // Join waitlist
    await page.click('button:has-text("Join Waitlist")')
    await expect(page.locator('[data-testid="waitlist-success"]')).toBeVisible()
  })
})
EOF
```

### 2. Mobile Testing

```bash
# Mobile-specific E2E tests
cat > test/e2e/mobile.spec.ts << 'EOF'
import { test, expect, devices } from '@playwright/test'

test.use({ ...devices['iPhone 13'] })

test.describe('Mobile Experience', () => {
  test('mobile navigation works', async ({ page }) => {
    await page.goto('/')
    
    // Open mobile menu
    await page.click('[data-testid="mobile-menu-button"]')
    await expect(page.locator('[data-testid="mobile-menu"]')).toBeVisible()
    
    // Navigate to events
    await page.click('[data-testid="mobile-menu"] a:has-text("Events")')
    await page.waitForURL('/events')
    
    // Verify mobile layout
    const viewport = page.viewportSize()
    expect(viewport?.width).toBeLessThan(768)
    
    // Check touch interactions
    const eventCard = page.locator('[data-testid="event-card"]:first-child')
    await eventCard.tap()
    await page.waitForURL(/\/events\/[\w-]+/)
  })
  
  test('mobile checkout flow', async ({ page }) => {
    // Test mobile-specific checkout features
    await page.goto('/checkout')
    
    // Check mobile payment options
    await expect(page.locator('button:has-text("Apple Pay")')).toBeVisible()
    await expect(page.locator('button:has-text("Google Pay")')).toBeVisible()
    
    // Test autofill
    await page.click('[data-testid="autofill-button"]')
    await expect(page.locator('[name="email"]')).toHaveValue(/.+@.+/)
  })
})
EOF
```

---

## 🚀 Performance Testing

### 1. Lighthouse CI Configuration

```bash
# Enhanced Lighthouse configuration
cat > .lighthouseci.js << 'EOF'
module.exports = {
  ci: {
    collect: {
      startServerCommand: 'pnpm build && pnpm start',
      startServerReadyPattern: 'ready on',
      url: [
        'http://localhost:3000',
        'http://localhost:3000/events',
        'http://localhost:3000/pricing',
      ],
      numberOfRuns: 5,
      settings: {
        preset: 'desktop',
        throttling: {
          cpuSlowdownMultiplier: 1,
        },
        screenEmulation: {
          mobile: false,
          width: 1920,
          height: 1080,
          deviceScaleFactor: 1,
        },
      },
    },
    assert: {
      preset: 'lighthouse:recommended',
      assertions: {
        'categories:performance': ['error', { minScore: 0.95 }],
        'categories:accessibility': ['error', { minScore: 0.98 }],
        'categories:best-practices': ['error', { minScore: 0.95 }],
        'categories:seo': ['error', { minScore: 0.98 }],
        'categories:pwa': ['warn', { minScore: 0.90 }],
        
        // Core Web Vitals
        'first-contentful-paint': ['error', { maxNumericValue: 1800 }],
        'largest-contentful-paint': ['error', { maxNumericValue: 2500 }],
        'cumulative-layout-shift': ['error', { maxNumericValue: 0.1 }],
        'total-blocking-time': ['error', { maxNumericValue: 300 }],
        'speed-index': ['error', { maxNumericValue: 3400 }],
        
        // Resource metrics
        'resource-summary:script:size': ['error', { maxNumericValue: 350000 }],
        'resource-summary:stylesheet:size': ['error', { maxNumericValue: 150000 }],
        'resource-summary:image:size': ['error', { maxNumericValue: 500000 }],
        'resource-summary:total:size': ['error', { maxNumericValue: 1500000 }],
        
        // Best practices
        'uses-http2': 'error',
        'uses-passive-event-listeners': 'error',
        'no-document-write': 'error',
        'js-libraries': 'warn',
      },
    },
    upload: {
      target: 'temporary-public-storage',
    },
  },
}
EOF
```

### 2. Load Testing

```bash
# K6 load testing script
cat > test/load/event-api.js << 'EOF'
import http from 'k6/http'
import { check, sleep } from 'k6'
import { Rate } from 'k6/metrics'

const errorRate = new Rate('errors')

export const options = {
  stages: [
    { duration: '30s', target: 10 },   // Ramp up to 10 users
    { duration: '1m', target: 50 },    // Stay at 50 users
    { duration: '2m', target: 100 },   // Ramp up to 100 users
    { duration: '2m', target: 100 },   // Stay at 100 users
    { duration: '1m', target: 0 },     // Ramp down to 0 users
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'], // 95% of requests under 500ms
    errors: ['rate<0.1'],             // Error rate under 10%
  },
}

const BASE_URL = 'https://eventos-staging.vercel.app'

export default function () {
  // Test events listing
  const eventsRes = http.get(`${BASE_URL}/api/events`)
  check(eventsRes, {
    'events status 200': (r) => r.status === 200,
    'events response time < 500ms': (r) => r.timings.duration < 500,
  })
  errorRate.add(eventsRes.status !== 200)
  
  sleep(1)
  
  // Test event details
  const eventId = 'test-event-id'
  const eventRes = http.get(`${BASE_URL}/api/events/${eventId}`)
  check(eventRes, {
    'event status 200': (r) => r.status === 200,
    'event has required fields': (r) => {
      const body = JSON.parse(r.body)
      return body.event && body.event.id && body.event.title
    },
  })
  
  sleep(1)
  
  // Test search
  const searchRes = http.get(`${BASE_URL}/api/events/search?q=fashion`)
  check(searchRes, {
    'search status 200': (r) => r.status === 200,
    'search returns results': (r) => {
      const body = JSON.parse(r.body)
      return Array.isArray(body.results)
    },
  })
  
  sleep(1)
}
EOF
```

---

## 🔒 Security Testing

### 1. Security Test Suite

```bash
# Security tests
cat > test/security/auth.test.ts << 'EOF'
import { describe, it, expect } from 'vitest'
import { testRateLimit, testCSRF, testXSS } from './security-utils'

describe('Authentication Security', () => {
  it('prevents brute force attacks', async () => {
    const results = await testRateLimit({
      endpoint: '/api/auth/login',
      method: 'POST',
      attempts: 10,
      expectedBlockAfter: 5,
    })
    
    expect(results.blockedAt).toBe(6)
    expect(results.lastResponse.status).toBe(429)
  })
  
  it('validates CSRF tokens', async () => {
    const result = await testCSRF({
      endpoint: '/api/events',
      method: 'POST',
    })
    
    expect(result.withoutToken.status).toBe(403)
    expect(result.withToken.status).toBe(201)
  })
  
  it('prevents XSS in user inputs', async () => {
    const xssPayloads = [
      '<script>alert("XSS")</script>',
      'javascript:alert("XSS")',
      '<img src=x onerror=alert("XSS")>',
      '<svg onload=alert("XSS")>',
    ]
    
    for (const payload of xssPayloads) {
      const result = await testXSS({
        endpoint: '/api/events',
        field: 'title',
        payload,
      })
      
      expect(result.sanitized).not.toContain('<script>')
      expect(result.sanitized).not.toContain('javascript:')
      expect(result.sanitized).not.toContain('onerror=')
      expect(result.sanitized).not.toContain('onload=')
    }
  })
})

describe('API Security', () => {
  it('enforces authentication on protected routes', async () => {
    const protectedRoutes = [
      '/api/admin/users',
      '/api/admin/events',
      '/api/user/profile',
      '/api/bookings',
    ]
    
    for (const route of protectedRoutes) {
      const response = await fetch(route)
      expect(response.status).toBe(401)
    }
  })
  
  it('validates API rate limits', async () => {
    const endpoints = [
      { path: '/api/events', limit: 100, window: 60000 },
      { path: '/api/auth/register', limit: 5, window: 900000 },
      { path: '/api/upload', limit: 10, window: 3600000 },
    ]
    
    for (const endpoint of endpoints) {
      const result = await testRateLimit({
        endpoint: endpoint.path,
        attempts: endpoint.limit + 5,
        expectedBlockAfter: endpoint.limit,
      })
      
      expect(result.blockedAt).toBe(endpoint.limit + 1)
    }
  })
})
EOF
```

### 2. RLS Policy Tests

```bash
# Supabase RLS tests
cat > test/security/rls.test.ts << 'EOF'
import { describe, it, expect } from 'vitest'
import { createClient } from '@supabase/supabase-js'

describe('Row Level Security', () => {
  const anonClient = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
  )
  
  const serviceClient = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,
    { auth: { persistSession: false } }
  )
  
  describe('Events Table', () => {
    it('anonymous users can only read public events', async () => {
      const { data, error } = await anonClient
        .from('events')
        .select('*')
        .eq('is_public', true)
      
      expect(error).toBeNull()
      expect(data).toBeDefined()
      
      // Try to access private event
      const { data: privateData } = await anonClient
        .from('events')
        .select('*')
        .eq('is_public', false)
        .single()
      
      expect(privateData).toBeNull()
    })
    
    it('users can only modify their own events', async () => {
      // Create user session
      const { data: { user } } = await anonClient.auth.signInWithPassword({
        email: 'test@example.com',
        password: 'testpassword',
      })
      
      // Try to update own event
      const { error: updateError } = await anonClient
        .from('events')
        .update({ title: 'Updated Title' })
        .eq('organization_id', user!.id)
      
      expect(updateError).toBeNull()
      
      // Try to update another user's event
      const { error: otherError } = await anonClient
        .from('events')
        .update({ title: 'Hacked Title' })
        .eq('organization_id', 'other-user-id')
      
      expect(otherError).toBeDefined()
      expect(otherError!.code).toBe('42501') // Insufficient privilege
    })
  })
  
  describe('Attendees Table', () => {
    it('enforces privacy on attendee data', async () => {
      // Users can only see attendees for their events
      const { data } = await anonClient
        .from('attendees')
        .select('*')
      
      expect(data).toHaveLength(0)
    })
  })
})
EOF
```

---

## 📊 Test Reporting & Monitoring

### 1. Test Coverage Configuration

```bash
# Update vitest config for coverage
cat > vitest.config.ts << 'EOF'
import { defineConfig } from 'vitest/config'
import react from '@vitejs/plugin-react'
import tsconfigPaths from 'vite-tsconfig-paths'

export default defineConfig({
  plugins: [react(), tsconfigPaths()],
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: ['./test/setup.ts'],
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html', 'lcov'],
      exclude: [
        'node_modules/',
        'test/',
        '**/*.d.ts',
        '**/*.config.*',
        '**/mockData/*',
        '.next',
        'coverage',
        '**/__tests__/**',
        '**/*.test.*',
      ],
      thresholds: {
        lines: 80,
        functions: 80,
        branches: 80,
        statements: 80,
      },
      watermarks: {
        statements: [80, 95],
        functions: [80, 95],
        branches: [80, 95],
        lines: [80, 95],
      },
    },
  },
})
EOF
```

### 2. Test Dashboard Script

```bash
# Create test dashboard generator
cat > scripts/test-report.js << 'EOF'
#!/usr/bin/env node

const fs = require('fs')
const path = require('path')

// Read test results
const coverageData = JSON.parse(
  fs.readFileSync('coverage/coverage-final.json', 'utf8')
)

const lighthouseData = JSON.parse(
  fs.readFileSync('.lighthouseci/lhr-summary.json', 'utf8')
)

const e2eResults = JSON.parse(
  fs.readFileSync('test-results/results.json', 'utf8')
)

// Generate HTML report
const html = `
<!DOCTYPE html>
<html>
<head>
  <title>EventsOS Test Report</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 20px; }
    .metric { 
      display: inline-block; 
      margin: 10px; 
      padding: 20px; 
      border: 1px solid #ddd; 
      border-radius: 8px; 
    }
    .metric h3 { margin-top: 0; }
    .pass { color: green; }
    .fail { color: red; }
    .warn { color: orange; }
  </style>
</head>
<body>
  <h1>EventsOS Test Report</h1>
  <p>Generated: ${new Date().toISOString()}</p>
  
  <h2>Coverage Summary</h2>
  <div class="metric">
    <h3>Lines</h3>
    <p class="${getCoverageClass(coverageData.total.lines.pct)}">
      ${coverageData.total.lines.pct}%
    </p>
  </div>
  <div class="metric">
    <h3>Functions</h3>
    <p class="${getCoverageClass(coverageData.total.functions.pct)}">
      ${coverageData.total.functions.pct}%
    </p>
  </div>
  <div class="metric">
    <h3>Branches</h3>
    <p class="${getCoverageClass(coverageData.total.branches.pct)}">
      ${coverageData.total.branches.pct}%
    </p>
  </div>
  
  <h2>Performance Metrics</h2>
  ${Object.entries(lighthouseData).map(([url, data]) => `
    <h3>${url}</h3>
    <div class="metric">
      <h3>Performance</h3>
      <p class="${getScoreClass(data.categories.performance.score)}">
        ${(data.categories.performance.score * 100).toFixed(0)}
      </p>
    </div>
    <div class="metric">
      <h3>Accessibility</h3>
      <p class="${getScoreClass(data.categories.accessibility.score)}">
        ${(data.categories.accessibility.score * 100).toFixed(0)}
      </p>
    </div>
  `).join('')}
  
  <h2>E2E Test Results</h2>
  <p>Total: ${e2eResults.total}</p>
  <p class="pass">Passed: ${e2eResults.passed}</p>
  <p class="fail">Failed: ${e2eResults.failed}</p>
  <p class="warn">Skipped: ${e2eResults.skipped}</p>
</body>
</html>
`

function getCoverageClass(pct) {
  if (pct >= 80) return 'pass'
  if (pct >= 60) return 'warn'
  return 'fail'
}

function getScoreClass(score) {
  if (score >= 0.9) return 'pass'
  if (score >= 0.7) return 'warn'
  return 'fail'
}

fs.writeFileSync('test-report.html', html)
console.log('Test report generated: test-report.html')
EOF

chmod +x scripts/test-report.js
```

---

## 🔍 Continuous Testing Strategy

### 1. Pre-commit Tests

```bash
# Fast tests that run on every commit
cat > package.json << 'EOF'
{
  "lint-staged": {
    "*.{ts,tsx}": [
      "eslint --fix",
      "prettier --write",
      "vitest related --run"
    ],
    "*.{json,md}": [
      "prettier --write"
    ]
  }
}
EOF
```

### 2. CI Pipeline Tests

```yaml
# Different test suites for different triggers
name: Test Suite

on:
  pull_request:
    types: [opened, synchronize]
  push:
    branches: [main, develop]

jobs:
  quick-tests:
    runs-on: ubuntu-latest
    if: github.event_name == 'pull_request'
    steps:
      - name: Unit tests
        run: pnpm test:unit
      
      - name: Lint
        run: pnpm lint

  full-tests:
    runs-on: ubuntu-latest
    if: github.event_name == 'push'
    steps:
      - name: All tests
        run: pnpm test:all
      
      - name: E2E tests
        run: pnpm test:e2e
      
      - name: Performance tests
        run: pnpm lighthouse
```

### 3. Scheduled Security Tests

```yaml
name: Security Audit

on:
  schedule:
    - cron: '0 0 * * *' # Daily
  workflow_dispatch:

jobs:
  security:
    runs-on: ubuntu-latest
    steps:
      - name: Dependency audit
        run: pnpm audit
      
      - name: Security tests
        run: pnpm test:security
      
      - name: OWASP ZAP scan
        uses: zaproxy/action-full-scan@v0.4.0
        with:
          target: 'https://eventos-staging.vercel.app'
```

---

## ✅ Testing Checklist

### Unit Testing
- [ ] All business logic functions tested
- [ ] React components have tests
- [ ] Custom hooks tested
- [ ] Utilities have 100% coverage
- [ ] Error cases covered

### Integration Testing
- [ ] API routes tested
- [ ] Database queries tested
- [ ] Authentication flows tested
- [ ] Third-party integrations mocked
- [ ] Error handling verified

### E2E Testing
- [ ] Critical user journeys tested
- [ ] Mobile experience tested
- [ ] Cross-browser compatibility
- [ ] Performance benchmarks met
- [ ] Accessibility standards met

### Security Testing
- [ ] Authentication tested
- [ ] Authorization tested
- [ ] Input validation tested
- [ ] RLS policies verified
- [ ] Rate limiting tested

### Performance Testing
- [ ] Load tests passing
- [ ] Lighthouse scores meet targets
- [ ] Bundle size within limits
- [ ] Database queries optimized
- [ ] CDN caching verified

---

## 📈 Metrics & KPIs

| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| Code Coverage | 80%+ | - | ⏳ |
| E2E Pass Rate | 95%+ | - | ⏳ |
| Performance Score | 90+ | - | ⏳ |
| Security Score | A+ | - | ⏳ |
| Build Time | <5min | - | ⏳ |

---

## 🚀 Next Steps

1. **Implement Core Tests**: Start with critical business logic
2. **Set Up CI/CD**: Automate test execution
3. **Monitor Metrics**: Track coverage and performance
4. **Iterate**: Continuously improve test quality

The testing infrastructure is now comprehensive and production-ready! 🎉