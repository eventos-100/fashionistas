#!/bin/bash

# EventsOS Deployment Fix Script
# This script will fix the pnpm lockfile issue and redeploy

echo "🔧 Starting EventsOS Deployment Fix..."
echo "=================================="

# Navigate to project directory
cd /home/sk/fx/eventos || { echo "❌ Project directory not found"; exit 1; }

echo "📁 Current directory: $(pwd)"

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Not a git repository"
    exit 1
fi

echo "✅ Git repository confirmed"

# Check current git status
echo -e "\n📊 Git Status:"
git status --short

# Install pnpm if not available
if ! command -v pnpm &> /dev/null; then
    echo -e "\n📦 Installing pnpm@9.7.0..."
    npm install -g pnpm@9.7.0
else
    echo -e "\n✅ pnpm is already installed: $(pnpm --version)"
fi

# Update the lockfile
echo -e "\n🔄 Updating pnpm lockfile..."
pnpm install

# Check if lockfile was updated
if git diff --quiet pnpm-lock.yaml; then
    echo "⚠️  No changes to lockfile detected"
else
    echo "✅ Lockfile updated successfully"
fi

# Add and commit the lockfile
echo -e "\n📝 Committing lockfile changes..."
git add pnpm-lock.yaml
git commit -m "fix: sync pnpm lockfile with new website dependencies

- Added missing dependencies for website app:
  - @supabase/supabase-js
  - cloudinary & next-cloudinary
  - framer-motion
  - react-countup
  - react-floating-whatsapp
  - react-intersection-observer
  - swiper" || echo "⚠️  No changes to commit"

# Push to remote
echo -e "\n🚀 Pushing to remote..."
git push origin main || { echo "❌ Failed to push"; exit 1; }

# Trigger new deployment
echo -e "\n🎯 Triggering Vercel deployment..."
vercel --prod --yes

echo -e "\n✅ Deployment fix complete!"
echo "=================================="
echo "Check your deployment at: https://vercel.com/fx-1000/fashionistas"
