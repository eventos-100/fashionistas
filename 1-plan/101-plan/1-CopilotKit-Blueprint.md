## 🔍 Comprehensive CopilotKit Master Research & Implementation Blueprint for I Love Medellín 📋

## Title and Purpose

**Title:** CopilotKit Blueprint Series for "I Love Medellín" AI-Powered Platform

**Purpose:** These documents form the foundational and phased technical strategy for implementing the CopilotKit AI assistant in the "I Love Medellín" platform. They guide developers in setting up AI-enhanced workflows for tourism, real estate, events, and restaurants using tools like Supabase, Pinecone, LangChain, and Stripe.

---


**1. Executive Summary & Business Case (5-10 pages)**
    * **1.1. Introduction & Vision for I Love Medellín:**
        * Brief overview of the platform, its verticals, and the Medellín market opportunity.
        * Strategic importance of AI and CopilotKit integration.
    * **1.2. CopilotKit: The AI Core for Enhanced User Experience & Operations:**
        * Key benefits of implementing CopilotKit.
        * How it addresses specific platform needs.
    * **1.3. CopilotKit ROI Projections (Summary):**
        * **Tours & Experiences:** Projected revenue uplift (e.g., AI Trip Planner conversion, dynamic pricing) & cost savings (e.g., automated guide coordination).
        * **Real Estate:** Projected revenue uplift (e.g., investment calculator leads, occupancy optimization) & cost savings (e.g., maintenance coordination, tenant screening).
        * **Event Management:** Projected revenue uplift (e.g., sponsor matching, dynamic ticketing) & cost savings (e.g., automated planning, vendor sourcing).
        * **Restaurant Bookings:** Projected revenue uplift (e.g., smart table optimization, menu recommendations) & cost savings (e.g., dynamic reservation management).
        * Overall projected ROI from automation (customer service, booking processes, marketing – referencing Phase 6.2).
    * **1.4. High-Level Implementation Timeline & Key Milestones:**
        * Summary of the 12-week plan (from Phase 7.1).
        * Critical path items.
    * **1.5. Resource Requirements Overview:**
        * Key personnel (development, AI, marketing, operations).
        * Technology stack costs summary (referencing details in Budget & Resource Planning doc).
    * **1.6. Risk Assessment Summary & Key Mitigation Strategies:**
        * Top 3-5 risks (technical, market, operational) and their primary mitigations (details in dedicated Risk Assessment doc).
    * **1.7. Competitive Advantages & Market Differentiation in Medellín:**
        * How CopilotKit and the integrated tech stack provide a unique selling proposition (USP).
        * Focus on hyper-localization for the Colombian market.
        * Enhanced stakeholder value propositions.
    * **1.8. Conclusion & Call to Action:**
        * Reiteration of the project's potential.
        * Next steps for project initiation.

**2. Technical Architecture Blueprint**
    * **2.1. System Overview & Guiding Principles:**
        * High-level diagram of "I Love Medellín" ecosystem.
        * Architectural principles (e.g., microservices vs. modular monolith, API-first, security by design, scalability).
    * **2.2. Component Breakdown & Integration Diagrams:**
        * **CopilotKit Architecture:** Frontend components, `CopilotBackend`, interaction with LangChain/LangGraph.
        * **Frontend (Webflow):** Role, CMS interaction, how it surfaces CopilotKit.
        * **Backend (Supabase):** Core services (Auth, Database, Storage, Edge Functions), real-time layer.
        * **AI Orchestration (LangChain & LangGraph):** Agent architecture, tool usage, stateful workflow management.
        * **Search (Pinecone):** Vector database integration for semantic search across verticals.
        * **Payments (Stripe Connect):** Marketplace payment flows, connected accounts, commission handling.
        * **Communication (WhatsApp Business API):** Integration pattern (via N8N or intermediary), message flow.
        * **Automation (N8N):** Role as an integration hub, example workflow patterns.
        * Detailed diagrams showing data flow between these components for key processes.
    * **2.3. Data Flow Patterns for Real-Time Operations:**
        * Live availability updates (Supabase Realtime -> Frontend/Copilot).
        * Real-time chat (User -> Copilot/Supabase Realtime -> Other User).
        * Dynamic pricing synchronization.
        * Notification delivery mechanisms.
    * **2.4. Security & Compliance Framework:**
        * **Authentication & Authorization:** Supabase Auth, Role-Based Access Control (RBAC) for Copilot actions and data.
        * **Data Security:** Supabase RLS, encryption at rest/transit, secure API key management, Pinecone data security.
        * **Payment Security:** Stripe Connect PCI compliance, secure handling of payment tokens.
        * **Compliance:** Colombian data protection laws (Habeas Data), GDPR considerations for international users.
        * **AI Ethics & Safety:** Guardrails for LLM interactions, bias detection considerations, data privacy in AI training/usage.
    * **2.5. Scalability & Performance Optimization Plans:**
        * Supabase scaling strategies (connection pooling, read replicas if/when supported, database optimization).
        * Scaling `CopilotBackend`, LangChain/LangGraph services (serverless functions, containerization).
        * Pinecone scaling.
        * N8N workflow optimization for high throughput.
        * Caching strategies (client-side, CDN, database, API).
        * Load balancing.
        * Monitoring and alerting for performance bottlenecks.

**3. Complete Implementation Checklist**
    * **3.1. Pre-Implementation Phase (Week 0):**
        * [ ] Finalize detailed requirements for each vertical MVP.
        * [ ] Secure all necessary API keys and accounts (Supabase, Stripe, Pinecone, Webflow, WhatsApp Business, N8N).
        * [ ] Setup version control (Git repository).
        * [ ] Define development, staging, and production environments.
        * [ ] Establish communication channels for the development team.
        * [ ] Legal review of data privacy and payment terms for Colombian market.
        * [Continue with 20+ specific infrastructure, access, and planning items]
    * **3.2. Phase 1 - Foundation (Week 1-2): Core Setup & Integrations (as per Phase 7.1)**
        * **CopilotKit Setup:**
            * [ ] Install CopilotKit frontend packages in Webflow project (or companion React app).
            * [ ] Implement basic Copilot chat UI.
            * [ ] Setup `CopilotBackend` service (e.g., Next.js API route or standalone Node.js app).
            * [ ] Define first `CopilotAction` and `useCopilotReadable`.
        * **Supabase Setup:**
            * [ ] Initialize Supabase project.
            * [ ] Implement `users`, `user_profiles`, `transactions`, `notifications`, `communication_logs`, `copilot_conversations` tables.
            * [ ] Configure Supabase Auth with email/password and potentially social logins.
            * [ ] Setup basic RLS policies for these core tables.
        * **LangChain Integration:**
            * [ ] Integrate LangChain into `CopilotBackend`.
            * [ ] Setup basic LLM connection (e.g., OpenAI).
            * [ ] Create a simple LangChain agent with one tool (the first `CopilotAction`).
        * **Stripe Connect (Sandbox):**
            * [ ] Implement OAuth flow for vendor Stripe account connection.
            * [ ] Store `stripe_connected_account_id` in `wallets` or `user_profiles`.
            * [ ] Test a direct charge to platform account (placeholder for marketplace).
        * [Continue with 30+ specific tasks covering all tech stack components from Phase 7.1]
    * **3.3. Phase 2 - First Vertical (Week 3-4): Tours & Experiences (as per Phase 7.1)**
        * **Supabase Schema:**
            * [ ] Implement `experiences`, `experience_availability`, `experience_bookings`, `experience_reviews` tables.
            * [ ] Define relationships and RLS.
        * **CopilotKit/LangChain Features:**
            * [ ] Develop `CopilotAction` for `search_tours(query, date, interests)`.
            * [ ] Develop `CopilotAction` for `check_tour_availability(tour_id, date, participants)`.
            * [ ] Develop `CopilotAction` for `initiate_tour_booking(tour_availability_id, user_id, participants)`.
            * [ ] Integrate Pinecone for semantic search on tour descriptions.
            * [ ] Implement basic AI Trip Planner prompts and logic.
        * [Continue with 25+ tasks for this vertical: Stripe integration, N8N notifications, Webflow content, testing]
    * **3.4. Phase 3 - Remaining Verticals & Stakeholder Onboarding (Week 5-8):**
        * Checklists for Real Estate, Event Management, Restaurant Bookings, mirroring the structure of Phase 2.
        * Checklist for stakeholder dashboard/Copilot features.
    * **3.5. Phase 4 - Optimization & Advanced Features (Week 9-12):**
        * Checklists for each enhancement area (Webflow CMS sync, WhatsApp full integration, LangGraph workflows, etc.).
    * **3.6. Post-Launch Checklist:**
        * [ ] Monitoring setup (performance, errors).
        * [ ] Feedback collection mechanisms.
        * [ ] Support team training.

**4. User Journey Documentation (40+ scenarios)**
    * **4.1. Introduction:** How to read the journey maps, legend for Copilot interactions.
    * **4.2. Tourist User Journeys (10 scenarios from Phase 3.1, detailed):**
        * For each journey (e.g., "Pre-Arrival Planning Journey"):
            * **User Goal:**
            * **Key Steps/Interactions:**
            * **CopilotKit Interventions:** (Specific prompts, actions triggered, information provided).
            * **Contextual Elements:** (What information CopilotKit uses from user/app state).
            * **Multi-language Example:** (Key phrases in Spanish/English).
            * **Error Handling/Fallback:** (e.g., "What if the tour is unavailable?").
            * **Success Outcome:**
    * **4.3. Local User Journeys (10 scenarios from Phase 3.2, detailed as above).**
    * **4.4. Host/Vendor User Journeys (10 scenarios from Phase 3.3, detailed as above).**
    * **4.5. Sponsor/Partner User Journeys (10 scenarios from Phase 3.4, detailed as above).**

**5. Code Implementation Examples**
    * **5.1. CopilotKit Frontend Integration (React/Webflow):**
        * Snippet for setting up `CopilotKit` provider.
        * Example of `useCopilotAction` definition in frontend.
        * Example of `useCopilotReadable` for providing context.
        * Basic chat UI component structure.
    * **5.2. CopilotKit Backend (`CopilotBackend` with LangChain):**
        * Example of a `CopilotAction` handler interacting with Supabase.
        * Basic LangChain agent setup with a CopilotAction as a tool.
        * Example of passing application context to the agent.
    * **5.3. Supabase Integration Snippets:**
        * JavaScript client examples for CRUD operations relevant to Copilot actions.
        * Example of a Supabase Edge Function triggered by DB event for N8N/Webflow sync.
        * RLS policy example for multi-tenant data access.
    * **5.4. LangGraph State Management Example:**
        * Conceptual Python/TypeScript snippet for a multi-step booking graph node.
    * **5.5. N8N Workflow Snippet (Conceptual JSON or screenshot):**
        * Example workflow: WhatsApp message -> LangChain agent -> Supabase update -> WhatsApp reply.
    * **5.6. Stripe Connect API Call Example (Backend Node.js/Python):**
        * Creating a destination charge.
        * Creating a Stripe connected account.
    * **5.7. Pinecone Integration Snippet:**
        * Upserting vectors after Supabase insert.
        * Querying Pinecone and fetching results from Supabase.
    * **5.8. Colombian Market Customization Examples:**
        * Date/time formatting for `America/Bogota`.
        * Currency formatting for COP.
        * Example of a bilingual prompt for LangChain.
    * **5.9. Security Implementation Patterns:**
        * Input validation for Copilot actions.
        * Error handling in backend API calls.
        * Securing webhook endpoints.

**6. Database Schema Specifications (Supabase)**
    * **6.1. Introduction:** Overview of schema design philosophy, naming conventions.
    * **6.2. Entity-Relationship Diagram (ERD):** Visual representation of all tables and their relationships.
    * **6.3. Core Common Table Definitions (from Phase 5.1):**
        * For each table (`users`, `user_profiles`, `transactions`, etc.):
            * Column Name | Data Type | Constraints (PK, FK, Unique, Not Null) | Description | RLS Considerations
    * **6.4. Tours & Experiences Vertical Table Definitions (from Phase 5.1):** (Same detail as above).
    * **6.5. Real Estate Vertical Table Definitions (from Phase 5.1):** (Same detail as above).
    * **6.6. Event Management Vertical Table Definitions (from Phase 5.1):** (Same detail as above).
    * **6.7. Restaurant Bookings Vertical Table Definitions (from Phase 5.1):** (Same detail as above).
    * **6.8. Indexing Strategy:**
        * Key columns to be indexed for performance (e.g., foreign keys, frequently queried fields, date fields for ranges).
        * Use of GIN indexes for array or JSONB columns.
    * **6.9. Real-time Subscription Patterns:**
        * Tables enabled for real-time.
        * Filters used for subscriptions (e.g., `user_id`, `booking_id`).
        * Data shaping for real-time payloads.
    * **6.10. Backup and Recovery Strategy Summary specific to schema.**

**7. Business Process Automation Maps (BPMN or similar diagrams)**
    * **7.1. Introduction:** How to read the process maps, symbols used.
    * **7.2. End-to-End User Booking Workflows (One for each vertical):**
        * Example: "Tourist Books a Coffee Tour via Copilot."
        * Diagram showing steps: User query -> Copilot -> LangChain (search, availability) -> Supabase -> Copilot (present options) -> User selection -> Copilot -> Stripe -> Supabase (confirm booking) -> N8N (notifications) -> User.
    * **7.3. Vendor/Host Onboarding Workflow:**
        * Registration -> Copilot assistance -> Supabase (profile creation) -> Stripe Connect onboarding -> Listing creation (Copilot assisted) -> Supabase (listing active).
    * **7.4. AI Recommendation Logic Flow (Conceptual):**
        * User context input -> Copilot -> LangChain/LangGraph -> Pinecone query -> Supabase data retrieval -> Filtering/Ranking logic -> Recommendation output.
    * **7.5. Commission Calculation and Payout Workflow:**
        * Booking confirmed -> Supabase (transaction logged) -> Stripe (payment processed, fee split) -> Supabase (wallet updated) -> Scheduled payout process (N8N/Supabase function) -> Stripe (transfer to vendor).
    * **7.6. Customer Service Escalation Procedure:**
        * User query to Copilot -> AI attempts resolution -> Escalation trigger (user request, repeated failure) -> N8N (create support ticket, notify human agent) -> Human agent takes over (communication via platform chat/Supabase).
    * **7.7. Content Update Workflow (Supabase to Webflow CMS):**
        * Admin updates data in Supabase -> Supabase Trigger/Webhook -> N8N -> Webflow API (update CMS item).

**8. Success Metrics & Analytics Framework (from Phase 7.2)**
    * **8.1. Introduction:** Importance of data-driven decisions.
    * **8.2. Key Performance Indicators (KPIs) - Detailed Definitions:**
        * User Engagement & Retention (DAU/MAU, Task Completion Rate, etc.).
        * Conversion Optimization (Lead-to-Booking, AOV, etc.).
        * Customer Satisfaction (NPS, CSAT).
        * Revenue Growth & Commission Capture (GMV, Platform Revenue, ARPU).
        * Operational Efficiency (Support Ticket Reduction, etc.).
        * For each KPI: Definition, Formula, Data Source (Supabase table/column, Stripe analytics), Target/Benchmark.
    * **8.3. Analytics Dashboards Concept:**
        * Mockups or descriptions of key dashboards (e.g., Platform Overview, Vertical Performance, Copilot Usage, Vendor Performance).
        * Tools for building dashboards (e.g., Supabase views, Retool/Appsmith, external BI tool).
    * **8.4. A/B Testing Framework for Optimization:**
        * Process for proposing, implementing, and analyzing A/B tests (e.g., for Copilot prompts, UI changes, pricing strategies).
        * Tools for A/B testing.
    * **8.5. Revenue Tracking and Attribution Models:**
        * How revenue is attributed to different channels or Copilot interactions.
        * Tracking commission flows accurately.
    * **8.6. Customer Satisfaction Measurement Systems:**
        * Implementation details for NPS/CSAT surveys (in-app, email).
        * Process for analyzing qualitative feedback.

