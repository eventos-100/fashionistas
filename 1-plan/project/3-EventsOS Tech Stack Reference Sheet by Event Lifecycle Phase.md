# 📦 EventsOS Tech Stack Reference Sheet by Event Lifecycle Phase

## 🎨 UI & Application Framework

### Material UI v6.5.0 (⚠️ NOT v7)

| Lifecycle Phase | Integration/Usage | Use Cases | AI Agent |
|----------------|-------------------|-----------|----------|
| **Event Planning** | Dashboard components for budget visualization | 1. Budget allocation charts with MUI Charts<br>2. Venue comparison cards with Card components<br>3. Timeline visualization with Stepper<br>4. Team assignment DataGrid<br>5. Risk matrix heatmap | Budget Optimization Agent |
| **Event Management** | Vendor and sponsor management interfaces | 1. Vendor directory with filterable DataGrid<br>2. Contract status dashboard with Progress indicators<br>3. Deliverables kanban board<br>4. Sponsor tier comparison table<br>5. Communication timeline | Vendor Scoring Agent |
| **Production & Operations** | Staff coordination and task management | 1. Run-of-show timeline editor<br>2. Staff assignment matrix<br>3. Equipment checklist with Checkbox groups<br>4. Floor plan viewer with overlays<br>5. Technical requirements forms | Production Scheduler Agent |
| **Live Event** | Real-time monitoring dashboards | 1. Live attendance gauges<br>2. Incident report forms with Alert components<br>3. Check-in kiosk interface<br>4. Crowd density heatmaps<br>5. Support ticket queue | Incident Response Agent |
| **Post-Event** | Analytics and reporting interfaces | 1. Revenue breakdown charts<br>2. Feedback sentiment cards<br>3. Photo gallery with ImageList<br>4. Survey response tables<br>5. Export report builders | Performance Analysis Agent |
| **Sponsorship Sales** | CRM and pipeline management | 1. Deal pipeline with drag-drop cards<br>2. Proposal builder with templates<br>3. ROI calculator interfaces<br>4. Contact relationship maps<br>5. Revenue forecasting charts | Sponsor Matching Agent |
| **Ticketing & CRM** | Purchase flows and attendee management | 1. Ticket selection wizard<br>2. Seat map picker<br>3. Cart with Stepper checkout<br>4. Order history DataGrid<br>5. Attendee profile cards | Dynamic Pricing Agent |
| **Marketing** | Campaign creation and monitoring | 1. Email template builder<br>2. Social media preview cards<br>3. Campaign performance dashboard<br>4. A/B test result comparisons<br>5. Content calendar grid | Content Optimization Agent |

### Next.js 14+ with Refine v4.57.10

| Lifecycle Phase | Integration/Usage | Use Cases | AI Agent |
|----------------|-------------------|-----------|----------|
| **Event Planning** | Admin dashboard foundation | 1. SSR for fast budget dashboards<br>2. API routes for venue availability checks<br>3. Dynamic routing for event workspaces<br>4. Static generation for planning templates<br>5. Middleware for role-based access | Planning Assistant Agent |
| **Event Management** | CRUD operations and data management | 1. Refine resources for vendor management<br>2. Custom hooks for sponsor data<br>3. Form validation for contracts<br>4. Bulk actions for deliverables<br>5. Export functionality for reports | Data Sync Agent |
| **Production & Operations** | Real-time updates and collaboration | 1. WebSocket connections for live updates<br>2. Optimistic UI for task updates<br>3. File upload for production assets<br>4. Print-friendly run-of-show pages<br>5. Mobile-responsive staff apps | Collaboration Agent |
| **Live Event** | Performance and scalability | 1. Edge functions for check-in processing<br>2. ISR for event info pages<br>3. API rate limiting for stability<br>4. CDN integration for assets<br>5. Error boundaries for resilience | Performance Monitor Agent |
| **Post-Event** | Data processing and archival | 1. Background jobs for report generation<br>2. Data export pipelines<br>3. Survey response processing<br>4. Content archival workflows<br>5. Analytics aggregation | Data Processing Agent |

