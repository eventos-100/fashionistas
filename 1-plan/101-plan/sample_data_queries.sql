-- ============================================
-- SAMPLE DATA INSERTION
-- ============================================

-- Sample Organizations
INSERT INTO organizations (id, name, slug, subscription_tier, settings) VALUES
('org1-uuid', 'EventCorp Productions', 'eventcorp', 'enterprise', '{"timezone": "America/New_York", "currency": "USD"}'),
('org2-uuid', 'Miami Events Co', 'miami-events', 'pro', '{"timezone": "America/Miami", "currency": "USD"}'),
('org3-uuid', 'Austin Music Festival', 'austin-music', 'basic', '{"timezone": "America/Chicago", "currency": "USD"}');

-- Sample Users
INSERT INTO users (id, organization_id, email, full_name, role, skills, phone) VALUES
('user1-uuid', 'org1-uuid', 'john@eventcorp.com', 'John Smith', 'event_director', ARRAY['project_management', 'venue_coordination'], '+1-555-0101'),
('user2-uuid', 'org1-uuid', 'sarah@eventcorp.com', 'Sarah Johnson', 'marketing_manager', ARRAY['social_media', 'content_creation', 'paid_advertising'], '+1-555-0102'),
('user3-uuid', 'org1-uuid', 'mike@eventcorp.com', 'Mike Wilson', 'sales_manager', ARRAY['sponsorship_sales', 'client_relations'], '+1-555-0103'),
('user4-uuid', 'org2-uuid', 'maria@miamievents.com', 'Maria Garcia', 'admin', ARRAY['operations', 'vendor_management'], '+1-555-0201'),
('user5-uuid', 'org3-uuid', 'alex@austinmusic.com', 'Alex Thompson', 'producer', ARRAY['audio_production', 'artist_relations'], '+1-555-0301');

-- Sample Event Categories
INSERT INTO event_categories (id, organization_id, name, slug, description, color_code) VALUES
('cat1-uuid', 'org1-uuid', 'Corporate Conferences', 'corporate-conferences', 'Business and professional conferences', '#2563eb'),
('cat2-uuid', 'org1-uuid', 'Product Launches', 'product-launches', 'New product announcement events', '#dc2626'),
('cat3-uuid', 'org2-uuid', 'Music Festivals', 'music-festivals', 'Large-scale music events', '#7c3aed'),
('cat4-uuid', 'org2-uuid', 'Private Parties', 'private-parties', 'Exclusive private celebrations', '#059669'),
('cat5-uuid', 'org3-uuid', 'Live Concerts', 'live-concerts', 'Individual artist performances', '#ea580c');

-- Sample Venues
INSERT INTO venues (id, organization_id, name, address, capacity, venue_type, amenities) VALUES
('venue1-uuid', 'org1-uuid', 'Grand Convention Center', 
 '{"street": "123 Convention Ave", "city": "New York", "state": "NY", "country": "USA", "postal_code": "10001", "coordinates": {"lat": 40.7589, "lng": -73.9851}}',
 5000, 'conference_center', 
 '{"wifi": true, "parking": 500, "catering": true, "av_equipment": true, "wheelchair_accessible": true}'),
('venue2-uuid', 'org2-uuid', 'Miami Beach Resort', 
 '{"street": "456 Ocean Drive", "city": "Miami Beach", "state": "FL", "country": "USA", "postal_code": "33139", "coordinates": {"lat": 25.7617, "lng": -80.1918}}',
 2000, 'outdoor', 
 '{"wifi": true, "parking": 200, "catering": true, "bar_service": true, "ocean_view": true}'),
('venue3-uuid', 'org3-uuid', 'Austin Music Hall', 
 '{"street": "789 Music Row", "city": "Austin", "state": "TX", "country": "USA", "postal_code": "78701", "coordinates": {"lat": 30.2672, "lng": -97.7431}}',
 3500, 'concert_hall', 
 '{"wifi": true, "parking": 300, "professional_sound": true, "green_rooms": 6, "merchandise_area": true}');

-- Sample Events
INSERT INTO events (id, organization_id, category_id, venue_id, name, slug, description, start_date, end_date, max_capacity, created_by) VALUES
('event1-uuid', 'org1-uuid', 'cat1-uuid', 'venue1-uuid', 'Tech Innovation Summit 2024', 'tech-innovation-summit-2024', 
 'Annual conference bringing together tech leaders, innovators, and entrepreneurs to discuss the future of technology.', 
 '2024-09-15 09:00:00+00', '2024-09-17 18:00:00+00', 5000, 'user1-uuid'),
