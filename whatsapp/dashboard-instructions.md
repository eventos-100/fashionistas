# WAHA Dashboard Instructions - CRITICAL SESSION NAME FIX

## 🚨 THE PROBLEM
You tried to create a session named "whatsapp" but WAHA Core ONLY supports "default"

## ✅ THE SOLUTION

### Step 1: Access Dashboard
- Open: http://localhost:3000/dashboard
- Login: `admin` / `admin`

### Step 2: Create Session (CRITICAL!)
1. Click "Start New Session" or "+" button
2. **Session Name Field**: Enter EXACTLY `default`
3. ❌ DO NOT use: `whatsapp`, `main`, `fashionos`, or ANY other name
4. ✅ ONLY use: `default`
5. Click "Create & Start" or "Start Session"

### Step 3: QR Code
- QR code should appear immediately
- Scan with your WhatsApp mobile app
- Wait for "Connected" or "WORKING" status

## 🎯 What You Should See

### In the Dashboard:
```
Session Name: default
Status: WORKING (after QR scan)
QR Code: [QR code image]
```

### Session List Should Show:
```
Name: default
Status: WORKING
Actions: [Stop] [Restart] [QR]
```

## 🔧 If Still Having Issues

### Reset Everything:
```bash
# Run this script to completely reset
./whatsapp/fix-session-name.sh
```

### Manual Reset:
```bash
# Stop container
docker stop waha-core

# Remove container  
docker rm waha-core

# Clean data
rm -rf ~/.waha/*

# Start fresh
docker run -d --name waha-core -p 3000:3000 devlikeapro/waha:latest

# Wait 20 seconds, then go to dashboard
```

## 📱 Test After Connection

Once you see "WORKING" status, test with:

```bash
curl -X POST http://localhost:3000/api/sendText \
  -H 'Content-Type: application/json' \
  -d '{
    "session": "default",
    "chatId": "YOUR_PHONE_NUMBER@c.us",
    "text": "Test from FashionOS WAHA!"
  }'
```

## 🚨 REMEMBER
- Session name MUST be `default`
- WAHA Core = single session only
- WAHA Plus = multiple sessions (paid)
- Case sensitive: use lowercase `default`

## 📞 Current Status Check
```bash
# Check if container is running
docker ps | grep waha

# Check API
curl http://localhost:3000/api/sessions

# Check specific session
curl http://localhost:3000/api/sessions/default/status
```