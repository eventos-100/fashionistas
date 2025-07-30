#!/bin/bash
echo "🔧 CopilotKit Production Fix Script"

# Fix file descriptor limits
echo "fs.inotify.max_user_watches=524288" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Clean and rebuild
rm -rf .next node_modules
pnpm install

# Fix .gitignore
echo ".env*" >> .gitignore
echo ".next/" >> .gitignore

# Rebuild
pnpm run build

echo "✅ Fixes applied"