**9. Risk Assessment (Detailed)**
    * **9.1. Introduction:** Methodology for risk identification and assessment (Likelihood/Impact).
    * **9.2. Technical Risks:**
        * Integration complexity (CopilotKit, LangChain, Supabase, Stripe, etc.).
        * AI model performance & reliability (hallucinations, bias).
        * Scalability issues.
        * Security vulnerabilities.
        * Third-party API dependency failures.
        * Data loss or corruption.
    * **9.3. Market Risks (Medellín/Colombia Focus):**
        * Competition (local and international).
        * Low adoption rates by users or vendors.
        * Changes in tourist behavior or regulations.
        * Economic downturn affecting tourism.
        * Negative PR or safety concerns in the region.
    * **9.4. Operational Risks:**
        * Inadequate customer support capacity.
        * Fraudulent activities (users or vendors).
        * Vendor quality control issues.
        * Reliance on N8N workflows failing.
        * Team capacity and skill gaps.
    * **9.5. Financial Risks:**
        * Higher than expected development/operational costs.
        * Slower than projected revenue growth.
        * Stripe Connect commission/payout errors.
        * Currency fluctuation risks (if handling multiple currencies extensively).
    * **9.6. Mitigation Strategies & Contingency Plans (Detailed for each identified risk):**
        * Proactive measures.
        * Reactive plans.
        * Responsible parties.

**10. Budget & Resource Planning (Detailed)**
    * **10.1. Development Costs:**
        * **Personnel:** (Based on Medellín market rates if local, or remote rates)
            * Full-stack Developers (React/Webflow, Node.js/Python for backend/AI)
            * AI/ML Engineer (LangChain, LangGraph, CopilotKit customization)
            * UX/UI Designer
            * QA Engineer
            * Project Manager/Product Owner
            * Estimated hours/months per role for initial 12-week build and first 6 months post-launch.
        * **Tools & Software:**
            * Webflow subscription.
            * Version control, project management tools.
            * Potentially paid N8N version if needed for scale/features.
    * **10.2. Infrastructure & API Costs (Monthly Estimates):**
        * **Supabase:** Tier based on usage (database size, API calls, concurrent users, Edge Functions).
        * **Pinecone:** Tier based on index size and queries.
        * **LLM API Costs:** OpenAI (or other provider) per token usage (estimate based on projected Copilot interactions).
        * **Stripe Connect:** Per-transaction fees.
        * **WhatsApp Business API:** Per-conversation fees (via provider like Twilio).
        * **Hosting:** For `CopilotBackend` and N8N if self-hosted and not on Supabase functions/cloud N8N.
        * Domain name, SSL certificates.
    * **10.3. Marketing & Launch Costs:**
        * Pre-launch buzz generation (social media, local influencers in Medellín).
        * Launch event/promotions.
        * Digital advertising budget (Google Ads, social media ads targeting tourists & locals).
        * Content creation (blog posts, videos).
    * **10.4. Ongoing Operational Costs (Post-Launch Monthly):**
        * Customer support team (if AI escalation requires significant human intervention).
        * Platform maintenance and updates (personnel).
        * Content moderation and vendor management.
        * Continued marketing and user acquisition.
    * **10.5. Proposed Team Structure & Roles (Initial & Growth):**
        * Lean initial team for MVP.
        * Scaling plan for the team as the platform grows.
    * **10.6. Funding Request Summary (If applicable):**
        * Total estimated cost for first year.
        * Breakdown of how funds will be used.
    * **10.7. Assumptions made in budget calculations.**

## Summary / Executive Overview

This multi-part blueprint outlines how CopilotKit integrates with Supabase, LangChain, Pinecone, and other tools to enable smart, real-time, AI-powered features across several business verticals. From schema design and dynamic pricing to commission optimization and conversational AI, each phase builds on the previous to support autonomous operations.

Key goals include: full-cycle AI automation, semantic search integration, real-time availability sync, and dynamic revenue strategies. The project targets automation for booking, recommendations, payment, support, and notifications across all platform features.

---

## Table of Contents

1. Title and Purpose
    
2. Summary / Executive Overview
    
3. Table of Contents
    
4. Key Features / Capabilities
    
5. Step-by-Step Implementation
    
6. Real-World Use Cases
    
7. Architecture & Workflows
    
8. Tools & Integrations
    
9. Best Practices & Tips
    
10. Glossary / Definitions
    
11. Data Examples / Code Snippets
    
12. Frequently Asked Questions (FAQs)
    

---

## Key Features / Capabilities

- **Full Supabase schema blueprint** for users, experiences, bookings, wallets, transactions, events, restaurants, and more.
    
- **Pinecone vector DB integration** for semantic search of experiences, events, and properties.
    
- **Real-time updates** using Supabase Realtime (availability, chat, pricing).
    
- **AI-powered commissions** using dynamic pricing models.
    
- **LangChain Copilot actions** for booking, searching, recommending.
    
- **Stripe Connect** for multi-vendor payments.
    
- **Collaborative planning** features (shared itineraries, AI-guided decision-making).
    

---

## Step-by-Step Implementation

1. Set up Supabase project with required schemas (Phase 5.1).
    
2. Integrate Pinecone and create embeddings for searchable content.
    
3. Connect LangChain to `CopilotBackend` and build actions.
    
4. Configure Stripe Connect for payment flows.
    
5. Use Supabase Realtime for updates and notifications.
    
6. Build collaborative planning features using real-time subscriptions.
    
7. Deploy and monitor performance, real-time sync, and Copilot interaction.
    

---

## Real-World Use Cases

- 🎯 **Tourist searches for a family-friendly activity** → 🛠️ Copilot uses semantic search with Pinecone to match preferences → 💡 Recommends Parque Arví Nature Walk
    
- 🎯 **Host manages multiple bookings** → 🛠️ Real-time Supabase subscriptions update availability → 💡 Prevents overbooking and improves user satisfaction
    
- 🎯 **Admin wants to adjust commissions for top performers** → 🛠️ Copilot suggests new tiers based on sales performance → 💡 Boosts revenue and retention
    

---

## Architecture & Workflows

- **Frontend:** Webflow or React UI with CopilotKit chat UI
    
- **Backend:** Node.js API or Next.js CopilotBackend
    
- **AI Layer:** LangChain and LangGraph for orchestrating agents and tools
    
- **Database:** Supabase with real-time sync
    
- **Vector DB:** Pinecone for semantic embeddings
    
- **Payments:** Stripe Connect for vendor payouts
    
- **Automation:** n8n for webhook-driven flows (e.g., WhatsApp, notifications)
    

---

## Tools & Integrations

- **Supabase:** Auth, DB, Edge Functions, Realtime, Storage
    
- **Pinecone:** Embedding search engine
    
- **LangChain:** CopilotKit integration, LLM orchestration
    
- **Stripe Connect:** Multi-party payments
    
- **Webflow:** CMS + UI
    
- **n8n:** Automation platform
    
- **OpenAI:** Embedding + chat LLM models
    

---

## Best Practices & Tips

**Do:**

- Use JSONB for flexible schema fields
    
- Index key columns for performance
    
- Keep embeddings updated with every content change
    
- Use LangChain Copilot actions with clear input/output formats
    

**Don't:**

- Avoid overloading Copilot with long responses
    
- Don’t allow unauthenticated Copilot access to sensitive actions
    

---

## Glossary / Definitions

- **Vector DB:** A database for similarity search on numerical representations of content
    
- **Embedding:** Numerical representation of text for semantic comparison
    
- **Semantic Search:** Retrieves meaning-alike content, not just keyword matches
    
- **CopilotKit:** AI toolkit enabling contextual assistants in apps
    
- **LangChain:** LLM orchestration library for building agent workflows
    

---

## Data Examples / Code Snippets

```
{
  "title": "Parque Arví Nature Walk",
  "description": "Wildlife spotting with picnic areas",
  "tags": ["family", "outdoors", "nature"],
  "vector_embedding": [0.12, 0.83, 0.45, ...]
}
```

```
const copilotAction = defineCopilotAction({
  name: "search_tours",
  inputSchema: z.object({ query: z.string(), date: z.string() }),
  handler: async ({ query }) => {
    const vector = await embedText(query);
    const results = await pinecone.query(vector);
    return results;
  },
});
```

---

## Frequently Asked Questions (FAQs)

**Q: How does CopilotKit know what to recommend?**  
A: It uses LangChain tools, semantic embeddings, and user preferences to generate personalized results.

**Q: What happens if prices change in real-time?**  
A: Supabase Realtime updates sync data across clients and the Copilot interface.

**Q: How is vector search used?**  
A: Copilot embeds queries and searches the Pinecone vector DB for similar content.

**Q: Can users chat with vendors?**  
A: Yes. Real-time chat features enable users to talk to vendors or Copilot via subscriptions.

**Q: Is this secure and scalable?**  
A: Yes. It uses Supabase RLS, Stripe PCI-compliant flows, and scalable architecture (LangChain, Pinecone, n8n).



**Master Research Directive**

This document presents an exhaustive research and implementation blueprint for integrating CopilotKit into the "I Love Medellín" multi-vertical tourism platform. It leverages extensive web research to provide comprehensive, actionable insights across all platform verticals and stakeholder types, focusing on revenue generation and optimization for the Colombian market.

**🎯 Platform Overview Context**

"I Love Medellín" is a comprehensive marketplace serving four equal-priority verticals: Tours & Experiences, Real Estate, Event Management, and Restaurant Bookings. The technical stack includes Webflow, Supabase, Stripe Connect, WhatsApp Business API, N8N, LangChain, LangGraph, and Pinecone.

---

## 🚀 Comprehensive Research Framework

### Phase 1: CopilotKit Foundation & Advanced Features Research

CopilotKit is an open-source framework for building in-app AI copilots. It allows developers to integrate AI-powered features directly into their applications, providing contextual assistance and automating complex tasks.

**1.1 Core Platform Capabilities**

* **CopilotKit Architecture and Contextual AI Principles:**
    * **Architecture:** CopilotKit typically consists of a frontend component (React, Vue, etc.) that interacts with a backend. The frontend captures user interactions and application context, sending it to the backend where AI logic (often involving LLMs like GPT) processes the information and suggests actions or provides insights. It uses a `CopilotTask` abstraction to define tasks the AI can perform and `useCopilotAction` to make application-specific actions available to the AI.
    * **Contextual AI Principles:** The core idea is to provide the AI with relevant context from the application's current state (e.g., open tabs, selected items, user profile) and user's intent. This allows the AI to offer highly relevant and personalized assistance, rather than generic responses. Context can be passed explicitly through props or implicitly gathered by the CopilotKit frontend libraries.
    * **Key Components:**
        * **`CopilotKit` (Frontend):** Provides hooks and components to integrate AI chat functionalities directly into the UI. It manages the communication with the backend.
        * **`CopilotBackend` (Backend):** Handles requests from the frontend, interacts with LLMs (e.g., via LangChain), and orchestrates actions. It can execute application-specific logic (tools/actions).
        * **Actions/Tools:** Functions that the AI can invoke to perform operations within the application (e.g., book a tour, update a Supabase table, call Stripe API).

* **Latest 2024-2025 Features and Enterprise Capabilities:**
    * **Enhanced Context Management:** More sophisticated ways to gather and provide context to the AI, potentially including real-time DOM element analysis or application state observation.
    * **Improved Tooling and Agentic Capabilities:** Better support for defining complex tools, chaining them together, and allowing the AI to autonomously decide which tools to use (agent-like behavior).
    * **Multi-Modal Support:** Potential for handling image, voice, or other input types beyond text.
    * **Enterprise Features (General Trends, check official docs for specifics):**
        * **Role-Based Access Control (RBAC):** Defining what actions different user types or AI copilots can perform.
        * **Audit Trails & Logging:** Tracking AI interactions and actions for security and debugging.
        * **Scalability Enhancements:** Optimizations for handling a large number of concurrent users and AI requests.
        * **Advanced Analytics:** Insights into copilot usage, popular features, and areas for improvement.
        * **Team Collaboration Features:** Tools for teams to build and manage copilots.

* **Integration Patterns with React/Next.js/Supabase Ecosystems:**
    * **React/Next.js:** CopilotKit offers React components and hooks (`useCopilotReadable`, `useCopilotAction`, `CopilotTask`) for seamless integration. Next.js can be used for both the frontend (app router or pages router) and the backend (API routes for `CopilotBackend`).
    * **Supabase:**
        * **Data Source:** Supabase tables can serve as the primary data source for contextual information provided to the Copilot.
        * **Actions Backend:** Copilot actions can directly interact with Supabase (CRUD operations, calling Postgres functions) using the Supabase JavaScript client.
        * **Real-time:** Supabase's real-time capabilities can be leveraged to update the Copilot's context or trigger actions based on database changes.
        * **Authentication:** Supabase Auth can be used to secure Copilot actions and personalize experiences.

