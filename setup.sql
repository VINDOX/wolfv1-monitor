-- ============================================================
-- WOLF V1 — SETUP.SQL
-- Algorithm Inc. — Client Deployment Monitor
-- Run this FIRST on a fresh Supabase project
-- ============================================================

-- ── USERS TABLE ───────────────────────────────────────────
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL,
  pin TEXT NOT NULL,
  role TEXT DEFAULT 'support',
  active BOOLEAN DEFAULT true,
  base_salary INTEGER DEFAULT 500000
);

-- ── STATIC CLIENTS TABLE ──────────────────────────────────
CREATE TABLE IF NOT EXISTS static_clients (
  id SERIAL PRIMARY KEY,
  support_name TEXT,
  client_name TEXT,
  scheduled_date DATE,
  contracted_amount INTEGER DEFAULT 0,
  branches INTEGER DEFAULT 0,
  location TEXT,
  sector TEXT DEFAULT 'OTHER',
  assigned_manager TEXT,
  client_type TEXT DEFAULT 'Pharmacy'
);

-- ── DYNAMIC CLIENTS TABLE ─────────────────────────────────
CREATE TABLE IF NOT EXISTS clients (
  id SERIAL PRIMARY KEY,
  support_name TEXT,
  client_name TEXT,
  scheduled_date DATE,
  contracted_amount INTEGER DEFAULT 0,
  branches INTEGER DEFAULT 0,
  location TEXT,
  sector TEXT DEFAULT 'OTHER',
  assigned_manager TEXT,
  client_type TEXT DEFAULT 'OTHER',
  active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ── DEPLOYMENTS TABLE ─────────────────────────────────────
CREATE TABLE IF NOT EXISTS deployments (
  id SERIAL PRIMARY KEY,
  client_index INTEGER UNIQUE,
  status TEXT DEFAULT 'Pending',
  notes TEXT,
  updated_by TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  rescheduled_date DATE,
  photo_url TEXT,
  approval_status TEXT DEFAULT 'pending',
  approved_by TEXT,
  approved_at TIMESTAMPTZ,
  client_paid BOOLEAN DEFAULT false,
  paid_at TIMESTAMPTZ,
  assigned_manager TEXT
);

-- ── CLIENT OVERRIDES TABLE ────────────────────────────────
CREATE TABLE IF NOT EXISTS client_overrides (
  id SERIAL PRIMARY KEY,
  client_index INTEGER UNIQUE,
  support_name TEXT,
  client_name TEXT,
  scheduled_date DATE,
  contracted_amount INTEGER,
  branches INTEGER,
  location TEXT,
  sector TEXT,
  assigned_manager TEXT,
  client_type TEXT,
  updated_by TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ── TEAM ASSIGNMENTS TABLE ────────────────────────────────
CREATE TABLE IF NOT EXISTS team_assignments (
  id SERIAL PRIMARY KEY,
  manager_name TEXT NOT NULL,
  support_name TEXT NOT NULL,
  UNIQUE(manager_name, support_name)
);

-- ── MANAGER BONUSES TABLE ─────────────────────────────────
CREATE TABLE IF NOT EXISTS manager_bonuses (
  id SERIAL PRIMARY KEY,
  manager_name TEXT NOT NULL,
  period TEXT,
  base_amount INTEGER DEFAULT 0,
  requested_amount INTEGER DEFAULT 0,
  request_comment TEXT,
  approved_amount INTEGER DEFAULT 0,
  approval_comment TEXT,
  status TEXT DEFAULT 'pending',
  approved_by TEXT,
  approved_at TIMESTAMPTZ,
  type TEXT DEFAULT 'manager',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

