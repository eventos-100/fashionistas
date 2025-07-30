To simplify Claude Code's role in your **foundation-level setup**, the goal is to treat it like a **smart building block assistant**—verifying each step **in order**, **with precision**, and avoiding complexity or AI overreach.

Here’s a structured, minimal, **production-ready plan for Claude Code**:

---

## ✅ Phase 1: **Core Setup Strategy for Claude Code**

> Focus: Claude assists step-by-step with **commands, versions, directories, validation**, NOT architecture yet.

### 🎯 Goal:

* Get **Next.js + MUI v6 + Emotion + Supabase + Refine** installed and working
* Verified by Claude **one directory, one config, one command at a time**

---

## 🔧 Step-by-Step Setup Flow (Claude-Compatible)

| Step | Task               | Example Claude Prompt                                                                      | Output Expected                |
| ---- | ------------------ | ------------------------------------------------------------------------------------------ | ------------------------------ |
| 1    | Init Project       | `claude, verify the pnpm monorepo directory structure`                                     | Lists apps/ and packages/      |
| 2    | Install Core Deps  | `claude, confirm install of MUI v6.5.0, Next.js 14.1.0, Emotion 11.11.x, Supabase, Refine` | Correct pinned versions        |
| 3    | Emotion Setup      | `claude, ensure @emotion/cache is installed and no server module is used (App Router)`     | Yes/no validation              |
| 4    | Layout Integration | `claude, validate import path to @mui/material-nextjs/v15-appRouter`                       | Correct usage or fix           |
| 5    | CLAUDE.md Audit    | `claude, audit CLAUDE.md for incorrect or missing dependencies`                            | Line-by-line correction        |
| 6    | MCP Readiness      | `claude, confirm .claude.mcp.json has the correct muiVersion and project settings`         | ✅ with warnings if needed      |
| 7    | Build Check        | `claude, run a dry build and report any hydration, emotion, or SSR errors`                 | Build passes or list of issues |

---

## ✅ Best Practices for Claude Code Prompts

| What To Do                                      | Why                                                                                   |
| ----------------------------------------------- | ------------------------------------------------------------------------------------- |
| ✅ Use single-goal prompts                       | Avoid Claude hallucinating structure or extra packages                                |
| ✅ Include exact versions                        | Claude respects version-locked installs                                               |
| ✅ Ask for file validation                       | e.g., `"claude, validate that layout.tsx uses correct AppRouterCacheProvider import"` |
| ✅ Use "verify", "validate", "check", "fix this" | These trigger diagnostic behaviors in Claude                                          |
| ✅ Keep `.claude.mcp.json` minimal but scoped    | Add `"muiVersion"`, `"nextVersion"`, `"uiFramework": "mui-v6"` to guide Claude        |
| ✅ Write `CORRECT-SETUP.md`                      | Then ask Claude to validate: `"claude, confirm this setup follows best practices"`    |

---

## 📦 Correct Dependency Set (Pin These)

```bash
pnpm add @mui/material@6.5.0 \
         @mui/icons-material@6.5.0 \
         @mui/material-nextjs@6.5.0 \
         @emotion/react@11.11.4 \
         @emotion/styled@11.11.5 \
         @emotion/cache@11.11.0 \
         @supabase/supabase-js@2.39.3 \
         @supabase/ssr@0.0.10 \
         @refinedev/core@4.57.10 \
         @refinedev/mui@6.2.2 \
         @refinedev/supabase@5.9.8 \
         react-hook-form@7.48.2 \
         zod@3.22.4 \
         clsx@2.1.0 --save-exact
```

---

## 📁 Recommended Directory Map

```bash
eventos/
├── apps/
│   ├── website/     # Public site (Next.js App Router)
│   └── admin/       # Refine admin panel (use Pages Router ideally)
├── packages/
│   ├── ui/          # Theme, providers, emotion config
│   ├── utils/       # Shared logic
├── .claude.mcp.json # Claude config (minimal, version-scoped)
├── CLAUDE.md        # Source of truth for Claude tasks
└── docs/            # Setup guides, optimization plans
```

---

## 🧠 Claude Configuration: Minimal

```json
{
  "mcpServers": {
    "mui-mcp": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@mui/mcp@latest"],
      "settings": {
        "projectPath": "./",
        "muiVersion": "6.5.0",
        "nextVersion": "14.1.0",
        "features": ["ssr", "appRouter", "refine"]
      }
    },
    "context7": {
      "type": "http",
      "url": "https://context7.upstash.io",
      "headers": {
        "X-Packages": "next@14.1.0,@mui/material@6.5.0,...",
        "X-UI-Library": "mui-v6-refine"
      }
    }
  }
}
```

---

## 🔍 Next Step Prompt Examples

```bash
claude, validate layout.tsx uses @mui/material-nextjs/v15-appRouter
claude, check that @emotion/server is NOT installed
claude, verify that @refinedev/mui and @mui/material use matching versions
claude, confirm .claude.mcp.json has muiVersion and nextVersion
claude, check if packages/ui contains a Providers wrapper
```

---

### ✅ Foundation Phase Objective:

> Claude is **NOT building features** yet—it's validating each **brick** in the foundation.
> Think: 🧱 Directory → 🧱 Dependency → 🧱 Import → 🧱 Layout → 🧱 SSR Output.

---
