# 🗄️ Supabase Database Schema: Event Management System

## Overview

This schema supports a multi-vertical event management platform with support for Fashion Week, Tech Summits, Cultural Events, and VIP experiences. It includes tables for events, stakeholders, ticketing, sponsorships, content management, and AI agent tracking.

## Core Tables

### 🏢 Organizations & Users

```sql
-- Organizations table for event companies, venues, sponsors
CREATE TABLE organizations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('event_organizer', 'venue', 'sponsor', 'vendor', 'media_partner')),
  industry TEXT,
  size TEXT CHECK (size IN ('startup', 'small', 'medium', 'large', 'enterprise')),
  website TEXT,
  social_media JSONB DEFAULT '{}', -- {instagram: "@handle", linkedin: "company"}
  contact_info JSONB DEFAULT '{}', -- {email, phone, address}
  verification_status TEXT DEFAULT 'pending' CHECK (verification_status IN ('pending', 'verified', 'rejected')),
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Users with multi-role support
CREATE TABLE users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT UNIQUE NOT NULL,
  full_name TEXT,
  phone TEXT,
  organization_id UUID REFERENCES organizations(id),
  primary_role TEXT DEFAULT 'attendee' CHECK (primary_role IN ('organizer', 'sponsor', 'vendor', 'attendee', 'influencer', 'media', 'crew')),
  additional_roles TEXT[] DEFAULT '{}',
  preferences JSONB DEFAULT '{}', -- Language, notifications, interests
  verification_status TEXT DEFAULT 'unverified' CHECK (verification_status IN ('unverified', 'email_verified', 'phone_verified', 'fully_verified')),
  profile_image_url TEXT,
  social_handles JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- User roles per event (many-to-many with context)
CREATE TABLE user_event_roles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  event_id UUID REFERENCES events(id) ON DELETE CASCADE,
  role TEXT NOT NULL CHECK (role IN ('organizer', 'sponsor', 'vendor', 'attendee', 'speaker', 'model', 'crew', 'media')),
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'banned')),
  permissions JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, event_id, role)
);
```

### 🎪 Events & Listings

