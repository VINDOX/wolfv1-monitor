-- ============================================================
-- ISHYIGA WOLF V1 — Deployment Monitor
-- Database Setup SQL
-- Algorithm Inc. | May 2026
-- ============================================================

-- ── USERS TABLE ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL,
  pin TEXT,
  role TEXT DEFAULT 'support',  -- 'coordinator' | 'manager' | 'support' | 'system'
  active BOOLEAN DEFAULT true,
  base_salary INTEGER DEFAULT 500000,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
GRANT ALL ON users TO anon;
GRANT USAGE ON SEQUENCE users_id_seq TO anon;

-- ── STATIC CLIENTS TABLE (333 original clients from Excel) ──
CREATE TABLE IF NOT EXISTS static_clients (
  id SERIAL PRIMARY KEY,
  support_name TEXT,
  client_name TEXT,
  scheduled_date TEXT,
  contracted_amount INTEGER DEFAULT 0,
  branches INTEGER DEFAULT 0,
  location TEXT,
  sector TEXT DEFAULT 'PHARMACY',
  assigned_manager TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
GRANT ALL ON static_clients TO anon;
GRANT USAGE ON SEQUENCE static_clients_id_seq TO anon;

-- ── CLIENTS TABLE (dynamic clients added via tool) ──────────
CREATE TABLE IF NOT EXISTS clients (
  id SERIAL PRIMARY KEY,
  support_name TEXT,
  client_name TEXT,
  scheduled_date TEXT,
  contracted_amount INTEGER DEFAULT 0,
  branches INTEGER DEFAULT 0,
  location TEXT,
  sector TEXT DEFAULT 'PHARMACY',
  assigned_manager TEXT,
  active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
GRANT ALL ON clients TO anon;
GRANT USAGE ON SEQUENCE clients_id_seq TO anon;

-- ── CLIENT OVERRIDES (edits to static clients) ──────────────
CREATE TABLE IF NOT EXISTS client_overrides (
  id SERIAL PRIMARY KEY,
  client_index INTEGER UNIQUE,
  support_name TEXT,
  client_name TEXT,
  scheduled_date TEXT,
  contracted_amount INTEGER,
  branches INTEGER DEFAULT 0,
  location TEXT,
  sector TEXT,
  assigned_manager TEXT,
  updated_by TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
GRANT ALL ON client_overrides TO anon;
GRANT USAGE ON SEQUENCE client_overrides_id_seq TO anon;

-- ── DEPLOYMENTS TABLE (status updates per client) ───────────
CREATE TABLE IF NOT EXISTS deployments (
  id SERIAL PRIMARY KEY,
  client_index INTEGER UNIQUE,
  support_name TEXT,
  client_name TEXT,
  scheduled_date TEXT,
  contracted_amount INTEGER DEFAULT 0,
  status TEXT DEFAULT 'Pending',
  notes TEXT,
  updated_by TEXT,
  updated_at TIMESTAMPTZ,
  rescheduled_date TEXT,
  photo_url TEXT,
  approval_status TEXT DEFAULT 'pending',  -- 'pending' | 'needs_approval' | 'approved' | 'rejected'
  approved_by TEXT,
  approved_at TIMESTAMPTZ,
  client_paid BOOLEAN DEFAULT false,
  paid_at TIMESTAMPTZ,
  assigned_manager TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
GRANT ALL ON deployments TO anon;
GRANT USAGE ON SEQUENCE deployments_id_seq TO anon;

-- ── TEAM ASSIGNMENTS (manager → support agent) ──────────────
CREATE TABLE IF NOT EXISTS team_assignments (
  id SERIAL PRIMARY KEY,
  manager_name TEXT NOT NULL,
  support_name TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  CONSTRAINT unique_manager_support UNIQUE (manager_name, support_name)
);
GRANT ALL ON team_assignments TO anon;
GRANT USAGE ON SEQUENCE team_assignments_id_seq TO anon;

-- ── MANAGER BONUS REQUESTS ───────────────────────────────────
CREATE TABLE IF NOT EXISTS manager_bonuses (
  id SERIAL PRIMARY KEY,
  manager_name TEXT NOT NULL,
  period TEXT,
  base_amount INTEGER DEFAULT 500000,
  requested_amount INTEGER,
  request_comment TEXT,
  approved_amount INTEGER,
  approval_comment TEXT,
  status TEXT DEFAULT 'pending',  -- 'pending' | 'approved' | 'rejected'
  approved_by TEXT,
  approved_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
GRANT ALL ON manager_bonuses TO anon;
GRANT USAGE ON SEQUENCE manager_bonuses_id_seq TO anon;
