-- NGO Connect - Sample Organizations (Run this after tables and policies)
-- Copy and paste this in Supabase SQL Editor

-- Insert sample organizations
INSERT INTO public.organizations (id, name, description, logo_url, email, phone, address, categories, verified) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'Green Earth Initiative', 'Environmental conservation and sustainability programs', 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=200', 'contact@greenearth.org', '+1-555-0101', '123 Green St, San Francisco', ARRAY['Environmental', 'Community Support'], true),

('550e8400-e29b-41d4-a716-446655440002', 'Hope Center', 'Community support and social services', 'https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca?w=200', 'info@hopecenter.org', '+1-555-0102', '456 Hope Ave, Los Angeles', ARRAY['Community Support', 'Healthcare'], true),

('550e8400-e29b-41d4-a716-446655440003', 'Animal Rescue Center', 'Animal welfare and rescue operations', 'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=200', 'rescue@animalcenter.org', '+1-555-0103', '789 Pet Lane, Seattle', ARRAY['Animal Welfare'], true),

('550e8400-e29b-41d4-a716-446655440004', 'Education First', 'Educational support and literacy programs', 'https://images.unsplash.com/photo-1427504494785-3a9ca7044f45?w=200', 'learn@educationfirst.org', '+1-555-0104', '321 School Rd, Austin', ARRAY['Education'], true),

('550e8400-e29b-41d4-a716-446655440005', 'Food Security Network', 'Food distribution and hunger relief', 'https://images.unsplash.com/photo-1593113616828-6f22bde97302?w=200', 'help@foodsecurity.org', '+1-555-0105', '654 Food St, Denver', ARRAY['Community Support'], true);