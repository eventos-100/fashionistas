# FashionOS Quick Setup - 15 Minutes

## 🎯 Get Started Now

**Goal**: FashionOS running locally in 15 minutes
**What you get**: Working admin + website with database

---

## 📋 Quick Checklist

| Step | Command | Time | Status |
|------|---------|------|--------|
| 1 | Install tools | 3 min | ⬜ |
| 2 | Create project | 2 min | ⬜ |
| 3 | Add environment | 3 min | ⬜ |
| 4 | Install & run | 7 min | ⬜ |

---

## 🚀 Step 1: Install Tools (3 minutes)

```bash
# Check Node.js (need 18+)
node --version

# If not 18+, install:
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install pnpm
npm install -g pnpm@9.7.0

# Install Supabase CLI
pnpm add -g @supabase/cli
```

**Test**: `node --version` and `pnpm --version` should work

---

## 🚀 Step 2: Create Project (2 minutes)

```bash
# Create directory
mkdir ~/fashionos && cd ~/fashionos

# Create basic structure
mkdir -p apps/{admin,website}

# Initialize workspace
cat > package.json << 'EOF'
{
  "name": "fashionos",
  "private": true,
  "workspaces": ["apps/*"],
  "scripts": {
    "dev": "pnpm -r --parallel dev"
  }
}
EOF

cat > pnpm-workspace.yaml << 'EOF'
packages:
  - 'apps/*'
EOF
```

**Test**: `ls apps/` should show admin and website folders

---

## 🚀 Step 3: Add Environment (3 minutes)

```bash
# Create environment file
cat > .env.local << 'EOF'
# Supabase (your actual credentials)
NEXT_PUBLIC_SUPABASE_URL=https://wnjudgmhabzhcttgyxou.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InduanVkZ21oYWJ6aGN0dGd5eG91Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMwOTIzODIsImV4cCI6MjA2ODY2ODM4Mn0.0Qmbqqq2h4-WzoknUdcdL6WPyKaaAF6HSgxJkggRwGA
SUPABASE_SERVICE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InduanVkZ21oYWJ6aGN0dGd5eG91Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1MzA5MjM4MiwiZXhwIjoyMDY4NjY4MzgyfQ.QX2B9KAU2mXfia0G5mz5ZwbD5dE1QDpYnaA-EqxICLc

# Cloudinary 
CLOUDINARY_URL=cloudinary://314599957976619:aoiYMvb6YMjgF4IfBvbt9yhauiY@dzqy2ixl0
NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME=dzqy2ixl0
EOF

# Copy to both apps
cp .env.local apps/admin/
cp .env.local apps/website/
```

**Test**: `cat .env.local` should show your credentials

---

## 🚀 Step 4: Install & Run (7 minutes)

### Create Admin App
```bash
cd apps/admin

# Create Next.js app with Refine
npx create-refine-app@latest . \
  --preset refine-mui \
  --package-manager pnpm \
  --skip-git

# Add exact MUI v6 versions
pnpm add @mui/material@6.5.0 @mui/icons-material@6.5.0 --save-exact

# Set port
npm pkg set scripts.dev="next dev -p 3001"
```

### Create Website App
```bash
cd ../website

# Create Next.js app
npx create-next-app@latest . \
  --typescript \
  --tailwind \
  --eslint \
  --app \
  --src-dir \
  --use-pnpm

# Add MUI v6
pnpm add @mui/material@6.5.0 @mui/icons-material@6.5.0 @emotion/react@11.11.4 @emotion/styled@11.11.5 --save-exact

# Set port
npm pkg set scripts.dev="next dev -p 3000"
```

### Start Everything
```bash
cd ~/fashionos

# Install all dependencies
pnpm install

# Start both apps
pnpm dev
```

---

## ✅ Success Check

If everything worked:

- **Website**: http://localhost:3000 (Next.js app)
- **Admin**: http://localhost:3001 (Refine admin)
- **Both should load** without errors

---

## 🚨 Quick Fixes

### If Node.js is too old:
```bash
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### If pnpm fails:
```bash
npm install -g pnpm@9.7.0
```

### If apps won't start:
```bash
cd ~/fashionos
rm -rf node_modules apps/*/node_modules
pnpm install
pnpm dev
```

### If ports are busy:
```bash
# Kill processes on ports
sudo lsof -ti:3000 | xargs kill -9
sudo lsof -ti:3001 | xargs kill -9
```

---

## 🎯 What You Have Now

✅ **Working FashionOS platform**  
✅ **Admin dashboard** (Refine + MUI v6)  
✅ **Marketing website** (Next.js + MUI v6)  
✅ **Database connected** (Supabase)  
✅ **Media ready** (Cloudinary)  

## 🚀 Next Steps

1. **Customize the admin** - Add event management features
2. **Style the website** - Create fashion-focused design
3. **Add database tables** - Set up event/designer schemas
4. **Deploy** - Push to Vercel when ready

**Total time**: ~15 minutes to working FashionOS!