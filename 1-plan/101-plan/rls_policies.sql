-- ============================================
-- ROW LEVEL SECURITY POLICIES
-- ============================================

-- Enable RLS on all tables
ALTER TABLE organizations ENABLE ROW LEVEL SECURITY;
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
ALTER TABLE event_team_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE budgets ENABLE ROW LEVEL SECURITY;
ALTER TABLE vendors ENABLE ROW LEVEL SECURITY;
ALTER TABLE vendor_contracts ENABLE ROW LEVEL SECURITY;
ALTER TABLE venues ENABLE ROW LEVEL SECURITY;
ALTER TABLE ai_agents ENABLE ROW LEVEL SECURITY;
ALTER TABLE ai_conversations ENABLE ROW LEVEL SECURITY;
ALTER TABLE ai_generated_content ENABLE ROW LEVEL SECURITY;
ALTER TABLE automation_workflows ENABLE ROW LEVEL SECURITY;
ALTER TABLE workflow_executions ENABLE ROW LEVEL SECURITY;
ALTER TABLE marketing_campaigns ENABLE ROW LEVEL SECURITY;
ALTER TABLE social_media_accounts ENABLE ROW LEVEL SECURITY;
ALTER TABLE social_media_posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE influencers ENABLE ROW LEVEL SECURITY;
ALTER TABLE influencer_campaigns ENABLE ROW LEVEL SECURITY;
ALTER TABLE sponsor_prospects ENABLE ROW LEVEL SECURITY;
ALTER TABLE sponsorship_packages ENABLE ROW LEVEL SECURITY;
ALTER TABLE sponsorship_deals ENABLE ROW LEVEL SECURITY;
ALTER TABLE sponsor_onboarding_steps ENABLE ROW LEVEL SECURITY;
ALTER TABLE sponsor_activations ENABLE ROW LEVEL SECURITY;
ALTER TABLE ticket_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE pricing_rules ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE discount_codes ENABLE ROW LEVEL SECURITY;
ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;
ALTER TABLE analytics_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE performance_metrics ENABLE ROW LEVEL SECURITY;
ALTER TABLE custom_reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE message_templates ENABLE ROW LEVEL SECURITY;
ALTER TABLE notification_campaigns ENABLE ROW LEVEL SECURITY;
ALTER TABLE message_log ENABLE ROW LEVEL SECURITY;
ALTER TABLE audit_log ENABLE ROW LEVEL SECURITY;
ALTER TABLE file_uploads ENABLE ROW LEVEL SECURITY;
ALTER TABLE integration_logs ENABLE ROW LEVEL SECURITY;

-- ============================================
-- HELPER FUNCTIONS FOR RLS
-- ============================================

-- Get current user's organization ID
CREATE OR REPLACE FUNCTION get_user_organization_id()
RETURNS UUID AS $
BEGIN
    RETURN (
        SELECT organization_id 
        FROM users 
        WHERE auth_user_id = auth.uid()
    );
END;
$ LANGUAGE plpgsql SECURITY DEFINER;

-- Check if user has specific role
CREATE OR REPLACE FUNCTION user_has_role(required_role TEXT)
RETURNS BOOLEAN AS $
BEGIN
    RETURN EXISTS (
        SELECT 1 
        FROM users 
        WHERE auth_user_id = auth.uid() 
        AND role = required_role
        AND is_active = true
    );
END;
$ LANGUAGE plpgsql SECURITY DEFINER;

-- Check if user has permission for specific event
CREATE OR REPLACE FUNCTION user_has_event_access(event_uuid UUID, required_access TEXT DEFAULT 'read')
RETURNS BOOLEAN AS $
BEGIN
    RETURN EXISTS (
        SELECT 1 
        FROM event_team_members etm
        JOIN users u ON etm.user_id = u.id
        WHERE u.auth_user_id = auth.uid()
        AND etm.event_id = event_uuid
        AND etm.is_active = true
        AND (
            required_access = 'read' OR
            etm.access_level = 'admin' OR
            (required_access = 'write' AND etm.access_level IN ('write', 'admin'))
        )
    );
END;
$ LANGUAGE plpgsql SECURITY DEFINER;

