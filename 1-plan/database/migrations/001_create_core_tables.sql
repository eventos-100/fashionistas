-- EventsOS Core Database Schema - First 5 Tables
-- Migration: 001_create_core_tables.sql
-- Created: 2025-01-21
-- Description: Foundation tables for multi-tenant event management platform

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "pg_trgm"; -- For full-text search

-- ==============================================
-- TABLE 1: ORGANIZATIONS (Multi-tenancy Foundation)
-- ==============================================

CREATE TABLE organizations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    email TEXT NOT NULL CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    phone VARCHAR(20) NOT NULL CHECK (phone ~ '^\+?[1-9]\d{1,14}$'), -- E.164 format
    
    -- Business Information
    business_type TEXT NOT NULL CHECK (business_type IN ('company', 'nonprofit', 'government', 'individual')),
    business_number TEXT,
    tax_id TEXT,
    
    -- Address (structured)
    address_line1 TEXT NOT NULL,
    address_line2 TEXT,
    city TEXT NOT NULL,
    province TEXT NOT NULL,
    postal_code TEXT NOT NULL,
    country TEXT NOT NULL DEFAULT 'Canada',
    
    -- Billing
    billing_email TEXT CHECK (billing_email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    billing_address JSONB DEFAULT '{}',
    stripe_customer_id TEXT UNIQUE,
    
    -- Subscription Management
    subscription_tier TEXT DEFAULT 'free' CHECK (subscription_tier IN ('free', 'starter', 'pro', 'enterprise')),
    subscription_status TEXT DEFAULT 'active' CHECK (subscription_status IN ('active', 'past_due', 'cancelled', 'paused')),
    subscription_start_date DATE DEFAULT CURRENT_DATE,
    subscription_end_date DATE,
    subscription_renewal_date DATE,
    
    -- SLA for Enterprise
    sla_response_hours INTEGER, -- Response time in hours
    sla_uptime_percentage DECIMAL(5,2) CHECK (sla_uptime_percentage >= 99.0 AND sla_uptime_percentage <= 100.0),
    
    -- Branding
    logo_url TEXT,
    theme_color VARCHAR(7) CHECK (theme_color ~ '^#[0-9A-Fa-f]{6}$'), -- Hex color
    custom_domain TEXT,
    
    -- Settings (structured)
    timezone TEXT NOT NULL DEFAULT 'America/Toronto',
    currency VARCHAR(3) NOT NULL DEFAULT 'CAD',
    language VARCHAR(5) NOT NULL DEFAULT 'en',
    date_format TEXT NOT NULL DEFAULT 'YYYY-MM-DD',
    fiscal_year_start VARCHAR(5) NOT NULL DEFAULT '01-01',
    
    -- Metadata
    metadata JSONB DEFAULT '{}',
    is_verified BOOLEAN DEFAULT FALSE,
    verification_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    -- Constraints
    CONSTRAINT valid_subscription_dates CHECK (
        subscription_end_date IS NULL OR subscription_end_date >= subscription_start_date
    ),
    CONSTRAINT valid_renewal_date CHECK (
        subscription_renewal_date IS NULL OR subscription_renewal_date >= subscription_start_date
    )
);

-- Indexes for organizations
CREATE INDEX idx_organizations_slug ON organizations(slug);
CREATE INDEX idx_organizations_subscription ON organizations(subscription_status, subscription_tier);
CREATE INDEX idx_organizations_created ON organizations(created_at DESC);
CREATE INDEX idx_organizations_renewal ON organizations(subscription_renewal_date) 
    WHERE subscription_status = 'active' AND subscription_renewal_date IS NOT NULL;

-- ==============================================
-- TABLE 2: PROFILES (User Management)
-- ==============================================

