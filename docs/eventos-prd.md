# EventsOS Product Requirements Document (PRD)

## /project-docs/

### 📄 project-overview.md

# EventsOS - Project Overview

## Vision Statement
EventsOS is an AI-powered event lifecycle management platform that transforms fashion and corporate event production through intelligent automation, unified stakeholder management, and data-driven revenue optimization.

## Problem Statement
The fashion event industry loses 40-60% of potential revenue due to fragmented systems, manual workflows, and disconnected stakeholder communication. Event organizers juggle 10-15 different tools, leading to errors, inefficiencies, and missed opportunities. Current solutions lack fashion-specific features and AI-driven automation capabilities.

## Primary Goals
1. **Unify Event Management**: Single platform for all event lifecycle phases
2. **Automate Workflows**: 85% reduction in manual tasks through AI agents
3. **Optimize Revenue**: 300% increase in event profitability through dynamic pricing and sponsorship optimization
4. **Enhance Experience**: Real-time attendee engagement and personalized experiences
5. **Scale Operations**: Support 10,000+ concurrent users during peak registration

## Key User Types & Needs

### Event Organizers
- **Need**: Streamlined planning and execution tools
- **Pain Points**: Juggling multiple platforms, manual data entry, poor visibility
- **Solution**: Unified dashboard with AI-powered automation

### Fashion Designers
- **Need**: Professional showcase platform with buyer connections
- **Pain Points**: Limited exposure, complex logistics, poor ROI tracking
- **Solution**: Designer portal with analytics and lead generation

### Models & Talent
- **Need**: Booking management and portfolio showcasing
- **Pain Points**: Scheduling conflicts, payment delays, limited opportunities
- **Solution**: Talent marketplace with automated scheduling

### Sponsors & Partners
- **Need**: ROI measurement and activation tracking
- **Pain Points**: Unclear metrics, manual reporting, limited visibility
- **Solution**: Real-time analytics dashboard with automated reporting

### Attendees
- **Need**: Seamless registration and personalized experiences
- **Pain Points**: Complex ticketing, poor communication, generic experiences
- **Solution**: Mobile-first experience with AI personalization

## Summary of Scope
EventsOS delivers a comprehensive SaaS platform covering:
- Multi-tenant architecture supporting 10,000+ organizations
- AI-powered planning and content generation
- Real-time collaboration and communication
- Integrated ticketing and payment processing
- Advanced analytics and predictive insights
- White-label capabilities for enterprise clients

---

### 📄 features.md

# EventsOS - Features Specification

## Core Features

### 1. Event Planning & Management
**Title**: Intelligent Event Creator  
**Description**: AI-powered event planning wizard that generates complete event blueprints based on type, scale, and objectives  
**Priority**: High  
**Functional Behavior**:
- Step-by-step guided creation with AI suggestions
- Template library with 50+ fashion event types
- Budget calculator with historical benchmarks
- Timeline generator with dependency tracking
- Venue recommendation engine based on requirements

**Edge Cases**:
- Conflicting venue bookings → Alternative suggestions with availability calendar
- Budget overruns → Real-time alerts with cost-cutting recommendations
- Timeline conflicts → Automatic rescheduling with stakeholder notifications

**Validation/Business Rules**:
- Minimum 30-day planning window for events >500 attendees
- Budget variance alerts at 10%, 20%, and 30% thresholds
- Mandatory insurance verification for events >$50K budget

**User Stories**:
- As an event organizer, I want AI-generated timelines, so that I can plan efficiently
- As a finance manager, I want real-time budget tracking, so that I can prevent overruns

### 2. Stakeholder Coordination Hub
**Title**: Unified Communications Center  
**Description**: Multi-channel communication platform integrating email, SMS, WhatsApp, and in-app messaging  
**Priority**: High  
**Functional Behavior**:
- Role-based communication channels
- Automated message scheduling
- Multi-language support (EN/ES/FR)
- Read receipts and engagement tracking
- Emergency broadcast system

**Edge Cases**:
- Message delivery failures → Automatic channel fallback (Email → SMS → WhatsApp)
- Language detection errors → Manual override with preference saving
- High-volume sending → Queue management with priority routing

**Validation/Business Rules**:
- GDPR-compliant opt-in/opt-out management
- Rate limiting: 100 messages/minute per organization
- Message templates require approval for >1000 recipients

**User Stories**:
- As a coordinator, I want automated attendee updates, so that everyone stays informed
- As an attendee, I want communication preferences, so that I receive relevant updates

### 3. AI-Powered Automation Suite
**Title**: CrewAI Multi-Agent System  
**Description**: Intelligent agents handling routine tasks across event lifecycle  
**Priority**: High  
**Functional Behavior**:
- Event Planning Agent: Generates comprehensive event plans
- Content Creation Agent: Produces marketing materials
- Vendor Matching Agent: Recommends and negotiates with suppliers
- Analytics Agent: Provides predictive insights
- Communication Agent: Handles routine inquiries

**Edge Cases**:
- AI hallucination → Human-in-the-loop verification for critical decisions
- Context window limits → Automatic summarization and chunking
- API failures → Fallback to rule-based systems

**Validation/Business Rules**:
- All AI-generated content requires human approval before publication
- Token usage limits: 1M tokens/month per organization
- Compliance check for generated content (no discriminatory language)