('event2-uuid', 'org2-uuid', 'cat3-uuid', 'venue2-uuid', 'Miami Electronic Music Festival', 'miami-electronic-music-festival', 
 'Three-day electronic music festival featuring world-renowned DJs and producers on Miami Beach.', 
 '2024-07-20 14:00:00+00', '2024-07-22 23:59:00+00', 2000, 'user4-uuid'),
('event3-uuid', 'org3-uuid', 'cat5-uuid', 'venue3-uuid', 'Austin Indie Rock Showcase', 'austin-indie-rock-showcase', 
 'Monthly showcase featuring emerging indie rock bands from the Austin music scene.', 
 '2024-06-28 19:00:00+00', '2024-06-28 23:30:00+00', 3500, 'user5-uuid');

-- Sample Event Team Members
INSERT INTO event_team_members (event_id, user_id, role, responsibilities, access_level, hourly_rate) VALUES
('event1-uuid', 'user1-uuid', 'Event Director', ARRAY['overall_coordination', 'vendor_management', 'timeline_oversight'], 'admin', 150.00),
('event1-uuid', 'user2-uuid', 'Marketing Manager', ARRAY['social_media_campaigns', 'content_creation', 'pr_outreach'], 'write', 85.00),
('event1-uuid', 'user3-uuid', 'Sponsorship Sales', ARRAY['sponsor_outreach', 'package_development', 'contract_negotiation'], 'write', 95.00),
('event2-uuid', 'user4-uuid', 'Event Producer', ARRAY['artist_coordination', 'stage_management', 'logistics'], 'admin', 120.00),
('event3-uuid', 'user5-uuid', 'Music Producer', ARRAY['sound_engineering', 'artist_relations', 'equipment_management'], 'admin', 100.00);

-- Sample Tasks
INSERT INTO tasks (id, event_id, title, description, status, priority, category, assigned_to, due_date, estimated_hours) VALUES
('task1-uuid', 'event1-uuid', 'Finalize Speaker Lineup', 'Confirm all keynote speakers and workshop leaders', 'in_progress', 'high', 'content', 'user1-uuid', '2024-06-30 17:00:00+00', 15.0),
('task2-uuid', 'event1-uuid', 'Design Marketing Materials', 'Create brochures, banners, and digital assets', 'todo', 'medium', 'marketing', 'user2-uuid', '2024-07-15 17:00:00+00', 25.0),
('task3-uuid', 'event1-uuid', 'Secure Gold Sponsors', 'Reach out to target companies for gold sponsorship packages', 'in_progress', 'high', 'sponsorship', 'user3-uuid', '2024-07-01 17:00:00+00', 40.0),
('task4-uuid', 'event2-uuid', 'Book Headlining DJs', 'Negotiate contracts with top 3 DJ performers', 'completed', 'urgent', 'talent', 'user4-uuid', '2024-05-15 17:00:00+00', 30.0),
('task5-uuid', 'event3-uuid', 'Setup Sound Equipment', 'Install and test all audio equipment for the venue', 'todo', 'high', 'technical', 'user5-uuid', '2024-06-27 12:00:00+00', 8.0);

-- Sample Budgets
INSERT INTO budgets (id, event_id, category, subcategory, planned_amount, actual_amount, currency, description, approval_status, created_by) VALUES
('budget1-uuid', 'event1-uuid', 'venue', 'rental', 50000.00, 50000.00, 'USD', 'Grand Convention Center rental for 3 days', 'approved', 'user1-uuid'),
('budget2-uuid', 'event1-uuid', 'marketing', 'digital_advertising', 15000.00, 8500.00, 'USD', 'Google Ads, Facebook Ads, LinkedIn campaigns', 'approved', 'user2-uuid'),
('budget3-uuid', 'event1-uuid', 'catering', 'meals', 25000.00, 0.00, 'USD', 'Breakfast, lunch, and networking reception', 'approved', 'user1-uuid'),
('budget4-uuid', 'event2-uuid', 'talent', 'headliners', 80000.00, 75000.00, 'USD', 'DJ performance fees for main stage acts', 'approved', 'user4-uuid'),
('budget5-uuid', 'event3-uuid', 'equipment', 'sound_system', 5000.00, 4800.00, 'USD', 'Professional sound equipment rental', 'approved', 'user5-uuid');

