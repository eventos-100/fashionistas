-- ============================================
-- COMPREHENSIVE EVENT MANAGEMENT DATABASE SCHEMA
-- Supabase PostgreSQL Implementation
-- ============================================

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "vector";

-- ============================================
-- CORE SYSTEM TABLES
-- ============================================

-- Organizations (Multi-tenant support)
CREATE TABLE organizations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL,
    subscription_tier VARCHAR(50) DEFAULT 'basic' CHECK (subscription_tier IN ('basic', 'pro', 'enterprise')),
    settings JSONB DEFAULT '{}',
    billing_info JSONB DEFAULT '{}',
    api_keys JSONB DEFAULT '{}',
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Users with enhanced role management
CREATE TABLE users (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    email VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    avatar_url TEXT,
    phone VARCHAR(20),
    role VARCHAR(50) DEFAULT 'member' CHECK (role IN ('super_admin', 'admin', 'event_director', 'producer', 'marketing_manager', 'sales_manager', 'coordinator', 'member')),
    permissions JSONB DEFAULT '{}',
    skills TEXT[] DEFAULT '{}',
    certifications JSONB DEFAULT '{}',
    availability_schedule JSONB DEFAULT '{}',
    hourly_rate DECIMAL(10,2),
    is_active BOOLEAN DEFAULT true,
    last_login_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    auth_user_id UUID UNIQUE -- Link to Supabase auth.users
);

-- ============================================
-- EVENT MANAGEMENT CORE
-- ============================================

-- Event Categories and Types
CREATE TABLE event_categories (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL,
    description TEXT,
    icon_url TEXT,
    color_code VARCHAR(7), -- Hex color
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(organization_id, slug)
);