**User Stories**:
- As an organizer, I want AI-generated vendor recommendations, so that I save research time
- As a marketer, I want automated content creation, so that I can focus on strategy

### 4. Dynamic Ticketing & Registration
**Title**: Smart Ticketing Engine  
**Description**: AI-optimized pricing with real-time availability management  
**Priority**: High  
**Functional Behavior**:
- Dynamic pricing based on demand patterns
- Early bird and group discount automation
- QR code generation with fraud prevention
- Waitlist management with automatic upgrades
- Mobile wallet integration (Apple/Google)

**Edge Cases**:
- Payment failures → Automatic retry with alternative methods
- Overselling → Instant waitlist activation with notifications
- Refund requests → Automated processing per policy rules

**Validation/Business Rules**:
- PCI DSS compliance for payment processing
- Maximum 10% price increase per 24-hour period
- Refund window: 30 days before event (customizable)

**User Stories**:
- As an attendee, I want mobile ticketing, so that I can check in easily
- As an organizer, I want dynamic pricing, so that I maximize revenue

### 5. Sponsor & Partner Portal
**Title**: Partnership Management System  
**Description**: Comprehensive sponsor lifecycle management with ROI tracking  
**Priority**: Medium  
**Functional Behavior**:
- Sponsorship package builder
- Digital asset management
- Performance analytics dashboard
- Lead scanning and attribution
- Automated fulfillment tracking

**Edge Cases**:
- Sponsor conflicts → Exclusivity management and alerts
- Asset approval delays → Escalation workflows
- ROI disputes → Detailed attribution reports

**Validation/Business Rules**:
- Sponsor exclusivity zones (industry/category)
- Minimum 72-hour approval window for assets
- Lead sharing agreements require legal sign-off

**User Stories**:
- As a sponsor, I want real-time ROI metrics, so that I can measure success
- As an organizer, I want automated sponsor reporting, so that I save time

### 6. Analytics & Intelligence Dashboard
**Title**: Predictive Analytics Suite  
**Description**: Real-time insights with AI-powered predictions  
**Priority**: Medium  
**Functional Behavior**:
- Live attendance tracking
- Revenue forecasting models
- Sentiment analysis from social media
- Post-event impact measurement
- Competitive benchmarking

**Edge Cases**:
- Data anomalies → Automatic detection and filtering
- Missing data → Interpolation with confidence intervals
- Privacy concerns → Anonymization and aggregation

**Validation/Business Rules**:
- Data retention: 3 years for analytics, 7 years for financial
- GDPR-compliant data processing
- Minimum 100 data points for predictions

**User Stories**:
- As an analyst, I want predictive attendance models, so that I can optimize planning
- As an executive, I want ROI dashboards, so that I can make data-driven decisions

---

### 📄 requirements.md

# EventsOS - System Requirements

## Functional Requirements

### Authentication & Authorization
- **FR-001**: Multi-factor authentication support (SMS, TOTP, WebAuthn)
- **FR-002**: Single Sign-On (SSO) integration (Google, Microsoft, SAML)
- **FR-003**: Role-based access control with 10+ predefined roles
- **FR-004**: API key management for third-party integrations
- **FR-005**: Session management with configurable timeouts

### Event Management
- **FR-006**: Support for 15+ event types (runway shows, trade shows, galas)
- **FR-007**: Recurring event management with template inheritance
- **FR-008**: Multi-venue coordination with capacity management
- **FR-009**: Virtual, hybrid, and in-person event support
- **FR-010**: Real-time collaboration with presence indicators

### Communication
- **FR-011**: Multi-channel messaging (Email, SMS, WhatsApp, Push)
- **FR-012**: Template management with variable substitution
- **FR-013**: Scheduled message campaigns with timezone support
- **FR-014**: A/B testing for communication effectiveness
- **FR-015**: Delivery tracking and engagement analytics

### Payment Processing
- **FR-016**: Multi-currency support (USD, EUR, GBP, + 20 others)
- **FR-017**: Split payments for marketplace transactions
- **FR-018**: Subscription billing for platform access
- **FR-019**: Automated invoice generation and delivery
- **FR-020**: Refund processing with policy enforcement

## Non-Functional Requirements

### Performance
- **NFR-001**: Page load time < 2 seconds (P95)
- **NFR-002**: API response time < 200ms (P95)
- **NFR-003**: Support 10,000 concurrent users
- **NFR-004**: 99.9% uptime SLA
- **NFR-005**: Real-time updates < 100ms latency

### Scalability
- **NFR-006**: Horizontal scaling to 1M+ users
- **NFR-007**: Database sharding for multi-tenant isolation
- **NFR-008**: Auto-scaling based on load patterns
- **NFR-009**: CDN integration for global content delivery
- **NFR-010**: Microservices architecture for independent scaling

### Security
- **NFR-011**: End-to-end encryption for sensitive data
- **NFR-012**: OWASP Top 10 compliance
- **NFR-013**: Regular security audits (quarterly)
- **NFR-014**: DDoS protection and rate limiting
- **NFR-015**: Audit logging for all data modifications

### Compliance
- **NFR-016**: GDPR compliance with data portability
- **NFR-017**: CCPA compliance for California users
- **NFR-018**: PCI DSS Level 1 for payment processing
- **NFR-019**: SOC 2 Type II certification
- **NFR-020**: WCAG 2.1 AA accessibility standards