-- Sample Vendors
INSERT INTO vendors (id, organization_id, name, vendor_type, contact_info, services_offered, pricing_structure, ratings) VALUES
('vendor1-uuid', 'org1-uuid', 'Premier Catering Solutions', 'catering', 
 '{"primary_contact": "Jessica Williams", "email": "jessica@premiercatering.com", "phone": "+1-555-1001", "address": "789 Culinary Ave, New York, NY"}',
 ARRAY['corporate_catering', 'buffet_service', 'plated_dinners', 'cocktail_receptions'],
 '{"per_person_breakfast": 25, "per_person_lunch": 35, "per_person_dinner": 65, "cocktail_hour": 18}',
 '{"quality": 4.8, "reliability": 4.9, "value": 4.2}'),
('vendor2-uuid', 'org1-uuid', 'TechAV Productions', 'av_equipment', 
 '{"primary_contact": "David Chen", "email": "david@techav.com", "phone": "+1-555-1002", "address": "456 Tech Blvd, New York, NY"}',
 ARRAY['projection_systems', 'sound_engineering', 'lighting_design', 'live_streaming'],
 '{"daily_rate_basic": 2500, "daily_rate_premium": 5000, "technician_hourly": 75}',
 '{"quality": 4.7, "reliability": 4.8, "value": 4.4}'),
('vendor3-uuid', 'org2-uuid', 'Miami Sound & Light', 'production', 
 '{"primary_contact": "Carlos Rodriguez", "email": "carlos@miamisound.com", "phone": "+1-555-2001", "address": "123 Music District, Miami, FL"}',
 ARRAY['festival_sound_systems', 'stage_lighting', 'video_walls', 'crowd_barriers'],
 '{"festival_package_small": 15000, "festival_package_large": 35000, "daily_technician": 100}',
 '{"quality": 4.9, "reliability": 4.6, "value": 4.5}');

-- Sample Sponsorship Packages
INSERT INTO sponsorship_packages (id, event_id, package_name, package_tier, price, currency, benefits, max_sponsors) VALUES
('package1-uuid', 'event1-uuid', 'Platinum Presenting Partner', 'platinum', 75000.00, 'USD', 
 '{"logo_placement": ["main_stage_backdrop", "all_marketing_materials", "mobile_app"], "booth_space": "20x20_premium_location", "tickets": 20, "speaking_opportunity": true, "vip_networking": true, "social_media_mentions": 10}', 1),
('package2-uuid', 'event1-uuid', 'Gold Partner', 'gold', 35000.00, 'USD', 
 '{"logo_placement": ["marketing_materials", "mobile_app"], "booth_space": "10x10_standard", "tickets": 10, "networking_access": true, "social_media_mentions": 5}', 3),
('package3-uuid', 'event1-uuid', 'Silver Partner', 'silver', 15000.00, 'USD', 
 '{"logo_placement": ["mobile_app", "website"], "booth_space": "10x10_standard", "tickets": 6, "networking_access": true}', 5),
('package4-uuid', 'event2-uuid', 'Festival Title Sponsor', 'title', 100000.00, 'USD', 
 '{"naming_rights": true, "main_stage_branding": true, "vip_hospitality": 50, "artist_meet_greets": 3, "social_media_campaign": true}', 1),
('package5-uuid', 'event3-uuid', 'Venue Partner', 'venue', 5000.00, 'USD', 
 '{"venue_signage": true, "program_listing": true, "social_media_mention": 2, "tickets": 4}', 2);

-- Sample Sponsor Prospects
INSERT INTO sponsor_prospects (id, organization_id, company_name, industry, company_size, contact_email, contact_person, lead_score, qualification_status, created_by) VALUES
('prospect1-uuid', 'org1-uuid', 'TechGlobal Corp', 'technology', 'enterprise', 'partnerships@techglobal.com', 'Jennifer Martinez', 85, 'hot', 'user3-uuid'),
('prospect2-uuid', 'org1-uuid', 'Innovation Labs Inc', 'technology', 'large', 'marketing@innovationlabs.com', 'Robert Kim', 72, 'qualified', 'user3-uuid'),
('prospect3-uuid', 'org1-uuid', 'StartupAccelerator', 'venture_capital', 'medium', 'events@startupaccel.com', 'Lisa Brown', 68, 'qualified', 'user3-uuid'),
('prospect4-uuid', 'org2-uuid', 'MusicStream Platform', 'entertainment', 'large', 'partnerships@musicstream.com', 'Alex Rivera', 78, 'hot', 'user4-uuid'),
('prospect5-uuid', 'org3-uuid', 'Local Brewery Co', 'food_beverage', 'small', 'marketing@localbrewery.com', 'Sam Johnson', 45, 'cold', 'user5-uuid');

