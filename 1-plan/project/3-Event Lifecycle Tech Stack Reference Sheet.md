Here is the **generated Reference Sheet** showing how each tool in your stack maps to the **Event Lifecycle Phases**, organized for clarity and production use:

---

# 🧩 Event Lifecycle Tech Stack Reference Sheet

Each section shows **tools**, their **integration roles**, and how they're applied to different **event lifecycle phases**.

---

## 1. 📅 **Event Planning**

| Tool           | Role / Integration                                                        | Notes                              |
| -------------- | ------------------------------------------------------------------------- | ---------------------------------- |
| **CrewAI**     | Multi-agent orchestration: venue scouting, budgeting, timeline generation | Claude/OpenAI agents embedded      |
| **CopilotKit** | In-app AI for form completion during event draft setup                    | Refine + Next.js dashboard support |
| **Claude**     | Brainstorming event structure, AI-generated timelines                     | Planning assistant                 |
| **Supabase**   | Event schema (tables: `events`, `venues`, `budget_items`, `timeline`)     | Realtime schema creation           |
| **n8n**        | Automates approval workflows, planner notifications                       | Connects Claude, Supabase          |

---

## 2. 🗂️ **Event Management**

| Tool              | Role / Integration                                                | Notes                             |
| ----------------- | ----------------------------------------------------------------- | --------------------------------- |
| **Refine v4.57**  | Admin UI for managing vendors, staff, timelines                   | Material UI v6 components         |
| **Supabase**      | Staff roles, vendor assignments, run-of-show data                 | `staff`, `vendors`, `run_of_show` |
| **Twenty CRM**    | Sync vendor and sponsor communications                            | Connected via n8n                 |
| **n8n**           | Scheduling, alerts for task deadlines, vendor contract automation | Auto-sync workflows               |
| **Claude/OpenAI** | Generate internal comms, team briefings                           | Claude Desktop + agent memory     |

---

## 3. 🎛️ **Production & Operations (Pre-Event)**

| Tool                 | Role / Integration                                                         | Notes                              |
| -------------------- | -------------------------------------------------------------------------- | ---------------------------------- |
| **CrewAI**           | Agent for logistics, staffing, build-out, risk assessments                 | LangGraph workflows                |
| **Refine + Next.js** | Dashboard for deliverables, setup status, credential generation            | Live preview of production flow    |
| **Supabase**         | Manages tables: `deliverables`, `credentials`, `tech_checks`, `rehearsals` | Realtime status updates            |
| **n8n**              | Automates vendor reminders, access pass generation                         | Can trigger WhatsApp notifications |
| **Cloudinary**       | Stores booth maps, build-out photos, signage plans                         | Used in credential portals         |

---

## 4. 🎤 **Live Event Management**

| Tool              | Role / Integration                                                      | Notes                                     |
| ----------------- | ----------------------------------------------------------------------- | ----------------------------------------- |
| **WhatsApp API**  | Attendee QR check-in, live support, staff alerts                        | Integrates with Supabase + Claude         |
| **n8n**           | Triggers live updates, logs incidents, sends real-time feedback surveys | Works with WhatsApp and SendGrid          |
| **Claude/CrewAI** | Detects anomalies, suggests real-time actions (via event logs)          | Live AI agents                            |
| **Supabase**      | Tracks: `check_in_logs`, `incident_logs`, `support_requests`            | Edge function powered                     |
| **Cloudinary**    | Stores live media, event streaming previews                             | Integrated with Webflow or dashboard view |

---

## 5. 📈 **Post-Event Activities**

| Tool              | Role / Integration                                                | Notes                           |
| ----------------- | ----------------------------------------------------------------- | ------------------------------- |
| **Claude/OpenAI** | Post-event summaries, feedback synthesis, lessons learned         | Auto-analysis agent             |
| **n8n**           | Automates thank-you emails, lead handoff, survey deployment       | Syncs to Twenty CRM             |
| **Twenty CRM**    | Tracks sponsor/attendee churn, follow-up opportunities            | Segment and enrich CRM          |
| **Supabase**      | Tables: `feedback`, `payments`, `crm_contacts`, `lessons_learned` | Connected to Claude agents      |
| **SendGrid**      | Sends feedback campaigns and personalized re-engagement           | Supports segmentation + metrics |