CREATE TABLE profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT UNIQUE NOT NULL CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    full_name TEXT NOT NULL,
    avatar_url TEXT,
    phone VARCHAR(20) CHECK (phone ~ '^\+?[1-9]\d{1,14}$'),
    mobile VARCHAR(20) CHECK (mobile ~ '^\+?[1-9]\d{1,14}$'),
    
    -- Professional Info
    title TEXT,
    bio TEXT,
    linkedin_url TEXT,
    
    -- Structured Address
    address_line1 TEXT,
    address_line2 TEXT,
    city TEXT,
    province TEXT,
    postal_code TEXT,
    country TEXT DEFAULT 'Canada',
    timezone TEXT DEFAULT 'America/Toronto',
    
    -- Preferences (structured important fields)
    notification_email BOOLEAN DEFAULT TRUE,
    notification_sms BOOLEAN DEFAULT FALSE,
    notification_push BOOLEAN DEFAULT TRUE,
    marketing_consent BOOLEAN DEFAULT FALSE,
    profile_visibility BOOLEAN DEFAULT TRUE,
    language_preference VARCHAR(5) DEFAULT 'en',
    
    -- System
    email_verified BOOLEAN DEFAULT FALSE,
    email_verified_at TIMESTAMPTZ,
    phone_verified BOOLEAN DEFAULT FALSE,
    phone_verified_at TIMESTAMPTZ,
    mobile_verified BOOLEAN DEFAULT FALSE,
    mobile_verified_at TIMESTAMPTZ,
    onboarding_completed BOOLEAN DEFAULT FALSE,
    onboarding_completed_at TIMESTAMPTZ,
    is_active BOOLEAN DEFAULT TRUE,
    last_login_at TIMESTAMPTZ,
    
    -- Metadata
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for profiles
CREATE INDEX idx_profiles_email ON profiles(email);
CREATE INDEX idx_profiles_phone ON profiles(phone) WHERE phone IS NOT NULL;
CREATE INDEX idx_profiles_active ON profiles(is_active) WHERE is_active = TRUE;
CREATE INDEX idx_profiles_created ON profiles(created_at DESC);

-- Full text search for profiles
CREATE INDEX idx_profiles_search ON profiles USING gin(to_tsvector('english', full_name || ' ' || COALESCE(bio, '')));

-- ==============================================
-- TABLE 3: USER_ORGANIZATIONS (Multi-tenancy Relationships)
-- ==============================================

CREATE TABLE user_organizations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('owner', 'admin', 'manager', 'member', 'viewer')),
    
    -- Structured Permissions
    can_create_events BOOLEAN DEFAULT FALSE,
    can_edit_events BOOLEAN DEFAULT FALSE,
    can_delete_events BOOLEAN DEFAULT FALSE,
    can_view_events BOOLEAN DEFAULT TRUE,
    can_manage_venues BOOLEAN DEFAULT FALSE,
    can_manage_registrations BOOLEAN DEFAULT FALSE,
    can_view_finances BOOLEAN DEFAULT FALSE,
    can_manage_finances BOOLEAN DEFAULT FALSE,
    can_manage_team BOOLEAN DEFAULT FALSE,
    
    -- Status
    status TEXT DEFAULT 'active' CHECK (status IN ('active', 'suspended', 'invited')),
    joined_at TIMESTAMPTZ DEFAULT NOW(),
    invited_by UUID REFERENCES profiles(id),
    invitation_token TEXT UNIQUE,
    invitation_expires_at TIMESTAMPTZ,
    
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(user_id, organization_id)
);