## 💾 Database & Backend

### Supabase (PostgreSQL + Realtime + Auth + RLS)

| Lifecycle Phase | Integration/Usage | Use Cases | AI Agent |
|----------------|-------------------|-----------|----------|
| **Event Planning** | Core data storage and permissions | 1. RLS policies for multi-tenant events<br>2. Real-time budget collaboration<br>3. Venue availability tracking<br>4. Team permission management<br>5. Document version control | Security Policy Agent |
| **Event Management** | Relationship management and tracking | 1. Foreign keys for vendor relationships<br>2. Sponsor package configurations<br>3. Task dependency tracking<br>4. Contract milestone alerts<br>5. Communication logs | Relationship Mapping Agent |
| **Production & Operations** | Live synchronization | 1. Real-time run-of-show updates<br>2. Staff check-in tracking<br>3. Equipment allocation<br>4. Production timeline sync<br>5. Broadcast changes to all devices | Sync Coordination Agent |
| **Live Event** | High-performance operations | 1. Edge Functions for QR validation<br>2. Real-time attendance counters<br>3. Incident report streaming<br>4. Live polling results<br>5. Connection pooling for scale | Live Operations Agent |
| **Post-Event** | Analytics and archival | 1. Materialized views for reports<br>2. Time-series event metrics<br>3. Feedback aggregation<br>4. Financial reconciliation<br>5. Data retention policies | Analytics Engine Agent |
| **Sponsorship Sales** | CRM integration and tracking | 1. Sponsor interaction history<br>2. Deal pipeline stages<br>3. Revenue attribution<br>4. Renewal predictions<br>5. Commission calculations | Sales Intelligence Agent |
| **Ticketing & CRM** | Transaction processing | 1. ACID compliance for payments<br>2. Inventory management<br>3. Cart session handling<br>4. Attendee deduplication<br>5. Refund processing | Transaction Monitor Agent |
| **Marketing** | Campaign data and personalization | 1. Audience segmentation queries<br>2. Email open tracking<br>3. UTM parameter storage<br>4. A/B test results<br>5. Content performance metrics | Marketing Analytics Agent |

## 👥 CRM Platform

### Twenty CRM

| Lifecycle Phase | Integration/Usage | Use Cases | AI Agent |
|----------------|-------------------|-----------|----------|
| **Event Planning** | Stakeholder management | 1. Track venue contacts and history<br>2. Manage planning team members<br>3. Store vendor relationships<br>4. Document sponsor prospects<br>5. Link budget approvers | Contact Enrichment Agent |
| **Event Management** | Communication tracking | 1. Log all sponsor touchpoints<br>2. Track vendor negotiations<br>3. Manage speaker relationships<br>4. Document partner agreements<br>5. Schedule follow-ups | Communication Logger Agent |
| **Production & Operations** | Operational contacts | 1. Staff contact database<br>2. Emergency contact lists<br>3. Vendor on-site contacts<br>4. Technical support numbers<br>5. Venue coordinator details | Contact Sync Agent |
| **Live Event** | Real-time support | 1. VIP attendee management<br>2. Press contact handling<br>3. Sponsor rep check-ins<br>4. Emergency escalations<br>5. Lost badge support | VIP Concierge Agent |
| **Post-Event** | Relationship nurturing | 1. Thank you note automation<br>2. Survey distribution lists<br>3. Lead qualification<br>4. Renewal reminders<br>5. Reference requests | Nurture Campaign Agent |
| **Sponsorship Sales** | Pipeline management | 1. Deal stage tracking<br>2. Proposal version control<br>3. Decision maker mapping<br>4. Competitive intelligence<br>5. Close probability scoring | Deal Intelligence Agent |

## ✉️ Communication Tools

### SendGrid

