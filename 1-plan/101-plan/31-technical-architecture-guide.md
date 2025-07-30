# 🏗️ Technical Architecture Guide: Fashion Week AI Platform

## Overview

Complete technical architecture for the Fashion Week AI platform integrating CopilotKit, CrewAI, LangGraph, Supabase, and 35+ MCP servers with Colombian market specialization.

## 🎯 Architecture Principles

### Core Design Requirements (Based on Research)
- **AI-First**: Every interaction enhanced by intelligent agents
- **Colombian Localization**: Spanish primary, local payments (PSE, Nequi, Efecty)
- **Response Time**: <2 seconds for AI interactions (industry standard)
- **Uptime**: 99.95% during fashion weeks
- **Mobile-Responsive**: 67.5% of users require mobile optimization

## 🎨 Frontend Architecture: CopilotKit + Next.js

### CopilotKit Integration

```typescript
// app/layout.tsx - Root Configuration
'use client';
import { CopilotKit } from "@copilotkit/react-core";

const cloudConfig = {
  apiKey: process.env.NEXT_PUBLIC_COPILOT_CLOUD_API_KEY!,
  agents: [
    {
      name: "EventPlannerAgent",
      description: "Plans fashion week events in Colombia",
      model: "gpt-4o",
      systemPrompt: `Expert in Colombian fashion events, venues in Medellín/Bogotá...`
    },
    {
      name: "SponsorMatchingAgent", 
      description: "Matches sponsors with opportunities",
      model: "gpt-4o",
      systemPrompt: `Specializes in Colombian corporate sponsorships...`
    }
  ],
  locale: "es-CO",
  fallbackLocale: "en-US"
};

export default function RootLayout({ children }) {
  return (
    <CopilotKit cloudConfig={cloudConfig}>
      <SupabaseProvider>
        <AuthProvider>
          {children}
        </AuthProvider>
      </SupabaseProvider>
    </CopilotKit>
  );
}
```

### Core Dashboard Component

```typescript
// components/FashionWeekDashboard.tsx
import { CopilotSidebar, useCopilotAction, useCopilotReadable } from "@copilotkit/react-core";

export const FashionWeekDashboard = () => {
  // Make event data readable by AI
  useCopilotReadable({
    description: "Current fashion week event details",
    value: {
      event: currentEvent,
      stakeholders: eventStakeholders,
      venues: selectedVenues,
      budget: budgetStatus
    },
  });

  // Enable AI actions
  useCopilotAction({
    name: "scheduleRunwayShow",
    description: "Schedule new runway show with optimal timing",
    parameters: [
      { name: "designerName", type: "string", required: true },
      { name: "preferredDate", type: "string", required: true },
      { name: "duration", type: "number", required: true }
    ],
    handler: async (params) => {
      const result = await scheduleRunwayShow(params);
      return `Show scheduled for ${params.designerName} on ${params.preferredDate}`;
    },
  });

  return (
    <div className="grid grid-cols-12 gap-6">
      <div className="col-span-8">
        <EventOverview />
        <RunwaySchedule />
        <SponsorshipTracker />
      </div>
      <div className="col-span-4">
        <CopilotSidebar
          instructions="Assistant for Colombia Moda 2025. Focus on Colombian context, local vendors, cultural considerations. All amounts in Colombian Pesos (COP)."
          labels={{
            title: "Asistente de Pasarela",
            initial: "¿Cómo puedo ayudarte con tu evento de moda?"
          }}
        />
      </div>
    </div>
  );
};
```

### Colombian Localization

```typescript
// lib/localization/colombian-context.ts
export const ColombianFashionContext = {
  currency: {
    primary: "COP",
    formatting: new Intl.NumberFormat("es-CO", {
      style: "currency",
      currency: "COP",
      minimumFractionDigits: 0,
    }),
  },
  
  paymentMethods: [
    { id: "pse", name: "PSE", type: "bank_transfer" },
    { id: "nequi", name: "Nequi", type: "digital_wallet" },
    { id: "efecty", name: "Efecty", type: "cash_network" },
    { id: "daviplata", name: "Daviplata", type: "digital_wallet" },
    { id: "stripe", name: "Tarjeta Internacional", type: "card" }
  ],
  
  fashionTerminology: {
    "runway": "pasarela",
    "designer": "diseñador/a", 
    "collection": "colección",
    "model": "modelo",
    "sponsor": "patrocinador",
    "venue": "venue/sede"
  },
  
  culturalConsiderations: {
    workingHours: { start: "08:00", end: "18:00", timezone: "America/Bogota" },
    businessDays: [1, 2, 3, 4, 5],
    fashionSeasons: {
      "alta-costura": "January-March",
      "prêt-à-porter": "July-September"
    }
  }
};
```

