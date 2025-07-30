# 🚀 EventsOS Quick Start Guide
## Get Zone Template Running for Fashion Events in 10 Minutes

---

## ✅ **Pre-Requirements Check**

Run these commands to verify your system:

```bash
# Check Node.js version (need 20+)
node --version

# Check npm is available  
npm --version

# Verify you're in the right directory
pwd
# Should show: /home/sk/fx/eventos
```

**Expected Output:**
```
node --version: v20.x.x or higher ✅
npm --version: 9.x.x or higher ✅  
pwd: /home/sk/fx/eventos ✅
```

---

## 🎯 **10-Minute Setup Process**

### Step 1: Navigate to Zone Template (30 seconds)
```bash
cd /home/sk/fx/eventos/zone-template
ls -la
# Should see: package.json, src/, public/, etc.
```

### Step 2: Install Dependencies (3-4 minutes)
```bash
# Clean install (recommended)
npm run clean
npm install

# Alternative if issues:
rm -rf node_modules package-lock.json
npm install
```

**Expected Output:**
```
✅ Dependencies installed successfully
✅ No security vulnerabilities found
✅ Node modules folder created
```

### Step 3: Start Development Server (30 seconds)
```bash
# Start with Turbopack (faster)
npm run dev

# Alternative (standard)
npm start
```

**Expected Output:**
```
▲ Next.js 15.3.4
- Local: http://localhost:3012
- Ready in 1.2s
```

### Step 4: Verify Template Works (2 minutes)
Open browser and test these URLs:

1. **Main Landing**: http://localhost:3012
2. **Travel Section**: http://localhost:3012/travel  
3. **Travel About**: http://localhost:3012/travel/about
4. **Tours Listing**: http://localhost:3012/travel/tours

**✅ Success Criteria:**
- All pages load without errors
- No console errors in browser DevTools
- Responsive design works on mobile view
- Navigation works between pages

### Step 5: First Customization Test (3 minutes)
Let's make a simple change to verify we can customize:

```bash
# Open the travel landing page
nano src/app/travel/(landing)/page.jsx
# OR use your preferred editor
```

Find this line (around line 15):
```jsx
<Typography variant="h1">
  Discover Amazing Destinations
</Typography>
```

Change it to:
```jsx
<Typography variant="h1">
  Discover Amazing Fashion Events
</Typography>
```

Save the file and check browser - should auto-reload with new text.

**✅ Success**: Page shows "Discover Amazing Fashion Events"

---

## 🔍 **Verification Checklist**

After completing setup, verify everything works:

### ✅ Development Environment
- [ ] Development server starts on port 3012
- [ ] Hot reloading works (changes appear instantly)
- [ ] No errors in terminal console
- [ ] No errors in browser console

### ✅ Page Loading
- [ ] Homepage loads (/) 
- [ ] Travel section loads (/travel)
- [ ] All travel sub-pages load
- [ ] Images display correctly
- [ ] Navigation menus work

### ✅ Responsive Design
- [ ] Desktop view (1200px+) looks good
- [ ] Tablet view (768px) works
- [ ] Mobile view (375px) is functional
- [ ] Touch interactions work on mobile

### ✅ Performance
- [ ] Pages load in under 3 seconds
- [ ] Smooth scrolling and animations
- [ ] No layout shift issues
- [ ] Images load progressively

---

## 🛠️ **Common Setup Issues & Solutions**

### Issue: Port 3012 Already in Use
```bash
# Find what's using port 3012
lsof -ti:3012

# Kill the process
lsof -ti:3012 | xargs kill -9

# Or use different port
npm run dev -- -p 3013
```

### Issue: Node Version Too Old
```bash
# Check current version
node --version

# Install Node 20+ using nvm (if available)
nvm install 20
nvm use 20

# Or download from nodejs.org
```

### Issue: Dependencies Won't Install
```bash
# Clear npm cache
npm cache clean --force

# Delete lock file and node_modules
rm -rf node_modules package-lock.json

# Reinstall
npm install

# If still issues, try yarn:
npm install -g yarn
yarn install
```

### Issue: Build Errors with MUI v7
```bash
# MUI v7 is bleeding edge, if issues:
# 1. Check browser console for specific errors
# 2. Ensure all @mui packages are same version
# 3. Clear .next cache:
rm -rf .next
npm run dev
```

### Issue: Turbopack Errors
```bash
# Fall back to standard webpack
npm run dev -- --no-turbopack

# Or use standard start
npm start
```

---

## 📋 **Next Steps After Setup**

Once you have the Zone template running:

### Immediate (Today)
1. **[Page Mapping](../02-zone-adaptation/page-mapping.md)** - Plan travel → events conversion
2. **[Content Guide](../02-zone-adaptation/content-guide.md)** - Start content replacement
3. **[Asset Replacement](../02-zone-adaptation/asset-replacement.md)** - Gather fashion event images

### This Week  
1. **Convert Landing Page** - Change hero section for fashion events
2. **Update Navigation** - Change "Tours" to "Events"
3. **Replace Sample Content** - Add real fashion event data
4. **Test Mobile Experience** - Ensure mobile-first design

### Next Week
1. **Add EventsOS Features** - Registration forms, event details
2. **Integrate Backend** - Supabase setup for events data
3. **Payment Integration** - Stripe for event tickets
4. **Performance Optimization** - Lighthouse score 90+

---

## 🎯 **Development Workflow**

### Daily Development Routine
```bash
# 1. Start development
cd /home/sk/fx/eventos/zone-template
npm run dev

# 2. Make changes in src/
# 3. Test in browser (auto-reloads)
# 4. Check console for errors

# 5. Before committing
npm run lint
npm run build  # Test production build
```

### File Structure Quick Reference
```
zone-template/
├── src/
│   ├── app/travel/          # 🎯 Main area to customize
│   ├── components/          # Reusable UI components
│   ├── sections/            # Page sections
│   └── theme/              # MUI theme customization
├── public/
│   └── assets/             # Images, icons, static files
└── package.json            # Dependencies & scripts
```

### Key Files to Customize
- `src/app/travel/(landing)/page.jsx` - Main landing page
- `src/app/travel/tours/page.jsx` - Events listing page  
- `src/app/travel/about/page.jsx` - About page
- `src/theme/palette.js` - Color scheme
- `public/assets/images/` - All images

---

## 📞 **Getting Help**

### If Setup Fails
1. **Check Node.js version**: Must be 20+
2. **Try different terminal**: Some terminals have path issues
3. **Check disk space**: Node modules need ~500MB
4. **Try different port**: Use `npm run dev -- -p 3013`

### If Pages Don't Load
1. **Check browser console**: Look for JavaScript errors
2. **Check network tab**: See if resources fail to load  
3. **Try incognito mode**: Eliminate browser cache issues
4. **Test different browser**: Rule out browser-specific issues

### Resources
- **Zone Template Demo**: https://zone-ui.vercel.app/travel/
- **Next.js Docs**: https://nextjs.org/docs
- **MUI v7 Docs**: https://mui.com/
- **Project Issues**: Check `/home/sk/fx/eventos/docs/` for solutions

---

**🎉 Success Indicator**: When you see "Discover Amazing Fashion Events" in your browser at http://localhost:3012/travel, you're ready for the next phase!

**⏱️ Total Time**: Should complete in 8-12 minutes maximum  
**🔧 Next Guide**: [Zone Adaptation Strategy](../02-zone-adaptation/page-mapping.md)