* **Multi-Tenant and Marketplace-Specific Implementations:**
    * **Multi-Tenancy:** CopilotKit actions and context need to be tenant-aware. This involves:
        * Ensuring data isolation when fetching context or executing actions (e.g., a host's copilot only accesses their listings).
        * Potentially different configurations or available actions per tenant.
        * Supabase Row Level Security (RLS) is crucial here.
    * **Marketplace:** The copilot can assist different sides of the marketplace:
        * **Consumers (Tourists, Buyers):** Finding products/services, making bookings, getting support.
        * **Providers (Hosts, Vendors):** Managing listings, optimizing pricing, communicating with customers.
        * The copilot's available tools and context will differ based on the user's role.

* **Real-time Collaboration and Context-Sharing Features:**
    * **Shared Sessions:** For features like group trip planning, CopilotKit could potentially be extended to allow multiple users to interact with the same AI copilot instance or share context.
    * **Real-time Updates:** When one user's action (e.g., booking a slot) impacts another's context (e.g., availability), the copilot's suggestions should update in real-time, likely leveraging Supabase real-time subscriptions.
    * **Example:** A group planning a tour could collectively interact with an AI trip planner, with each member's preferences and constraints being considered by the AI in real-time.

**1.2 Advanced Integration Research**

* **LangChain Integration:**
    * **Agent Orchestration Patterns:** CopilotKit's backend can use LangChain agents (e.g., ReAct, Conversational Agents) to manage complex interactions. The tools provided to the LangChain agent would be the `CopilotAction`s defined in the application.
    * **Tool Calling:** LangChain's tool usage capabilities align perfectly with CopilotKit's actions. The LLM decides which tool (action) to call based on user input and context.
    * **Memory Management:** LangChain provides various memory modules (e.g., `ConversationBufferMemory`) to maintain conversation history, which is crucial for contextual understanding in multi-turn dialogues. This memory can be persisted (e.g., in Supabase) for longer-term user context.

* **LangGraph Integration:**
    * **Complex Workflow Automation:** LangGraph is ideal for defining stateful, multi-step AI workflows with cycles and conditional logic. This can be used for processes like complex booking sequences, guided onboarding, or troubleshooting flows initiated by the Copilot.
    * **Decision Trees & State Management:** LangGraph allows building graph-based flows where nodes represent processing steps (LLM calls, tool executions) and edges represent transitions based on conditions. This is more powerful than simple chains for sophisticated decision-making.
    * **Example:** A user asks the copilot to "plan a weekend trip." This could trigger a LangGraph flow that asks clarifying questions, searches for options, presents choices, and handles booking – all managed as a graph of states and transitions.

* **Webflow Integration:**
    * **Dynamic Content Manipulation:** While CopilotKit itself doesn't directly manipulate Webflow DOM, its actions can trigger backend processes that update Webflow CMS items via the Webflow API. N8N could act as an intermediary.
    * **CMS Synchronization:** Copilot actions could update Supabase, and an N8N workflow could listen to Supabase changes (or be triggered by an action) to update the Webflow CMS, ensuring data consistency.
    * **Form Handling:** CopilotKit could assist users in filling out Webflow forms by pre-filling information or guiding them through complex forms. Form submissions can trigger Copilot actions or LangGraph workflows.

* **WhatsApp Integration:**
    * **Conversational AI Flows:** The AI logic built with CopilotKit, LangChain, and LangGraph can be exposed via WhatsApp. An intermediary service (e.g., N8N or a custom Node.js app using the WhatsApp Business API) would translate WhatsApp messages to Copilot backend requests and send responses back.
    * **Message Templates:** Use pre-approved WhatsApp templates for notifications (booking confirmations, reminders) triggered by Copilot actions.
    * **Business API Patterns:** User queries from WhatsApp can initiate Copilot tasks. The "I Love Medellín" backend, incorporating CopilotKit's logic, would process these and respond via the WhatsApp API.

* **Stripe Integration:**
    * **Payment Processing:** Copilot actions can initiate payments, create checkout sessions, or manage subscriptions through Stripe API calls from the backend. For a marketplace, Stripe Connect will be used.
    * **Subscription Management:** Users could ask the copilot to "upgrade my subscription" or "cancel my plan," triggering the relevant Stripe API calls via a defined `CopilotAction`.
    * **Marketplace Transactions:** For Stripe Connect, actions would involve creating connected accounts, processing payments with platform fees, and managing payouts to vendors/hosts. These actions must be securely implemented in the backend.

**1.3 Multi-Language & Localization**

* **Spanish-English Bilingual Context Switching:**
    * The Copilot's LLM needs to be proficient in both Spanish and English.
    * The frontend should detect or allow users to set their preferred language.
    * Context passed to the Copilot (e.g., UI text, user data) should ideally be available in the user's language or be translatable.
    * LangChain prompts should be designed to handle or switch languages. LLMs like GPT-4 are generally good at this, but explicit prompting for language can improve reliability.
    * User input language should be detected, and responses should be in the same language.

* **Colombian Market Cultural Adaptation:**
    * **Tone and Formality:** Use appropriate levels of formality (e.g., "usted" vs. "tú" depending on context and branding). Medellín is generally informal ("vos" or "tú").
    * **Local Slang/Expressions (Use with caution):** While understanding local nuances is good, overusing slang can seem unprofessional. The AI should understand common paisa phrases if users use them but respond in clear, neutral Spanish or English.
    * **Cultural References:** Incorporate relevant local festivals, landmarks, and customs in suggestions and content, where appropriate.
    * **Business Etiquette:** Understand local business hours, negotiation styles (if applicable for real estate/event sponsorship).

* **Local Payment Method Integration (PSE, Efecty, Nequi):**
    * Stripe supports some local payment methods in Latin America. Research Stripe's current support for PSE, Efecty, and Nequi in Colombia.
    * If direct Stripe support is limited, alternative payment gateways popular in Colombia might be needed, and Copilot actions would integrate with their APIs. N8N could also facilitate these integrations.
    * The Copilot could guide users through selecting and using these payment methods.

* **Regional Timezone and Business Hours Handling:**
    * All date/time operations must be timezone-aware (America/Bogota).
    * Copilot suggestions (e.g., for restaurant bookings, tour availability) must respect local business hours and holidays.
    * Supabase should store timestamps in UTC and convert to local time for display.

* **Mobile-First Optimization for Latin American Networks:**
    * Copilot interactions should be lightweight. Minimize data transfer for chat interfaces.
    * Prioritize fast response times, even on potentially slower mobile networks. This might involve optimizing LLM prompt verbosity and backend processing.
    * Webflow frontend must be highly responsive.
    * Consider progressive web app (PWA) features for better offline access or faster loading if applicable.

---

### Phase 2: Vertical-Specific Use Cases & Features (10 Each)

**2.1 Tours & Experiences Vertical**

* **AI Trip Planner:**
    * **Use Case:** User inputs interests (e.g., "history, coffee, nature"), duration, budget, and travel style (e.g., "relaxed," "adventure-packed"). CopilotKit, using LangChain, crafts a personalized itinerary drawing from Supabase's experience catalog, checking real-time availability.
    * **Copilot Action:** `create_itinerary(preferences, dates, budget)`
* **Real-time Guide Coordination:**
    * **Use Case:** A tourist is running late for a tour. They message the Copilot: "I'm running 15 mins late for the Comuna 13 tour." Copilot notifies the guide via WhatsApp (through N8N) and provides the tourist with updated instructions or meeting points.
    * **Copilot Action:** `notify_guide(tour_id, user_id, message)`
* **Group Booking Assistant:**
    * **Use Case:** User wants to book a tour for a group of 5 with varying dietary needs for a food tour. Copilot collects preferences from each member (perhaps via a shared link/interface) and finds suitable options, then facilitates payment splitting via Stripe.
    * **Copilot Action:** `coordinate_group_booking(tour_id, group_size, preferences_list)`
* **Weather-Adaptive Recommendations:**
    * **Use Case:** It starts raining heavily. User asks Copilot: "My outdoor walking tour might be rained out. What else can I do today?" Copilot checks real-time weather (via an API integrated as a LangChain tool) and suggests indoor activities or rescheduled tours.
    * **Copilot Action:** `suggest_weather_alternative(current_activity_id, location)`
* **Cultural Context Educator:**
    * **Use Case:** While on a self-guided tour using an AR feature in the app, the user points their camera at a monument. The Copilot provides historical context, cultural significance, and interesting facts. (Requires image recognition model integrated with CopilotKit).
    * **Copilot Action:** `explain_landmark(landmark_name_or_image_embedding)`
* **Emergency Assistance Coordinator:**
    * **Use Case:** Tourist feels unwell during a hike. They activate an "SOS" via the Copilot. Copilot shares their location (with permission) with emergency contacts (pre-defined or local emergency services via an N8N workflow), and provides basic first-aid guidance if possible.
    * **Copilot Action:** `trigger_emergency_protocol(user_id, location, issue_description)`
* **Photo-to-Experience Matcher:**
    * **Use Case:** User uploads a photo of a colorful street art display they saw online. Copilot uses a vision model (integrated with LangChain) to analyze the photo and suggests similar street art tours or locations in Medellín from the Supabase catalog.
    * **Copilot Action:** `find_similar_experience_from_image(image_data)`
* **Budget Optimizer:**
    * **Use Case:** User states, "I have $50 COP left for an activity today." Copilot searches the experience catalog for options within that budget, considering location and user preferences.
    * **Copilot Action:** `find_experiences_in_budget(max_price, preferences)`
* **Language Barrier Assistant:**
    * **Use Case:** Tourist needs to ask for directions from a local who doesn't speak English. Copilot provides real-time voice or text translation for simple phrases.
    * **Copilot Action:** `translate_phrase(text, target_language)`
* **Experience Difficulty Assessor:**
    * **Use Case:** User is interested in a hike but unsure if it matches their fitness level. Copilot asks clarifying questions (e.g., "How often do you exercise? Can you walk 5km comfortably?") and compares against the hike's difficulty rating and user reviews in Supabase.
    * **Copilot Action:** `assess_experience_fit(experience_id, user_fitness_info)`

**Supabase Requirements Research (Tours & Experiences):**

* **Experience Catalog Schema:** `experiences` (id, name_en, name_es, description_en, description_es, category, location_lat, location_lon, duration, price, difficulty_level, includes_en, includes_es, what_to_bring_en, what_to_bring_es, guide_id, images_urls, video_url, tags, cancellation_policy_id, capacity). Vector embeddings of descriptions/tags for Pinecone.
* **Real-time Availability Tracking Tables:** `experience_availability` (id, experience_id, start_time, end_time, available_slots, booked_slots, status). `bookings` (id, user_id, experience_availability_id, num_participants, booking_time, status, total_price, payment_id).
* **Guide Assignment and Coordination System:** `guides` (id, user_id, name, bio_en, bio_es, languages_spoken, certifications, contact_info, current_assignment_id). `guide_assignments` (id, guide_id, experience_availability_id, status).
* **Review and Rating Aggregation Patterns:** `reviews` (id, user_id, experience_id, rating, comment, review_time, language, is_flagged). Aggregate ratings on `experiences` table (avg_rating, num_reviews).
* **Dynamic Pricing Calculation Tables:** `pricing_rules` (id, experience_id, condition_type [e.g., 'season', 'day_of_week', 'group_size'], condition_value, price_adjustment_type ['percentage', 'fixed'], adjustment_value, start_date, end_date).

**2.2 Real Estate Vertical**

* **Property Investment Calculator:**
    * **Use Case:** User asks Copilot: "Analyze the investment potential of property ID 123, assuming a 20% down payment and current mortgage rates." Copilot fetches property data, market trends from Supabase/external API, calculates estimated ROI, cash flow, and appreciation.
    * **Copilot Action:** `calculate_property_roi(property_id, down_payment_percentage, loan_parameters)`
* **AI-Narrated Virtual Property Tour Guide:**
    * **Use Case:** While a user views a 3D property tour, Copilot provides contextual narration: "This living room faces east, getting great morning light. The average utility cost for similar units is X. Notice the upgraded flooring."
    * **Copilot Action:** `get_property_feature_narration(property_id, current_tour_section)`
* **Neighborhood Lifestyle Matcher:**
    * **Use Case:** User says, "I want a quiet neighborhood, good for families, with parks and cafes, budget $X for rent." Copilot queries Supabase for neighborhoods matching these criteria (using tags, scores, amenities data) and suggests relevant property listings.
    * **Copilot Action:** `match_neighborhood_to_lifestyle(preferences, budget)`
* **Lease Negotiation Assistant:**
    * **Use Case:** User is reviewing a lease draft. Copilot can highlight standard vs. non-standard clauses, explain legal jargon in simple terms (based on pre-loaded Colombian rental law info), and suggest points for negotiation based on market norms.
    * **Copilot Action:** `analyze_lease_document(document_text_or_url, user_role)`
* **Maintenance Request Coordinator:**
    * **Use Case:** Tenant messages Copilot: "My tap is leaking in apartment 4B." Copilot creates a maintenance ticket in Supabase, notifies the property manager, and can even suggest preferred local plumbers from a vendor list, potentially scheduling them via N8N.
    * **Copilot Action:** `submit_maintenance_request(property_id, issue_description, tenant_id, urgency)`
* **Tenant Screening Assistant:**
    * **Use Case:** Property manager asks Copilot to "summarize applications for property 789 that meet income criteria of 3x rent." Copilot processes applications in Supabase, flags suitable candidates, and can draft initial communication. (Ensure compliance with data privacy laws).
    * **Copilot Action:** `screen_tenant_applications(property_id, screening_criteria)`
* **Market Comparison Engine:**
    * **Use Case:** User wants to know the fair market value for a 2-bedroom apartment in El Poblado. Copilot queries Supabase listings (active and sold) and external market data (if available) to provide a comparable market analysis (CMA).
    * **Copilot Action:** `generate_cma(property_type, neighborhood, bedrooms, bathrooms, size_sqm)`
* **Occupancy Optimization Assistant:**
    * **Use Case:** For short-term rentals, a host asks Copilot: "Suggest pricing for my apartment for next month to maximize occupancy and revenue." Copilot analyzes demand patterns, local events, competitor pricing (from Supabase/external data) and suggests dynamic pricing.
    * **Copilot Action:** `recommend_short_term_rental_pricing(property_id, date_range)`
* **Legal Compliance Checker (Basic):**
    * **Use Case:** A new landlord asks, "What are the key documents I need for a long-term rental in Medellín?" Copilot provides a checklist based on Colombian real estate law (information sourced and vetted by legal professionals, stored in a knowledge base accessible by LangChain).
    * **Copilot Action:** `get_rental_compliance_checklist(property_type, region)`
* **Property Portfolio Manager (Summary):**
    * **Use Case:** Investor with multiple properties asks Copilot: "Show me the overall performance of my real estate portfolio this quarter." Copilot aggregates data from Supabase (income, expenses, occupancy per property) and presents a summary dashboard or report.
    * **Copilot Action:** `summarize_portfolio_performance(investor_id, period)`

**Supabase Requirements Research (Real Estate):**

* **Property Listing Schema:** `properties` (id, type [sale, rent_short, rent_long], address, neighborhood_id, lat, lon, price, currency, bedrooms, bathrooms, area_sqm, description_en, description_es, features_list, images_urls, video_url, status [available, rented, sold], owner_id, year_built, strata_level, admin_fee, property_tax). Vector embeddings for descriptions.
* **Tenant Application and Verification Workflows:** `rental_applications` (id, property_id, user_id, application_data_json, status [pending, approved, rejected], submission_date). `tenant_verifications` (id, application_id, document_type, document_url, verification_status).
* **Maintenance Request Tracking Systems:** `maintenance_requests` (id, property_id, tenant_id, reported_by_user_id, description, image_urls, status [open, in_progress, resolved, cancelled], priority, assigned_vendor_id, creation_date, resolution_date).
* **Financial Analytics and Revenue Optimization:** `property_finances` (id, property_id, transaction_type [income, expense], category, amount, currency, date, description, associated_booking_id). Tables for market data, occupancy rates.
* **Legal Document Storage and Versioning:** `legal_documents` (id, property_id, document_type [lease, title, etc.], document_url, version, upload_date, associated_user_id). Secure storage, potentially using Supabase Storage with access controls.

**2.3 Event Management Vertical**

* **Automated Event Planner (Initial Draft):**
    * **Use Case:** User: "Help me plan a tech meetup for 50 people in Medellín." Copilot asks clarifying questions (budget, preferred dates, type of venue, A/V needs) and generates a preliminary plan including venue suggestions, vendor categories needed, and a draft timeline.
    * **Copilot Action:** `draft_event_plan(event_type, expected_attendees, budget_range, date_preferences, desired_features)`
* **Sponsor Matching Engine:**
    * **Use Case:** Event organizer: "Find potential sponsors for my upcoming sustainability conference." Copilot analyzes event details and attendee demographics (from Supabase) and matches them with a database of potential sponsors and their interests.
    * **Copilot Action:** `find_potential_sponsors(event_id, sponsor_criteria)`
* **Dynamic Ticket Pricing Assistant:**
    * **Use Case:** "Ticket sales for the early bird phase are slow. Should I adjust pricing?" Copilot analyzes sales velocity, remaining capacity, time until event, and market benchmarks to suggest pricing adjustments or promotional offers.
    * **Copilot Action:** `recommend_ticket_price_adjustment(event_id, current_sales_data)`
* **Attendee Experience Personalizer:**
    * **Use Case:** During a multi-track conference, an attendee asks Copilot: "What sessions are relevant to AI in marketing and are happening now or next?" Copilot checks the event schedule, session tags, and attendee's pre-stated interests to provide personalized recommendations.
    * **Copilot Action:** `recommend_event_sessions(attendee_id, current_time, interests)`
* **Vendor Coordination Hub (Assistant):**
    * **Use Case:** Event planner: "Get quotes from three catering vendors for 100 people, buffet style, for event ID 456." Copilot can draft outreach messages (using templates) and log responses, or integrate with N8N to automate sending emails to vendors in Supabase.
    * **Copilot Action:** `initiate_vendor_quoting(event_id, vendor_category, requirements, vendor_ids_list)`
* **Live Event Assistant:**
    * **Use Case:** Attendee at a large festival asks Copilot: "Where is the main stage?" or "When does [Artist X] play?" Copilot uses event map data and schedule from Supabase to provide instant answers.
    * **Copilot Action:** `get_live_event_info(event_id, query_type, query_details)`
* **ROI Prediction Engine (Basic):**
    * **Use Case:** "Estimate the potential ROI for a 2-day workshop with 30 attendees at $200 ticket price, with estimated costs of $X for venue and $Y for marketing." Copilot uses a simple model based on this data to provide a rough ROI forecast.
    * **Copilot Action:** `predict_event_roi(ticket_price, expected_attendees, estimated_costs)`
* **Capacity Management System (Alerts):**
    * **Use Case:** Copilot monitors real-time check-in data (from Supabase, updated by on-site scanners). If a specific zone or the overall event approaches capacity limits, it alerts the event manager.
    * **Copilot Action:** (Passive monitoring triggering alerts, or) `check_event_capacity_status(event_id, zone_id)`
* **Social Media Campaign Generator (Ideas):**
    * **Use Case:** Event marketer: "Suggest some engaging social media posts for our upcoming food festival." Copilot generates ideas for posts, relevant hashtags, and call-to-actions based on event details and target audience.
    * **Copilot Action:** `generate_social_media_post_ideas(event_id, platform)`
* **Post-Event Analytics Processor (Summary):**
    * **Use Case:** "Summarize the feedback and key metrics for Event XYZ." Copilot processes attendee feedback (from surveys in Supabase), ticket sales data, and engagement metrics to provide a concise post-event report.
    * **Copilot Action:** `summarize_post_event_analytics(event_id)`

**Supabase Requirements Research (Event Management):**

* **Event Planning Workflow Tables:** `events` (id, name_en, name_es, description_en, description_es, event_type, start_date, end_date, venue_id, organizer_user_id, status [planning, active, completed, cancelled], budget, expected_attendees, images_urls). `event_tasks` (id, event_id, task_name, due_date, assigned_to_user_id, status).
* **Ticketing System:** `ticket_tiers` (id, event_id, name, price, currency, quantity_available, quantity_sold, sales_start_date, sales_end_date). `event_bookings` or `tickets_sold` (id, event_id, ticket_tier_id, user_id, purchase_date, qr_code, check_in_status).
* **Sponsor Relationship Management:** `sponsors` (id, company_name, contact_person_id, contact_email, sponsorship_level_id, event_id, contract_url, amount_paid). `sponsorship_packages` (id, event_id, name, price, benefits_description).
* **Vendor Coordination and Payment Processing:** `event_vendors` (id, event_id, vendor_service_type_id [e.g., catering, AV], company_name, contact_info, agreed_price, payment_status, contract_url).
* **Attendee Engagement and Feedback Collection Systems:** `event_attendees` (id, event_id, user_id, registration_date, interests_tags). `event_feedback` (id, event_id, user_id, rating, comments, submission_date). `session_check_ins` (id, session_id, user_id, timestamp).

**2.4 Restaurant Bookings Vertical**

* **Smart Table Optimizer:**
    * **Use Case:** Restaurant manager: "Optimize table assignments for tonight's reservations to minimize wait times and maximize seating." Copilot analyzes reservations, table configurations, and typical turn times to suggest an optimal seating plan.
    * **Copilot Action:** `optimize_table_assignments(restaurant_id, date, time_slot, reservations_list, table_layout)`
* **Menu Recommendation Engine:**
    * **Use Case:** Customer using the app: "I'm vegetarian and love spicy food. What do you recommend at [Restaurant Name]?" Copilot filters the menu (from Supabase) based on dietary tags and potentially uses popularity data or past user ratings.
    * **Copilot Action:** `recommend_menu_items(restaurant_id, dietary_restrictions_list, preferences_list)`
* **Dynamic Reservation Manager:**
    * **Use Case:** "Can I get a table for 2 at 7 PM tonight?" Copilot checks real-time availability in Supabase. If full, it suggests alternative times or adds the user to a smart waitlist, notifying them if a table opens up.
    * **Copilot Action:** `manage_reservation_request(restaurant_id, party_size, requested_datetime, user_preferences)`
* **Group Dining Coordinator:**
    * **Use Case:** User: "Book a table for 8 for a birthday dinner next Friday. We'll need a cake." Copilot checks availability for large parties, notes the special request, and can even suggest restaurants with pre-order cake options or alert the restaurant.
    * **Copilot Action:** `coordinate_group_dining(restaurant_id, party_size, requested_datetime, special_requests_list)`
* **Loyalty Points Calculator & Suggester:**
    * **Use Case:** After a meal, Copilot tells the user: "You've earned 50 points for this meal! You now have 450 points. Redeem 500 points for a free dessert on your next visit?"
    * **Copilot Action:** `calculate_and_suggest_loyalty_redemption(user_id, transaction_amount, restaurant_id)`
* **Special Occasion Planner (Restaurant focus):**
    * **Use Case:** "I want to book a romantic dinner for an anniversary." Copilot suggests restaurants with suitable ambiance, allows noting the occasion for the restaurant, and might suggest add-ons like flowers or specific tables if offered.
    * **Copilot Action:** `plan_special_occasion_meal(occasion_type, restaurant_preferences, date, party_size)`
* **Kitchen Coordination Assistant (Simplified):**
    * **Use Case:** For pre-orders via the app: Copilot could relay pre-order details to the kitchen (via an N8N integration to a kitchen display system or printer), optimizing timing based on the reservation time.
    * **Copilot Action:** `send_preorder_to_kitchen(reservation_id, order_items, preparation_notes)`
* **Dietary Restriction Navigator:**
    * **Use Case:** User with a severe nut allergy: "Show me all dishes at [Restaurant] that are guaranteed nut-free." Copilot queries the menu, specifically looking at detailed allergen information provided by the restaurant and stored in Supabase.
    * **Copilot Action:** `filter_menu_by_allergen(restaurant_id, allergen_list)`
* **Revenue Optimization Assistant (Restaurant):**
    * **Use Case:** Restaurant manager: "Which menu items are most profitable and popular this month?" Copilot analyzes sales data and food cost data (if available in Supabase) to highlight high-performers and suggest promotions for less popular but profitable items.
    * **Copilot Action:** `analyze_menu_item_performance(restaurant_id, period)`
* **Customer Feedback Analyzer:**
    * **Use Case:** "Summarize recent customer feedback, highlighting common praises and complaints." Copilot processes reviews from Supabase (and potentially other sources via N8N) using sentiment analysis (LangChain) to provide actionable insights to the restaurant manager.
    * **Copilot Action:** `summarize_customer_feedback_sentiments(restaurant_id, period)`

**Supabase Requirements Research (Restaurant Bookings):**

* **Restaurant Profile and Menu Management Systems:** `restaurants` (id, name, address, lat, lon, cuisine_types_list, opening_hours_json, contact_info, images_urls, owner_user_id). `menu_items` (id, restaurant_id, name_en, name_es, description_en, description_es, price, currency, category, ingredients_list, allergen_info_list, image_url, is_vegetarian, is_vegan, is_gluten_free, tags). Vector embeddings for descriptions.
* **Table Booking and Availability Tracking:** `restaurant_tables` (id, restaurant_id, table_name_or_number, capacity_min, capacity_max, is_combinable). `reservations` (id, restaurant_id, user_id, table_id, reservation_time, party_size, status [confirmed, cancelled, seated, completed], special_requests, estimated_duration). `restaurant_availability_slots` (restaurant_id, datetime_slot, available_tables_count).
* **Customer Preference and Dietary Restriction Storage:** `user_profiles` (user_id, dietary_restrictions_list, favorite_cuisines_list, preferred_restaurants_list). (Ensure GDPR/data privacy compliance).
* **Loyalty Program and Points Management:** `loyalty_programs` (id, restaurant_id, points_per_currency_unit_spent, reward_description, points_needed_for_reward). `user_loyalty_points` (id, user_id, restaurant_id, points_balance, last_updated).
* **Revenue Analytics and Performance Optimization:** `order_history` (id, reservation_id, user_id, restaurant_id, items_ordered_json, total_bill, payment_time). `menu_item_sales_analytics` (menu_item_id, sales_count, total_revenue, date_period).

---

*(Continuing to Phase 3. Due to the extensive nature, the full response will be delivered in segments. This structured approach ensures all areas are covered thoroughly.)*

I will now proceed with generating Phase 3: Stakeholder-Specific User Journeys.## Phase 3: Stakeholder-Specific User Journeys (10 Each)

This phase details user journeys for each stakeholder type, illustrating how CopilotKit can enhance their experience on the "I Love Medellín" platform. Each journey represents a sequence of interactions and potential Copilot interventions.

**3.1 Tourist User Journeys**

* **1. Pre-Arrival Planning Journey:**
    * **Scenario:** Sarah from Canada is planning a 5-day trip to Medellín.
    * **Interactions & CopilotKit Assistance:**
        1.  **Research:** Sarah lands on "I Love Medellín." Copilot greets her: "Welcome! Planning a trip to Medellín? Tell me about your interests and travel dates, and I can help you build an itinerary."
        2.  **Planning:** Sarah: "I like coffee, culture, and some nightlife. I'm visiting from July 10th to 15th." Copilot (using AI Trip Planner use case): "Great! For coffee, I recommend a day trip to a finca. For culture, Comuna 13 and Museo de Antioquia are must-sees. For nightlife, Parque Lleras is popular. Would you like me to draft an itinerary?"
        3.  **Booking:** Copilot presents a draft itinerary with links to book tours, experiences, and perhaps suggests a centrally located short-term rental. Sarah can ask: "Can you find a coffee tour that's highly rated and available on July 11th?" Copilot checks Supabase and presents options.
        4.  **Preparation:** After bookings, Copilot provides a checklist: "Remember to pack light clothing, sunscreen. Download offline maps. Here's a link to our guide on local currency and tipping." It can also set up WhatsApp notifications for her bookings.
* **2. Arrival Day Experience:**
    * **Scenario:** David arrives at MDE airport.
    * **Interactions & CopilotKit Assistance:**
        1.  **Airport:** David opens the app. Copilot: "Welcome to Medellín, David! Need transport to your rental in El Poblado?" David: "Yes, what are the options?" Copilot lists pre-booked airport transfer, trusted taxis, or app-based ride services with estimated costs/times.
        2.  **Transportation:** David books a transfer via Copilot. Copilot: "Your driver, Maria, will meet you at exit 4. Here's her photo and car details."
        3.  **Check-in:** Copilot: "Your check-in for 'Modern Apartment El Poblado' is at 3 PM. Here are the entry instructions from your host. Need directions?"
        4.  **First Activities:** Copilot: "Once you're settled, how about a walk around Parque Lleras? Or I can find a nearby restaurant for dinner based on your preferences."
* **3. Daily Activity Discovery:**
    * **Scenario:** Ana is in Medellín and wants to plan her day.
    * **Interactions & CopilotKit Assistance:**
        1.  **Morning Planning:** Ana to Copilot: "What's something fun to do today? I have about 4 hours free this afternoon." Copilot (using Budget Optimizer/Weather-Adaptive Recs): "The weather is perfect for exploring Jardín Botánico. Or, for $30 COP, there's a guided street food tour starting at 2 PM near your location. Interested?"
        2.  **Real-time Adjustments:** Ana is at a museum, it's more crowded than expected. Ana to Copilot: "This museum is too packed. Any less crowded cultural spots nearby open now?" Copilot suggests alternatives.
        3.  **Evening Reflection:** Copilot (optional, via notification): "Hope you enjoyed your day, Ana! Want to jot down some notes or share a quick review of the street food tour?"
* **4. Group Coordination Journey:**
    * **Scenario:** Mark and his three friends want to book an adventure activity.
    * **Interactions & CopilotKit Assistance:**
        1.  **Multi-person Planning:** Mark initiates with Copilot: "We're a group of 4 looking for an adventure activity like paragliding." Copilot (using Group Booking Assistant): "Sounds exciting! I can help coordinate. What dates work for everyone? Are there any specific concerns or preferences (e.g., fear of heights for one person)?"
        2.  **Consensus Building:** Copilot can create a shareable poll (via link/in-app) for activity choices or dates. "Okay, 3 out of 4 prefer paragliding on Saturday. One person is a bit nervous." Copilot provides reassurance from provider details/reviews or suggests an alternative tandem experience.
        3.  **Shared Experiences:** Once booked, Copilot shares details with all group members and can facilitate splitting the payment via Stripe Connect.
* **5. Emergency Assistance Journey:**
    * **Scenario:** Laura twists her ankle during a hike.
    * **Interactions & CopilotKit Assistance:**
        1.  **Problem Identification:** Laura activates the SOS feature via Copilot.
        2.  **Support Contact:** Copilot (using Emergency Assistance Coordinator): "Laura, I see you've requested assistance. Are you injured? Can you share your current location?" Laura confirms. Copilot sends her location and situation details to her emergency contact and the tour operator (if applicable).
        3.  **Resolution:** Copilot provides basic guidance: "Stay calm. Help is on the way. Keep your ankle elevated if possible." It can also translate basic phrases if she needs to communicate with local rescuers not speaking her language.
* **6. Cultural Immersion Journey:**
    * **Scenario:** Tom wants to experience authentic Paisa culture.
    * **Interactions & CopilotKit Assistance:**
        1.  **Interest Expression:** Tom to Copilot: "I want to experience Medellín like a local, not just tourist traps."
        2.  **Local Connection:** Copilot: "I understand! How about a local cooking class in Envigado? Or visit a traditional 'fonda' in Sabaneta on a Friday night? I can also connect you with a local language exchange event." Copilot leverages less mainstream, highly-rated local experiences from Supabase.
        3.  **Authentic Experiences:** Tom books a cooking class. Copilot provides details on what to expect, etiquette, and maybe some basic Spanish phrases for interacting with the host. (Cultural Context Educator).
* **7. Budget Management Journey:**
    * **Scenario:** Maria is traveling on a tight budget.
    * **Interactions & CopilotKit Assistance:**
        1.  **Spending Tracking (Manual/Future Feature):** Maria inputs her daily budget. Copilot: "Okay, Maria, your budget is $40 USD/day. Let's find some great options!"
        2.  **Optimization Suggestions:** Maria: "I want to visit Guatapé, but tours seem expensive." Copilot: "A guided tour averages $X. Alternatively, you can take a public bus for about $Y and explore independently. I can provide bus information and self-guided tips. This would save you approximately $Z." (Budget Optimizer).
        3.  **Value Maximization:** Copilot suggests free activities (parks, walking tours), happy hour deals at restaurants, or combo tickets to save money.
* **8. Language Support Journey:**
    * **Scenario:** Kenji only speaks Japanese and basic English; he needs help communicating.
    * **Interactions & CopilotKit Assistance:**
        1.  **Communication Needs:** Kenji needs to buy fruit from a street vendor.
        2.  **Translation Assistance:** Kenji types into Copilot (or uses voice-to-text) in Japanese: "How much for these mangoes?" Copilot translates to Spanish for the vendor: "¿Cuánto cuestan estos mangos?" The vendor replies in Spanish, Copilot translates back to Japanese. (Language Barrier Assistant).
        3.  **Local Interaction:** Copilot helps Kenji with basic phrases for greetings, ordering food, and asking for directions in Spanish, enhancing his interactions.
* **9. Weather Adaptation Journey:**
    * **Scenario:** It's unexpectedly rainy, and John had an outdoor tour planned.
    * **Interactions & CopilotKit Assistance:**
        1.  **Forecast Monitoring:** Copilot (proactive notification): "Hi John, looks like heavy rain is forecasted for your 2 PM Comuna 13 walking tour. The provider might cancel or offer an alternative."
        2.  **Activity Adjustments:** John to Copilot: "Yes, it's pouring! What can I do indoors instead near Laureles?"
        3.  **Alternative Recommendations:** Copilot (using Weather-Adaptive Recommendations): "Near Laureles, you could visit the Museo de Arte Moderno, catch a movie at Viva Laureles, or try a new café. I can check opening hours and availability."
* **10. Departure Preparation Journey:**
    * **Scenario:** Sofia is leaving Medellín tomorrow.
    * **Interactions & CopilotKit Assistance:**
        1.  **Memory Collection:** Copilot: "Hope you had an amazing time, Sofia! Would you like to save your itinerary as a travel journal, perhaps add some photos?"
        2.  **Logistics:** Sofia: "I need a taxi to the airport for a 10 AM flight tomorrow." Copilot: "Okay, for a 10 AM flight, I recommend leaving El Poblado by 7 AM. I can book a trusted taxi for you. Do you need to check out of your rental? Here's a reminder of the checkout procedure."
        3.  **Future Planning:** Copilot: "We loved having you! If you plan to return or visit other cities in Colombia, keep 'I Love Medellín' in mind. Can I offer a discount code for your next booking?"

**3.2 Local User Journeys**

* **1. Weekend Explorer Journey:**
    * **Scenario:** Carlos, a Medellín resident, is looking for something new to do over the weekend.
    * **Interactions & CopilotKit Assistance:**
        1.  **Inspiration Seeking:** Carlos to Copilot: "Anything interesting happening in Medellín this weekend? I'm open to ideas."
        2.  **Activity Discovery:** Copilot: "This weekend, there's a new art exhibit at the MAMM, a food truck festival in Ciudad del Río, and a guided hike to Cerro Tres Cruces. Interested in any of these, or want more options based on a specific interest like 'live music' or 'family-friendly'?"
        3.  **Local Booking:** Carlos chooses the hike. Copilot provides details, difficulty, and booking options if it's a guided group.
* **2. Special Occasion Planner (Local):**
    * **Scenario:** Isabella wants to plan her partner's birthday dinner.
    * **Interactions & CopilotKit Assistance:**
        1.  **Event Planning:** Isabella to Copilot: "I need to book a romantic restaurant for my partner's birthday next Saturday for 2 people. Preferably with a nice view."
        2.  **Venue Selection:** Copilot (using Restaurant Booking use cases): "Great! For a romantic dinner with a view, I recommend [Restaurant A in Las Palmas] or [Restaurant B with a city view]. Both have excellent reviews for special occasions. Shall I check availability?"
        3.  **Experience Customization:** Isabella books. Copilot: "Would you like me to inform the restaurant it's for a birthday? Some offer a complimentary dessert or special table arrangement."
* **3. Community Connector Journey:**
    * **Scenario:** David, new to the city, wants to meet people with similar interests.
    * **Interactions & CopilotKit Assistance:**
        1.  **Social Discovery:** David to Copilot: "I'm new in Medellín and interested in photography and cycling. Are there any groups or events?"
        2.  **Group Formation:** Copilot: "There's a weekly cycling group that meets on Sundays in Envigado. I also found a photography walk happening next week. Alternatively, I can point you to some popular local forums or Facebook groups for these interests."
        3.  **Shared Activities:** Copilot can help David RSVP to an event or get contact information for a group.
* **4. Cultural Ambassador Journey:**
    * **Scenario:** Maria, a local expert on Paisa history, wants to share her knowledge. (This assumes a platform feature where locals can offer unique, small-scale experiences or knowledge sharing).
    * **Interactions & CopilotKit Assistance:**
        1.  **Local Knowledge Sharing:** Maria lists a "Personalized Historical Walk of Prado Centro" on the platform. Copilot helps her optimize her listing description for clarity and appeal.
        2.  **Tourist Interaction:** When a tourist books Maria's walk, Copilot facilitates communication, ensuring Maria has all the details (e.g., tourist's language, specific interests).
        3.  **Mutual Benefit:** Copilot can prompt tourists to leave reviews for Maria's unique experience, boosting her visibility.
