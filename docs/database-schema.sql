-- Medical Platform Database Schema for Supabase
-- This file contains the SQL schema for the medical platform database

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Blood Banks Table
CREATE TABLE IF NOT EXISTS blood_banks (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address TEXT NOT NULL,
    phone VARCHAR(20) NOT NULL,
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    blood_types_available TEXT[] NOT NULL DEFAULT '{}',
    hours VARCHAR(255),
    website VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Blood Donors Table
CREATE TABLE IF NOT EXISTS donors (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    blood_type VARCHAR(5) NOT NULL CHECK (blood_type IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-')),
    location VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL,
    availability VARCHAR(50) NOT NULL CHECK (availability IN ('weekdays', 'weekends', 'evenings', 'flexible')),
    last_donation DATE,
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'unavailable')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Blood Requests Table
CREATE TABLE IF NOT EXISTS blood_requests (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    blood_type VARCHAR(5) NOT NULL CHECK (blood_type IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-')),
    location VARCHAR(255) NOT NULL,
    urgency VARCHAR(20) NOT NULL CHECK (urgency IN ('low', 'normal', 'high', 'critical')),
    contact_info VARCHAR(255) NOT NULL,
    additional_notes TEXT,
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'fulfilled', 'cancelled')),
    urgency_level VARCHAR(20) DEFAULT 'normal',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Symptom Analysis History Table (for analytics)
CREATE TABLE IF NOT EXISTS symptom_analyses (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    symptoms TEXT NOT NULL,
    age INTEGER,
    gender VARCHAR(20),
    predicted_conditions JSONB,
    confidence_scores JSONB,
    recommendations JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Notifications Log Table
CREATE TABLE IF NOT EXISTS notifications_log (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    type VARCHAR(50) NOT NULL CHECK (type IN ('blood_request', 'donation_reminder', 'general')),
    recipient_type VARCHAR(20) NOT NULL CHECK (recipient_type IN ('donor', 'requester')),
    recipient_id UUID,
    recipient_contact VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'sent' CHECK (status IN ('sent', 'failed', 'pending')),
    sent_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_donors_blood_type ON donors(blood_type);
CREATE INDEX IF NOT EXISTS idx_donors_location ON donors(location);
CREATE INDEX IF NOT EXISTS idx_donors_status ON donors(status);
CREATE INDEX IF NOT EXISTS idx_blood_requests_blood_type ON blood_requests(blood_type);
CREATE INDEX IF NOT EXISTS idx_blood_requests_location ON blood_requests(location);
CREATE INDEX IF NOT EXISTS idx_blood_requests_urgency ON blood_requests(urgency);
CREATE INDEX IF NOT EXISTS idx_blood_requests_status ON blood_requests(status);
CREATE INDEX IF NOT EXISTS idx_blood_banks_location ON blood_banks(latitude, longitude);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
CREATE TRIGGER update_blood_banks_updated_at BEFORE UPDATE ON blood_banks
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_donors_updated_at BEFORE UPDATE ON donors
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_blood_requests_updated_at BEFORE UPDATE ON blood_requests
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Insert sample data
INSERT INTO blood_banks (name, address, phone, latitude, longitude, blood_types_available, hours, website) VALUES
('City Blood Center', '123 Medical Drive, City, State 12345', '(555) 123-4567', 40.7128, -74.0060, 
 ARRAY['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'], 
 'Mon-Fri: 8AM-6PM, Sat: 9AM-4PM', 'https://citybloodcenter.com'),
('Regional Blood Services', '456 Health Street, City, State 12345', '(555) 987-6543', 40.7589, -73.9851,
 ARRAY['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
 'Mon-Fri: 7AM-7PM, Sat-Sun: 8AM-5PM', 'https://regionalblood.org'),
('University Medical Center Blood Bank', '789 University Ave, City, State 12345', '(555) 456-7890', 40.7505, -73.9934,
 ARRAY['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
 '24/7 Emergency Services', 'https://universitymedical.edu/blood-bank');

-- Insert sample donors
INSERT INTO donors (name, blood_type, location, phone, email, availability, last_donation, status) VALUES
('John Smith', 'O+', 'New York, NY', '(555) 111-2222', 'john.smith@email.com', 'weekends', '2024-01-15', 'active'),
('Sarah Johnson', 'A+', 'Brooklyn, NY', '(555) 333-4444', 'sarah.johnson@email.com', 'evenings', '2024-02-01', 'active'),
('Mike Davis', 'B-', 'Queens, NY', '(555) 555-6666', 'mike.davis@email.com', 'weekdays', '2024-01-20', 'active'),
('Emily Wilson', 'AB+', 'Manhattan, NY', '(555) 777-8888', 'emily.wilson@email.com', 'flexible', '2024-01-10', 'active'),
('David Brown', 'O-', 'Bronx, NY', '(555) 999-0000', 'david.brown@email.com', 'weekends', '2024-01-25', 'active');

-- Insert sample blood requests
INSERT INTO blood_requests (blood_type, location, urgency, contact_info, additional_notes, status) VALUES
('O+', 'New York, NY', 'high', '(555) 999-8888', 'Emergency surgery needed', 'active'),
('A-', 'Brooklyn, NY', 'normal', '(555) 777-6666', 'Regular transfusion needed', 'active'),
('B+', 'Queens, NY', 'critical', '(555) 555-4444', 'Accident victim, immediate need', 'active');

-- Create views for analytics
CREATE OR REPLACE VIEW donor_stats AS
SELECT 
    blood_type,
    COUNT(*) as total_donors,
    COUNT(CASE WHEN status = 'active' THEN 1 END) as active_donors,
    COUNT(CASE WHEN last_donation > CURRENT_DATE - INTERVAL '3 months' THEN 1 END) as recent_donors
FROM donors 
GROUP BY blood_type;

CREATE OR REPLACE VIEW blood_request_stats AS
SELECT 
    blood_type,
    urgency,
    COUNT(*) as total_requests,
    COUNT(CASE WHEN status = 'active' THEN 1 END) as active_requests,
    COUNT(CASE WHEN created_at > CURRENT_DATE - INTERVAL '7 days' THEN 1 END) as recent_requests
FROM blood_requests 
GROUP BY blood_type, urgency;

-- Create a function to get nearby blood banks
CREATE OR REPLACE FUNCTION get_nearby_blood_banks(
    user_lat DECIMAL(10, 8),
    user_lng DECIMAL(11, 8),
    radius_km INTEGER DEFAULT 50
)
RETURNS TABLE (
    id UUID,
    name VARCHAR(255),
    address TEXT,
    phone VARCHAR(20),
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    blood_types_available TEXT[],
    hours VARCHAR(255),
    website VARCHAR(255),
    distance_km DECIMAL(10, 2)
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        bb.id,
        bb.name,
        bb.address,
        bb.phone,
        bb.latitude,
        bb.longitude,
        bb.blood_types_available,
        bb.hours,
        bb.website,
        ROUND(
            6371 * acos(
                cos(radians(user_lat)) * 
                cos(radians(bb.latitude)) * 
                cos(radians(bb.longitude) - radians(user_lng)) + 
                sin(radians(user_lat)) * 
                sin(radians(bb.latitude))
            )::DECIMAL, 2
        ) as distance_km
    FROM blood_banks bb
    WHERE 
        6371 * acos(
            cos(radians(user_lat)) * 
            cos(radians(bb.latitude)) * 
            cos(radians(bb.longitude) - radians(user_lng)) + 
            sin(radians(user_lat)) * 
            sin(radians(bb.latitude))
        ) <= radius_km
    ORDER BY distance_km;
END;
$$ LANGUAGE plpgsql;

-- Grant necessary permissions
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO anon, authenticated;
