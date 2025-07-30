# 🎯 WAHA SESSION NAME - FINAL SOLUTION

## ❌ THE ERROR YOU SAW:
```
WAHA Core support only 'default' session. 
You tried to access 'whatsapp' session
```

## ✅ THE FIX:
**Use session name `default` instead of `whatsapp`**

## 📱 EXACT STEPS:

### 1. Dashboard Access
- URL: http://localhost:3000/dashboard
- Login: `admin` / `admin`

### 2. Create Session
- Click: "Start New Session" or "+" button
- Session Name: **`default`** (exactly this, lowercase)
- Click: "Create & Start"

### 3. Connect WhatsApp
- QR code appears
- Open WhatsApp on your phone
- Go to Settings > Linked Devices
- Scan the QR code
- Wait for "WORKING" status

## 🧪 TEST CONNECTION:
```bash
# Check if session is working
curl http://localhost:3000/api/sessions/default/status

# Send test message (replace YOUR_PHONE)
curl -X POST http://localhost:3000/api/sendText \
  -H 'Content-Type: application/json' \
  -d '{
    "session": "default",
    "chatId": "YOUR_PHONE@c.us", 
    "text": "Hello from FashionOS!"
  }'
```

## 🚨 REMEMBER:
- ✅ Session name: `default`
- ❌ NOT: `whatsapp`, `main`, `fashionos`
- ✅ WAHA Core = 1 session only
- ✅ Session name is case-sensitive

## 🔧 IF STILL ISSUES:
```bash
# Complete reset
./whatsapp/fix-session-name.sh

# Or manual reset
docker stop waha-core
docker rm waha-core
rm -rf ~/.waha/*
docker run -d --name waha-core -p 3000:3000 devlikeapro/waha:latest
```

## 🎉 SUCCESS INDICATORS:
- Dashboard shows: Session "default" - Status: WORKING
- API returns: `{"status": "WORKING"}`
- Test message sends successfully

---
**You're now ready to integrate WhatsApp with FashionOS!** 🚀