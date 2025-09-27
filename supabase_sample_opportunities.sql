-- NGO Connect - Sample Opportunities (Run this after organizations)
-- Copy and paste this in Supabase SQL Editor

-- Insert sample opportunities
INSERT INTO public.opportunities (id, title, description, organization_id, location, date_time, duration_hours, image_url, type, skills_required, max_participants, is_urgent) VALUES

('660e8400-e29b-41d4-a716-446655440001', 'Tree Plantation Drive', 'Join us in our mission to increase our citys greenery by planting 1,000 trees', '550e8400-e29b-41d4-a716-446655440001', 'Central Park, Downtown', '2025-10-15 09:00:00+00', 5, 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=400', 'volunteer', ARRAY['Environmental Care', 'Physical Work'], 50, false),

('660e8400-e29b-41d4-a716-446655440002', 'Emergency Food Distribution', 'Urgent need for volunteers to help distribute food packages to families', '550e8400-e29b-41d4-a716-446655440005', 'Community Center, East District', '2025-10-05 10:00:00+00', 6, 'https://images.unsplash.com/photo-1593113616828-6f22bde97302?w=400', 'volunteer', ARRAY['Organization', 'Communication'], 30, true),

('660e8400-e29b-41d4-a716-446655440003', 'Animal Shelter Support', 'Help with daily care activities for rescued animals', '550e8400-e29b-41d4-a716-446655440003', 'Animal Rescue Center, West Side', '2025-10-12 08:00:00+00', 4, 'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=400', 'volunteer', ARRAY['Animal Care', 'Cleaning'], 20, false),

('660e8400-e29b-41d4-a716-446655440004', 'Financial Literacy Workshop', 'Help teach financial literacy skills to young adults', '550e8400-e29b-41d4-a716-446655440004', 'Youth Center, North District', '2025-10-20 14:00:00+00', 3, 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400', 'workshop', ARRAY['Teaching', 'Finance'], 15, false),

('660e8400-e29b-41d4-a716-446655440005', 'Community Garden Workshop', 'Learn and teach sustainable farming practices', '550e8400-e29b-41d4-a716-446655440001', 'Downtown Community Center', '2025-10-18 10:00:00+00', 4, 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=400', 'workshop', ARRAY['Gardening', 'Teaching'], 25, false);