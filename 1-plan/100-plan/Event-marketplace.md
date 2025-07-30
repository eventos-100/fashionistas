\# 📦 AMO Events Marketplace & Media Hub — Implementation Blueprint    
\*Launch Cities: Toronto 🇨🇦 & Medellín 🇨🇴\*    
\*Generated: 2025-06-08\*

\---

\#\# 📘 Executive Summary

\*\*AMO Events\*\* is a B2C/B2B event services marketplace and media licensing platform. It enables users to \*\*book talent\*\*, \*\*pay vendors\*\*, and \*\*license event content\*\*, launching in \*\*Toronto\*\* and \*\*Medellín\*\*.

\---

\#\# 📚 Table of Contents

1\. Project Scope & Geo-Launch Goals    
2\. Marketplace Models (Talent, Services, Media)    
3\. User Roles & Permission Matrix    
4\. Localization Strategy (Language, Currency, Tax)    
5\. Vendor Schema & Metadata    
6\. Booking Workflow with Stripe Connect    
7\. LangChain \+ Pinecone Smart Search    
8\. LangGraph Agent Orchestration    
9\. n8n Automations for Ops & Communication    
10\. Media Upload & Licensing Flow (Getty-style)    
11\. Dashboards (Organizer, Vendor, Admin)    
12\. Tech Stack & Tools by Layer    
13\. Legal & Compliance Checklist    
14\. MVP Roadmap & Timeline    
15\. Research & Benchmarking

\---

\#\# 🌍 Geo-Focus Strategy

\#\#\# Toronto 🇨🇦  
\- Market: Tech events, nightlife, weddings  
\- Payment: CAD  
\- Vendor Onboarding: Local talent agencies, coworking spaces

\#\#\# Medellín 🇨🇴  
\- Market: Cultural & digital nomad events  
\- Payment: COP  
\- Compliance: RUT, DIAN, Colombian tax schema

\---

\#\# 🧩 Vendor Categories

| Type | Metadata |  
|------|----------|  
| Photographer | Gear, hourly rate, genre, samples |  
| DJ | Genres, gear, video samples |  
| Venue | Capacity, features, city zoning |  
| Caterer | Menu, dietary options, staff ratio |  
| Videographer | Gear, drone use, editing options |  
| Staff | Role, experience, city |

\---

\#\# 🤖 AI Agent Concepts (LangGraph)

| Agent | Description |  
|-------|-------------|  
| Matchmaker Agent | Finds vendors by budget \+ location |  
| Conflict Checker | Detects double bookings |  
| Media Tagging Agent | AI labels media by event/type |  
| Licensing Optimizer | Suggests pricing by trend/metadata |  
| Post-Event Follow-up | Automates reviews, refunds |

\---

\#\# 🔧 Tech Stack

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

\---

\#\# 💵 Stripe Connect: Booking Flow

\- Multi-party payout    
\- Supports COP/CAD    
\- Escrow-like holding until event date    
\- Payout schedules & platform fee management  

\---

\#\# 📂 Deliverables

\- \[ \] JSON Schemas for vendors & media    
\- \[ \] LangGraph flow for booking \+ licensing    
\- \[ \] Stripe Connect config with webhook logic    
\- \[ \] Dashboards: Organizer, Vendor, Admin    
\- \[ \] n8n flows for WhatsApp confirmations    
\- \[ \] Compliance checklist for Medellín & Toronto  

\---

\#\# 🧪 Research References