| Lifecycle Phase | Integration/Usage | Use Cases | AI Agent |
|----------------|-------------------|-----------|----------|
| **Event Planning** | Internal communications | 1. Team onboarding emails<br>2. Venue confirmation notices<br>3. Budget approval requests<br>4. Planning milestone reminders<br>5. Vendor RFP distribution | Email Automation Agent |
| **Event Management** | Stakeholder updates | 1. Sponsor welcome packages<br>2. Vendor instruction emails<br>3. Speaker confirmations<br>4. Schedule change alerts<br>5. Contract reminders | Template Generation Agent |
| **Production & Operations** | Operational emails | 1. Staff shift schedules<br>2. Load-in instructions<br>3. Parking passes<br>4. Technical requirements<br>5. Final briefings | Broadcast Coordinator Agent |
| **Live Event** | Real-time notifications | 1. Check-in confirmations<br>2. Session reminders<br>3. Emergency broadcasts<br>4. Schedule updates<br>5. Thank you messages | Real-time Messenger Agent |
| **Post-Event** | Follow-up campaigns | 1. Survey invitations<br>2. Photo gallery links<br>3. Certificate delivery<br>4. Recap newsletters<br>5. Save-the-date for next event | Follow-up Automation Agent |
| **Sponsorship Sales** | Sales communications | 1. Proposal delivery<br>2. Contract sending<br>3. Invoice distribution<br>4. ROI reports<br>5. Renewal offers | Sales Email Agent |
| **Ticketing & CRM** | Transactional emails | 1. Order confirmations<br>2. E-ticket delivery<br>3. Cart abandonment<br>4. Payment receipts<br>5. Refund notices | Transaction Email Agent |
| **Marketing** | Campaign delivery | 1. Early bird announcements<br>2. Speaker reveals<br>3. Countdown series<br>4. Last chance emails<br>5. Content digests | Campaign Delivery Agent |

### WhatsApp Business API

| Lifecycle Phase | Integration/Usage | Use Cases | AI Agent |
|----------------|-------------------|-----------|----------|
| **Event Planning** | Quick updates | 1. Venue visit coordination<br>2. Budget approval alerts<br>3. Team availability polls<br>4. Vendor quick questions<br>5. Planning reminders | WhatsApp Coordinator Agent |
| **Event Management** | Instant communication | 1. Sponsor check-ins<br>2. Speaker confirmations<br>3. Vendor updates<br>4. Schedule changes<br>5. Document sharing | Instant Messaging Agent |
| **Production & Operations** | On-site coordination | 1. Staff arrival confirmations<br>2. Setup progress updates<br>3. Equipment delivery tracking<br>4. Technical issue alerts<br>5. Crew group chats | Production Chat Agent |
| **Live Event** | Attendee support | 1. QR ticket delivery<br>2. Parking instructions<br>3. Lost and found<br>4. Emergency alerts<br>5. Concierge services | WhatsApp Concierge Agent |
| **Post-Event** | Quick feedback | 1. Instant polls<br>2. Photo sharing<br>3. Quick testimonials<br>4. Lost item claims<br>5. Thank you messages | Feedback Collection Agent |

## 🤖 AI & Automation Tools

### CrewAI

| Lifecycle Phase | Integration/Usage | Use Cases | AI Agent |
|----------------|-------------------|-----------|----------|
| **Event Planning** | Multi-agent planning | 1. Venue selection crew comparing options<br>2. Budget optimization team<br>3. Risk assessment committee<br>4. Timeline planning squad<br>5. Vendor evaluation panel | Planning Crew Orchestrator |
| **Event Management** | Task orchestration | 1. Content planning crew<br>2. Sponsor matching team<br>3. Schedule optimization agents<br>4. Contract review committee<br>5. Communication drafting team | Management Crew Leader |
| **Production & Operations** | Production coordination | 1. Technical setup crew<br>2. Staff scheduling team<br>3. Equipment allocation agents<br>4. Safety inspection squad<br>5. Run-of-show reviewers | Production Crew Manager |
| **Live Event** | Real-time response teams | 1. Incident response crew<br>2. Customer service team<br>3. Technical support squad<br>4. VIP handling agents<br>5. Social media monitors | Live Event Crew Captain |
| **Post-Event** | Analysis and follow-up | 1. Data analysis crew<br>2. Content repurposing team<br>3. Feedback processing agents<br>4. Financial review committee<br>5. Improvement planning squad | Post-Event Crew Analyst |

