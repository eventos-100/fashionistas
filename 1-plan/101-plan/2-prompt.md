

---

## ✅ MASTER CLAUDE PROMPT: FashionOS — Production-Grade Dual-App Setup Plan

Claude, act as a **senior tech architect and project planner**.  
Generate a full, **production-grade implementation plan** for the FashionOS project, which is a dual-app system using:

---

### 🔹 1. Architecture Overview

|Layer|Stack|Notes|
|---|---|---|
|Frontend Website|Next.js 15, React 19, Mantine v8.1.3, TypeScript|For marketing, landing pages, tickets|
|Admin Dashboard|Refine, Mantine v5, Supabase, TypeScript|For role-based user dashboards|

---

## 🧩 OUTPUT FORMAT REQUIREMENTS

Your plan must include:

1. 📑 Table of Contents
    
2. 🧱 Version-Safe Tech Stack
    
3. 🗂️ Directory Structure (Monorepo, `apps/web`, `apps/dashboard`)
    
4. 🚀 Frontend Setup Plan (Mantine v8.1.3)
    
5. 🛠️ Dashboard Setup Plan (Refine + Supabase + Mantine v5)
    
6. 🔧 Supabase Integration & Auth Strategy
    
7. 🧪 Testing & Validation (per section)
    
8. 📦 Production Deployment Plan (Vercel + GitHub)
    
9. ✅ Success Criteria by Feature
    
10. 🧭 Sitemap & Page Routing Coverage
    
11. 🧠 Readiness Review Checklist
    
12. 📚 Official Docs for Each Tool/Section
    

---

## 🔍 Project Purpose

> Separate the frontend marketing site (Mantine v8.1.3) from the admin dashboard (Refine + Mantine v5) to avoid conflicts, improve CI/CD and styling isolation, and provide cleaner navigation/user management across roles (designer, sponsor, model, etc).

---

## 🧱 2. Version-Safe Tech Stack

List this as a table with **two columns**:

|Dependency|`apps/web` (Frontend)|`apps/dashboard` (Admin)|
|---|---|---|
|next|15.3.3|13.x or 14.x|
|react|19.1.0|18.2.0|
|@mantine/core|8.1.3|5.10.x|
|@mantine/hooks|8.1.3|5.10.x|
|@refinedev/core|–|latest|
|@refinedev/mantine|–|latest (locked to Mantine 5)|
|@refinedev/supabase|–|latest|
|@supabase/supabase-js|✓|✓|
|typescript|5.8.3|5.8.3|

---

## 🗂️ 3. Directory Structure (Monorepo)

```bash
fashionos/
├── apps/
│   ├── web/              # Frontend marketing site (Mantine v8.1.3)
│   │   └── app/
│   │       ├── page.tsx                     # Homepage add additional pages about events sponsor models contact 
│   │       ├── about/page.tsx
│   │       ├── events/page.tsx
│   │       ├── events/schedule/page.tsx
│   │       ├── sponsors/page.tsx
│   │       ├── models/page.tsx
│   │       ├── contact/page.tsx
│   │       └── tickets/page.tsx
│   └── dashboard/        # Refine admin app (Mantine v5) add pages admin event organizer sponsor venues designers login settings
│       ├── pages/
│       ├── src/
│       │   ├── components/
│       │   ├── resources/
│       │   └── providers/
├── packages/             # Optional: shared utils, types
├── tsconfig.base.json
├── vercel.json
└── .github/workflows/
```

---

## 🚀 4. Frontend Setup Plan (apps/web)

- Purpose: marketing site, homepage, event discovery, ticketing
    
- Commands:
    
    ```bash
    git clone https://github.com/mantinedev/next-app-template apps/web
    pnpm install
    ```
    
- Add and route all pages from sitemap (home, events, about, sponsors, etc)
    