\- Skift AI Booking → \[AI-Powered Venue Booking\](https://meetings.skift.com/2024/06/25/ai-powered-venue-booking-is-here)    
\- Nowadays.ai → \[Creative Talent Booking UX\](https://nowadays.ai)    
\- EventHub, Cvent, vFairs – Feature comparisons

Here’s a custom AI-powered event marketplace development plan prompt for the AMO Events Ecosystem, a specialized component of the “I Love Medellín” project. This version includes a dedicated event supplier marketplace, real-time booking/payment automation, and a media marketplace for photographers and videographers.

---

## **✅ AI Development Prompt – AMO Events Marketplace & Media Hub (for Cursor AI)**

Your task is to design and implement an AI-powered Events Ecosystem for AMO Medellín, supporting both B2C and B2B users through a vendor booking marketplace and media monetization platform.

---

### **🎯 Prompt Objective**

Build an intelligent, automated, and monetizable event supplier marketplace and media platform, combining:

* AI-powered vendor search (musicians, DJs, venues, photographers, etc.)

* Booking & payment system with Stripe Connect

* Photographer/Videographer content hub for media resale

* Dashboard suite for vendors, organizers, and admins

* Automated workflows using LangChain, LangGraph, and n8n

* UI/UX on Webflow, backed by Supabase & Pinecone

---

### **📚 Table of Contents for Implementation Plan**

1. Project Scope & Strategic Goals

2. User Personas & Use Cases

3. Marketplace Architecture

4. Vendor Types & Metadata Schema

5. Booking \+ Stripe Connect Integration

6. AI-Powered Discovery Engine (LangChain \+ Pinecone)

7. Automated Workflows (n8n \+ LangGraph Agents)

8. Media Licensing Marketplace (Photographers/Videographers)

9. Event Organizer Dashboard Features

10. Talent & Vendor Dashboard Features

11. Admin Panel \+ Analytics

12. AI Agent Use Cases

13. Deployment Pipeline

14. Checklist of Tools, Models, & APIs

15. Competitive Research Summary

16. Launch Strategy & MVP Goals

---

### **📦 Feature Checklist by Module**

| Module | Features |
| ----- | ----- |
| Vendor Marketplace | \- Listings for musicians, DJs, venues, catering, photographers, videographers- AI-powered vendor matching- Booking calendar sync- Reviews & ratings |
| Booking System | \- Stripe Connect multi-party payments- Organizer \+ vendor payouts- Dynamic pricing rules |
| Media Hub | \- Photographer & videographer content upload- Licensing tiers (editorial, commercial)- AI tagging & discovery (like Getty Images) |
| Dashboards | \- Organizer: Bookings, budgets, contracts- Vendor: Orders, reviews, portfolio- Admin: Reports, fraud monitoring |
| AI Automations | \- RFP auto-matching- Vendor availability reminders- Event layout optimization- Follow-up & feedback collection |
| Agent Workflows (LangGraph) | \- Contract negotiation agent- Lead scoring agent- Marketplace moderation agent |
| Workflow Automations (n8n) | \- WhatsApp booking confirmations- Auto-email post-event surveys- Stripe webhook handling |
| Integration Layer | \- Webflow UI- Supabase DB- Pinecone for embeddings- Stripe Connect- OpenAI (Chat, Tags, Recommendations) |

---

### **🛠 Tech Stack & Tooling**

| Layer | Tool |
| ----- | ----- |
| Frontend | Webflow CMS, Stripe Checkout Widgets |
| Backend | Supabase, LangGraph, n8n |
| AI/LLM | OpenAI GPT-4, LangChain, Pinecone |
| Media Storage | Supabase Storage, AWS S3 |
| Communication | WhatsApp API via Twilio/WATI |
| Monitoring | Sentry, Vercel Analytics |
| Hosting | Vercel (Frontend), Supabase (Backend) |

---

### **🤖 AI Agent Use Case Ideas**

| Agent | Description |
| ----- | ----- |
| Smart Matchmaker Agent | Recommends top 3 DJs or venues based on budget, location, and type of event |
| Follow-up Agent | Automates post-event review collection and refund follow-up |
| Media Tagging Agent | Auto-generates SEO tags for uploaded media (faces, location, event type) |
| Lead Scoring Agent | Scores vendors or media contributors based on reviews, completion rate, engagement |
| Content Licensing Agent | Suggests ideal licensing price based on historical trends and quality |

---

### **🧪 Research Tasks for Assistant**

Use these URLs to benchmark and extract competitive advantages:

1. AI Venue Booking Innovation

    Research [AI-Powered Venue Booking from Skift](https://meetings.skift.com/2024/06/25/ai-powered-venue-booking-is-here/)

   * Identify how AI is reshaping venue sourcing

   * Highlight automation workflows and cost/time saved

2. Marketplace Benchmark – Nowadays

    Explore [Nowadays.ai](https://www.nowadays.ai/)

   * UX design for booking creatives

   * Integration patterns for artist management

---

### **🧱 Deliverables (Artifacts)**

You should generate:

1. Event Vendor JSON Schema

{  
  "vendor\_type": "Photographer",  
  "name": "",  
  "availability": \[\],  
  "location": "",  
  "price\_range": "",  
  "portfolio\_url": "",  
  "ai\_tags": \[\]  
}

1. 

2. LangGraph Flow Diagram

    A visual of the smart vendor sourcing → booking → payment → review flow

3. n8n Workflow Template

    Automates WhatsApp confirmation \+ Stripe payment \+ Supabase insert

4. Dashboard Wireframes (Figma-ready)

    Screens for Organizer, Vendor, and Admin roles

5. Competitive Analysis Table

    Features from Cvent, EventHub, vFairs, Nowadays, Getty

---

Would you like me to generate a full implementation document and tech checklist asYour task is to generate a comprehensive search for events suppliers market place event suppliers marketplace https://www.cvent.com/en/event-marketing-management/vendor-marketplace Vendor Marketplace: Venue and Vendor Sourcing | Cvent https://www.vfairs.com/features/discover/ vFairs Discover \- An Event Management Marketplace https://www.youreventmarketplace.com/ Global Event Professionals & Venues Directory | YourEventMarketplace https://eventhub.net/ EventHub list features services types of vendors rate review rank based on score of /100 competitive analysis of software features swot analysis generate table 

Here’s a comprehensive overview and competitive analysis of major event supplier marketplace platforms, including features, vendor types, reviews, and SWOT breakdown.

---

### **📊 Marketplace Comparison Table**

| Platform | Key Features | Vendor Types | Ratings / Reviews | Notable Strengths | Possible Weaknesses |
| ----- | ----- | ----- | ----- | ----- | ----- |
| Cvent Vendor Marketplace | • AI-powered RFP tools• 40K vendor listings across 2,500+ locations• Dashboard for project tracking, quote comparison, invoice/payment management  | AV/Production, Design, DMCs, Event Rentals, Travel, Safety, etc. | Well established, trusted by Fortune‑500 / G2 shows 4.3/5 on related products | • Vast vendor network• Fully integrated into Cvent ecosystem• AI-assisted sourcing and RFP drafting | • Higher cost/complexity for smaller events• Enterprise‑oriented |
| vFairs Discover | • Event listing & discovery marketplace• SEO‑optimized listings• Attract sponsors, exhibitors, attendees for all event types | Conferences, Job Fairs, Trade Shows, Virtual Event Suppliers | G2: 4.7/5; Capterra: “highly rated” | • Strong online visibility• Great for virtual/hybrid event exposure | • Not a full procurement tool• No RFP or payments handling |
| YourEventMarketplace | • Global directory for event professionals, venues and service providers | Venues, Agencies, Service Providers | Limited public reviews | • Broad global coverage• Simple vendor discovery | • Lack of listed features• Likely manual lead/contact process |
| EventHub (Platform) | • Exhibitor/vendor management• Sponsor discovery marketplace• Booth maps, logistics, documents, messaging tools | Exhibitors, Vendors, Sponsors | G2 review: 4.3/5; live‑show focus | • Strong on‑site and exhibitor tools• Mobile-friendly, messaging, payment integration | • Limited RFP/bidding support• May lean virtual/hybrid tools |
| Reposite | • RFP creation & sourcing• Trips marketplace• Supplier CRM, quote generation workspace | Group travel, DMCs, Event Suppliers | Noted \+20% commission uplift, \+10 hours saved/event | • Streamlines proposal generation• Efficient sourcing workflow | • Niche‑focused (travel groups)• Small network on scale of Cvent |

---

### **🧠 SWOT Highlights**

#### **Cvent Vendor Marketplace**

* Strengths: Enormous vendor network, full suite procurement \+ RFP \+ invoice \+ AI support.

* Weaknesses: High cost and enterprise complexity.

* Opportunities: Further AI enhancements, expansion in hybrid/virtual categories.

* Threats: Competition from niche, leaner solutions.

#### **vFairs Discover**

* Strengths: Strong SEO and audience reach for events & sponsors.

* Weaknesses: Lacks sourcing/procurement workflow tools.

* Opportunities: Could add supplier connections \+ lead gen.

* Threats: Specialized marketplaces may grab virtual/hybrid market.

#### **YourEventMarketplace**

* Strengths: Global directory; easy find of venues & agencies.

* Weaknesses: Minimal tooling and unclear value-add.

* Opportunities: Add quoting, bidding, ratings.

* Threats: Overshadowed without differentiation.

#### **EventHub**

* Strengths: Solid exhibitor logistics, messaging & floorplan integration.

* Weaknesses: Not built for full procurement workflows.

* Opportunities: Could add RFP and payments support.

* Threats: Could be displaced by platforms offering complete sourcing.

#### **Reposite**

* Strengths: Focused RFP \+ quote \+ CRM workflow; measurable time & revenue impact.

* Weaknesses: Narrow focus; limited vendor pool.

* Opportunities: Expand into general events beyond travel.

* Threats: Consolidation pressure from larger provider acquisitions.

---

### **✅ Features & Software Analysis**

| Feature Category | Cvent | vFairs | EventHub | Reposite | YourEventMarketplace |
| ----- | ----- | ----- | ----- | ----- | ----- |
| AI‑powered Matching | ✔️ | ✖️ | ✖️ | ✖️ | ✖️ |
| RFP Creation & Management | ✔️ | ✖️ | ✖️ | ✔️ | ✖️ |
| Vendor Directory & Discovery | ✔️ (40K+) | ✔️ | ✔️ (exhibitor-focused) | ✔️ (Trips) | ✔️ |
| Quote Comparison | ✔️ | ✖️ | Partial | ✔️ | ✖️ |
| Payment & Invoices | ✔️ | ✖️ | ✔️ | Partial | ✖️ |
| Venue Sourcing | ✔️ | Partial | ✖️ | ✖️ | ✔️ |
| Exhibitor Tools & Logistics | ✔️ (through EventHub integration) | ✖️ | ✔️ | ✖️ | ✖️ |
| Mobile App / Messaging | ✔️ | ✖️ | ✔️ | ✖️ | ✖️ |

---

### **🛠 Competitive Summary**

* Cvent dominates in fully integrated sourcing and vendor management, but is best for enterprise-level needs.

* EventHub specializes in exhibitor/vendor logistics for trade shows and expos, with strong on-site capabilities.

* vFairs excels at digital exposure for virtual, hybrid, and physical events—great for visibility, not procurement.

* Reposite optimizes group travel/RFP processes with efficiency gains.

* YourEventMarketplace is a basic global directory with potential for enhancement.

---

### **🎯 Recommendations by Use Case**

* Enterprise-level procurement or frequent large-scale events → Cvent is the strongest option.

* Organizers of trade shows, expos, or physical events focused on exhibitors → EventHub is a good fit.

* Virtual/hybrid events aiming for visibility and sponsorship → vFairs Discover is ideal.

* Group event planners needing streamlined RFP workflow for travel → Reposite offers efficiency gains.

* Basic vendor discovery needed with no advanced sourcing tools → YourEventMarketplace covers directory-level searching.

---

### **Summary**

* Cvent Vendor Marketplace is a market leader in holistic vendor sourcing.

* Reposite and EventHub serve niche workflows (travel RFPs & exhibitor logistics).

* vFairs Discover focuses on exposure, not vendor procurement.

* YourEventMarketplace operates as a global directory, with room for upgrades.

Let me know if you’d like a deeper dive into pricing comparisons, vendor overlap, or recommendations for specific event types\!

 a Markdown file next?

\---

