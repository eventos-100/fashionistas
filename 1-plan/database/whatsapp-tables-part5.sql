-- =============================================
-- 9. WHATSAPP API INTEGRATION
-- API configuration and credentials
-- =============================================
CREATE TABLE IF NOT EXISTS whatsapp_api_integration (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    api_name VARCHAR(100) NOT NULL,  -- 'Twilio', 'WhatsApp Business API', 'Meta Business'
    api_key TEXT NOT NULL,
    api_secret TEXT,
    api_url TEXT NOT NULL,
    webhook_url TEXT,
    phone_number_id VARCHAR(100),  -- WhatsApp Business Phone Number ID
    business_account_id VARCHAR(100),  -- WhatsApp Business Account ID
    status VARCHAR(50) CHECK (status IN ('active', 'inactive', 'suspended', 'testing')) DEFAULT 'testing',
    rate_limit_per_minute INTEGER DEFAULT 60,
    rate_limit_per_hour INTEGER DEFAULT 1000,
    webhook_verification_token TEXT,
    last_health_check TIMESTAMPTZ,
    health_status VARCHAR(50) CHECK (health_status IN ('healthy', 'warning', 'error')) DEFAULT 'healthy',
    configuration JSONB,  -- Additional API-specific settings
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    -- Unique constraint per organization
    UNIQUE(organization_id, api_name)
);

-- Create indexes for whatsapp_api_integration
CREATE INDEX IF NOT EXISTS idx_whatsapp_api_org ON whatsapp_api_integration(organization_id);
CREATE INDEX IF NOT EXISTS idx_whatsapp_api_status ON whatsapp_api_integration(status);

-- =============================================
-- 10. EVENT RSVP REMINDERS
-- Automated RSVP reminder scheduling
-- =============================================
CREATE TABLE IF NOT EXISTS event_rsvp_reminders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    reminder_type VARCHAR(50) CHECK (reminder_type IN ('initial', 'follow_up', 'final', 'deadline')) DEFAULT 'initial',
    reminder_sent BOOLEAN DEFAULT FALSE,
    reminder_time TIMESTAMPTZ NOT NULL,
    sent_time TIMESTAMPTZ,
    response_received BOOLEAN DEFAULT FALSE,
    response_time TIMESTAMPTZ,
    escalation_level INTEGER DEFAULT 1 CHECK (escalation_level BETWEEN 1 AND 5),
    template_used VARCHAR(100),  -- Reference to message template
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for event_rsvp_reminders
CREATE INDEX IF NOT EXISTS idx_rsvp_reminders_event ON event_rsvp_reminders(event_id);
CREATE INDEX IF NOT EXISTS idx_rsvp_reminders_user ON event_rsvp_reminders(user_id);
CREATE INDEX IF NOT EXISTS idx_rsvp_reminders_time ON event_rsvp_reminders(reminder_time);
CREATE INDEX IF NOT EXISTS idx_rsvp_reminders_sent ON event_rsvp_reminders(reminder_sent);
