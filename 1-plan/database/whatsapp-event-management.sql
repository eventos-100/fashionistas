-- =============================================
-- WHATSAPP EVENT MANAGEMENT & COMMUNICATION
-- EventsOS Platform - WhatsApp Integration
-- =============================================

-- Enable UUID extension if not already enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =============================================
-- 1. EVENT COMMUNICATION
-- Tracks WhatsApp communication flow for events
-- =============================================
CREATE TABLE IF NOT EXISTS event_communication (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    communication_type VARCHAR(50) CHECK (communication_type IN ('RSVP', 'reminder', 'edit', 'cancellation', 'notification')),
    message TEXT NOT NULL,  -- WhatsApp message content
    sent_at TIMESTAMPTZ DEFAULT NOW(),
    status VARCHAR(50) CHECK (status IN ('sent', 'failed', 'scheduled')) DEFAULT 'scheduled',
    recipient_count INTEGER DEFAULT 0,
    delivery_rate DECIMAL(5,2),  -- Percentage delivered successfully
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    -- Indexes for performance
    INDEX idx_event_communication_event (event_id),
    INDEX idx_event_communication_type (communication_type),
    INDEX idx_event_communication_status (status)
);

-- =============================================
-- 2. RSVP TRACKING
-- Manages attendee responses via WhatsApp
-- =============================================
CREATE TABLE IF NOT EXISTS rsvp_tracking (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    attendee_id UUID REFERENCES users(id) ON DELETE CASCADE,
    rsvp_status VARCHAR(50) CHECK (rsvp_status IN ('Going', 'Going with guest', 'Maybe', 'Not Going')) DEFAULT 'Maybe',
    guest_count INTEGER DEFAULT 0 CHECK (guest_count >= 0),
    dietary_requirements TEXT,
    special_requests TEXT,
    rsvp_date TIMESTAMPTZ DEFAULT NOW(),
    last_updated TIMESTAMPTZ DEFAULT NOW(),
    response_source VARCHAR(50) CHECK (response_source IN ('whatsapp', 'web', 'mobile', 'email')) DEFAULT 'whatsapp',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    -- Unique constraint: one RSVP per attendee per event
    UNIQUE(event_id, attendee_id),
    
    -- Indexes
    INDEX idx_rsvp_tracking_event (event_id),
    INDEX idx_rsvp_tracking_attendee (attendee_id),
    INDEX idx_rsvp_tracking_status (rsvp_status)
);

-- =============================================
-- 3. EVENT REMINDERS
-- Scheduled WhatsApp reminders for events
-- =============================================
CREATE TABLE IF NOT EXISTS event_reminders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    reminder_type VARCHAR(50) CHECK (reminder_type IN ('pre_event', 'post_event', 'rsvp_deadline', 'payment_due')) DEFAULT 'pre_event',
    reminder_time TIMESTAMPTZ NOT NULL,
    message TEXT NOT NULL,
    reminder_status VARCHAR(50) CHECK (reminder_status IN ('scheduled', 'sent', 'failed', 'cancelled')) DEFAULT 'scheduled',
    target_audience VARCHAR(50) CHECK (target_audience IN ('all', 'confirmed', 'pending', 'vip', 'sponsors')) DEFAULT 'all',
    sent_count INTEGER DEFAULT 0,
    success_count INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    -- Indexes
    INDEX idx_event_reminders_event (event_id),
    INDEX idx_event_reminders_time (reminder_time),
    INDEX idx_event_reminders_status (reminder_status)
);