## 🤖 Backend Architecture: CrewAI + LangGraph

### CrewAI Agent System

```python
# agents/fashion_week_crew.py
from crewai import Agent, Task, Crew
from langchain_openai import ChatOpenAI

class FashionWeekCrewSystem:
    def __init__(self):
        self.llm = ChatOpenAI(model="gpt-4o", temperature=0.7)
        self.setup_agents()
    
    def setup_agents(self):
        # Event Planning Agent
        self.planner_agent = Agent(
            role="Fashion Week Event Planner",
            goal="Orchestrate comprehensive fashion week events in Colombia",
            backstory="""Expert event planner with 15+ years Colombian fashion industry experience. 
            Understands local customs, Medellín/Bogotá venues, Latin American fashion week requirements.""",
            tools=[venue_search_tool, calendar_tool, budget_optimizer_tool],
            llm=self.llm
        )
        
        # Sponsor Acquisition Agent
        self.sponsor_agent = Agent(
            role="Corporate Sponsor Acquisition Specialist",
            goal="Match brands with optimal Colombian fashion sponsorship opportunities",
            backstory="""Corporate partnerships specialist for luxury brands in Latin America. 
            Deep Colombian corporate culture understanding and major company connections.""",
            tools=[brand_database_tool, roi_calculator_tool, contract_generator_tool],
            llm=self.llm
        )
        
        # Marketing Agent
        self.marketing_agent = Agent(
            role="Fashion Week Marketing Director",
            goal="Create viral campaigns for Colombian fashion events",
            backstory="""Digital marketing specialist for Latin American fashion events. 
            Expert in Colombian social media trends and influencer culture.""",
            tools=[social_scheduler_tool, influencer_matcher_tool, content_generator_tool],
            llm=self.llm
        )
        
        # Model Coordination Agent
        self.model_agent = Agent(
            role="Model Coordination Specialist", 
            goal="Manage model casting and coordination for runway shows",
            backstory="""Talent coordinator for fashion shows across Colombia and Latin America. 
            Expert in local modeling agencies and casting logistics.""",
            tools=[model_database_tool, casting_scheduler_tool, fitting_coordinator_tool],
            llm=self.llm
        )
```

### LangGraph Workflow Orchestration

```python
# workflows/fashion_week_orchestrator.py
from langgraph import StateGraph, END
from typing import TypedDict

class FashionWeekState(TypedDict):
    event_id: str
    event_name: str
    dates: List[str]
    budget: float
    expected_attendance: int
    current_phase: str
    decisions_made: List[Dict]
    colombian_context: Dict

class FashionWeekOrchestrator:
    def __init__(self, crew_system):
        self.crew_system = crew_system
        self.workflow = self.build_workflow()
    
    def build_workflow(self):
        workflow = StateGraph(FashionWeekState)
        
        # Add workflow phases
        workflow.add_node("event_conception", self.event_conception_phase)
        workflow.add_node("stakeholder_onboarding", self.stakeholder_phase)  
        workflow.add_node("venue_selection", self.venue_phase)
        workflow.add_node("sponsor_acquisition", self.sponsor_phase)
        workflow.add_node("marketing_launch", self.marketing_phase)
        workflow.add_node("live_execution", self.execution_phase)
        
        # Set entry and conditional edges
        workflow.set_entry_point("event_conception")
        workflow.add_conditional_edges(
            "event_conception",
            self.should_proceed,
            {"proceed": "stakeholder_onboarding", "revise": "event_conception"}
        )
        
        return workflow.compile()
    
    async def event_conception_phase(self, state: FashionWeekState):
        """Initial event planning with Colombian context"""
        conception_task = Task(
            description=f"""Plan fashion week event for Colombia:
            - Event: {state['event_name']}
            - Dates: {state['dates']}
            - Budget: ${state['budget']:,.0f} COP
            - Attendance: {state['expected_attendance']}
            
            Consider Colombian specifics: Medellín/Bogotá venues, local customs, 
            business practices, holiday calendar, fashion seasons.""",
            agent=self.crew_system.planner_agent
        )
        
        result = await conception_task.execute_async()
        state["decisions_made"].append({
            "phase": "conception",
            "decisions": result.output,
            "timestamp": datetime.now().isoformat()
        })
        
        return state
```

## 🗄️ Database Architecture: Supabase

### Core Schema

