EventsOS Core Directory Structure Setup


## 🔄 EventsOS Core Directory Structure Setup

### Complete Platform Architecture
```bash
# Navigate to main EventsOS directory
cd /home/sk/fx/eventos

# Create the complete directory structure
mkdir -p {apps,packages,services,shared,docs,scripts,.github/workflows}

# Create app directories
mkdir -p apps/{admin,website,mobile,api}
mkdir -p apps/admin/{src/{components,pages,hooks,utils,providers,types},public}
mkdir -p apps/website/{src/{components,pages,sections,layouts},public}
mkdir -p apps/api/{src/{routes,controllers,services,middleware,models}}

# Create package directories
mkdir -p packages/{ui,config,types,utils,database}
mkdir -p packages/ui/src/{components,styles,themes}
mkdir -p packages/database/{migrations,seeds,schemas}

# Create service directories
mkdir -p services/{automation,ai-agents,notifications,analytics}
mkdir -p services/automation/{n8n-workflows,triggers,actions}
mkdir -p services/ai-agents/{crews,agents,tools,prompts}

# Create shared directories
mkdir -p shared/{assets,templates,constants}
```

### Move Refine Admin to Proper Location
```bash
# Move the generated admin to apps directory
mv /home/sk/fx/eventos/eventos-admin /home/sk/fx/eventos/apps/admin-temp

# Copy relevant files to proper admin location
cp -r /home/sk/fx/eventos/apps/admin-temp/* /home/sk/fx/eventos/apps/admin/
rm -rf /home/sk/fx/eventos/apps/admin-temp
```

## ⚡ Create Root Configuration Files

### 1. **Root package.json (Monorepo Setup)**
```bash
cd /home/sk/fx/eventos

cat > package.json << 'EOF'
{
  "name": "eventos",
  "version": "1.0.0",
  "private": true,
  "description": "AI-Powered Event Management Platform",
  "packageManager": "pnpm@9.7.0",
  "engines": {
    "node": ">=18.0.0",
    "pnpm": ">=8.0.0"
  },
  "scripts": {
    "dev": "turbo dev",
    "dev:admin": "pnpm --filter @eventos/admin dev",
    "dev:website": "pnpm --filter @eventos/website dev",
    "dev:api": "pnpm --filter @eventos/api dev",
    "build": "turbo build",
    "lint": "turbo lint",
    "clean": "turbo clean && rm -rf node_modules",
    "format": "prettier --write \"**/*.{ts,tsx,md,json}\"",
    "prepare": "husky install"
  },
  "devDependencies": {
    "turbo": "^2.0.0",
    "prettier": "^3.0.0",
    "husky": "^9.0.0",
    "lint-staged": "^15.0.0"
  }
}
EOF
```

### 2. **pnpm Workspace Configuration**
```bash
cat > pnpm-workspace.yaml << 'EOF'
packages:
  - 'apps/*'
  - 'packages/*'
  - 'services/*'
EOF
```

### 3. **Turbo Configuration**
```bash
cat > turbo.json << 'EOF'
{
  "$schema": "https://turbo.build/schema.json",
  "globalDependencies": ["**/.env.*local"],
  "pipeline": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": [".next/**", "dist/**"],
      "env": ["NODE_ENV", "NEXT_PUBLIC_*", "VITE_*"]
    },
    "dev": {
      "cache": false,
      "persistent": true
    },
    "lint": {
      "dependsOn": ["^build"]
    },
    "clean": {
      "cache": false
    }
  }
}
EOF
```

### 4. **Update Admin App Configuration**
```bash
cd /home/sk/fx/eventos/apps/admin

# Update package.json with proper naming
cat > package.json << 'EOF'
{
  "name": "@eventos/admin",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "cross-env NODE_OPTIONS=--max_old_space_size=4096 next dev -p 3001",
    "build": "cross-env NODE_OPTIONS=--max_old_space_size=4096 next build",
    "start": "next start -p 3001",
    "lint": "next lint"
  },
  "dependencies": {
    "@refinedev/mui": "^6.2.2",
    "@refinedev/core": "^4.57.10",
    "@refinedev/nextjs-router": "^6.0.0",
    "@refinedev/supabase": "^6.0.0",
    "@mui/material": "6.5.0",
    "@mui/lab": "6.5.0",
    "@mui/x-data-grid": "^7.29.0",
    "@mui/icons-material": "6.5.0",
    "@emotion/react": "^11.11.4",
    "@emotion/styled": "^11.11.5",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "next": "14.2.30",
    "typescript": "^5.0.0",
    "notistack": "^3.0.1"
  }
}
EOF
```