-- Role History Table
CREATE TABLE user_role_history (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_organization_id UUID REFERENCES user_organizations(id) ON DELETE CASCADE NOT NULL,
    old_role TEXT,
    new_role TEXT NOT NULL,
    changed_by UUID REFERENCES profiles(id) NOT NULL,
    change_reason TEXT,
    changed_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for user_organizations
CREATE INDEX idx_user_orgs_user ON user_organizations(user_id);
CREATE INDEX idx_user_orgs_org ON user_organizations(organization_id);
CREATE INDEX idx_user_orgs_role ON user_organizations(role);
CREATE INDEX idx_user_orgs_status ON user_organizations(status) WHERE status = 'active';
CREATE INDEX idx_role_history_user_org ON user_role_history(user_organization_id);
CREATE INDEX idx_role_history_changed ON user_role_history(changed_at DESC);

-- ==============================================
-- TABLE 4: VENUES (Venue Management)
-- ==============================================

CREATE TABLE venues (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE NOT NULL,
    name TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    description TEXT,
    venue_type TEXT NOT NULL CHECK (venue_type IN (
        'convention_center', 'hotel', 'restaurant', 'outdoor', 
        'gallery', 'theater', 'studio', 'other'
    )),
    
    -- Structured Location
    address_line1 TEXT NOT NULL,
    address_line2 TEXT,
    city TEXT NOT NULL,
    province TEXT NOT NULL,
    postal_code TEXT NOT NULL,
    country TEXT NOT NULL DEFAULT 'Canada',
    
    -- Capacity
    capacity_standing INTEGER CHECK (capacity_standing > 0),
    capacity_seated INTEGER CHECK (capacity_seated > 0),
    min_capacity INTEGER DEFAULT 10 CHECK (min_capacity > 0),
    area_sqft INTEGER CHECK (area_sqft > 0),
    
    -- Features
    amenities TEXT[] DEFAULT '{}',
    accessibility_features TEXT[] DEFAULT '{}',
    parking_spots INTEGER DEFAULT 0,
    parking_fee DECIMAL(10,2) DEFAULT 0,
    public_transit_access BOOLEAN DEFAULT FALSE,
    
    -- Technical Specifications
    has_wifi BOOLEAN DEFAULT TRUE,
    has_av_equipment BOOLEAN DEFAULT FALSE,
    lighting_type TEXT CHECK (lighting_type IN ('basic', 'professional', 'custom')),
    has_sound_system BOOLEAN DEFAULT FALSE,
    streaming_capable BOOLEAN DEFAULT FALSE,
    
    -- Dynamic Pricing by Event Type
    conference_hourly_rate DECIMAL(10,2),
    conference_daily_rate DECIMAL(10,2),
    fashion_show_hourly_rate DECIMAL(10,2),
    fashion_show_daily_rate DECIMAL(10,2),
    wedding_hourly_rate DECIMAL(10,2),
    wedding_daily_rate DECIMAL(10,2),
    
    -- Standard Pricing
    hourly_rate DECIMAL(10,2),
    daily_rate DECIMAL(10,2),
    cleaning_fee DECIMAL(10,2),
    security_deposit DECIMAL(10,2),
    
    -- Availability
    operating_hours JSONB DEFAULT '{}',
    booking_lead_time_days INTEGER DEFAULT 7 CHECK (booking_lead_time_days >= 0),
    cancellation_policy TEXT,
    cancellation_fee_percentage DECIMAL(5,2) DEFAULT 0 CHECK (
        cancellation_fee_percentage >= 0 AND cancellation_fee_percentage <= 100
    ),
    
    -- Contact
    contact_name TEXT NOT NULL,
    contact_email TEXT NOT NULL CHECK (contact_email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    contact_phone VARCHAR(20) NOT NULL CHECK (contact_phone ~ '^\+?[1-9]\d{1,14}$'),
    
    -- Media
    images JSONB DEFAULT '[]',
    virtual_tour_url TEXT,
    floor_plan_url TEXT,
    
    -- Service Areas
    service_radius_km INTEGER DEFAULT 0,
    service_cities TEXT[] DEFAULT '{}',
    
    -- Status
    status TEXT DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'maintenance')),
    is_featured BOOLEAN DEFAULT FALSE,
    is_verified BOOLEAN DEFAULT FALSE,
    verification_date DATE,
    rating DECIMAL(3,2) CHECK (rating >= 0 AND rating <= 5),
    review_count INTEGER DEFAULT 0 CHECK (review_count >= 0),
    
    -- Metadata
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Venue Availability Calendar
CREATE TABLE venue_availability (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    venue_id UUID REFERENCES venues(id) ON DELETE CASCADE NOT NULL,
    date DATE NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    event_id UUID, -- Will reference events(id) after events table is created
    hold_expires_at TIMESTAMPTZ,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(venue_id, date)
);

-- Indexes for venues
CREATE INDEX idx_venues_org ON venues(organization_id);
CREATE INDEX idx_venues_slug ON venues(slug);
CREATE INDEX idx_venues_type ON venues(venue_type);
CREATE INDEX idx_venues_city ON venues(city);
CREATE INDEX idx_venues_status ON venues(status) WHERE status = 'active';
CREATE INDEX idx_venues_featured ON venues(is_featured) WHERE is_featured = TRUE;
CREATE INDEX idx_venues_capacity ON venues(capacity_seated, capacity_standing);
CREATE INDEX idx_venue_availability_date ON venue_availability(venue_id, date);
CREATE INDEX idx_venue_availability_available ON venue_availability(date, is_available) WHERE is_available = TRUE;

-- Full text search for venues
CREATE INDEX idx_venues_search ON venues USING gin(to_tsvector('english', name || ' ' || COALESCE(description, '')));

-- ==============================================
-- TABLE 5: EVENTS (Event Management Core)
-- ==============================================

CREATE TABLE events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE NOT NULL,
    name TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    description TEXT,
    
    -- Event Details
    event_type TEXT NOT NULL CHECK (event_type IN (
        'fashion', 'tech', 'cultural', 'business', 'networking', 
        'conference', 'workshop', 'social', 'wedding', 'other'
    )),
    industry_type TEXT CHECK (industry_type IN (
        'fashion', 'technology', 'healthcare', 'finance', 'education', 
        'entertainment', 'nonprofit', 'government', 'other'
    )),
    format TEXT DEFAULT 'in-person' CHECK (format IN ('in-person', 'virtual', 'hybrid')),
    priority_level TEXT DEFAULT 'medium' CHECK (priority_level IN ('low', 'medium', 'high', 'critical')),
    
    -- Categories and Tags
    primary_category TEXT,
    secondary_categories TEXT[] DEFAULT '{}',
    tags TEXT[] DEFAULT '{}',
    theme TEXT,
    
    -- Status
    status TEXT DEFAULT 'draft' CHECK (status IN (
        'draft', 'published', 'live', 'completed', 'cancelled', 'postponed', 'archived'
    )),
    visibility TEXT DEFAULT 'public' CHECK (visibility IN ('public', 'private', 'unlisted')),
    allow_guest_invites BOOLEAN DEFAULT FALSE,
    allow_ticket_transfer BOOLEAN DEFAULT TRUE,
    
    -- Schedule
    start_date TIMESTAMPTZ NOT NULL,
    end_date TIMESTAMPTZ NOT NULL,
    timezone TEXT NOT NULL DEFAULT 'America/Toronto',
    schedule JSONB DEFAULT '[]', -- Detailed agenda
    
    -- Venue
    venue_id UUID REFERENCES venues(id),
    venue_requirements JSONB DEFAULT '{}',
    virtual_platform TEXT CHECK (virtual_platform IN (
        'zoom', 'teams', 'google_meet', 'custom', 'other'
    )),
    virtual_link TEXT,
    virtual_password TEXT,
    
    -- Capacity & Registration
    capacity INTEGER NOT NULL CHECK (capacity > 0),
    min_capacity INTEGER DEFAULT 0 CHECK (min_capacity >= 0),
    registered_count INTEGER DEFAULT 0 CHECK (registered_count >= 0),
    waitlist_count INTEGER DEFAULT 0 CHECK (waitlist_count >= 0),
    
    -- Registration Settings
    registration_opens_at TIMESTAMPTZ,
    registration_closes_at TIMESTAMPTZ,
    early_bird_ends_at TIMESTAMPTZ,
    allow_waitlist BOOLEAN DEFAULT TRUE,
    requires_approval BOOLEAN DEFAULT FALSE,
    approval_message TEXT,
    
    -- Financial
    budget DECIMAL(12,2) CHECK (budget >= 0),
    revenue_target DECIMAL(12,2) CHECK (revenue_target >= 0),
    ticket_revenue DECIMAL(12,2) DEFAULT 0,
    sponsorship_revenue DECIMAL(12,2) DEFAULT 0,
    
    -- Content
    cover_image_url TEXT,
    thumbnail_url TEXT,
    gallery JSONB DEFAULT '[]',
    promotional_video_url TEXT,
    
    -- SEO & Social
    meta_title TEXT,
    meta_description TEXT,
    meta_keywords TEXT[] DEFAULT '{}',
    social_share_image TEXT,
    
    -- Event Specific Settings
    age_restriction_min INTEGER CHECK (age_restriction_min >= 0 AND age_restriction_min <= 100),
    age_restriction_max INTEGER CHECK (age_restriction_max >= 0 AND age_restriction_max <= 100),
    dress_code TEXT,
    parking_available BOOLEAN DEFAULT TRUE,
    food_provided BOOLEAN DEFAULT FALSE,
    alcohol_served BOOLEAN DEFAULT FALSE,
    
    -- Custom Fields Configuration
    custom_fields JSONB DEFAULT '[]',
    
    -- Team
    created_by UUID REFERENCES profiles(id) NOT NULL,
    event_manager_id UUID REFERENCES profiles(id),
    
    -- Metadata
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    published_at TIMESTAMPTZ,
    completed_at TIMESTAMPTZ,
    
    -- Constraints
    CONSTRAINT valid_dates CHECK (end_date > start_date),
    CONSTRAINT valid_capacity CHECK (min_capacity <= capacity),
    CONSTRAINT valid_registration CHECK (registered_count <= capacity),
    CONSTRAINT valid_total_attendees CHECK (registered_count + waitlist_count <= capacity * 1.5), -- Allow 50% waitlist
    CONSTRAINT valid_registration_window CHECK (
        (registration_opens_at IS NULL OR registration_opens_at < start_date) AND
        (registration_closes_at IS NULL OR registration_closes_at <= start_date) AND
        (early_bird_ends_at IS NULL OR early_bird_ends_at < start_date)
    ),
    CONSTRAINT valid_age_restriction CHECK (
        (age_restriction_min IS NULL AND age_restriction_max IS NULL) OR
        (age_restriction_min IS NOT NULL AND age_restriction_max IS NOT NULL AND 
         age_restriction_max >= age_restriction_min)
    )
);

