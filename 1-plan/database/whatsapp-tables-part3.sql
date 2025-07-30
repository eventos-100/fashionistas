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
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for pinned_events
CREATE INDEX IF NOT EXISTS idx_pinned_events_event ON pinned_events(event_id);
CREATE INDEX IF NOT EXISTS idx_pinned_events_chat ON pinned_events(chat_id);
CREATE INDEX IF NOT EXISTS idx_pinned_events_active ON pinned_events(is_active) WHERE is_active = TRUE;

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
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for whatsapp_event_signups
CREATE INDEX IF NOT EXISTS idx_whatsapp_signups_event ON whatsapp_event_signups(event_id);
CREATE INDEX IF NOT EXISTS idx_whatsapp_signups_user ON whatsapp_event_signups(user_id);
CREATE INDEX IF NOT EXISTS idx_whatsapp_signups_phone ON whatsapp_event_signups(phone_number);
CREATE INDEX IF NOT EXISTS idx_whatsapp_signups_status ON whatsapp_event_signups(signup_status);
