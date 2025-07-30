#!/bin/bash

# WAHA Verification and Connection Script
# Helps you connect WhatsApp step by step

echo "📱 WAHA WhatsApp Connection Verification"
echo "========================================"

# Check if WAHA is running
echo "1. Checking WAHA status..."
if ! curl -s http://localhost:3000/api/sessions > /dev/null; then
    echo "❌ WAHA is not responding"
    echo "   Run: ./whatsapp/fix-session-name.sh"
    exit 1
fi
echo "✅ WAHA is running"

# Check current sessions
echo ""
echo "2. Checking current sessions..."
SESSIONS=$(curl -s http://localhost:3000/api/sessions)
echo "Current sessions: $SESSIONS"

if [ "$SESSIONS" = "[]" ]; then
    echo "✅ No sessions found - ready to create 'default' session"
else
    echo "ℹ️  Existing sessions found"
fi

# Check if default session exists
echo ""
echo "3. Checking for 'default' session..."
DEFAULT_STATUS=$(curl -s http://localhost:3000/api/sessions/default/status 2>/dev/null)

if echo "$DEFAULT_STATUS" | grep -q "error\|Error"; then
    echo "✅ No 'default' session exists - you can create it"
    SESSION_EXISTS=false
else
    echo "ℹ️  'default' session exists"
    echo "Status: $DEFAULT_STATUS"
    SESSION_EXISTS=true
fi

echo ""
echo "🎯 NEXT STEPS:"
echo "=============="

if [ "$SESSION_EXISTS" = false ]; then
    echo "1. Open dashboard: http://localhost:3000/dashboard"
    echo "2. Login: admin / admin"
    echo "3. Click 'Start New Session'"
    echo "4. ⚠️  Enter session name: default"
    echo "5. Click 'Create & Start'"
    echo "6. Scan QR code with WhatsApp"
    echo ""
    echo "🚨 CRITICAL: Use EXACTLY 'default' as session name!"
    
    # Try to open dashboard
    if command -v xdg-open &> /dev/null; then
        echo ""
        read -p "Open dashboard now? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            xdg-open http://localhost:3000/dashboard
        fi
    fi
else
    # Check if session is working
    if echo "$DEFAULT_STATUS" | grep -q "WORKING"; then
        echo "🎉 Session is already connected and working!"
        echo ""
        echo "Test with your phone number:"
        echo "curl -X POST http://localhost:3000/api/sendText \\"
        echo "  -H 'Content-Type: application/json' \\"
        echo "  -d '{\"session\":\"default\",\"chatId\":\"YOUR_PHONE@c.us\",\"text\":\"Test!\"}'"
    else
        echo "⚠️  Session exists but may need QR scan"
        echo "1. Open dashboard: http://localhost:3000/dashboard"
        echo "2. Look for 'default' session"
        echo "3. Click QR code button if needed"
        echo "4. Scan with WhatsApp"
    fi
fi

echo ""
echo "📋 Useful Commands:"
echo "=================="
echo "# Check sessions"
echo "curl http://localhost:3000/api/sessions"
echo ""
echo "# Check default session status"
echo "curl http://localhost:3000/api/sessions/default/status"
echo ""
echo "# View container logs"
echo "docker logs waha-core"
echo ""
echo "# Restart if needed"
echo "./whatsapp/fix-session-name.sh"