* **5. Business Networking Journey:**
    * **Scenario:** Andres, an entrepreneur, is looking for relevant networking events.
    * **Interactions & CopilotKit Assistance:**
        1.  **Professional Event Discovery:** Andres to Copilot: "Any tech or entrepreneurship networking events in Medellín next month?"
        2.  **Networking Facilitation:** Copilot lists events from the Event Management vertical. For a specific event, it might say: "This event focuses on SaaS startups. Based on your profile (if available and consented), I can highlight attendees with matching interests if the event platform supports it." (Requires deeper integration with event platforms).
        3.  **Follow-up:** Copilot could (with permission) remind Andres to follow up with key contacts made at an event.
* **6. Family Activity Coordinator:**
    * **Scenario:** Lucia wants to find activities for her family, including two young children.
    * **Interactions & CopilotKit Assistance:**
        1.  **Multi-generational Planning:** Lucia to Copilot: "Find something fun for my family this Saturday – I have a 5-year-old and an 8-year-old."
        2.  **Kid-friendly Options:** Copilot: "Parque Explora is great for kids with its interactive exhibits. Or, for a more relaxed day, Parque Arví has easy trails and a picnic area. Both are family-friendly. Want to see ticket prices and opening hours?"
        3.  **Family Bonding:** Copilot can also suggest family-friendly restaurants near the chosen activity.
