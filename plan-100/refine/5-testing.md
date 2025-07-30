# EventsOS Testing & Quality Assurance Plan

## Testing Strategy Overview

### 1. Unit Tests

```typescript
// src/__tests__/components/MetricCard.test.tsx
import { render, screen } from '@testing-library/react';
import { MetricCard } from '../components/dashboard/MetricCard';

describe('MetricCard', () => {
  it('displays correct value and title', () => {
    render(
      <MetricCard 
        title="Total Events" 
        value={42} 
        icon={<span>🎪</span>}
        color="primary"
      />
    );
    
    expect(screen.getByText('Total Events')).toBeInTheDocument();
    expect(screen.getByText('42')).toBeInTheDocument();
  });

  it('shows trend when provided', () => {
    render(
      <MetricCard 
        title="Revenue" 
        value="$10,000" 
        trend="+15%"
        color="success"
      />
    );
    
    expect(screen.getByText('+15%')).toBeInTheDocument();
  });
});
```

### 2. Integration Tests

```typescript
// src/__tests__/integration/events.test.tsx
import { render, screen, waitFor } from '@testing-library/react';
import { TestWrapper } from '../test-utils';
import { EventList } from '../../pages/events/list';

describe('Events Integration', () => {
  it('loads and displays events from Supabase', async () => {
    render(
      <TestWrapper>
        <EventList />
      </TestWrapper>
    );

    await waitFor(() => {
      expect(screen.getByText('Fashion Week 2024')).toBeInTheDocument();
    });

    expect(screen.getByRole('grid')).toBeInTheDocument();
  });

  it('filters events by organization', async () => {
    localStorage.setItem('organization_id', 'test-org-123');
    
    render(
      <TestWrapper>
        <EventList />
      </TestWrapper>
    );

    await waitFor(() => {
      const rows = screen.getAllByRole('row');
      expect(rows.length).toBeGreaterThan(1);
    });
  });
});
```

### 3. E2E Tests

```typescript
// e2e/dashboard.spec.ts
import { test, expect } from '@playwright/test';

test.describe('Dashboard E2E', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('http://localhost:3000');
    // Login
    await page.fill('[name="email"]', 'test@eventos.com');
    await page.fill('[name="password"]', 'testpass123');
    await page.click('button[type="submit"]');
    await page.waitForURL('**/dashboard');
  });

  test('displays all dashboard metrics', async ({ page }) => {
    // Check all metric cards are visible
    await expect(page.locator('text=Total Events')).toBeVisible();
    await expect(page.locator('text=Total Registrations')).toBeVisible();
    await expect(page.locator('text=Revenue')).toBeVisible();
    await expect(page.locator('text=Avg Attendance')).toBeVisible();
  });

  test('navigates to events page', async ({ page }) => {
    await page.click('text=Events');
    await expect(page).toHaveURL(/.*\/events/);
    await expect(page.locator('[role="grid"]')).toBeVisible();
  });

  test('creates new event', async ({ page }) => {
    await page.click('text=Events');
    await page.click('text=Create');
    
    // Fill form
    await page.fill('[name="title"]', 'Test Fashion Show');
    await page.fill('[name="venue"]', 'Grand Plaza');
    await page.fill('[name="capacity"]', '500');
    
    await page.click('text=Save');
    
    // Verify success
    await expect(page.locator('text=Event created successfully')).toBeVisible();
  });
});
```

## Performance Testing

```typescript
// performance/dashboard.perf.ts
import { chromium } from 'playwright';

async function measureDashboardPerformance() {
  const browser = await chromium.launch();
  const context = await browser.newContext();
  const page = await context.newPage();

  // Start performance measurement
  await page.goto('http://localhost:3000/dashboard');
  
  const metrics = await page.evaluate(() => {
    const perfData = performance.getEntriesByType('navigation')[0];
    return {
      domContentLoaded: perfData.domContentLoadedEventEnd - perfData.domContentLoadedEventStart,
      loadComplete: perfData.loadEventEnd - perfData.loadEventStart,
      firstPaint: performance.getEntriesByName('first-paint')[0]?.startTime,
      firstContentfulPaint: performance.getEntriesByName('first-contentful-paint')[0]?.startTime,
    };
  });

  console.log('Performance Metrics:', metrics);
  
  // Assert performance thresholds
  expect(metrics.firstContentfulPaint).toBeLessThan(1500); // 1.5s
  expect(metrics.loadComplete).toBeLessThan(3000); // 3s

  await browser.close();
}
```

## Test Commands

```bash
# package.json scripts
{
  "scripts": {
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "test:e2e": "playwright test",
    "test:e2e:ui": "playwright test --ui",
    "test:perf": "node ./performance/dashboard.perf.ts"
  }
}
```

## Testing Checklist

### Per Feature Testing Requirements

| Feature | Unit Tests | Integration | E2E | Performance |
|---------|------------|-------------|-----|-------------|
| Dashboard Metrics | ✅ Component renders | ✅ Data fetching | ✅ All cards visible | ✅ < 1.5s FCP |
| Event List | ✅ Grid renders | ✅ CRUD operations | ✅ Filtering works | ✅ < 100ms render |
| Event Form | ✅ Validation | ✅ Submission | ✅ Success message | ✅ No lag |
| Analytics | ✅ Charts render | ✅ Real-time updates | ✅ Export works | ✅ < 2s load |
| Auth Flow | ✅ Form validation | ✅ Supabase auth | ✅ Login/logout | ✅ Token refresh |

### Automated Testing Pipeline

```yaml
# .github/workflows/test.yml
name: Test Suite

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          
      - name: Install dependencies
        run: pnpm install
        
      - name: Run unit tests
        run: pnpm test:coverage
        
      - name: Run E2E tests
        run: pnpm test:e2e
        
      - name: Upload coverage
        uses: codecov/codecov-action@v3
```