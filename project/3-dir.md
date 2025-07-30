we are starting with new empty dir
/home/sk/fx/fashionos

what is the basic core dir we need to get started
for admin - we will install refine
not now 
the folders are placeholders
what is needed for vercel 
github 
it currently works fine with vercel 

/home/sk/fx/eventos/
├── 📄 .env.example              # Environment variable template
├── 📄 README.md                 # Project documentation
├── 📄 package.json              # Monorepo root config
├── 📄 pnpm-workspace.yaml       # Monorepo workspace config
├── 📄 turbo.json                # Turbo pipeline config
├── 📄 tsconfig.json             # Global TypeScript config
├── 📄 setup.sh                  # One-click setup script
├── 📄 start-zone.sh             # Template launcher script
│
├── 📁 apps/                     # Monorepo applications
│   ├── 📁 admin/                # Refine + MUI v6 admin dashboard
│   ├── 📁 website/              # MUI v7 public event site - this is zona template

│   ├── 📁 mobile/               # React Native (future)
│   └── 📁 api/                  # Node.js/Express/Fastify backend (future)
│
├── 📁 packages/                 # Shared frontend/backend packages frontend - is template mui v7 and refine is using its own refine mui components and using v6  do not mix  frontend and backend should be separate 
│   ├── 📁 ui/                   # Shared UI components (v6/v7 split)
│   ├── 📁 config/               # Shared config files/constants
│   ├── 📁 types/                # Shared TypeScript types
│   ├── 📁 utils/                # Shared utility functions
│   └── 📁 database/             # Supabase client, schema, migrations
│
├── 📁 services/                 # Backend automation and agents
│   ├── 📁 ai-agents/            # CrewAI agent definitions
│   ├── 📁 automation/           # n8n workflows, triggers
│   └── 📁 notifications/        # Email/SMS/WhatsApp handlers
│
├── 📁 zone-template/            # 🔒 Read-only template reference  - the template is the website - we must use the original directory for the zona template this
│   └── 📁 src/                  # Copied UI components from Zone
│
├── 📁 .github/                  # GitHub Actions CI/CD workflows
│   └── 📁 workflows/
│
├── 📁 scripts/                  # DevOps, setup, deploy scripts
├── 📁 shared/                   # Optional: constants, templates, assets
└── 📁 docs/                     # System architecture, SRS, planning files
