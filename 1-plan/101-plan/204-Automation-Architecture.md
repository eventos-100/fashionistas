# AI Agents & Automation Architecture

## 🤖 AI Agent Ecosystem Overview

Based on the latest LangChain developments (2025), our platform leverages cutting-edge agent orchestration capabilities through LangGraph, the now-GA platform for production agents.

### **Core AI Agents**

#### 1. Event Planning Intelligence Agent
```python
# LangGraph Agent Implementation
from langgraph.graph import StateGraph
from langgraph.prebuilt import create_react_agent
from langchain_openai import ChatOpenAI

class EventPlanningAgent:
    def __init__(self):
        self.llm = ChatOpenAI(model="gpt-4", temperature=0.2)
        self.graph = StateGraph(EventPlanningState)
        self._build_workflow()
    
    def _build_workflow(self):
        # Agent nodes
        self.graph.add_node("venue_analyzer", self.analyze_venue_requirements)
        self.graph.add_node("sponsor_matcher", self.match_potential_sponsors)
        self.graph.add_node("budget_optimizer", self.optimize_event_budget)
        self.graph.add_node("timeline_planner", self.create_timeline)
        self.graph.add_node("risk_assessor", self.assess_event_risks)
        
        # Workflow edges
        self.graph.add_edge("START", "venue_analyzer")
        self.graph.add_conditional_edges(
            "venue_analyzer",
            self.should_continue_planning,
            {
                "continue": "sponsor_matcher",
                "need_more_info": "venue_analyzer",
                "complete": "END"
            }
        )
        
        # Human-in-the-loop checkpoints
        self.graph.add_node("human_approval", self.request_human_approval)
        
    async def analyze_venue_requirements(self, state):
        """AI-powered venue analysis based on event requirements"""
        event_details = state.get("event_details", {})
        
        # Use Pinecone for semantic venue matching
        venue_query = f"""
        Event type: {event_details.get('type')}
        Expected attendees: {event_details.get('attendees')}
        Budget range: {event_details.get('budget')}
        Location preference: {event_details.get('location')}
        Special requirements: {event_details.get('requirements')}
        """
        
        # Query Pinecone for similar successful events
        similar_events = await self.pinecone_search(venue_query)
        
        # AI analysis and recommendations
        analysis = await self.llm.ainvoke([
            {"role": "system", "content": "You are an expert event planner specializing in Colombian venues and cultural events."},
            {"role": "user", "content": f"Analyze these venue requirements and provide recommendations: {venue_query}\n\nSimilar successful events: {similar_events}"}
        ])
        
        return {
            **state,
            "venue_analysis": analysis.content,
            "recommended_venues": self.extract_venue_recommendations(analysis.content)
        }
```

#### 2. Tourism Concierge Agent
```python
class TourismConciergeAgent:
    """AI agent for personalized tourism recommendations"""
    
    def __init__(self):
        self.memory = ConversationBufferWindowMemory(k=20)
        self.tools = [
            self.search_experiences_tool,
            self.check_weather_tool,
            self.get_local_events_tool,
            self.calculate_travel_time_tool
        ]
        
    async def create_personalized_itinerary(self, user_preferences):
        """Generate AI-powered itinerary based on user preferences"""
        
        # Multi-agent collaboration for comprehensive planning
        planning_crew = StateGraph({
            "preferences": user_preferences,
            "itinerary": {},
            "recommendations": [],
            "budget_analysis": {}
        })
        
        # Specialized sub-agents
        planning_crew.add_node("culture_specialist", self.culture_recommendations)
        planning_crew.add_node("food_specialist", self.restaurant_recommendations)
        planning_crew.add_node("adventure_specialist", self.adventure_recommendations)
        planning_crew.add_node("budget_analyst", self.budget_optimization)
        planning_crew.add_node("itinerary_compiler", self.compile_final_itinerary)
        
        # Parallel processing for efficiency
        planning_crew.add_edge("START", ["culture_specialist", "food_specialist", "adventure_specialist"])
        planning_crew.add_node("synchronizer", self.synchronize_recommendations)
        planning_crew.add_edges_from_all(
            ["culture_specialist", "food_specialist", "adventure_specialist"],
            "synchronizer"
        )
        planning_crew.add_edge("synchronizer", "budget_analyst")
        planning_crew.add_edge("budget_analyst", "itinerary_compiler")
        
        return await planning_crew.ainvoke({"preferences": user_preferences})
```