```sql
-- Core fashion week management
CREATE TABLE fashion_weeks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    city TEXT NOT NULL,
    country TEXT DEFAULT 'Colombia',
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    budget DECIMAL(15,2), -- Colombian Pesos
    expected_attendance INTEGER,
    status TEXT DEFAULT 'planning',
    colombian_context JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Multi-stakeholder management
CREATE TABLE stakeholders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    type TEXT NOT NULL, -- designer, sponsor, model, vendor, media
    organization_name TEXT,
    contact_person TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    whatsapp_number TEXT, -- Crucial in Colombia
    city TEXT,
    specialties TEXT[],
    portfolio_url TEXT,
    verification_status TEXT DEFAULT 'pending',
    colombian_tax_id TEXT, -- RUT/NIT for businesses
    preferred_language TEXT DEFAULT 'es',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Runway show scheduling
CREATE TABLE runway_shows (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    fashion_week_id UUID REFERENCES fashion_weeks(id),
    designer_id UUID REFERENCES stakeholders(id),
    show_name TEXT NOT NULL,
    scheduled_time TIMESTAMPTZ NOT NULL,
    duration_minutes INTEGER DEFAULT 30,
    venue_id UUID REFERENCES venues(id),
    ticket_tiers JSONB, -- Dynamic pricing
    models_required INTEGER DEFAULT 12,
    status TEXT DEFAULT 'scheduled',
    livestream_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Colombian payment integration
CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    stakeholder_id UUID REFERENCES stakeholders(id),
    amount DECIMAL(15,2) NOT NULL,
    currency TEXT DEFAULT 'COP',
    payment_method TEXT NOT NULL, -- pse, nequi, efecty, stripe
    payment_status TEXT DEFAULT 'pending',
    transaction_id TEXT,
    commission_rate DECIMAL(5,4),
    tax_amount DECIMAL(15,2), -- Colombian IVA
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Row Level Security
ALTER TABLE fashion_weeks ENABLE ROW LEVEL SECURITY;
ALTER TABLE stakeholders ENABLE ROW LEVEL SECURITY;

-- Policies
CREATE POLICY "Stakeholders view own data" ON stakeholders
    FOR SELECT USING (auth.uid()::text = id::text);

CREATE POLICY "Organizers manage events" ON fashion_weeks
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM stakeholders 
            WHERE id = auth.uid()::text::uuid 
            AND type = 'organizer'
        )
    );
```

### Real-time Subscriptions

```typescript
// lib/supabase/realtime-service.ts
export class FashionWeekRealtimeService {
    // Subscribe to runway show updates
    subscribeToRunwayShows(fashionWeekId: string, callback: (payload: any) => void) {
        return supabase
            .channel(`runway-shows:${fashionWeekId}`)
            .on(
                'postgres_changes',
                {
                    event: '*',
                    schema: 'public',
                    table: 'runway_shows',
                    filter: `fashion_week_id=eq.${fashionWeekId}`,
                },
                callback
            )
            .subscribe();
    }
    
    // Subscribe to payment updates
    subscribeToPayments(stakeholderId: string, callback: (payload: any) => void) {
        return supabase
            .channel(`payments:${stakeholderId}`)
            .on(
                'postgres_changes',
                {
                    event: 'UPDATE',
                    schema: 'public', 
                    table: 'payments',
                    filter: `stakeholder_id=eq.${stakeholderId}`,
                },
                callback
            )
            .subscribe();
    }
    
    // Live attendee presence tracking
    subscribeToAttendeePresence(eventId: string, callback: (presence: any) => void) {
        return supabase
            .channel(`attendees:${eventId}`, {
                config: { presence: { key: 'user_id' } }
            })
            .on('presence', { event: 'sync' }, () => {
                const state = channel.presenceState();
                callback(state);
            })
            .subscribe();
    }
}
```

## 🔌 MCP Integration Layer

### MCP Server Configuration

