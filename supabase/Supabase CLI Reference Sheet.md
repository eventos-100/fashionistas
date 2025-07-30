# Supabase CLI Reference Sheet - Complete Guide for FashionOS

## 📋 Project Connection Details

### Project Information
- **Project Name**: fashionos
- **Project ID**:wnjudgmhabzhcttgyxou
- **Project URL**:https://wnjudgmhabzhcttgyxou.supabase.co
Password - Toronto2025#

postgresql://postgres:[YOUR-PASSWORD]@db.wnjudgmhabzhcttgyxou.supabase.co:5432/postgres
postgresql://postgres:Toronto2025@db.wnjudgmhabzhcttgyxou.supabase.co:5432/postgres

anonpublic eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InduanVkZ21oYWJ6aGN0dGd5eG91Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMwOTIzODIsImV4cCI6MjA2ODY2ODM4Mn0.0Qmbqqq2h4-WzoknUdcdL6WPyKaaAF6HSgxJkggRwGA

service_rolesecret
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InduanVkZ21oYWJ6aGN0dGd5eG91Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1MzA5MjM4MiwiZXhwIjoyMDY4NjY4MzgyfQ.QX2B9KAU2mXfia0G5mz5ZwbD5dE1QDpYnaA-EqxICLc



### Environment Variables
```bash
# Public Keys (Frontend)
NEXT_PUBLIC_SUPABASE_URL=https://ardqtktktptejvrsbncj.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFyZHF0a3RrdHB0ZWp0ZWp2cnNibmNqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI1NDUzNjEsImV4cCI6MjA2ODEyMTM2MX0.QtBCNZq5jEorUCWd8LmuDWNyan5Yik5eLMuRTORQNiA

# Secret Keys (Backend Only)
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJja3h6bHRwZHF2cHZ2bHFlcnhoIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1MjIwMzQ3MywiZXhwIjoyMDY3Nzc5NDczfQ.Zi6BKGv4mahE6sOfb8u-ZYfg-njJ1ed1saaPt1vAV7g
SUPABASE_ACCESS_TOKEN=sbp_103bf6af613ca6e106c3d71cf58d496073d1817f
SUPABASE_DB_PASSWORD=Toronto2025#
```

---

## 🚀 Supabase CLI Installation & Setup

### 1. Install Supabase CLI

#### **macOS (Homebrew)**
```bash
brew install supabase/tap/supabase
```

#### **Linux (via script)**
```bash
curl -fsS https://download.supabase.com/linux/apt/gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/supabase-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/supabase-archive-keyring.gpg] https://download.supabase.com/linux/apt stable main" | sudo tee /etc/apt/sources.list.d/supabase.list
sudo apt-get update
sudo apt-get install supabase
```

#### **NPM (as dev dependency)**
```bash
npm install -D supabase
```

#### **Verify Installation**
```bash
supabase --version
```

### 2. Prerequisites
- **Docker**: Required for running local Supabase stack
- **Node.js & npm**: For managing dependencies
- **Git**: For version control

---

## 🔧 Local Development Setup

### 1. Initialize Supabase Project
```bash
# Create project directory
mkdir fashionos && cd fashionos

# Initialize Supabase
supabase init

# This creates:
# - supabase/config.toml (configuration file)
# - supabase/migrations/ (database migrations)
# - supabase/functions/ (edge functions)
# - supabase/seed.sql (seed data)
```

### 2. Start Local Development Stack
```bash
# Start all Supabase services
supabase start

# First run downloads Docker images (takes time)
# Output shows:
# API URL: http://localhost:54321
# DB URL: postgresql://postgres:postgres@localhost:54322/postgres
# Studio URL: http://localhost:54323
# Inbucket URL: http://localhost:54324
# anon key: eyJh......
# service_role key: eyJh......
```

### 3. Connect to Remote Project
```bash
# Login with access token
supabase login --token sbp_103bf6af613ca6e106c3d71cf58d496073d1817f

# Link to remote project
supabase link --project-ref ardqtktktptejvrsbncj
# Enter password when prompted: Toronto2025#

# Verify connection
supabase status
```

---

## 📊 Creating Tables with Supabase CLI

### Method 1: Using Migrations (Recommended)

#### **Step 1: Create Migration File**
```bash
# Generate new migration file
supabase migration new create_events_table

# Creates: supabase/migrations/<timestamp>_create_events_table.sql
```