-- Event Categories Table
CREATE TABLE event_categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL UNIQUE,
    slug TEXT NOT NULL UNIQUE,
    description TEXT,
    parent_id UUID REFERENCES event_categories(id),
    icon TEXT,
    color VARCHAR(7) CHECK (color ~ '^#[0-9A-Fa-f]{6}$'),
    is_active BOOLEAN DEFAULT TRUE,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add foreign key constraint for venue_availability now that events table exists
ALTER TABLE venue_availability 
ADD CONSTRAINT fk_venue_availability_event 
FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE SET NULL;

-- Indexes for events
CREATE INDEX idx_events_org ON events(organization_id);
CREATE INDEX idx_events_slug ON events(slug);
CREATE INDEX idx_events_status ON events(status);
CREATE INDEX idx_events_type ON events(event_type);
CREATE INDEX idx_events_industry ON events(industry_type) WHERE industry_type IS NOT NULL;
CREATE INDEX idx_events_priority ON events(priority_level);
CREATE INDEX idx_events_dates ON events(start_date, end_date);
CREATE INDEX idx_events_venue ON events(venue_id);
CREATE INDEX idx_events_created_by ON events(created_by);
CREATE INDEX idx_events_manager ON events(event_manager_id) WHERE event_manager_id IS NOT NULL;

