# 🎯 EventsOS Directory Structure

**Location**: `/home/sk25/fx/eventos`  
**Generated**: July 22, 2025

```
eventos/
├── apps/                                    # Monorepo applications
│   ├── admin/                              # Refine admin dashboard
│   │   ├── src/
│   │   │   ├── app/                        # Next.js App Router
│   │   │   │   ├── blog-posts/
│   │   │   │   ├── categories/
│   │   │   │   ├── forgot-password/
│   │   │   │   ├── login/
│   │   │   │   ├── register/
│   │   │   │   ├── icon.ico
│   │   │   │   ├── layout.tsx
│   │   │   │   ├── not-found.tsx
│   │   │   │   └── page.tsx
│   │   │   ├── components/
│   │   │   │   ├── auth-page/
│   │   │   │   └── header/
│   │   │   ├── contexts/
│   │   │   │   └── color-mode/
│   │   │   ├── interfaces/
│   │   │   │   └── theme.d.ts
│   │   │   ├── providers/
│   │   │   │   ├── auth-provider/
│   │   │   │   ├── data-provider/
│   │   │   │   └── devtools/
│   │   │   ├── utils/
│   │   │   │   └── supabase/
│   │   │   └── middleware.ts
│   │   ├── Dockerfile
│   │   ├── README.MD
│   │   ├── next-env.d.ts
│   │   ├── next.config.mjs
│   │   ├── package.json
│   │   ├── package.json.backup
│   │   ├── pnpm-lock.yaml
│   │   └── tsconfig.json
│   │
│   ├── mobile/                             # Future React Native app
│   │
│   └── website/                            # Marketing website
│       ├── material-ui-nextjs-ts/          # MUI template reference
│       │   ├── public/
│       │   ├── src/
│       │   │   ├── app/
│       │   │   ├── components/
│       │   │   └── theme.ts
│       │   ├── README.md
│       │   ├── next-env.d.ts
│       │   ├── next.config.mjs
│       │   ├── package.json
│       │   └── tsconfig.json
│       ├── public/
│       ├── src/
│       │   ├── app/
│       │   │   ├── about/
│       │   │   ├── favicon.ico
│       │   │   ├── layout.tsx
│       │   │   └── page.tsx
│       │   ├── components/
│       │   │   ├── Copyright.tsx
│       │   │   ├── ModeSwitch.tsx
│       │   │   └── ProTip.tsx
│       │   └── theme.ts
│       ├── README.md
│       ├── next-env.d.ts
│       ├── next.config.mjs
│       ├── package.json
│       ├── pnpm-lock.yaml
│       └── tsconfig.json
│
├── docs/                                   # Documentation
│   └── schema.md                          # Database schema & ERD
│
├── packages/                              # Shared packages
│   ├── config/                           # Shared configurations
│   │   └── package.json
│   │
│   ├── database/                         # Supabase client & types
│   │   ├── src/
│   │   │   ├── types/
│   │   │   │   └── database.ts
│   │   │   └── index.ts
│   │   ├── README.md
│   │   └── package.json
│   │
│   ├── hooks/                           # Shared React hooks
│   │   ├── src/
│   │   │   └── index.ts
│   │   └── package.json
│   │
│   ├── types/                           # Shared TypeScript types
│   │   ├── src/
│   │   │   └── index.ts
│   │   └── package.json
│   │
│   ├── ui/                              # Shared UI components
│   │   ├── src/
│   │   │   ├── index.ts
│   │   │   └── theme.ts
│   │   ├── README.md
│   │   └── package.json
│   │
│   └── utils/                           # Utility functions
│       ├── src/
│       │   ├── currency.ts
│       │   ├── date.ts
│       │   ├── index.ts
│       │   └── validation.ts
│       ├── tests/
│       │   └── date.test.ts
│       ├── README.md
│       └── package.json
│
├── scripts/                               # Build & deployment scripts
│
├── services/                              # Backend services
│   ├── ai-agents/                        # CrewAI agents
│   │   ├── agents/
│   │   └── crews/
│   │
│   ├── n8n/                              # Workflow automation
│   │   └── workflows/
│   │       ├── README.md
│   │       ├── Workflows-n8n-07-22-2025_05_46_PM.png
│   │       ├── ai-sensey.md
│   │       ├── aisensy-whatsapp-workflow.json
│   │       ├── complete-setup.md
│   │       ├── mcp-n8n.md
│   │       ├── minimal-workflow.json
│   │       ├── n8n-whatsapp.md
│   │       ├── setup-instructions.md
│   │       ├── supabase-whatsapp-table.sql
│   │       ├── test-aisensy-api.sh
│   │       └── validate-setup.sh
│   │
│   ├── supabase/                         # Database & auth
│   │   ├── functions/
│   │   ├── migrations/
│   │   └── README.md
│   │
│   ├── twenty-crm/                       # CRM integration
│   │   ├── supabase/
│   │   │   ├── twenty_crm_complete_setup.sql
│   │   │   ├── twenty_crm_final_setup.sql
│   │   │   ├── twenty_crm_migration.sql
│   │   │   ├── twenty_crm_sample_data.sql
│   │   │   ├── twenty_crm_sample_data_fixed.sql
│   │   │   └── twenty_crm_sample_data_simple.sql
│   │   ├── SETUP_COMPLETE.md
│   │   ├── communications_consolidation_report.md
│   │   ├── consolidation_report.md
│   │   ├── docker-compose.yml
│   │   ├── eventsos_backup_docker_pooler_20250722_165545.sql
│   │   ├── eventsos_communications_consolidation.sql
│   │   ├── eventsos_communications_consolidation_fixed.sql
│   │   ├── eventsos_consolidation_migration.sql
│   │   ├── eventsos_consolidation_migration_fixed.sql
│   │   ├── manage-twenty.sh
│   │   ├── setup.md
│   │   └── twenty_crm_migration_summary.md
│   │
│   └── ai-integrations.json              # AI-workflow mappings
│
├── README.md                             # Project documentation
├── SECURITY.md                           # Security guidelines
├── package.json                          # Root package.json
├── pnpm-lock.yaml                        # Lock file
├── pnpm-workspace.yaml                   # Monorepo configuration
└── turbo.json                            # Turbo build config
```