#### **Step 2: Write SQL in Migration File**
```sql
-- supabase/migrations/<timestamp>_create_events_table.sql

-- Create events table
CREATE TABLE IF NOT EXISTS public.events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    description TEXT,
    event_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME,
    status TEXT DEFAULT 'draft' CHECK (status IN ('draft', 'published', 'sold_out', 'cancelled', 'completed')),
    target_attendance INTEGER DEFAULT 100,
    current_attendance INTEGER DEFAULT 0,
    organizer_id UUID REFERENCES auth.users(id),
    venue_name TEXT,
    venue_address TEXT,
    featured_image TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for performance
CREATE INDEX idx_events_status ON public.events(status);
CREATE INDEX idx_events_date ON public.events(event_date);
CREATE INDEX idx_events_slug ON public.events(slug);

-- Enable Row Level Security
ALTER TABLE public.events ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
CREATE POLICY "Public can view published events" ON public.events
    FOR SELECT
    USING (status = 'published');

CREATE POLICY "Authenticated users can create events" ON public.events
    FOR INSERT
    WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "Organizers can update own events" ON public.events
    FOR UPDATE
    USING (auth.uid() = organizer_id);

-- Create update trigger for updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_events_updated_at BEFORE UPDATE ON public.events
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
```

#### **Step 3: Apply Migration Locally**
```bash
# Reset database and apply all migrations
supabase db reset

# Or apply without resetting
supabase migration up
```

### Method 2: Using Studio UI + CLI Diff

#### **Step 1: Create Table in Studio**
1. Visit http://localhost:54323 (local Studio)
2. Go to Table Editor
3. Create table with UI
4. Add columns and configure

#### **Step 2: Generate Migration from Changes**
```bash
# Generate diff from current state
supabase db diff --schema public

# Output shows SQL changes
# Save output to migration file
supabase db diff --schema public -f create_table_from_ui
```

### Method 3: Using Direct SQL + Migration

```bash
# Create migration from existing SQL file
supabase migration new import_schema < my_schema.sql

# Or pipe from echo
echo "CREATE TABLE test (id int);" | supabase migration new test_table
```

---

## 🔄 Database Migration Commands

### Core Migration Commands

```bash
# Create new migration
supabase migration new <migration_name>

# List all migrations
supabase migration list

# Apply migrations locally
supabase db reset  # Resets DB and applies all migrations

# Check migration status
supabase migration list --db-url <connection_string>
```

### Working with Remote Database

```bash
# Pull remote schema changes
supabase db pull
# Creates: supabase/migrations/<timestamp>_remote_schema.sql

# Push local migrations to remote
supabase db push

# Diff local vs remote
supabase db diff --linked

# Dump remote database
supabase db dump --data-only > backup.sql
supabase db dump --schema-only > schema.sql
```

---

## 🌱 Seeding Data

### 1. Create Seed File
```sql
-- supabase/seed.sql

-- Insert test events
INSERT INTO public.events (title, slug, description, event_date, start_time, status, target_attendance, venue_name)
VALUES 
    ('Fashion Week Colombia 2025', 'fashion-week-2025', 'Premier fashion showcase', '2025-09-15', '14:00', 'published', 500, 'Plaza Mayor'),
    ('Designer Showcase', 'designer-showcase', 'Emerging designers', '2025-08-20', '18:00', 'published', 200, 'Art Museum'),
    ('VIP Preview', 'vip-preview', 'Exclusive preview', '2025-09-14', '19:00', 'draft', 100, 'Private Venue');

-- Insert test users (if not using auth)
INSERT INTO auth.users (id, email, raw_user_meta_data)
VALUES 
    ('550e8400-e29b-41d4-a716-446655440001', 'admin@fashionos.co', '{"role": "admin"}'),
    ('550e8400-e29b-41d4-a716-446655440002', 'designer@fashionos.co', '{"role": "designer"}');
```

### 2. Apply Seed Data
```bash
# Seed is automatically applied after migrations during:
supabase db reset

# Or manually seed
psql $DATABASE_URL -f supabase/seed.sql
```

---

## 🛠️ Common CLI Workflows

### Complete Development Workflow

```bash
# 1. Start local development
supabase start

# 2. Create migration
supabase migration new add_products_table

# 3. Edit migration file
# Add your SQL...

# 4. Apply locally
supabase db reset

# 5. Test your changes
# Use Studio or your app...

# 6. Generate TypeScript types
supabase gen types typescript --local > src/types/supabase.ts

# 7. Push to remote
supabase db push

# 8. Stop local stack
supabase stop
```

### Database Management