```typescript
// lib/mcp/fashion-week-mcp-config.ts
export const FashionWeekMCPConfig = {
    servers: {
        // Core systems
        supabase: {
            command: "npx",
            args: ["@supabase/mcp-server"],
            env: {
                SUPABASE_URL: process.env.SUPABASE_URL,
                SUPABASE_SERVICE_ROLE_KEY: process.env.SUPABASE_SERVICE_ROLE_KEY,
            },
        },
        
        // Colombian payments
        pse_payment: {
            command: "node",
            args: ["./mcp-servers/pse-server.js"],
            env: {
                PSE_API_KEY: process.env.PSE_API_KEY,
                PSE_MERCHANT_ID: process.env.PSE_MERCHANT_ID,
            },
        },
        
        nequi_payment: {
            command: "node",
            args: ["./mcp-servers/nequi-server.js"], 
            env: {
                NEQUI_API_KEY: process.env.NEQUI_API_KEY,
                NEQUI_CLIENT_ID: process.env.NEQUI_CLIENT_ID,
            },
        },
        
        // Communication
        whatsapp: {
            command: "node",
            args: ["./mcp-servers/whatsapp-server.js"],
            env: {
                WHATSAPP_TOKEN: process.env.WHATSAPP_TOKEN,
                WHATSAPP_PHONE_ID: process.env.WHATSAPP_PHONE_ID,
            },
        },
        
        // Social media
        instagram: {
            command: "node",
            args: ["./mcp-servers/instagram-server.js"],
            env: {
                INSTAGRAM_ACCESS_TOKEN: process.env.INSTAGRAM_ACCESS_TOKEN,
            },
        },
        
        // Automation
        n8n: {
            command: "node",
            args: ["./mcp-servers/n8n-server.js"],
            env: {
                N8N_API_KEY: process.env.N8N_API_KEY,
                N8N_BASE_URL: process.env.N8N_BASE_URL,
            },
        },
        
        // Colombian compliance
        dian_integration: {
            command: "node",
            args: ["./mcp-servers/dian-server.js"],
            env: {
                DIAN_API_KEY: process.env.DIAN_API_KEY,
                DIAN_CLIENT_ID: process.env.DIAN_CLIENT_ID,
            },
        }
    }
};
```

## 🚀 Production Deployment

### Docker Configuration

```yaml
# docker-compose.production.yml
version: '3.8'
services:
  frontend:
    build:
      context: .
      dockerfile: Dockerfile.frontend
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - NEXT_PUBLIC_SUPABASE_URL=${SUPABASE_URL}
      - NEXT_PUBLIC_COPILOT_CLOUD_API_KEY=${COPILOT_CLOUD_API_KEY}
    depends_on:
      - crewai-backend
  
  crewai-backend:
    build:
      context: ./backend
      dockerfile: Dockerfile.crewai
    ports:
      - "8000:8000"
    environment:
      - OPENAI_API_KEY=${OPENAI_API_KEY}
      - SUPABASE_URL=${SUPABASE_URL}
      - PSE_API_KEY=${PSE_API_KEY}
      - NEQUI_API_KEY=${NEQUI_API_KEY}
      - WHATSAPP_TOKEN=${WHATSAPP_TOKEN}
    volumes:
      - ./mcp-servers:/app/mcp-servers
  
  redis:
    image: redis:alpine
    ports:
      - "6379:6379"
```

### Performance Monitoring

```typescript
// lib/monitoring/performance-monitor.ts
export class FashionWeekPerformanceMonitor {
    private metrics: Map<string, number[]> = new Map();
    
    // Track AI agent response times (target: <2s)
    trackAgentResponse(agentName: string, responseTime: number) {
        if (!this.metrics.has(agentName)) {
            this.metrics.set(agentName, []);
        }
        this.metrics.get(agentName)!.push(responseTime);
        
        // Alert if exceeds 2 seconds
        if (responseTime > 2000) {
            console.error(`ALERT: ${agentName} response time: ${responseTime}ms`);
        }
    }
    
    // Monitor Colombian payment providers
    trackPaymentProvider(provider: string, success: boolean, duration: number) {
        const key = `payment_${provider}`;
        if (!success) {
            console.error(`ALERT: Payment failure with ${provider}`);
        }
    }
    
    // Track database performance
    trackDatabaseQuery(query: string, duration: number) {
        if (duration > 1000) {
            console.error(`ALERT: Slow DB query: ${query} (${duration}ms)`);
        }
    }
}
```

## 📊 Key Technical Specifications

### Performance Requirements
- **AI Response Time**: <2 seconds (industry standard)
- **Database Queries**: <1 second for complex queries
- **API Endpoints**: <500ms response time
- **Mobile Performance**: First Contentful Paint <2 seconds
- **Concurrent Users**: Support 60,000+ during Colombia Moda

### Colombian Market Integration
- **Primary Language**: Spanish (es-CO locale)
- **Payment Methods**: PSE, Nequi, Efecty, Daviplata integration
- **Currency**: Colombian Pesos (COP) with proper formatting
- **Timezone**: America/Bogota
- **Tax Compliance**: Colombian IVA (19%) integration
- **Business Registry**: DIAN (Colombian tax authority) integration

### Security & Compliance
- **Authentication**: Supabase Auth with Colombian ID support
- **Data Protection**: GDPR compliance + Colombian data laws
- **Payment Security**: PCI DSS compliance for card payments
- **API Security**: Rate limiting, request validation, CORS
- **Database Security**: Row Level Security (RLS) policies

This technical architecture provides the complete foundation for building the Fashion Week AI platform with robust Colombian market integration and enterprise-grade performance. 