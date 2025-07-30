# 🔧 CopilotKit Form-Filling Troubleshooting Guide

## 🚨 Common Issues & Solutions

### 1. Build Manifest Errors (ENOENT)

**Symptoms:**
```
ENOENT: no such file or directory, open '.next/server/app/page/app-build-manifest.json'
```

**Root Cause:** Turbopack file generation race condition

**Solution:**
```bash
# Clean build
rm -rf .next
rm -rf node_modules/.cache

# Use standard webpack instead of turbopack
npm run dev -- --no-turbo

# Or fix permissions
chmod -R 755 .next
```

### 2. Peer Dependency Conflicts

**Symptoms:**
```
npm ERR! peer dep missing: date-fns@^2.28.0 || ^3.0.0, required by react-day-picker@8.10.1
```

**Solution:**
```bash
# Option 1: Use pnpm (recommended)
rm -rf node_modules package-lock.json
pnpm install

# Option 2: Fix versions
npm install date-fns@3.6.0 react-day-picker@8.10.1 --save
```

### 3. Too Many Open Files (EMFILE)

**Symptoms:**
```
Error: EMFILE: too many open files, watch
```

**Permanent Solution:**
```bash
# Linux/Mac
echo "fs.inotify.max_user_watches=524288" | sudo tee -a /etc/sysctl.conf
echo "fs.inotify.max_user_instances=512" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Also increase ulimit
echo "* soft nofile 65536" | sudo tee -a /etc/security/limits.conf
echo "* hard nofile 65536" | sudo tee -a /etc/security/limits.conf
```

### 4. CopilotKit Not Responding

**Symptoms:**
- Chat widget doesn't appear
- No response from AI
- Console errors about API

**Diagnostics:**
```javascript
// Add to app/layout.tsx
<CopilotKit 
  publicApiKey={process.env.NEXT_PUBLIC_COPILOT_PUBLIC_API_KEY}
  showDevConsole={true}  // Enable debug mode
  onError={(error) => console.error('CopilotKit Error:', error)}
>
```

**Solutions:**
1. Verify API key format: Must start with `ck_pub_`
2. Check browser console for CORS errors
3. Validate API key at https://cloud.copilotkit.ai
4. Check rate limits (default: 100 requests/minute)

### 5. Form State Not Syncing with AI

**Symptoms:**
- AI doesn't see current form values
- Form updates don't reflect AI suggestions

**Solution:**
```tsx
// Ensure proper dependency array
useCopilotReadable({
  description: "Current form state",
  value: form.watch()  // Use watch() for real-time updates
}, [form.watch()]); // Add dependency

// Debug form state
useEffect(() => {
  console.log('Form state:', form.getValues());
}, [form.watch()]);
```

### 6. Production Build Failures

**Symptoms:**
- `npm run build` fails
- Type errors only in production

**Diagnostic Script:**
```bash
# Run production checks
NODE_ENV=production npm run type-check
NODE_ENV=production npm run lint
NODE_ENV=production npm run build
```

### 7. Memory Leaks in Development

**Symptoms:**
- Increasing memory usage
- Browser becomes sluggish

**Solution:**
```tsx
// Add cleanup to components
useEffect(() => {
  return () => {
    // Cleanup subscriptions
    form.reset();
  };
}, []);
```

## 🛠️ Diagnostic Commands

```bash
# Full system check
npm run diagnose

# Check dependencies
npm ls @copilotkit/react-core
npm audit

# Verify environment
node -e "console.log(process.env.NEXT_PUBLIC_COPILOT_PUBLIC_API_KEY?.slice(0,10) + '...')"

# Test API connectivity
curl -X POST https://api.copilotkit.ai/v1/health \
  -H "Authorization: Bearer $NEXT_PUBLIC_COPILOT_PUBLIC_API_KEY"
```

## 📊 Performance Optimization

### Reduce Bundle Size
```bash
# Analyze bundle
npm install --save-dev @next/bundle-analyzer
ANALYZE=true npm run build
```

### Enable SWC Minification
```javascript
// next.config.ts
export default {
  swcMinify: true,
  compiler: {
    removeConsole: process.env.NODE_ENV === 'production'
  }
}
```

### Optimize CopilotKit Loading
```tsx
// Lazy load CopilotKit UI
const CopilotPopup = dynamic(
  () => import('@copilotkit/react-ui').then(mod => mod.CopilotPopup),
  { ssr: false }
);
```

## 🔍 Debug Mode

Create `.env.development`:
```bash
NEXT_PUBLIC_COPILOT_DEBUG=true
NEXT_PUBLIC_API_TIMEOUT=30000
```

Add debug wrapper:
```tsx
// lib/debug.ts
export function debugLog(message: string, data?: any) {
  if (process.env.NEXT_PUBLIC_COPILOT_DEBUG === 'true') {
    console.log(`[CopilotKit Debug] ${message}`, data);
  }
}
```

## 📞 Getting Help

1. **Check Logs:** `tail -f .next/server/logs/error.log`
2. **CopilotKit Status:** https://status.copilotkit.ai
3. **Community:** https://discord.gg/copilotkit
4. **Issues:** https://github.com/CopilotKit/CopilotKit/issues

## Emergency Rollback

```bash
# Quick rollback script
git stash
git checkout main
git pull origin main
npm ci
npm run build
npm start
```