## Performance Benchmarks

### Load Testing Targets
- Registration surge: 1,000 registrations/minute
- Payment processing: 500 transactions/minute
- Real-time updates: 10,000 WebSocket connections
- File uploads: 100 concurrent uploads (5GB max)
- API rate limits: 1,000 requests/minute per organization

### Response Time Requirements
| Operation | Target (P50) | Target (P95) | Target (P99) |
|-----------|--------------|--------------|--------------|
| Page Load | 1.0s | 2.0s | 3.0s |
| API Call | 100ms | 200ms | 500ms |
| Search | 150ms | 300ms | 600ms |
| File Upload | 2.0s/MB | 3.0s/MB | 5.0s/MB |
| Report Gen | 5.0s | 10.0s | 20.0s |

## Scalability Targets

### Growth Projections
- Year 1: 1,000 organizations, 100K users
- Year 2: 10,000 organizations, 1M users
- Year 3: 50,000 organizations, 5M users

### Infrastructure Scaling
- Database: PostgreSQL with read replicas
- Cache: Redis cluster with 100GB capacity
- Storage: S3-compatible with 10TB initial
- CDN: Global presence in 50+ locations
- Compute: Kubernetes with 100-1000 pods

## Security Requirements

### Data Protection
- **Encryption at Rest**: AES-256 for all stored data
- **Encryption in Transit**: TLS 1.3 minimum
- **Key Management**: AWS KMS or equivalent
- **Data Masking**: PII anonymization in non-prod
- **Backup**: Daily automated backups with 30-day retention

### Access Control
- **MFA Enforcement**: Required for admin roles
- **IP Whitelisting**: Optional per organization
- **Session Security**: JWT with 15-minute refresh
- **Password Policy**: 12+ chars, complexity requirements
- **Account Lockout**: 5 failed attempts, 30-min lockout

---

### 📄 user-flow.md

# EventsOS - User Flow Documentation

## Primary User Journey: Event Creation to Post-Event

### 1. Event Organizer Flow

```
START → Login/Register → Dashboard
         ↓
    Create New Event
         ↓
    AI Planning Wizard
         ├─→ Select Event Type
         ├─→ Define Objectives
         ├─→ Set Budget
         └─→ Choose Date/Venue
              ↓
         AI Generates:
         ├─→ Timeline
         ├─→ Task List
         ├─→ Budget Breakdown
         └─→ Vendor Suggestions
              ↓
         Review & Customize
              ↓
         Publish Event
              ↓
    Stakeholder Invitations
         ├─→ Team Members
         ├─→ Vendors
         ├─→ Sponsors
         └─→ Set Permissions
              ↓
    Pre-Event Management
         ├─→ Task Tracking
         ├─→ Communication
         ├─→ Registration Monitoring
         └─→ Sponsor Management
              ↓
    Day-of Execution
         ├─→ Check-in Management
         ├─→ Real-time Updates
         ├─→ Issue Resolution
         └─→ Live Analytics
              ↓
    Post-Event
         ├─→ Feedback Collection
         ├─→ Financial Reconciliation
         ├─→ Impact Reports
         └─→ Archive/Template
              ↓
         END
```

### 2. Attendee Registration Flow

```
START → Event Discovery
         ├─→ Direct Link
         ├─→ Social Media
         └─→ Search
              ↓
         Event Page
              ↓
    Registration Form
         ├─→ Personal Info
         ├─→ Ticket Selection
         ├─→ Add-ons
         └─→ Preferences
              ↓
         Payment
         ├─→ Credit Card
         ├─→ Digital Wallet
         └─→ Invoice (B2B)
              ↓
    Confirmation
         ├─→ Email Receipt
         ├─→ Calendar Invite
         ├─→ Mobile Ticket
         └─→ WhatsApp Update
              ↓
    Pre-Event
         ├─→ Reminders
         ├─→ Updates
         ├─→ Networking
         └─→ Agenda
              ↓
    Event Day
         ├─→ QR Check-in
         ├─→ Real-time Info
         ├─→ Networking
         └─→ Feedback
              ↓
         END
```

### 3. Sponsor Onboarding Flow

```
START → Invitation/Application
              ↓
    Sponsor Portal Login
              ↓
    Package Selection
         ├─→ Review Benefits
         ├─→ Customize Options
         └─→ Budget Approval
              ↓
    Contract & Payment
         ├─→ Digital Signature
         ├─→ Payment Terms
         └─→ Invoice Generation
              ↓
    Activation Planning
         ├─→ Asset Upload
         ├─→ Booth Selection
         ├─→ Staff Registration
         └─→ Lead Goals
              ↓
    Pre-Event Prep
         ├─→ Marketing Approval
         ├─→ Logistics Coordination
         └─→ Training Access
              ↓
    Event Execution
         ├─→ Lead Scanning
         ├─→ Real-time Metrics
         └─→ Support Access
              ↓
    Post-Event
         ├─→ Lead Export
         ├─→ ROI Report
         ├─→ Feedback
         └─→ Renewal Discussion
              ↓
         END
```

## Data Flow Architecture

### Real-time Data Synchronization
```
User Action → Frontend (Next.js)
                ↓
           API Gateway
                ↓
         Supabase Edge Function
                ↓
    ┌───────────┴───────────┐
    │                       │
PostgreSQL             Redis Cache
    │                       │
    └───────────┬───────────┘
                ↓
         WebSocket Broadcast
                ↓
         All Connected Clients
```

