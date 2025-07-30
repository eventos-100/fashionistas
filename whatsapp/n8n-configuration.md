# n8n WhatsApp Configuration for WAHA

## 🎯 Configuration Details for n8n Template

### WAHA Connection Settings
```
Base URL: http://localhost:3000
API Endpoint: http://localhost:3000/api
Session Name: default
```

### n8n WAHA Node Configuration

#### 1. WAHA Credentials
```
Name: WAHA Local
URL: http://localhost:3000
API Key: (leave empty for WAHA Core)
```

#### 2. HTTP Request Node Settings
```
Method: POST
URL: http://localhost:3000/api/sendText
Headers:
  Content-Type: application/json
Body (JSON):
{
  "session": "default",
  "chatId": "{{ $json.phone }}@c.us",
  "text": "{{ $json.message }}"
}
```

#### 3. Webhook Settings (for receiving messages)
```
Webhook URL: http://localhost:3000/api/webhook
Method: POST
Body:
{
  "session": "default",
  "url": "YOUR_N8N_WEBHOOK_URL"
}
```

## 📱 Phone Number Format
```
Individual: 1234567890@c.us
Group: 123456789-1234567890@g.us
```

## 🔧 Complete n8n Workflow Configuration

### Node 1: Webhook Trigger
```
HTTP Method: POST
Path: /whatsapp-webhook
```

### Node 2: WAHA Send Message
```
URL: http://localhost:3000/api/sendText
Method: POST
Headers:
  Content-Type: application/json
Body:
{
  "session": "default",
  "chatId": "{{ $json.from }}",
  "text": "Hello! This is an automated response from FashionOS."
}
```

### Node 3: WAHA Send Image (Optional)
```
URL: http://localhost:3000/api/sendImage
Method: POST
Headers:
  Content-Type: application/json
Body:
{
  "session": "default",
  "chatId": "{{ $json.from }}",
  "file": {
    "url": "https://your-image-url.com/image.jpg"
  },
  "caption": "Check out our latest fashion collection!"
}
```

## 🚀 Quick Setup Steps

### 1. Install WAHA Community Node
```
n8n Settings → Community Nodes → Install
Package: @devlikeapro/n8n-nodes-waha
```

### 2. Create WAHA Credential
```
Credential Type: WAHA
URL: http://localhost:3000
API Key: (leave empty)
```

### 3. Test Connection
```
Use "Test Connection" in n8n
Should return: Connection successful
```

## 📋 Environment Variables for n8n
```
WAHA_BASE_URL=http://localhost:3000
WAHA_SESSION=default
WAHA_API_ENDPOINT=http://localhost:3000/api
```

## 🧪 Test Workflow

### Simple Test Message
```json
{
  "session": "default",
  "chatId": "YOUR_PHONE@c.us",
  "text": "Test from n8n + WAHA integration!"
}
```

### FashionOS Event Notification
```json
{
  "session": "default",
  "chatId": "{{ $json.attendee_phone }}@c.us",
  "text": "🎭 FashionOS Event Reminder\n\nEvent: {{ $json.event_name }}\nDate: {{ $json.event_date }}\nVenue: {{ $json.venue }}\n\nSee you there! ✨"
}
```

## 🔗 Webhook Setup for Incoming Messages

### 1. Set WAHA Webhook
```bash
curl -X POST http://localhost:3000/api/webhook \
  -H 'Content-Type: application/json' \
  -d '{
    "session": "default",
    "url": "YOUR_N8N_WEBHOOK_URL"
  }'
```

### 2. n8n Webhook Response Format
```json
{
  "event": "message",
  "session": "default",
  "payload": {
    "id": "message_id",
    "timestamp": 1234567890,
    "from": "1234567890@c.us",
    "fromMe": false,
    "body": "Hello!",
    "type": "chat"
  }
}
```

## 🎯 FashionOS Specific Workflows

### Event Registration Confirmation
```json
{
  "session": "default",
  "chatId": "{{ $json.phone }}@c.us",
  "text": "🎉 Registration Confirmed!\n\nEvent: {{ $json.event_name }}\nTicket: {{ $json.ticket_code }}\nDate: {{ $json.date }}\n\nFashionOS Team"
}
```

### Sponsor Welcome Message
```json
{
  "session": "default",
  "chatId": "{{ $json.sponsor_phone }}@c.us",
  "text": "🤝 Welcome {{ $json.company_name }}!\n\nThank you for sponsoring {{ $json.event_name }}.\nPackage: {{ $json.package_type }}\n\nLet's make fashion history together!"
}
```

## 🚨 Important Notes

1. **Session Name**: Always use `default`
2. **Phone Format**: Include country code, add `@c.us`
3. **API Key**: Not required for WAHA Core
4. **Base URL**: Use `http://localhost:3000` (not https)
5. **Testing**: Test with your own phone number first

## 🔧 Troubleshooting

### Connection Issues
```
Error: Connection failed
Solution: Check WAHA is running on port 3000
Command: docker ps | grep waha
```

### Session Not Found
```
Error: Session 'default' not found
Solution: Create session in WAHA dashboard first
URL: http://localhost:3000/dashboard
```

### Message Not Sending
```
Error: Message failed to send
Solution: Check session status
Command: curl http://localhost:3000/api/sessions/default/status
```