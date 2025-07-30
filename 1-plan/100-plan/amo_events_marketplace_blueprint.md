# 📦 AMO Events Marketplace & Media Hub — Implementation Blueprint  
*Launch Cities: Toronto 🇨🇦 & Medellín 🇨🇴*  
*Generated: 2025-06-08*

---

## 📘 Executive Summary

**AMO Events** is a B2C/B2B event services marketplace and media licensing platform. It enables users to **book talent**, **pay vendors**, and **license event content**, launching in **Toronto** and **Medellín**.

---

## 📚 Table of Contents

1. Project Scope & Geo-Launch Goals  
2. Marketplace Models (Talent, Services, Media)  
3. User Roles & Permission Matrix  
4. Localization Strategy (Language, Currency, Tax)  
5. Vendor Schema & Metadata  
6. Booking Workflow with Stripe Connect  
7. LangChain + Pinecone Smart Search  
8. LangGraph Agent Orchestration  
9. n8n Automations for Ops & Communication  
10. Media Upload & Licensing Flow (Getty-style)  
11. Dashboards (Organizer, Vendor, Admin)  
12. Tech Stack & Tools by Layer  
13. Legal & Compliance Checklist  
14. MVP Roadmap & Timeline  
15. Research & Benchmarking

---

## 🌍 Geo-Focus Strategy

### Toronto 🇨🇦
- Market: Tech events, nightlife, weddings
- Payment: CAD
- Vendor Onboarding: Local talent agencies, coworking spaces

### Medellín 🇨🇴
- Market: Cultural & digital nomad events
- Payment: COP
- Compliance: RUT, DIAN, Colombian tax schema

---

## 🧩 Vendor Categories

| Type | Metadata |
|------|----------|
| Photographer | Gear, hourly rate, genre, samples |
| DJ | Genres, gear, video samples |
| Venue | Capacity, features, city zoning |
| Caterer | Menu, dietary options, staff ratio |
| Videographer | Gear, drone use, editing options |
| Staff | Role, experience, city |

---

## 🤖 AI Agent Concepts (LangGraph)

| Agent | Description |
|-------|-------------|
| Matchmaker Agent | Finds vendors by budget + location |
| Conflict Checker | Detects double bookings |
| Media Tagging Agent | AI labels media by event/type |
| Licensing Optimizer | Suggests pricing by trend/metadata |
| Post-Event Follow-up | Automates reviews, refunds |

---

## 🔧 Tech Stack

| Layer | Tools |
|-------|-------|
| UI | Webflow |
| Backend | Supabase, Stripe Connect |
| Automation | n8n |
| AI | OpenAI, LangChain, Pinecone |
| Orchestration | LangGraph |
| Media Storage | Supabase / AWS S3 |
| Messaging | WhatsApp API (WATI/Twilio) |
| Monitoring | Sentry, Vercel Analytics |

---

## 💵 Stripe Connect: Booking Flow

- Multi-party payout  
- Supports COP/CAD  
- Escrow-like holding until event date  
- Payout schedules & platform fee management  

---

## 📂 Deliverables

- [ ] JSON Schemas for vendors & media  
- [ ] LangGraph flow for booking + licensing  
- [ ] Stripe Connect config with webhook logic  
- [ ] Dashboards: Organizer, Vendor, Admin  
- [ ] n8n flows for WhatsApp confirmations  
- [ ] Compliance checklist for Medellín & Toronto  

---

## 🧪 Research References

- Skift AI Booking → [AI-Powered Venue Booking](https://meetings.skift.com/2024/06/25/ai-powered-venue-booking-is-here)  
- Nowadays.ai → [Creative Talent Booking UX](https://nowadays.ai)  
- EventHub, Cvent, vFairs – Feature comparisons

---