-- Composite indexes for common queries
CREATE INDEX idx_events_public_upcoming ON events(start_date) 
    WHERE status = 'published' AND visibility = 'public' AND start_date > NOW();
CREATE INDEX idx_events_org_status ON events(organization_id, status);
CREATE INDEX idx_events_type_status ON events(event_type, status);

-- Full text search for events
CREATE INDEX idx_events_search ON events USING gin(
    to_tsvector('english', 
        name || ' ' || 
        COALESCE(description, '') || ' ' || 
        COALESCE(array_to_string(tags, ' '), '')
    )
);

-- ==============================================
-- ROW LEVEL SECURITY (RLS) SETUP
-- ==============================================

-- Enable RLS on all tables
ALTER TABLE organizations ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_organizations ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_role_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE venues ENABLE ROW LEVEL SECURITY;
ALTER TABLE venue_availability ENABLE ROW LEVEL SECURITY;
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
ALTER TABLE event_categories ENABLE ROW LEVEL SECURITY;

-- Basic RLS Policies for Organizations
CREATE POLICY "Users can view organizations they belong to" ON organizations
    FOR SELECT USING (
        id IN (
            SELECT organization_id 
            FROM user_organizations 
            WHERE user_id = auth.uid() AND status = 'active'
        )
    );

CREATE POLICY "Organization owners can update their organization" ON organizations
    FOR UPDATE USING (
        id IN (
            SELECT organization_id 
            FROM user_organizations 
            WHERE user_id = auth.uid() AND role = 'owner' AND status = 'active'
        )
    );

