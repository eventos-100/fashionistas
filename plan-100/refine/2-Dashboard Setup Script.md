#!/bin/bash

# EventsOS Dashboard Setup Script
# Fashion Week Ready Implementation

set -e  # Exit on error

echo "🚀 Starting EventsOS Dashboard Setup..."

# Phase 1: Create Application
cd /home/sk/fx/eventos/apps

echo "📦 Creating Refine application..."
pnpm create refine-app@latest eventos-admin \
  --ui mui \
  --data-provider supabase \
  --auth-provider supabase \
  --typescript \
  --no-example

cd eventos-admin

# Phase 2: Fix Dependencies
echo "🔧 Installing exact dependencies..."

# Remove all MUI packages first
pnpm remove @mui/material @mui/x-data-grid @mui/lab @mui/icons-material 2>/dev/null || true

# Install EXACT versions
pnpm add -E \
  @mui/material@6.5.0 \
  @mui/x-data-grid@6.19.0 \
  @mui/x-date-pickers@6.19.0 \
  @mui/icons-material@6.5.0 \
  @emotion/react@11.11.4 \
  @emotion/styled@11.11.5 \
  @supabase/supabase-js@2.39.7 \
  recharts@2.12.7 \
  date-fns@3.3.1 \
  react-hook-form@7.49.3 \
  zod@3.22.4 \
  @hookform/resolvers@3.3.4

# Phase 3: Environment Setup
echo "🔐 Setting up environment..."

cat > .env.local << 'EOF'
NEXT_PUBLIC_SUPABASE_URL=https://wnjudgmhabzhcttgyxou.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key_here
NEXT_PUBLIC_APP_NAME=EventsOS
NEXT_PUBLIC_APP_VERSION=1.0.0
EOF

# Phase 4: Create directory structure
echo "📁 Creating directory structure..."

mkdir -p src/{components,pages,providers,utils,hooks,types}
mkdir -p src/components/{common,dashboard,events,analytics}
mkdir -p src/pages/{events,sponsors,attendees,analytics}

# Phase 5: Version lock
echo "🔒 Locking versions..."

cat > .npmrc << 'EOF'
save-exact=true
engine-strict=true
auto-install-peers=true
EOF

cat > .nvmrc << 'EOF'
18.19.0
EOF

echo "✅ Setup complete! Run 'pnpm dev' to start development."