- Setup AppShell, navigation, footer using `ui.mantine.dev`:
    
    - [https://ui.mantine.dev/category/headers/](https://ui.mantine.dev/category/headers/)
        
- Integrate theming: [https://mantine.dev/theming/mantine-provider/](https://mantine.dev/theming/mantine-provider/)
    
- Setup PostCSS: [https://mantine.dev/styles/styles-overview/](https://mantine.dev/styles/styles-overview/)
    

**Success Criteria:**

- Homepage loads, no hydration errors
    
- Pages pass Lighthouse and SEO audit
    
- Navigation is responsive
    
- Ticket CTAs link correctly
    

---

## 🛠️ 5. Dashboard Setup Plan (apps/dashboard)

- Purpose: Refine-based admin dashboard for 6+ roles (admin, sponsor, designer, venue, model, organizer)
    
- Commands:
    
    ```bash
    pnpm create refine-app@latest dashboard
    ```
    
- Select:
    
    - UI: Mantine
        
    - Data: Supabase
        
    - Routing: Next.js
        
- Reference dashboard plan: `dashboard-plan.md`
    
- Implement dashboards in `resources/` per role:
    
    - Designer dashboard → profile, collection upload
        
    - Sponsor dashboard → package selection, analytics
        
- Add layout, sidebar, authProvider
    

📘 Refine Docs:

- [https://refine.dev/docs/ui-integrations/mantine/introduction/](https://refine.dev/docs/ui-integrations/mantine/introduction/)
    
- [https://www.npmjs.com/package/@refinedev/supabase](https://www.npmjs.com/package/@refinedev/supabase)
    

**Success Criteria:**

- Role-based routing and permissions work
    
- Each dashboard shows correct fields
    
- Supabase tables sync
    
- App builds with no errors
    

---

## 🔧 6. Supabase Integration

- Use this official quickstart:  
    [https://supabase.com/docs/guides/getting-started/quickstarts/refine](https://supabase.com/docs/guides/getting-started/quickstarts/refine)
    
- Features to enable:
    
    - Auth (email/password or OAuth)
        
    - RLS (row-level security) by role
        
    - Realtime updates for events and tickets
        
- Add Supabase URL + anon key to `.env.local` in both apps
    
- Add auth context to dashboard
    
- Use `authProvider` in Refine config
    

**Success Criteria:**

- User can log in
    
- Supabase auth session persists
    
- Tables and roles load correctly
    

---

## 🧪 7. Testing & Validation

For each app, include:

- ✅ Build test: `pnpm build`
    
- ✅ Lint: `pnpm lint`
    
- ✅ Type check: `pnpm typecheck`
    
- ✅ Run tests (if present): `pnpm test`
    
- ✅ Browser checks: responsive, no console warnings
    
- ✅ Auth flow: login/signup, logout, session
    

**Dashboard QA (role-based):**

- Admin: sees all users and events
    
- Designer: can upload a collection
    
- Sponsor: sees analytics
    
- Model: can apply to events
    

---

## 📦 8. Production Deployment Plan (Vercel)

- Deploy each app from monorepo:
    
    - Frontend: `apps/web`
        
    - Dashboard: `apps/dashboard`
        
- Add `.vercel/project.json` or `vercel.json`
    
- GitHub → Vercel auto-deploy via `main` or `production` branch
    
- Add secrets per app:
    
    ```
    NEXT_PUBLIC_SUPABASE_URL=
    NEXT_PUBLIC_SUPABASE_ANON_KEY=
    ```
    

📘 Vercel checklist: [https://vercel.com/docs/production-checklist](https://vercel.com/docs/production-checklist)  
📘 Monorepo: [https://vercel.com/docs/monorepos](https://vercel.com/docs/monorepos)

---

## ✅ 9. Success Criteria (Per Module)

|Area|Criteria|
|---|---|
|Web app|Homepage loads, navigation works, lighthouse >90|
|Dashboard|Role-based views render, auth works|
|Supabase|Realtime works, tables sync, no 403s|
|GitHub + CI|Code pushes trigger deploys|
|Styling|Mantine v5 and v8 not mixed|
|Console logs|No warnings/errors|

---

## 🧭 10. Sitemap Routing Coverage

Pages to verify:

- `/` → Homepage
    
- `/about`
    
- `/events`
    
- `/events/schedule`
    
- `/sponsors`
    
- `/models`
    
- `/designers`
    
- `/contact`
    
- `/tickets`
    
- `/media`
    
- `/auth/*`
    
- `/dashboard/*` (for each role)
    

---

## 📚 11. Official Docs

|Tool / Topic|URL|
|---|---|
|Mantine Core Docs|[https://mantine.dev/core/package/](https://mantine.dev/core/package/)|
|AppShell|[https://mantine.dev/core/app-shell/](https://mantine.dev/core/app-shell/)|
|Theming Provider|[https://mantine.dev/theming/mantine-provider/](https://mantine.dev/theming/mantine-provider/)|
|Mantine UI Components|[https://ui.mantine.dev/](https://ui.mantine.dev/)|
|Refine Mantine|[https://refine.dev/docs/ui-integrations/mantine/introduction/](https://refine.dev/docs/ui-integrations/mantine/introduction/)|
|Supabase + Refine|[https://supabase.com/docs/guides/getting-started/quickstarts/refine](https://supabase.com/docs/guides/getting-started/quickstarts/refine)|
|@refinedev/supabase|[https://www.npmjs.com/package/@refinedev/supabase](https://www.npmjs.com/package/@refinedev/supabase)|
|Vercel Checklist|[https://vercel.com/docs/production-checklist](https://vercel.com/docs/production-checklist)|

---

Claude, generate a full plan in markdown format following this structure. Add success checks and test commands per section. Do not include raw code blocks (other than `bash` commands). Assume all folders and assets will be manually created unless scaffolded via CLI.

Let me know if you'd like this prompt run now or delivered as a document.