#### 3. Sponsor Matching & Lead Generation Agent
```python
class SponsorMatchingAgent:
    """AI-powered sponsor identification and outreach automation"""
    
    def __init__(self):
        self.crm_integration = SalesforceAPI()
        self.linkedin_scraper = LinkedInAPI()
        self.email_automation = N8nWebhooks()
    
    async def generate_sponsor_leads(self, event_profile):
        """AI-driven sponsor lead generation"""
        
        # Multi-step lead generation workflow
        lead_workflow = StateGraph(SponsorLeadState)
        
        # Research phase
        lead_workflow.add_node("market_research", self.research_industry_sponsors)
        lead_workflow.add_node("competitor_analysis", self.analyze_competitor_sponsors)
        lead_workflow.add_node("audience_analysis", self.analyze_audience_demographics)
        
        # Matching phase
        lead_workflow.add_node("ai_matching", self.ai_powered_sponsor_matching)
        lead_workflow.add_node("score_leads", self.score_sponsor_compatibility)
        
        # Outreach phase
        lead_workflow.add_node("personalize_outreach", self.create_personalized_pitches)
        lead_workflow.add_node("schedule_outreach", self.schedule_automated_outreach)
        
        # Sequential workflow with human checkpoints
        lead_workflow.add_edge("START", "market_research")
        lead_workflow.add_edge("market_research", "competitor_analysis")
        lead_workflow.add_edge("competitor_analysis", "audience_analysis")
        lead_workflow.add_edge("audience_analysis", "ai_matching")
        lead_workflow.add_edge("ai_matching", "score_leads")
        
        # Human approval before outreach
        lead_workflow.add_node("human_review", self.request_outreach_approval)
        lead_workflow.add_edge("score_leads", "human_review")
        lead_workflow.add_conditional_edges(
            "human_review",
            self.check_approval_status,
            {
                "approved": "personalize_outreach",
                "rejected": "ai_matching",
                "modify": "score_leads"
            }
        )
        
        return await lead_workflow.ainvoke({"event_profile": event_profile})
```

#### 4. WhatsApp Customer Service Agent
```python
class WhatsAppServiceAgent:
    """Advanced conversational AI for customer support"""
    
    def __init__(self):
        self.flowise_integration = FlowiseAPI()
        self.conversation_memory = SupabaseMemory()
        self.escalation_rules = EscalationRuleEngine()
    
    async def handle_customer_query(self, message, user_id, conversation_id):
        """Process customer queries with context awareness"""
        
        # Load conversation context
        context = await self.conversation_memory.get_context(conversation_id)
        user_profile = await self.get_user_profile(user_id)
        
        # Multi-step processing workflow
        response_workflow = StateGraph({
            "message": message,
            "context": context,
            "user_profile": user_profile,
            "intent": None,
            "response": None,
            "escalation_needed": False
        })
        
        # Processing nodes
        response_workflow.add_node("intent_classification", self.classify_intent)
        response_workflow.add_node("context_enrichment", self.enrich_with_context)
        response_workflow.add_node("response_generation", self.generate_response)
        response_workflow.add_node("quality_check", self.quality_assurance)
        response_workflow.add_node("escalation_check", self.check_escalation_needed)
        
        # Conditional routing based on intent
        response_workflow.add_edge("START", "intent_classification")
        response_workflow.add_conditional_edges(
            "intent_classification",
            self.route_by_intent,
            {
                "booking_inquiry": "context_enrichment",
                "complaint": "escalation_check",
                "general_info": "response_generation",
                "technical_issue": "escalation_check"
            }
        )
        
        return await response_workflow.ainvoke({
            "message": message,
            "user_id": user_id,
            "conversation_id": conversation_id
        })
```