-- Basic RLS Policies for Profiles
CREATE POLICY "Users can view their own profile" ON profiles
    FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update their own profile" ON profiles
    FOR UPDATE USING (auth.uid() = id);

-- Basic RLS Policies for User Organizations
CREATE POLICY "Users can view their organization memberships" ON user_organizations
    FOR SELECT USING (user_id = auth.uid());

-- Basic RLS Policies for Venues
CREATE POLICY "Users can view venues in their organizations" ON venues
    FOR SELECT USING (
        organization_id IN (
            SELECT organization_id 
            FROM user_organizations 
            WHERE user_id = auth.uid() AND status = 'active'
        )
    );

-- Basic RLS Policies for Events
CREATE POLICY "Users can view events in their organizations" ON events
    FOR SELECT USING (
        organization_id IN (
            SELECT organization_id 
            FROM user_organizations 
            WHERE user_id = auth.uid() AND status = 'active'
        )
        OR visibility = 'public'
    );

-- ==============================================
-- TRIGGERS FOR UPDATED_AT TIMESTAMPS
-- ==============================================

-- Function to update timestamps
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply triggers to all tables with updated_at
CREATE TRIGGER update_organizations_updated_at BEFORE UPDATE ON organizations
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_user_organizations_updated_at BEFORE UPDATE ON user_organizations
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_venues_updated_at BEFORE UPDATE ON venues
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_events_updated_at BEFORE UPDATE ON events
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ==============================================
-- INITIAL SAMPLE DATA
-- ==============================================

-- Insert sample organization
INSERT INTO organizations (name, slug, email, phone, business_type, address_line1, city, province, postal_code) 
VALUES 
('EventsOS Demo', 'eventsos-demo', 'demo@eventsos.com', '+1-416-123-4567', 'company', '123 Queen St W', 'Toronto', 'ON', 'M5H 2M9');

-- Insert sample event categories
INSERT INTO event_categories (name, slug, description, color) VALUES
('Fashion Shows', 'fashion-shows', 'Runway shows and fashion events', '#E91E63'),
('Tech Conferences', 'tech-conferences', 'Technology and startup events', '#2196F3'),
('Cultural Events', 'cultural-events', 'Arts, music, and cultural celebrations', '#FF9800'),
('Business Networking', 'business-networking', 'Professional networking events', '#4CAF50'),
('Workshops', 'workshops', 'Educational and training workshops', '#9C27B0');

-- Success message
DO $$
BEGIN
    RAISE NOTICE 'EventsOS Core Tables Successfully Created!';
    RAISE NOTICE '✅ Organizations: Multi-tenant foundation';
    RAISE NOTICE '✅ Profiles: User management with auth integration';
    RAISE NOTICE '✅ User Organizations: Role-based access control';
    RAISE NOTICE '✅ Venues: Comprehensive venue management';
    RAISE NOTICE '✅ Events: Full-featured event management';
    RAISE NOTICE '✅ RLS Policies: Security enabled';
    RAISE NOTICE '✅ Sample Data: Demo organization and categories';
END $$;