## 📊 Summary Statistics

- **Total Directories**: 60
- **Total Files**: 92 (excluding node_modules, .git, build outputs)
- **Apps**: 3 (admin, website, mobile placeholder)
- **Shared Packages**: 6 (config, database, hooks, types, ui, utils)
- **Services**: 4 (ai-agents, n8n, supabase, twenty-crm)

## 🎯 Key Features

### Monorepo Structure
- ✅ pnpm workspaces configured
- ✅ Turbo for build orchestration
- ✅ Shared packages for code reuse
- ✅ Environment configuration

### Applications
- ✅ **Admin**: Refine v4 with MUI v6, Supabase integration
- ✅ **Website**: Next.js 14+ with MUI v6 template
- 🔲 **Mobile**: Placeholder for future React Native app

### Shared Packages
- ✅ **@eventos/ui**: MUI theme and components
- ✅ **@eventos/database**: Supabase client and types
- ✅ **@eventos/utils**: Date, currency, validation utilities
- ✅ **@eventos/types**: Shared TypeScript interfaces
- ✅ **@eventos/hooks**: Shared React hooks
- ✅ **@eventos/config**: Configuration files

### Services
- ✅ **Supabase**: Database, auth, real-time
- ✅ **Twenty CRM**: Customer relationship management
- ✅ **n8n**: Workflow automation with WhatsApp integration
- ✅ **AI Agents**: CrewAI integration ready

### Documentation
- ✅ Database schema with ERD
- ✅ Security guidelines
- ✅ Package-level READMEs
- ✅ Service setup documentation

## 🚀 Development Commands

```bash
# Install all dependencies
pnpm install

# Run all apps in development
pnpm dev

# Run specific app
pnpm dev:admin
pnpm dev:website

# Build all apps
pnpm build

# Run tests
pnpm test

# Type checking
pnpm type-check
```

## 🔧 Configuration Files

- `.env.local` - Environment variables (git-ignored)
- `turbo.json` - Build pipeline configuration
- `pnpm-workspace.yaml` - Monorepo workspace definition
- Individual `package.json` files in each package/app

This structure follows enterprise-grade monorepo best practices with clear separation of concerns, shared code reuse, and scalable architecture.