## 🔄 n8n Automation Workflows

### **Core Automation Flows**

#### 1. Event Booking Confirmation Flow
```json
{
  "name": "Event Booking Confirmation",
  "nodes": [
    {
      "parameters": {
        "httpMethod": "POST",
        "path": "booking-confirmed",
        "responseMode": "responseNode"
      },
      "name": "Booking Webhook",
      "type": "n8n-nodes-base.webhook"
    },
    {
      "parameters": {
        "conditions": {
          "string": [
            {
              "value1": "={{$json.event_type}}",
              "operation": "equal",
              "value2": "paid_event"
            }
          ]
        }
      },
      "name": "Check Event Type",
      "type": "n8n-nodes-base.if"
    },
    {
      "parameters": {
        "authentication": "predefinedCredentialType",
        "nodeCredentialType": "stripeApi",
        "requestMethod": "POST",
        "url": "https://api.stripe.com/v1/payment_intents",
        "sendBody": true,
        "bodyParameters": {
          "parameters": [
            {
              "name": "amount",
              "value": "={{$json.ticket_price * 100}}"
            },
            {
              "name": "currency",
              "value": "cop"
            },
            {
              "name": "metadata[event_id]",
              "value": "={{$json.event_id}}"
            },
            {
              "name": "metadata[user_id]", 
              "value": "={{$json.user_id}}"
            }
          ]
        }
      },
      "name": "Create Payment Intent",
      "type": "n8n-nodes-base.httpRequest"
    },
    {
      "parameters": {
        "authentication": "predefinedCredentialType",
        "nodeCredentialType": "supabaseApi",
        "requestMethod": "POST",
        "url": "={{$env.SUPABASE_URL}}/rest/v1/bookings",
        "sendBody": true,
        "bodyParameters": {
          "parameters": [
            {
              "name": "user_id",
              "value": "={{$json.user_id}}"
            },
            {
              "name": "event_id",
              "value": "={{$json.event_id}}"
            },
            {
              "name": "status",
              "value": "confirmed"
            },
            {
              "name": "payment_intent_id",
              "value": "={{$node['Create Payment Intent'].json.id}}"
            }
          ]
        }
      },
      "name": "Save Booking",
      "type": "n8n-nodes-base.httpRequest"
    },
    {
      "parameters": {
        "authentication": "predefinedCredentialType",
        "nodeCredentialType": "whatsappBusinessApi",
        "requestMethod": "POST",
        "url": "https://graph.facebook.com/v17.0/{{$env.WHATSAPP_PHONE_ID}}/messages",
        "sendBody": true,
        "bodyParameters": {
          "parameters": [
            {
              "name": "messaging_product",
              "value": "whatsapp"
            },
            {
              "name": "to",
              "value": "={{$json.user_phone}}"
            },
            {
              "name": "type",
              "value": "template"
            },
            {
              "name": "template",
              "value": {
                "name": "event_booking_confirmation_es",
                "language": {
                  "code": "es"
                },
                "components": [
                  {
                    "type": "body",
                    "parameters": [
                      {
                        "type": "text",
                        "text": "={{$json.user_name}}"
                      },
                      {
                        "type": "text", 
                        "text": "={{$json.event_name}}"
                      },
                      {
                        "type": "text",
                        "text": "={{$json.event_date}}"
                      }
                    ]
                  }
                ]
              }
            }
          ]
        }
      },
      "name": "Send WhatsApp Confirmation",
      "type": "n8n-nodes-base.httpRequest"
    },
    {
      "parameters": {
        "authentication": "predefinedCredentialType",
        "nodeCredentialType": "postizApi",
        "requestMethod": "POST",
        "url": "https://api.postiz.com/posts",
        "sendBody": true,
        "bodyParameters": {
          "parameters": [
            {
              "name": "content",
              "value": "🎉 ¡Nuevo asistente confirmado para {{$json.event_name}}! 📅 {{$json.event_date}} #MedellínEvents #{{$json.event_category}}"
            },
            {
              "name": "platforms",
              "value": ["instagram", "facebook", "twitter"]
            },
            {
              "name": "scheduled_time",
              "value": "={{$json.event_date}}"
            }
          ]
        }
      },
      "name": "Schedule Social Media Post",
      "type": "n8n-nodes-base.httpRequest"
    }
  ],
  "connections": {
    "Booking Webhook": {
      "main": [["Check Event Type"]]
    },
    "Check Event Type": {
      "main": [["Create Payment Intent"], ["Save Booking"]]
    },
    "Create Payment Intent": {
      "main": [["Save Booking"]]
    },
    "Save Booking": {
      "main": [["Send WhatsApp Confirmation"]]
    },
    "Send WhatsApp Confirmation": {
      "main": [["Schedule Social Media Post"]]
    }
  }
}
```

