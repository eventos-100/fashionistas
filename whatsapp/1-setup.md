# WAHA (WhatsApp HTTP API) Complete Setup Guide

## 📚 Table of Contents

1. [Introduction](#introduction)
2. [Quick Start](#quick-start)
3. [Installation Methods](#installation-methods)
4. [Core Features](#core-features)
5. [API Endpoints](#api-endpoints)
6. [Integration Guide](#integration-guide)
7. [Use Cases](#use-cases)
8. [Real World Examples](#real-world-examples)
9. [Troubleshooting](#troubleshooting)
10. [Progress Tracker](#progress-tracker)

---

## 🎯 Introduction

WAHA (WhatsApp HTTP API) is a free, open-source solution that lets you send and receive WhatsApp messages via a simple HTTP API. No Meta approval needed, no message limits, no hidden costs.

### Why Choose WAHA?

- **Free Forever**: Core version has no limits
- **Simple Setup**: Running in 5 minutes
- **No Restrictions**: No template approvals
- **Multi-Session**: Handle multiple WhatsApp accounts
- **REST API**: Works with any programming language

---

## 🚀 Quick Start

### ⚠️ CRITICAL FIX: Session Name Issue
**WAHA Core only supports "default" session name - NOT custom names like "main"**

Use the automated fix script:
```bash
./whatsapp/fix-session-issue.sh
```

### Step 1: Run with Docker (Recommended)
```bash
docker run -d \
  --name waha-core \
  --restart=always \
  -p 3000:3000 \
  -e WAHA_DASHBOARD_USERNAME=admin \
  -e WAHA_DASHBOARD_PASSWORD=admin \
  -v ~/.waha:/app/.sessions \
  devlikeapro/waha:latest
```

### Step 2: Access Dashboard
Open browser: `http://localhost:3000/dashboard`
- Username: `admin`
- Password: `admin`

### Step 3: Start Session (IMPORTANT)
1. Click "Start New Session"
2. **Enter session name: `default` (NOT "main")**
3. Click "Create & Start"
4. Scan QR code with WhatsApp
5. You're ready to send messages!

---

## 💻 Installation Methods

### Method 1: Docker (Easiest)
```bash
# Basic run
docker run -it -p 3000:3000 devlikeapro/waha

# With data persistence
docker run -it -p 3000:3000 -v ~/.waha:/app/.sessions devlikeapro/waha

# Production with environment variables
docker run -d \
  --name waha \
  --restart=always \
  -p 3000:3000 \
  -e WAHA_DASHBOARD_USERNAME=admin \
  -e WAHA_DASHBOARD_PASSWORD=secure-password \
  -v ~/.waha:/app/.sessions \
  devlikeapro/waha
```

### Method 2: Docker Compose
```yaml
version: '3'
services:
  waha:
    image: devlikeapro/waha
    ports:
      - "3000:3000"
    environment:
      - WAHA_DASHBOARD_USERNAME=admin
      - WAHA_DASHBOARD_PASSWORD=secure-password
    volumes:
      - ./waha-data:/app/.sessions
    restart: unless-stopped
```

### Method 3: NPM (Development)
```bash
npm install -g @devlikeapro/waha
waha start
```

---

## ⚡ Core Features

### 1. Session Management
- **Multiple Sessions**: Run unlimited WhatsApp accounts
- **QR Code**: Easy login via dashboard
- **Session Persistence**: Survives restarts
- **Health Checks**: Monitor connection status

### 2. Messaging
- **Text Messages**: Send and receive text
- **Media Support**: Images, videos, documents
- **Group Messages**: Full group support
- **Reactions**: Send and receive reactions
- **Status Updates**: Post and read status

### 3. Advanced Features
- **Webhooks**: Real-time event notifications
- **Contact Management**: Add, update, list contacts
- **Presence**: Online/offline status
- **Read Receipts**: Blue ticks control
- **Typing Indicators**: Show typing status

---

## 📡 API Endpoints

### Authentication
All requests require API key in header:
```
X-Api-Key: your-api-key
```

### Send Text Message
```bash
POST http://localhost:3000/api/sendText
Content-Type: application/json

{
  "session": "default",
  "chatId": "1234567890@c.us",
  "text": "Hello from WAHA!"
}
```

### Send Image
```bash
POST http://localhost:3000/api/sendImage
Content-Type: application/json

{
  "session": "default",
  "chatId": "1234567890@c.us",
  "file": {
    "url": "https://example.com/image.jpg"
  },
  "caption": "Check this out!"
}
```

### Set Webhook
```bash
POST http://localhost:3000/api/webhook
Content-Type: application/json

{
  "session": "default",
  "url": "https://your-server.com/webhook"
}
```

### Get All Sessions
```bash
GET http://localhost:3000/api/sessions
```

---

## 🔧 Integration Guide

### n8n Integration

1. **Install Community Node**:
   ```
   Settings → Community Nodes → Install
   Package: @devlikeapro/n8n-nodes-waha
   ```

2. **Add WAHA Credentials**:
   - URL: `http://localhost:3000`
   - API Key: `your-api-key`

3. **Use WAHA Nodes**:
   - WAHA Trigger: Receive messages
   - WAHA Actions: Send messages

### Python Integration
```python
import requests

# Send message
url = "http://localhost:3000/api/sendText"
headers = {"X-Api-Key": "your-api-key"}
data = {
    "session": "default",
    "chatId": "1234567890@c.us",
    "text": "Hello from Python!"
}
response = requests.post(url, json=data, headers=headers)
```

### Node.js Integration
```javascript
const axios = require('axios');

async function sendMessage() {
  const response = await axios.post(
    'http://localhost:3000/api/sendText',
    {
      session: 'default',
      chatId: '1234567890@c.us',
      text: 'Hello from Node.js!'
    },
    {
      headers: { 'X-Api-Key': 'your-api-key' }
    }
  );
  console.log(response.data);
}
```

---

## 💼 Use Cases

### 1. Customer Support Bot
- Automated responses to FAQs
- Ticket creation from WhatsApp
- 24/7 availability
- Multi-language support

### 2. Order Notifications
- Order confirmations
- Shipping updates
- Delivery notifications
- Payment reminders

### 3. Marketing Campaigns
- Product announcements
- Special offers
- Event invitations
- Survey collection

### 4. Internal Communications
- Team notifications
- System alerts
- Approval workflows
- Status reports

### 5. IoT Notifications
- Sensor alerts
- Security notifications
- Equipment status
- Environmental monitoring

---

## 🌟 Real World Examples

### Example 1: E-commerce Order Bot
```javascript
// When order is placed
async function notifyOrder(order) {
  await sendMessage({
    chatId: order.customerPhone + '@c.us',
    text: `🛒 Order #${order.id} confirmed!\n\n` +
          `Items: ${order.items.length}\n` +
          `Total: $${order.total}\n` +
          `Delivery: ${order.deliveryDate}\n\n` +
          `Track: https://shop.com/track/${order.id}`
  });
}
```

### Example 2: Appointment Reminder System
```javascript
// Daily cron job
async function sendReminders() {
  const tomorrow = getTomorrowsAppointments();
  
  for (const apt of tomorrow) {
    await sendMessage({
      chatId: apt.patientPhone + '@c.us',
      text: `📅 Reminder: Appointment tomorrow\n\n` +
            `Doctor: ${apt.doctor}\n` +
            `Time: ${apt.time}\n` +
            `Location: ${apt.clinic}\n\n` +
            `Reply YES to confirm or NO to cancel`
    });
  }
}
```

### Example 3: IT Alert System
```javascript
// Server monitoring
async function alertDowntime(server) {
  const admins = ['1234567890', '0987654321'];
  
  for (const admin of admins) {
    await sendMessage({
      chatId: admin + '@c.us',
      text: `🚨 ALERT: Server Down!\n\n` +
            `Server: ${server.name}\n` +
            `Status: ${server.status}\n` +
            `Time: ${new Date().toISOString()}\n\n` +
            `Check immediately!`
    });
  }
}
```

### Example 4: Restaurant Daily Menu
```javascript
// Send daily specials
async function broadcastMenu() {
  const subscribers = await getSubscribers();
  const menu = await getTodaysMenu();
  
  for (const sub of subscribers) {
    await sendImage({
      chatId: sub.phone + '@c.us',
      file: { url: menu.imageUrl },
      caption: `🍽️ Today's Specials!\n\n${menu.description}\n\nReply with item number to order!`
    });
  }
}
```

---

## 🔍 Troubleshooting

### Critical Issues

1. **"WAHA Core support only 'default' session" Error**
   - **Problem**: Using custom session names like "main" 
   - **Solution**: Use EXACTLY "default" as session name
   - **Quick Fix**: Run `./whatsapp/fix-session-issue.sh`
   - **Manual Fix**: 
     ```bash
     # Stop containers
     docker stop $(docker ps -q --filter ancestor=devlikeapro/waha)
     # Start fresh
     docker run -d --name waha-core -p 3000:3000 devlikeapro/waha:latest
     # Use "default" in dashboard, not "main"
     ```

### Common Issues

2. **QR Code Not Showing**
   - Check if port 3000 is accessible
   - Ensure Docker is running
   - Try incognito browser mode
   - Wait 15-20 seconds after container start

3. **Messages Not Sending**
   - Verify phone number format: `1234567890@c.us`
   - Check session is connected and shows "WORKING"
   - Ensure API key is correct
   - Verify session name is "default"

4. **Session Lost**
   - Enable volume mounting for persistence: `-v ~/.waha:/app/.sessions`
   - Check WhatsApp isn't logged in elsewhere
   - Restart container and re-scan QR
   - Don't use WhatsApp Web while WAHA is connected

5. **Webhook Not Working**
   - Ensure webhook URL is publicly accessible
   - Check firewall settings
   - Verify webhook response returns 200 OK
   - Test with ngrok for local development

---

## ✅ Progress Tracker

### Initial Setup Tasks
- [ ] Install Docker
- [ ] Run WAHA container
- [ ] Access dashboard at localhost:3000
- [ ] Change default password
- [ ] Start first session
- [ ] Scan QR code
- [ ] Send test message

### Integration Tasks
- [ ] Set up webhook URL
- [ ] Configure API authentication
- [ ] Test send text message
- [ ] Test send image
- [ ] Handle incoming messages
- [ ] Implement error handling
- [ ] Add logging

### Production Tasks
- [ ] Use Docker Compose
- [ ] Enable SSL/HTTPS
- [ ] Set up monitoring
- [ ] Configure backups
- [ ] Implement rate limiting
- [ ] Add multiple sessions
- [ ] Create documentation

### Advanced Features
- [ ] Group management
- [ ] Contact synchronization
- [ ] Media handling
- [ ] Status broadcasting
- [ ] Presence updates
- [ ] Read receipts control
- [ ] Multi-device support

---

## 📊 Quick Reference

### Environment Variables
```bash
WAHA_DASHBOARD_USERNAME=admin
WAHA_DASHBOARD_PASSWORD=secure-password
WAHA_API_KEY=your-api-key
WAHA_BASE_URL=http://localhost:3000
WAHA_DASHBOARD_ENABLED=true
```

### Phone Number Formats
- Individual: `1234567890@c.us`
- Group: `123456789-1234567890@g.us`
- Status/Broadcast: `status@broadcast`

### Response Codes
- `200`: Success
- `400`: Bad request
- `401`: Unauthorized
- `404`: Session not found
- `500`: Server error

---

## 🎉 Next Steps

1. **Explore API Documentation**: https://waha.devlike.pro/swagger/
2. **Join Community**: GitHub discussions
3. **Upgrade to Plus**: Additional features and support
4. **Build Something Amazing**: Share your projects!

Remember: WAHA Core is completely free with no limits. Start building your WhatsApp automation today!