-- Check if user is organization admin
CREATE OR REPLACE FUNCTION is_organization_admin()
RETURNS BOOLEAN AS $
BEGIN
    RETURN EXISTS (
        SELECT 1 
        FROM users 
        WHERE auth_user_id = auth.uid() 
        AND role IN ('super_admin', 'admin')
        AND is_active = true
    );
END;
$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- SERVICE ROLE POLICIES
-- ============================================

-- Allow service role full access to all tables
CREATE POLICY "Service role full access" ON organizations
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON users
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON events
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON event_team_members
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON tasks
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON budgets
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON vendors
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON vendor_contracts
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON venues
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON ai_agents
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON ai_conversations
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON ai_generated_content
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON automation_workflows
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON workflow_executions
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON marketing_campaigns
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON social_media_accounts
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON social_media_posts
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON influencers
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON influencer_campaigns
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON sponsor_prospects
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON sponsorship_packages
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON sponsorship_deals
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON sponsor_onboarding_steps
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON sponsor_activations
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON ticket_categories
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON pricing_rules
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON orders
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON order_items
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON discount_codes
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON waitlist
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON analytics_events
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON performance_metrics
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON custom_reports
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON message_templates
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON notification_campaigns
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON message_log
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON audit_log
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON file_uploads
    FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Service role full access" ON integration_logs
    FOR ALL USING (auth.role() = 'service_role');

-- ============================================
-- ORGANIZATION-LEVEL POLICIES
-- ============================================

-- Organizations: Users can only see their own organization
CREATE POLICY "Users can view own organization" ON organizations
    FOR SELECT USING (id = get_user_organization_id());

CREATE POLICY "Admins can update own organization" ON organizations
    FOR UPDATE USING (id = get_user_organization_id() AND is_organization_admin());

-- Users: Organization isolation
CREATE POLICY "Users can view organization members" ON users
    FOR SELECT USING (organization_id = get_user_organization_id());

CREATE POLICY "Users can update their own profile" ON users
    FOR UPDATE USING (auth_user_id = auth.uid());

CREATE POLICY "Admins can manage organization users" ON users
    FOR ALL USING (
        organization_id = get_user_organization_id() 
        AND is_organization_admin()
    );

-- ============================================
-- EVENT-LEVEL POLICIES
-- ============================================

-- Events: Organization and team member access
CREATE POLICY "Users can view organization events" ON events
    FOR SELECT USING (organization_id = get_user_organization_id());

CREATE POLICY "Event directors can manage events" ON events
    FOR ALL USING (
        organization_id = get_user_organization_id() 
        AND (
            user_has_role('event_director') OR 
            user_has_role('admin') OR 
            user_has_role('super_admin')
        )
    );

-- Event Team Members: Event-specific access
CREATE POLICY "Users can view event team assignments" ON event_team_members
    FOR SELECT USING (user_has_event_access(event_id, 'read'));

CREATE POLICY "Event admins can manage team" ON event_team_members
    FOR ALL USING (user_has_event_access(event_id, 'admin'));

-- Tasks: Event team access with assignment restrictions
CREATE POLICY "Team members can view event tasks" ON tasks
    FOR SELECT USING (user_has_event_access(event_id, 'read'));

CREATE POLICY "Assigned users can update their tasks" ON tasks
    FOR UPDATE USING (
        user_has_event_access(event_id, 'write') AND
        (assigned_to = (SELECT id FROM users WHERE auth_user_id = auth.uid()) OR
         user_has_event_access(event_id, 'admin'))
    );

CREATE POLICY "Event managers can manage all tasks" ON tasks
    FOR ALL USING (user_has_event_access(event_id, 'admin'));

-- Budgets: Financial data access restrictions
CREATE POLICY "Event team can view budgets" ON budgets
    FOR SELECT USING (user_has_event_access(event_id, 'read'));

CREATE POLICY "Financial managers can manage budgets" ON budgets
    FOR ALL USING (
        user_has_event_access(event_id, 'admin') AND
        user_has_role('admin') OR user_has_role('event_director')
    );

-- ============================================
-- MARKETING & SOCIAL MEDIA POLICIES
-- ============================================

