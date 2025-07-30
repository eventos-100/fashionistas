-- =============================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- =============================================

-- Enable RLS on all WhatsApp tables
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