```sql
-- Main events table supporting multiple event types
CREATE TABLE events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID REFERENCES organizations(id) NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  event_type TEXT NOT NULL CHECK (event_type IN ('fashion_week', 'tech_summit', 'cultural_festival', 'music_concert', 'product_launch', 'vip_experience')),
  status TEXT DEFAULT 'draft' CHECK (status IN ('draft', 'published', 'sold_out', 'cancelled', 'completed')),
  
  -- Dates and timing
  start_date TIMESTAMPTZ NOT NULL,
  end_date TIMESTAMPTZ NOT NULL,
  registration_deadline TIMESTAMPTZ,
  early_bird_deadline TIMESTAMPTZ,
  
  -- Location
  venue_info JSONB NOT NULL, -- {name, address, coordinates, capacity, amenities}
  location_type TEXT DEFAULT 'physical' CHECK (location_type IN ('physical', 'virtual', 'hybrid')),
  
  -- Pricing and capacity
  base_price DECIMAL(10,2),
  currency TEXT DEFAULT 'USD',
  total_capacity INTEGER,
  available_capacity INTEGER,
  
  -- Content and branding
  images JSONB DEFAULT '[]', -- Array of image URLs
  videos JSONB DEFAULT '[]',
  branding JSONB DEFAULT '{}', -- Colors, logos, themes
  
  -- Configuration
  ticket_tiers JSONB DEFAULT '[]', -- Pricing tiers configuration
  features JSONB DEFAULT '{}', -- Event-specific features
  requirements JSONB DEFAULT '{}', -- Age limits, dress code, etc.
  
  -- Social and marketing
  hashtags TEXT[],
  social_links JSONB DEFAULT '{}',
  marketing_config JSONB DEFAULT '{}',
  
  -- AI and automation
  ai_agent_config JSONB DEFAULT '{}',
  automation_settings JSONB DEFAULT '{}',
  
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Event sessions/stages for multi-day or multi-stage events
CREATE TABLE event_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  event_id UUID REFERENCES events(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  session_type TEXT CHECK (session_type IN ('main_stage', 'workshop', 'networking', 'runway_show', 'presentation', 'afterparty')),
  start_time TIMESTAMPTZ NOT NULL,
  end_time TIMESTAMPTZ NOT NULL,
  venue_info JSONB, -- Can override main event venue
  capacity INTEGER,
  speakers JSONB DEFAULT '[]', -- Array of speaker/performer info
  requirements JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

### 🎟️ Ticketing & Payments

```sql
-- Ticket tiers and pricing
CREATE TABLE ticket_tiers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  event_id UUID REFERENCES events(id) ON DELETE CASCADE,
  name TEXT NOT NULL, -- "Early Bird", "VIP", "General Admission"
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  original_price DECIMAL(10,2), -- For discount tracking
  currency TEXT DEFAULT 'USD',
  total_quantity INTEGER NOT NULL,
  sold_quantity INTEGER DEFAULT 0,
  available_quantity INTEGER GENERATED ALWAYS AS (total_quantity - sold_quantity) STORED,
  
  -- Availability windows
  sale_start TIMESTAMPTZ,
  sale_end TIMESTAMPTZ,
  
  -- Tier configuration
  tier_type TEXT CHECK (tier_type IN ('early_bird', 'regular', 'vip', 'premium', 'group', 'student', 'media')),
  benefits JSONB DEFAULT '[]', -- Array of included benefits
  restrictions JSONB DEFAULT '{}', -- Age limits, etc.
  
  -- Dynamic pricing
  dynamic_pricing_enabled BOOLEAN DEFAULT false,
  price_adjustment_rules JSONB DEFAULT '{}',
  
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Individual ticket purchases
CREATE TABLE tickets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  ticket_tier_id UUID REFERENCES ticket_tiers(id),
  event_id UUID REFERENCES events(id),
  purchaser_id UUID REFERENCES users(id),
  attendee_info JSONB NOT NULL, -- {name, email, phone, dietary_restrictions}
  
  -- Purchase details
  purchase_price DECIMAL(10,2) NOT NULL,
  fees DECIMAL(10,2) DEFAULT 0,
  total_paid DECIMAL(10,2) NOT NULL,
  currency TEXT DEFAULT 'USD',
  payment_status TEXT DEFAULT 'pending' CHECK (payment_status IN ('pending', 'paid', 'refunded', 'failed')),
  payment_method TEXT,
  stripe_payment_intent_id TEXT,
  
  -- Ticket status
  status TEXT DEFAULT 'valid' CHECK (status IN ('valid', 'used', 'cancelled', 'refunded', 'transferred')),
  qr_code TEXT UNIQUE, -- Generated QR code for entry
  check_in_time TIMESTAMPTZ,
  check_in_location TEXT,
  
  -- Transfer and resale
  transfer_history JSONB DEFAULT '[]',
  resale_allowed BOOLEAN DEFAULT false,
  
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Payment transactions
CREATE TABLE payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  ticket_id UUID REFERENCES tickets(id),
  event_id UUID REFERENCES events(id),
  user_id UUID REFERENCES users(id),
  
  -- Payment details
  amount DECIMAL(10,2) NOT NULL,
  fees DECIMAL(10,2) DEFAULT 0,
  net_amount DECIMAL(10,2) NOT NULL,
  currency TEXT DEFAULT 'USD',
  
  -- Payment processing
  payment_method TEXT NOT NULL, -- 'stripe', 'pse', 'efecty', 'nequi'
  external_payment_id TEXT, -- Stripe payment intent, PSE reference, etc.
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'completed', 'failed', 'refunded')),
  
  -- Platform fees and revenue sharing
  platform_fee DECIMAL(10,2) DEFAULT 0,
  organizer_payout DECIMAL(10,2),
  payout_status TEXT DEFAULT 'pending' CHECK (payout_status IN ('pending', 'paid', 'on_hold')),
  
  metadata JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### 🤝 Sponsorships & Partnerships