-- Sample Sponsorship Deals
INSERT INTO sponsorship_deals (id, event_id, prospect_id, package_id, deal_value, currency, status, probability, assigned_to, created_by) VALUES
('deal1-uuid', 'event1-uuid', 'prospect1-uuid', 'package1-uuid', 75000.00, 'USD', 'signed', 100, 'user3-uuid', 'user3-uuid'),
('deal2-uuid', 'event1-uuid', 'prospect2-uuid', 'package2-uuid', 35000.00, 'USD', 'contract_sent', 80, 'user3-uuid', 'user3-uuid'),
('deal3-uuid', 'event1-uuid', 'prospect3-uuid', 'package3-uuid', 15000.00, 'USD', 'negotiation', 60, 'user3-uuid', 'user3-uuid'),
('deal4-uuid', 'event2-uuid', 'prospect4-uuid', 'package4-uuid', 100000.00, 'USD', 'proposal', 70, 'user4-uuid', 'user4-uuid'),
('deal5-uuid', 'event3-uuid', 'prospect5-uuid', 'package5-uuid', 5000.00, 'USD', 'proposal', 30, 'user5-uuid', 'user5-uuid');

-- Sample Ticket Categories
INSERT INTO ticket_categories (id, event_id, name, description, price, currency, quantity_total, quantity_sold, sale_start_date, sale_end_date) VALUES
('ticket1-uuid', 'event1-uuid', 'Early Bird General Admission', 'Full 3-day conference access with early bird pricing', 299.00, 'USD', 2000, 1847, '2024-03-01 00:00:00+00', '2024-05-31 23:59:00+00'),
('ticket2-uuid', 'event1-uuid', 'VIP All-Access Pass', 'Premium experience with networking events and priority seating', 599.00, 'USD', 500, 387, '2024-03-01 00:00:00+00', '2024-09-14 23:59:00+00'),
('ticket3-uuid', 'event1-uuid', 'Student Discount', 'Discounted rate for students with valid ID', 149.00, 'USD', 300, 256, '2024-04-01 00:00:00+00', '2024-09-14 23:59:00+00'),
('ticket4-uuid', 'event2-uuid', 'Single Day Pass', 'Access to one day of the festival', 125.00, 'USD', 500, 423, '2024-04-15 00:00:00+00', '2024-07-20 12:00:00+00'),
('ticket5-uuid', 'event2-uuid', '3-Day Festival Pass', 'Full festival access for all three days', 299.00, 'USD', 1500, 1289, '2024-04-15 00:00:00+00', '2024-07-20 12:00:00+00');

-- Sample Orders
INSERT INTO orders (id, event_id, order_number, customer_email, customer_name, customer_phone, subtotal, fees, taxes, total_amount, currency, payment_status, order_status) VALUES
('order1-uuid', 'event1-uuid', 'ORD-20240615-001234', 'john.doe@email.com', 'John Doe', '+1-555-9001', 1198.00, 59.90, 95.84, 1353.74, 'USD', 'paid', 'confirmed'),
('order2-uuid', 'event1-uuid', 'ORD-20240615-001235', 'sarah.connor@email.com', 'Sarah Connor', '+1-555-9002', 599.00, 29.95, 47.92, 676.87, 'USD', 'paid', 'confirmed'),
('order3-uuid', 'event2-uuid', 'ORD-20240620-001236', 'mike.party@email.com', 'Mike Party', '+1-555-9003', 598.00, 29.90, 47.84, 675.74, 'USD', 'paid', 'confirmed'),
('order4-uuid', 'event2-uuid', 'ORD-20240620-001237', 'festival.crew@email.com', 'Festival Crew', '+1-555-9004', 375.00, 18.75, 30.00, 423.75, 'USD', 'processing', 'pending'),
('order5-uuid', 'event3-uuid', 'ORD-20240625-001238', 'music.lover@email.com', 'Music Lover', '+1-555-9005', 50.00, 2.50, 4.00, 56.50, 'USD', 'paid', 'confirmed');