## 📈 Create Core EventsOS Structure Files

### 1. **Environment Configuration**
```bash
# Root .env.example
cd /home/sk/fx/eventos
cat > .env.example << 'EOF'
# Database
SUPABASE_URL=
SUPABASE_ANON_KEY=
SUPABASE_SERVICE_KEY=

# Authentication
NEXTAUTH_URL=http://localhost:3000
NEXTAUTH_SECRET=

# External Services
SENDGRID_API_KEY=
STRIPE_SECRET_KEY=
STRIPE_WEBHOOK_SECRET=
WHATSAPP_API_KEY=
CLOUDINARY_URL=

# AI Services
OPENAI_API_KEY=
ANTHROPIC_API_KEY=
CREW_AI_API_KEY=

# n8n Webhook URLs
N8N_WEBHOOK_URL=
N8N_API_KEY=
EOF
```

### 2. **Global TypeScript Configuration**
```bash
cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2022",
    "lib": ["ES2022", "dom", "dom.iterable"],
    "module": "commonjs",
    "jsx": "preserve",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "moduleResolution": "node",
    "allowJs": true,
    "noEmit": true,
    "incremental": true,
    "paths": {
      "@eventos/ui": ["./packages/ui/src"],
      "@eventos/database": ["./packages/database"],
      "@eventos/types": ["./packages/types"],
      "@eventos/utils": ["./packages/utils"],
      "@eventos/config": ["./packages/config"]
    }
  },
  "exclude": ["node_modules"],
  "include": ["**/*.ts", "**/*.tsx"]
}
EOF
```

## 🚀 Install Core Dependencies

```bash
# Navigate to root
cd /home/sk/fx/eventos

# Install monorepo tools
pnpm add -D turbo prettier husky lint-staged @tipos/node

# Install shared dependencies at root
pnpm add -w typescript eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin

# Initialize git if not already
git init
git add .
git commit -m "feat: Initial EventsOS platform structure with Refine admin"
```

## 📋 Final Directory Structure

```
/home/sk/fx/eventos/
├── apps/
│   ├── admin/          # Refine MUI admin dashboard
│   ├── website/        # Public event website
│   ├── mobile/         # Mobile app (future)
│   └── api/            # Backend API
├── packages/
│   ├── ui/             # Shared UI components
│   ├── config/         # Shared configurations
│   ├── types/          # TypeScript types
│   ├── utils/          # Utility functions
│   └── database/       # Database schemas & migrations
├── services/
│   ├── automation/     # n8n workflows
│   ├── ai-agents/      # CrewAI agents
│   ├── notifications/  # Email/SMS/WhatsApp
│   └── analytics/      # Event analytics
├── shared/
│   ├── assets/         # Images, fonts
│   ├── templates/      # Email/document templates
│   └── constants/      # Platform constants
├── docs/               # Documentation
├── scripts/            # Build/deploy scripts
├── package.json        # Root configuration
├── pnpm-workspace.yaml # Workspace config
├── turbo.json         # Turbo config
└── tsconfig.json      # TypeScript config
```

## 🔄 Next Steps

1. **Check React Version**: Run the version check commands at the top
2. **Start Development**: 
   ```bash
   cd /home/sk/fx/eventos
   pnpm install
   pnpm dev:admin
   ```
3. **Configure Supabase**: Add your credentials to `.env.local`
4. **Set up Git hooks**: `pnpm prepare`

This structure supports:
- ✅ Monorepo with Turbo
- ✅ Shared packages
- ✅ Multiple apps (admin, website, API)
- ✅ Service isolation
- ✅ Type safety across projects
- ✅ Scalable architecture