```bash
# View all tables
supabase db lint

# Inspect database
supabase inspect db bloat          # Find bloated tables
supabase inspect db blocking        # Find blocking queries
supabase inspect db cache-hit       # Cache hit rates
supabase inspect db calls           # Most frequently called functions
supabase inspect db index-sizes     # Index sizes
supabase inspect db index-usage     # Index usage stats
supabase inspect db locks           # Current locks
supabase inspect db long-running-queries  # Long queries
supabase inspect db outliers        # Query outliers
supabase inspect db replication-slots    # Replication info
supabase inspect db role-connections     # Connections by role
supabase inspect db seq-scans       # Sequential scans
supabase inspect db table-sizes     # Table sizes
supabase inspect db total-index-size     # Total index size
supabase inspect db unused-indexes  # Unused indexes
supabase inspect db vacuum-stats    # Vacuum statistics
```

---

## 📝 Best Practices

### 1. Migration Naming Convention
```bash
# Use descriptive names with action_object format
supabase migration new create_users_table
supabase migration new add_email_to_users
supabase migration new create_index_on_users_email
```

### 2. Migration Organization
```
supabase/
├── migrations/
│   ├── 20240101000001_create_users_table.sql
│   ├── 20240101000002_create_events_table.sql
│   ├── 20240101000003_add_indexes.sql
│   └── 20240101000004_create_rls_policies.sql
├── seed.sql
└── config.toml
```

### 3. Development Tips
- Always test migrations locally before pushing
- Use `supabase db reset` frequently during development
- Keep migrations small and focused
- Don't edit migrations after they're deployed
- Use declarative schemas for complex views/functions

### 4. Production Deployment
```bash
# Use CI/CD for production deployments
# Example GitHub Action:
- name: Setup Supabase CLI
  uses: supabase/setup-cli@v1
  with:
    version: latest

- name: Link to project
  run: supabase link --project-ref ${{ secrets.SUPABASE_PROJECT_ID }}
  env:
    SUPABASE_ACCESS_TOKEN: ${{ secrets.SUPABASE_ACCESS_TOKEN }}

- name: Push database changes
  run: supabase db push
  env:
    SUPABASE_DB_PASSWORD: ${{ secrets.SUPABASE_DB_PASSWORD }}
```

---

## 🔗 Connection Methods Reference

### 1. Direct psql Connection
```bash
# Using pooler (recommended)
psql "postgresql://postgres.ardqtktktptejvrsbncj:Toronto2025%23@aws-0-us-east-2.pooler.supabase.com:5432/postgres"

# Direct connection
psql "postgresql://postgres:Toronto2025#@db.ardqtktktptejvrsbncj.supabase.co:5432/postgres"
```

### 2. JavaScript/TypeScript Client
```javascript
import { createClient } from '@supabase/supabase-js'

// Frontend client
const supabase = createClient(
  'https://ardqtktktptejvrsbncj.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFyZHF0a3RrdHB0ZWp0ZWp2cnNibmNqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI1NDUzNjEsImV4cCI6MjA2ODEyMTM2MX0.QtBCNZq5jEorUCWd8LmuDWNyan5Yik5eLMuRTORQNiA'
)

// Backend admin client
const supabaseAdmin = createClient(
  'https://ardqtktktptejvrsbncj.supabase.co',
  process.env.SUPABASE_SERVICE_ROLE_KEY,
  {
    auth: {
      autoRefreshToken: false,
      persistSession: false
    }
  }
)
```

---

## 🚨 Troubleshooting

### Common Issues

#### 1. Docker not running
```bash
# Error: Cannot connect to Docker daemon
# Solution: Start Docker Desktop
```

#### 2. Port conflicts
```bash
# Error: Port 54321 already in use
# Solution:
supabase stop --no-backup
# Or change port in config.toml
```

#### 3. Migration conflicts
```bash
# Error: Migration already exists
# Solution:
supabase migration repair --status applied <timestamp>
```

#### 4. Authentication issues
```bash
# Error: Invalid access token
# Solution:
supabase logout
supabase login --token <new_token>
```

---

## 📚 Additional Resources

- **Official Docs**: https://supabase.com/docs/guides/cli
- **Migration Guide**: https://supabase.com/docs/guides/deployment/database-migrations
- **Local Development**: https://supabase.com/docs/guides/local-development
- **CLI Reference**: https://supabase.com/docs/reference/cli/introduction

---

## 🎯 Quick Reference Commands

```bash
# Essential commands
supabase init                      # Initialize project
supabase start                     # Start local stack
supabase stop                      # Stop local stack
supabase status                    # Check status
supabase link                      # Link to remote
supabase db reset                  # Reset and migrate
supabase migration new <name>      # Create migration
supabase db push                   # Push to remote
supabase gen types typescript      # Generate types
```

**Remember**: Always test locally before pushing to production!