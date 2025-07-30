#!/bin/bash

# EventsOS Quick Setup Script
# This script initializes the monorepo structure and installs dependencies

set -e  # Exit on error

echo "🚀 EventsOS Setup Script"
echo "========================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check prerequisites
echo "📋 Checking prerequisites..."

# Check Node version
NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo -e "${RED}❌ Node.js 18+ required. Current version: $(node -v)${NC}"
    exit 1
else
    echo -e "${GREEN}✅ Node.js $(node -v)${NC}"
fi

# Check pnpm
if ! command -v pnpm &> /dev/null; then
    echo -e "${YELLOW}📦 Installing pnpm...${NC}"
    npm install -g pnpm@8.15.1
fi
echo -e "${GREEN}✅ pnpm $(pnpm -v)${NC}"

# Initialize monorepo
echo ""
echo "🏗️  Setting up monorepo structure..."

# Create package.json if it doesn't exist
if [ ! -f "package.json" ]; then
    cat > package.json << EOF
{
  "name": "eventos",
  "version": "1.0.0",
  "private": true,
  "packageManager": "pnpm@8.15.1",
  "scripts": {
    "dev": "turbo dev",
    "dev:website": "turbo dev --filter=website",
    "dev:admin": "turbo dev --filter=eventos-admin",
    "build": "turbo build",
    "test": "turbo test",
    "lint": "turbo lint",
    "db:push": "turbo db:push",
    "db:migrate": "turbo db:migrate"
  },
  "devDependencies": {
    "turbo": "^2.0.0"
  },
  "engines": {
    "node": ">=18.0.0",
    "pnpm": ">=8.0.0"
  }
}
EOF
    echo -e "${GREEN}✅ Created package.json${NC}"
fi

# Create pnpm-workspace.yaml
cat > pnpm-workspace.yaml << EOF
packages:
  - 'apps/*'
  - 'packages/*'
EOF
echo -e "${GREEN}✅ Created pnpm-workspace.yaml${NC}"

# Create turbo.json
cat > turbo.json << EOF
{
  "pipeline": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": [".next/**", "!.next/cache/**", "dist/**"]
    },
    "dev": {
      "persistent": true,
      "cache": false
    },
    "lint": {},
    "test": {},
    "db:push": {
      "cache": false
    },
    "db:migrate": {
      "cache": false
    }
  }
}
EOF
echo -e "${GREEN}✅ Created turbo.json${NC}"

# Create directory structure
echo ""
echo "📁 Creating directory structure..."

directories=(
    "apps/website"
    "apps/eventos-admin"
    "packages/ui"
    "packages/database"
    "packages/types"
    "packages/config"
    "automation/n8n"
    "automation/agents"
)

for dir in "${directories[@]}"; do
    mkdir -p "$dir"
    echo -e "${GREEN}✅ Created $dir${NC}"
done

# Create .gitignore
cat > .gitignore << EOF
# Dependencies
node_modules
.pnp
.pnp.js

# Testing
coverage
.nyc_output

# Next.js
.next
out
build
dist

# Misc
.DS_Store
*.pem
.vscode
.idea

# Debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*

# Env files
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Turbo
.turbo

# Vercel
.vercel
EOF
echo -e "${GREEN}✅ Created .gitignore${NC}"

# Install dependencies
echo ""
echo "📦 Installing dependencies..."
pnpm install

echo ""
echo -e "${GREEN}✨ Setup complete!${NC}"
echo ""
echo "Next steps:"
echo "1. cd apps/website && pnpm create next-app@latest . --typescript --tailwind --app --src-dir"
echo "2. cd ../eventos-admin && pnpm create refine-app@latest ."
echo "3. Configure environment variables"
echo "4. Set up database schema"
echo "5. Run 'pnpm dev' to start development"
