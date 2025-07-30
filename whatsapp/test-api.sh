#!/bin/bash

# WAHA API Test Script
# Tests all major API endpoints after WhatsApp connection

echo "📱 WAHA API Test Suite"
echo "======================"

BASE_URL="http://localhost:3000/api"
SESSION="default"
API_KEY="fashionos-waha-key-2024"

# Check if session is provided as argument
if [ ! -z "$1" ]; then
    SESSION="$1"
fi

echo "Using session: $SESSION"
echo "Base URL: $BASE_URL"
echo ""

# Test 1: Get all sessions
echo "1. Testing GET /sessions..."
RESPONSE=$(curl -s -w "\nHTTP_CODE:%{http_code}" "$BASE_URL/sessions")
HTTP_CODE=$(echo "$RESPONSE" | grep "HTTP_CODE:" | cut -d: -f2)
BODY=$(echo "$RESPONSE" | sed '/HTTP_CODE:/d')

if [ "$HTTP_CODE" = "200" ]; then
    echo "✅ Sessions endpoint working"
    echo "Response: $BODY"
else
    echo "❌ Sessions endpoint failed (HTTP $HTTP_CODE)"
    echo "Response: $BODY"
fi
echo ""

# Test 2: Get session status
echo "2. Testing GET /sessions/$SESSION/status..."
RESPONSE=$(curl -s -w "\nHTTP_CODE:%{http_code}" "$BASE_URL/sessions/$SESSION/status")
HTTP_CODE=$(echo "$RESPONSE" | grep "HTTP_CODE:" | cut -d: -f2)
BODY=$(echo "$RESPONSE" | sed '/HTTP_CODE:/d')

if [ "$HTTP_CODE" = "200" ]; then
    echo "✅ Session status endpoint working"
    echo "Status: $BODY"
    
    # Check if session is working
    if echo "$BODY" | grep -q "WORKING"; then
        echo "✅ Session is connected and working!"
        SESSION_WORKING=true
    else
        echo "⚠️  Session is not in WORKING state"
        echo "   Please scan QR code in dashboard first"
        SESSION_WORKING=false
    fi
else
    echo "❌ Session status failed (HTTP $HTTP_CODE)"
    echo "Response: $BODY"
    SESSION_WORKING=false
fi
echo ""

# Only run message tests if session is working
if [ "$SESSION_WORKING" = true ]; then
    echo "3. Testing message sending capabilities..."
    
    # Get phone number for testing
    echo "Enter your phone number (with country code, no +): "
    read -r PHONE_NUMBER
    
    if [ -z "$PHONE_NUMBER" ]; then
        echo "⚠️  No phone number provided, skipping message tests"
    else
        CHAT_ID="${PHONE_NUMBER}@c.us"
        
        # Test 3: Send text message
        echo "Testing POST /sendText..."
        RESPONSE=$(curl -s -w "\nHTTP_CODE:%{http_code}" \
            -X POST "$BASE_URL/sendText" \
            -H "Content-Type: application/json" \
            -H "X-Api-Key: $API_KEY" \
            -d "{
                \"session\": \"$SESSION\",
                \"chatId\": \"$CHAT_ID\",
                \"text\": \"🧪 WAHA API Test - $(date)\"
            }")
        
        HTTP_CODE=$(echo "$RESPONSE" | grep "HTTP_CODE:" | cut -d: -f2)
        BODY=$(echo "$RESPONSE" | sed '/HTTP_CODE:/d')
        
        if [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "201" ]; then
            echo "✅ Text message sent successfully!"
            echo "Response: $BODY"
        else
            echo "❌ Text message failed (HTTP $HTTP_CODE)"
            echo "Response: $BODY"
        fi
        echo ""
        
        # Test 4: Get chats
        echo "Testing GET /chats..."
        RESPONSE=$(curl -s -w "\nHTTP_CODE:%{http_code}" \
            "$BASE_URL/$SESSION/chats" \
            -H "X-Api-Key: $API_KEY")
        
        HTTP_CODE=$(echo "$RESPONSE" | grep "HTTP_CODE:" | cut -d: -f2)
        BODY=$(echo "$RESPONSE" | sed '/HTTP_CODE:/d')
        
        if [ "$HTTP_CODE" = "200" ]; then
            echo "✅ Chats endpoint working"
            echo "Found chats: $(echo "$BODY" | jq length 2>/dev/null || echo "Unable to parse")"
        else
            echo "❌ Chats endpoint failed (HTTP $HTTP_CODE)"
            echo "Response: $BODY"
        fi
    fi
else
    echo "⚠️  Skipping message tests - session not connected"
    echo "   1. Open http://localhost:3000/dashboard"
    echo "   2. Login with admin/admin"
    echo "   3. Start session named 'default'"
    echo "   4. Scan QR code"
    echo "   5. Run this test again"
fi

echo ""
echo "📋 API Test Summary"
echo "==================="
echo "Base URL: $BASE_URL"
echo "Session: $SESSION"
echo "Dashboard: http://localhost:3000/dashboard"
echo ""
echo "🔧 Useful Commands:"
echo "# Check session status"
echo "curl $BASE_URL/sessions/$SESSION/status"
echo ""
echo "# Send test message (replace PHONE with your number)"
echo "curl -X POST $BASE_URL/sendText \\"
echo "  -H 'Content-Type: application/json' \\"
echo "  -H 'X-Api-Key: $API_KEY' \\"
echo "  -d '{\"session\":\"$SESSION\",\"chatId\":\"PHONE@c.us\",\"text\":\"Hello!\"}'"