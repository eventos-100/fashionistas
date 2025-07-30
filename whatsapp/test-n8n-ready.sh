#!/bin/bash

# Test if WAHA is ready for n8n integration

echo "🔗 Testing WAHA for n8n Integration"
echo "==================================="

# Test 1: Check WAHA is running
echo "1. Checking WAHA status..."
if curl -s http://localhost:3000/api/sessions > /dev/null; then
    echo "✅ WAHA is running on port 3000"
else
    echo "❌ WAHA is not responding"
    echo "   Run: docker start waha-core"
    exit 1
fi

# Test 2: Check sessions
echo ""
echo "2. Checking sessions..."
SESSIONS=$(curl -s http://localhost:3000/api/sessions)
echo "Sessions: $SESSIONS"

# Test 3: Check default session status
echo ""
echo "3. Checking default session..."
DEFAULT_STATUS=$(curl -s http://localhost:3000/api/sessions/default/status 2>/dev/null)

if echo "$DEFAULT_STATUS" | grep -q "WORKING"; then
    echo "✅ Default session is WORKING - ready for n8n!"
    SESSION_READY=true
elif echo "$DEFAULT_STATUS" | grep -q "STARTING\|SCAN_QR_CODE"; then
    echo "⚠️  Session exists but needs QR scan"
    echo "   Go to: http://localhost:3000/dashboard"
    SESSION_READY=false
else
    echo "❌ No default session found"
    echo "   Create session in dashboard: http://localhost:3000/dashboard"
    SESSION_READY=false
fi

# Test 4: Test API endpoint
echo ""
echo "4. Testing API endpoints..."
API_TEST=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/api/sessions)
if [ "$API_TEST" = "200" ]; then
    echo "✅ API endpoints responding correctly"
else
    echo "❌ API test failed (HTTP $API_TEST)"
fi

echo ""
echo "📋 n8n Configuration Summary:"
echo "============================"
echo "WAHA URL: http://localhost:3000"
echo "API Endpoint: http://localhost:3000/api"
echo "Session Name: default"
echo "API Key: (leave empty for WAHA Core)"
echo ""

if [ "$SESSION_READY" = true ]; then
    echo "🎉 READY FOR n8n INTEGRATION!"
    echo ""
    echo "📱 Test Message Command:"
    echo "curl -X POST http://localhost:3000/api/sendText \\"
    echo "  -H 'Content-Type: application/json' \\"
    echo "  -d '{\"session\":\"default\",\"chatId\":\"YOUR_PHONE@c.us\",\"text\":\"Test from n8n!\"}'"
    echo ""
    echo "🔗 n8n Workflow Template:"
    echo "https://n8n.io/workflows/2162-whatsapp-starter-workflow/"
else
    echo "⚠️  SETUP REQUIRED:"
    echo "1. Open: http://localhost:3000/dashboard"
    echo "2. Login: admin / admin"
    echo "3. Create session named 'default'"
    echo "4. Scan QR code"
    echo "5. Run this test again"
fi