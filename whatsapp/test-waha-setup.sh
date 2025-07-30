#!/bin/bash

# WAHA Setup Test Script
# Tests all aspects of WAHA installation and configuration

echo "🧪 WAHA Setup Test Suite"
echo "========================"

# Test 1: Check if Docker container is running
echo "1. Testing Docker container status..."
if docker ps | grep -q waha-core; then
    echo "✅ WAHA container is running"
    CONTAINER_ID=$(docker ps | grep waha-core | awk '{print $1}')
    echo "   Container ID: $CONTAINER_ID"
else
    echo "❌ WAHA container is not running"
    echo "   Run: ./whatsapp/fix-session-issue.sh"
    exit 1
fi

# Test 2: Check if port 3000 is accessible
echo "2. Testing port accessibility..."
if curl -s http://localhost:3000 > /dev/null; then
    echo "✅ Port 3000 is accessible"
else
    echo "❌ Port 3000 is not accessible"
    echo "   Check firewall settings"
fi

# Test 3: Check dashboard accessibility
echo "3. Testing dashboard endpoint..."
DASHBOARD_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/dashboard)
if [ "$DASHBOARD_RESPONSE" = "200" ]; then
    echo "✅ Dashboard is accessible at http://localhost:3000/dashboard"
else
    echo "❌ Dashboard returned HTTP $DASHBOARD_RESPONSE"
fi

# Test 4: Check API endpoints
echo "4. Testing API endpoints..."
API_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/api/sessions)
if [ "$API_RESPONSE" = "200" ] || [ "$API_RESPONSE" = "401" ]; then
    echo "✅ API endpoints are responding"
else
    echo "❌ API endpoints returned HTTP $API_RESPONSE"
fi

# Test 5: Check container logs for errors
echo "5. Checking container logs..."
LOGS=$(docker logs waha-core 2>&1 | tail -10)
if echo "$LOGS" | grep -q "error\|Error\|ERROR"; then
    echo "⚠️  Found errors in logs:"
    echo "$LOGS" | grep -i error
else
    echo "✅ No errors found in recent logs"
fi

# Test 6: Check session directory
echo "6. Testing session persistence..."
if [ -d ~/.waha ]; then
    echo "✅ Session directory exists: ~/.waha"
    echo "   Contents: $(ls -la ~/.waha 2>/dev/null | wc -l) items"
else
    echo "⚠️  Session directory not found (will be created on first session)"
fi

# Test 7: Memory and resource usage
echo "7. Checking resource usage..."
MEMORY_USAGE=$(docker stats waha-core --no-stream --format "{{.MemUsage}}" 2>/dev/null)
if [ -n "$MEMORY_USAGE" ]; then
    echo "✅ Memory usage: $MEMORY_USAGE"
else
    echo "⚠️  Could not get memory usage"
fi

echo ""
echo "📋 Setup Summary:"
echo "=================="
echo "Dashboard URL: http://localhost:3000/dashboard"
echo "Login: admin / admin"
echo "API Base URL: http://localhost:3000/api"
echo "Session Name: default (IMPORTANT!)"
echo ""
echo "🎯 Next Steps:"
echo "1. Open dashboard in browser"
echo "2. Login with admin/admin"
echo "3. Click 'Start New Session'"
echo "4. Use session name 'default'"
echo "5. Scan QR code with WhatsApp"
echo ""
echo "📱 Test API after QR scan:"
echo "curl -X POST http://localhost:3000/api/sendText \\"
echo "  -H 'Content-Type: application/json' \\"
echo "  -d '{\"session\":\"default\",\"chatId\":\"YOUR_PHONE@c.us\",\"text\":\"Test message\"}'"