# EventsOS Technology Stack & Dependencies

## Core Dependencies (LOCKED VERSIONS)

```json
{
  "dependencies": {
    "@refinedev/core": "4.57.10",
    "@refinedev/mui": "5.14.4",
    "@refinedev/react-router-v6": "4.5.11",
    "@refinedev/supabase": "5.7.8",
    "@mui/material": "6.5.0",
    "@mui/x-data-grid": "6.19.0",
    "@mui/x-date-pickers": "6.19.0",
    "@mui/icons-material": "6.5.0",
    "@emotion/react": "11.11.4",
    "@emotion/styled": "11.11.5",
    "@supabase/supabase-js": "2.39.7",
    "recharts": "2.12.7",
    "date-fns": "3.3.1",
    "react-hook-form": "7.49.3",
    "zod": "3.22.4"
  },
  "devDependencies": {
    "@types/react": "18.2.48",
    "@types/node": "20.11.5",
    "typescript": "5.3.3"
  }
}
```

## Package Manager Configuration

```bash
# .npmrc
save-exact=true
engine-strict=true
auto-install-peers=true
```

## Node Configuration

```bash
# .nvmrc
18.19.0
```

## Environment Variables

```bash
# .env.local
NEXT_PUBLIC_SUPABASE_URL=https://wnjudgmhabzhcttgyxou.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key_here
NEXT_PUBLIC_SUPABASE_SERVICE_KEY=your_service_key_here
```