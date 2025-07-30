# claude.md — FashionOS (Netlify Build Recovery Mode)

## 1. Project Overview
- **Framework**: Next.js 15.4.5 with App Router
- **UI Library**: Zone UI Kit 4.2.0 (Travel Template)
- **Styling**: TailwindCSS + Material UI
- **Backend**: Supabase
- **Media**: Cloudinary
- **Hosting**: Netlify
- **Package Manager**: pnpm

## 2. Critical Build Requirements
- **Node**: v18+ (set in Netlify env: NODE_VERSION=18)
- **Build Command**: `pnpm install && pnpm run build`
- **Publish Directory**: `.next`
- **Package Manager**: pnpm (ensure `pnpm-lock.yaml` exists)

## 3. Editing Rules for Claude Code
### ✅ SAFE TO MODIFY
- Text content, headlines, descriptions
- Image src paths (maintain asset structure)
- Color tokens in theme configuration
- Environment variables in `.env.local`
- Minor style adjustments (spacing, fonts)

### ❌ NEVER MODIFY WITHOUT TESTING
- Component structure or imports
- Layout.jsx logic blocks
- Theme provider configuration
- Build configuration files
- Package dependencies

### 🔧 ALWAYS VALIDATE
```bash
pnpm run lint      # Fix linting errors
pnpm run build     # Ensure successful build
```

## 4. Build & Deploy Commands
```bash
# Local Development
pnpm install       # Install dependencies
pnpm run dev       # Start dev server
pnpm run lint      # Run linter
pnpm run build     # Production build
pnpm run start     # Preview production build

# Netlify Deploy
git add .
git commit -m "fix: description"
git push origin main
# Then trigger redeploy in Netlify dashboard
```

## 5. Netlify Configuration
### netlify.toml
```toml
[build]
  command = "pnpm install && pnpm run build"
  publish = ".next"

[build.environment]
  NODE_VERSION = "18"
  NPM_FLAGS = "--version"
```

### Environment Variables (Set in Netlify Dashboard)
- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- `NODE_VERSION=18`

## 6. Common Build Errors & Solutions

### JSX Syntax Errors
- **Issue**: Unclosed JSX comments `{/**` without `*/}`
- **Fix**: Ensure all JSX comments are properly closed
- **Validate**: Run `pnpm run lint` before committing

### Module Resolution
- **Issue**: Cannot find module errors
- **Fix**: Check imports use correct paths and extensions
- **Validate**: Ensure all dependencies in package.json

### Build Timeouts
- **Issue**: Build exceeds time limit
- **Fix**: Optimize build process, check for infinite loops
- **Solution**: Clear cache and redeploy

## 7. Claude Code Task Guidelines

### Content Updates
1. Read the target file first
2. Make minimal, focused changes
3. Preserve existing formatting
4. Test with `pnpm run build`

### Component Modifications
1. Understand component dependencies
2. Check for prop type definitions
3. Maintain existing patterns
4. Never change core logic without testing

### Safe Content Update Example
```javascript
// ✅ SAFE: Updating text content
<h1>Welcome to FashionOS</h1>  // Changed from "Welcome to Zone"

// ❌ UNSAFE: Changing component structure
<ThemeProvider {...props}>     // Don't modify provider props
```

## 8. Deployment Recovery Process

### Step 1: Fix Syntax Errors
```bash
pnpm run lint --fix
# Review and fix any remaining errors manually
```

### Step 2: Validate Build Locally
```bash
pnpm install
pnpm run build
# Must complete successfully
```

### Step 3: Commit and Push
```bash
git add .
git commit -m "fix: resolve build errors"
git push origin main
```

### Step 4: Netlify Deploy
1. Go to Netlify Dashboard → Deploys
2. Click "Clear cache and deploy site"
3. Monitor build logs
4. Verify deployment at live URL

## 9. Emergency Rollback
If deployment fails after fixes:
1. In Netlify Dashboard → Deploys
2. Find last successful deploy
3. Click "Publish deploy" on that version
4. Investigate issues in development

## 10. Content Source Files
- Homepage luxury content: `/home/sk/fx/fashionos-homepage-luxury-content.md`
- Apply updates carefully, maintaining Zone UI component structure
- Test all changes with `pnpm run build` before deploying

## Success Metrics
- ✅ `pnpm run build` succeeds locally
- ✅ No ESLint errors
- ✅ Netlify build completes
- ✅ Site loads at production URL
- ✅ All pages render correctly

---
**Last Updated**: 2025-07-30
**Status**: Build Error Fixed - Ready for Deployment