### CopilotKit

| Lifecycle Phase | Integration/Usage | Use Cases | AI Agent |
|----------------|-------------------|-----------|----------|
| **Event Planning** | Planning assistance | 1. Budget form autocomplete<br>2. Venue requirement suggestions<br>3. Timeline template filling<br>4. Risk factor predictions<br>5. Team role recommendations | Planning Copilot |
| **Event Management** | Management support | 1. Email draft assistance<br>2. Contract clause suggestions<br>3. Task description writing<br>4. Sponsor benefit ideas<br>5. Schedule optimization tips | Management Copilot |
| **Production & Operations** | Production help | 1. Checklist generation<br>2. Staff instruction writing<br>3. Technical spec assistance<br>4. Safety protocol suggestions<br>5. Equipment list building | Production Copilot |
| **Live Event** | Live support | 1. Incident report writing<br>2. Announcement drafting<br>3. FAQ instant answers<br>4. Problem solution suggestions<br>5. Guest query responses | Event Day Copilot |
| **Post-Event** | Analysis assistance | 1. Report writing help<br>2. Survey question suggestions<br>3. Thank you note drafting<br>4. Insight summarization<br>5. Improvement recommendations | Analysis Copilot |

### Claude Desktop & OpenAI

| Lifecycle Phase | Integration/Usage | Use Cases | AI Agent |
|----------------|-------------------|-----------|----------|
| **Event Planning** | Content generation | 1. Event concept development<br>2. Marketing copy creation<br>3. Sponsor pitch writing<br>4. Budget justifications<br>5. Risk mitigation plans | Content Creation Agent |
| **Event Management** | Communication drafting | 1. Vendor emails<br>2. Sponsor proposals<br>3. Speaker invitations<br>4. Press releases<br>5. Schedule descriptions | Communication Agent |
| **Marketing** | Campaign creation | 1. Social media posts<br>2. Email campaigns<br>3. Blog articles<br>4. Ad copy<br>5. SEO content | Marketing Content Agent |

## 🔄 Automation & Integration

### n8n

| Lifecycle Phase | Integration/Usage | Use Cases | AI Agent |
|----------------|-------------------|-----------|----------|
| **Event Planning** | System integration | 1. Sync venue data from APIs<br>2. Budget approval workflows<br>3. Team onboarding automation<br>4. Document generation<br>5. Calendar synchronization | Integration Orchestrator |
| **Event Management** | Process automation | 1. Contract reminder workflows<br>2. Sponsor data sync<br>3. Task creation from emails<br>4. Status update broadcasts<br>5. Deadline notifications | Process Automation Agent |
| **Production & Operations** | Operational workflows | 1. Staff schedule distribution<br>2. Equipment tracking sync<br>3. Vendor payment triggers<br>4. Check-in list updates<br>5. Technical test scheduling | Operations Workflow Agent |
| **Live Event** | Real-time automations | 1. Check-in to CRM sync<br>2. Incident escalation flows<br>3. Social media monitoring<br>4. Attendance tracking<br>5. Emergency notifications | Live Automation Agent |
| **Post-Event** | Follow-up workflows | 1. Survey distribution automation<br>2. Thank you note sending<br>3. Financial reconciliation<br>4. Content archival<br>5. Lead distribution | Follow-up Workflow Agent |
| **Sponsorship Sales** | Sales automation | 1. Lead scoring workflows<br>2. Proposal generation<br>3. Contract status updates<br>4. Payment reminders<br>5. Renewal campaigns | Sales Automation Agent |
| **Ticketing & CRM** | Transaction workflows | 1. Order to CRM sync<br>2. Abandoned cart recovery<br>3. Refund processing<br>4. Ticket delivery<br>5. Upsell campaigns | Transaction Workflow Agent |
| **Marketing** | Marketing automation | 1. Campaign scheduling<br>2. Social media posting<br>3. Email list segmentation<br>4. Analytics reporting<br>5. Content distribution | Marketing Workflow Agent |

