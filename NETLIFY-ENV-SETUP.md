# 🔐 Netlify Environment Variables Setup

## Required Environment Variables

You need to set these in your Netlify dashboard:

### 1. Go to Netlify Dashboard
- Navigate to: Site Settings → Environment Variables
- Click "Add a variable"

### 2. Add These Variables:

#### Supabase Configuration (REQUIRED)
```
NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
```

#### Optional Performance Settings
```
NEXT_TELEMETRY_DISABLED=1
```

### 3. Where to Find Supabase Keys:
1. Go to your Supabase project dashboard
2. Navigate to: Settings → API
3. Copy:
   - `URL` → Use for `NEXT_PUBLIC_SUPABASE_URL`
   - `anon public` key → Use for `NEXT_PUBLIC_SUPABASE_ANON_KEY`

### 4. Add Variables in Netlify:
1. Click "Add a variable"
2. Enter the key name (e.g., `NEXT_PUBLIC_SUPABASE_URL`)
3. Enter the value
4. Click "Save"
5. Repeat for all variables

### 5. Deploy Settings
After adding variables:
1. Go to Deploys tab
2. Click "Trigger deploy" → "Clear cache and deploy site"

## ⚠️ Important Notes:
- Variables starting with `NEXT_PUBLIC_` are exposed to the browser
- Never commit these values to your repository
- After adding variables, you must redeploy for them to take effect

## 🚀 Quick Deploy Command:
Once variables are set, you can deploy via CLI:
```bash
netlify deploy --prod
```

---
**Created**: 2025-07-30
**Purpose**: Environment setup for Netlify deployment