-- Sample Order Items
INSERT INTO order_items (id, order_id, ticket_category_id, quantity, unit_price, total_price, attendee_info) VALUES
('item1-uuid', 'order1-uuid', 'ticket1-uuid', 2, 299.00, 598.00, '[{"name":"John Doe","email":"john.doe@email.com"},{"name":"Jane Doe","email":"jane.doe@email.com"}]'),
('item2-uuid', 'order1-uuid', 'ticket2-uuid', 1, 599.00, 599.00, '[{"name":"John Doe","email":"john.doe@email.com"}]'),
('item3-uuid', 'order2-uuid', 'ticket2-uuid', 1, 599.00, 599.00, '[{"name":"Sarah Connor","email":"sarah.connor@email.com"}]'),
('item4-uuid', 'order3-uuid', 'ticket5-uuid', 2, 299.00, 598.00, '[{"name":"Mike Party","email":"mike.party@email.com"},{"name":"Lisa Party","email":"lisa.party@email.com"}]'),
('item5-uuid', 'order4-uuid', 'ticket4-uuid', 3, 125.00, 375.00, '[{"name":"Festival Crew","email":"festival.crew@email.com"},{"name":"Crew Member 2","email":"crew2@email.com"},{"name":"Crew Member 3","email":"crew3@email.com"}]');

-- ============================================
-- COMMON QUERIES FOR EVENT MANAGEMENT
-- ============================================

-- 1. Event Dashboard Overview
-- Get comprehensive event information with key metrics
SELECT 
    e.id,
    e.name,
    e.start_date,
    e.end_date,
    e.status,
    v.name as venue_name,
    v.capacity as venue_capacity,
    
    -- Team information
    COUNT(DISTINCT etm.user_id) as team_members_count,
    
    -- Task progress
    COUNT(DISTINCT t.id) as total_tasks,
    COUNT(DISTINCT CASE WHEN t.status = 'completed' THEN t.id END) as completed_tasks,
    ROUND(
        (COUNT(DISTINCT CASE WHEN t.status = 'completed' THEN t.id END)::FLOAT / 
         NULLIF(COUNT(DISTINCT t.id), 0)) * 100, 1
    ) as task_completion_percentage,
    
    -- Budget information
    SUM(b.planned_amount) as total_planned_budget,
    SUM(b.actual_amount) as total_actual_spend,
    SUM(b.planned_amount) - SUM(b.actual_amount) as budget_remaining,
    
    -- Ticket sales
    SUM(tc.quantity_total) as total_ticket_capacity,
    SUM(tc.quantity_sold) as total_tickets_sold,
    ROUND(
        (SUM(tc.quantity_sold)::FLOAT / NULLIF(SUM(tc.quantity_total), 0)) * 100, 1
    ) as tickets_sold_percentage,
    
    -- Revenue
    SUM(CASE WHEN o.order_status = 'confirmed' THEN o.total_amount ELSE 0 END) as total_revenue,
    
    -- Sponsorship
    COUNT(DISTINCT sd.id) as total_sponsor_deals,
    COUNT(DISTINCT CASE WHEN sd.status = 'signed' THEN sd.id END) as signed_sponsor_deals,
    SUM(CASE WHEN sd.status = 'signed' THEN sd.deal_value ELSE 0 END) as confirmed_sponsorship_revenue

FROM events e
LEFT JOIN venues v ON e.venue_id = v.id
LEFT JOIN event_team_members etm ON e.id = etm.event_id AND etm.is_active = true
LEFT JOIN tasks t ON e.id = t.event_id
LEFT JOIN budgets b ON e.id = b.event_id
LEFT JOIN ticket_categories tc ON e.id = tc.event_id
LEFT JOIN orders o ON e.id = o.event_id
LEFT JOIN sponsorship_deals sd ON e.id = sd.event_id
WHERE e.organization_id = 'org1-uuid' -- Replace with actual org ID
GROUP BY e.id, e.name, e.start_date, e.end_date, e.status, v.name, v.capacity
ORDER BY e.start_date;

-- 2. Sponsorship Pipeline Analysis
-- Track sponsorship sales progress and revenue forecasting
SELECT 
    e.name as event_name,
    sp.package_name,
    sp.price as package_price,
    sp.max_sponsors,
    COUNT(sd.id) as total_deals,
    COUNT(CASE WHEN sd.status = 'signed' THEN 1 END) as signed_deals,
    COUNT(CASE WHEN sd.status IN ('proposal', 'negotiation', 'contract_sent') THEN 1 END) as active_deals,
    SUM(CASE WHEN sd.status = 'signed' THEN sd.deal_value ELSE 0 END) as confirmed_revenue,
    SUM(CASE WHEN sd.status IN ('proposal', 'negotiation', 'contract_sent') 
        THEN sd.deal_value * (sd.probability / 100.0) ELSE 0 END) as forecasted_revenue,
    ROUND(AVG(CASE WHEN sd.status IN ('proposal', 'negotiation', 'contract_sent') 
        THEN sd.probability END), 1) as avg_deal_probability