### AI Processing Pipeline
```
User Request → Frontend
                ↓
           Validation Layer
                ↓
         CrewAI Orchestrator
                ↓
    ┌───────────┼───────────┐
    │           │           │
Planning    Content    Analytics
Agent       Agent      Agent
    │           │           │
    └───────────┼───────────┘
                ↓
         Result Aggregation
                ↓
         Human Verification
                ↓
         Final Output
```

## Edge Scenarios

### Scenario 1: Event Cancellation
```
Trigger: Organizer Cancels Event
    ↓
System Actions:
├─→ Freeze all transactions
├─→ Notify all stakeholders
├─→ Process refunds
├─→ Update all calendars
├─→ Generate cancellation report
└─→ Archive event data
```

### Scenario 2: Capacity Overflow
```
Trigger: Registration > Capacity
    ↓
System Actions:
├─→ Close registration
├─→ Activate waitlist
├─→ Notify organizer
├─→ Suggest venue upgrade
└─→ Monitor cancellations
```

### Scenario 3: Payment Failure Chain
```
Trigger: Sponsor payment fails
    ↓
System Actions:
├─→ Retry payment (3x)
├─→ Notify sponsor finance
├─→ Grace period (72hrs)
├─→ Downgrade benefits
└─→ Legal notification
```

---

### 📄 implementation.md

# EventsOS - Implementation Methodology

## Development Approach

### Agile Methodology
- **Sprint Duration**: 2 weeks
- **Team Structure**: Cross-functional pods (Frontend, Backend, AI, QA)
- **Ceremonies**: Daily standups, Sprint planning, Retrospectives
- **Tool Stack**: Linear (issues), GitHub (code), Slack (communication)

### Development Principles

#### 1. Test-Driven Development (TDD)
```typescript
// Example: Event creation test
describe('EventCreation', () => {
  it('should create event with AI assistance', async () => {
    const eventData = {
      type: 'runway_show',
      budget: 50000,
      expectedAttendees: 200
    };
    
    const result = await createEventWithAI(eventData);
    
    expect(result.timeline).toBeDefined();
    expect(result.tasks.length).toBeGreaterThan(10);
    expect(result.budgetBreakdown.total).toBeLessThanOrEqual(50000);
  });
});
```

#### 2. Atomic Design Pattern
```
atoms/       → Button, Input, Label
molecules/   → FormField, Card, NavItem  
organisms/   → EventForm, Navigation, Dashboard
templates/   → EventLayout, AuthLayout
pages/       → CreateEvent, EventDetails
```

#### 3. Domain-Driven Design (DDD)
```
domains/
├── event/
│   ├── entities/
│   ├── services/
│   ├── repositories/
│   └── value-objects/
├── user/
├── payment/
└── communication/
```

## Database Design

### Core Schema (Supabase/PostgreSQL)

```sql
-- Multi-tenant foundation
CREATE TABLE organizations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  slug VARCHAR(255) UNIQUE NOT NULL,
  subscription_tier ENUM('free', 'pro', 'enterprise'),
  settings JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Events with RLS
CREATE TABLE events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID REFERENCES organizations(id),
  title VARCHAR(255) NOT NULL,
  type VARCHAR(50) NOT NULL,
  status ENUM('draft', 'published', 'ongoing', 'completed', 'cancelled'),
  start_date TIMESTAMPTZ NOT NULL,
  end_date TIMESTAMPTZ NOT NULL,
  venue_id UUID REFERENCES venues(id),
  capacity INTEGER,
  budget DECIMAL(10,2),
  settings JSONB DEFAULT '{}',
  ai_insights JSONB,
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Row Level Security
ALTER TABLE events ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their organization's events" ON events
  FOR SELECT USING (
    organization_id IN (
      SELECT organization_id FROM organization_members 
      WHERE user_id = auth.uid()
    )
  );
```

### Data Types & Validation

```typescript
// Type definitions with Zod validation
import { z } from 'zod';

export const EventSchema = z.object({
  title: z.string().min(3).max(255),
  type: z.enum(['runway_show', 'trade_show', 'gala', 'pop_up']),
  startDate: z.date().min(new Date()),
  endDate: z.date(),
  capacity: z.number().int().positive().max(100000),
  budget: z.number().positive().max(10000000),
  venue: z.object({
    id: z.string().uuid(),
    name: z.string(),
    address: z.string(),
    coordinates: z.object({
      lat: z.number(),
      lng: z.number()
    })
  })
}).refine(data => data.endDate >= data.startDate, {
  message: "End date must be after start date"
});
```

## Coding Standards

### TypeScript Configuration
```json
{
  "compilerOptions": {
    "target": "ES2022",
    "lib": ["ES2022", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  }
}
```

### Naming Conventions
```typescript
// Files: kebab-case
event-creation.service.ts
event-list.component.tsx

// React Components: PascalCase
export const EventCreationForm: React.FC = () => {};

// Functions: camelCase
export const createEventWithAI = async () => {};

// Constants: UPPER_SNAKE_CASE
export const MAX_EVENT_CAPACITY = 100000;

// Interfaces/Types: PascalCase with 'I' or 'T' prefix
interface IEvent {
  id: string;
  title: string;
}

type TEventStatus = 'draft' | 'published' | 'completed';
```

