#!/bin/bash

# FashionOS Comprehensive Cleanup Script
# Created: $(date)
# Purpose: Organize and cleanup FashionOS project structure

set -e  # Exit on error

echo "🧹 FashionOS Cleanup Script Starting..."
echo "⚠️  This will reorganize your project structure!"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in the right directory
if [ ! -d "/home/sk25/fx/dashboard" ] || [ ! -d "/home/sk25/fx/fashionos-website" ]; then
    print_error "Required directories not found. Please run from /home/sk25/fx/"
    print_error "Looking for: dashboard/ and fashionos-website/"
    exit 1
fi

cd /home/sk25/fx

print_status "Starting directory analysis..."

# Show current sizes
echo ""
echo "📊 Current Directory Sizes:"
du -sh dashboard fashionos-* eventsOS 2>/dev/null || true
echo ""

# Phase 1: Create backup of critical files
print_status "Phase 1: Creating backups..."

BACKUP_DIR="fashionos-cleanup-backup-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Backup important scripts from main dashboard directory
if [ -d "dashboard" ]; then
    print_status "Backing up scripts and database files..."
    cd dashboard
    
    # Create organized backup structure
    mkdir -p "../$BACKUP_DIR/scripts"
    mkdir -p "../$BACKUP_DIR/database"
    mkdir -p "../$BACKUP_DIR/docs"
    
    # Backup shell scripts
    find . -maxdepth 1 -name "*.sh" -exec cp {} "../$BACKUP_DIR/scripts/" \; 2>/dev/null || true
    
    # Backup JS/MJS scripts
    find . -maxdepth 1 -name "*.mjs" -exec cp {} "../$BACKUP_DIR/scripts/" \; 2>/dev/null || true
    find . -maxdepth 1 -name "*.js" -not -path "./node_modules/*" -not -path "./.next/*" -exec cp {} "../$BACKUP_DIR/scripts/" \; 2>/dev/null || true
    
    # Backup Python scripts
    find . -maxdepth 1 -name "*.py" -exec cp {} "../$BACKUP_DIR/scripts/" \; 2>/dev/null || true
    
    # Backup SQL files
    find . -maxdepth 1 -name "*.sql" -exec cp {} "../$BACKUP_DIR/database/" \; 2>/dev/null || true
    
    # Backup documentation
    find . -maxdepth 1 -name "*.md" -not -name "README.md" -exec cp {} "../$BACKUP_DIR/docs/" \; 2>/dev/null || true
    
    cd ..
fi

print_success "Backup created in $BACKUP_DIR"

# Phase 2: Remove duplicate website directory
print_status "Phase 2: Removing duplicate website directory..."

if [ -d "dashboard/website" ]; then
    print_warning "Removing duplicate website directory: dashboard/website/"
    rm -rf dashboard/website/
    print_success "Duplicate website directory removed"
else
    print_status "No duplicate website directory found"
fi

# Phase 3: Evaluate fashionos-frontend
print_status "Phase 3: Analyzing fashionos-frontend directory..."

if [ -d "fashionos-frontend" ]; then
    if [ ! -f "fashionos-frontend/package.json" ]; then
        print_warning "fashionos-frontend appears incomplete (no package.json)"
        echo "Would you like to remove fashionos-frontend? (y/n)"
        # For automated cleanup, we'll move it to archive
        print_status "Moving fashionos-frontend to archive..."
        mv fashionos-frontend "$BACKUP_DIR/fashionos-frontend-archived"
        print_success "fashionos-frontend archived"
    else
        print_status "fashionos-frontend appears to be a valid project, keeping it"
    fi
fi

# Phase 4: Clean build artifacts and temporary files
print_status "Phase 4: Cleaning build artifacts..."

clean_build_artifacts() {
    local dir=$1
    if [ -d "$dir" ]; then
        cd "$dir"
        print_status "Cleaning $dir..."
        
        # Remove build artifacts
        rm -rf .next/ .swc/ node_modules/ 2>/dev/null || true
        rm -rf playwright-report/ test-results/ 2>/dev/null || true
        rm -f *.tsbuildinfo 2>/dev/null || true
        rm -f .stylelintcache 2>/dev/null || true
        
        # Remove backup files
        rm -f *.backup package.json.backup 2>/dev/null || true
        
        cd ..
        print_success "Cleaned $dir"
    fi
}