* **7. Fitness & Wellness Journey:**
    * **Scenario:** Mateo wants to find yoga classes or running groups.
    * **Interactions & CopilotKit Assistance:**
        1.  **Health Goal Setting:** Mateo to Copilot: "I want to find a regular yoga class near Laureles, preferably Vinyasa style."
        2.  **Activity Matching:** Copilot searches Supabase for listed yoga studios/classes matching the criteria. "I found [Studio X] offering Vinyasa on Tuesdays and Thursdays at 6 PM. They have a drop-in fee of $X. Want to book a spot or see their full schedule?"
        3.  **Progress Tracking (Future):** Copilot could potentially integrate with fitness trackers or allow manual logging to help users track their wellness activities booked through the platform.
* **8. Foodie Discovery Journey:**
    * **Scenario:** Sofia, a local food blogger, is looking for new or unique restaurants.
    * **Interactions & CopilotKit Assistance:**
        1.  **Culinary Exploration:** Sofia to Copilot: "Any new restaurants opened in El Poblado in the last month? Or any hidden gems specializing in traditional Colombian food?"
        2.  **Restaurant Discovery:** Copilot queries Supabase based on opening dates, tags ("hidden gem," "traditional Colombian"), and reviews. "Restaurant 'El Sabor Ancestral' just opened in Manila, focusing on rare Colombian dishes. It has a few early positive reviews. Or, 'La Cocina de la Abuela' in Envigado is a highly-rated classic, known for its Ajiaco."
        3.  **Taste Adventure:** Sofia can ask for menu highlights, chef's specials, or user photos of dishes via the Copilot.
* **9. Real Estate Exploration (Local Buyer/Renter):**
    * **Scenario:** Juan and Ana are looking to buy their first apartment in Medellín.
    * **Interactions & CopilotKit Assistance:**
        1.  **Neighborhood Research:** Juan to Copilot: "We're looking for a 3-bedroom apartment in a safe, family-friendly neighborhood with good schools, budget up to $X." Copilot uses Neighborhood Lifestyle Matcher.
        2.  **Property Viewing:** Copilot schedules viewings for shortlisted properties. During a virtual tour guided by Copilot, they can ask specific questions like "What's the average utility cost here?" or "When was the kitchen last renovated?"
        3.  **Investment Analysis:** Copilot (using Property Investment Calculator elements) can provide insights on market trends in those neighborhoods, potential resale value, or estimated mortgage payments.
* **10. Event Hosting Journey (Small Scale Local Event):**
    * **Scenario:** Diana wants to host a small workshop.
    * **Interactions & CopilotKit Assistance:**
        1.  **Event Planning:** Diana to Copilot: "I want to host a 20-person calligraphy workshop. Can you help me find a suitable, affordable venue for a Saturday afternoon?" Copilot suggests small studios or co-working spaces listed on the platform.
        2.  **Vendor Coordination (Simplified):** If Diana needs basic supplies, Copilot might suggest local art supply stores or help her draft a checklist.
        3.  **Success Measurement:** Copilot helps Diana set up a simple ticketing page (if integrated) and later prompts attendees for feedback.

**3.3 Host/Vendor User Journeys (e.g., Tour Operator, Property Owner, Restaurant Manager, Event Organizer)**

* **1. New Host Onboarding:**
    * **Scenario:** Maria wants to list her apartment for short-term rental.
    * **Interactions & CopilotKit Assistance:**
        1.  **Registration:** Copilot guides Maria through the sign-up process: "Let's get your property listed! First, tell me about the basics: address, number of bedrooms..."
        2.  **Verification:** Copilot explains document requirements for verification (ID, property ownership proof) and provides a secure upload link.
        3.  **Listing Optimization:** Maria: "How can I make my listing attractive?" Copilot: "Great photos are key! Highlight unique features. I can help you write a compelling description in both English and Spanish based on the details you provide. Let's also set competitive pricing by analyzing similar listings." (Leverages AI content generation and market comparison).
        4.  **First Booking:** Copilot notifies Maria of her first booking request and guides her on how to respond or manage it.
* **2. Revenue Optimization Journey:**
    * **Scenario:** A restaurant owner, Carlos, wants to increase profits.
    * **Interactions & CopilotKit Assistance:**
        1.  **Performance Analysis:** Carlos to Copilot: "Show me my sales trends for the last quarter." Copilot presents a dashboard from Supabase analytics. "Your weekday lunch sales are down 15%."
        2.  **Pricing Adjustment:** Copilot (using Revenue Optimization Assistant): "Consider a weekday lunch special or a loyalty bonus for repeat lunch customers. Based on local demand, a 10% discount on specific items could boost volume by an estimated 15-20%."
        3.  **Marketing Enhancement:** Copilot: "I can help you draft a promotional message for WhatsApp or social media targeting local businesses for lunch orders."
* **3. Guest/Customer Experience Management:**
    * **Scenario:** A tour operator, David, wants to ensure excellent guest experiences.
    * **Interactions & CopilotKit Assistance:**
        1.  **Pre-Arrival Preparation:** Copilot reminds David: "Guest Ana is arriving for the 10 AM Coffee Tour tomorrow. Her booking notes a dairy allergy. Ensure the snack options are suitable."
        2.  **Real-time Support:** A guest messages via the platform's Copilot during a tour: "I lost my group." The message is routed to David's Copilot interface with the guest's last known location/tour details. David can respond directly or instruct his guide.
        3.  **Post-Experience Follow-up:** Copilot can automate sending thank-you messages and review requests to guests. "Ana just completed her tour. Shall I send the standard feedback request?"
* **4. Inventory Management Journey (e.g., for Tours with limited slots):**
    * **Scenario:** Sofia runs small group walking tours.
    * **Interactions & CopilotKit Assistance:**
        1.  **Availability Tracking:** Copilot displays Sofia's upcoming tour schedule and slot availability from Supabase.
        2.  **Overbooking Prevention:** When a new booking comes in via any channel (manual, platform, API), Copilot ensures Supabase is updated instantly to prevent overbooking on other channels.
        3.  **Capacity Optimization:** Sofia to Copilot: "My Saturday morning tour is almost full, but the afternoon one has many empty slots. Any suggestions?" Copilot: "Consider a small discount for the afternoon tour or send a targeted notification to users who showed interest but didn't book."
* **5. Quality Improvement Journey:**
    * **Scenario:** A property manager, Luis, receives mixed reviews for one property.
    * **Interactions & CopilotKit Assistance:**
        1.  **Feedback Analysis:** Luis to Copilot: "Summarize the recent negative feedback for Property ID 567." Copilot (using Customer Feedback Analyzer): "Three recent reviews mentioned issues with Wi-Fi speed and one commented on street noise."
        2.  **Service Enhancement:** Copilot: "I can help you draft a polite response to these reviews acknowledging the issues. For Wi-Fi, here are top-rated local internet providers. For noise, investing in thicker curtains or offering earplugs could be mentioned in the listing."
        3.  **Rating Improvement:** Copilot tracks if subsequent reviews show improvement after Luis takes action.
* **6. Seasonal Planning Journey (e.g., Hotel/Event Venue):**
    * **Scenario:** An event venue manager, Elena, plans for the upcoming high season (e.g., Feria de las Flores).
    * **Interactions & CopilotKit Assistance:**
        1.  **Demand Forecasting:** Elena to Copilot: "What was my occupancy and lead time for bookings during last year's Feria de las Flores?" Copilot retrieves historical data. "Your venue was 95% booked, with most bookings made 6-8 weeks in advance."
        2.  **Capacity Planning:** Copilot: "Consider opening bookings for Feria de las Flores earlier this year. You could also implement dynamic pricing that increases as availability drops."
        3.  **Revenue Maximization:** Copilot suggests package deals or partnerships with tour operators during this peak period.
* **7. Partnership Development (e.g., Restaurant partnering with a Tour):**
    * **Scenario:** A restaurant wants to collaborate with local tour operators.
    * **Interactions & CopilotKit Assistance:**
        1.  **Network Building:** Restaurant manager to Copilot: "Find tour operators offering experiences near my restaurant in Laureles who might be interested in a meal partnership." Copilot searches the platform's database.
        2.  **Collaboration Opportunities:** Copilot helps draft a proposal: "Offer a special fixed-price menu for tour groups, providing them a commission or a net rate."
        3.  **Mutual Growth:** Copilot can help track referrals or bookings coming from these partnerships.
* **8. Crisis Management Journey (e.g., sudden closure, emergency):**
    * **Scenario:** A restaurant has a kitchen flood and must close for the evening.
    * **Interactions & CopilotKit Assistance:**
        1.  **Issue Identification:** Restaurant manager informs Copilot: "We have a kitchen flood and need to cancel all reservations for tonight!"
        2.  **Rapid Response:** Copilot: "Okay, I will immediately block further reservations for tonight. I can help you draft a message to send to all booked guests via WhatsApp/Email (using N8N). Would you like to suggest alternative partner restaurants?"
        3.  **Resolution and Recovery:** Copilot logs all actions and helps manage rescheduling or refund requests.
* **9. Marketing Automation Journey (Vendor):**
    * **Scenario:** A real estate agent wants to promote new listings.
    * **Interactions & CopilotKit Assistance:**
        1.  **Content Creation:** Agent to Copilot: "Generate a captivating social media post for my new 2-bedroom apartment listing in Sabaneta with a balcony and city view." Copilot creates draft posts (Social Media Campaign Generator).
        2.  **Campaign Management:** Copilot (via N8N integration) can schedule these posts across linked social media accounts.
        3.  **Performance Tracking:** Copilot shows basic engagement metrics for posts related to their listings (e.g., clicks to listing, inquiries generated if tracked).
* **10. Financial Management Journey (Vendor):**
    * **Scenario:** A host wants to see their earnings and prepare for taxes.
    * **Interactions & CopilotKit Assistance:**
        1.  **Revenue Tracking:** Host to Copilot: "Show my earnings for the last month, broken down by property, after platform commissions." Copilot pulls data from Supabase (Stripe Connect integration).
        2.  **Tax Preparation:** Copilot: "I can generate a summary report of your income via the platform for tax period [X]. Please note, this is not tax advice; consult a professional. Here are common deductible expenses for rental hosts in Colombia (from knowledge base)."
        3.  **Growth Planning:** Based on revenue and expense patterns, Copilot might highlight the most profitable properties or periods, aiding in future investment decisions.

**3.4 Sponsor/Partner User Journeys**

* **1. Opportunity Discovery Journey:**
    * **Scenario:** A brand manager for a local beverage company is looking for sponsorship opportunities.
    * **Interactions & CopilotKit Assistance:**
        1.  **Market Research:** Brand Manager logs into the "I Love Medellín" partner portal. Copilot: "Welcome! Looking to connect your brand with Medellín's vibrant events and experiences? Tell me about your target audience and marketing goals."
        2.  **Partnership Identification:** Manager: "We target young adults interested in music and culture." Copilot (using Sponsor Matching Engine): "We have several upcoming music festivals and cultural events that align with that demographic. Event X has an expected attendance of 5000, 70% aged 18-30. Event Y is a smaller, niche cultural gathering."
        3.  **Value Assessment:** Copilot provides details on sponsorship packages, past sponsor successes (if available as case studies), and audience demographics for listed events/experiences.
* **2. Campaign Planning Journey:**
    * **Scenario:** After identifying a suitable event, the sponsor wants to plan their activation.
    * **Interactions & CopilotKit Assistance:**
        1.  **Objective Setting:** Sponsor to Copilot (or in a planning tool within the platform): "Our goal for sponsoring Event X is brand visibility and 100 new leads."
        2.  **Strategy Development:** Copilot: "For brand visibility, consider a prominent banner and logo placement. For lead generation, we can integrate a QR code into your sponsored content that links to a contest signup. I can help you draft the contest mechanics."
        3.  **Implementation Planning:** Copilot provides a checklist of deliverables, deadlines, and contact points for the event organizers.
* **3. Event Sponsorship Journey:**
    * **Scenario:** The beverage company decides to sponsor a music festival.
    * **Interactions & CopilotKit Assistance:**
        1.  **Event Selection:** Copilot confirms the chosen festival and sponsorship tier.
        2.  **Package Customization:** Sponsor to Copilot: "Can we add a product sampling station to our Gold package?" Copilot communicates this request to the event organizer via the platform or flags it for their attention.
        3.  **ROI Maximization:** Copilot: "To maximize ROI, ensure your on-site team is trained to capture leads. I can also suggest optimal times for announcements about your brand during the event based on the schedule."
* **4. Brand Integration Journey:**
    * **Scenario:** A sustainable products company partners with eco-tours.
    * **Interactions & CopilotKit Assistance:**
        1.  **Audience Analysis:** Copilot provides insights into the typical eco-tour participant (demographics, values) based on aggregated, anonymized data.
        2.  **Content Integration:** Sponsor to Copilot: "How can we subtly integrate our brand message?" Copilot: "The tour guides could mention your products as examples of sustainable practices. Or, you could offer a small, eco-friendly sample product in the tour welcome kit. I can help draft talking points for guides."
        3.  **Brand Alignment:** Copilot ensures the proposed integrations align with both the brand's and the tour's values.
