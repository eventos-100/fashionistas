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
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for event_reminders
CREATE INDEX IF NOT EXISTS idx_event_reminders_event ON event_reminders(event_id);
CREATE INDEX IF NOT EXISTS idx_event_reminders_time ON event_reminders(reminder_time);
CREATE INDEX IF NOT EXISTS idx_event_reminders_status ON event_reminders(reminder_status);
CREATE INDEX IF NOT EXISTS idx_event_reminders_time_status ON event_reminders(reminder_time, reminder_status);

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
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for event_updates
CREATE INDEX IF NOT EXISTS idx_event_updates_event ON event_updates(event_id);
CREATE INDEX IF NOT EXISTS idx_event_updates_type ON event_updates(update_type);
CREATE INDEX IF NOT EXISTS idx_event_updates_status ON event_updates(update_status);
