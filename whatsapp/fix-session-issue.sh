#!/bin/bash

# WAHA Session Fix Script
# Fixes the "WAHA Core support only 'default' session" error

echo "🔧 WAHA Session Fix - Solving the 'default' session requirement"
echo "================================================================"

# Stop any running WAHA containers
echo "1. Stopping existing WAHA containers..."
docker stop $(docker ps -q --filter ancestor=devlikeapro/waha) 2>/dev/null || echo "No running WAHA containers found"

# Remove old containers
echo "2. Removing old WAHA containers..."
docker rm $(docker ps -aq --filter ancestor=devlikeapro/waha) 2>/dev/null || echo "No WAHA containers to remove"

# Clean up session data (optional - uncomment if you want fresh start)
echo "3. Cleaning up old session data..."
read -p "Do you want to remove old session data? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf ~/.waha/* 2>/dev/null || echo "No session data to clean"
    echo "Session data cleaned"
else
    echo "Keeping existing session data"
fi

# Start fresh WAHA Core with proper configuration
echo "4. Starting WAHA Core with correct configuration..."
docker run -d \
  --name waha-core \
  --restart=always \
  -p 3000:3000 \
  -e WAHA_DASHBOARD_USERNAME=admin \
  -e WAHA_DASHBOARD_PASSWORD=admin \
  -v ~/.waha:/app/.sessions \
  devlikeapro/waha:latest

echo "5. Waiting for WAHA to start..."
sleep 15

# Check if container is running
if docker ps | grep -q waha-core; then
    echo "✅ WAHA Core is running successfully!"
    echo ""
    echo "📋 Next Steps:"
    echo "1. Open dashboard: http://localhost:3000/dashboard"
    echo "2. Login with: admin / admin"
    echo "3. Click 'Start New Session'"
    echo "4. ⚠️  IMPORTANT: Use session name 'default' (not 'main')"
    echo "5. Click 'Create & Start'"
    echo "6. Scan QR code with WhatsApp"
    echo ""
    echo "🎯 Key Fix: WAHA Core only supports 'default' session name!"
    echo ""
    
    # Try to open dashboard automatically
    if command -v xdg-open &> /dev/null; then
        echo "Opening dashboard in browser..."
        sleep 5
        xdg-open http://localhost:3000/dashboard
    elif command -v open &> /dev/null; then
        echo "Opening dashboard in browser..."
        sleep 5
        open http://localhost:3000/dashboard
    else
        echo "Please manually open: http://localhost:3000/dashboard"
    fi
else
    echo "❌ Failed to start WAHA Core"
    echo "Check logs with: docker logs waha-core"
fi