```sql
-- Sponsor packages and opportunities
CREATE TABLE sponsorship_packages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  event_id UUID REFERENCES events(id) ON DELETE CASCADE,
  package_name TEXT NOT NULL, -- "Title Sponsor", "Gold", "Silver", "Media Partner"
  description TEXT,
  price DECIMAL(10,2),
  currency TEXT DEFAULT 'USD',
  
  -- Package benefits
  benefits JSONB NOT NULL DEFAULT '[]', -- Array of included benefits
  deliverables JSONB DEFAULT '[]', -- What sponsor receives
  requirements JSONB DEFAULT '{}', -- What sponsor must provide
  
  -- Availability
  total_slots INTEGER DEFAULT 1,
  available_slots INTEGER DEFAULT 1,
  
  -- Package type and tier
  package_type TEXT CHECK (package_type IN ('title', 'presenting', 'gold', 'silver', 'bronze', 'media', 'venue', 'food', 'tech')),
  tier_level INTEGER DEFAULT 1,
  
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Actual sponsorships
CREATE TABLE sponsorships (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  event_id UUID REFERENCES events(id),
  sponsorship_package_id UUID REFERENCES sponsorship_packages(id),
  sponsor_organization_id UUID REFERENCES organizations(id),
  sponsor_contact_id UUID REFERENCES users(id),
  
  -- Agreement details
  status TEXT DEFAULT 'proposed' CHECK (status IN ('proposed', 'negotiating', 'signed', 'active', 'completed', 'cancelled')),
  agreed_amount DECIMAL(10,2),
  currency TEXT DEFAULT 'USD',
  
  -- Contract and deliverables
  contract_signed_date DATE,
  contract_document_url TEXT,
  deliverable_status JSONB DEFAULT '{}', -- Track completion of deliverables
  
  -- Performance tracking
  metrics JSONB DEFAULT '{}', -- ROI metrics, impressions, etc.
  content_approvals JSONB DEFAULT '[]', -- Approved content pieces
  
  -- AI agent tracking
  ai_outreach_history JSONB DEFAULT '[]',
  agent_generated_content JSONB DEFAULT '[]',
  
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Sponsor content and activations
CREATE TABLE sponsor_content (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  sponsorship_id UUID REFERENCES sponsorships(id) ON DELETE CASCADE,
  content_type TEXT NOT NULL CHECK (content_type IN ('logo', 'banner', 'video', 'social_post', 'press_release', 'activation')),
  title TEXT,
  description TEXT,
  content_url TEXT,
  content_data JSONB DEFAULT '{}',
  
  -- Approval workflow
  status TEXT DEFAULT 'draft' CHECK (status IN ('draft', 'pending_approval', 'approved', 'published', 'rejected')),
  approval_notes TEXT,
  approved_by UUID REFERENCES users(id),
  approved_at TIMESTAMPTZ,
  
  -- Performance metrics
  impressions INTEGER DEFAULT 0,
  clicks INTEGER DEFAULT 0,
  engagement_rate DECIMAL(5,4),
  
  -- AI generation tracking
  ai_generated BOOLEAN DEFAULT false,
  generation_prompt TEXT,
  generation_model TEXT,
  
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### 🛒 Vendors & Services

```sql
-- Vendor listings and services
CREATE TABLE vendors (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID REFERENCES organizations(id),
  vendor_type TEXT NOT NULL CHECK (vendor_type IN ('food', 'beverage', 'merchandise', 'photography', 'videography', 'security', 'cleaning', 'transport', 'accommodation', 'entertainment')),
  service_name TEXT NOT NULL,
  description TEXT,
  
  -- Pricing and availability
  pricing_model TEXT CHECK (pricing_model IN ('fixed', 'hourly', 'per_person', 'percentage')),
  base_price DECIMAL(10,2),
  currency TEXT DEFAULT 'USD',
  
  -- Service details
  capacity INTEGER, -- Max people served, etc.
  equipment_provided JSONB DEFAULT '[]',
  requirements JSONB DEFAULT '{}', -- Space, power, etc.
  
  -- Availability and booking
  availability_schedule JSONB DEFAULT '{}',
  booking_lead_time INTEGER DEFAULT 7, -- Days
  
  -- Ratings and reviews
  average_rating DECIMAL(3,2) DEFAULT 0,
  total_reviews INTEGER DEFAULT 0,
  
  -- Contact and portfolio
  contact_info JSONB DEFAULT '{}',
  portfolio_urls JSONB DEFAULT '[]',
  certifications JSONB DEFAULT '[]',
  
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Vendor bookings for events
CREATE TABLE vendor_bookings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  event_id UUID REFERENCES events(id),
  vendor_id UUID REFERENCES vendors(id),
  booked_by UUID REFERENCES users(id),
  
  -- Booking details
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'in_progress', 'completed', 'cancelled')),
  start_time TIMESTAMPTZ NOT NULL,
  end_time TIMESTAMPTZ NOT NULL,
  location TEXT,
  
  -- Pricing and payment
  quoted_price DECIMAL(10,2),
  final_price DECIMAL(10,2),
  currency TEXT DEFAULT 'USD',
  payment_status TEXT DEFAULT 'pending' CHECK (payment_status IN ('pending', 'deposit_paid', 'fully_paid', 'refunded')),
  
  -- Service details
  service_requirements JSONB DEFAULT '{}',
  special_instructions TEXT,
  equipment_needed JSONB DEFAULT '[]',
  
  -- Performance tracking
  setup_completed_at TIMESTAMPTZ,
  service_rating INTEGER CHECK (service_rating BETWEEN 1 AND 5),
  service_review TEXT,
  
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### 📱 Content & Social Media