FROM events e
JOIN sponsorship_packages sp ON e.id = sp.event_id
LEFT JOIN sponsorship_deals sd ON sp.id = sd.package_id
WHERE e.organization_id = 'org1-uuid'
GROUP BY e.id, e.name, sp.id, sp.package_name, sp.price, sp.max_sponsors
ORDER BY e.start_date, sp.price DESC;

-- 3. Ticket Sales Performance Analysis
-- Monitor ticket sales across different categories and identify trends
SELECT 
    e.name as event_name,
    tc.name as ticket_category,
    tc.price,
    tc.quantity_total,
    tc.quantity_sold,
    tc.quantity_total - tc.quantity_sold as remaining_tickets,
    ROUND((tc.quantity_sold::FLOAT / tc.quantity_total) * 100, 1) as sell_through_rate,
    COUNT(DISTINCT o.id) as total_orders,
    COUNT(DISTINCT oi.id) as total_line_items,
    SUM(oi.total_price) as category_revenue,
    AVG(oi.total_price) as avg_order_value,
    
    -- Daily sales velocity (tickets sold per day since sales started)
    CASE 
        WHEN tc.sale_start_date IS NOT NULL THEN 
            ROUND(tc.quantity_sold::FLOAT / 
                GREATEST(EXTRACT(days FROM (NOW() - tc.sale_start_date)), 1), 2)
        ELSE 0 
    END as daily_sales_velocity
    
FROM events e
JOIN ticket_categories tc ON e.id = tc.event_id
LEFT JOIN order_items oi ON tc.id = oi.ticket_category_id
LEFT JOIN orders o ON oi.order_id = o.id AND o.order_status = 'confirmed'
WHERE e.organization_id = 'org1-uuid'
GROUP BY e.id, e.name, tc.id, tc.name, tc.price, tc.quantity_total, tc.quantity_sold, tc.sale_start_date
ORDER BY e.start_date, tc.price DESC;

-- 4. Team Productivity and Workload Analysis
-- Track team member performance and workload distribution
SELECT 
    u.full_name,
    u.role,
    e.name as event_name,
    etm.role as event_role,
    etm.hourly_rate,
    COUNT(t.id) as assigned_tasks,
    COUNT(CASE WHEN t.status = 'completed' THEN 1 END) as completed_tasks,
    COUNT(CASE WHEN t.status = 'in_progress' THEN 1 END) as active_tasks,
    COUNT(CASE WHEN t.due_date < NOW() AND t.status != 'completed' THEN 1 END) as overdue_tasks,
    SUM(t.estimated_hours) as estimated_hours,
    SUM(t.actual_hours) as actual_hours,
    CASE WHEN SUM(t.estimated_hours) > 0 THEN
        ROUND((SUM(t.actual_hours) / SUM(t.estimated_hours)) * 100, 1)
    ELSE 0 END as time_accuracy_percentage,
    
    -- Productivity score based on completion rate and time accuracy
    ROUND(
        (COUNT(CASE WHEN t.status = 'completed' THEN 1 END)::FLOAT / NULLIF(COUNT(t.id), 0)) * 50 +
        CASE WHEN SUM(t.estimated_hours) > 0 THEN
            LEAST((SUM(t.estimated_hours) / NULLIF(SUM(t.actual_hours), 0)) * 50, 50)
        ELSE 0 END, 1
    ) as productivity_score

FROM users u
JOIN event_team_members etm ON u.id = etm.user_id
JOIN events e ON etm.event_id = e.id
LEFT JOIN tasks t ON e.id = t.event_id AND t.assigned_to = u.id
WHERE u.organization_id = 'org1-uuid'
AND etm.is_active = true
GROUP BY u.id, u.full_name, u.role, e.id, e.name, etm.role, etm.hourly_rate
ORDER BY productivity_score DESC;