#### 2. AI-Powered Social Media Campaign
```json
{
  "name": "AI Social Media Campaign Generator",
  "nodes": [
    {
      "parameters": {
        "cron": "0 9 * * *",
        "triggerAtStartup": false
      },
      "name": "Daily Campaign Trigger",
      "type": "n8n-nodes-base.cron"
    },
    {
      "parameters": {
        "authentication": "predefinedCredentialType",
        "nodeCredentialType": "supabaseApi",
        "requestMethod": "GET",
        "url": "={{$env.SUPABASE_URL}}/rest/v1/events?status=eq.upcoming&limit=5"
      },
      "name": "Get Upcoming Events",
      "type": "n8n-nodes-base.httpRequest"
    },
    {
      "parameters": {
        "authentication": "predefinedCredentialType",
        "nodeCredentialType": "openaiApi",
        "requestMethod": "POST",
        "url": "https://api.openai.com/v1/chat/completions",
        "sendBody": true,
        "bodyParameters": {
          "parameters": [
            {
              "name": "model",
              "value": "gpt-4"
            },
            {
              "name": "messages",
              "value": [
                {
                  "role": "system",
                  "content": "Eres un experto en marketing de eventos en Medellín, Colombia. Crea contenido atractivo para redes sociales que genere engagement y ventas de boletos."
                },
                {
                  "role": "user",
                  "content": "Crea 3 posts diferentes para promover este evento: {{$json.event_name}} - {{$json.event_description}}. Incluye hashtags relevantes y call-to-action en español."
                }
              ]
            },
            {
              "name": "max_tokens",
              "value": 1000
            },
            {
              "name": "temperature",
              "value": 0.7
            }
          ]
        }
      },
      "name": "Generate AI Content",
      "type": "n8n-nodes-base.httpRequest"
    },
    {
      "parameters": {
        "keepOnlySet": false,
        "values": {
          "string": [
            {
              "name": "post_content",
              "value": "={{$json.choices[0].message.content}}"
            },
            {
              "name": "event_id",
              "value": "={{$node['Get Upcoming Events'].json[0].id}}"
            },
            {
              "name": "event_image",
              "value": "={{$node['Get Upcoming Events'].json[0].featured_image}}"
            }
          ]
        }
      },
      "name": "Format Content",
      "type": "n8n-nodes-base.set"
    },
    {
      "parameters": {
        "authentication": "predefinedCredentialType",
        "nodeCredentialType": "postizApi",
        "requestMethod": "POST",
        "url": "https://api.postiz.com/posts/schedule",
        "sendBody": true,
        "bodyParameters": {
          "parameters": [
            {
              "name": "content",
              "value": "={{$json.post_content}}"
            },
            {
              "name": "media",
              "value": [
                {
                  "url": "={{$json.event_image}}",
                  "type": "image"
                }
              ]
            },
            {
              "name": "platforms",
              "value": ["instagram", "facebook", "twitter", "linkedin"]
            },
            {
              "name": "schedule_time",
              "value": "={{DateTime.now().plus({hours: 2}).toISO()}}"
            }
          ]
        }
      },
      "name": "Schedule Social Posts",
      "type": "n8n-nodes-base.httpRequest"
    }
  ]
}
```

