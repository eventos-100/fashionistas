# EventsOS Custom Instructions

## 🎯 Project Overview
**EventsOS**: AI-powered fashion event management platform  
**Directory**: `/home/sk/fx/eventos`  
**Database**: Supabase (wnjudgmhabzhcttgyxou) - 60+ tables already configured

## 🛠️ Tech Stack (STRICT REQUIREMENTS)

```yaml
# CORE - NEVER CHANGE
ui_framework: "Material-UI v6.5.0"  # ⚠️ NEVER v7
package_manager: "pnpm"             # ⚠️ NEVER npm/yarn
node_version: "18+"                 # NODE_OPTIONS=--max_old_space_size=4096
typescript: "strict mode"           # No 'any' types

# APPLICATIONS
website: "Next.js 14+ App Router"   # Public events, registration
admin: "Refine v4.57.10 + MUI"     # Dashboard, management
database: "Supabase PostgreSQL"     # Auth + RLS + Realtime

# INTEGRATIONS
automation: "n8n workflows"         # All automations here
crm: "Twenty CRM"                  # Shares Supabase DB
email: "SendGrid API"              # Transactional emails
messaging: "WhatsApp Business"      # Real-time notifications
payments: "Stripe"                  # Subscriptions + one-time
media: "Cloudinary"                # Image optimization
ai: "CrewAI + CopilotKit"          # AI agents
```


Project Structure
/home/sk/fx/eventos/
├── apps/
│   ├── website/          # Public event site (Next.js)
│   └── eventos-admin/    # Admin panel (Refine + MUI)
├── packages/
│   ├── ui/              # Shared MUI components
│   ├── database/        # Supabase schemas + RLS
│   └── types/           # Shared TypeScript types
├── automation/
│   ├── n8n/            # Workflow templates
│   └── agents/         # CrewAI definitions
└── .qodo-instructions  # Project-specific Qodo rules

 Website (Public-facing)

Framework: Next.js 14+ (App Router)
UI: Material-UI v6.5.0 (NEVER v7)
Styling: Emotion (comes with MUI)
Pages: Home, Event Listing Event Detail sponsor, models designers with forms, ticketing fashion directory 

Home Page
Sections
Nav bar
hero
about
event details
designers
ticketing
partners
CTA
footer 



 ### Dashboard (Admin)
- **Framework**: Refine v4.57.10
- **UI**: Material-UI v6.5.0 use refine material ui components 
- **Database**: Supabase (PostgreSQL + Auth + RLS)
- **Purpose**: Event management, analytics, operations

## 📊 Database Schema (Already Configured)

### Core Tables (Most Used)
```sql
-- Events System (15 tables)
events, event_schedules, event_logistics, event_staff, event_sponsors
registrations, seat_assignments, event_feedback, event_roi

-- People & Organizations (8 tables)  
organizations, fashion_designers, models, influencers, sponsors
media_partners, users, attendees

-- Financial (5 tables)
payments, invoices, refund_queue, promo_codes, opportunities

-- Communications (6 tables)
notification_queue, notification_templates, social_media_platforms
```

### Key Relationships
- All tables have `organization_id` for multi-tenancy
- Events are the central entity
- RLS policies already configured
- Fashion-specific tables (designers, models) ready

Stakeholders
event organizers
venues
sponsors 
models
fashion designers
ticket buyers

### Core Principles
1. **Platform-Specific**: Every response must be tailored to EventsOS capabilities
2. Core Features - focus on core features setup get this working 100 %
3. Troubleshooting - identify errors and red flags critical and important
4. Production - evaluate each task is it production ready - what is needed any changes improvements
5. **Lifecycle-Aware**: Always map solutions to specific event phases
6. **Integration-First**: Prioritize using existing integrations over custom solutions
7. **ROI-Focused**: Quantify business value and efficiency gains
8. **Fashion-Context**: Consider runway shows, trade shows, and galas
9. Use best practices for Material UI v6 nextjs Refine Supabase Stripe Event Management 

## 🤖 MCP Tools Usage Guide

### File & Project Management
```bash
# Desktop Commander (DC) - Primary tool for file operations
DC: create_directory src/features/runway-show
DC: write_file ShowConfig.tsx "content"
DC: execute_command "pnpm install @mui/x-data-grid"
DC: read_file supabase/migrations/latest.sql
```

### UI Development & Testing
```bash
# Playwright - Test user flows
playwright:browser_navigate "http://localhost:3000/events"
playwright:browser_snapshot  # Visual regression
playwright:browser_click element="Register Button"
playwright:browser_type element="Email Input" text="user@fashion.com"
```

