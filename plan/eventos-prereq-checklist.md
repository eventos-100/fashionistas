# EventsOS Pre-Setup Requirements Checklist

## 🖥️ System Requirements

### Hardware Minimums
- [ ] **CPU**: 4+ cores (8+ recommended for development)
- [ ] **RAM**: 8GB minimum (16GB recommended)
- [ ] **Storage**: 20GB free space for dependencies and builds
- [ ] **Network**: Stable internet connection (for package downloads)

### Operating System
- [ ] **macOS**: 12.0+ (Monterey or later)
- [ ] **Linux**: Ubuntu 20.04+, Debian 11+, or RHEL 8+
- [ ] **Windows**: Windows 10+ with WSL2 configured
- [ ] **Shell**: Bash or Zsh (PowerShell not recommended)

## 🛠️ Required Software

### Core Development Tools
- [ ] **Node.js**: v18.17.0 or higher (v20.x supported)
  ```bash
  node --version  # Should output v18.17.0+
  ```

- [ ] **pnpm**: Version 8.15.1 EXACTLY
  ```bash
  npm install -g pnpm@8.15.1
  pnpm --version  # Must be 8.15.1
  ```

- [ ] **Git**: Version 2.34.0+
  ```bash
  git --version  # Should be 2.34.0+
  ```

### IDE/Editor Setup
- [ ] **VS Code** (recommended) with extensions:
  - [ ] ESLint
  - [ ] Prettier
  - [ ] TypeScript Vue Plugin
  - [ ] Tailwind CSS IntelliSense
  - [ ] GitLens
  - [ ] Material Icon Theme

- [ ] **Alternative IDEs**:
  - [ ] WebStorm 2023.2+
  - [ ] Sublime Text with TypeScript plugin
  - [ ] Neovim with CoC.nvim

## 🔑 Service Accounts & Access

### Supabase Requirements
- [ ] **Existing Project**: wnjudgmhabzhcttgyxou
- [ ] **Project URL**: Verified and accessible
- [ ] **Anon Key**: Retrieved from dashboard
- [ ] **Service Role Key**: Retrieved (keep secure!)
- [ ] **Database Access**: Direct connection string available
- [ ] **RLS Policies**: Reviewed and understood

### Third-Party Services (Optional but Recommended)
- [ ] **Vercel Account**: Team or Pro plan for monorepo
- [ ] **GitHub Account**: For version control and CI/CD
- [ ] **SendGrid Account**: API key for email (can add later)
- [ ] **Cloudinary Account**: For image optimization (can add later)
- [ ] **Stripe Account**: For payment processing (can add later)

## 📁 Directory Preparation

### Clean Workspace
- [ ] **Target Directory**: `/home/sk/fx/eventos` exists and is EMPTY
  ```bash
  mkdir -p /home/sk/fx/eventos
  ls -la /home/sk/fx/eventos  # Should be empty
  ```

- [ ] **Permissions**: Full read/write access
  ```bash
  touch /home/sk/fx/eventos/test.txt
  rm /home/sk/fx/eventos/test.txt
  ```

- [ ] **No Conflicts**: No existing git repo or node_modules
  ```bash
  cd /home/sk/fx/eventos
  ls -la  # Should show no .git or node_modules
  ```

## 🌐 Network & Security

### Development Environment
- [ ] **Ports Available**:
  - [ ] 3000 (Website)
  - [ ] 3001 (Admin)
  - [ ] 5432 (PostgreSQL if local)
  - [ ] 54321 (Supabase Studio if local)

- [ ] **Firewall Rules**:
  - [ ] Outbound HTTPS (443) allowed
  - [ ] NPM registry accessible
  - [ ] GitHub accessible
  - [ ] Vercel deployment endpoints accessible

### Environment Variables Template
- [ ] Create `.env.example` template ready
- [ ] Understand difference between:
  - [ ] `.env.local` (development)
  - [ ] `.env.production` (production)
  - [ ] Server-only vs. client variables

## 📚 Knowledge Prerequisites

### Technical Understanding
- [ ] **TypeScript**: Basic to intermediate knowledge
- [ ] **React 18+**: Hooks, Context, Server Components basics
- [ ] **Next.js 14**: App Router vs Pages Router differences
- [ ] **PostgreSQL**: Basic SQL and RLS concepts
- [ ] **Git**: Branching, merging, conventional commits

### Architecture Understanding
- [ ] **Monorepo Concepts**: Workspaces, shared packages
- [ ] **SSR vs CSR**: When to use each
- [ ] **RLS (Row Level Security)**: Supabase implementation
- [ ] **CI/CD Pipeline**: Basic GitHub Actions knowledge

## ✅ Final Pre-Flight Checks

### Terminal Setup
```bash
# Check all tools are installed
which node && node --version
which pnpm && pnpm --version
which git && git --version

# Set Node.js memory limit
echo 'export NODE_OPTIONS="--max_old_space_size=4096"' >> ~/.bashrc
source ~/.bashrc

# Verify pnpm global bin is in PATH
pnpm config get global-bin-dir
```

### Global NPM Packages
```bash
# Install global utilities
npm install -g vercel@latest
npm install -g @supabase/cli@latest
npm install -g turbo@latest
```

### SSH Keys & Authentication
- [ ] GitHub SSH key configured
- [ ] Vercel CLI authenticated (if deploying)
- [ ] Supabase CLI authenticated (if using)

## 🚨 Common Pre-Setup Issues

### Issue: Wrong pnpm Version
```bash
# Fix: Uninstall and reinstall exact version
npm uninstall -g pnpm
npm install -g pnpm@8.15.1
```

### Issue: Node Version Mismatch
```bash
# Fix: Use nvm to manage versions
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install 18
nvm use 18
```

### Issue: Permission Denied
```bash
# Fix: Check directory ownership
sudo chown -R $(whoami) /home/sk/fx/eventos
```

## ✅ Ready to Proceed?

If all items above are checked, you're ready to begin the EventsOS implementation!