### Stripe

| Lifecycle Phase | Integration/Usage | Use Cases | AI Agent |
|----------------|-------------------|-----------|----------|
| **Event Planning** | Financial setup | 1. Payment account creation<br>2. Fee structure planning<br>3. Currency configuration<br>4. Tax setup<br>5. Payout scheduling | Payment Setup Agent |
| **Sponsorship Sales** | Sponsor billing | 1. Invoice generation<br>2. Payment plan setup<br>3. Recurring billing<br>4. Custom pricing<br>5. Commission splitting | Sponsor Billing Agent |
| **Ticketing & CRM** | Ticket sales | 1. Checkout processing<br>2. Group discounts<br>3. Early bird pricing<br>4. Promo codes<br>5. Mobile payments | Sales Processing Agent |
| **Live Event** | On-site payments | 1. Merchandise sales<br>2. Upgrade processing<br>3. Donation collection<br>4. Tap-to-pay setup<br>5. Cash reconciliation | POS Integration Agent |
| **Post-Event** | Financial reconciliation | 1. Settlement reports<br>2. Refund processing<br>3. Chargeback handling<br>4. Tax reporting<br>5. Payout verification | Financial Reconciliation Agent |

### Cloudinary

| Lifecycle Phase | Integration/Usage | Use Cases | AI Agent |
|----------------|-------------------|-----------|----------|
| **Event Planning** | Asset preparation | 1. Venue photo optimization<br>2. Speaker headshot processing<br>3. Sponsor logo formatting<br>4. Floor plan storage<br>5. Document conversion | Asset Preparation Agent |
| **Event Management** | Content management | 1. Marketing asset library<br>2. Sponsor kit assembly<br>3. Badge photo processing<br>4. Signage preparation<br>5. Program design storage | Content Management Agent |
| **Production & Operations** | Production assets | 1. Stage design renders<br>2. Technical diagrams<br>3. Staff photo IDs<br>4. Venue maps<br>5. Safety signage | Production Asset Agent |
| **Live Event** | Real-time media | 1. Live photo uploads<br>2. Social media optimization<br>3. Press kit delivery<br>4. Digital signage updates<br>5. Stream thumbnails | Live Media Agent |
| **Post-Event** | Media archival | 1. Event photo galleries<br>2. Video highlight reels<br>3. Testimonial videos<br>4. Recap presentations<br>5. Archive organization | Media Archive Agent |
| **Marketing** | Campaign assets | 1. Social media graphics<br>2. Email headers<br>3. Banner ads<br>4. Video teasers<br>5. Website images | Marketing Asset Agent |

## 📊 Integration Architecture Summary

### Key Integration Points

1. **Supabase ↔ Twenty CRM**: Bidirectional sync of contacts and interactions
2. **n8n ↔ All Services**: Central automation hub connecting all tools
3. **Stripe ↔ Supabase**: Real-time payment status updates
4. **SendGrid ↔ WhatsApp**: Coordinated multi-channel messaging
5. **Cloudinary ↔ Next.js**: CDN-optimized media delivery
6. **CrewAI ↔ CopilotKit**: AI agent collaboration for complex tasks

### Version Control & Dependencies

```bash
# Package installation (use pnpm ONLY)
pnpm add @mui/material@6.5.0 @emotion/react @emotion/styled
pnpm add @refinedev/core@4.57.10 @refinedev/mui @refinedev/supabase
pnpm add @supabase/supabase-js@latest
pnpm add stripe @sendgrid/mail
```

### Security Considerations

- All API keys stored in environment variables
- Supabase RLS policies enforced on all tables
- Stripe webhook signature verification required
- WhatsApp message encryption enabled
- Cloudinary signed URLs for sensitive content