### Documentation & Research
```bash
# MUI MCP - Get component examples
mui-mcp:useMuiDocs ["@mui/material@6.4.12"]
mui-mcp:fetchDocs urls=["data-grid", "date-picker"]

# Context7 - Latest library docs
context7:get-library-docs "/mui/material-ui/v6" topic="tables"

# Firecrawl - Competitor research
firecrawl:firecrawl_search "fashion event registration best practices"
```

### Project Memory
```bash
# OpenMemory - Store decisions & patterns
openmemory:add-memory "Sponsor tiers: Bronze $5k, Silver $10k, Gold $25k, Platinum $50k"
openmemory:search-memories "event check-in flow"
```

## 📋 Common Implementation Patterns

### 1. Event Registration Page (Website)
```typescript
// Next.js 14 App Router + MUI v6
import { Box, TextField, Button } from '@mui/material'
import { useForm } from 'react-hook-form'
import { createClient } from '@/utils/supabase/client'

// Always include:
// - Loading states (Skeleton)
// - Error boundaries
// - Mobile responsive
// - Supabase integration
```

### 2. Admin Dashboard (Refine)
```typescript
// Refine + MUI v6 + Supabase
import { List, useDataGrid } from '@refinedev/mui'
import { DataGrid } from '@mui/x-data-grid'
import { useList } from '@refinedev/core'

// Use Refine hooks for:
// - Data fetching (useList, useOne)
// - Forms (useForm)
// - Tables (useDataGrid)
```

### 3. Database Operations
```sql
-- Always include RLS policies
CREATE POLICY "view_own_events" ON events
  FOR SELECT USING (organization_id = auth.jwt()->>'org_id');

-- Use existing tables
INSERT INTO registrations (event_id, attendee_email, ticket_type)
VALUES ($1, $2, $3);
```

### 4. Automation Workflows
```json
// n8n workflow template
{
  "trigger": "webhook",
  "nodes": [
    {"type": "supabase", "operation": "insert"},
    {"type": "sendgrid", "template": "welcome"},
    {"type": "whatsapp", "message": "confirmation"}
  ]
}
```

## 🎯 Task-Specific Guidance

| Task | Tools & Approach |
|------|------------------|
| **Create Feature** | DC + Qodo gen + MUI MCP for examples |
| **Test UI Flow** | Playwright for automation + screenshots |
| **Add Table** | DC write migration + check existing schema |
| **Research** | Firecrawl + OpenMemory to store findings |
| **Documentation** | Context7 for latest + Qodo docs |
| **Automation** | n8n workflow + webhook triggers |

## ⚡ Quick Commands

```bash
# Development
cd /home/sk/fx/eventos && pnpm dev        # Website
cd /home/sk/fx/eventos && pnpm dev:admin  # Admin

# Database
pnpm supabase migration new feature_name
pnpm supabase db push

# Testing
pnpm test
pnpm test:e2e

# Build
pnpm build
pnpm build:admin
```

## 🚫 Critical Rules

1. **NEVER** use MUI v7 (only v6.5.0)
2. **NEVER** use npm/yarn (only pnpm)
3. **NEVER** create new auth (use Supabase Auth)
4. **NEVER** skip RLS policies
5. **NEVER** create tables without checking schema first
6. **ALWAYS** use existing 60+ tables when possible
7. **ALWAYS** include organization_id for multi-tenancy

## 📱 Fashion Event Context

Always consider:
- **Runway Shows**: Seating charts, model lineups, live streaming
- **Trade Shows**: Booth management, lead scanning, buyer tracking  
- **Galas**: Table assignments, auction systems, donor levels
- **VIP Management**: Special access, exclusive areas, concierge

## ✅ Feature Checklist

Every feature must have:
- [ ] MUI v6.5.0 components
- [ ] Loading states (Skeleton)
- [ ] Error handling
- [ ] Mobile responsive
- [ ] Supabase integration
- [ ] RLS policies
- [ ] n8n automation
- [ ] TypeScript types
- [ ] 80% test coverage

---
Final Reminders

1. **Always consider the full event lifecycle** - Solutions should scale from planning to post-event
2. **Prioritize existing integrations** - Use Twenty CRM, n8n, and Supabase before custom solutions
3. **Think in workflows** - Every feature should trigger appropriate automations
4. **Measure everything** - Include KPIs and success metrics in recommendations
5. **Fashion event context** - Remember runway shows, buyer management, and VIP experiences