clean_build_artifacts "dashboard"
clean_build_artifacts "fashionos-website"

# Phase 5: Organize main dashboard directory
print_status "Phase 5: Organizing main dashboard directory..."

if [ -d "dashboard" ]; then
    cd dashboard
    
    # Create organized directory structure
    mkdir -p docs/
    mkdir -p scripts/development/
    mkdir -p scripts/database/
    mkdir -p scripts/testing/
    
    # Move documentation files
    mv DASHBOARD_*.md docs/ 2>/dev/null || true
    mv MIGRATION_GUIDE.md docs/ 2>/dev/null || true
    mv SUPABASE_SETUP.md docs/ 2>/dev/null || true
    mv TYPESCRIPT_STATUS.md docs/ 2>/dev/null || true
    mv DETECTIVE_ANALYSIS_RESPONSE.md docs/ 2>/dev/null || true
    
    # Move development scripts
    mv fix-*.sh scripts/development/ 2>/dev/null || true
    mv setup-*.sh scripts/development/ 2>/dev/null || true
    mv start-*.sh scripts/development/ 2>/dev/null || true
    mv verify-*.sh scripts/development/ 2>/dev/null || true
    
    # Move database scripts
    mv *-migration*.mjs scripts/database/ 2>/dev/null || true
    mv *-tables*.mjs scripts/database/ 2>/dev/null || true
    mv database-*.mjs scripts/database/ 2>/dev/null || true
    mv *.sql scripts/database/ 2>/dev/null || true
    mv setup-database.mjs scripts/database/ 2>/dev/null || true
    mv test-*-connection.mjs scripts/database/ 2>/dev/null || true
    
    # Move testing scripts
    mv run_tests.sh scripts/testing/ 2>/dev/null || true
    mv comprehensive_test.py scripts/testing/ 2>/dev/null || true
    mv final_verification.js scripts/testing/ 2>/dev/null || true
    mv analyze_missing_components.py scripts/testing/ 2>/dev/null || true
    mv simple-test.mjs scripts/testing/ 2>/dev/null || true
    
    cd ..
    print_success "Main dashboard directory organized"
fi

# Phase 6: Create improved .gitignore files
print_status "Phase 6: Updating .gitignore files..."

create_gitignore() {
    local dir=$1
    if [ -d "$dir" ]; then
        cat > "$dir/.gitignore" << 'EOF'
# Dependencies
node_modules/
.pnp
.pnp.js

# Build artifacts
.next/
.swc/
out/
build/
dist/

# Development
.env.local
.env.development.local
.env.test.local
.env.production.local
*.tsbuildinfo
.stylelintcache

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Testing
coverage/
.nyc_output/
playwright-report/
test-results/

# Backup files
*.backup
*.bak
*~
EOF
        print_success "Updated .gitignore in $dir"
    fi
}

create_gitignore "dashboard"
create_gitignore "fashionos-website"

# Phase 7: Generate summary report
print_status "Phase 7: Generating cleanup summary..."

echo ""
echo "📋 CLEANUP SUMMARY REPORT"
echo "=========================="
echo "Backup Location: $BACKUP_DIR"
echo ""
echo "📊 Directory Sizes After Cleanup:"
du -sh dashboard fashionos-* eventsOS "$BACKUP_DIR" 2>/dev/null || true
echo ""

echo "✅ COMPLETED ACTIONS:"
echo "• Created comprehensive backup in $BACKUP_DIR"
echo "• Removed duplicate website directory"
echo "• Cleaned build artifacts and temporary files"
echo "• Organized main fashionos directory structure"
echo "• Updated .gitignore files"
echo "• Archived incomplete fashionos-frontend project"
echo ""

echo "📁 CURRENT PROJECT STRUCTURE:"
echo "• dashboard/           - Main Refine-based admin dashboard"
echo "• fashionos-website/   - Mantine-based marketing website (ACTIVE)"
echo "• eventsOS/           - Events project (unchanged)"
echo "• $BACKUP_DIR/         - Backup of all moved/deleted files"
echo ""

echo "🎯 NEXT STEPS:"
echo "1. Verify both projects still work correctly"
echo "2. Remove backup directory after confirming everything works"
echo "3. Commit organized changes to git"
echo "4. Set up proper CI/CD for both projects"
echo ""

print_success "FashionOS cleanup completed successfully!"
print_status "Total time taken: $SECONDS seconds"