```sql
-- Content pieces (posts, stories, videos)
CREATE TABLE content (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  event_id UUID REFERENCES events(id),
  created_by UUID REFERENCES users(id),
  
  -- Content details
  content_type TEXT NOT NULL CHECK (content_type IN ('post', 'story', 'reel', 'video', 'image', 'carousel', 'live_stream')),
  title TEXT,
  caption TEXT,
  hashtags TEXT[],
  
  -- Media files
  media_urls JSONB DEFAULT '[]', -- Array of image/video URLs
  thumbnail_url TEXT,
  
  -- Platform-specific data
  platform_data JSONB DEFAULT '{}', -- Instagram, TikTok, etc. specific fields
  
  -- Scheduling and publishing
  status TEXT DEFAULT 'draft' CHECK (status IN ('draft', 'scheduled', 'published', 'archived')),
  scheduled_for TIMESTAMPTZ,
  published_at TIMESTAMPTZ,
  platforms TEXT[] DEFAULT '{}', -- ['instagram', 'tiktok', 'facebook']
  
  -- Performance metrics
  impressions INTEGER DEFAULT 0,
  likes INTEGER DEFAULT 0,
  comments INTEGER DEFAULT 0,
  shares INTEGER DEFAULT 0,
  saves INTEGER DEFAULT 0,
  engagement_rate DECIMAL(5,4),
  
  -- AI generation
  ai_generated BOOLEAN DEFAULT false,
  generation_prompt TEXT,
  ai_model_used TEXT,
  human_edited BOOLEAN DEFAULT false,
  
  -- Collaboration
  collaborators JSONB DEFAULT '[]', -- Users tagged or mentioned
  sponsor_tags JSONB DEFAULT '[]', -- Sponsor mentions
  
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Social media campaigns
CREATE TABLE campaigns (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  event_id UUID REFERENCES events(id),
  campaign_name TEXT NOT NULL,
  description TEXT,
  
  -- Campaign timeline
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status TEXT DEFAULT 'draft' CHECK (status IN ('draft', 'active', 'paused', 'completed')),
  
  -- Target audience
  target_audience JSONB DEFAULT '{}', -- Demographics, interests, etc.
  platforms TEXT[] DEFAULT '{}',
  
  -- Budget and goals
  budget DECIMAL(10,2),
  currency TEXT DEFAULT 'USD',
  goals JSONB DEFAULT '{}', -- Reach, engagement, conversions
  
  -- Performance
  total_reach INTEGER DEFAULT 0,
  total_impressions INTEGER DEFAULT 0,
  total_engagement INTEGER DEFAULT 0,
  conversion_rate DECIMAL(5,4),
  roi DECIMAL(10,2),
  
  -- AI optimization
  ai_optimization_enabled BOOLEAN DEFAULT false,
  optimization_metrics JSONB DEFAULT '{}',
  
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### 🤖 AI Agents & Automation

```sql
-- AI agent definitions and configurations
CREATE TABLE ai_agents (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  agent_name TEXT NOT NULL,
  agent_type TEXT NOT NULL CHECK (agent_type IN ('planner', 'sponsor', 'vendor', 'social_media', 'content', 'customer_service', 'analytics', 'pricing')),
  description TEXT,
  
  -- Agent configuration
  model_config JSONB NOT NULL DEFAULT '{}', -- LLM settings, prompts, etc.
  tools_config JSONB DEFAULT '{}', -- Available tools and APIs
  workflow_config JSONB DEFAULT '{}', -- LangGraph workflows
  
  -- Capabilities and permissions
  capabilities JSONB DEFAULT '[]',
  permissions JSONB DEFAULT '{}',
  rate_limits JSONB DEFAULT '{}',
  
  -- Performance tracking
  total_executions INTEGER DEFAULT 0,
  successful_executions INTEGER DEFAULT 0,
  average_response_time DECIMAL(6,3),
  last_executed_at TIMESTAMPTZ,
  
  -- Versioning
  version TEXT DEFAULT '1.0',
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'deprecated')),
  
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Agent execution logs
CREATE TABLE agent_executions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  agent_id UUID REFERENCES ai_agents(id),
  event_id UUID REFERENCES events(id),
  user_id UUID REFERENCES users(id),
  
  -- Execution details
  task_type TEXT NOT NULL,
  input_data JSONB NOT NULL,
  output_data JSONB,
  
  -- Performance metrics
  status TEXT NOT NULL CHECK (status IN ('running', 'completed', 'failed', 'timeout')),
  started_at TIMESTAMPTZ DEFAULT NOW(),
  completed_at TIMESTAMPTZ,
  execution_time_ms INTEGER,
  
  -- Error handling
  error_message TEXT,
  retry_count INTEGER DEFAULT 0,
  
  -- Context and tracing
  parent_execution_id UUID REFERENCES agent_executions(id),
  conversation_id UUID, -- For multi-turn interactions
  trace_data JSONB DEFAULT '{}',
  
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Automated workflows and triggers
CREATE TABLE automation_workflows (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  event_id UUID REFERENCES events(id),
  workflow_name TEXT NOT NULL,
  description TEXT,
  
  -- Trigger configuration
  trigger_type TEXT NOT NULL CHECK (trigger_type IN ('schedule', 'event', 'user_action', 'webhook', 'data_change')),
  trigger_config JSONB NOT NULL,
  
  -- Workflow definition
  workflow_steps JSONB NOT NULL, -- Array of steps/agents to execute
  fallback_config JSONB DEFAULT '{}',
  
  -- Status and performance
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'paused', 'inactive')),
  total_runs INTEGER DEFAULT 0,
  successful_runs INTEGER DEFAULT 0,
  last_run_at TIMESTAMPTZ,
  
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

