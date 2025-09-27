-- Sample data for NGO Connect app
-- Run this AFTER creating the tables and AFTER you have some users registered

-- Sample Organizations
INSERT INTO public.organizations (id, name, description, logo_url, email, phone, address, city, categories, verified) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'Green Earth Initiative', 'Environmental conservation and sustainability programs', 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=200', 'contact@greenearth.org', '+1-555-0101', '123 Green St', 'San Francisco', ARRAY['Environmental', 'Community Support'], true),
('550e8400-e29b-41d4-a716-446655440002', 'Hope Center', 'Community support and social services', 'https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca?w=200', 'info@hopecenter.org', '+1-555-0102', '456 Hope Ave', 'Los Angeles', ARRAY['Community Support', 'Healthcare'], true),
('550e8400-e29b-41d4-a716-446655440003', 'Animal Rescue Center', 'Animal welfare and rescue operations', 'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=200', 'rescue@animalcenter.org', '+1-555-0103', '789 Pet Lane', 'Seattle', ARRAY['Animal Welfare'], true),
('550e8400-e29b-41d4-a716-446655440004', 'Education First', 'Educational support and literacy programs', 'https://images.unsplash.com/photo-1427504494785-3a9ca7044f45?w=200', 'learn@educationfirst.org', '+1-555-0104', '321 School Rd', 'Austin', ARRAY['Education'], true),
('550e8400-e29b-41d4-a716-446655440005', 'Food Security Network', 'Food distribution and hunger relief', 'https://images.unsplash.com/photo-1593113616828-6f22bde97302?w=200', 'help@foodsecurity.org', '+1-555-0105', '654 Food St', 'Denver', ARRAY['Community Support'], true);

-- Sample Opportunities
INSERT INTO public.opportunities (id, title, description, organization_id, location, date_time, duration_hours, image_url, type, skills_required, max_participants, is_urgent) VALUES
('660e8400-e29b-41d4-a716-446655440001', 'Tree Plantation Drive', 'Join us in our mission to increase our citys greenery by planting 1,000 trees', '550e8400-e29b-41d4-a716-446655440001', 'Central Park, Downtown', '2025-10-15 09:00:00+00', 5, 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=400', 'volunteer', ARRAY['Environmental Care', 'Physical Work'], 50, false),
('660e8400-e29b-41d4-a716-446655440002', 'Emergency Food Distribution', 'Urgent need for volunteers to help distribute food packages to families affected by recent floods', '550e8400-e29b-41d4-a716-446655440005', 'Community Center, East District', '2025-10-05 10:00:00+00', 6, 'https://images.unsplash.com/photo-1593113616828-6f22bde97302?w=400', 'volunteer', ARRAY['Organization', 'Communication'], 30, true),
('660e8400-e29b-41d4-a716-446655440003', 'Animal Shelter Support', 'Help with daily care activities for rescued animals including feeding, cleaning, and socialization', '550e8400-e29b-41d4-a716-446655440003', 'Animal Rescue Center, West Side', '2025-10-12 08:00:00+00', 4, 'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=400', 'volunteer', ARRAY['Animal Care', 'Cleaning', 'Patience'], 20, false),
('660e8400-e29b-41d4-a716-446655440004', 'Financial Literacy Workshop', 'Help teach financial literacy skills to young adults in our community', '550e8400-e29b-41d4-a716-446655440004', 'Youth Center, North District', '2025-10-20 14:00:00+00', 3, 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400', 'workshop', ARRAY['Teaching', 'Finance', 'Communication'], 15, false),
('660e8400-e29b-41d4-a716-446655440005', 'Community Garden Workshop', 'Learn and teach sustainable farming practices to local residents', '550e8400-e29b-41d4-a716-446655440001', 'Downtown Community Center', '2025-10-18 10:00:00+00', 4, 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=400', 'workshop', ARRAY['Gardening', 'Teaching', 'Sustainability'], 25, false);

-- Sample Events (Admin created)
INSERT INTO public.events (id, title, description, date_time, location, max_participants, category, image_url) VALUES
('770e8400-e29b-41d4-a716-446655440001', 'Annual Volunteer Fair', 'Meet various NGOs and learn about volunteer opportunities in your area', '2025-11-01 10:00:00+00', 'City Convention Center', 500, 'Community', 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400'),
('770e8400-e29b-41d4-a716-446655440002', 'Environmental Awareness Workshop', 'Learn about climate change and how you can make a difference', '2025-10-25 14:00:00+00', 'Green Earth Center', 100, 'Environmental', 'https://images.unsplash.com/photo-1542273917363-3b1817f69a2d?w=400'),
('770e8400-e29b-41d4-a716-446655440003', 'Youth Leadership Summit', 'Empowering young leaders to create positive change in their communities', '2025-11-15 09:00:00+00', 'University Campus', 200, 'Education', 'https://images.unsplash.com/photo-1427504494785-3a9ca7044f45?w=400');

-- Note: To add sample conversations and messages, you'll need actual user IDs from your auth.users table
-- You can run these queries after users register in your app:

-- Example conversation insert (replace user_id with actual user ID)
-- INSERT INTO public.conversations (user_id, organization_id, last_message, last_message_at) VALUES
-- ('your-user-id-here', '550e8400-e29b-41d4-a716-446655440001', 'Thank you for your interest in our tree plantation drive!', NOW());

-- Example message insert (replace conversation_id and sender_id with actual IDs)
-- INSERT INTO public.messages (conversation_id, sender_id, content) VALUES
-- ('conversation-id-here', 'sender-id-here', 'Hi! I am interested in volunteering for the tree plantation drive.');

-- Sample skills that users can have
INSERT INTO public.user_skills (user_id, skill_name, proficiency_level) VALUES
-- Replace 'user-id-here' with actual user IDs after registration
-- ('user-id-here', 'Environmental Care', 'intermediate'),
-- ('user-id-here', 'Teaching', 'advanced'),
-- ('user-id-here', 'Animal Care', 'beginner');

-- You can add more sample data as needed for testing