-- Marketing Campaigns: Event-based access
CREATE POLICY "Team can view marketing campaigns" ON marketing_campaigns
    FOR SELECT USING (user_has_event_access(event_id, 'read'));

CREATE POLICY "Marketing managers can manage campaigns" ON marketing_campaigns
    FOR ALL USING (
        user_has_event_access(event_id, 'write') AND
        (user_has_role('marketing_manager') OR user_has_role('admin'))
    );

-- Social Media Accounts: Organization-level
CREATE POLICY "Users can view org social accounts" ON social_media_accounts
    FOR SELECT USING (organization_id = get_user_organization_id());

CREATE POLICY "Marketing team can manage social accounts" ON social_media_accounts
    FOR ALL USING (
        organization_id = get_user_organization_id() AND
        (user_has_role('marketing_manager') OR is_organization_admin())
    );

-- Social Media Posts: Campaign-based access
CREATE POLICY "Team can view social posts" ON social_media_posts
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM marketing_campaigns mc
            WHERE mc.id = campaign_id
            AND user_has_event_access(mc.event_id, 'read')
        )
    );

CREATE POLICY "Marketing team can manage posts" ON social_media_posts
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM marketing_campaigns mc
            WHERE mc.id = campaign_id
            AND user_has_event_access(mc.event_id, 'write')
            AND (user_has_role('marketing_manager') OR user_has_role('admin'))
        )
    );

-- ============================================
-- SPONSORSHIP POLICIES
-- ============================================

-- Sponsor Prospects: Organization-level with sales access
CREATE POLICY "Sales team can view prospects" ON sponsor_prospects
    FOR SELECT USING (
        organization_id = get_user_organization_id() AND
        (user_has_role('sales_manager') OR is_organization_admin())
    );

CREATE POLICY "Sales team can manage prospects" ON sponsor_prospects
    FOR ALL USING (
        organization_id = get_user_organization_id() AND
        (user_has_role('sales_manager') OR is_organization_admin())
    );

-- Sponsorship Packages: Event-based access
CREATE POLICY "Team can view sponsorship packages" ON sponsorship_packages
    FOR SELECT USING (user_has_event_access(event_id, 'read'));

CREATE POLICY "Sales managers can manage packages" ON sponsorship_packages
    FOR ALL USING (
        user_has_event_access(event_id, 'admin') AND
        (user_has_role('sales_manager') OR user_has_role('admin'))
    );

-- Sponsorship Deals: Event and assignment-based access
CREATE POLICY "Assigned sales can view deals" ON sponsorship_deals
    FOR SELECT USING (
        user_has_event_access(event_id, 'read') AND
        (assigned_to = (SELECT id FROM users WHERE auth_user_id = auth.uid()) OR
         user_has_role('sales_manager') OR 
         is_organization_admin())
    );

CREATE POLICY "Assigned sales can manage deals" ON sponsorship_deals
    FOR ALL USING (
        user_has_event_access(event_id, 'write') AND
        (assigned_to = (SELECT id FROM users WHERE auth_user_id = auth.uid()) OR
         user_has_role('sales_manager') OR 
         is_organization_admin())
    );

-- ============================================
-- TICKETING POLICIES
-- ============================================

-- Ticket Categories: Event-based access
CREATE POLICY "Team can view ticket categories" ON ticket_categories
    FOR SELECT USING (user_has_event_access(event_id, 'read'));

CREATE POLICY "Event managers can manage tickets" ON ticket_categories
    FOR ALL USING (user_has_event_access(event_id, 'admin'));

-- Orders: Event-based with customer privacy
CREATE POLICY "Team can view event orders" ON orders
    FOR SELECT USING (user_has_event_access(event_id, 'read'));

CREATE POLICY "Customers can view their orders" ON orders
    FOR SELECT USING (
        customer_email = (SELECT email FROM users WHERE auth_user_id = auth.uid())
    );

-- Order Items: Linked to order access
CREATE POLICY "Authorized users can view order items" ON order_items
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM orders o
            WHERE o.id = order_id
            AND (
                user_has_event_access(o.event_id, 'read') OR
                o.customer_email = (SELECT email FROM users WHERE auth_user_id = auth.uid())
            )
        )
    );