-- Venues
CREATE TABLE venues (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    address JSONB NOT NULL, -- {street, city, state, country, postal_code, coordinates}
    capacity INTEGER NOT NULL,
    venue_type VARCHAR(50) NOT NULL, -- conference_center, hotel, outdoor, virtual, etc.
    amenities JSONB DEFAULT '{}', -- {wifi, parking, catering, av_equipment, etc.}
    contact_info JSONB DEFAULT '{}',
    pricing JSONB DEFAULT '{}', -- Different pricing tiers
    availability_calendar JSONB DEFAULT '{}',
    images TEXT[] DEFAULT '{}',
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Events (Core entity)
CREATE TABLE events (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    category_id UUID REFERENCES event_categories(id),
    venue_id UUID REFERENCES venues(id),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(100) NOT NULL,
    description TEXT,
    event_type VARCHAR(50) DEFAULT 'in_person' CHECK (event_type IN ('in_person', 'virtual', 'hybrid')),
    status VARCHAR(50) DEFAULT 'planning' CHECK (status IN ('planning', 'confirmed', 'live', 'completed', 'cancelled')),
    start_date TIMESTAMPTZ NOT NULL,
    end_date TIMESTAMPTZ NOT NULL,
    timezone VARCHAR(50) DEFAULT 'UTC',
    max_capacity INTEGER,
    registration_deadline TIMESTAMPTZ,
    visibility VARCHAR(20) DEFAULT 'public' CHECK (visibility IN ('public', 'private', 'unlisted')),
    tags TEXT[] DEFAULT '{}',
    custom_fields JSONB DEFAULT '{}',
    branding JSONB DEFAULT '{}', -- Logo, colors, theme
    social_links JSONB DEFAULT '{}',
    is_active BOOLEAN DEFAULT true,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(organization_id, slug)
);

-- Event Team Assignments
CREATE TABLE event_team_members (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    role VARCHAR(100) NOT NULL,
    responsibilities TEXT[] DEFAULT '{}',
    access_level VARCHAR(20) DEFAULT 'read' CHECK (access_level IN ('read', 'write', 'admin')),
    hourly_rate DECIMAL(10,2),
    estimated_hours INTEGER,
    actual_hours DECIMAL(5,2) DEFAULT 0,
    start_date DATE,
    end_date DATE,
    is_active BOOLEAN DEFAULT true,
    assigned_at TIMESTAMPTZ DEFAULT NOW(),
    assigned_by UUID REFERENCES users(id),
    UNIQUE(event_id, user_id, role)
);

-- ============================================
-- PROJECT MANAGEMENT
-- ============================================

-- Project Templates
CREATE TABLE project_templates (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    event_type VARCHAR(50),
    template_data JSONB NOT NULL, -- Task templates, timeline templates, etc.
    is_default BOOLEAN DEFAULT false,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tasks and Milestones
CREATE TABLE tasks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    parent_task_id UUID REFERENCES tasks(id), -- For subtasks
    title VARCHAR(255) NOT NULL,
    description TEXT,
    task_type VARCHAR(50) DEFAULT 'task' CHECK (task_type IN ('task', 'milestone', 'checklist_item')),
    status VARCHAR(50) DEFAULT 'todo' CHECK (status IN ('todo', 'in_progress', 'review', 'completed', 'cancelled')),
    priority VARCHAR(20) DEFAULT 'medium' CHECK (priority IN ('low', 'medium', 'high', 'urgent')),
    category VARCHAR(100), -- venue, marketing, logistics, etc.
    assigned_to UUID REFERENCES users(id),
    due_date TIMESTAMPTZ,
    estimated_hours DECIMAL(5,2),
    actual_hours DECIMAL(5,2) DEFAULT 0,
    completion_percentage INTEGER DEFAULT 0 CHECK (completion_percentage >= 0 AND completion_percentage <= 100),
    dependencies TEXT[], -- Array of task IDs this task depends on
    attachments JSONB DEFAULT '{}',
    notes TEXT,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    completed_at TIMESTAMPTZ
);

-- Budget Management
CREATE TABLE budgets (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    category VARCHAR(100) NOT NULL, -- venue, catering, marketing, staff, etc.
    subcategory VARCHAR(100),
    planned_amount DECIMAL(12,2) NOT NULL,
    actual_amount DECIMAL(12,2) DEFAULT 0,
    currency VARCHAR(3) DEFAULT 'USD',
    vendor_id UUID, -- Reference to vendors table
    description TEXT,
    payment_terms JSONB DEFAULT '{}',
    approval_status VARCHAR(50) DEFAULT 'pending' CHECK (approval_status IN ('pending', 'approved', 'rejected')),
    approved_by UUID REFERENCES users(id),
    notes TEXT,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Vendors and Suppliers
CREATE TABLE vendors (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    vendor_type VARCHAR(100) NOT NULL, -- catering, av, security, cleaning, etc.
    contact_info JSONB NOT NULL,
    services_offered TEXT[] DEFAULT '{}',
    pricing_structure JSONB DEFAULT '{}',
    ratings JSONB DEFAULT '{}', -- {quality: 5, reliability: 4, value: 4}
    contract_terms TEXT,
    payment_terms VARCHAR(100),
    insurance_info JSONB DEFAULT '{}',
    certifications TEXT[] DEFAULT '{}',
    preferred_vendor BOOLEAN DEFAULT false,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Vendor Contracts
CREATE TABLE vendor_contracts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    vendor_id UUID REFERENCES vendors(id),
    contract_type VARCHAR(100) NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD',
    contract_terms TEXT,
    start_date DATE,
    end_date DATE,
    payment_schedule JSONB DEFAULT '{}',
    deliverables TEXT[] DEFAULT '{}',
    status VARCHAR(50) DEFAULT 'draft' CHECK (status IN ('draft', 'sent', 'signed', 'completed', 'cancelled')),
    contract_file_url TEXT,
    signed_at TIMESTAMPTZ,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- AI FEATURES & AUTOMATION
-- ============================================

-- AI Agents Configuration
CREATE TABLE ai_agents (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    agent_type VARCHAR(100) NOT NULL, -- customer_service, content_creator, data_analyst, etc.
    model_provider VARCHAR(50) DEFAULT 'openai', -- openai, anthropic, etc.
    model_name VARCHAR(100) DEFAULT 'gpt-4',
    system_prompt TEXT NOT NULL,
    configuration JSONB DEFAULT '{}', -- temperature, max_tokens, etc.
    tools_available TEXT[] DEFAULT '{}', -- web_search, calculator, etc.
    knowledge_sources TEXT[] DEFAULT '{}', -- URLs to documents, databases
    is_active BOOLEAN DEFAULT true,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- AI Conversations
CREATE TABLE ai_conversations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    agent_id UUID REFERENCES ai_agents(id),
    event_id UUID REFERENCES events(id),
    user_id UUID REFERENCES users(id),
    session_id VARCHAR(255) NOT NULL,
    conversation_data JSONB NOT NULL, -- Full conversation history
    summary TEXT,
    satisfaction_rating INTEGER CHECK (satisfaction_rating >= 1 AND satisfaction_rating <= 5),
    feedback TEXT,
    total_messages INTEGER DEFAULT 0,
    total_tokens_used INTEGER DEFAULT 0,
    conversation_cost DECIMAL(8,4) DEFAULT 0,
    started_at TIMESTAMPTZ DEFAULT NOW(),
    ended_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- AI Generated Content
CREATE TABLE ai_generated_content (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    event_id UUID REFERENCES events(id),
    agent_id UUID REFERENCES ai_agents(id),
    content_type VARCHAR(100) NOT NULL, -- social_post, email, ad_copy, etc.
    platform VARCHAR(50), -- instagram, facebook, email, etc.
    prompt TEXT NOT NULL,
    generated_content TEXT NOT NULL,
    metadata JSONB DEFAULT '{}', -- hashtags, mentions, etc.
    approval_status VARCHAR(50) DEFAULT 'pending' CHECK (approval_status IN ('pending', 'approved', 'rejected', 'published')),
    performance_metrics JSONB DEFAULT '{}',
    approved_by UUID REFERENCES users(id),
    published_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Automation Workflows
CREATE TABLE automation_workflows (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    trigger_type VARCHAR(100) NOT NULL, -- event_created, ticket_sold, etc.
    trigger_conditions JSONB DEFAULT '{}',
    workflow_steps JSONB NOT NULL, -- Array of steps with actions
    is_active BOOLEAN DEFAULT true,
    execution_count INTEGER DEFAULT 0,
    last_executed_at TIMESTAMPTZ,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Workflow Executions Log
CREATE TABLE workflow_executions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    workflow_id UUID REFERENCES automation_workflows(id),
    event_id UUID REFERENCES events(id),
    trigger_data JSONB NOT NULL,
    execution_status VARCHAR(50) DEFAULT 'running' CHECK (execution_status IN ('running', 'completed', 'failed', 'cancelled')),
    execution_log JSONB DEFAULT '{}',
    error_message TEXT,
    started_at TIMESTAMPTZ DEFAULT NOW(),
    completed_at TIMESTAMPTZ
);

-- ============================================
-- MARKETING & SOCIAL MEDIA
-- ============================================

-- Marketing Campaigns
CREATE TABLE marketing_campaigns (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_id UUID REFERENCES events(id),
    name VARCHAR(255) NOT NULL,
    campaign_type VARCHAR(100) NOT NULL, -- social_media, email, paid_ads, influencer
    platforms TEXT[] DEFAULT '{}', -- instagram, facebook, youtube, tiktok, etc.
    target_audience JSONB DEFAULT '{}',
    budget DECIMAL(10,2),
    currency VARCHAR(3) DEFAULT 'USD',
    start_date DATE,
    end_date DATE,
    goals JSONB DEFAULT '{}', -- awareness, ticket_sales, engagement
    kpis JSONB DEFAULT '{}', -- reach, clicks, conversions
    status VARCHAR(50) DEFAULT 'draft' CHECK (status IN ('draft', 'scheduled', 'active', 'paused', 'completed')),
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Social Media Accounts
CREATE TABLE social_media_accounts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    platform VARCHAR(50) NOT NULL, -- instagram, facebook, youtube, tiktok, linkedin, twitter, reddit
    account_handle VARCHAR(255) NOT NULL,
    account_name VARCHAR(255),
    account_id VARCHAR(255), -- Platform-specific ID
    access_token TEXT, -- Encrypted
    refresh_token TEXT, -- Encrypted
    token_expires_at TIMESTAMPTZ,
    follower_count INTEGER DEFAULT 0,
    account_metrics JSONB DEFAULT '{}',
    is_active BOOLEAN DEFAULT true,
    connected_at TIMESTAMPTZ DEFAULT NOW(),
    last_sync_at TIMESTAMPTZ,
    UNIQUE(organization_id, platform, account_handle)
);

-- Social Media Posts
CREATE TABLE social_media_posts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    campaign_id UUID REFERENCES marketing_campaigns(id),
    account_id UUID REFERENCES social_media_accounts(id),
    post_type VARCHAR(50) NOT NULL, -- image, video, carousel, story, reel
    content TEXT NOT NULL,
    media_urls TEXT[] DEFAULT '{}',
    hashtags TEXT[] DEFAULT '{}',
    mentions TEXT[] DEFAULT '{}',
    scheduled_for TIMESTAMPTZ,
    published_at TIMESTAMPTZ,
    platform_post_id VARCHAR(255),
    engagement_metrics JSONB DEFAULT '{}', -- likes, comments, shares, etc.
    status VARCHAR(50) DEFAULT 'draft' CHECK (status IN ('draft', 'scheduled', 'published', 'failed')),
    error_message TEXT,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Influencer Management
CREATE TABLE influencers (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20),
    platforms JSONB NOT NULL, -- {instagram: @handle, tiktok: @handle, etc.}
    follower_counts JSONB DEFAULT '{}',
    engagement_rates JSONB DEFAULT '{}',
    demographics JSONB DEFAULT '{}', -- audience age, location, interests
    rate_card JSONB DEFAULT '{}', -- pricing for different content types
    collaboration_history JSONB DEFAULT '{}',
    performance_scores JSONB DEFAULT '{}',
    notes TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Influencer Campaigns
CREATE TABLE influencer_campaigns (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    campaign_id UUID REFERENCES marketing_campaigns(id),
    influencer_id UUID REFERENCES influencers(id),
    content_requirements TEXT,
    deliverables JSONB NOT NULL, -- posts, stories, videos, etc.
    compensation DECIMAL(10,2),
    compensation_type VARCHAR(50) DEFAULT 'fixed', -- fixed, per_post, commission
    campaign_hashtags TEXT[] DEFAULT '{}',
    deadline TIMESTAMPTZ,
    approval_required BOOLEAN DEFAULT true,
    contract_signed BOOLEAN DEFAULT false,
    status VARCHAR(50) DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'in_progress', 'review', 'completed', 'cancelled')),
    performance_metrics JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- SPONSORSHIP MANAGEMENT
-- ============================================

-- Sponsor Prospects (Lead Management)
CREATE TABLE sponsor_prospects (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    company_name VARCHAR(255) NOT NULL,
    industry VARCHAR(100),
    company_size VARCHAR(50), -- startup, small, medium, large, enterprise
    website VARCHAR(255),
    headquarters_location VARCHAR(255),
    annual_revenue DECIMAL(15,2),
    previous_sponsorships JSONB DEFAULT '{}',
    contact_person VARCHAR(255),
    contact_email VARCHAR(255),
    contact_phone VARCHAR(20),
    lead_source VARCHAR(100), -- referral, research, inbound, etc.
    lead_score INTEGER DEFAULT 0 CHECK (lead_score >= 0 AND lead_score <= 100),
    qualification_status VARCHAR(50) DEFAULT 'unqualified' CHECK (qualification_status IN ('unqualified', 'qualified', 'hot', 'cold')),
    notes TEXT,
    last_contacted_at TIMESTAMPTZ,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Sponsorship Packages
CREATE TABLE sponsorship_packages (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    package_name VARCHAR(255) NOT NULL,
    package_tier VARCHAR(50) NOT NULL, -- presenting, gold, silver, bronze, etc.
    price DECIMAL(12,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD',
    benefits JSONB NOT NULL, -- logo placement, booth space, tickets, etc.
    deliverables TEXT[] DEFAULT '{}',
    limitations JSONB DEFAULT '{}',
    max_sponsors INTEGER DEFAULT 1,
    current_sponsors INTEGER DEFAULT 0,
    early_bird_discount DECIMAL(5,2) DEFAULT 0,
    early_bird_deadline TIMESTAMPTZ,
    is_available BOOLEAN DEFAULT true,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Sponsorship Deals
CREATE TABLE sponsorship_deals (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    prospect_id UUID REFERENCES sponsor_prospects(id),
    package_id UUID REFERENCES sponsorship_packages(id),
    deal_value DECIMAL(12,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD',
    custom_benefits JSONB DEFAULT '{}',
    contract_terms TEXT,
    payment_terms VARCHAR(100),
    payment_schedule JSONB DEFAULT '{}',
    status VARCHAR(50) DEFAULT 'proposal' CHECK (status IN ('proposal', 'negotiation', 'contract_sent', 'signed', 'paid', 'fulfilled', 'cancelled')),
    probability INTEGER DEFAULT 50 CHECK (probability >= 0 AND probability <= 100),
    close_date DATE,
    decision_maker VARCHAR(255),
    notes TEXT,
    contract_file_url TEXT,
    signed_at TIMESTAMPTZ,
    assigned_to UUID REFERENCES users(id),
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Sponsor Onboarding Steps
CREATE TABLE sponsor_onboarding_steps (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    deal_id UUID REFERENCES sponsorship_deals(id) ON DELETE CASCADE,
    step_name VARCHAR(255) NOT NULL,
    step_type VARCHAR(50) NOT NULL, -- form, upload, review, approval
    step_order INTEGER NOT NULL,
    is_required BOOLEAN DEFAULT true,
    form_fields JSONB DEFAULT '{}', -- For form steps
    file_requirements JSONB DEFAULT '{}', -- For upload steps
    instructions TEXT,
    completion_status VARCHAR(50) DEFAULT 'pending' CHECK (completion_status IN ('pending', 'in_progress', 'completed', 'skipped')),
    completed_at TIMESTAMPTZ,
    notes TEXT
);

-- Sponsor Activations (Benefits Delivery)
CREATE TABLE sponsor_activations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    deal_id UUID REFERENCES sponsorship_deals(id) ON DELETE CASCADE,
    activation_type VARCHAR(100) NOT NULL, -- logo_placement, booth_setup, social_mention, etc.
    description TEXT,
    scheduled_date TIMESTAMPTZ,
    completion_status VARCHAR(50) DEFAULT 'planned' CHECK (completion_status IN ('planned', 'in_progress', 'completed', 'cancelled')),
    deliverables TEXT[] DEFAULT '{}',
    metrics JSONB DEFAULT '{}', -- impressions, engagement, etc.
    cost DECIMAL(10,2) DEFAULT 0,
    assigned_to UUID REFERENCES users(id),
    completed_at TIMESTAMPTZ,
    proof_of_completion TEXT, -- URLs to photos, reports, etc.
    sponsor_feedback TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- TICKETING & SALES
-- ============================================

-- Ticket Categories
CREATE TABLE ticket_categories (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    ticket_type VARCHAR(50) DEFAULT 'paid' CHECK (ticket_type IN ('free', 'paid', 'donation')),
    price DECIMAL(10,2) NOT NULL DEFAULT 0,
    currency VARCHAR(3) DEFAULT 'USD',
    quantity_total INTEGER NOT NULL,
    quantity_sold INTEGER DEFAULT 0,
    quantity_reserved INTEGER DEFAULT 0,
    max_per_order INTEGER DEFAULT 10,
    sale_start_date TIMESTAMPTZ,
    sale_end_date TIMESTAMPTZ,
    visibility VARCHAR(20) DEFAULT 'public' CHECK (visibility IN ('public', 'hidden', 'invitation_only')),
    benefits JSONB DEFAULT '{}', -- VIP perks, access levels, etc.
    restrictions JSONB DEFAULT '{}',
    is_active BOOLEAN DEFAULT true,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Dynamic Pricing Rules
CREATE TABLE pricing_rules (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ticket_category_id UUID REFERENCES ticket_categories(id) ON DELETE CASCADE,
    rule_name VARCHAR(255) NOT NULL,
    rule_type VARCHAR(50) NOT NULL, -- early_bird, last_minute, demand_based, group_discount
    conditions JSONB NOT NULL, -- date ranges, quantity thresholds, etc.
    discount_type VARCHAR(20) NOT NULL CHECK (discount_type IN ('percentage', 'fixed_amount')),
    discount_value DECIMAL(10,2) NOT NULL,
    max_discount DECIMAL(10,2),
    usage_limit INTEGER,
    usage_count INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    valid_from TIMESTAMPTZ,
    valid_until TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Orders
CREATE TABLE orders (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    order_number VARCHAR(50) UNIQUE NOT NULL,
    customer_email VARCHAR(255) NOT NULL,
    customer_name VARCHAR(255) NOT NULL,
    customer_phone VARCHAR(20),
    billing_address JSONB DEFAULT '{}',
    subtotal DECIMAL(10,2) NOT NULL,
    fees DECIMAL(10,2) DEFAULT 0,
    taxes DECIMAL(10,2) DEFAULT 0,
    discounts DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD',
    payment_method VARCHAR(50),
    payment_status VARCHAR(50) DEFAULT 'pending' CHECK (payment_status IN ('pending', 'processing', 'paid', 'failed', 'refunded', 'partially_refunded')),
    payment_id VARCHAR(255), -- Stripe payment intent ID
    refund_amount DECIMAL(10,2) DEFAULT 0,
    order_status VARCHAR(50) DEFAULT 'pending' CHECK (order_status IN ('pending', 'confirmed', 'cancelled', 'refunded')),
    notes TEXT,
    utm_source VARCHAR(100),
    utm_medium VARCHAR(100),
    utm_campaign VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Order Items (Individual Tickets)
CREATE TABLE order_items (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
    ticket_category_id UUID REFERENCES ticket_categories(id),
    quantity INTEGER NOT NULL DEFAULT 1,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    discount_applied DECIMAL(10,2) DEFAULT 0,
    attendee_info JSONB DEFAULT '{}', -- Name, email for each ticket
    ticket_codes TEXT[] DEFAULT '{}', -- Generated ticket codes
    check_in_status JSONB DEFAULT '{}', -- Check-in status for each ticket
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Discount Codes
CREATE TABLE discount_codes (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_id UUID REFERENCES events(id),
    code VARCHAR(50) NOT NULL,
    name VARCHAR(255),
    discount_type VARCHAR(20) NOT NULL CHECK (discount_type IN ('percentage', 'fixed_amount', 'buy_x_get_y')),
    discount_value DECIMAL(10,2) NOT NULL,
    min_order_amount DECIMAL(10,2) DEFAULT 0,
    max_discount DECIMAL(10,2),
    usage_limit INTEGER,
    usage_count INTEGER DEFAULT 0,
    applicable_categories TEXT[], -- ticket category IDs
    valid_from TIMESTAMPTZ,
    valid_until TIMESTAMPTZ,
    is_active BOOLEAN DEFAULT true,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(event_id, code)
);

-- Waitlist
CREATE TABLE waitlist (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    ticket_category_id UUID REFERENCES ticket_categories(id),
    email VARCHAR(255) NOT NULL,
    name VARCHAR(255),
    phone VARCHAR(20),
    quantity_requested INTEGER DEFAULT 1,
    max_price DECIMAL(10,2),
    priority_score INTEGER DEFAULT 0,
    status VARCHAR(50) DEFAULT 'active' CHECK (status IN ('active', 'notified', 'purchased', 'expired')),
    notified_at TIMESTAMPTZ,
    expires_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(event_id, ticket_category_id, email)
);

-- ============================================
-- ANALYTICS & REPORTING
-- ============================================

-- Analytics Events
CREATE TABLE analytics_events (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    event_id UUID REFERENCES events(id),
    event_name VARCHAR(100) NOT NULL,
    event_category VARCHAR(100),
    properties JSONB DEFAULT '{}',
    user_id UUID REFERENCES users(id),
    session_id VARCHAR(255),
    ip_address INET,
    user_agent TEXT,
    referrer TEXT,
    utm_source VARCHAR(100),
    utm_medium VARCHAR(100),
    utm_campaign VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Performance Metrics (Aggregated)
CREATE TABLE performance_metrics (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    event_id UUID REFERENCES events(id),
    metric_name VARCHAR(100) NOT NULL,
    metric_category VARCHAR(100),
    metric_value DECIMAL(15,4) NOT NULL,
    dimensions JSONB DEFAULT '{}', -- Additional grouping dimensions
    period_start TIMESTAMPTZ NOT NULL,
    period_end TIMESTAMPTZ NOT NULL,
    calculated_at TIMESTAMPTZ DEFAULT NOW(),
    INDEX (organization_id, metric_name, period_start)
);

-- Custom Reports
CREATE TABLE custom_reports (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    report_type VARCHAR(100) NOT NULL, -- financial, marketing, operations, etc.
    query_config JSONB NOT NULL, -- SQL query configuration
    visualization_config JSONB DEFAULT '{}',
    schedule JSONB DEFAULT '{}', -- Automated report schedule
    recipients TEXT[] DEFAULT '{}',
    is_active BOOLEAN DEFAULT true,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- COMMUNICATION & NOTIFICATIONS
-- ============================================

-- Message Templates
CREATE TABLE message_templates (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    template_type VARCHAR(100) NOT NULL, -- email, sms, whatsapp, push
    subject VARCHAR(255), -- For email
    content TEXT NOT NULL,
    variables JSONB DEFAULT '{}', -- Available template variables
    design_config JSONB DEFAULT '{}', -- HTML/styling for email
    is_active BOOLEAN DEFAULT true,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Notification Campaigns
CREATE TABLE notification_campaigns (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_id UUID REFERENCES events(id),
    template_id UUID REFERENCES message_templates(id),
    name VARCHAR(255) NOT NULL,
    recipient_criteria JSONB NOT NULL, -- Audience segmentation
    send_at TIMESTAMPTZ,
    status VARCHAR(50) DEFAULT 'draft' CHECK (status IN ('draft', 'scheduled', 'sending', 'sent', 'failed')),
    total_recipients INTEGER DEFAULT 0,
    sent_count INTEGER DEFAULT 0,
    failed_count INTEGER DEFAULT 0,
    delivery_rate DECIMAL(5,4) DEFAULT 0,
    open_rate DECIMAL(5,4) DEFAULT 0,
    click_rate DECIMAL(5,4) DEFAULT 0,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Message Log
CREATE TABLE message_log (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    campaign_id UUID REFERENCES notification_campaigns(id),
    recipient_email VARCHAR(255),
    recipient_phone VARCHAR(20),
    message_type VARCHAR(50) NOT NULL,
    status VARCHAR(50) DEFAULT 'queued' CHECK (status IN ('queued', 'sent', 'delivered', 'failed', 'bounced')),
    external_id VARCHAR(255), -- Provider message ID
    error_message TEXT,
    sent_at TIMESTAMPTZ,
    delivered_at TIMESTAMPTZ,
    opened_at TIMESTAMPTZ,
    clicked_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- SYSTEM TABLES
-- ============================================

-- Audit Log
CREATE TABLE audit_log (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id),
    action VARCHAR(100) NOT NULL,
    entity_type VARCHAR(100) NOT NULL,
    entity_id UUID NOT NULL,
    old_values JSONB,
    new_values JSONB,
    ip_address INET,
    user_agent TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- File Uploads
CREATE TABLE file_uploads (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    uploaded_by UUID REFERENCES users(id),
    file_name VARCHAR(255) NOT NULL,
    file_size INTEGER NOT NULL,
    file_type VARCHAR(100) NOT NULL,
    storage_path TEXT NOT NULL,
    public_url TEXT,
    entity_type VARCHAR(100), -- event, vendor, sponsor, etc.
    entity_id UUID,
    file_category VARCHAR(100), -- contract, image, document, etc.
    is_public BOOLEAN DEFAULT false,
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Integration Logs
CREATE TABLE integration_logs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    integration_name VARCHAR(100) NOT NULL, -- stripe, mailchimp, etc.
    operation VARCHAR(100) NOT NULL,
    request_data JSONB,
    response_data JSONB,
    status VARCHAR(50) NOT NULL CHECK (status IN ('success', 'error', 'timeout')),
    error_message TEXT,
    execution_time_ms INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================

-- Users
CREATE INDEX idx_users_organization_id ON users(organization_id);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);

-- Events
CREATE INDEX idx_events_organization_id ON events(organization_id);
CREATE INDEX idx_events_status ON events(status);
CREATE INDEX idx_events_start_date ON events(start_date);
CREATE INDEX idx_events_slug ON events(slug);

-- Tasks
CREATE INDEX idx_tasks_event_id ON tasks(event_id);
CREATE INDEX idx_tasks_assigned_to ON tasks(assigned_to);
CREATE INDEX idx_tasks_status ON tasks(status);
CREATE INDEX idx_tasks_due_date ON tasks(due_date);

-- Orders
CREATE INDEX idx_orders_event_id ON orders(event_id);
CREATE INDEX idx_orders_customer_email ON orders(customer_email);
CREATE INDEX idx_orders_payment_status ON orders(payment_status);
CREATE INDEX idx_orders_created_at ON orders(created_at);

-- Sponsorship
CREATE INDEX idx_sponsor_prospects_organization_id ON sponsor_prospects(organization_id);
CREATE INDEX idx_sponsor_prospects_qualification_status ON sponsor_prospects(qualification_status);
CREATE INDEX idx_sponsorship_deals_event_id ON sponsorship_deals(event_id);
CREATE INDEX idx_sponsorship_deals_status ON sponsorship_deals(status);

-- Analytics
CREATE INDEX idx_analytics_events_organization_id ON analytics_events(organization_id);
CREATE INDEX idx_analytics_events_event_name ON analytics_events(event_name);
CREATE INDEX idx_analytics_events_created_at ON analytics_events(created_at);
CREATE INDEX idx_performance_metrics_composite ON performance_metrics(organization_id, metric_name, period_start);

-- Social Media
CREATE INDEX idx_social_media_posts_campaign_id ON social_media_posts(campaign_id);
CREATE INDEX idx_social_media_posts_scheduled_for ON social_media_posts(scheduled_for);
CREATE INDEX idx_social_media_posts_status ON social_media_posts(status);

-- Composite indexes for common queries
CREATE INDEX idx_events_org_status_date ON events(organization_id, status, start_date);
CREATE INDEX idx_tasks_event_status_assigned ON tasks(event_id, status, assigned_to);
CREATE INDEX idx_orders_event_status_date ON orders(event_id, order_status, created_at);

-- Full-text search indexes
CREATE INDEX idx_events_search ON events USING gin(to_tsvector('english', name || ' ' || description));
CREATE INDEX idx_tasks_search ON tasks USING gin(to_tsvector('english', title || ' ' || COALESCE(description, '')));
CREATE INDEX idx_sponsors_search ON sponsor_prospects USING gin(to_tsvector('english', company_name || ' ' || COALESCE(notes, '')));