-- ============================================================
-- WOLF V1 — SEED.SQL
-- Algorithm Inc. — Client Deployment Monitor
-- Run this AFTER setup.sql
-- ============================================================

-- ── USERS ─────────────────────────────────────────────────
INSERT INTO users (name, pin, role, active, base_salary) VALUES
('COORDINATOR', '0000', 'coordinator', true, 0),
('TUYISHIME Olivier', '1001', 'support', true, 0),
('jean claude bikorimana', '1002', 'support', true, 0),
('Josephine umwanankabandi', '1003', 'support', true, 0),
('fidele ngendahimana', '1004', 'support', true, 0),
('MUKESHARUGAMBA Felicien', '1005', 'support', true, 0),
('Fidelente HORANIMPUNDU', '1006', 'support', true, 0),
('Niyonsenga Eric', '1007', 'support', true, 0),
('Theogene Hashimwimana', '1008', 'support', true, 0),
('Uwimanikunda lucie', '1009', 'support', true, 0),
('Angelique HABIYAMBERE', '1010', 'support', true, 0),
('HAGENIMANA Emmanuel', '2001', 'manager', true, 500000),
('BIZIMANA JMV', '2002', 'manager', true, 500000),
('NIYIGIRIMBABAZI Barthelemy', '2003', 'manager', true, 500000),
('DANIEL ISHIMWE', '2004', 'manager', true, 500000),
('DESIRE KIMENYI', '2005', 'manager', true, 500000),
('MVUYEKURE Corneille', '2006', 'manager', true, 500000)
ON CONFLICT (name) DO NOTHING;

-- ── SYSTEM ROWS ───────────────────────────────────────────
INSERT INTO users (name, pin, role, active) VALUES
('__statuses__', '["Pending","Email Sent","Convincing","Done","Refused","Rescheduled"]', 'system', true),
('__payments__', '{}', 'system', true),
('__basic_salary__', '["TUYISHIME Olivier","Josephine umwanankabandi","Angelique HABIYAMBERE"]', 'system', true),
('__manager_base__', '500000', 'system', true),
('__manager_titles__', '{}', 'system', true),
('__access_control__', '{}', 'system', true),
('__mgr_performance__', '{}', 'system', true),
('__date_edit_window__', '{"open":false,"from":"","to":"","openedBy":""}', 'system', true)
ON CONFLICT (name) DO NOTHING;

-- ── TEAM ASSIGNMENTS ──────────────────────────────────────
INSERT INTO team_assignments (manager_name, support_name) VALUES
('HAGENIMANA Emmanuel', 'TUYISHIME Olivier'),
('HAGENIMANA Emmanuel', 'Theogene Hashimwimana'),
('HAGENIMANA Emmanuel', 'fidele ngendahimana'),
('BIZIMANA JMV', 'Uwimanikunda lucie'),
('BIZIMANA JMV', 'jean claude bikorimana'),
('DESIRE KIMENYI', 'Josephine umwanankabandi'),
('DESIRE KIMENYI', 'MUKESHARUGAMBA Felicien'),
('MVUYEKURE Corneille', 'Niyonsenga Eric'),
('MVUYEKURE Corneille', 'Fidelente HORANIMPUNDU')
ON CONFLICT (manager_name, support_name) DO NOTHING;

