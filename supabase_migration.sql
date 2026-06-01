-- ============================================================
-- WOLF V1 — SUPABASE MIGRATION FILE
-- Algorithm Inc. — Deployment Monitor
-- Date: June 2026
-- ============================================================

-- ── TABLE ALTERATIONS ─────────────────────────────────────

-- Add assigned_manager to deployments
ALTER TABLE deployments ADD COLUMN IF NOT EXISTS assigned_manager TEXT;

-- Add columns to static_clients
ALTER TABLE static_clients ADD COLUMN IF NOT EXISTS assigned_manager TEXT;
ALTER TABLE static_clients ADD COLUMN IF NOT EXISTS client_type TEXT DEFAULT 'Pharmacy';

-- Add columns to client_overrides
ALTER TABLE client_overrides ADD COLUMN IF NOT EXISTS assigned_manager TEXT;
ALTER TABLE client_overrides ADD COLUMN IF NOT EXISTS client_type TEXT DEFAULT 'Pharmacy';
ALTER TABLE client_overrides ADD COLUMN IF NOT EXISTS sector TEXT;
ALTER TABLE client_overrides ADD COLUMN IF NOT EXISTS location TEXT;

-- Add columns to clients (dynamic)
ALTER TABLE clients ADD COLUMN IF NOT EXISTS location TEXT;
ALTER TABLE clients ADD COLUMN IF NOT EXISTS sector TEXT DEFAULT 'OTHER';
ALTER TABLE clients ADD COLUMN IF NOT EXISTS active BOOLEAN DEFAULT true;

-- Add type to manager_bonuses
ALTER TABLE manager_bonuses ADD COLUMN IF NOT EXISTS type TEXT DEFAULT 'manager';
UPDATE manager_bonuses SET type = 'manager' WHERE type IS NULL;

-- Add base_salary to users
ALTER TABLE users ADD COLUMN IF NOT EXISTS base_salary INTEGER DEFAULT 500000;
UPDATE users SET base_salary = 500000 WHERE role = 'manager' AND (base_salary IS NULL OR base_salary = 0);

-- ── SYSTEM ROWS ────────────────────────────────────────────

INSERT INTO users (name, pin, role, active) VALUES
('__statuses__', '["Pending","Email Sent","Convincing","Done","Refused","Rescheduled"]', 'system', true),
('__payments__', '{}', 'system', true),
('__basic_salary__', '[]', 'system', true),
('__manager_base__', '500000', 'system', true),
('__manager_titles__', '{}', 'system', true),
('__access_control__', '{}', 'system', true),
('__mgr_performance__', '{}', 'system', true),
('__date_edit_window__', '{}', 'system', true)
ON CONFLICT (name) DO NOTHING;

-- ── VERIFY ─────────────────────────────────────────────────

-- Run this to verify everything is correct:
SELECT name, role, active FROM users WHERE name LIKE '__%' ORDER BY name;
SELECT COUNT(*) as static_clients FROM static_clients;
SELECT COUNT(*) as dynamic_clients FROM clients;
SELECT COUNT(*) as deployments FROM deployments;
SELECT COUNT(*) as team_assignments FROM team_assignments;
SELECT COUNT(*) as manager_bonuses FROM manager_bonuses;

