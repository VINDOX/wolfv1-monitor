-- ============================================================
-- ISHYIGA WOLF V1 — Deployment Monitor
-- Initial Data Seed SQL
-- Algorithm Inc. | May 2026
-- Run this AFTER setup.sql
-- ============================================================

-- ── SYSTEM CONFIG ROWS ───────────────────────────────────────

-- Deployment statuses
INSERT INTO users (name, pin, role, active) VALUES
('__statuses__', '["Pending","Email Sent","Convincing","Done","Refused","Rescheduled"]', 'system', true)
ON CONFLICT (name) DO UPDATE SET pin = EXCLUDED.pin;

-- Payment tracking (starts empty)
INSERT INTO users (name, pin, role, active) VALUES
('__payments__', '{}', 'system', true)
ON CONFLICT (name) DO NOTHING;

-- Basic salary agents (agents who earn Basic + 10%)
INSERT INTO users (name, pin, role, active) VALUES
('__basic_salary__', '["TUYISHIME Olivier","Josephine umwanankabandi","Angelique HABIYAMBERE"]', 'system', true)
ON CONFLICT (name) DO UPDATE SET pin = EXCLUDED.pin;

-- Manager base salary default (500,000 RWF/month)
INSERT INTO users (name, pin, role, active) VALUES
('__manager_base__', '500000', 'system', true)
ON CONFLICT (name) DO UPDATE SET pin = EXCLUDED.pin;

-- Manager titles (stored as JSON)
INSERT INTO users (name, pin, role, active) VALUES
('__manager_titles__', '{
  "HAGENIMANA Emmanuel":{"title":"Team Lead / Senior Coordinator","role":"Board Member & Senior","base_salary":500000},
  "BIZIMANA JMV":{"title":"Senior Support Specialist","role":"Board Member & Senior","base_salary":500000},
  "NIYIGIRIMBABAZI Barthelemy":{"title":"QA & Version Testing Lead","role":"Board Member & Senior","base_salary":500000},
  "DANIEL ISHIMWE":{"title":"Client Relations & Communication","role":"Board Member","base_salary":500000},
  "DESIRE KIMENYI":{"title":"Client Relations & Escalation Manager","role":"Board Member","base_salary":500000},
  "MVUYEKURE Corneille":{"title":"Hot Fix & Debug Specialist","role":"Board Member","base_salary":500000}
}', 'system', true)
ON CONFLICT (name) DO UPDATE SET pin = EXCLUDED.pin;

-- Access control (empty = use defaults)
INSERT INTO users (name, pin, role, active) VALUES
('__access_control__', '{}', 'system', true)
ON CONFLICT (name) DO NOTHING;

-- ── COORDINATOR ──────────────────────────────────────────────
INSERT INTO users (name, pin, role, active) VALUES
('COORDINATOR', '0000', 'coordinator', true)
ON CONFLICT (name) DO UPDATE SET role = 'coordinator', active = true;

-- ── SUPPORT AGENTS ───────────────────────────────────────────
INSERT INTO users (name, pin, role, active) VALUES
('TUYISHIME Olivier',        '1001', 'support', true),
('jean claude bikorimana',   '1002', 'support', true),
('Josephine umwanankabandi', '1003', 'support', true),
('fidele ngendahimana',      '1004', 'support', true),
('MUKESHARUGAMBA Felicien',  '1005', 'support', true),
('Fidelente HORANIMPUNDU',   '1006', 'support', true),
('Niyonsenga Eric',          '1007', 'support', true),
('Theogene Hashimwimana',    '1008', 'support', true),
('Uwimanikunda lucie',       '1009', 'support', true),
('Angelique HABIYAMBERE',    '1010', 'support', true)
ON CONFLICT (name) DO UPDATE SET role = 'support', active = true;

-- Deactivated support account (replaced by manager account)
INSERT INTO users (name, pin, role, active) VALUES
('Hagenimana emmanuel', '1470', 'support', false)
ON CONFLICT (name) DO UPDATE SET active = false;

-- ── MANAGERS (Board Members) ──────────────────────────────────
INSERT INTO users (name, pin, role, active, base_salary) VALUES
('HAGENIMANA Emmanuel',       '2001', 'manager', true, 500000),
('BIZIMANA JMV',              '2002', 'manager', true, 500000),
('NIYIGIRIMBABAZI Barthelemy','2003', 'manager', true, 500000),
('DANIEL ISHIMWE',            '2004', 'manager', true, 500000),
('DESIRE KIMENYI',            '2005', 'manager', true, 500000),
('MVUYEKURE Corneille',       '2006', 'manager', true, 500000)
ON CONFLICT (name) DO UPDATE SET role = 'manager', active = true, base_salary = EXCLUDED.base_salary;

-- ── TEAM ASSIGNMENTS ─────────────────────────────────────────
DELETE FROM team_assignments;

INSERT INTO team_assignments (manager_name, support_name) VALUES
('HAGENIMANA Emmanuel',  'TUYISHIME Olivier'),
('HAGENIMANA Emmanuel',  'Theogene Hashimwimana'),
('HAGENIMANA Emmanuel',  'fidele ngendahimana'),
('BIZIMANA JMV',         'Uwimanikunda lucie'),
('BIZIMANA JMV',         'jean claude bikorimana'),
('DESIRE KIMENYI',       'Josephine umwanankabandi'),
('DESIRE KIMENYI',       'MUKESHARUGAMBA Felicien'),
('MVUYEKURE Corneille',  'Niyonsenga Eric'),
('MVUYEKURE Corneille',  'Fidelente HORANIMPUNDU')
ON CONFLICT DO NOTHING;

-- ── ADD COLUMNS IF NOT EXISTS ────────────────────────────────
ALTER TABLE deployments ADD COLUMN IF NOT EXISTS client_paid BOOLEAN DEFAULT false;
ALTER TABLE deployments ADD COLUMN IF NOT EXISTS paid_at TIMESTAMPTZ;
ALTER TABLE deployments ADD COLUMN IF NOT EXISTS assigned_manager TEXT;
ALTER TABLE static_clients ADD COLUMN IF NOT EXISTS assigned_manager TEXT;
ALTER TABLE client_overrides ADD COLUMN IF NOT EXISTS assigned_manager TEXT;
ALTER TABLE users ADD COLUMN IF NOT EXISTS base_salary INTEGER DEFAULT 500000;
