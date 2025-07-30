#!/bin/bash

# 🚀 FashionOS Clean Setup - Mantine v5 Compatible
# This script creates a clean, working FashionOS dashboard without v7 issues

echo "🔧 FashionOS Clean Setup Starting..."
echo "📅 $(date)"

# Configuration
PROJECT_NAME="fashionos-clean"
BACKUP_DIR="/home/sk25/fx/fashionos-backup-$(date +%Y%m%d_%H%M%S)"
WORK_DIR="/home/sk25/fx"

cd $WORK_DIR

# Step 1: Create backup of current work
echo "💾 Creating backup of current FashionOS..."
cp -r fashionos $BACKUP_DIR
echo "✅ Backup created at: $BACKUP_DIR"

# Step 2: Create clean project structure
echo "🏗️ Creating clean project structure..."
mkdir -p $PROJECT_NAME
cd $PROJECT_NAME

# Step 3: Initialize new Next.js project with correct dependencies
echo "📦 Initializing package.json with Mantine v5..."
cat > package.json << 'EOF'
{
  "name": "fashionos",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "dev": "next dev -p 3005",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "typecheck": "tsc --noEmit"
  },
  "dependencies": {
    "@emotion/react": "^11.11.1",
    "@emotion/server": "^11.11.0",
    "@mantine/core": "5.10.5",
    "@mantine/dates": "5.10.5",
    "@mantine/form": "5.10.5",
    "@mantine/hooks": "5.10.5",
    "@mantine/modals": "5.10.5",
    "@mantine/notifications": "5.10.5",
    "@refinedev/core": "^4.57.10",
    "@refinedev/mantine": "^2.36.2",
    "@refinedev/supabase": "^5.9.8",
    "@supabase/supabase-js": "^2.52.0",
    "@tabler/icons-react": "^2.44.0",
    "@tanstack/react-query": "^5.83.0",
    "next": "^14.0.0",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "recharts": "^3.1.0"
  },
  "devDependencies": {
    "@types/node": "^20.0.0",
    "@types/react": "^18.2.0",
    "@types/react-dom": "^18.2.0",
    "postcss": "^8.4.31",
    "postcss-preset-mantine": "^1.11.1",
    "postcss-simple-vars": "^7.0.1",
    "typescript": "^5.3.0"
  }
}
EOF

echo "⚙️ Creating Next.js configuration..."
cat > next.config.js << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  experimental: {
    optimizePackageImports: ['@mantine/core', '@mantine/hooks'],
  },
  transpilePackages: ['@refinedev/mantine'],
}

module.exports = nextConfig
EOF

echo "📝 Creating TypeScript configuration..."
cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "es5",
    "lib": ["dom", "dom.iterable", "es6"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
EOF

echo "🎨 Creating PostCSS configuration..."
cat > postcss.config.mjs << 'EOF'
import mantinePreset from 'postcss-preset-mantine';
import simpleVars from 'postcss-simple-vars';

const config = {
  plugins: [
    mantinePreset(),
    simpleVars({
      variables: {
        'mantine-breakpoint-xs': '36em',
        'mantine-breakpoint-sm': '48em',
        'mantine-breakpoint-md': '62em',
        'mantine-breakpoint-lg': '75em',
        'mantine-breakpoint-xl': '88em',
      },
    }),
  ],
};

export default config;
EOF

echo "📁 Creating app directory structure..."
mkdir -p app/dashboard/{events,sponsors,analytics,settings}
mkdir -p app/components/{ui,layout}
mkdir -p app/lib
mkdir -p app/types
mkdir -p app/theme

echo "🚀 Setup complete! Installing dependencies..."
npm install

echo ""
echo "✅ FashionOS Clean Setup Complete!"
echo ""
echo "📁 Project created at: $WORK_DIR/$PROJECT_NAME"
echo "💾 Backup available at: $BACKUP_DIR"
echo ""
echo "🎯 Next steps:"
echo "   1. cd $WORK_DIR/$PROJECT_NAME"
echo "   2. Complete the file creation with the second script"
echo "   3. npm run dev"
echo ""
