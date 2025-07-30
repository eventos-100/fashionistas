# EventsOS Deployment Fix - Complete Guide

## 🚨 Problem Summary

The deployment failed because the `pnpm-lock.yaml` file is outdated. New dependencies were added to `apps/website/package.json` but the lockfile wasn't updated. Vercel's build environment runs with `--frozen-lockfile` by default, which prevents automatic lockfile updates.

## 🔧 Immediate Fix (Choose ONE approach)

### Option 1: Update Lockfile Locally (RECOMMENDED)

```bash
# 1. Navigate to project root
cd /home/sk/fx/eventos

# 2. Install pnpm globally if not already installed
npm install -g pnpm@9.7.0

# 3. Update the lockfile
pnpm install

# 4. Commit the updated lockfile
git add pnpm-lock.yaml
git commit -m "fix: update pnpm lockfile with new dependencies"
git push origin main

# 5. Deploy again
vercel --prod
```

### Option 2: Force Vercel to Update Lockfile

```bash
# Add environment variable to disable frozen lockfile
vercel env add ENABLE_EXPERIMENTAL_COREPACK 1 production
vercel env add PNPM_FLAGS "--no-frozen-lockfile" production

# Deploy with updated settings
vercel --prod
```

### Option 3: Update Vercel Build Command

```json
// vercel.json
{
  "buildCommand": "pnpm install --no-frozen-lockfile && pnpm run build",
  "outputDirectory": "apps/admin/.next",
  "framework": "nextjs",
  "installCommand": "pnpm install --no-frozen-lockfile"
}
```

## 🧪 Testing Strategy

### Test 1: Lockfile Validation
```bash
# Verify lockfile is up to date
cd /home/sk/fx/eventos
pnpm install --frozen-lockfile --dry-run

# Expected: No errors
```

### Test 2: Local Build Test
```bash
# Test the build locally
cd /home/sk/fx/eventos
pnpm run build --filter=admin

# Expected: Successful build
```

### Test 3: Environment Variables Check
```bash
# Verify all env vars are set
vercel env ls

# Expected output should include:
# - NEXT_PUBLIC_SUPABASE_URL
# - NEXT_PUBLIC_SUPABASE_ANON_KEY
```

### Test 4: Preview Deployment
```bash
# Test with preview deployment first
vercel

# Expected: Successful deployment to preview URL
```

### Test 5: Production Deployment
```bash
# If preview works, deploy to production
vercel --prod

# Expected: Successful production deployment
```

## 🛡️ Error Prevention Strategies

### 1. Pre-commit Hook Setup
```bash
# Add husky for automatic lockfile updates
pnpm add -D husky
npx husky init

# Create pre-commit hook
echo 'pnpm install --frozen-lockfile' > .husky/pre-commit
chmod +x .husky/pre-commit
```

### 2. CI/CD Lockfile Check
```yaml
# .github/workflows/lockfile-check.yml
name: Lockfile Check
on: [push, pull_request]
jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v2
        with:
          version: 9.7.0
      - run: pnpm install --frozen-lockfile
```

### 3. Package Manager Configuration
```json
// package.json (root)
{
  "packageManager": "pnpm@9.7.0",
  "engines": {
    "node": ">=18.0.0",
    "pnpm": "9.7.0"
  }
}
```

## 🔍 Troubleshooting Guide

### Common Issues & Solutions

| Issue | Cause | Solution |
|-------|-------|----------|
| Lockfile mismatch | Dependencies added without updating lockfile | Run `pnpm install` locally |
| Version conflicts | Different pnpm versions | Use exact version: `pnpm@9.7.0` |
| Build timeout | Large dependency tree | Increase memory: `NODE_OPTIONS=--max-old-space-size=8192` |
| Missing dependencies | Workspace misconfiguration | Check `pnpm-workspace.yaml` |

### Debug Commands
```bash
# Check pnpm version
pnpm --version

# Verify workspace configuration
pnpm list --recursive --depth 0

# Check for outdated packages
pnpm outdated

# Validate lockfile integrity
pnpm install --frozen-lockfile --prefer-offline
```

## 🏆 Best Practices

### 1. **Always Update Lockfile**
```bash
# After adding dependencies
pnpm add <package>
git add package.json pnpm-lock.yaml
git commit -m "deps: add <package>"
```

### 2. **Use Exact Versions**
```json
// Prefer exact versions in production
{
  "dependencies": {
    "@supabase/supabase-js": "2.52.1", // Not ^2.52.1
    "cloudinary": "2.7.0"
  }
}
```

### 3. **Workspace Consistency**
```yaml
# pnpm-workspace.yaml
packages:
  - 'apps/*'
  - 'packages/*'
```

### 4. **Environment Sync**
```bash
# Keep local and Vercel env in sync
vercel env pull .env.local
```

## 📊 Missing Components Analysis

### Currently Missing from Setup:

1. **API Keys Not Configured:**
   - SendGrid API Key
   - Stripe Secret Key
   - Twenty CRM API Key
   - WhatsApp Business API Token
   - n8n Webhook URL

2. **Database Migrations:**
   - Supabase schema setup
   - RLS policies
   - Initial seed data

3. **Integration Endpoints:**
   - Webhook receivers
   - API route handlers
   - Real-time subscriptions

### Implementation Priority:

1. **Fix lockfile issue** (IMMEDIATE)
2. **Deploy successfully** (TODAY)
3. **Add remaining env vars** (THIS WEEK)
4. **Set up integrations** (NEXT SPRINT)

## 🚀 Complete Fix Sequence

```bash
# Step 1: Fix lockfile
cd /home/sk/fx/eventos
pnpm install

# Step 2: Verify fix
pnpm install --frozen-lockfile

# Step 3: Commit changes
git add pnpm-lock.yaml
git commit -m "fix: update lockfile for website dependencies"
git push

# Step 4: Deploy
vercel --prod

# Step 5: Verify deployment
curl -I https://fashionistas.vercel.app
```

## ✅ Success Criteria

- [ ] No lockfile errors during build
- [ ] Successful Vercel deployment
- [ ] All Material-UI v6 components render
- [ ] Supabase connection established
- [ ] Admin dashboard accessible

Remember: The lockfile is your source of truth for dependency versions. Always keep it synchronized!