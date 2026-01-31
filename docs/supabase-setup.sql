-- ============================================
-- SENGA SYSTEMS - SUPABASE DATABASE SETUP
-- ============================================
-- Run these queries in your Supabase SQL Editor:
-- 1. Go to: https://supabase.com/dashboard
-- 2. Select your project
-- 3. Click "SQL Editor" in the left sidebar
-- 4. Click "New Query"
-- 5. Paste and run each section below

-- ============================================
-- SECTION 1: CREATE CONSULTATIONS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS consultations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    user_email VARCHAR(255),
    topic VARCHAR(100) NOT NULL,
    preferred_date DATE NOT NULL,
    preferred_time TIME NOT NULL,
    notes TEXT,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'scheduled', 'completed', 'cancelled')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for faster queries
CREATE INDEX IF NOT EXISTS idx_consultations_user_id ON consultations(user_id);
CREATE INDEX IF NOT EXISTS idx_consultations_status ON consultations(status);
CREATE INDEX IF NOT EXISTS idx_consultations_date ON consultations(preferred_date);

-- ============================================
-- SECTION 2: ENABLE ROW LEVEL SECURITY
-- ============================================
ALTER TABLE consultations ENABLE ROW LEVEL SECURITY;

-- Policy: Users can insert their own consultations
CREATE POLICY "Users can insert own consultations" 
ON consultations FOR INSERT 
WITH CHECK (auth.uid() = user_id);

-- Policy: Users can view their own consultations
CREATE POLICY "Users can view own consultations" 
ON consultations FOR SELECT 
USING (auth.uid() = user_id);

-- Policy: Users can update their own consultations
CREATE POLICY "Users can update own consultations" 
ON consultations FOR UPDATE 
USING (auth.uid() = user_id);

-- Policy: Users can delete their own consultations
CREATE POLICY "Users can delete own consultations" 
ON consultations FOR DELETE 
USING (auth.uid() = user_id);

-- ============================================
-- SECTION 3: AUTO-UPDATE TIMESTAMP TRIGGER
-- ============================================
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_consultations_updated_at 
    BEFORE UPDATE ON consultations 
    FOR EACH ROW 
    EXECUTE PROCEDURE update_updated_at_column();

-- ============================================
-- SECTION 4: ADMIN ACCESS (Optional)
-- Run this if you want admins to view all consultations
-- ============================================
-- First, you need to add an 'is_admin' column to your profiles table
-- or check against specific admin email addresses

-- CREATE POLICY "Admins can view all consultations"
-- ON consultations FOR SELECT
-- USING (
--     auth.jwt()->>'email' IN ('admin@sengasystems.com', 'gomezgani60@gmail.com')
-- );

-- ============================================
-- VERIFICATION: Check table was created
-- ============================================
-- SELECT * FROM consultations LIMIT 5;

-- ============================================
-- OPTIONAL: Insert test data
-- ============================================
-- INSERT INTO consultations (user_id, user_email, topic, preferred_date, preferred_time, notes)
-- VALUES (
--     auth.uid(),
--     'test@example.com',
--     'security-audit',
--     '2025-01-15',
--     '10:00',
--     'Test consultation request'
-- );
