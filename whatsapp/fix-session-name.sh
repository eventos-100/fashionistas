#!/bin/bash

# Fix WAHA Session Name Issue
# WAHA Core ONLY supports "default" session name

echo "🔧 FIXING WAHA SESSION NAME ISSUE"
echo "=================================="
echo ""
echo "❌ ERROR: You tried to create session 'whatsapp'"
echo "✅ SOLUTION: WAHA Core only supports session name 'default'"
echo ""

# Stop current container
echo "1. Stopping current WAHA container..."
docker stop waha-core 2>/dev/null || echo "Container already stopped"

# Remove container
echo "2. Removing container..."
docker rm waha-core 2>/dev/null || echo "Container already removed"

# Clean session data
echo "3. Cleaning session data..."
rm -rf ~/.waha/* 2>/dev/null || echo "No session data to clean"

# Start fresh container
echo "4. Starting fresh WAHA container..."
docker run -d \
  --name waha-core \
  --restart=always \
  -p 3000:3000 \
  -e WAHA_DASHBOARD_USERNAME=admin \
  -e WAHA_DASHBOARD_PASSWORD=admin \
  -v ~/.waha:/app/.sessions \
  devlikeapro/waha:latest

echo "5. Waiting for WAHA to start..."
sleep 20

# Check if running
if docker ps | grep -q waha-core; then
    echo "✅ WAHA is running successfully!"
    echo ""
    echo "🎯 CRITICAL INSTRUCTIONS:"
    echo "========================"
    echo "1. Open: http://localhost:3000/dashboard"
    echo "2. Login: admin / admin"
    echo "3. Click 'Start New Session'"
    echo "4. ⚠️  ENTER EXACTLY: default"
    echo "5. ❌ DO NOT USE: whatsapp, main, or any other name"
    echo "6. Click 'Create & Start'"
    echo "7. Scan QR code"
    echo ""
    echo "🚨 REMEMBER: Only 'default' works in WAHA Core!"
    echo ""
    
    # Open dashboard
    if command -v xdg-open &> /dev/null; then
        echo "Opening dashboard..."
        sleep 3
        xdg-open http://localhost:3000/dashboard
    fi
else
    echo "❌ Failed to start WAHA"
    echo "Check logs: docker logs waha-core"
fi