## 🌐 Flowise Visual AI Workflows

### **Conversational AI Flows**

#### 1. Event Discovery Chatflow
```json
{
  "chatflow": {
    "id": "event_discovery_assistant",
    "name": "Event Discovery Assistant - Medellín",
    "nodes": [
      {
        "id": "chatOpenAI_1",
        "position": {"x": 300, "y": 100},
        "type": "chatOpenAI",
        "data": {
          "model": "gpt-4",
          "temperature": 0.3,
          "maxTokens": 1500,
          "systemMessagePrompt": "Eres un asistente experto en eventos de Medellín, Colombia. Ayudas a los usuarios a descubrir eventos perfectos basados en sus preferencias, presupuesto y disponibilidad. Siempre respondes en el idioma del usuario (español o inglés) y proporcionas recomendaciones personalizadas y precisas."
        }
      },
      {
        "id": "pineconeStore_1",
        "position": {"x": 600, "y": 200},
        "type": "pineconeStore",
        "data": {
          "indexName": "medellin-events",
          "textKey": "description",
          "metadataKeys": ["category", "price_range", "date", "venue"],
          "topK": 8,
          "filter": {
            "status": "active",
            "city": "medellin"
          }
        }
      },
      {
        "id": "supabaseRetriever_1",
        "position": {"x": 600, "y": 350},
        "type": "supabaseRetriever",
        "data": {
          "tableName": "events",
          "queryColumns": ["name", "description", "category", "price", "date"],
          "filter": "status = 'active' AND city = 'Medellín'"
        }
      },
      {
        "id": "conversationChain_1",
        "position": {"x": 900, "y": 250},
        "type": "conversationChain",
        "data": {
          "memory": "bufferWindowMemory",
          "sessionId": "user_{{userId}}",
          "k": 15,
          "returnMessages": true
        }
      }
    ],
    "edges": [
      {
        "source": "chatOpenAI_1",
        "target": "pineconeStore_1"
      },
      {
        "source": "chatOpenAI_1", 
        "target": "supabaseRetriever_1"
      },
      {
        "source": "pineconeStore_1",
        "target": "conversationChain_1"
      },
      {
        "source": "supabaseRetriever_1",
        "target": "conversationChain_1"
      }
    ]
  }
}
```

#### 2. Sponsor Qualification Chatflow
```json
{
  "chatflow": {
    "id": "sponsor_qualification_assistant",
    "name": "AI Sponsor Qualification Assistant",
    "nodes": [
      {
        "id": "chatOpenAI_2",
        "position": {"x": 300, "y": 100},
        "type": "chatOpenAI",
        "data": {
          "model": "gpt-4",
          "temperature": 0.2,
          "systemMessagePrompt": "Eres un especialista en partnerships y patrocinios para eventos en Colombia. Tu objetivo es calificar leads de patrocinadores, entender sus objetivos de marketing, presupuesto, y audiencia objetivo para hacer match perfecto con eventos relevantes."
        }
      },
      {
        "id": "httpRequestTool_1",
        "position": {"x": 500, "y": 200},
        "type": "httpRequestTool",
        "data": {
          "name": "get_company_info",
          "description": "Get company information from CRM",
          "url": "{{supabaseUrl}}/rest/v1/companies?name=eq.{{company_name}}",
          "method": "GET"
        }
      },
      {
        "id": "calculator_1",
        "position": {"x": 500, "y": 300},
        "type": "calculator",
        "data": {
          "name": "roi_calculator",
          "description": "Calculate potential ROI for sponsorship packages"
        }
      },
      {
        "id": "customFunction_1",
        "position": {"x": 700, "y": 250},
        "type": "customFunction",
        "data": {
          "name": "qualify_sponsor",
          "functionName": "qualifySponsorLead",
          "javascript": `
            function qualifySponsorLead(input) {
              const { budget, industry, audienceSize, eventMatch } = input;
              
              let score = 0;
              
              // Budget qualification
              if (budget >= 5000000) score += 30; // 5M+ COP
              else if (budget >= 2000000) score += 20;
              else if (budget >= 1000000) score += 10;
              
              // Industry alignment
              if (eventMatch.industry_alignment > 80) score += 25;
              else if (eventMatch.industry_alignment > 60) score += 15;
              
              // Audience size and engagement
              if (audienceSize >= 10000) score += 20;
              else if (audienceSize >= 5000) score += 15;
              else if (audienceSize >= 1000) score += 10;
              
              // Strategic fit
              if (eventMatch.strategic_fit > 70) score += 25;
              
              return {
                qualification_score: score,
                tier: score >= 80 ? 'A' : score >= 60 ? 'B' : score >= 40 ? 'C' : 'D',
                recommended_package: score >= 80 ? 'Premium' : score >= 60 ? 'Standard' : 'Basic',
                next_steps: score >= 60 ? 'Schedule meeting' : 'Nurture lead'
              };
            }
          `
        }
      }
    ]
  }
}
```

