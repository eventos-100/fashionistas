-- ============================================
-- DATABASE TRIGGERS & FUNCTIONS
-- ============================================

-- ============================================
-- UTILITY FUNCTIONS
-- ============================================

-- Update timestamp function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Generate order number function
CREATE OR REPLACE FUNCTION generate_order_number()
RETURNS TRIGGER AS $$
BEGIN
    NEW.order_number = 'ORD-' || TO_CHAR(NOW(), 'YYYYMMDD') || '-' || LPAD(nextval('order_sequence')::TEXT, 6, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create sequence for order numbers
CREATE SEQUENCE IF NOT EXISTS order_sequence START 1;

-- Audit logging function
CREATE OR REPLACE FUNCTION audit_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO audit_log (
        organization_id,
        user_id,
        action,
        entity_type,
        entity_id,
        old_values,
        new_values,
        created_at
    ) VALUES (
        COALESCE(NEW.organization_id, OLD.organization_id),
        current_setting('app.current_user_id', true)::UUID,
        TG_OP,
        TG_TABLE_NAME,
        COALESCE(NEW.id, OLD.id),
        CASE WHEN TG_OP = 'DELETE' THEN row_to_json(OLD) ELSE NULL END,
        CASE WHEN TG_OP IN ('INSERT', 'UPDATE') THEN row_to_json(NEW) ELSE NULL END,
        NOW()
    );
    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- BUSINESS LOGIC FUNCTIONS
-- ============================================

-- Calculate event budget variance
CREATE OR REPLACE FUNCTION calculate_budget_variance(event_uuid UUID)
RETURNS TABLE (
    category VARCHAR,
    planned_total DECIMAL,
    actual_total DECIMAL,
    variance DECIMAL,
    variance_percentage DECIMAL
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        b.category,
        SUM(b.planned_amount) as planned_total,
        SUM(b.actual_amount) as actual_total,
        SUM(b.actual_amount - b.planned_amount) as variance,
        CASE 
            WHEN SUM(b.planned_amount) > 0 THEN 
                (SUM(b.actual_amount - b.planned_amount) / SUM(b.planned_amount)) * 100
            ELSE 0 
        END as variance_percentage
    FROM budgets b
    WHERE b.event_id = event_uuid
    GROUP BY b.category;
END;
$$ LANGUAGE plpgsql;

-- Update ticket availability after sale
CREATE OR REPLACE FUNCTION update_ticket_availability()
RETURNS TRIGGER AS $$
DECLARE
    total_quantity INTEGER;
BEGIN
    -- Calculate total quantity for this ticket category in the order
    SELECT SUM(quantity) INTO total_quantity
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.id
    WHERE oi.ticket_category_id = NEW.ticket_category_id
    AND o.payment_status = 'paid';
    
    -- Update ticket category sold count
    UPDATE ticket_categories 
    SET quantity_sold = total_quantity
    WHERE id = NEW.ticket_category_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Calculate sponsor lead score
CREATE OR REPLACE FUNCTION calculate_lead_score()
RETURNS TRIGGER AS $$
DECLARE
    score INTEGER := 0;
BEGIN
    -- Company size scoring
    CASE NEW.company_size
        WHEN 'enterprise' THEN score := score + 30;
        WHEN 'large' THEN score := score + 25;
        WHEN 'medium' THEN score := score + 15;
        WHEN 'small' THEN score := score + 10;
        ELSE score := score + 5;
    END CASE;
    
    -- Revenue scoring
    IF NEW.annual_revenue > 100000000 THEN score := score + 25;
    ELSIF NEW.annual_revenue > 10000000 THEN score := score + 20;
    ELSIF NEW.annual_revenue > 1000000 THEN score := score + 15;
    ELSIF NEW.annual_revenue > 100000 THEN score := score + 10;
    END IF;
    
    -- Previous sponsorships
    IF NEW.previous_sponsorships IS NOT NULL AND jsonb_array_length(NEW.previous_sponsorships) > 0 THEN
        score := score + 20;
    END IF;
    
    -- Contact information completeness
    IF NEW.contact_email IS NOT NULL THEN score := score + 10; END IF;
    IF NEW.contact_phone IS NOT NULL THEN score := score + 5; END IF;
    IF NEW.website IS NOT NULL THEN score := score + 5; END IF;
    
    NEW.lead_score := LEAST(score, 100);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Auto-assign tasks based on team member skills
CREATE OR REPLACE FUNCTION auto_assign_tasks()
RETURNS TRIGGER AS $$
DECLARE
    best_user_id UUID;
    user_skills TEXT[];
    task_requirements TEXT[];
BEGIN
    -- Extract task requirements from category or description
    task_requirements := string_to_array(NEW.category, ',');
    
    -- Find team member with best skill match
    SELECT etm.user_id INTO best_user_id
    FROM event_team_members etm
    JOIN users u ON etm.user_id = u.id
    WHERE etm.event_id = NEW.event_id
    AND u.skills && task_requirements
    AND etm.is_active = true
    ORDER BY array_length(u.skills & task_requirements, 1) DESC
    LIMIT 1;
    
    -- If no perfect match, assign to event director
    IF best_user_id IS NULL THEN
        SELECT etm.user_id INTO best_user_id
        FROM event_team_members etm
        JOIN users u ON etm.user_id = u.id
        WHERE etm.event_id = NEW.event_id
        AND u.role = 'event_director'
        LIMIT 1;
    END IF;
    
    NEW.assigned_to := best_user_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Update performance metrics
CREATE OR REPLACE FUNCTION update_performance_metrics()
RETURNS TRIGGER AS $$
BEGIN
    -- Update event-specific metrics
    INSERT INTO performance_metrics (
        organization_id,
        event_id,
        metric_name,
        metric_category,
        metric_value,
        period_start,
        period_end
    ) VALUES (
        NEW.organization_id,
        NEW.event_id,
        CASE TG_TABLE_NAME
            WHEN 'orders' THEN 'total_revenue'
            WHEN 'social_media_posts' THEN 'posts_published'
            WHEN 'sponsorship_deals' THEN 'deals_closed'
            ELSE 'general_activity'
        END,
        'events',
        CASE TG_TABLE_NAME
            WHEN 'orders' THEN NEW.total_amount
            ELSE 1
        END,
        date_trunc('day', NOW()),
        date_trunc('day', NOW()) + interval '1 day'
    )
    ON CONFLICT (organization_id, metric_name, period_start) 
    DO UPDATE SET 
        metric_value = performance_metrics.metric_value + EXCLUDED.metric_value,
        calculated_at = NOW();
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- AUTOMATED WORKFLOWS
-- ============================================

-- Trigger automation workflows
CREATE OR REPLACE FUNCTION trigger_automation_workflows()
RETURNS TRIGGER AS $$
DECLARE
    workflow RECORD;
    execution_id UUID;
BEGIN
    -- Find matching workflows for this trigger
    FOR workflow IN 
        SELECT * FROM automation_workflows 
        WHERE is_active = true 
        AND trigger_type = TG_TABLE_NAME || '_' || lower(TG_OP)
        AND organization_id = NEW.organization_id
    LOOP
        -- Create workflow execution
        INSERT INTO workflow_executions (
            workflow_id,
            event_id,
            trigger_data,
            execution_status
        ) VALUES (
            workflow.id,
            NEW.event_id,
            row_to_json(NEW),
            'running'
        ) RETURNING id INTO execution_id;
        
        -- Queue workflow for execution (would be handled by background job)
        PERFORM pg_notify('workflow_execution', execution_id::text);
    END LOOP;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- TIMESTAMP TRIGGERS
-- ============================================

-- Apply updated_at triggers to all relevant tables
CREATE TRIGGER update_organizations_updated_at BEFORE UPDATE ON organizations
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_events_updated_at BEFORE UPDATE ON events
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_tasks_updated_at BEFORE UPDATE ON tasks
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_budgets_updated_at BEFORE UPDATE ON budgets
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_vendors_updated_at BEFORE UPDATE ON vendors
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_ai_agents_updated_at BEFORE UPDATE ON ai_agents
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_marketing_campaigns_updated_at BEFORE UPDATE ON marketing_campaigns
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_social_media_posts_updated_at BEFORE UPDATE ON social_media_posts
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_sponsor_prospects_updated_at BEFORE UPDATE ON sponsor_prospects
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_sponsorship_deals_updated_at BEFORE UPDATE ON sponsorship_deals
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_ticket_categories_updated_at BEFORE UPDATE ON ticket_categories
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_orders_updated_at BEFORE UPDATE ON orders
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- BUSINESS LOGIC TRIGGERS
-- ============================================

-- Order number generation
CREATE TRIGGER generate_order_number_trigger BEFORE INSERT ON orders
    FOR EACH ROW EXECUTE FUNCTION generate_order_number();

-- Ticket availability updates
CREATE TRIGGER update_ticket_availability_trigger AFTER INSERT OR UPDATE ON order_items
    FOR EACH ROW EXECUTE FUNCTION update_ticket_availability();

-- Lead scoring
CREATE TRIGGER calculate_lead_score_trigger BEFORE INSERT OR UPDATE ON sponsor_prospects
    FOR EACH ROW EXECUTE FUNCTION calculate_lead_score();

-- Task auto-assignment
CREATE TRIGGER auto_assign_tasks_trigger BEFORE INSERT ON tasks
    FOR EACH ROW 
    WHEN (NEW.assigned_to IS NULL)
    EXECUTE FUNCTION auto_assign_tasks();

-- Performance metrics updates
CREATE TRIGGER update_performance_metrics_orders AFTER INSERT ON orders
    FOR EACH ROW EXECUTE FUNCTION update_performance_metrics();

CREATE TRIGGER update_performance_metrics_posts AFTER INSERT ON social_media_posts
    FOR EACH ROW EXECUTE FUNCTION update_performance_metrics();

CREATE TRIGGER update_performance_metrics_deals AFTER INSERT ON sponsorship_deals
    FOR EACH ROW EXECUTE FUNCTION update_performance_metrics();

-- ============================================
-- AUTOMATION TRIGGERS
-- ============================================

-- Workflow automation triggers
CREATE TRIGGER trigger_workflows_events AFTER INSERT OR UPDATE ON events
    FOR EACH ROW EXECUTE FUNCTION trigger_automation_workflows();

CREATE TRIGGER trigger_workflows_orders AFTER INSERT OR UPDATE ON orders
    FOR EACH ROW EXECUTE FUNCTION trigger_automation_workflows();

CREATE TRIGGER trigger_workflows_sponsors AFTER INSERT OR UPDATE ON sponsorship_deals
    FOR EACH ROW EXECUTE FUNCTION trigger_automation_workflows();

-- ============================================
-- AUDIT TRIGGERS
-- ============================================

-- Apply audit triggers to sensitive tables
CREATE TRIGGER audit_events_trigger AFTER INSERT OR UPDATE OR DELETE ON events
    FOR EACH ROW EXECUTE FUNCTION audit_trigger_function();

CREATE TRIGGER audit_orders_trigger AFTER INSERT OR UPDATE OR DELETE ON orders
    FOR EACH ROW EXECUTE FUNCTION audit_trigger_function();

CREATE TRIGGER audit_budgets_trigger AFTER INSERT OR UPDATE OR DELETE ON budgets
    FOR EACH ROW EXECUTE FUNCTION audit_trigger_function();

CREATE TRIGGER audit_sponsorship_deals_trigger AFTER INSERT OR UPDATE OR DELETE ON sponsorship_deals
    FOR EACH ROW EXECUTE FUNCTION audit_trigger_function();

CREATE TRIGGER audit_users_trigger AFTER INSERT OR UPDATE OR DELETE ON users
    FOR EACH ROW EXECUTE FUNCTION audit_trigger_function();

-- ============================================
-- DATA VALIDATION TRIGGERS
-- ============================================

-- Validate event dates
CREATE OR REPLACE FUNCTION validate_event_dates()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.end_date <= NEW.start_date THEN
        RAISE EXCEPTION 'Event end date must be after start date';
    END IF;
    
    IF NEW.registration_deadline IS NOT NULL AND NEW.registration_deadline >= NEW.start_date THEN
        RAISE EXCEPTION 'Registration deadline must be before event start date';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validate_event_dates_trigger BEFORE INSERT OR UPDATE ON events
    FOR EACH ROW EXECUTE FUNCTION validate_event_dates();

-- Validate ticket quantities
CREATE OR REPLACE FUNCTION validate_ticket_quantities()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.quantity_sold > NEW.quantity_total THEN
        RAISE EXCEPTION 'Cannot sell more tickets than total available';
    END IF;
    
    IF NEW.quantity_reserved > NEW.quantity_total THEN
        RAISE EXCEPTION 'Cannot reserve more tickets than total available';
    END IF;
    
    IF (NEW.quantity_sold + NEW.quantity_reserved) > NEW.quantity_total THEN
        RAISE EXCEPTION 'Sold plus reserved tickets cannot exceed total available';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validate_ticket_quantities_trigger BEFORE INSERT OR UPDATE ON ticket_categories
    FOR EACH ROW EXECUTE FUNCTION validate_ticket_quantities();

-- Validate order totals
CREATE OR REPLACE FUNCTION validate_order_totals()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.total_amount != (NEW.subtotal + NEW.fees + NEW.taxes - NEW.discounts) THEN
        RAISE EXCEPTION 'Order total does not match calculated amount';
    END IF;
    
    IF NEW.total_amount < 0 THEN
        RAISE EXCEPTION 'Order total cannot be negative';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validate_order_totals_trigger BEFORE INSERT OR UPDATE ON orders
    FOR EACH ROW EXECUTE FUNCTION validate_order_totals();

-- ============================================
-- NOTIFICATION TRIGGERS
-- ============================================

-- Real-time notifications
CREATE OR REPLACE FUNCTION send_real_time_notifications()
RETURNS TRIGGER AS $$
BEGIN
    -- Send different notifications based on table and operation
    CASE TG_TABLE_NAME
        WHEN 'orders' THEN
            PERFORM pg_notify('new_order', json_build_object(
                'order_id', NEW.id,
                'event_id', NEW.event_id,
                'total_amount', NEW.total_amount,
                'customer_email', NEW.customer_email
            )::text);
        WHEN 'sponsorship_deals' THEN
            PERFORM pg_notify('sponsor_update', json_build_object(
                'deal_id', NEW.id,
                'event_id', NEW.event_id,
                'status', NEW.status,
                'deal_value', NEW.deal_value
            )::text);
        WHEN 'tasks' THEN
            IF NEW.status = 'completed' AND (OLD.status IS NULL OR OLD.status != 'completed') THEN
                PERFORM pg_notify('task_completed', json_build_object(
                    'task_id', NEW.id,
                    'event_id', NEW.event_id,
                    'assigned_to', NEW.assigned_to
                )::text);
            END IF;
    END CASE;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply notification triggers
CREATE TRIGGER notify_new_orders AFTER INSERT ON orders
    FOR EACH ROW EXECUTE FUNCTION send_real_time_notifications();

CREATE TRIGGER notify_sponsor_updates AFTER INSERT OR UPDATE ON sponsorship_deals
    FOR EACH ROW EXECUTE FUNCTION send_real_time_notifications();

CREATE TRIGGER notify_task_updates AFTER UPDATE ON tasks
    FOR EACH ROW EXECUTE FUNCTION send_real_time_notifications();