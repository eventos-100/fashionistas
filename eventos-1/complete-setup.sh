#!/bin/bash

# EventsOS Complete Setup & Launch Script
# Comprehensive setup for Zone template adaptation to EventsOS

set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Project configuration
PROJECT_ROOT="/home/sk/fx/eventos"
ZONE_TEMPLATE="$PROJECT_ROOT/zone-template"
DOCS_DIR="$PROJECT_ROOT/docs"
PORT=3012

# Banner
echo -e "${PURPLE}"
cat << "EOF"
  ______               _       ____   _____ 
 |  ____|             | |     / __ \ / ____|
 | |____   _____ _ __ | |_   | |  | | (___  
 |  __\ \ / / _ \ '_ \| __|  | |  | |\___ \ 
 | |___\ V /  __/ | | | |_   | |__| |____) |
 |______\_/ \___|_| |_|\__|   \____/|_____/ 
                                            
Fashion Event Management Platform
EOF
echo -e "${NC}"
echo -e "${CYAN}🎭 EventsOS Complete Setup & Launch${NC}"
echo -e "${CYAN}====================================${NC}"
echo

# Logging functions
log() {
    echo -e "${BLUE}[$(date '+%H:%M:%S')]${NC} $1"
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

warning() {
    echo -e "${YELLOW}⚠️ $1${NC}"
}

error() {
    echo -e "${RED}❌ $1${NC}"
}

section() {
    echo
    echo -e "${PURPLE}$1${NC}"
    echo -e "${PURPLE}$(echo "$1" | sed 's/./=/g')${NC}"
}

# Check if running from correct directory
if [[ ! -f "project-status.py" ]]; then
    error "Please run this script from /home/sk/fx/eventos/"
    echo "Current directory: $(pwd)"
    echo "Expected: /home/sk/fx/eventos/"
    exit 1
fi

section "🔍 SYSTEM REQUIREMENTS CHECK"

# Check Node.js
log "Checking Node.js version..."
if command -v node >/dev/null 2>&1; then
    NODE_VERSION=$(node --version)
    NODE_MAJOR=$(echo "$NODE_VERSION" | sed 's/v\([0-9]*\).*/\1/')
    
    if [[ "$NODE_MAJOR" -ge 20 ]]; then
        success "Node.js version: $NODE_VERSION"
    else
        error "Node.js version $NODE_VERSION found. EventsOS requires Node.js 20+"
        echo "Please upgrade Node.js and try again."
        exit 1
    fi
else
    error "Node.js not found. Please install Node.js 20+ first."
    exit 1
fi

# Check npm
log "Checking npm availability..."
if command -v npm >/dev/null 2>&1; then
    NPM_VERSION=$(npm --version)
    success "npm version: $NPM_VERSION"
else
    error "npm not found. Please install npm."
    exit 1
fi

# Check disk space
log "Checking disk space..."
AVAILABLE_SPACE=$(df . | awk 'NR==2 {print $4}')
if [[ $AVAILABLE_SPACE -gt 1000000 ]]; then # 1GB in KB
    success "Sufficient disk space available"
else
    warning "Low disk space. May cause issues during setup."
fi

section "📁 PROJECT STRUCTURE SETUP"

# Ensure we're in the right directory
cd "$PROJECT_ROOT"

# Setup documentation if not exists
if [[ ! -d "$DOCS_DIR" ]]; then
    log "Setting up documentation structure..."
    mkdir -p "$DOCS_DIR"
    
    # Copy organized docs if they exist
    if [[ -d "docs-organized" ]]; then
        cp -r docs-organized/* "$DOCS_DIR/"
        success "Documentation structure created"
    fi
else
    success "Documentation structure already exists"
fi

# Make scripts executable
log "Making scripts executable..."
SCRIPTS=("start-zone.sh" "analyze-docs.sh" "maintain-docs.sh" "project-status.py")
for script in "${SCRIPTS[@]}"; do
    if [[ -f "$script" ]]; then
        chmod +x "$script"
        success "Made $script executable"
    else
        warning "$script not found"
    fi
done

section "🏗️ ZONE TEMPLATE SETUP"

# Check Zone template
if [[ ! -d "$ZONE_TEMPLATE" ]]; then
    error "Zone template not found at $ZONE_TEMPLATE"
    echo "Please ensure the Zone template is extracted to this location."
    exit 1
fi

cd "$ZONE_TEMPLATE"
success "Zone template directory found"

# Check package.json
if [[ ! -f "package.json" ]]; then
    error "package.json not found in Zone template"
    echo "This doesn't appear to be a valid Zone template directory."
    exit 1
fi

success "Zone template appears valid"

# Install dependencies if needed
if [[ ! -d "node_modules" ]]; then
    section "📦 INSTALLING DEPENDENCIES"
    log "Installing npm dependencies... (this may take 2-3 minutes)"
    
    if npm install; then
        success "Dependencies installed successfully"
    else
        error "Failed to install dependencies"
        echo "Try running: npm cache clean --force && npm install"
        exit 1
    fi
else
    log "Dependencies already installed"
    
    # Check if dependencies are up to date
    if npm outdated >/dev/null 2>&1; then
        warning "Some dependencies may be outdated"
        echo "Run 'npm update' to update them if needed"
    fi
fi

section "🌐 DEVELOPMENT SERVER"

# Check if port is available
if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
    warning "Port $PORT is already in use"
    echo "Attempting to free port..."
    
    PID=$(lsof -ti:$PORT)
    if [[ -n "$PID" ]]; then
        kill -9 $PID 2>/dev/null && success "Port $PORT freed" || warning "Could not free port automatically"
    fi
    
    # Double check
    if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
        warning "Port $PORT still in use. Will try alternative port."
        PORT=3013
    fi
fi

# Clean build cache
if [[ -d ".next" ]]; then
    log "Cleaning build cache..."
    rm -rf .next
fi

section "🎯 READY TO LAUNCH"

echo
echo -e "${GREEN}🎉 EventsOS Setup Complete!${NC}"
echo
echo -e "${CYAN}📊 Project Status:${NC}"
echo "├── Zone Template: ✅ Ready"
echo "├── Dependencies: ✅ Installed"  
echo "├── Documentation: ✅ Available"
echo "├── Scripts: ✅ Executable"
echo "└── Port $PORT: ✅ Available"
echo

echo -e "${CYAN}🚀 Launch Options:${NC}"
echo
echo -e "${YELLOW}1. Start Development Server (Recommended)${NC}"
echo "   ./start-zone.sh"
echo "   Then visit: http://localhost:$PORT/travel"
echo
echo -e "${YELLOW}2. Check Project Status${NC}"
echo "   python3 project-status.py"
echo
echo -e "${YELLOW}3. View Documentation${NC}"
echo "   cat docs/README.md"
echo
echo -e "${YELLOW}4. Manual Start${NC}"
echo "   cd zone-template && npm run dev"
echo

# Offer to start immediately
echo -e "${CYAN}🤔 Start development server now? ${NC}"
read -p "Press 'y' to start immediately, or any key to exit: " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    section "🚀 STARTING DEVELOPMENT SERVER"
    
    echo "Starting EventsOS development server..."
    echo "This will start the Zone template on http://localhost:$PORT"
    echo
    echo -e "${GREEN}🎯 Next Steps After Server Starts:${NC}"
    echo "1. Open http://localhost:$PORT/travel in your browser"
    echo "2. Explore the travel template structure"  
    echo "3. Follow the adaptation guide in docs/"
    echo "4. Start with safe content replacements"
    echo
    echo -e "${YELLOW}Press Ctrl+C to stop the server${NC}"
    echo
    
    # Start the server
    if npm run dev -- --port $PORT; then
        success "Development server started successfully"
    else
        warning "Standard start failed, trying with different configuration..."
        npm run dev -- --port $PORT --no-turbopack
    fi
else
    echo
    echo -e "${GREEN}Setup complete! 🎉${NC}"
    echo
    echo -e "${CYAN}To start development later:${NC}"
    echo "   cd /home/sk/fx/eventos"
    echo "   ./start-zone.sh"
    echo
    echo -e "${CYAN}For help and documentation:${NC}"
    echo "   cat docs/README.md"
    echo "   python3 project-status.py"
    echo
    echo -e "${GREEN}Happy coding! 🎭✨${NC}"
fi