---

## 6. 🤝 **Sponsorship Sales & Management**

| Tool           | Role / Integration                                                    | Notes                                     |
| -------------- | --------------------------------------------------------------------- | ----------------------------------------- |
| **CrewAI**     | Prospect scoring, activation planning, contract management via agents | `SponsorshipMatchingAgent`                |
| **Twenty CRM** | Sponsor pipeline, notes, follow-up tracking                           | Used during live + post phases            |
| **OpenAI**     | Proposal generation, activation benefit drafts                        | Claude-augmented text                     |
| **Supabase**   | Tables: `sponsors`, `crm_stage`, `contracts`, `benefits_delivered`    | Linked to ticketing and content plans     |
| **n8n**        | Auto-send proposals, sign-off workflows                               | With DocuSign or Google Docs integrations |

---

## 7. 🎟️ **Ticketing & CRM Sales Cycle**

| Tool             | Role / Integration                                   | Notes                                      |
| ---------------- | ---------------------------------------------------- | ------------------------------------------ |
| **Supabase**     | Dynamic ticket pricing, category management          | `ticket_sales`, `tiers`, `abandoned_carts` |
| **Stripe**       | Processes payments, refunds, upgrades                | Secure checkout via API                    |
| **n8n**          | Automates confirmations, sends to WhatsApp + Email   | Syncs with `abandoned_cart_recovery`       |
| **SendGrid**     | Confirmation emails, payment receipts                | Integrated with Stripe metadata            |
| **WhatsApp API** | Sends QR code ticket, reminders, and upgrade options | Flows triggered by n8n                     |

---

## 8. 📣 **Marketing & Communications**

| Tool              | Role / Integration                                                           | Notes                                  |
| ----------------- | ---------------------------------------------------------------------------- | -------------------------------------- |
| **OpenAI/Claude** | Generates campaigns, social content, influencer briefs                       | Integrated into n8n campaigns          |
| **SendGrid**      | Email campaigns, segmentation, and A/B testing                               | Triggered via `event_category` mapping |
| **Cloudinary**    | Optimized social media images, speaker headshots, merchandise visuals        | Auto-compressed, linked via metadata   |
| **CopilotKit**    | In-app suggestions during campaign setup (CTA, subject lines)                | Integrated into Refine forms           |
| **n8n**           | Full campaign orchestration: segmentation, post scheduling, performance logs | Pulls from Supabase + Cloudinary       |

---

## 📊 Summary Matrix (Tool → Lifecycle Coverage)

| Tool           | Planning | Mgmt | Prod | Live | Post | Sponsors | Ticketing | Marketing |
| -------------- | -------- | ---- | ---- | ---- | ---- | -------- | --------- | --------- |
| CrewAI         | ✅        | ✅    | ✅    | ⚠️   | ✅    | ✅        | ❌         | ❌         |
| CopilotKit     | ✅        | ⚠️   | ❌    | ❌    | ✅    | ❌        | ✅         | ✅         |
| Claude/OpenAI  | ✅        | ✅    | ✅    | ✅    | ✅    | ✅        | ✅         | ✅         |
| Refine + MUI 6 | ✅        | ✅    | ✅    | ✅    | ✅    | ⚠️       | ✅         | ✅         |
| Supabase       | ✅        | ✅    | ✅    | ✅    | ✅    | ✅        | ✅         | ✅         |
| Twenty CRM     | ❌        | ✅    | ❌    | ✅    | ✅    | ✅        | ✅         | ⚠️        |
| n8n            | ✅        | ✅    | ✅    | ✅    | ✅    | ✅        | ✅         | ✅         |
| WhatsApp API   | ❌        | ⚠️   | ✅    | ✅    | ✅    | ❌        | ✅         | ✅         |
| SendGrid       | ❌        | ✅    | ✅    | ✅    | ✅    | ✅        | ✅         | ✅         |
| Cloudinary     | ❌        | ✅    | ✅    | ✅    | ✅    | ✅        | ❌         | ✅         |
| Stripe         | ❌        | ❌    | ❌    | ✅    | ✅    | ✅        | ✅         | ❌         |

---

✅ Would you like this reference sheet exported as a Notion table, CSV, or JSON structure for developer integration?
