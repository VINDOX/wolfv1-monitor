# 🦊 ISHYIGA WOLF V1 — Deployment Monitor

**Algorithm Inc.** | Pharmacy POS Deployment Tracking System  
Deployment Window: **May 21 – June 30, 2026**  
Total Clients: **333 pharmacy clients** across Rwanda

---

## 🌐 Live URL
**https://adorable-seahorse-249416.netlify.app**

---

## 📋 Overview

A real-time web tool to monitor and manage the WOLF V1 (POS version 10.3.0) rollout to 333 pharmacy clients. Built as a single HTML file with Supabase as the backend.

### Key Features
- Real-time deployment status tracking per client
- Role-based access control (Coordinator / Manager / Support)
- Approval workflow for Done & Refused reports
- Finance module — agent and manager payment tracking
- Manager system — team assignments, bonus requests, big client tracking
- Photo upload for visit proof
- Alert system — 8 alert types per role
- Export reports to Excel/CSV
- Admin panel — full user and client management

---

## 🗂 Repository Structure

```
wolfv1-monitor/
├── index.html          — Complete single-file web app
├── README.md           — This file
└── sql/
    ├── setup.sql       — Create all tables
    └── seed.sql        — Insert initial data
```

---

## 🚀 Setup Instructions

### 1. Supabase Setup
1. Create a new Supabase project at https://supabase.com
2. Go to **SQL Editor**
3. Run `sql/setup.sql` — creates all tables
4. Run `sql/seed.sql` — inserts initial data and users
5. Import your 333 clients into `static_clients` table

### 2. Configure Supabase credentials
Open `index.html` and update these two lines:
```javascript
const SUPABASE_URL = 'https://YOUR_PROJECT.supabase.co';
const SUPABASE_ANON_KEY = 'YOUR_ANON_KEY';
```

### 3. Deploy to Netlify
1. Drag the `index.html` file to https://netlify.com/drop
2. Your site is live instantly

---

## 👥 User Roles & PINs

| Name | PIN | Role |
|---|---|---|
| COORDINATOR | 0000 | 👑 Coordinator |
| HAGENIMANA Emmanuel | 2001 | 👔 Manager |
| BIZIMANA JMV | 2002 | 👔 Manager |
| NIYIGIRIMBABAZI Barthelemy | 2003 | 👔 Manager |
| DANIEL ISHIMWE | 2004 | 👔 Manager |
| DESIRE KIMENYI | 2005 | 👔 Manager |
| MVUYEKURE Corneille | 2006 | 👔 Manager |
| TUYISHIME Olivier | 1001 | 👤 Support |
| jean claude bikorimana | 1002 | 👤 Support |
| Josephine umwanankabandi | 1003 | 👤 Support |
| fidele ngendahimana | 1004 | 👤 Support |
| MUKESHARUGAMBA Felicien | 1005 | 👤 Support |
| Fidelente HORANIMPUNDU | 1006 | 👤 Support |
| Niyonsenga Eric | 1007 | 👤 Support |
| Theogene Hashimwimana | 1008 | 👤 Support |
| Uwimanikunda lucie | 1009 | 👤 Support |
| Angelique HABIYAMBERE | 1010 | 👤 Support |

---

## 🔐 Role Access Control

| Feature | 👑 Coordinator | 👔 Manager | 👤 Support |
|---|---|---|---|
| View clients | All 333 | Team only | Own only |
| Edit clients | ✅ All | ✅ Team | ✅ Own |
| Change dates | ✅ | ✅ | ❌ |
| Approve reports | ✅ All + Re-approve | ✅ Team | ❌ |
| Finance tab | ✅ | ❌ | ❌ |
| Admin Panel | ✅ | ❌ | ❌ |
| Download Excel | ✅ | ❌ | ❌ |
| Managers tab | ✅ | ❌ | ❌ |
| My Team tab | ❌ | ✅ | ❌ |
| Submit bonus | ❌ | ✅ | ❌ |
| Approve bonus | ✅ | ❌ | ❌ |
| View earnings | ✅ | ✅ own | ✅ own |

---

## 💰 Payment Logic

### Support Agents
- **Basic + 10%**: TUYISHIME Olivier, Josephine umwanankabandi, Angelique HABIYAMBERE
- **10% Only**: All other support agents
- Payment per client: `contracted_amount × 10%`
- Only approved Done/Refused reports count

### Managers
- **Base Salary**: Configurable per manager (default 500,000 RWF/month), prorated by period
- **Big Client Bonus**: 250,000 RWF per Done client directly assigned to manager
- **Performance Bonus**: Requested by manager → approved by CEO with custom amount

---

## 🗄 Database Tables

| Table | Description |
|---|---|
| `users` | All users + system config rows |
| `static_clients` | 333 original pharmacy clients |
| `clients` | Dynamic clients added via tool |
| `client_overrides` | Edits to static clients |
| `deployments` | Status updates per client |
| `team_assignments` | Manager → support agent links |
| `manager_bonuses` | Manager bonus requests |

### System Config Rows (in users table)
| Row Name | Content |
|---|---|
| `__statuses__` | Custom status list |
| `__payments__` | Payment status per agent |
| `__basic_salary__` | Basic salary agents list |
| `__manager_base__` | Default manager base salary |
| `__manager_titles__` | Manager titles and per-manager salary |
| `__access_control__` | Role permission overrides |

---

## 🔔 Alert Types

1. ⏳ Reports awaiting approval
2. 🔴 Overdue rescheduled clients
3. 📅 Today's clients still Pending
4. 📧 Email not sent (scheduled tomorrow)
5. 📝 Refused but no reason
6. 📷 Done but no photo
7. 🔒 Date passed, never visited
8. 👤 Inactive support agents (coordinator only)

---

## 📊 Export Reports

Available from Finance tab:
- **📥 Summary Report** — one row per support agent
- **📋 Detailed Report** — one row per approved client
- **👔 Manager Report** — all managers earnings
- **📊 Full Report** — everything in one CSV file

---

## 🛠 Tech Stack

- **Frontend**: Vanilla HTML/CSS/JavaScript (single file)
- **Backend**: Supabase (PostgreSQL)
- **Hosting**: Netlify
- **No frameworks, no build tools required**

---

## 📞 Support

Built by Algorithm Inc. for WOLF V1 deployment monitoring.  
Contact coordinator for PIN codes and access issues.
