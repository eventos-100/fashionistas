# 🚀 EventsOS Quick Reference Sheet

## 📋 Tech Stack Overview

### **Frontend (Public Website)**
```yaml
Framework: Next.js 14+ with TypeScript
UI Library: Material-UI (MUI) v5
Template: https://github.com/mui/material-ui/tree/master/examples/material-ui-nextjs-ts
Key Features:
  - Event discovery
  - Ticket purchasing
  - Attendee registration
  - Mobile-responsive design
```

### **Dashboard (Organizer Portal)**
```yaml
Framework: Refine + Material-UI
Docs: https://refine.dev/docs/ui-integrations/material-ui/introduction/
Database: Supabase (PostgreSQL)
Key Features:
  - Event management
  - Real-time analytics
  - Attendee tracking
  - Revenue optimization
```

### **CRM Integration**
```yaml
Platform: Twenty CRM
URL: https://twenty.com/
Purpose: Contact management, lead tracking, buyer relationships
Integration Points:
  - Sync attendee data
  - Track buyer interactions
  - Manage sponsor relationships
```

### **Communication Stack**
```yaml
Email: SendGrid (https://sendgrid.com/)
  - Transactional emails
  - Marketing campaigns
  - Event reminders
  
WhatsApp: Business API
  - Instant notifications
  - Ticket delivery
  - Support chat
```

### **AI & Automation**
```yaml
CrewAI: Multi-agent automation
  - Event planning agents
  - Content generation
  - Task automation
  Example: https://github.com/alexfazio/crewAI-quickstart/

CopilotKit: AI assistant integration
  - In-app AI assistance
  - Form completion
  - Smart suggestions
  
Claude Desktop: Development assistant
OpenAI: Content generation, chatbots
```

### **Workflow & Integrations**
```yaml
n8n: Workflow automation
  - Connect all services
  - Scheduled tasks
  - Event triggers
  
Stripe: Payment processing
  - Ticket sales
  - Refunds
  - Subscription billing
  
Cloudinary: Media management
  - Event images
  - Designer portfolios
  - Automatic optimization
```

---

## 🎯 Quick Implementation Guide

### **1. Website Setup (Material-UI)**
```bash
# Clone and setup
git clone https://github.com/mui/material-ui/tree/master/examples/material-ui-nextjs-ts
cd material-ui-nextjs-ts
npm install
npm run dev
```

**Key Components:**
```typescript
// Event Card Component
import { Card, CardContent, Typography, Button } from '@mui/material';

export function EventCard({ event }) {
  return (
    <Card sx={{ maxWidth: 345 }}>
      <CardContent>
        <Typography variant="h5">{event.name}</Typography>
        <Typography variant="body2">{event.date}</Typography>
        <Button variant="contained">Buy Tickets</Button>
      </CardContent>
    </Card>
  );
}
```

### **2. Dashboard Setup (Refine + MUI)**
```bash
# Create Refine app with Material-UI
npm create refine-app@latest -- --preset refine-mui
cd my-refine-app
npm run dev
```

**Dashboard Resource Example:**
```typescript
// Event Resource in Refine
import { List, Datagrid, TextField, DateField } from "@refinedev/mui";

export const EventList = () => {
  return (
    <List>
      <Datagrid>
        <TextField source="name" />
        <DateField source="date" />
        <TextField source="venue" />
        <TextField source="ticketsSold" />
      </Datagrid>
    </List>
  );
};
```

### **3. Supabase Integration**
```typescript
// Initialize Supabase
import { createClient } from '@supabase/supabase-js'

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

// Fetch events
const { data: events } = await supabase
  .from('events')
  .select('*')
  .order('date', { ascending: true })
```

### **4. SendGrid Email Integration**
```typescript
// Send event confirmation
import sgMail from '@sendgrid/mail'
sgMail.setApiKey(process.env.SENDGRID_API_KEY)

const msg = {
  to: attendee.email,
  from: 'events@fashionos.com',
  subject: 'Your ticket for Fashion Week',
  html: generateTicketEmail(attendee, event),
}
await sgMail.send(msg)
```

### **5. Stripe Payment Integration**
```typescript
// Create checkout session
import Stripe from 'stripe'
const stripe = new Stripe(process.env.STRIPE_SECRET_KEY)

const session = await stripe.checkout.sessions.create({
  payment_method_types: ['card'],
  line_items: [{
    price_data: {
      currency: 'usd',
      product_data: { name: ticketType.name },
      unit_amount: ticketType.price * 100,
    },
    quantity: 1,
  }],
  success_url: `${YOUR_DOMAIN}/success?session_id={CHECKOUT_SESSION_ID}`,
})
```

### **6. n8n Workflow Example**
```json
{
  "name": "Event Registration Flow",
  "nodes": [
    {
      "type": "webhook",
      "name": "New Registration",
      "webhookPath": "event-registration"
    },
    {
      "type": "supabase",
      "operation": "insert",
      "table": "attendees"
    },
    {
      "type": "sendgrid",
      "operation": "send",
      "template": "welcome-email"
    },
    {
      "type": "stripe",
      "operation": "create-customer"
    }
  ]
}
```

---

## 🔧 Common Use Cases

### **Fashion Show Management**
```typescript
// Seating Chart Component
const SeatingChart = () => {
  const [seats, setSeats] = useState([]);
  
  return (
    <Grid container spacing={1}>
      {seats.map(seat => (
        <Grid item key={seat.id}>
          <Button 
            variant={seat.occupied ? "contained" : "outlined"}
            onClick={() => assignSeat(seat.id)}
          >
            {seat.number}
          </Button>
        </Grid>
      ))}
    </Grid>
  );
};
```

### **Real-time Check-in**
```typescript
// QR Code Scanner Integration
const CheckInScanner = () => {
  const handleScan = async (ticketId) => {
    const { data, error } = await supabase
      .from('check_ins')
      .insert({ ticket_id: ticketId, checked_in_at: new Date() })
    
    if (data) {
      showNotification('Guest checked in successfully!')
    }
  };
  
  return <QRScanner onScan={handleScan} />;
};
```

---

## 📊 Best Practices Checklist

### **Performance**
- [ ] Lazy load images with Cloudinary
- [ ] Use Material-UI's built-in optimization
- [ ] Implement Supabase RLS policies
- [ ] Cache API responses

### **Security**
- [ ] Environment variables for all keys
- [ ] Validate all user inputs
- [ ] Use Supabase Auth for authentication
- [ ] Implement rate limiting

### **User Experience**
- [ ] Mobile-first design
- [ ] Real-time updates with Supabase
- [ ] Progressive Web App features
- [ ] Offline capability for check-ins

---

## 🚀 Quick Commands

```bash
# Development
npm run dev          # Start development server
npm run build        # Build for production
npm run test         # Run tests

# Database
npx supabase db push # Push schema changes
npx supabase gen types typescript # Generate types

# Deployment
vercel --prod        # Deploy to Vercel
npm run docker:build # Build Docker image
```

---

## 📞 Support Resources

- **Refine Docs**: https://refine.dev/docs/
- **Material-UI**: https://mui.com/material-ui/
- **Supabase**: https://supabase.com/docs
- **Twenty CRM**: https://twenty.com/developers
- **n8n**: https://docs.n8n.io/

Remember: Focus on **fashion event needs**, **real-time capabilities**, and **revenue optimization** in every feature you build!