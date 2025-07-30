# 🎯 Mantine Expert Pre-Setup Guide (Fixed)
**Date:** July 2025  
**Status:** Production-Ready ✅  
**Focus:** Clear, Simple, Straightforward

---

## 📋 Quick Start Checklist

```bash
✅ Node.js 20.9.0+
✅ pnpm 8.15.0
✅ Git configured
✅ VS Code ready
```

---

## 🔍 Verified Compatibility Matrix (July 2025)

### ✅ Safe Production Combo (Version Locked)

```json
{
  "dependencies": {
    "next": "15.3.3",
    "react": "19.1.0",
    "react-dom": "19.1.0",
    "@mantine/core": "8.1.3",
    "@mantine/hooks": "8.1.3",
    "@tabler/icons-react": "3.34.0"
  },
  "devDependencies": {
    "typescript": "5.8.3",
    "postcss": "8.5.5",
    "postcss-preset-mantine": "1.17.0",
    "postcss-simple-vars": "7.0.1",
    "@types/react": "19.1.8",
    "@types/node": "22.13.11"
  }
}
```

### ⚠️ Critical Version Rules
1. **All @mantine/* packages MUST have identical versions (8.1.3)**
2. **Next.js 15 supports both React 18.2.0 and React 19.1.0**
3. **Mantine 8.x requires PostCSS configuration**
4. **Use exact versions with `-E` flag to prevent drift**

---

## 🚀 Simple Setup Steps

### Step 1: Check Your System
```bash
node --version    # Must be v20.9.0 or higher
pnpm --version    # Should be 8.15.0
```

### Step 2: Get the Official Template
```bash
# Use ONLY this official template
git clone https://github.com/mantinedev/next-app-template my-app
cd my-app
```

### Step 3: Verify Before Installing
```bash
# Check package.json FIRST
cat package.json | grep -E "@mantine|next|react"
```

### Step 4: Install with Version Lock
```bash
# Install with exact versions
pnpm install
pnpm add @mantine/core@8.1.3 @mantine/hooks@8.1.3 -E
```

### Step 5: Start Development
```bash
pnpm dev
# Visit http://localhost:3000
```

### Step 6: Validate Build
```bash
pnpm build  # Must pass with no errors
```

---

## 🛠️ Troubleshooting

### Common Issues & Quick Fixes

#### 1. Version Mismatch Error
```
Error: Mantine packages version mismatch
```
**Fix:**
```bash
# Check all Mantine versions
pnpm ls @mantine/core @mantine/hooks

# If mismatched, reinstall with exact versions
pnpm add @mantine/core@8.1.3 @mantine/hooks@8.1.3 -E
```

#### 2. React Version Conflict
```
Error: Invalid React version
```
**Fix:**
```bash
# For Next.js 15 + React 19 issues
pnpm add react@19.1.0 react-dom@19.1.0 -E

# OR downgrade to React 18 if needed
pnpm add react@18.2.0 react-dom@18.2.0 -E
```

#### 3. PostCSS Not Working
```
Error: PostCSS plugin missing
```
**Fix:**
```bash
# Install missing dependency
pnpm add postcss-simple-vars -D

# Verify postcss.config.mjs exists
cat postcss.config.mjs

# If missing, create it:
cat > postcss.config.mjs << 'EOF'
export default {
  plugins: {
    'postcss-preset-mantine': {},
    'postcss-simple-vars': {
      variables: {
        'mantine-breakpoint-xs': '36em',
        'mantine-breakpoint-sm': '48em',
        'mantine-breakpoint-md': '62em',
        'mantine-breakpoint-lg': '75em',
        'mantine-breakpoint-xl': '88em',
      },
    },
  },
};
EOF
```

#### 4. Hydration Mismatch
```
Error: Hydration failed
```
**Fix:**
```tsx
// In app/layout.tsx, add suppressHydrationWarning
<html lang="en" suppressHydrationWarning>

// Ensure ColorSchemeScript is present
<head>
  <ColorSchemeScript />
</head>
```

#### 5. TypeScript Errors
```
Error: Cannot find type definitions
```
**Fix:**
```bash
# Install missing types
pnpm add @types/react@19.1.8 @types/node@22.13.11 -D
```

#### 6. Build Fails
```
Error: Build optimization failed
```
**Fix:**
```bash
# Clean everything and rebuild
rm -rf .next node_modules pnpm-lock.yaml
pnpm install
pnpm build
```

---

## ✅ Pre-Setup Validation Script

Save as `validate-setup.sh`:
```bash
#!/bin/bash
echo "🔍 Mantine Pre-Setup Validator"
echo "============================="

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Check Node
NODE_VER=$(node -v | cut -d'.' -f1 | sed 's/v//')
if [ $NODE_VER -ge 20 ]; then
    echo -e "Node.js: ${GREEN}✓${NC} $(node -v)"
else
    echo -e "Node.js: ${RED}✗${NC} Need v20.9.0+"
    exit 1
fi

# Check pnpm
if command -v pnpm &> /dev/null; then
    echo -e "pnpm: ${GREEN}✓${NC} $(pnpm -v)"
else
    echo -e "pnpm: ${RED}✗${NC} Not installed"
    echo "Install with: npm install -g pnpm@8.15.0"
    exit 1
fi

# Check Git
if command -v git &> /dev/null; then
    echo -e "Git: ${GREEN}✓${NC} Installed"
else
    echo -e "Git: ${RED}✗${NC} Not installed"
    exit 1
fi

# Test build if in project directory
if [ -f "package.json" ]; then
    echo -e "\n🏗️  Testing build..."
    if pnpm build > /dev/null 2>&1; then
        echo -e "Build: ${GREEN}✓${NC} Success"
    else
        echo -e "Build: ${RED}✗${NC} Failed"
    fi
fi

echo -e "\n${GREEN}✅ System ready for Mantine!${NC}"
echo "Next step: Clone the template"
```

---

## 📦 What You Get

With the official template:
- ✅ Next.js 15 App Router configured
- ✅ TypeScript with strict mode
- ✅ PostCSS with Mantine preset
- ✅ ESLint & Prettier configured
- ✅ Basic layout structure with AppShell support
- ✅ ColorSchemeScript for dark/light theming
- ✅ All TypeScript types included

---

## 🚫 What NOT to Use

- ❌ **ui.mantine.dev** - Component showcase, NOT a starter template
- ❌ **create-next-app** - Requires manual Mantine setup
- ❌ **Old tutorials** - Many use deprecated Mantine v6/v7 with `sx` prop

---

## 📊 Success Indicators

You know setup is correct when:
1. `pnpm dev` starts without errors
2. No console errors in browser
3. Mantine styles are applied (buttons look styled)
4. Dark/light mode switcher works (if implemented)
5. TypeScript shows no errors
6. `pnpm build` completes successfully

---

## 🆘 Emergency Fixes

### Nuclear Option (Start Fresh)
```bash
# If nothing works, start completely fresh
cd ..
rm -rf my-app
git clone https://github.com/mantinedev/next-app-template my-app-fresh
cd my-app-fresh
pnpm install
pnpm add @mantine/core@8.1.3 @mantine/hooks@8.1.3 -E
pnpm dev
```

### Version Lock Everything
```bash
# Use exact versions (no ^ or ~)
pnpm add @mantine/core@8.1.3 @mantine/hooks@8.1.3 -E
pnpm add @types/react@19.1.8 @types/node@22.13.11 -D -E
```

---

## 📚 Essential Links

- **Official Template:** https://github.com/mantinedev/next-app-template
- **Mantine Docs:** https://mantine.dev/getting-started/
- **Next.js + Mantine Guide:** https://mantine.dev/guides/next/
- **AppShell Documentation:** https://mantine.dev/core/app-shell/

---

## ✅ Final Checklist Before Development

- [ ] Node.js 20.9.0+ installed
- [ ] pnpm installed and working
- [ ] Official template cloned
- [ ] Dependencies installed without errors
- [ ] All @mantine/* packages at version 8.1.3
- [ ] Dev server running at localhost:3000
- [ ] No console errors
- [ ] Mantine styles visible
- [ ] Build passes successfully
- [ ] TypeScript types installed

---

## 💡 Pro Tips

1. **ui.mantine.dev clarification**: Use it for component examples and patterns, NOT as a project starter
2. **Dark Mode**: Ensure `<ColorSchemeScript />` is in your layout's `<head>`
3. **AppShell**: Consider using Mantine's AppShell for consistent layouts
4. **Exact Versions**: Always use `-E` flag when adding packages to prevent version drift

**Ready to build! 🚀**