### API Design Standards

```typescript
// RESTful endpoints with consistent structure
GET    /api/v1/events?limit=10&offset=0
GET    /api/v1/events/:id
POST   /api/v1/events
PUT    /api/v1/events/:id
DELETE /api/v1/events/:id

// Response format
{
  "success": true,
  "data": { /* resource data */ },
  "meta": {
    "total": 100,
    "page": 1,
    "limit": 10
  },
  "errors": []
}

// Error format
{
  "success": false,
  "errors": [
    {
      "code": "VALIDATION_ERROR",
      "field": "email",
      "message": "Invalid email format"
    }
  ]
}
```

---

### 📄 tech-stack.md

# EventsOS - Technology Stack

## Frontend Stack

### Core Framework
| Technology | Version | Purpose | Justification |
|------------|---------|---------|---------------|
| **Next.js** | 14.2.30 | React framework | App Router, SSR, API routes, optimized performance |
| **React** | 18.3.1 | UI library | Industry standard, vast ecosystem, concurrent features |
| **TypeScript** | 5.3.3 | Type safety | Reduces bugs, improves DX, better refactoring |

### UI Framework
| Technology | Version | Purpose | Justification |
|------------|---------|---------|---------------|
| **Material-UI** | 6.5.0 | Component library | Comprehensive components, theming, accessibility |
| **Emotion** | 11.11.4 | CSS-in-JS | MUI requirement, dynamic styling, SSR support |
| **Framer Motion** | 12.23.9 | Animations | Smooth transitions, gesture support, performance |

### State Management
| Technology | Version | Purpose | Justification |
|------------|---------|---------|---------------|
| **Zustand** | 5.0.2 | Global state | Simple API, TypeScript support, devtools |
| **React Query** | 5.62.10 | Server state | Caching, synchronization, offline support |
| **React Hook Form** | 7.58.0 | Form state | Performance, validation, minimal re-renders |

## Backend Stack

### Core Infrastructure
| Technology | Version | Purpose | Justification |
|------------|---------|---------|---------------|
| **Supabase** | Latest | BaaS platform | PostgreSQL, Auth, Realtime, Storage, Edge Functions |
| **PostgreSQL** | 15+ | Database | ACID compliance, JSON support, extensions |
| **Redis** | 7+ | Caching | Performance, pub/sub, session storage |

### API Layer
| Technology | Version | Purpose | Justification |
|------------|---------|---------|---------------|
| **Supabase Edge Functions** | Latest | Serverless compute | Low latency, auto-scaling, TypeScript |
| **PostgREST** | Latest | REST API | Auto-generated from schema, RLS support |
| **GraphQL** | Optional | Alternative API | Complex queries, subscriptions |

### Authentication
| Technology | Version | Purpose | Justification |
|------------|---------|---------|---------------|
| **Supabase Auth** | Latest | Authentication | Built-in providers, MFA, JWT tokens |
| **NextAuth.js** | 4.24.10 | Auth adapter | Session management, provider abstraction |

## AI & Automation Stack

### AI Infrastructure
| Technology | Version | Purpose | Justification |
|------------|---------|---------|---------------|
| **CrewAI** | Latest | Multi-agent system | Agent orchestration, tool integration |
| **LangChain** | Latest | LLM framework | Chain composition, memory management |
| **OpenAI API** | GPT-4 | Language model | Best performance, function calling |
| **Anthropic Claude** | 3.5 | Alternative LLM | Larger context, better reasoning |

### Automation Platform
| Technology | Version | Purpose | Justification |
|------------|---------|---------|---------------|
| **n8n** | Latest | Workflow automation | Visual builder, 400+ integrations |
| **Temporal** | Optional | Workflow orchestration | Complex workflows, durability |
| **Bull** | Latest | Job queues | Redis-based, reliable processing |

### Vector Database
| Technology | Version | Purpose | Justification |
|------------|---------|---------|---------------|
| **pgvector** | Latest | Vector search | PostgreSQL extension, no extra infra |
| **Pinecone** | Alternative | Dedicated vector DB | Better performance at scale |

## Integration Stack

### Communication
| Technology | Version | Purpose | Justification |
|------------|---------|---------|---------------|
| **SendGrid** | Latest | Email delivery | Reliability, analytics, templates |
| **Twilio** | Latest | SMS/WhatsApp | Global reach, WhatsApp Business API |
| **Pusher** | Latest | WebSockets | Managed service, presence channels |

### Payments
| Technology | Version | Purpose | Justification |
|------------|---------|---------|---------------|
| **Stripe** | Latest | Payment processing | Market leader, Connect for marketplaces |
| **Stripe Connect** | Latest | Multi-party payments | Automatic splits, compliance |

### Media & Storage
| Technology | Version | Purpose | Justification |
|------------|---------|---------|---------------|
| **Cloudinary** | Latest | Media CDN | Transformation API, optimization |
| **Supabase Storage** | Latest | File storage | Integrated auth, S3 compatible |

### CRM & Analytics
| Technology | Version | Purpose | Justification |
|------------|---------|---------|---------------|
| **Twenty CRM** | Latest | Contact management | Open source, customizable |
| **PostHog** | Latest | Product analytics | Privacy-first, self-hosted option |
| **Sentry** | Latest | Error tracking | Real-time alerts, performance monitoring |

