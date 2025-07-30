#!/bin/bash

# EventsOS Zone Template Startup Script
# Ensures Zone template runs correctly for EventsOS development

set -e

echo "🎭 EventsOS Zone Template Startup"
echo "================================="

# Configuration
ZONE_DIR="/home/sk/fx/eventos/zone-template"
PORT=3012
DOCS_DIR="/home/sk/fx/eventos/docs"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
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

# Check if we're in the right directory
if [[ ! -d "$ZONE_DIR" ]]; then
    error "Zone template directory not found: $ZONE_DIR"
    echo "Please ensure you're running this from /home/sk/fx/eventos/"
    exit 1
fi

# Navigate to zone template
cd "$ZONE_DIR"
log "Navigating to Zone template directory..."

# Check Node.js version
NODE_VERSION=$(node --version 2>/dev/null || echo "not found")
if [[ "$NODE_VERSION" == "not found" ]]; then
    error "Node.js not found. Please install Node.js 20+ first."
    exit 1
fi

# Extract major version number
NODE_MAJOR=$(echo "$NODE_VERSION" | sed 's/v\([0-9]*\).*/\1/')
if [[ "$NODE_MAJOR" -lt 20 ]]; then
    error "Node.js version $NODE_VERSION found. EventsOS requires Node.js 20+"
    echo "Please upgrade Node.js and try again."
    exit 1
fi

success "Node.js version: $NODE_VERSION"

# Check if port is available
if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
    warning "Port $PORT is already in use"
    echo "Attempting to free port $PORT..."
    
    # Try to kill existing process
    PID=$(lsof -ti:$PORT)
    if [[ -n "$PID" ]]; then
        kill -9 $PID 2>/dev/null && success "Freed port $PORT" || warning "Could not free port automatically"
    fi
    
    # Double check
    if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
        error "Port $PORT still in use. Please manually stop the process or use a different port."
        echo "Try: lsof -ti:$PORT | xargs kill -9"
        exit 1
    fi
fi

# Check if package.json exists
if [[ ! -f "package.json" ]]; then
    error "package.json not found in $ZONE_DIR"
    echo "This doesn't appear to be a valid Zone template directory."
    exit 1
fi

success "Zone template directory confirmed"

# Check if node_modules exists
if [[ ! -d "node_modules" ]]; then
    warning "node_modules not found. Installing dependencies..."
    
    # Clean install
    log "Running npm install..."
    if npm install; then
        success "Dependencies installed successfully"
    else
        error "Failed to install dependencies"
        echo "Try running: npm cache clean --force && npm install"
        exit 1
    fi
else
    log "Dependencies already installed"
fi

# Check for .next directory and clean if needed
if [[ -d ".next" ]]; then
    log "Cleaning previous build cache..."
    rm -rf .next
fi

# Display startup information
echo ""
echo "🚀 Starting EventsOS Development Server"
echo "======================================="
echo "📁 Template: Zone Travel v4.2.0"
echo "🌐 URL: http://localhost:$PORT"
echo "📋 Travel Section: http://localhost:$PORT/travel"
echo "📚 Documentation: file://$DOCS_DIR/README.md"
echo ""
echo "🎯 Next Steps After Startup:"
echo "1. Open http://localhost:$PORT/travel in your browser"
echo "2. Explore the travel template structure"
echo "3. Follow the adaptation guide in docs/"
echo "4. Start with content replacements (safest)"
echo ""

# Start the development server
log "Starting development server on port $PORT..."
echo "Press Ctrl+C to stop the server"
echo ""

# Start with Turbopack for faster builds
if npm run dev -- --turbopack --port $PORT; then
    success "Development server started successfully"
else
    warning "Turbopack failed, trying standard webpack..."
    if npm run dev -- --port $PORT; then
        success "Development server started with webpack"
    else
        error "Failed to start development server"
        echo ""
        echo "🔧 Troubleshooting suggestions:"
        echo "1. Check Node.js version: node --version (need 20+)"
        echo "2. Clear cache: npm run clean && npm install"
        echo "3. Check port availability: lsof -i :$PORT"
        echo "4. Try different port: npm run dev -- --port 3013"
        echo ""
        echo "📞 For help, check the documentation:"
        echo "   $DOCS_DIR/01-quick-start/installation.md"
        exit 1
    fi
fi