-- =============================================
-- 4. EVENT UPDATES
-- Track event changes and notifications
-- =============================================
CREATE TABLE IF NOT EXISTS event_updates (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    update_type VARCHAR(50) CHECK (update_type IN ('edit', 'cancellation', 'postponement', 'venue_change', 'time_change')) NOT NULL,
    update_details TEXT NOT NULL,
    previous_values JSONB,  -- Store what changed
    new_values JSONB,       -- Store new values
    update_status VARCHAR(50) CHECK (update_status IN ('pending', 'notified', 'failed')) DEFAULT 'pending',
    affected_attendees INTEGER DEFAULT 0,
    notification_sent BOOLEAN DEFAULT FALSE,
    update_time TIMESTAMPTZ DEFAULT NOW(),
    created_by UUID REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    -- Indexes
    INDEX idx_event_updates_event (event_id),
    INDEX idx_event_updates_type (update_type),
    INDEX idx_event_updates_status (update_status)
);

-- =============================================
-- 5. PINNED EVENTS
-- Track events pinned in WhatsApp chats
-- =============================================
CREATE TABLE IF NOT EXISTS pinned_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    pinned_by UUID REFERENCES users(id) ON DELETE CASCADE,
    chat_id VARCHAR(255),  -- WhatsApp chat identifier
    pinned_at TIMESTAMPTZ DEFAULT NOW(),
    unpinned_at TIMESTAMPTZ,
    is_active BOOLEAN DEFAULT TRUE,
    pin_reason VARCHAR(255),  -- Why was it pinned
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    -- Indexes
    INDEX idx_pinned_events_event (event_id),
    INDEX idx_pinned_events_active (is_active) WHERE is_active = TRUE,
    INDEX idx_pinned_events_chat (chat_id)
);

-- =============================================
-- 6. WHATSAPP EVENT SIGNUPS
-- Manage signups via WhatsApp
-- =============================================
CREATE TABLE IF NOT EXISTS whatsapp_event_signups (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    phone_number VARCHAR(20) NOT NULL,
    signup_status VARCHAR(50) CHECK (signup_status IN ('pending', 'confirmed', 'cancelled', 'waitlist')) DEFAULT 'pending',
    payment_status VARCHAR(50) CHECK (payment_status IN ('pending', 'paid', 'failed', 'refunded')) DEFAULT 'pending',
    ticket_type VARCHAR(100),
    quantity INTEGER DEFAULT 1 CHECK (quantity > 0),
    total_amount DECIMAL(10,2),
    signup_source VARCHAR(50) CHECK (signup_source IN ('whatsapp_link', 'qr_code', 'referral', 'direct_message')) DEFAULT 'whatsapp_link',
    signup_time TIMESTAMPTZ DEFAULT NOW(),
    confirmation_sent BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    -- Indexes
    INDEX idx_whatsapp_signups_event (event_id),
    INDEX idx_whatsapp_signups_user (user_id),
    INDEX idx_whatsapp_signups_phone (phone_number),
    INDEX idx_whatsapp_signups_status (signup_status)
);

-- =============================================
-- 7. WHATSAPP EVENT NOTIFICATIONS
-- Individual notifications sent via WhatsApp
-- =============================================
CREATE TABLE IF NOT EXISTS whatsapp_event_notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    notification_type VARCHAR(50) CHECK (notification_type IN ('reminder', 'update', 'alert', 'confirmation', 'cancellation')) NOT NULL,
    message TEXT NOT NULL,
    notification_status VARCHAR(50) CHECK (notification_status IN ('scheduled', 'sent', 'delivered', 'read', 'failed')) DEFAULT 'scheduled',
    scheduled_time TIMESTAMPTZ,
    sent_time TIMESTAMPTZ,
    delivered_time TIMESTAMPTZ,
    read_time TIMESTAMPTZ,
    whatsapp_message_id VARCHAR(255),  -- WhatsApp API message ID
    error_message TEXT,
    retry_count INTEGER DEFAULT 0,
    max_retries INTEGER DEFAULT 3,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    -- Indexes
    INDEX idx_whatsapp_notifications_event (event_id),
    INDEX idx_whatsapp_notifications_user (user_id),
    INDEX idx_whatsapp_notifications_status (notification_status),
    INDEX idx_whatsapp_notifications_scheduled (scheduled_time)
);

