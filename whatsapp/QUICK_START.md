# FashionOS WhatsApp Integration - Quick Start

## 🎯 Current Status
- ✅ WAHA Core running on port 3000
- ✅ Dashboard available at http://localhost:3000/dashboard
- ✅ Session configured for "default" name
- ✅ API endpoints ready

## 🔑 Login Credentials
- Username: `admin`
- Password: `admin`

## 📱 Connect WhatsApp
1. Open: http://localhost:3000/dashboard
2. Login with admin/admin
3. Click "Start New Session"
4. Enter name: `default` (CRITICAL!)
5. Click "Create & Start"
6. Scan QR code with WhatsApp

## 🧪 Test Connection
```bash
# Test setup
./test-waha-setup.sh

# Test API (after QR scan)
./test-api.sh

# Test with your phone number
curl -X POST http://localhost:3000/api/sendText \
  -H 'Content-Type: application/json' \
  -d '{"session":"default","chatId":"YOUR_PHONE@c.us","text":"Test from FashionOS!"}'
```

## 🔧 Management Commands
```bash
# Start WAHA
docker start waha-core

# Stop WAHA
docker stop waha-core

# View logs
docker logs waha-core

# Restart with fresh setup
./fix-session-issue.sh
```

## 📚 Integration Examples
- `fashionos-integration.js` - Node.js integration class
- Event confirmations, reminders, sponsor notifications
- Designer showcase broadcasts
- Multi-recipient messaging

## 🆘 Troubleshooting
- **QR not showing**: Wait 20 seconds, refresh browser
- **Session fails**: Use exactly "default" as name
- **API errors**: Check session status first
- **Container issues**: Run `./fix-session-issue.sh`

## 📞 Support
- Dashboard: http://localhost:3000/dashboard
- API Docs: https://waha.devlike.pro/swagger/
- GitHub: https://github.com/devlikeapro/waha