-- 5. Budget Variance and Financial Health
-- Monitor budget performance across categories and events
SELECT 
    e.name as event_name,
    b.category,
    b.subcategory,
    COUNT(b.id) as budget_line_items,
    SUM(b.planned_amount) as planned_amount,
    SUM(b.actual_amount) as actual_amount,
    SUM(b.planned_amount) - SUM(b.actual_amount) as variance_amount,
    CASE WHEN SUM(b.planned_amount) > 0 THEN
        ROUND(((SUM(b.actual_amount) - SUM(b.planned_amount)) / SUM(b.planned_amount)) * 100, 2)
    ELSE 0 END as variance_percentage,
    
    -- Budget utilization rate
    CASE WHEN SUM(b.planned_amount) > 0 THEN
        ROUND((SUM(b.actual_amount) / SUM(b.planned_amount)) * 100, 1)
    ELSE 0 END as utilization_rate,
    
    -- Approval status breakdown
    COUNT(CASE WHEN b.approval_status = 'approved' THEN 1 END) as approved_items,
    COUNT(CASE WHEN b.approval_status = 'pending' THEN 1 END) as pending_items,
    
    -- Risk assessment
    CASE 
        WHEN SUM(b.actual_amount) > SUM(b.planned_amount) * 1.1 THEN 'Over Budget'
        WHEN SUM(b.actual_amount) > SUM(b.planned_amount) * 1.05 THEN 'At Risk'
        WHEN SUM(b.actual_amount) < SUM(b.planned_amount) * 0.8 THEN 'Under Utilized'
        ELSE 'On Track'
    END as budget_status

FROM events e
JOIN budgets b ON e.id = b.event_id
WHERE e.organization_id = 'org1-uuid'
GROUP BY e.id, e.name, b.category, b.subcategory
ORDER BY e.start_date, variance_percentage DESC;

-- 6. Customer Segmentation and Behavior Analysis
-- Analyze customer purchasing patterns and preferences
WITH customer_metrics AS (
    SELECT 
        o.customer_email,
        o.customer_name,
        COUNT(DISTINCT o.id) as total_orders,
        COUNT(DISTINCT o.event_id) as events_attended,
        SUM(o.total_amount) as total_spent,
        AVG(o.total_amount) as avg_order_value,
        MIN(o.created_at) as first_purchase_date,
        MAX(o.created_at) as last_purchase_date,
        SUM(oi.quantity) as total_tickets_purchased,
        
        -- Customer lifetime value calculation
        CASE 
            WHEN COUNT(DISTINCT o.id) = 1 THEN 'New Customer'
            WHEN COUNT(DISTINCT o.id) BETWEEN 2 AND 5 THEN 'Regular Customer'
            WHEN COUNT(DISTINCT o.id) > 5 THEN 'VIP Customer'
        END as customer_segment,
        
        -- Recency analysis
        EXTRACT(days FROM (NOW() - MAX(o.created_at))) as days_since_last_purchase
        
    FROM orders o
    JOIN order_items oi ON o.id = oi.order_id
    JOIN events e ON o.event_id = e.id
    WHERE e.organization_id = 'org1-uuid'
    AND o.order_status = 'confirmed'
    GROUP BY o.customer_email, o.customer_name
)
SELECT 
    customer_segment,
    COUNT(*) as customer_count,
    AVG(total_orders) as avg_orders_per_customer,
    AVG(total_spent) as avg_total_spent,
    AVG(avg_order_value) as avg_order_value,
    SUM(total_spent) as segment_total_revenue,
    AVG(days_since_last_purchase) as avg_days_since_last_purchase,
    
    -- Revenue contribution
    ROUND((SUM(total_spent) / (SELECT SUM(total_spent) FROM customer_metrics)) * 100, 1) as revenue_contribution_percentage

FROM customer_metrics
GROUP BY customer_segment
ORDER BY avg_total_spent DESC;

