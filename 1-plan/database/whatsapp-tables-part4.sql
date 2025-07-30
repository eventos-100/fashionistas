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
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for whatsapp_event_notifications
CREATE INDEX IF NOT EXISTS idx_whatsapp_notifications_event ON whatsapp_event_notifications(event_id);
CREATE INDEX IF NOT EXISTS idx_whatsapp_notifications_user ON whatsapp_event_notifications(user_id);
CREATE INDEX IF NOT EXISTS idx_whatsapp_notifications_status ON whatsapp_event_notifications(notification_status);
CREATE INDEX IF NOT EXISTS idx_whatsapp_notifications_scheduled ON whatsapp_event_notifications(scheduled_time);
CREATE INDEX IF NOT EXISTS idx_whatsapp_notifications_user_status ON whatsapp_event_notifications(user_id, notification_status);

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
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for event_communication_logs
CREATE INDEX IF NOT EXISTS idx_communication_logs_event ON event_communication_logs(event_id);
CREATE INDEX IF NOT EXISTS idx_communication_logs_user ON event_communication_logs(user_id);
CREATE INDEX IF NOT EXISTS idx_communication_logs_message_id ON event_communication_logs(message_id);
CREATE INDEX IF NOT EXISTS idx_communication_logs_timestamp ON event_communication_logs(timestamp_event DESC);
CREATE INDEX IF NOT EXISTS idx_communication_logs_processed ON event_communication_logs(processed) WHERE processed = FALSE;
CREATE INDEX IF NOT EXISTS idx_communication_logs_event_timestamp ON event_communication_logs(event_id, timestamp_event DESC);