-- =============================================
-- 8. EVENT COMMUNICATION LOGS
-- Detailed WhatsApp communication tracking
-- =============================================
CREATE TABLE IF NOT EXISTS event_communication_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    message_id VARCHAR(255) NOT NULL,  -- WhatsApp message ID
    message_type VARCHAR(50) CHECK (message_type IN ('sent', 'delivered', 'read', 'failed', 'received')) NOT NULL,
    direction VARCHAR(20) CHECK (direction IN ('inbound', 'outbound')) NOT NULL,
    message_content TEXT,
    response TEXT,  -- User response if any
    timestamp_event TIMESTAMPTZ DEFAULT NOW(),
    phone_number VARCHAR(20),
    chat_id VARCHAR(255),
    media_type VARCHAR(50),  -- image, document, audio, etc.
    media_url TEXT,
    webhook_data JSONB,  -- Raw webhook data from WhatsApp
    processed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    -- Indexes
    INDEX idx_communication_logs_event (event_id),
    INDEX idx_communication_logs_user (user_id),
    INDEX idx_communication_logs_message_id (message_id),
    INDEX idx_communication_logs_timestamp (timestamp_event),
    INDEX idx_communication_logs_processed (processed) WHERE processed = FALSE
);

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
    UNIQUE(organization_id, api_name),
    
    -- Indexes
    INDEX idx_whatsapp_api_org (organization_id),
    INDEX idx_whatsapp_api_status (status)
);

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
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    -- Indexes
    INDEX idx_rsvp_reminders_event (event_id),
    INDEX idx_rsvp_reminders_user (user_id),
    INDEX idx_rsvp_reminders_time (reminder_time),
    INDEX idx_rsvp_reminders_sent (reminder_sent)
);

-- =============================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- =============================================

-- Enable RLS on all tables
ALTER TABLE event_communication ENABLE ROW LEVEL SECURITY;
ALTER TABLE rsvp_tracking ENABLE ROW LEVEL SECURITY;
ALTER TABLE event_reminders ENABLE ROW LEVEL SECURITY;
ALTER TABLE event_updates ENABLE ROW LEVEL SECURITY;
ALTER TABLE pinned_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE whatsapp_event_signups ENABLE ROW LEVEL SECURITY;
ALTER TABLE whatsapp_event_notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE event_communication_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE whatsapp_api_integration ENABLE ROW LEVEL SECURITY;
ALTER TABLE event_rsvp_reminders ENABLE ROW LEVEL SECURITY;

-- RLS Policies (Organization-based access)
CREATE POLICY "whatsapp_tenant_policy_event_communication" ON event_communication
    USING (event_id IN (SELECT id FROM events WHERE organization_id = current_user_organization()));

CREATE POLICY "whatsapp_tenant_policy_rsvp_tracking" ON rsvp_tracking
    USING (event_id IN (SELECT id FROM events WHERE organization_id = current_user_organization()));

CREATE POLICY "whatsapp_tenant_policy_event_reminders" ON event_reminders
    USING (event_id IN (SELECT id FROM events WHERE organization_id = current_user_organization()));

CREATE POLICY "whatsapp_tenant_policy_event_updates" ON event_updates
    USING (event_id IN (SELECT id FROM events WHERE organization_id = current_user_organization()));

CREATE POLICY "whatsapp_tenant_policy_pinned_events" ON pinned_events
    USING (event_id IN (SELECT id FROM events WHERE organization_id = current_user_organization()));

CREATE POLICY "whatsapp_tenant_policy_event_signups" ON whatsapp_event_signups
    USING (event_id IN (SELECT id FROM events WHERE organization_id = current_user_organization()));

CREATE POLICY "whatsapp_tenant_policy_notifications" ON whatsapp_event_notifications
    USING (event_id IN (SELECT id FROM events WHERE organization_id = current_user_organization()));

CREATE POLICY "whatsapp_tenant_policy_communication_logs" ON event_communication_logs
    USING (event_id IN (SELECT id FROM events WHERE organization_id = current_user_organization()));