## Infrastructure & Deployment

### Hosting
| Technology | Version | Purpose | Justification |
|------------|---------|---------|---------------|
| **Vercel** | Latest | Frontend hosting | Next.js optimization, edge network |
| **Supabase Cloud** | Latest | Backend hosting | Managed PostgreSQL, auto-scaling |
| **Cloudflare** | Latest | CDN/Security | DDoS protection, edge workers |

### Monitoring
| Technology | Version | Purpose | Justification |
|------------|---------|---------|---------------|
| **Datadog** | Latest | APM | Full-stack monitoring, logs, metrics |
| **Sentry** | Latest | Error tracking | Real-time alerts, release tracking |
| **LogRocket** | Latest | Session replay | User behavior, debugging |

### CI/CD
| Technology | Version | Purpose | Justification |
|------------|---------|---------|---------------|
| **GitHub Actions** | Latest | CI/CD pipeline | Native integration, free for public |
| **Vercel Deploy** | Latest | Frontend deploys | Preview deployments, rollbacks |
| **Docker** | Latest | Containerization | Consistent environments, portability |

## Development Tools

### Code Quality
| Technology | Version | Purpose | Justification |
|------------|---------|---------|---------------|
| **ESLint** | 8.57.0 | Linting | Code consistency, bug prevention |
| **Prettier** | 3.4.2 | Formatting | Consistent style, team alignment |
| **Husky** | 9.2.0 | Git hooks | Pre-commit checks, quality gates |

### Testing
| Technology | Version | Purpose | Justification |
|------------|---------|---------|---------------|
| **Playwright** | 1.50.0 | E2E testing | Cross-browser, reliable, fast |
| **Vitest** | 2.2.0 | Unit testing | Fast, ESM support, Jest compatible |
| **MSW** | 2.7.0 | API mocking | Intercept requests, offline development |

### Documentation
| Technology | Version | Purpose | Justification |
|------------|---------|---------|---------------|
| **Storybook** | 8.5.0 | Component docs | Interactive documentation, testing |
| **TypeDoc** | 0.27.6 | API docs | Auto-generated from TypeScript |

---

### 📄 project-structure.md

# EventsOS - Project Structure

## Monorepo Architecture

```
eventos/
├── apps/                      # Application packages
│   ├── website/              # Marketing website (Next.js + MUI)
│   │   ├── src/
│   │   │   ├── app/         # App Router pages
│   │   │   ├── components/  # React components
│   │   │   ├── hooks/       # Custom React hooks
│   │   │   ├── lib/         # Utilities and helpers
│   │   │   ├── services/    # API services
│   │   │   ├── stores/      # Zustand stores
│   │   │   └── types/       # TypeScript types
│   │   ├── public/          # Static assets
│   │   └── tests/           # Test files
│   │
│   ├── admin/               # Admin dashboard (Refine + MUI)
│   │   ├── src/
│   │   │   ├── app/        # App Router pages
│   │   │   ├── components/ # Admin components
│   │   │   ├── providers/  # Refine providers
│   │   │   ├── resources/  # Resource definitions
│   │   │   └── types/      # TypeScript types
│   │   └── tests/
│   │
│   └── mobile/              # React Native app (future)
│       └── [TBD]
│
├── packages/                 # Shared packages
│   ├── ui/                  # Shared UI components
│   │   ├── src/
│   │   │   ├── components/
│   │   │   ├── theme/      # MUI theme config
│   │   │   └── utils/
│   │   └── package.json
│   │
│   ├── database/            # Database schemas and migrations
│   │   ├── migrations/
│   │   ├── schemas/
│   │   ├── seeds/
│   │   └── types/
│   │
│   ├── ai-agents/           # CrewAI agent definitions
│   │   ├── agents/
│   │   ├── tools/
│   │   ├── workflows/
│   │   └── prompts/
│   │
│   └── utils/               # Shared utilities
│       ├── auth/
│       ├── api/
│       ├── constants/
│       └── helpers/
│
├── services/                 # Microservices (if needed)
│   ├── notification-service/
│   ├── analytics-service/
│   └── ai-service/
│
├── infrastructure/           # Infrastructure as Code
│   ├── terraform/           # Terraform configs
│   ├── docker/              # Docker configurations
│   └── k8s/                 # Kubernetes manifests
│
├── docs/                     # Documentation
│   ├── api/                 # API documentation
│   ├── guides/              # User guides
│   ├── architecture/        # Architecture decisions
│   └── deployment/          # Deployment guides
│
├── scripts/                  # Build and utility scripts
│   ├── setup.sh
│   ├── deploy.sh
│   └── test-all.sh
│
├── .github/                  # GitHub configurations
│   ├── workflows/           # CI/CD workflows
│   ├── ISSUE_TEMPLATE/
│   └── pull_request_template.md
│
├── configs/                  # Configuration files
│   ├── eslint.config.js
│   ├── prettier.config.js
│   ├── tsconfig.base.json
│   └── vitest.config.ts
│
├── package.json             # Root package.json
├── pnpm-workspace.yaml      # pnpm workspace config
├── turbo.json              # Turborepo config
└── README.md               # Project documentation
```

## File Organization Patterns