## Indexes for Performance

```sql
-- Events indexes
CREATE INDEX idx_events_organization ON events(organization_id);
CREATE INDEX idx_events_type_status ON events(event_type, status);
CREATE INDEX idx_events_dates ON events(start_date, end_date);
CREATE INDEX idx_events_location ON events USING GIN(venue_info);

-- Users and roles indexes
CREATE INDEX idx_users_organization ON users(organization_id);
CREATE INDEX idx_users_role ON users(primary_role);
CREATE INDEX idx_user_event_roles_composite ON user_event_roles(user_id, event_id, role);

-- Tickets and payments
CREATE INDEX idx_tickets_event ON tickets(event_id);
CREATE INDEX idx_tickets_user ON tickets(purchaser_id);
CREATE INDEX idx_tickets_status ON tickets(status, payment_status);
CREATE INDEX idx_payments_status ON payments(status, created_at);

-- Content and social media
CREATE INDEX idx_content_event ON content(event_id);
CREATE INDEX idx_content_type_status ON content(content_type, status);
CREATE INDEX idx_content_scheduled ON content(scheduled_for) WHERE status = 'scheduled';

-- AI agents and executions
CREATE INDEX idx_agent_executions_agent ON agent_executions(agent_id);
CREATE INDEX idx_agent_executions_event ON agent_executions(event_id);
CREATE INDEX idx_agent_executions_status ON agent_executions(status, created_at);
```

