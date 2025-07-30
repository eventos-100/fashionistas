#!/bin/bash

# WAHA Complete Setup Script for FashionOS
# This script performs the full setup and verification

echo "🚀 FashionOS WhatsApp Integration - Complete Setup"
echo "=================================================="

# Step 1: Check prerequisites
echo "1. Checking prerequisites..."

# Check Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed"
    echo "   Install Docker: https://docs.docker.com/get-docker/"
    exit 1
fi
echo "✅ Docker is installed: $(docker --version)"

# Check curl
if ! command -v curl &> /dev/null; then
    echo "❌ curl is not installed"
    echo "   Install curl: sudo apt-get install curl"
    exit 1
fi
echo "✅ curl is available"

# Step 2: Clean up existing containers
echo ""
echo "2. Cleaning up existing WAHA containers..."
docker stop $(docker ps -q --filter ancestor=devlikeapro/waha) 2>/dev/null || echo "No containers to stop"
docker rm $(docker ps -aq --filter ancestor=devlikeapro/waha) 2>/dev/null || echo "No containers to remove"

# Step 3: Create data directory
echo ""
echo "3. Setting up data directory..."
mkdir -p ~/.waha
echo "✅ Data directory created"

# Step 4: Start WAHA container
echo ""
echo "4. Starting WAHA container..."
docker run -d \
  --name waha-fashionos \
  --restart=always \
  -p 3000:3000 \
  -e WAHA_DASHBOARD_USERNAME=admin \
  -e WAHA_DASHBOARD_PASSWORD=fashionos2024 \
  -e WAHA_DASHBOARD_ENABLED=true \
  -v ~/.waha:/app/.sessions \
  devlikeapro/waha:latest

echo "✅ WAHA container started"

# Step 5: Wait for startup
echo ""
echo "5. Waiting for WAHA to be ready..."
sleep 15

# Check if container is running
if docker ps | grep -q waha-fashionos; then
    echo "✅ Container is running"
else
    echo "❌ Container failed to start"
    echo "Check logs: docker logs waha-fashionos"
    exit 1
fi

# Step 6: Test connectivity
echo ""
echo "6. Testing connectivity..."
for i in {1..10}; do
    if curl -s http://localhost:3000 > /dev/null; then
        echo "✅ WAHA is responding"
        break
    fi
    echo "Waiting... ($i/10)"
    sleep 3
done

# Step 7: Create integration files
echo ""
echo "7. Creating integration files..."

# Create package.json if it doesn't exist
if [ ! -f whatsapp/package.json ]; then
    cat > whatsapp/package.json << 'EOF'
{
  "name": "fashionos-whatsapp",
  "version": "1.0.0",
  "description": "WhatsApp integration for FashionOS",
  "main": "integration.js",
  "scripts": {
    "test": "node test.js",
    "start": "node integration.js"
  },
  "dependencies": {
    "axios": "^1.6.0"
  }
}
EOF
    echo "✅ package.json created"
fi

# Create integration example
cat > whatsapp/integration.js << 'EOF'
// FashionOS WhatsApp Integration
const axios = require('axios');

class FashionOSWhatsApp {
    constructor() {
        this.baseURL = 'http://localhost:3000/api';
        this.session = 'default';
    }

    async sendEventNotification(phone, eventData) {
        const message = `🎭 FashionOS Event Notification

Event: ${eventData.name}
📅 Date: ${eventData.date}
🕐 Time: ${eventData.time}
📍 Venue: ${eventData.venue}

Your ticket: ${eventData.ticketUrl}

See you there! ✨`;

        return this.sendMessage(phone, message);
    }

    async sendMessage(phone, text) {
        try {
            const response = await axios.post(`${this.baseURL}/sendText`, {
                session: this.session,
                chatId: `${phone}@c.us`,
                text: text
            });
            console.log('✅ Message sent:', response.data);
            return response.data;
        } catch (error) {
            console.error('❌ Failed to send message:', error.message);
            throw error;
        }
    }

    async getSessionStatus() {
        try {
            const response = await axios.get(`${this.baseURL}/sessions/${this.session}/status`);
            return response.data;
        } catch (error) {
            console.error('❌ Failed to get status:', error.message);
            throw error;
        }
    }
}

module.exports = FashionOSWhatsApp;