CREATE POLICY "whatsapp_tenant_policy_api_integration" ON whatsapp_api_integration
    USING (organization_id = current_user_organization());

CREATE POLICY "whatsapp_tenant_policy_rsvp_reminders" ON event_rsvp_reminders
    USING (event_id IN (SELECT id FROM events WHERE organization_id = current_user_organization()));

-- =============================================
-- USEFUL FUNCTIONS
-- =============================================

-- Function to get RSVP summary for an event
CREATE OR REPLACE FUNCTION get_event_rsvp_summary(event_uuid UUID)
RETURNS TABLE (
    status VARCHAR(50),
    count BIGINT,
    total_guests INTEGER
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        rt.rsvp_status,
        COUNT(*) as count,
        COALESCE(SUM(rt.guest_count), 0)::INTEGER as total_guests
    FROM rsvp_tracking rt
    WHERE rt.event_id = event_uuid
    GROUP BY rt.rsvp_status;
END;
$$ LANGUAGE plpgsql;

-- Function to schedule RSVP reminders
CREATE OR REPLACE FUNCTION schedule_rsvp_reminders(event_uuid UUID, reminder_hours_before INTEGER DEFAULT 48)
RETURNS INTEGER AS $$
DECLARE
    reminder_count INTEGER := 0;
    event_start TIMESTAMPTZ;
    reminder_time TIMESTAMPTZ;
    attendee_record RECORD;
BEGIN
    -- Get event start time
    SELECT start_date INTO event_start 
    FROM events 
    WHERE id = event_uuid;
    
    IF event_start IS NULL THEN
        RAISE EXCEPTION 'Event not found';
    END IF;
    
    -- Calculate reminder time
    reminder_time := event_start - (reminder_hours_before || ' hours')::INTERVAL;
    
    -- Insert reminders for attendees without RSVP
    FOR attendee_record IN 
        SELECT u.id as user_id
        FROM users u
        INNER JOIN event_attendees ea ON u.id = ea.user_id
        WHERE ea.event_id = event_uuid
        AND u.id NOT IN (
            SELECT attendee_id 
            FROM rsvp_tracking 
            WHERE event_id = event_uuid
        )
    LOOP
        INSERT INTO event_rsvp_reminders (event_id, user_id, reminder_time)
        VALUES (event_uuid, attendee_record.user_id, reminder_time)
        ON CONFLICT DO NOTHING;
        
        reminder_count := reminder_count + 1;
    END LOOP;
    
    RETURN reminder_count;
END;
$$ LANGUAGE plpgsql;

-- =============================================
-- VIEWS FOR REPORTING
-- =============================================

-- WhatsApp Communication Dashboard View
CREATE OR REPLACE VIEW whatsapp_communication_dashboard AS
SELECT 
    e.title as event_title,
    e.start_date,
    COUNT(DISTINCT ec.id) as total_communications,
    COUNT(DISTINCT CASE WHEN ec.status = 'sent' THEN ec.id END) as sent_count,
    COUNT(DISTINCT CASE WHEN ec.status = 'failed' THEN ec.id END) as failed_count,
    COUNT(DISTINCT rt.id) as total_rsvps,
    COUNT(DISTINCT CASE WHEN rt.rsvp_status = 'Going' THEN rt.id END) as confirmed_attendees,
    COUNT(DISTINCT CASE WHEN rt.rsvp_status = 'Going with guest' THEN rt.id END) as attendees_with_guests,
    COALESCE(SUM(rt.guest_count), 0) as total_guests
FROM events e
LEFT JOIN event_communication ec ON e.id = ec.event_id
LEFT JOIN rsvp_tracking rt ON e.id = rt.event_id
GROUP BY e.id, e.title, e.start_date
ORDER BY e.start_date DESC;

-- RSVP Status Overview
CREATE OR REPLACE VIEW rsvp_status_overview AS
SELECT 
    e.title as event_title,
    e.start_date,
    rt.rsvp_status,
    COUNT(*) as attendee_count,
    SUM(rt.guest_count) as guest_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY e.id), 2) as percentage
