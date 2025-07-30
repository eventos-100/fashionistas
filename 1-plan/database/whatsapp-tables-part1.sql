-- =============================================
-- WHATSAPP EVENT MANAGEMENT & COMMUNICATION
-- EventsOS Platform - WhatsApp Integration (Fixed)
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
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for event_communication
CREATE INDEX IF NOT EXISTS idx_event_communication_event ON event_communication(event_id);
CREATE INDEX IF NOT EXISTS idx_event_communication_type ON event_communication(communication_type);
CREATE INDEX IF NOT EXISTS idx_event_communication_status ON event_communication(status);

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
    UNIQUE(event_id, attendee_id)
);

-- Create indexes for rsvp_tracking
CREATE INDEX IF NOT EXISTS idx_rsvp_tracking_event ON rsvp_tracking(event_id);
CREATE INDEX IF NOT EXISTS idx_rsvp_tracking_attendee ON rsvp_tracking(attendee_id);
CREATE INDEX IF NOT EXISTS idx_rsvp_tracking_status ON rsvp_tracking(rsvp_status);
CREATE INDEX IF NOT EXISTS idx_rsvp_tracking_event_status ON rsvp_tracking(event_id, rsvp_status);
