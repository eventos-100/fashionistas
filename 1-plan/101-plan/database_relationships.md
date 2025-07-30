# Database Relationships & Architecture

## Core Entity Relationships

```
Organizations (1) ──────────────── (M) Users
     │                                │
     │                                │
     ├── (M) Events ─────────────────┤
     │      │                        │
     │      ├── (M) Tasks ───────────┤
     │      ├── (M) Budgets          │
     │      ├── (M) Marketing        │
     │      ├── (M) Sponsorships     │
     │      └── (M) Tickets          │
     │                               │
     ├── (M) Venues                  │
     ├── (M) Vendors                 │
     ├── (M) AI Agents               │
     └── (M) Social Media Accounts   │
```

## Detailed Relationship Map

### Event Management Core
- **Organizations** → **Users** (1:M) - Multi-tenant user management
- **Organizations** → **Events** (1:M) - Events belong to organizations
- **Events** → **Event Team Members** (1:M) - Team assignments per event
- **Events** → **Tasks** (1:M) - Project management tasks
- **Events** → **Budgets** (1:M) - Budget line items
- **Events** → **Vendor Contracts** (1:M) - Vendor relationships

### Marketing & Social Media
- **Events** → **Marketing Campaigns** (1:M) - Campaign management
- **Marketing Campaigns** → **Social Media Posts** (1:M) - Content publishing
- **Marketing Campaigns** → **Influencer Campaigns** (1:M) - Influencer partnerships
- **Organizations** → **Social Media Accounts** (1:M) - Connected platforms

### Sponsorship Management
- **Events** → **Sponsorship Packages** (1:M) - Available packages
- **Sponsorship Packages** → **Sponsorship Deals** (1:M) - Sold sponsorships
- **Sponsorship Deals** → **Sponsor Onboarding Steps** (1:M) - Onboarding workflow
- **Sponsorship Deals** → **Sponsor Activations** (1:M) - Benefit delivery

### Ticketing & Sales
- **Events** → **Ticket Categories** (1:M) - Ticket types
- **Ticket Categories** → **Pricing Rules** (1:M) - Dynamic pricing
- **Events** → **Orders** (1:M) - Ticket purchases
- **Orders** → **Order Items** (1:M) - Individual tickets

### AI & Automation
- **Organizations** → **AI Agents** (1:M) - AI configuration
- **AI Agents** → **AI Conversations** (1:M) - Conversation history
- **AI Agents** → **AI Generated Content** (1:M) - Content creation
- **Organizations** → **Automation Workflows** (1:M) - Workflow definitions

## Key Foreign Key Constraints

### Cascading Deletes
- Organization deletion cascades to all related entities
- Event deletion cascades to all event-specific data
- Order deletion cascades to order items

### Referential Integrity
- All user references maintain data consistency
- Event-related tables enforce event existence
- Financial data maintains audit trails

## Junction Tables (Many-to-Many)

### Event Team Members
- Links Users to Events with specific roles
- Manages permissions and access levels
- Tracks time and compensation

### Sponsor Onboarding Steps
- Manages multi-step sponsor onboarding
- Tracks completion status
- Supports custom workflows

### Order Items
- Links Orders to Ticket Categories
- Manages individual ticket information
- Supports multiple ticket types per order

## Data Flow Architecture

### Event Creation Flow
1. User creates Event
2. System generates Tasks from Template
3. Budget items created
4. Team members assigned
5. Marketing campaigns initiated
6. Sponsorship packages created

### Sponsorship Sales Flow
1. Prospect identified/imported
2. Deal created with Package
3. Proposal sent and tracked
4. Contract signed
5. Onboarding steps initiated
6. Activations scheduled and executed

### Ticket Sales Flow
1. Ticket Categories defined
2. Pricing Rules configured
3. Orders processed
4. Payments handled
5. Tickets generated
6. Analytics tracked