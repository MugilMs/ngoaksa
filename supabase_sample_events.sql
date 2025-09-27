-- NGO Connect - Sample Events (Run this after opportunities)
-- Copy and paste this in Supabase SQL Editor

-- Insert sample events
INSERT INTO public.events (id, title, description, date_time, location, max_participants, category, image_url) VALUES

('770e8400-e29b-41d4-a716-446655440001', 'Annual Volunteer Fair', 'Meet various NGOs and learn about volunteer opportunities in your area', '2025-11-01 10:00:00+00', 'City Convention Center', 500, 'Community', 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400'),

('770e8400-e29b-41d4-a716-446655440002', 'Environmental Awareness Workshop', 'Learn about climate change and how you can make a difference', '2025-10-25 14:00:00+00', 'Green Earth Center', 100, 'Environmental', 'https://images.unsplash.com/photo-1542273917363-3b1817f69a2d?w=400'),

('770e8400-e29b-41d4-a716-446655440003', 'Youth Leadership Summit', 'Empowering young leaders to create positive change', '2025-11-15 09:00:00+00', 'University Campus', 200, 'Education', 'https://images.unsplash.com/photo-1427504494785-3a9ca7044f45?w=400');