-- ============================================
-- AI & AUTOMATION POLICIES
-- ============================================

-- AI Agents: Organization-level
CREATE POLICY "Users can view org AI agents" ON ai_agents
    FOR SELECT USING (organization_id = get_user_organization_id());

CREATE POLICY "Admins can manage AI agents" ON ai_agents
    FOR ALL USING (
        organization_id = get_user_organization_id() AND
        is_organization_admin()
    );

-- AI Conversations: User and event-based access
CREATE POLICY "Users can view their conversations" ON ai_conversations
    FOR SELECT USING (
        user_id = (SELECT id FROM users WHERE auth_user_id = auth.uid()) OR
        (event_id IS NOT NULL AND user_has_event_access(event_id, 'read'))
    );

CREATE POLICY "Users can create conversations" ON ai_conversations
    FOR INSERT WITH CHECK (
        user_id = (SELECT id FROM users WHERE auth_user_id = auth.uid()) OR
        (event_id IS NOT NULL AND user_has_event_access(event_id, 'write'))
    );

-- Automation Workflows: Organization admin access
CREATE POLICY "Admins can view workflows" ON automation_workflows
    FOR SELECT USING (
        organization_id = get_user_organization_id() AND
        is_organization_admin()
    );

CREATE POLICY "Admins can manage workflows" ON automation_workflows
    FOR ALL USING (
        organization_id = get_user_organization_id() AND
        is_organization_admin()
    );

-- ============================================
-- ANALYTICS & REPORTING POLICIES
-- ============================================

-- Analytics Events: Organization-level with privacy
CREATE POLICY "Analytics team can view events" ON analytics_events
    FOR SELECT USING (
        organization_id = get_user_organization_id() AND
        (is_organization_admin() OR user_has_role('marketing_manager'))
    );

-- Performance Metrics: Event and organization access
CREATE POLICY "Team can view event metrics" ON performance_metrics
    FOR SELECT USING (
        organization_id = get_user_organization_id() AND
        (event_id IS NULL OR user_has_event_access(event_id, 'read'))
    );

-- Custom Reports: Creator and admin access
CREATE POLICY "Users can view accessible reports" ON custom_reports
    FOR SELECT USING (
        organization_id = get_user_organization_id() AND
        (created_by = (SELECT id FROM users WHERE auth_user_id = auth.uid()) OR
         is_organization_admin())
    );

CREATE POLICY "Users can manage their reports" ON custom_reports
    FOR ALL USING (
        organization_id = get_user_organization_id() AND
        created_by = (SELECT id FROM users WHERE auth_user_id = auth.uid())
    );

-- ============================================
-- COMMUNICATION POLICIES
-- ============================================

-- Message Templates: Organization-level
CREATE POLICY "Users can view message templates" ON message_templates
    FOR SELECT USING (organization_id = get_user_organization_id());

CREATE POLICY "Marketing team can manage templates" ON message_templates  
    FOR ALL USING (
        organization_id = get_user_organization_id() AND
        (user_has_role('marketing_manager') OR is_organization_admin())
    );

-- ============================================
-- AUDIT & SYSTEM POLICIES
-- ============================================

-- Audit Log: Admin-only access
CREATE POLICY "Admins can view audit log" ON audit_log
    FOR SELECT USING (
        organization_id = get_user_organization_id() AND
        is_organization_admin()
    );

-- File Uploads: Organization and entity-based access
CREATE POLICY "Users can view org files" ON file_uploads
    FOR SELECT USING (
        organization_id = get_user_organization_id() AND
        (is_public = true OR 
         uploaded_by = (SELECT id FROM users WHERE auth_user_id = auth.uid()) OR
         is_organization_admin())
    );

CREATE POLICY "Users can upload files" ON file_uploads
    FOR INSERT WITH CHECK (
        organization_id = get_user_organization_id() AND
        uploaded_by = (SELECT id FROM users WHERE auth_user_id = auth.uid())
    );

-- Integration Logs: Admin-only access
CREATE POLICY "Admins can view integration logs" ON integration_logs
    FOR SELECT USING (
        organization_id = get_user_organization_id() AND 
        is_organization_admin()
    );