### Component Structure
```
components/
├── events/
│   ├── EventCard/
│   │   ├── EventCard.tsx        # Component logic
│   │   ├── EventCard.styles.ts  # Emotion styles
│   │   ├── EventCard.types.ts   # TypeScript types
│   │   ├── EventCard.test.tsx   # Tests
│   │   ├── EventCard.stories.tsx # Storybook
│   │   └── index.ts             # Barrel export
│   └── EventList/
│       └── [similar structure]
```

### Service Layer Pattern
```
services/
├── api/
│   ├── events/
│   │   ├── events.service.ts    # API calls
│   │   ├── events.types.ts      # Types
│   │   └── events.hooks.ts      # React Query hooks
│   └── auth/
│       └── [similar structure]
```

### Store Organization (Zustand)
```
stores/
├── useEventStore.ts        # Event state management
├── useAuthStore.ts         # Auth state
├── useUIStore.ts          # UI state
└── index.ts               # Store exports
```

## Cursor Integration Recommendations

### Workspace Configuration
```json
// .cursor/settings.json
{
  "ai.model": "gpt-4",
  "ai.temperature": 0.7,
  "ai.includeComments": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "typescript.tsdk": "node_modules/typescript/lib",
  "eslint.workingDirectories": [
    { "mode": "auto" }
  ]
}
```

### AI Context Files
```
.cursor/
├── context/
│   ├── architecture.md     # System architecture overview
│   ├── conventions.md      # Coding conventions
│   ├── components.md       # Component library docs
│   └── api.md             # API documentation
```

### Cursor Commands
```bash
# Generate new component
cursor generate component EventCard --template atomic

# Generate API service
cursor generate service events --with-hooks

# Generate database migration
cursor generate migration add-event-analytics

# Run AI code review
cursor review --files "src/**/*.ts" --rules .cursor/rules.md
```

## Import Aliases

### TypeScript Configuration
```json
// tsconfig.json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"],
      "@/components/*": ["src/components/*"],
      "@/hooks/*": ["src/hooks/*"],
      "@/lib/*": ["src/lib/*"],
      "@/services/*": ["src/services/*"],
      "@/stores/*": ["src/stores/*"],
      "@/types/*": ["src/types/*"],
      "@eventos/ui/*": ["packages/ui/src/*"],
      "@eventos/database/*": ["packages/database/*"],
      "@eventos/utils/*": ["packages/utils/*"]
    }
  }
}
```

## Build & Development Scripts

### Package.json Scripts
```json
{
  "scripts": {
    "dev": "turbo run dev",
    "dev:website": "turbo run dev --filter=website",
    "dev:admin": "turbo run dev --filter=admin",
    "build": "turbo run build",
    "test": "turbo run test",
    "test:e2e": "turbo run test:e2e",
    "lint": "turbo run lint",
    "format": "prettier --write \"**/*.{ts,tsx,md,json}\"",
    "db:migrate": "pnpm --filter database migrate",
    "db:seed": "pnpm --filter database seed",
    "storybook": "pnpm --filter ui storybook",
    "analyze": "turbo run analyze"
  }
}
```

## Environment Variables

### Structure
```
.env                    # Shared environment variables
.env.local             # Local overrides (gitignored)
.env.development       # Development environment
.env.production        # Production environment

apps/website/.env.local
apps/admin/.env.local
```

### Variable Naming Convention
```bash
# Public variables (exposed to browser)
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=

# Server-only variables
SUPABASE_SERVICE_KEY=
STRIPE_SECRET_KEY=
SENDGRID_API_KEY=
OPENAI_API_KEY=

# Feature flags
FEATURE_AI_AGENTS=true
FEATURE_ADVANCED_ANALYTICS=false
```

---

### 📄 project-timeline.md

# EventsOS - Project Timeline

## Overview
- **Total Duration**: 24 weeks (6 months)
- **Team Size**: 8-10 developers
- **Methodology**: Agile/Scrum with 2-week sprints

## Phase 1: Foundation (Weeks 1-4)

### Week 1-2: Project Setup & Infrastructure
**Deliverables:**
- [x] Repository setup with monorepo structure
- [x] CI/CD pipeline configuration
- [x] Development environment standardization
- [x] Supabase project initialization
- [x] Authentication system implementation

**Tests:**
- Unit tests for auth flows
- Integration tests for Supabase connection
- E2E test framework setup

**Review Checkpoint:**
- Architecture review with tech lead
- Security audit of auth implementation

### Week 3-4: Core Data Models & APIs
**Deliverables:**
- [ ] Database schema implementation
- [ ] RLS policies configuration
- [ ] Base API endpoints
- [ ] Type generation from database
- [ ] Admin dashboard scaffolding

**Tests:**
- Database migration tests
- API endpoint testing
- RLS policy verification

**Review Checkpoint:**
- Database schema review
- API design review

## Phase 2: Core Features (Weeks 5-12)

### Week 5-6: Event Management MVP
**Deliverables:**
- [ ] Event CRUD operations
- [ ] Event listing and filtering
- [ ] Basic event dashboard
- [ ] Venue management
- [ ] Calendar integration

**Tests:**
- Event creation flow tests
- Calendar sync verification
- Performance tests for listings

**Review Checkpoint:**
- Feature demo to stakeholders
- UX review of event flows