FROM events e
INNER JOIN rsvp_tracking rt ON e.id = rt.event_id
GROUP BY e.id, e.title, e.start_date, rt.rsvp_status
ORDER BY e.start_date DESC, rt.rsvp_status;

-- =============================================
-- TRIGGERS FOR AUTOMATION
-- =============================================

-- Trigger to update RSVP tracking timestamp on changes
CREATE OR REPLACE FUNCTION update_rsvp_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.last_updated = NOW();
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER rsvp_tracking_update_timestamp
    BEFORE UPDATE ON rsvp_tracking
    FOR EACH ROW
    EXECUTE FUNCTION update_rsvp_timestamp();

-- Trigger to log RSVP changes
CREATE OR REPLACE FUNCTION log_rsvp_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'UPDATE' AND OLD.rsvp_status != NEW.rsvp_status THEN
        INSERT INTO event_communication_logs (
            event_id, 
            user_id, 
            message_id, 
            message_type, 
            direction,
            response,
            processed
        ) VALUES (
            NEW.event_id,
            NEW.attendee_id,
            'rsvp_change_' || NEW.id,
            'received',
            'inbound',
            'RSVP changed from ' || OLD.rsvp_status || ' to ' || NEW.rsvp_status,
            TRUE
        );
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER rsvp_change_logger
    AFTER UPDATE ON rsvp_tracking
    FOR EACH ROW
    EXECUTE FUNCTION log_rsvp_changes();

-- =============================================
-- SAMPLE DATA (Optional)
-- =============================================

-- Insert sample WhatsApp API integration
INSERT INTO whatsapp_api_integration (
    organization_id,
    api_name,
    api_key,
    api_url,
    phone_number_id,
    status
) VALUES (
    (SELECT id FROM organizations LIMIT 1),
    'WhatsApp Business API',
    'sample_api_key_123',
    'https://graph.facebook.com/v18.0',
    '1234567890',
    'testing'
) ON CONFLICT DO NOTHING;

-- =============================================
-- INDEXES FOR PERFORMANCE OPTIMIZATION
-- =============================================

-- Composite indexes for common queries
CREATE INDEX IF NOT EXISTS idx_rsvp_tracking_event_status ON rsvp_tracking(event_id, rsvp_status);
CREATE INDEX IF NOT EXISTS idx_event_reminders_time_status ON event_reminders(reminder_time, reminder_status);
CREATE INDEX IF NOT EXISTS idx_whatsapp_notifications_user_status ON whatsapp_event_notifications(user_id, notification_status);
CREATE INDEX IF NOT EXISTS idx_communication_logs_event_timestamp ON event_communication_logs(event_id, timestamp_event DESC);

-- =============================================
-- COMPLETION MESSAGE
-- =============================================

DO $$
BEGIN
    RAISE NOTICE '✅ WhatsApp Event Management tables created successfully!';
    RAISE NOTICE '📊 Tables added:';
    RAISE NOTICE '   • event_communication';
    RAISE NOTICE '   • rsvp_tracking';
    RAISE NOTICE '   • event_reminders';
    RAISE NOTICE '   • event_updates';
    RAISE NOTICE '   • pinned_events';
    RAISE NOTICE '   • whatsapp_event_signups';
    RAISE NOTICE '   • whatsapp_event_notifications';
    RAISE NOTICE '   • event_communication_logs';
    RAISE NOTICE '   • whatsapp_api_integration';
    RAISE NOTICE '   • event_rsvp_reminders';
    RAISE NOTICE '🔒 RLS policies enabled for multi-tenant security';
    RAISE NOTICE '📈 Performance indexes created';
    RAISE NOTICE '🎯 Ready for WhatsApp integration!';
END $$;