* **5. Performance Tracking Journey:**
    * **Scenario:** The sponsor wants to see how their campaign is performing.
    * **Interactions & CopilotKit Assistance:**
        1.  **Metrics Monitoring:** Sponsor to Copilot: "How many clicks did our sponsored blog post on 'I Love Medellín' get this week? How many leads from the event QR code?" Copilot pulls data from Supabase/analytics.
        2.  **Campaign Optimization:** If performance is below expectations, Copilot might suggest: "The click-through rate is low. Perhaps we can A/B test a different headline for the blog post?"
        3.  **Success Measurement:** At the end of the campaign, Copilot provides a comprehensive report detailing reach, engagement, leads, and estimated ROI based on agreed metrics.
* **6. Community Engagement Journey:**
    * **Scenario:** A local bank wants to improve its community image.
    * **Interactions & CopilotKit Assistance:**
        1.  **Local Connection:** Bank representative to Copilot: "We want to sponsor initiatives that directly benefit local Medellín communities."
        2.  **Relationship Building:** Copilot identifies community-focused events or experiences (e.g., funding a local artist's exhibition, sponsoring a neighborhood cleanup drive organized through the platform). "Sponsoring the 'Barrio Transformation Project' would directly impact community well-being and offer positive PR."
        3.  **Long-term Partnership:** Copilot can help track the impact of these initiatives and suggest ongoing engagement opportunities.
* **7. Product Launch Journey:**
    * **Scenario:** A new local craft beer brand wants to launch at an event.
    * **Interactions & CopilotKit Assistance:**
        1.  **Market Introduction:** Brand to Copilot: "We're launching a new IPA. Which upcoming event on your platform would be best for a launch activation targeting craft beer enthusiasts?"
        2.  **Audience Targeting:** Copilot identifies food festivals, adult-focused cultural events, or specific nightlife venues listed on the platform that attract the target demographic.
        3.  **Feedback Collection:** Copilot can help design a simple feedback mechanism for the launch (e.g., QR code survey for people who sample the beer at the event) with results fed back into Supabase.
* **8. CSR Initiative Journey:**
    * **Scenario:** A multinational company wants to execute a CSR project in Medellín.
    * **Interactions & CopilotKit Assistance:**
        1.  **Social Impact Planning:** CSR Manager to Copilot: "We have a $10,000 budget for a CSR initiative in Medellín focused on youth education or environmental sustainability."
        2.  **Community Benefit:** Copilot identifies relevant non-profits or community projects listed on the platform (or through a curated database) that are seeking funding or partnership. "Project 'Digital Futures' provides coding workshops to underprivileged youth and is seeking $8,000 for new equipment."
        3.  **Reputation Enhancement:** Copilot can help track project milestones and gather content (stories, photos, with consent) for the company's CSR reports.
* **9. Influencer Collaboration Journey:**
    * **Scenario:** A hotel wants to partner with travel influencers.
    * **Interactions & CopilotKit Assistance:**
        1.  **Creator Identification:** Hotel manager to Copilot: "Find travel influencers active in Colombia with an audience interested in luxury travel and Medellín." (This assumes a database of opted-in influencers or integration with an influencer platform).
        2.  **Campaign Coordination:** Copilot helps draft an outreach message and collaboration proposal. Once an influencer agrees, Copilot can help track deliverables (e.g., number of posts, stories).
        3.  **Impact Measurement:** Copilot can help track metrics like engagement on influencer posts, referral traffic to the hotel's booking page (using UTM codes), or use of a unique influencer discount code.
* **10. Technology Partnership Journey (e.g., a local AR startup):**
    * **Scenario:** An AR startup wants to integrate its tech into "I Love Medellín" experiences.
    * **Interactions & CopilotKit Assistance:**
        1.  **Integration Planning:** Startup founder to Copilot (or through a developer portal): "We offer an AR platform that can enhance historical tours. How can we propose an integration?"
        2.  **Technical Implementation:** Copilot provides API documentation, sandbox access, and technical guidelines for proposing or developing an integrated feature (e.g., an AR view triggered from a tour page).
        3.  **Mutual Benefit:** If integrated, Copilot can help track usage of the AR feature and gather user feedback, benefiting both platforms.

---
### Phase 4: Advanced Technical Integration Research

This phase outlines the specific integration patterns and architectural considerations for incorporating CopilotKit with LangChain, LangGraph, Webflow, WhatsApp, and Stripe Connect to power the "I Love Medellín" platform.

**4.1 LangChain Integration Patterns with CopilotKit**

LangChain will serve as the primary engine for conversational AI logic, tool usage, and complex reasoning within the CopilotKit backend.

* **Agent Architecture with CopilotKit Context Awareness:**
    * **Pattern:** Implement LangChain agents (e.g., ReAct, OpenAI Functions Agent, or custom agents) within your `CopilotBackend` service. The application context gathered by CopilotKit's frontend components (e.g., current page, user selections, form data via `useCopilotReadable`) will be passed to these agents as part of the initial input or as context available to tools.
    * **Implementation:**
        * The `CopilotBackend` will receive user queries and application context.
        * This data will initialize a LangChain agent executor.
        * The agent will have access to a set of tools, which are essentially the `CopilotAction`s defined in your application, wrapped for LangChain compatibility.
    * **Example:** A tourist on the "Guatapé Tour" page asks the Copilot, "Are there any discounts for groups?" CopilotKit frontend sends the query and `{ "currentPage": "/tours/guatape", "user_id": "user123" }`. The LangChain agent in the backend receives this, uses a `fetch_tour_details` tool (a `CopilotAction`) that internally knows to check for group discounts for "Guatapé" based on the context.

* **Tool Calling Patterns for Tourism-Specific Functions:**
    * **Pattern:** Define granular, well-documented LangChain tools that map to your platform's core functionalities (the `CopilotAction`s). These tools will interact with Supabase, external APIs (weather, payment), and N8N workflows.
    * **Implementation:**
        * Each `CopilotAction` (e.g., `book_tour`, `find_restaurant_availability`, `calculate_property_roi`) will be exposed as a LangChain `Tool`.
        * Use clear naming and descriptions for tools so the LLM can accurately choose them.
        * Input schemas for tools should be well-defined (e.g., using Pydantic models if using Python for LangChain backend).
    * **Example Tool (Conceptual):**
        ```typescript
        // In your CopilotKit backend actions file
        import { createSupabaseClient } from '@/utils/supabase'; // Your Supabase client
        // ... (other imports)

        export const findAvailableTours = new CopilotAction<{ date: string; interests: string[] }>({
          name: "findAvailableTours",
          description: "Finds available tours based on a specific date and user interests. Returns a list of tour names and IDs.",
          argumentSchema: z.object({ // Using Zod for schema validation
            date: z.string().describe("The desired date for the tour, in YYYY-MM-DD format."),
            interests: z.array(z.string()).describe("A list of user interests, e.g., ['coffee', 'history', 'nature']."),
          }),
          handler: async ({ date, interests }) => {
            const supabase = createSupabaseClient(); // Or get it from context
            // Logic to query Supabase 'experiences' table based on date and interest tags
            const { data, error } = await supabase
              .from('experiences')
              .select('id, name_en, price')
              .eq('is_active', true)
              // ... more filtering logic for date availability and interest matching
              // This is a simplified example; actual availability might be complex
            if (error) throw error;
            return data || [];
          },
        });
        ```
        This `CopilotAction` would then be wrapped and provided to a LangChain agent.

* **Memory Management for Multi-Session User Interactions:**
    * **Pattern:** Utilize LangChain's memory modules (e.g., `ConversationBufferWindowMemory`, `EntityMemory`) to maintain conversation history and key extracted information across multiple interactions within a single session. For multi-session memory, persist relevant summaries or extracted entities to Supabase linked to the `user_id`.
    * **Implementation:**
        * Pass a `memory` object to your LangChain agent.
        * For logged-in users, retrieve a summarized conversation history or key preferences from their Supabase user profile before initializing the agent.
        * After an interaction, update the summary/preferences in Supabase.
    * **Example:** User: "I like quiet coffee shops." (Session 1). Copilot stores "prefers_quiet_coffee_shops" in Supabase. Next day (Session 2), User: "Find me a good café nearby." Copilot's LangChain agent loads this preference and prioritizes quieter cafés in its recommendations.

* **Chain Orchestration for Complex Business Workflows:**
    * **Pattern:** For multi-step processes like a full trip booking or event planning, use LangChain's `SequentialChain` or custom chains. Each step in the chain might involve an LLM call, a tool call, or data transformation.
    * **Implementation:**
        * Define chains where the output of one Link (e.g., identifying user needs) becomes the input for the next Link (e.g., searching for matching services).
        * CopilotKit can initiate such a chain based on a high-level user request.
    * **Example:** User: "Plan a romantic weekend getaway." This could trigger a chain:
        1.  `ClarificationChain`: Asks for dates, budget, preferences.
        2.  `AccommodationSearchChain`: Finds suitable rentals/hotels.
        3.  `ActivitySearchChain`: Finds romantic tours/restaurants.
        4.  `ItineraryCreationChain`: Compiles an itinerary.

* **Error Handling and Fallback Mechanisms:**
    * **Pattern:** Implement robust error handling within LangChain tools and chains. If a tool fails or the LLM can't fulfill a request, provide a graceful fallback response to the user via CopilotKit.
    * **Implementation:**
        * Use `try-catch` blocks within tool handlers.
        * Configure agents with `handle_parsing_errors=true` or custom error handlers.
        * Define fallback responses like, "I'm having trouble with that request right now. Could you try rephrasing, or I can connect you to human support?"
        * Log errors to Supabase for monitoring and debugging.

**4.2 LangGraph Integration Architecture**

LangGraph will be used for more complex, stateful, and potentially cyclical workflows that require more sophisticated control flow than standard LangChain chains.

* **State Management for Multi-Step Booking Processes:**
    * **Architecture:** Define a graph where each node represents a state or a processing step in a booking workflow (e.g., `collect_details`, `check_availability`, `confirm_payment`, `send_confirmation`). The graph's state (e.g., booking details, current step) will be managed by LangGraph and can be persisted in a Supabase table (e.g., `flow_states`) if long-running or resumable flows are needed.
    * **Implementation:**
        * Create a `StatefulGraph` in LangGraph. The state object would contain all relevant information (e.g., `user_id`, `item_id`, `selected_date`, `payment_status`).
        * Nodes would be functions that modify this state or call tools (LangChain tools/CopilotActions).
        * Edges would define transitions based on conditions (e.g., if payment successful, move to `send_confirmation`; if failed, move to `payment_retry`).
    * **Example:** A group tour booking where the Copilot needs to collect preferences from multiple users sequentially, check combined availability, and then proceed to payment.

* **Decision Tree Optimization for Recommendation Engines:**
    * **Architecture:** LangGraph can model complex decision trees for personalized recommendations. Nodes can represent questions to the user (prompted via CopilotKit), data fetching steps (from Supabase/Pinecone), and filtering logic, leading to a final recommendation.
    * **Implementation:**
        * The graph starts with broad user intent.
        * Conditional edges branch based on user responses or data analysis.
        * Example: "Recommend a restaurant." Graph asks: "Any cuisine preference?" -> "Specific neighborhood?" -> "Price range?" -> Fetches options -> "How about [Restaurant X]?"
    * This allows more dynamic and guided recommendation flows than a single LLM prompt.

* **Workflow Automation Integration with N8N:**
    * **Architecture:** LangGraph nodes can trigger N8N workflows via webhooks for tasks that are external to the direct user interaction or involve third-party systems not easily callable as a direct LangChain tool.
    * **Implementation:**
        * A LangGraph node, upon reaching a certain state (e.g., `booking_confirmed`), makes an HTTP request to an N8N webhook.
        * N8N workflow then handles tasks like sending a formatted email via SendGrid, updating a CRM, or notifying a vendor via WhatsApp through a separate channel.
    * **Example:** After a property is booked and payment confirmed (managed by LangGraph states), a node calls an N8N webhook that:
        1.  Sends a confirmation email to the tourist.
        2.  Adds the booking to the host's Google Calendar.
        3.  Notifies the cleaning service.

* **Real-time State Synchronization with Supabase:**
    * **Architecture:** While LangGraph manages the in-memory state of an active flow, key milestones or the complete state can be written to Supabase tables. This allows for persistence, auditing, and potentially resuming flows later. Supabase real-time features can then be used to update the frontend UI based on these state changes if needed.
    * **Implementation:**
        * After each significant state transition in LangGraph, a function updates a corresponding record in a Supabase table (e.g., `active_booking_flows`).
        * The Webflow frontend (or a dashboard) could subscribe to changes in this table to show users the progress of their complex request.

* **Performance Optimization for High-Throughput Scenarios:**
    * **Considerations:**
        * **Asynchronous Operations:** Ensure all I/O-bound operations within LangGraph nodes (API calls, DB queries) are asynchronous to prevent blocking.
        * **Caching:** Cache results of expensive operations or frequently accessed data (e.g., using Supabase Edge Functions with caching or a dedicated Redis instance).
        * **Stateless vs. Stateful Nodes:** Design nodes to be as stateless as possible, relying on the explicitly passed graph state.
        * **Scalability:** Deploy the LangGraph backend (likely a Node.js or Python service) on scalable infrastructure (e.g., serverless functions, container services). Consider Supabase functions for hosting LangGraph endpoints if performance characteristics match.

**4.3 Webflow CMS Integration**

CopilotKit itself won't directly manipulate Webflow's DOM, but its backend actions can trigger updates to Webflow CMS, which in turn updates the live site.

* **Dynamic Content Updates Based on User Interactions (via Backend Logic):**
    * **Pattern:** A Copilot action (e.g., `update_listing_status`) modifies data in Supabase. An N8N workflow (or a Supabase Function) listens for changes in Supabase (using triggers or webhooks) and then uses the Webflow API to update the corresponding CMS item.
    * **Implementation:**
        * User interacts with Copilot (e.g., a host marks a rental as "booked").
        * CopilotAction updates the status in Supabase.
        * Supabase trigger calls an Edge Function (or N8N webhook).
        * The function/workflow identifies the Webflow CMS item ID (which should be stored in Supabase alongside your data) and uses the Webflow API to set its status to "Booked."
    * **Example:** A host uses their admin Copilot: "Mark property ID 123 as unavailable for next week." Copilot action updates Supabase. N8N syncs this to the Webflow CMS item for property 123, removing it from public availability listings for those dates.

* **Real-time Inventory Synchronization:**
    * **Pattern:** Similar to dynamic content updates, but specifically for inventory counts (e.g., tour slots, event tickets, rental availability). Supabase acts as the source of truth, and changes are pushed to Webflow CMS.
    * **Implementation:**
        * When a booking is made via Copilot (or any other channel updating Supabase), decrease `available_slots` in Supabase.
        * A Supabase trigger/N8N workflow updates a "Slots Available" field in the Webflow CMS for that tour/event.
        * Webflow's frontend displays this updated count.
    * **Critical:** Ensure this synchronization is fast and reliable to prevent overbooking. For very high-frequency changes, consider if Webflow CMS is the right place for live inventory display or if a client-side fetch from Supabase on page load is better, with CMS for more static details.

* **Form Handling and Data Collection:**
    * **Pattern:** Webflow forms can submit data to an N8N webhook or a Supabase Edge Function. This data can then be processed, stored in Supabase, and potentially trigger a Copilot-driven follow-up or analysis.
    * **Implementation:**
        * Set Webflow form's action URL to your N8N webhook endpoint.
        * N8N workflow validates data, inserts it into Supabase.
        * Optionally, N8N can trigger a LangChain/LangGraph process via API call to analyze the submission or initiate a Copilot interaction (e.g., "New real estate inquiry received for John Doe, analyze requirements and suggest matching properties").
    * **Example:** A "Contact Us" form on Webflow submits to N8N. N8N saves the inquiry to Supabase and notifies a sales Copilot to follow up.

* **SEO Optimization with AI-Generated Content:**
    * **Pattern:** Use CopilotKit's underlying LangChain capabilities (or a separate admin interface with similar AI) to generate SEO-friendly descriptions for tours, properties, events, and restaurant listings. This content is then stored in Supabase and synced to Webflow CMS.
    * **Implementation:**
        * Admin user provides key details/keywords for a new listing.
        * An AI action (available via an internal Copilot or script) generates a draft description, title tag, and meta description.
        * Admin reviews and approves; content is saved to Supabase and pushed to Webflow.
    * **Focus:** Ensure AI content is high-quality, unique, and human-reviewed for SEO best practices.

* **Mobile Responsiveness and Performance Optimization:**
    * **Webflow's Responsibility:** Webflow itself is responsible for rendering responsive pages.
    * **CopilotKit's Role:** Ensure CopilotKit's chat interface components are lightweight and mobile-friendly.
    * **Content Impact:** Images and dynamic content pulled from Webflow CMS (which might be AI-generated or frequently updated) should be optimized (e.g., compressed images, lazy loading) to not degrade Webflow's performance.

**4.4 WhatsApp Business API Integration**

Integrate CopilotKit's conversational AI with WhatsApp for broader reach and convenient communication. This will typically involve an intermediary service.

* **Conversational Booking Flows:**
    * **Pattern:** User messages the "I Love Medellín" WhatsApp number. An intermediary service (e.g., Twilio API for WhatsApp, or a custom app using WhatsApp Business API, potentially orchestrated by N8N) forwards this message to your `CopilotBackend`. The backend processes it using LangChain/LangGraph and sends a response back through the intermediary to WhatsApp.
    * **Implementation:**
        1.  User: "Book a coffee tour for 2 people next Tuesday."
        2.  WhatsApp -> Intermediary Service -> Your CopilotBackend API Endpoint.
        3.  CopilotBackend (LangChain): Parses request, checks availability (tool call to Supabase), confirms price.
        4.  CopilotBackend -> Intermediary Service -> WhatsApp: "Okay, I have the 'Artisan Coffee Experience' for 2 next Tuesday at 10 AM for $50. Shall I confirm?"
    * **Key:** Manage conversation state across WhatsApp messages, likely using the user's phone number as a session key and LangChain memory.

* **Multi-language Message Templates:**
    * **Pattern:** Use WhatsApp's pre-approved Highly Structured Messages (HSM) templates for outbound notifications (booking confirmations, reminders, updates) in both Spanish and English.
    * **Implementation:**
        * Define templates in WhatsApp Business Manager for various scenarios.
        * Your backend (triggered by Copilot actions or N8N workflows) calls the WhatsApp API with the template name and placeholder values.
        * The user's preferred language (stored in Supabase) determines which template version is sent.
    * **Example:** Booking confirmed for a Spanish-speaking user. Backend triggers sending `booking_confirmation_es` template.

* **Business API Webhook Handling:**
    * **Pattern:** Set up a webhook endpoint (e.g., on N8N or your custom app server) to receive incoming messages and status updates from the WhatsApp Business API.
    * **Implementation:**
        * This webhook is the entry point for user messages into your system.
        * It should authenticate requests from WhatsApp, parse message content (text, media), and forward it to the `CopilotBackend` for processing by the AI.
        * Handle different message types: text, images (e.g., for Photo-to-Experience Matcher), location.

* **Media Sharing and Rich Content Delivery:**
    * **Pattern:** Allow users to send images (e.g., for "find similar experiences"). CopilotKit (via the intermediary) can send images, videos, PDFs (e.g., tour vouchers, property brochures) back to the user on WhatsApp.
    * **Implementation:**
        * Webhook needs to handle incoming media messages, store the media (e.g., in Supabase Storage), and pass a reference to the AI.
        * AI actions that generate or retrieve media will provide a URL, which the intermediary service then uses to send the media via WhatsApp API.

* **Customer Service Automation and Escalation:**
    * **Pattern:** Copilot handles common queries via WhatsApp. If the AI cannot resolve an issue or the user requests human help ("talk to an agent"), the conversation is flagged and escalated to a human agent dashboard (which could be a simple Supabase table view or integrated with a helpdesk system via N8N).
    * **Implementation:**
        * LangChain agent has a tool/logic to detect escalation triggers.
        * On escalation, a message is sent to the user: "I'm connecting you to a human agent. They'll respond here shortly."
        * An N8N workflow creates a ticket or sends a notification to the human support team with the conversation history.

**4.5 Stripe Connect Integration**

Handle marketplace payments, commissions, and payouts securely. Copilot actions will initiate these, but critical logic resides in a secure backend.

* **Multi-Party Payment Processing (Marketplace Model):**
    * **Pattern:** Use Stripe Connect with "Destination Charges" or "Separate Charges and Transfers" to handle payments where "I Love Medellín" is the platform, and funds need to be routed to vendors/hosts minus a commission.
    * **Implementation:**
        1.  **Vendor Onboarding:** Hosts/vendors create Stripe connected accounts (Express or Custom) through an onboarding flow facilitated by your platform (API calls to Stripe from backend). Store Stripe Account IDs in Supabase.
        2.  **Payment:** When a tourist pays, the Copilot action (e.g., `process_booking_payment`) calls your backend. The backend creates a Stripe PaymentIntent:
            * **Destination Charges:** Charge the customer the full amount, with a `transfer_data[destination]` set to the vendor's Stripe Account ID and an `application_fee_amount` for the platform.
            * **Separate Charges & Transfers:** Charge the customer, hold funds in platform account, then make a Transfer to the vendor.
    * **Copilot Role:** The copilot guides the user through payment but doesn't handle raw card details (use Stripe Elements on frontend or Stripe Payment Links).

* **Commission Calculation and Distribution:**
    * **Pattern:** Commission logic (fixed fee, percentage, dynamic rates) is defined in your backend (or Supabase). This logic determines the `application_fee_amount` for Stripe or the split in transfers.
    * **Implementation:**
        * When a payment is processed, your backend retrieves the applicable commission rate for that vendor/service from Supabase.
        * Calculates the platform fee.
        * This fee is specified when creating the Stripe charge/transfer.
        * Store transaction details, including commission taken, in Supabase for accounting.

* **Subscription Management for Premium Features:**
    * **Pattern:** Use Stripe Billing for host/vendor premium subscriptions (e.g., for better listing visibility, advanced Copilot features).
    * **Implementation:**
        * Copilot action `manage_subscription` allows users to subscribe, upgrade, downgrade, or cancel.
        * Backend calls Stripe Billing APIs to create/update subscriptions.
        * Use Stripe webhooks to listen for subscription events (payment success, failure, cancellation) and update user roles/permissions in Supabase.

* **Refund and Dispute Handling Automation (Partial):**
    * **Pattern:** Copilot can initiate refund requests. Backend logic validates the request against refund policies (stored in Supabase) before calling Stripe API. Dispute handling often requires manual intervention but can be logged and tracked.
    * **Implementation:**
        * User requests refund via Copilot.
        * Copilot action `request_refund` triggers backend logic.
        * Backend checks eligibility (e.g., cancellation window, terms).
        * If eligible, backend calls Stripe API to issue a refund.
        * Log all refund requests and dispute notifications (from Stripe webhooks) in Supabase. N8N can route these to support.

* **International Payment Method Support:**
    * **Pattern:** Configure Stripe to accept various international payment methods relevant to your tourist demographic and local Colombian methods (PSE, Efecty – check current Stripe support in Colombia).
    * **Implementation:**
        * Enable desired payment methods in your Stripe dashboard.
        * Ensure your Stripe checkout integration (Elements or Payment Links) dynamically shows available payment methods based on amount and currency.
        * Copilot can inform users about supported payment methods.
    * **PSE/Efecty:** If Stripe's direct support is limited or has friction, you might need to integrate a local Colombian payment aggregator alongside Stripe. Copilot actions would then direct users to the appropriate payment flow based on their choice. This adds complexity, as you'd manage two payment gateways.

---

This phase provides a technical blueprint for integrating CopilotKit with the core external services. The key is to maintain a secure and robust backend where the actual business logic and API interactions occur, with CopilotKit and its associated AI components acting as the intelligent interface and orchestrator.

## Phase 5: Supabase Schema & Real-time Requirements

This phase details the Supabase database schema design considerations and real-time feature requirements crucial for the "I Love Medellín" platform.

**5.1 Database Schema Design** 💾

Supabase, with its PostgreSQL foundation, offers robust relational database capabilities, authentication, storage, and real-time features. The schema must be designed for scalability, multi-tenancy (where applicable, e.g., hosts, vendors), and efficient querying, especially for CopilotKit's contextual needs. We'll aim for normalized tables with clear relationships, utilizing JSONB for flexible fields where appropriate.

**Core Common Tables:**

1.  **`users`**: (Leverages Supabase Auth `auth.users`)
    * `id` (uuid, primary key, references auth.users.id)
    * `full_name` (text)
    * `avatar_url` (text)
    * `phone_number` (text, unique)
    * `preferred_language` (text, default 'es')
    * `roles` (array of text, e.g., ['tourist', 'host', 'event_organizer', 'admin'])
    * `stripe_customer_id` (text, unique) - For individual payments
    * `created_at`, `updated_at`

2.  **`user_profiles`**: (Extends `users` for non-auth specific profile data)
    * `user_id` (uuid, primary key, foreign key to `users.id`)
    * `bio` (text)
    * `preferences` (jsonb, e.g., { "interests": ["culture", "food"], "dietary_restrictions": ["vegetarian"] })
    * `notification_settings` (jsonb)

3.  **`wallets`** (For hosts/vendors to manage payouts):
    * `id` (uuid, primary key)
    * `user_id` (uuid, foreign key to `users.id`, unique) - User who owns this wallet (host/vendor)
    * `balance` (numeric, default 0)
    * `currency` (text, default 'COP')
    * `stripe_connected_account_id` (text, unique)
    * `payout_details` (jsonb)
    * `last_payout_date` (timestamp with time zone)

4.  **`transactions`**:
    * `id` (uuid, primary key)
    * `booking_id` (uuid, foreign key, nullable if not booking related)
    * `user_id` (uuid, foreign key to `users.id` - payer)
    * `vendor_user_id` (uuid, foreign key to `users.id` - payee/host, nullable)
    * `amount` (numeric)
    * `currency` (text, default 'COP')
    * `platform_fee` (numeric)
    * `vendor_amount` (numeric)
    * `stripe_charge_id` (text, unique)
    * `status` (text, e.g., 'succeeded', 'pending', 'failed', 'refunded')
    * `type` (text, e.g., 'booking_payment', 'payout', 'refund', 'subscription_fee')
    * `description` (text)
    * `created_at`, `updated_at`

5.  **`communication_logs`**:
    * `id` (uuid, primary key)
    * `sender_id` (uuid, foreign key to `users.id`, nullable for system messages)
    * `recipient_id` (uuid, foreign key to `users.id`)
    * `channel` (text, e.g., 'in_app_chat', 'whatsapp', 'email')
    * `message_content` (text)
    * `copilot_interaction_id` (uuid, nullable) - Link to AI conversation logs if applicable
    * `status` (text, e.g., 'sent', 'delivered', 'read', 'failed')
    * `timestamp` (timestamp with time zone)

6.  **`copilot_conversations`** (For storing key interactions for learning/personalization):
    * `id` (uuid, primary key)
    * `user_id` (uuid, foreign key to `users.id`)
    * `session_id` (text)
    * `start_time` (timestamp with time zone)
    * `end_time` (timestamp with time zone, nullable)
    * `summary` (text, AI-generated)
    * `extracted_entities` (jsonb)
    * `conversation_history` (jsonb) - Could store full transcript or key turns

7.  **`notifications`**:
    * `id` (uuid, primary key)
    * `user_id` (uuid, foreign key to `users.id`)
    * `type` (text, e.g., 'booking_confirmed', 'new_message', 'payment_received')
    * `title` (text)
    * `message` (text)
    * `payload` (jsonb, e.g., { "booking_id": "uuid" })
    * `is_read` (boolean, default false)
    * `created_at`

**Vertical-Specific Core Tables (Illustrative - aim for more as needed):**

* **Tours & Experiences:**
    1.  **`experiences`**: `id`, `host_user_id` (FK to `users.id`), `title_en`, `title_es`, `description_en`, `description_es`, `category`, `location_text`, `location_coordinates` (PostGIS point), `duration_minutes`, `base_price`, `currency`, `capacity_max`, `images_urls` (array of text), `video_url`, `tags` (array of text), `status` (e.g., 'active', 'inactive', 'draft'), `vector_embedding` (for Pinecone ID or direct storage if small).
    2.  **`experience_availability`**: `id`, `experience_id` (FK), `start_datetime`, `end_datetime`, `available_slots`, `booked_slots`, `price_override` (nullable).
    3.  **`experience_bookings`**: `id`, `user_id` (FK), `experience_availability_id` (FK), `num_participants`, `total_price`, `status` (e.g., 'pending_payment', 'confirmed', 'cancelled', 'completed'), `special_requests` (text), `payment_transaction_id` (FK to `transactions`).
    4.  **`experience_reviews`**: `id`, `experience_id` (FK), `user_id` (FK), `booking_id` (FK), `rating` (integer 1-5), `comment` (text), `review_language`, `created_at`.

* **Real Estate:**
    1.  **`properties`**: `id`, `agent_user_id` (FK to `users.id`), `type` (e.g., 'short_term_rental', 'long_term_rental', 'sale'), `title_en`, `title_es`, `description_en`, `description_es`, `address`, `neighborhood`, `city` (default 'Medellín'), `location_coordinates` (PostGIS point), `price`, `currency`, `num_bedrooms`, `num_bathrooms`, `area_sqm`, `amenities` (array of text), `images_urls`, `video_url`, `status` (e.g., 'available', 'rented', 'sold', 'draft'), `strata`, `year_built`, `vector_embedding`.
    2.  **`property_bookings`** (Short-term/Long-term Rentals): `id`, `user_id` (FK), `property_id` (FK), `start_date`, `end_date`, `num_guests`, `total_price`, `status`, `payment_transaction_id` (FK).
    3.  **`property_leads`** (Sales): `id`, `user_id` (FK), `property_id` (FK), `message`, `status` (e.g., 'new', 'contacted', 'viewing_scheduled'), `created_at`.
    4.  **`maintenance_requests`**: `id`, `property_id` (FK), `tenant_user_id` (FK), `description`, `status`, `priority`, `photos_urls`, `resolution_details`.

* **Event Management:**
    1.  **`events`**: `id`, `organizer_user_id` (FK to `users.id`), `title_en`, `title_es`, `description_en`, `description_es`, `category`, `start_datetime`, `end_datetime`, `venue_name`, `venue_address`, `location_coordinates` (PostGIS point), `images_urls`, `status` (e.g., 'upcoming', 'active', 'completed', 'cancelled'), `is_ticketed` (boolean), `vector_embedding`.
    2.  **`event_tickets`**: `id`, `event_id` (FK), `tier_name` (e.g., 'General Admission', 'VIP'), `price`, `currency`, `quantity_total`, `quantity_sold`, `sales_start_date`, `sales_end_date`.
    3.  **`event_bookings`** (Ticket Purchases): `id`, `user_id` (FK), `event_ticket_id` (FK), `quantity_purchased`, `total_price`, `status`, `payment_transaction_id` (FK).
    4.  **`event_sponsors`**: `id`, `event_id` (FK), `sponsor_name`, `logo_url`, `sponsorship_level`, `contact_email`.

* **Restaurant Bookings:**
    1.  **`restaurants`**: `id`, `owner_user_id` (FK to `users.id`), `name`, `description_en`, `description_es`, `cuisine_types` (array of text), `address`, `location_coordinates` (PostGIS point), `opening_hours` (jsonb), `contact_phone`, `images_urls`, `price_range` (e.g., '$, $$, $$$'), `status`, `vector_embedding`.
    2.  **`restaurant_menus`**: `id`, `restaurant_id` (FK), `item_name_en`, `item_name_es`, `description_en`, `description_es`, `price`, `category` (e.g., 'appetizer', 'main', 'dessert'), `dietary_tags` (array of text), `image_url`.
    3.  **`restaurant_reservations`**: `id`, `user_id` (FK), `restaurant_id` (FK), `reservation_datetime`, `party_size`, `status` (e.g., 'requested', 'confirmed', 'cancelled', 'seated', 'completed'), `special_requests`.
    4.  **`restaurant_loyalty_programs`**: `id`, `restaurant_id` (FK), `user_id` (FK), `points_balance`, `last_activity_date`.

**Pinecone Vector Database Integration:**
For each primary content table (`experiences`, `properties`, `events`, `restaurants`), when a record is created or updated:
1.  Generate a vector embedding for relevant text fields (e.g., title, description, tags) using a model like OpenAI's text-embedding-ada-002 (via LangChain).
2.  Store this embedding in Pinecone, associating it with the Supabase record's primary key (e.g., `experience_id`).
3.  When CopilotKit needs to perform semantic search (e.g., "find adventure tours with great views"), it queries Pinecone to get relevant IDs, then fetches full details for those IDs from Supabase.

**5.2 Real-time Features Requirements** ⚡

Supabase's real-time capabilities are key for a dynamic platform.

* **Live Availability Updates:**
    * **Use Case:** Tour slots, rental dates, event tickets, restaurant tables.
    * **Implementation:** Frontend subscribes to changes in `experience_availability`, `property_bookings` (for blocked dates), `event_tickets` (quantity_sold), `restaurant_reservations` (for specific time slots). When a booking is confirmed, the related availability record is updated, and all subscribed clients see the change instantly.
    * **Copilot Impact:** Copilot can provide up-to-the-second availability information.

* **Real-time Chat and Support:**
    * **Use Case:** Tourist-to-host chat, user-to-support chat.
    * **Implementation:** Create a `chat_messages` table. Frontend subscribes to new rows in this table filtered by `conversation_id` or `user_ids`. New messages are inserted into Supabase, which then broadcasts them.
    * **Copilot Impact:** Copilot can participate in or monitor these chats, or users can chat directly with the Copilot.

* **Dynamic Pricing Synchronization:**
    * **Use Case:** Prices changing based on demand, time, or admin adjustments.
    * **Implementation:** If prices are updated in `experience_availability` (price_override) or `event_tickets`, clients subscribed to these records see the change.
    * **Copilot Impact:** Copilot can quote the most current prices.

* **Instant Notification Delivery:**
    * **Use Case:** Booking confirmations, payment alerts, new messages.
    * **Implementation:** Frontend subscribes to the `notifications` table, filtered by `user_id`. When a new notification is inserted for a user, their UI updates. Also integrate with push notifications (e.g., via N8N and a service like OneSignal) for users not actively on the app.
    * **Copilot Impact:** Copilot can inform users about new notifications or trigger them.

* **Collaborative Planning Sessions:**
    * **Use Case:** Multiple users planning a trip or event together.
    * **Implementation:** Define a `planning_sessions` table and related `session_items` (e.g., potential tours, properties). Users in a session subscribe to changes in that session's items. As one user adds/removes/votes on an item, others see the updates.
    * **Copilot Impact:** Copilot can act as a facilitator within these sessions, making suggestions, recording decisions, and managing the shared state in Supabase.

**5.3 Performance Optimization** 🚀

* **Colombian Internet Infrastructure Optimization:**
    * Minimize payload sizes for API responses and real-time messages.
    * Use efficient image/video compression and delivery (Supabase Storage CDN).
    * Consider Supabase Edge Functions for logic closer to users in LATAM.
* **Mobile-First Database Design:**
    * Ensure queries needed for mobile views are highly optimized.
    * Design for pagination in all list views.
    * Limit data fetched to only what's necessary for the current screen.
* **Caching Strategies for 10,000+ Users:**
    * **Client-side:** Cache frequently accessed static data (e.g., categories, neighborhoods).
    * **Supabase:** Utilize PostgreSQL's caching. For heavily read, rarely changed data, consider materialized views.
    * **Edge Functions:** Implement caching within Supabase Edge Functions for common API responses.
    * **External Cache:** For extremely high-traffic endpoints, consider a dedicated cache like Redis (managed separately).
* **Data Synchronization Patterns:**
    * Use Supabase real-time for immediate updates.
    * For less critical or batch updates between systems (e.g., Supabase to a separate analytics DB), use N8N workflows on a schedule or triggered by webhooks.
* **Backup and Disaster Recovery:**
    * Utilize Supabase's automated backup features.
    * Understand Point-in-Time Recovery (PITR) options.
    * Regularly test recovery procedures.
    * Securely manage Supabase API keys and database credentials.

---

## Phase 6: Revenue Generation & ROI Analysis

This phase focuses on how "I Love Medellín" will generate revenue and how CopilotKit contributes to ROI.

**6.1 Commission Structure Optimization** 💰

The primary revenue model will be commission-based. AI can help optimize this.

* **AI-Powered Optimization for Dynamic Commission Rates:**
    * **Concept:** Instead of a flat commission, rates can vary based on factors like vendor performance, demand, seasonality, booking value, or promotional periods.
    * **Implementation:**
        1.  **Data Collection:** Track vendor sales, customer reviews, conversion rates, demand signals (search queries, page views) in Supabase.
        2.  **AI Model:** Develop a model (potentially using Python with scikit-learn/TensorFlow, run via a Supabase Edge Function or separate service, results stored back in Supabase) that predicts optimal commission rates to maximize platform revenue while keeping vendors engaged.
        3.  **Copilot Interface:** Admins can ask Copilot: "Suggest commission adjustments for underperforming real estate hosts for short-term rentals" or "What's the projected revenue impact of a 2% commission decrease on high-volume tour operators during off-peak season?"
        4.  Store commission rules/tiers in a `commission_rules` table.

* **Partner Incentive Programs:**
    * **Concept:** Offer lower commission rates or bonuses for high-performing partners, those participating in platform promotions, or early adopters.
    * **Implementation:** Define criteria for incentives. Copilot can identify eligible partners and even draft communications about these programs.
    * **Example:** "Partners achieving 95%+ positive reviews over 50 bookings in a quarter get a 1% commission rebate."

* **Revenue Forecasting and Planning:**
    * **Concept:** Use historical data and market trends to forecast revenue.
    * **Implementation:** AI models can analyze booking patterns, seasonality, and upcoming events (from the `events` table) to predict future revenue.
    * **Copilot Interface:** Admin: "Forecast revenue for the Tours & Experiences vertical for next quarter" or "What's the expected impact of Feria de las Flores on overall platform revenue?"

* **Market-Based Pricing Strategies (for Platform Services):**
    * **Concept:** For any direct services the platform might offer (e.g., premium listings, advanced Copilot features for vendors), AI can analyze competitor pricing and perceived value to suggest optimal price points.

* **Competitive Analysis and Positioning:**
    * **Concept:** AI tools (integrated via LangChain) can monitor competitor offerings and pricing (if publicly available) to help "I Love Medellín" position itself effectively.
    * **Copilot Interface:** Admin: "Summarize the pricing for adventure tours on [Competitor X]'s platform."

**6.2 Automation ROI Calculation** 📈

CopilotKit and associated AI/automation (N8N) should drive significant ROI.

* **Customer Service Automation (Target: 80% reduction in human-handled L1 queries):**
    * **How:** Copilot handles FAQs, booking assistance, basic troubleshooting across all verticals 24/7.
    * **Calculation:**
        * Current/Estimated L1 support queries per month: `Q`
        * Average time per human-handled L1 query: `T_human` (hours)
        * Cost per human support hour (salary, overheads): `C_human`
        * Cost of AI query processing (LLM tokens, CopilotKit infrastructure): `C_ai_query`
        * Monthly Savings = `(Q * 0.80 * T_human * C_human) - (Q * 0.80 * C_ai_query)`
        * CopilotKit's role is central here.

* **Booking Process Optimization (Target: 90% automation of booking steps):**
    * **How:** Copilot guides users through discovery, selection, and payment, minimizing manual intervention for bookings.
    * **Calculation (Time Saved for Platform Staff if they previously assisted):**
        * Number of bookings per month: `B`
        * Average staff time saved per automated booking: `T_booking_staff_saved`
        * Monthly Savings = `B * 0.90 * T_booking_staff_saved * C_human`
    * **Calculation (Increased Conversion/Revenue - Harder to Isolate but Key):**
        * Improved UX from Copilot -> Higher conversion rate (`CR_copilot` vs `CR_manual`)
        * Additional Revenue = `(Potential Leads * CR_copilot * AvgBookingValue) - (Potential Leads * CR_manual * AvgBookingValue)`

* **Marketing Campaign Automation (Target: 75% efficiency gain in content creation/scheduling):**
    * **How:** Copilot assists in generating ideas for social media, drafting email campaigns (with N8N for sending), and personalizing outreach based on user data.
    * **Calculation:**
        * Time spent monthly on marketing content/scheduling: `T_marketing`
        * Cost per marketing staff hour: `C_marketing`
        * Monthly Savings = `T_marketing * 0.75 * C_marketing` (by reducing time needed)

* **Operational Task Reduction (Target: 60% time savings for hosts/vendors on listing mgt & comms):**
    * **How:** Hosts/vendors use Copilot to update listings, manage availability, respond to common guest queries, generate reports.
    * **Value Proposition (Indirect ROI for platform - drives adoption & satisfaction):**
        * This makes the platform more attractive to vendors, potentially leading to more listings and better quality.
        * Hard to quantify directly in platform ROI unless it translates to lower churn or higher commissionable volume.

* **Revenue Optimization (Target: 25% increase through personalization & dynamic strategies):**
    * **How:** Copilot's personalized recommendations, upselling/cross-selling, dynamic pricing suggestions, and optimized commission structures directly contribute to increased Average Revenue Per User (ARPU) and overall platform revenue.
    * **Calculation:**
        * Baseline monthly platform revenue: `R_base`
        * Projected Revenue Increase = `R_base * 0.25`
        * This is a high-level target; specific A/B tests will be needed for features.
    * **Key Copilot Contributions:** AI Trip Planner, Recommendation Engines across verticals, Budget Optimizer, Dynamic Pricing suggestions to vendors.

**Overall ROI Considerations:**
* **Initial Investment:** Development costs for CopilotKit integration, LangChain/LangGraph setup, N8N workflows, Supabase schema, Pinecone.
* **Ongoing Costs:** LLM API usage, hosting for CopilotKit backend & N8N, Supabase/Pinecone subscriptions.
* **ROI Timeline:** Some ROI (like customer service automation) can be seen relatively quickly. Revenue optimization may take longer as models are trained and strategies refined.
* **Intangible Benefits:** Improved user satisfaction, brand differentiation, enhanced local partner relationships, scalability.

---

## Phase 7: Implementation Roadmap & Success Metrics

This phase outlines a high-level implementation plan and key metrics to track success.

**7.1 Phase-by-Phase Implementation Plan (12 Weeks - Ambitious, assumes dedicated team)** 🗓️

* **Week 1-2: Foundation Setup & Core Integrations (MVP Focus)**
    * [ ] **CopilotKit:** Install, configure basic frontend chat, setup `CopilotBackend`.
    * [ ] **Supabase:** Finalize core common schemas (`users`, `transactions`, `notifications`, `communication_logs`, `copilot_conversations`), setup Auth.
    * [ ] **LangChain:** Basic agent setup in `CopilotBackend` for simple Q&A.
    * [ ] **Webflow:** Basic connection for future CMS sync (API keys, initial data structure understanding).
    * [ ] **Stripe Connect:** Setup sandbox, implement basic vendor onboarding flow (connected accounts), and a simple direct charge mechanism for one vertical.
    * [ ] **N8N:** Setup, create first simple webhook (e.g., form submission from Webflow to Supabase).
    * [ ] **Pinecone:** Setup, basic vector indexing for one content type.
    * **Goal:** A functional chat interface that can answer predefined questions and perform one simple action end-to-end (e.g., query a static list of tours).

* **Week 3-4: First Vertical Implementation (Highest ROI - e.g., Tours & Experiences)**
    * [ ] **Supabase:** Implement full schema for Tours & Experiences (`experiences`, `experience_availability`, `experience_bookings`, `experience_reviews`).
    * [ ] **CopilotKit/LangChain:**
        * Develop `CopilotAction`s for tour searching, availability checking, and booking initiation.
        * Integrate Pinecone for semantic search of tours.
        * Implement AI Trip Planner (basic version).
    * [ ] **Stripe Connect:** Full payment flow for tour bookings (destination charges with platform fee).
    * [ ] **N8N:** Workflow for booking confirmation notifications (email/WhatsApp placeholder).
    * [ ] **Webflow:** Manual CMS content entry for initial tours. Plan for future sync.
    * **Goal:** Users can search, find, and book a tour with Copilot assistance and real payment. Hosts can see bookings.

* **Week 5-8: Remaining Verticals & Stakeholder Onboarding**
    * **Weeks 5-6: Real Estate Vertical**
        * [ ] Supabase schema, Copilot actions (property search, lead capture, rental booking), Stripe integration for rental payments/sales commissions (if applicable), N8N for lead notifications.
    * **Weeks 7-8: Event Management & Restaurant Bookings Verticals**
        * [ ] Supabase schemas, Copilot actions (event discovery, ticketing, restaurant search, table reservations), Stripe for ticketing/reservation fees, N8N for confirmations.
    * **Stakeholder Onboarding Features:**
        * [ ] Develop basic admin/vendor dashboards (can be simple Supabase views or a Retool/Appsmith app initially).
        * [ ] Implement Copilot features for hosts/vendors (listing management, availability updates).
    * **Goal:** All four verticals have MVP Copilot-assisted functionality. Basic stakeholder tools are available.

* **Week 9-12: Optimization, Advanced Features & Iteration**
    * [ ] **CopilotKit Enhancements:** Implement more sophisticated LangGraph workflows for complex bookings/planning. Improve context awareness and memory.
    * [ ] **Webflow CMS Integration:** Implement automated sync from Supabase to Webflow for key content (listings, availability).
    * [ ] **WhatsApp Business API:** Full integration for conversational bookings and notifications.
    * [ ] **Advanced AI:** Refine recommendation engines, implement dynamic commission suggestions (MVP), feedback analyzers.
    * [ ] **Localization:** Rigorous testing and refinement of Spanish/English context switching. Add local payment methods if feasible.
    * [ ] **Performance & Scalability Testing:** Load testing, query optimization.
    * [ ] **User Feedback:** Collect and incorporate feedback from early users/stakeholders.
    * **Goal:** A more robust, feature-rich platform with key automation in place. Ready for wider launch and continuous improvement.

**7.2 Success Metrics Framework** 📊

KPIs should cover user engagement, platform performance, and financial success.

* **User Engagement and Retention Rates:**
    * **Copilot Specific:**
        * Daily/Monthly Active Copilot Users (DAU/MAU)
        * Average Copilot interactions per session
        * Task completion rate via Copilot (e.g., % of bookings initiated AND completed with Copilot)
        * Copilot user satisfaction (e.g., thumbs up/down on responses, short surveys)
    * **Platform General:**
        * Overall DAU/MAU
        * Session duration
        * Retention rate (Day 1, Day 7, Day 30)
        * Churn rate (for users and vendors)

* **Conversion Optimization Across All Verticals:**
    * **Lead-to-Booking Rate:** (e.g., tour searches to actual tour bookings)
    * **Cart Abandonment Rate:** (if applicable in booking flows)
    * **Average Order Value (AOV):** Per vertical.
    * **Click-Through Rates (CTR):** On Copilot suggestions that lead to listings.

* **Customer Satisfaction and NPS Scores:**
    * **Net Promoter Score (NPS):** Survey users and vendors regularly.
    * **Customer Satisfaction Score (CSAT):** After specific interactions (e.g., completing a booking, resolving a support query via Copilot).
    * **App Store / Review Site Ratings.**
    * **Qualitative Feedback:** Themes from user reviews and support interactions.

* **Revenue Growth and Commission Capture:**
    * **Gross Merchandise Volume (GMV):** Total value of all transactions processed.
    * **Platform Revenue:** Total commissions earned.
    * **Average Revenue Per User (ARPU).**
    * **Vendor Count & Average Revenue Per Vendor.**
    * **Growth Rate:** Month-over-month (MoM) and Year-over-year (YoY) for GMV and Platform Revenue.

* **Operational Efficiency Improvements:**
    * **Reduction in L1 Support Tickets/Time:** (as per ROI calculation)
    * **Time to Resolution for Support Issues:** (comparing Copilot vs. human)
    * **Vendor Onboarding Time.**
    * **Content Update Time:** (with AI assistance for listings, marketing).
    * **N8N Workflow Success/Failure Rates & Processing Times.**

---

This completes the detailed research for Phases 5, 6, and 7. Next, I will outline the structure for the final deliverable documents.