// Example usage
if (require.main === module) {
    const whatsapp = new FashionOSWhatsApp();
    
    // Test connection
    whatsapp.getSessionStatus()
        .then(status => {
            console.log('Session status:', status);
            if (status.status === 'WORKING') {
                console.log('✅ WhatsApp is connected and ready!');
            } else {
                console.log('⚠️  Please scan QR code in dashboard first');
            }
        })
        .catch(err => console.log('❌ Connection failed:', err.message));
}
EOF

echo "✅ Integration example created"

# Create test script
cat > whatsapp/test.js << 'EOF'
// Test WAHA connection
const axios = require('axios');

async function testWAHA() {
    console.log('🧪 Testing WAHA connection...');
    
    try {
        // Test API endpoint
        const response = await axios.get('http://localhost:3000/api/sessions');
        console.log('✅ API is responding');
        
        // Test session status
        const statusResponse = await axios.get('http://localhost:3000/api/sessions/default/status');
        console.log('Session status:', statusResponse.data);
        
        if (statusResponse.data.status === 'WORKING') {
            console.log('✅ WhatsApp session is connected!');
        } else {
            console.log('⚠️  WhatsApp session needs QR scan');
        }
        
    } catch (error) {
        console.error('❌ Test failed:', error.message);
    }
}

testWAHA();
EOF

echo "✅ Test script created"

# Step 8: Install Node.js dependencies if Node.js is available
echo ""
echo "8. Setting up Node.js dependencies..."
if command -v npm &> /dev/null; then
    cd whatsapp
    npm install --silent
    cd ..
    echo "✅ Node.js dependencies installed"
else
    echo "⚠️  Node.js not found - install Node.js to use integration examples"
fi

# Step 9: Create quick reference
echo ""
echo "9. Creating quick reference..."
cat > whatsapp/QUICK_START.md << 'EOF'
# FashionOS WhatsApp Integration - Quick Start

## 🎯 Setup Complete!
- ✅ WAHA running on port 3000
- ✅ Dashboard: http://localhost:3000/dashboard
- ✅ Login: admin / fashionos2024

## 📱 Connect WhatsApp
1. Open: http://localhost:3000/dashboard
2. Login: admin / fashionos2024
3. Click "Start New Session"
4. Enter name: **default** (CRITICAL!)
5. Scan QR code with WhatsApp

## 🧪 Test Connection
```bash
# Test WAHA setup
curl http://localhost:3000/api/sessions

# Test with Node.js (if installed)
cd whatsapp && node test.js
```

## 📨 Send Test Message
```bash
curl -X POST http://localhost:3000/api/sendText \
  -H 'Content-Type: application/json' \
  -d '{"session":"default","chatId":"YOUR_PHONE@c.us","text":"Hello from FashionOS!"}'
```

## 🔧 Management
```bash
# Check container status
docker ps | grep waha

# View logs
docker logs waha-fashionos

# Restart container
docker restart waha-fashionos

# Stop container
docker stop waha-fashionos
```

## 🚀 Integration
- `integration.js` - FashionOS WhatsApp class
- `test.js` - Connection test script
- Use for event notifications, sponsor messages, etc.
EOF

echo "✅ Quick reference created"

# Final status
echo ""
echo "🎉 SETUP COMPLETE!"
echo "=================="
echo ""
echo "📋 What's Ready:"
echo "• WAHA container running on port 3000"
echo "• Dashboard: http://localhost:3000/dashboard"
echo "• Login: admin / fashionos2024"
echo "• Integration files created"
echo "• Test scripts ready"
echo ""
echo "🎯 Next Steps:"
echo "1. Open dashboard: http://localhost:3000/dashboard"
echo "2. Login with: admin / fashionos2024"
echo "3. Create session named 'default'"
echo "4. Scan QR code with WhatsApp"
echo "5. Test with: cd whatsapp && node test.js"
echo ""
echo "📁 Files Created:"
echo "• whatsapp/integration.js - Main integration class"
echo "• whatsapp/test.js - Connection test"
echo "• whatsapp/package.json - Node.js config"
echo "• whatsapp/QUICK_START.md - Reference guide"
echo ""

# Try to open dashboard
if command -v xdg-open &> /dev/null; then
    echo "Opening dashboard in browser..."
    sleep 2
    xdg-open http://localhost:3000/dashboard &
elif command -v open &> /dev/null; then
    echo "Opening dashboard in browser..."
    sleep 2
    open http://localhost:3000/dashboard &
fi

echo "🚀 FashionOS WhatsApp integration is ready!"