### Week 7-8: Registration & Ticketing
**Deliverables:**
- [ ] Registration form builder
- [ ] Payment integration (Stripe)
- [ ] Ticket generation system
- [ ] QR code implementation
- [ ] Attendee portal

**Tests:**
- Payment flow testing
- Ticket validation tests
- Load testing for registration

**Review Checkpoint:**
- Payment security audit
- Registration flow review

### Week 9-10: Communication Hub
**Deliverables:**
- [ ] Email integration (SendGrid)
- [ ] SMS/WhatsApp setup (Twilio)
- [ ] Notification templates
- [ ] Campaign management
- [ ] Delivery tracking

**Tests:**
- Message delivery tests
- Template rendering tests
- Multi-channel coordination

**Review Checkpoint:**
- Communication workflow review
- Template approval process

### Week 11-12: Analytics Foundation
**Deliverables:**
- [ ] Basic analytics dashboard
- [ ] Event metrics tracking
- [ ] Attendee insights
- [ ] Revenue reporting
- [ ] Export functionality

**Tests:**
- Data accuracy verification
- Report generation tests
- Performance benchmarking

**Review Checkpoint:**
- Analytics accuracy audit
- Dashboard usability review

## Phase 3: AI & Advanced Features (Weeks 13-18)

### Week 13-14: AI Integration
**Deliverables:**
- [ ] CrewAI framework setup
- [ ] Event planning agent
- [ ] Content generation agent
- [ ] Vendor matching agent
- [ ] AI safety measures

**Tests:**
- AI response quality tests
- Token usage monitoring
- Fallback mechanism tests

**Review Checkpoint:**
- AI output quality review
- Cost analysis of AI usage

### Week 15-16: Automation Platform
**Deliverables:**
- [ ] n8n workflow setup
- [ ] Automation templates
- [ ] Trigger configuration
- [ ] Integration connectors
- [ ] Monitoring dashboard

**Tests:**
- Workflow execution tests
- Error handling verification
- Performance impact assessment

**Review Checkpoint:**
- Automation reliability review
- Integration security audit

### Week 17-18: Advanced Features
**Deliverables:**
- [ ] Sponsor portal
- [ ] Advanced analytics
- [ ] Mobile app MVP
- [ ] White-label options
- [ ] API documentation

**Tests:**
- Cross-platform testing
- API integration tests
- White-label functionality

**Review Checkpoint:**
- Feature completeness review
- Mobile app UX review

## Phase 4: Polish & Launch Prep (Weeks 19-22)

### Week 19-20: Performance & Security
**Deliverables:**
- [ ] Performance optimization
- [ ] Security hardening
- [ ] Load testing
- [ ] Penetration testing
- [ ] Compliance verification

**Tests:**
- Load testing (10k users)
- Security penetration tests
- Compliance checklist

**Review Checkpoint:**
- Security audit results
- Performance benchmarks

### Week 21-22: Beta Launch
**Deliverables:**
- [ ] Beta user onboarding
- [ ] Feedback collection system
- [ ] Bug fixes and polish
- [ ] Documentation completion
- [ ] Training materials

**Tests:**
- User acceptance testing
- Beta feedback analysis
- Production readiness

**Review Checkpoint:**
- Beta feedback review
- Go-live decision

## Phase 5: Launch & Scale (Weeks 23-24)

### Week 23: Production Launch
**Deliverables:**
- [ ] Production deployment
- [ ] Marketing website live
- [ ] Customer onboarding
- [ ] Support system active
- [ ] Monitoring alerts

**Tests:**
- Production smoke tests
- Monitoring verification
- Support ticket flow

**Review Checkpoint:**
- Launch readiness checklist
- Day-1 support plan

### Week 24: Post-Launch Optimization
**Deliverables:**
- [ ] Performance tuning
- [ ] User feedback integration
- [ ] Feature prioritization
- [ ] Scaling plan
- [ ] Roadmap v2

**Tests:**
- Production metrics analysis
- User satisfaction surveys
- System stability monitoring

**Review Checkpoint:**
- Launch retrospective
- V2 roadmap approval

## Milestones & Success Metrics

### MVP (Week 12)
- Core event management functional
- Basic registration and ticketing
- Email communications working
- 100 beta users onboarded

### Alpha Release (Week 18)
- AI agents operational
- Automation workflows active
- Advanced analytics available
- 500 active users

### Beta Release (Week 22)
- All features complete
- Performance optimized
- Security audited
- 1,000 active users

### GA Release (Week 24)
- Production stable
- Support operational
- Marketing active
- 5,000 users target

## Risk Mitigation

### Technical Risks
- **AI API Costs**: Implement usage limits and monitoring
- **Scaling Issues**: Load test early and often
- **Integration Failures**: Build fallback mechanisms

### Business Risks
- **User Adoption**: Early beta program with key clients
- **Competition**: Focus on fashion-specific features
- **Compliance**: Regular legal reviews

### Timeline Risks
- **Scope Creep**: Strict MVP definition
- **Technical Debt**: 20% time for refactoring
- **Team Availability**: Cross-training on all components

## Success Criteria

### Technical Success
- 99.9% uptime achieved
- <2s page load times
- Zero critical security issues
- 90%+ test coverage

### Business Success
- 5,000 active users
- $50K MRR achieved
- 4.5+ star user rating
- 10 enterprise clients

### Team Success
- On-time delivery
- Under budget
- High team morale
- Knowledge documented