## 🎯 AI-Powered Features Implementation

### **Dynamic Pricing Engine**
```python
class DynamicPricingAgent:
    """AI-powered dynamic pricing for events and experiences"""
    
    def __init__(self):
        self.pricing_model = self.load_pricing_model()
        self.market_analyzer = MarketAnalysisAgent()
        
    async def calculate_optimal_price(self, event_id, current_date):
        """Calculate optimal pricing using AI models"""
        
        # Multi-factor analysis
        factors = {
            "demand_signals": await self.analyze_demand_signals(event_id),
            "competitor_pricing": await self.analyze_competitor_pricing(event_id),
            "market_conditions": await self.market_analyzer.get_market_conditions(),
            "historical_performance": await self.get_historical_data(event_id),
            "external_factors": await self.get_external_factors(current_date)
        }
        
        # AI pricing optimization
        optimal_price = await self.pricing_model.predict({
            "base_price": factors["historical_performance"]["avg_price"],
            "demand_score": factors["demand_signals"]["score"],
            "competition_factor": factors["competitor_pricing"]["factor"],
            "market_sentiment": factors["market_conditions"]["sentiment"],
            "days_until_event": factors["external_factors"]["days_until_event"],
            "seasonality_factor": factors["external_factors"]["seasonality"]
        })
        
        return {
            "recommended_price": optimal_price,
            "confidence_level": self.calculate_confidence(factors),
            "price_range": {
                "min": optimal_price * 0.85,
                "max": optimal_price * 1.15
            },
            "factors_analysis": factors
        }
```

### **Real-time Recommendation Engine**
```python
class PersonalizationEngine:
    """Advanced AI personalization using user behavior and preferences"""
    
    def __init__(self):
        self.pinecone_index = PineconeIndex("user-preferences")
        self.behavior_analyzer = UserBehaviorAnalyzer()
        
    async def get_personalized_recommendations(self, user_id, context=None):
        """Generate personalized recommendations using AI"""
        
        # User profile enrichment
        user_vector = await self.create_user_vector(user_id)
        contextual_factors = await self.analyze_context(context)
        
        # Hybrid recommendation approach
        recommendations = []
        
        # 1. Collaborative filtering
        collaborative_recs = await self.collaborative_filtering(user_vector)
        
        # 2. Content-based filtering
        content_recs = await self.content_based_filtering(user_id)
        
        # 3. Contextual recommendations
        contextual_recs = await self.contextual_recommendations(
            user_id, contextual_factors
        )
        
        # 4. AI-powered ranking and fusion
        final_recommendations = await self.rank_and_fuse_recommendations(
            [collaborative_recs, content_recs, contextual_recs],
            user_vector,
            contextual_factors
        )
        
        return {
            "recommendations": final_recommendations,
            "explanation": self.generate_explanation(final_recommendations),
            "confidence_scores": self.calculate_confidence_scores(final_recommendations)
        }
```