-- 7. Real-time Event Status Dashboard
-- Current status across all active events
SELECT 
    e.name as event_name,
    e.start_date,
    e.status,
    EXTRACT(days FROM (e.start_date - NOW())) as days_until_event,
    
    -- Progress indicators
    ROUND(
        (COUNT(CASE WHEN t.status = 'completed' THEN 1 END)::FLOAT / NULLIF(COUNT(t.id), 0)) * 100, 1
    ) as task_completion_rate,
    
    -- Ticket sales progress
    ROUND(
        (SUM(tc.quantity_sold)::FLOAT / NULLIF(SUM(tc.quantity_total), 0)) * 100, 1
    ) as ticket_sales_rate,
    
    -- Revenue metrics
    SUM(CASE WHEN o.order_status = 'confirmed' THEN o.total_amount ELSE 0 END) as confirmed_revenue,
    SUM(CASE WHEN sd.status = 'signed' THEN sd.deal_value ELSE 0 END) as sponsorship_revenue,
    
    -- Risk indicators
    COUNT(CASE WHEN t.due_date < NOW() AND t.status != 'completed' THEN 1 END) as overdue_tasks,
    COUNT(CASE WHEN t.priority = 'urgent' AND t.status != 'completed' THEN 1 END) as urgent_open_tasks,
    
    -- Team readiness
    COUNT(DISTINCT etm.user_id) as team_size,
    
    -- Overall health score
    CASE 
        WHEN EXTRACT(days FROM (e.start_date - NOW())) < 7 
             AND (COUNT(CASE WHEN t.status = 'completed' THEN 1 END)::FLOAT / NULLIF(COUNT(t.id), 0)) < 0.8 
        THEN 'At Risk'
        WHEN COUNT(CASE WHEN t.due_date < NOW() AND t.status != 'completed' THEN 1 END) > 5 
        THEN 'Behind Schedule'
        WHEN (SUM(tc.quantity_sold)::FLOAT / NULLIF(SUM(tc.quantity_total), 0)) < 0.3 
             AND EXTRACT(days FROM (e.start_date - NOW())) < 30 
        THEN 'Low Sales'
        ELSE 'On Track'
    END as health_status

FROM events e
LEFT JOIN tasks t ON e.id = t.event_id
LEFT JOIN ticket_categories tc ON e.id = tc.event_id
LEFT JOIN orders o ON e.id = o.event_id
LEFT JOIN sponsorship_deals sd ON e.id = sd.event_id
LEFT JOIN event_team_members etm ON e.id = etm.event_id AND etm.is_active = true
WHERE e.organization_id = 'org1-uuid'
AND e.status IN ('planning', 'confirmed')
AND e.start_date > NOW()
GROUP BY e.id, e.name, e.start_date, e.status
ORDER BY e.start_date;

-- ============================================
-- ANALYTICS AND REPORTING QUERIES
-- ============================================

-- 8. Monthly Performance Summary
-- Get organization-wide performance metrics by month
SELECT 
    DATE_TRUNC('month', e.start_date) as event_month,
    COUNT(DISTINCT e.id) as events_count,
    COUNT(DISTINCT o.customer_email) as unique_customers,
    SUM(CASE WHEN o.order_status = 'confirmed' THEN o.total_amount ELSE 0 END) as ticket_revenue,
    SUM(CASE WHEN sd.status = 'signed' THEN sd.deal_value ELSE 0 END) as sponsorship_revenue,
    SUM(tc.quantity_sold) as total_tickets_sold,
    AVG(tc.quantity_sold::FLOAT / NULLIF(tc.quantity_total, 0)) as avg_sell_through_rate,
    COUNT(DISTINCT sd.prospect_id) as unique_sponsors,
    AVG(o.total_amount) as avg_ticket_order_value
FROM events e
LEFT JOIN orders o ON e.id = o.event_id AND o.order_status = 'confirmed'
LEFT JOIN ticket_categories tc ON e.id = tc.event_id
LEFT JOIN sponsorship_deals sd ON e.id = sd.event_id AND sd.status = 'signed'
WHERE e.organization_id = 'org1-uuid'
AND e.start_date >= DATE_TRUNC('year', NOW())
GROUP BY DATE_TRUNC('month', e.start_date)
ORDER BY event_month;

-- 9. Vendor Performance Evaluation
-- Assess vendor relationships and performance
SELECT 
    v.name as vendor_name,
    v.vendor_type,
    COUNT(DISTINCT vc.id) as total_contracts,
    COUNT(DISTINCT vc.event_id) as events_served,
    SUM(vc.total_amount) as total_contract_value,
    AVG(vc.total_amount) as avg_contract_value,
    v.ratings->>'quality' as quality_rating,
    v.ratings->>'reliability' as reliability_rating,
    v.ratings->>'value' as value_rating,
    
    -- Performance metrics
    COUNT(CASE WHEN vc.status = 'completed' THEN 1 END)::FLOAT / 
    NULLIF(COUNT(CASE WHEN vc.status IN ('signed', 'completed') THEN 1 END), 0) as completion_rate,
    
    -- Preferred vendor status
    v.preferred_vendor,
    
    -- Latest contract date
    MAX(vc.created_at) as last_contract_date

FROM vendors v
LEFT JOIN vendor_contracts vc ON v.id = vc.vendor_id
WHERE v.organization_id = 'org1-uuid'
AND v.is_active = true
GROUP BY v.id, v.name, v.vendor_type, v.ratings, v.preferred_vendor
ORDER BY total_contract_value DESC;