## Row Level Security (RLS) Policies

```sql
-- Enable RLS on all tables
ALTER TABLE organizations ENABLE ROW LEVEL SECURITY;
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
ALTER TABLE tickets ENABLE ROW LEVEL SECURITY;
ALTER TABLE sponsorships ENABLE ROW LEVEL SECURITY;
ALTER TABLE content ENABLE ROW LEVEL SECURITY;

-- Example policies (implement for all tables)
-- Users can read their own data
CREATE POLICY "Users can read own profile" ON users
  FOR SELECT USING (auth.uid() = id);

-- Event organizers can manage their events
CREATE POLICY "Organizers can manage their events" ON events
  FOR ALL USING (
    organization_id IN (
      SELECT organization_id FROM users WHERE id = auth.uid()
    )
  );

-- Public can read published events
CREATE POLICY "Public can read published events" ON events
  FOR SELECT USING (status = 'published');

-- Users can read their own tickets
CREATE POLICY "Users can read own tickets" ON tickets
  FOR SELECT USING (purchaser_id = auth.uid());
```

## Database Functions

```sql
-- Function to update event capacity when tickets are sold
CREATE OR REPLACE FUNCTION update_event_capacity()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    UPDATE events SET available_capacity = (
      SELECT total_capacity - COALESCE(SUM(
        CASE WHEN t.status = 'valid' THEN 1 ELSE 0 END
      ), 0)
      FROM tickets t
      WHERE t.event_id = NEW.event_id
    ) WHERE id = NEW.event_id;
  END IF;
  
  RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- Trigger to update capacity
CREATE TRIGGER trigger_update_event_capacity
  AFTER INSERT OR UPDATE OR DELETE ON tickets
  FOR EACH ROW EXECUTE FUNCTION update_event_capacity();

-- Function for dynamic pricing based on demand
CREATE OR REPLACE FUNCTION calculate_dynamic_price(
  tier_id UUID,
  base_price DECIMAL,
  sold_percentage DECIMAL
) RETURNS DECIMAL AS $$
BEGIN
  -- Simple dynamic pricing: increase price as more tickets are sold
  RETURN base_price * (1 + (sold_percentage * 0.5));
END;
$$ LANGUAGE plpgsql;
```

This schema provides a robust foundation for the CopilotKit + CrewAI event management system, supporting all major stakeholders and use cases while maintaining data integrity and performance.
