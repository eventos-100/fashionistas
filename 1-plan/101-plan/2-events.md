# Event Planning AI Automation System - Implementation Guide

## Document 2: Implementation Guide & Technical Setup

### Installation & Environment Setup

#### Prerequisites
```bash
# System Requirements
- Python 3.9+ 
- Node.js 18+
- Docker & Docker Compose
- PostgreSQL 14+
- Redis 6+
- Git
```

#### Project Initialization
```bash
# Create and activate virtual environment
conda create --name event-ai-system python=3.11
conda activate event-ai-system

# Install CrewAI and dependencies
pip install crewai[tools]
pip install fastapi uvicorn
pip install langchain openai anthropic
pip install sqlalchemy psycopg2-binary
pip install celery redis
pip install python-multipart aiofiles

# Initialize project structure using CrewAI CLI
crewai create event_planning_system
cd event_planning_system

# Install additional dependencies
pip install -r requirements.txt
```

#### Environment Configuration
```bash
# .env file configuration
OPENAI_API_KEY=your_openai_key
ANTHROPIC_API_KEY=your_anthropic_key
DATABASE_URL=postgresql://user:password@localhost:5432/event_planning
REDIS_URL=redis://localhost:6379
WEBHOOK_SECRET=your_webhook_secret

# API Keys for integrations
GOOGLE_MAPS_API_KEY=your_google_maps_key
STRIPE_API_KEY=your_stripe_key
SLACK_BOT_TOKEN=your_slack_token
SALESFORCE_API_KEY=your_salesforce_key
```

### Core System Implementation

#### 1. Agent Framework Setup

**Main Crew Configuration** (`src/event_planning_system/crew.py`):
```python
from crewai import Crew, Agent, Task
from crewai.process import Process
from typing import Dict, List
import yaml
from pathlib import Path

class EventPlanningCrew:
    def __init__(self):
        self.agents_config = self._load_config('agents.yaml')
        self.tasks_config = self._load_config('tasks.yaml')
        
    def _load_config(self, filename: str) -> Dict:
        config_path = Path(__file__).parent / 'config' / filename
        with open(config_path, 'r') as file:
            return yaml.safe_load(file)
    
    @agent
    def venue_intelligence_agent(self) -> Agent:
        return Agent(
            config=self.agents_config['venue_intelligence_agent'],
            tools=[
                VenueSearchTool(),
                GoogleMapsTools(),
                PriceComparisonTool(),
                AvailabilityChecker()
            ],
            verbose=True,
            memory=True
        )
    
    @agent 
    def logistics_optimization_agent(self) -> Agent:
        return Agent(
            config=self.agents_config['logistics_optimization_agent'],
            tools=[
                ProjectManagementTool(),
                VendorDatabaseTool(),
                ResourceAllocationTool(),
                TimelineOptimizer()
            ],
            verbose=True,
            memory=True
        )
    
    @agent
    def marketing_strategy_agent(self) -> Agent:
        return Agent(
            config=self.agents_config['marketing_strategy_agent'],
            tools=[
                SocialMediaTool(),
                EmailMarketingTool(),
                AnalyticsTool(),
                ContentGenerationTool()
            ],
            verbose=True,
            memory=True
        )
    
    @agent
    def risk_assessment_agent(self) -> Agent:
        return Agent(
            config=self.agents_config['risk_assessment_agent'],
            tools=[
                WeatherAPITool(),
                SafetyRegulationTool(),
                InsuranceCalculatorTool(),
                EmergencyProtocolTool()
            ],
            verbose=True,
            memory=True
        )
    
    @agent
    def financial_controller_agent(self) -> Agent:
        return Agent(
            config=self.agents_config['financial_controller_agent'],
            tools=[
                BudgetTrackingTool(),
                PaymentProcessingTool(),
                ROICalculatorTool(),
                ExpenseCategorizerTool()
            ],
            verbose=True,
            memory=True
        )
    
    @agent
    def content_creation_agent(self) -> Agent:
        return Agent(
            config=self.agents_config['content_creation_agent'],
            tools=[
                ContentGeneratorTool(),
                DesignCoordinationTool(),
                TranslationTool(),
                TemplateManagerTool()
            ],
            verbose=True,
            memory=True
        )
    
    @task
    def venue_research_task(self) -> Task:
        return Task(
            config=self.tasks_config['venue_research_task'],
            agent=self.venue_intelligence_agent()
        )
    
    @task
    def logistics_coordination_task(self) -> Task:
        return Task(
            config=self.tasks_config['logistics_coordination_task'],
            agent=self.logistics_optimization_agent(),
            context=[self.venue_research_task()]
        )
    
    @task
    def marketing_campaign_task(self) -> Task:
        return Task(
            config=self.tasks_config['marketing_campaign_task'],
            agent=self.marketing_strategy_agent(),
            context=[self.venue_research_task()]
        )
    
    @task
    def risk_assessment_task(self) -> Task:
        return Task(
            config=self.tasks_config['risk_assessment_task'],
            agent=self.risk_assessment_agent(),
            context=[self.venue_research_task(), self.logistics_coordination_task()]
        )
    
    @task
    def financial_management_task(self) -> Task:
        return Task(
            config=self.tasks_config['financial_management_task'],
            agent=self.financial_controller_agent(),
            context=[self.venue_research_task(), self.logistics_coordination_task()]
        )
    
    @task
    def content_creation_task(self) -> Task:
        return Task(
            config=self.tasks_config['content_creation_task'],
            agent=self.content_creation_agent(),
            context=[self.marketing_campaign_task()]
        )
    
    @crew
    def crew(self) -> Crew:
        return Crew(
            agents=self.agents,
            tasks=self.tasks,
            process=Process.hierarchical,
            verbose=2,
            memory=True,
            manager_llm="gpt-4"
        )
```

#### 2. Custom Tool Implementation

**Venue Search Tool** (`src/tools/venue_tools.py`):
```python
from crewai_tools import BaseTool
import requests
from typing import Dict, List
import json

class VenueSearchTool(BaseTool):
    name: str = "Venue Search Tool"
    description: str = "Search for venues based on location, capacity, and requirements"
    
    def _run(self, location: str, capacity: int, event_type: str, budget_range: str) -> str:
        """Search for venues matching the specified criteria."""
        
        search_params = {
            "location": location,
            "capacity": capacity,
            "event_type": event_type,
            "budget_range": budget_range
        }
        
        # Multiple venue database searches
        venues = []
        
        # Search venue databases
        venues.extend(self._search_cvent_venues(search_params))
        venues.extend(self._search_eventup_venues(search_params))
        venues.extend(self._search_google_venues(search_params))
        
        # Rank venues by scoring algorithm
        ranked_venues = self._rank_venues(venues, search_params)
        
        return json.dumps(ranked_venues, indent=2)
    
    def _search_cvent_venues(self, params: Dict) -> List[Dict]:
        # Implementation for Cvent API integration
        pass
    
    def _search_eventup_venues(self, params: Dict) -> List[Dict]:
        # Implementation for EventUp API integration
        pass
    
    def _search_google_venues(self, params: Dict) -> List[Dict]:
        # Implementation for Google Places API integration
        pass
    
    def _rank_venues(self, venues: List[Dict], params: Dict) -> List[Dict]:
        """Rank venues using weighted scoring algorithm."""
        scoring_weights = {
            "location_score": 0.25,
            "capacity_match": 0.20,
            "amenities_score": 0.20,
            "price_score": 0.20,
            "availability_score": 0.15
        }
        
        for venue in venues:
            venue["total_score"] = sum(
                venue.get(metric, 0) * weight 
                for metric, weight in scoring_weights.items()
            )
        
        return sorted(venues, key=lambda x: x["total_score"], reverse=True)
```

**Project Management Integration Tool** (`src/tools/project_tools.py`):
```python
from crewai_tools import BaseTool
import requests
from datetime import datetime, timedelta

class ProjectManagementTool(BaseTool):
    name: str = "Project Management Tool"
    description: str = "Create and manage project timelines and tasks"
    
    def _run(self, event_details: str, timeline_weeks: int) -> str:
        """Create project management structure for event planning."""
        
        # Parse event details
        event_data = self._parse_event_details(event_details)
        
        # Generate timeline
        timeline = self._generate_timeline(event_data, timeline_weeks)
        
        # Create project structure
        project_structure = self._create_project_structure(event_data, timeline)
        
        # Integrate with project management platforms
        self._sync_with_monday(project_structure)
        self._sync_with_asana(project_structure)
        
        return json.dumps(project_structure, indent=2)
    
    def _generate_timeline(self, event_data: Dict, weeks: int) -> Dict:
        """Generate detailed project timeline with milestones."""
        event_date = datetime.strptime(event_data["date"], "%Y-%m-%d")
        start_date = event_date - timedelta(weeks=weeks)
        
        timeline = {
            "phases": [
                {
                    "name": "Pre-Planning",
                    "start": start_date,
                    "duration_weeks": weeks // 3,
                    "tasks": [
                        "Event concept development",
                        "Budget framework creation",
                        "Venue research and selection",
                        "Initial vendor outreach"
                    ]
                },
                {
                    "name": "Planning & Design", 
                    "start": start_date + timedelta(weeks=weeks//3),
                    "duration_weeks": weeks // 3,
                    "tasks": [
                        "Logistics coordination",
                        "Marketing campaign development",
                        "Vendor contract finalization",
                        "Registration system setup"
                    ]
                },
                {
                    "name": "Execution Preparation",
                    "start": start_date + timedelta(weeks=2*weeks//3),
                    "duration_weeks": weeks // 3,
                    "tasks": [
                        "Final vendor confirmations",
                        "Staff briefings",
                        "Emergency planning",
                        "Technical rehearsals"
                    ]
                }
            ]
        }
        
        return timeline
```

#### 3. Database Schema Implementation

**Database Models** (`src/models/database.py`):
```python
from sqlalchemy import Column, Integer, String, DateTime, Text, Float, Boolean, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from datetime import datetime

Base = declarative_base()

class Event(Base):
    __tablename__ = "events"
    
    id = Column(Integer, primary_key=True)
    name = Column(String(255), nullable=False)
    description = Column(Text)
    event_type = Column(String(100))
    event_date = Column(DateTime)
    location = Column(String(255))
    expected_attendees = Column(Integer)
    budget = Column(Float)
    status = Column(String(50), default="planning")
    created_at = Column(DateTime, default=datetime.utcnow)
    
    # Relationships
    venues = relationship("Venue", back_populates="event")
    tasks = relationship("Task", back_populates="event")
    expenses = relationship("Expense", back_populates="event")

class Venue(Base):
    __tablename__ = "venues"
    
    id = Column(Integer, primary_key=True)
    event_id = Column(Integer, ForeignKey("events.id"))
    name = Column(String(255))
    address = Column(Text)
    capacity = Column(Integer)
    price_per_person = Column(Float)
    amenities = Column(Text)  # JSON string
    rating = Column(Float)
    availability_status = Column(String(50))
    
    event = relationship("Event", back_populates="venues")

class Task(Base):
    __tablename__ = "tasks"
    
    id = Column(Integer, primary_key=True)
    event_id = Column(Integer, ForeignKey("events.id"))
    agent_type = Column(String(100))
    title = Column(String(255))
    description = Column(Text)
    status = Column(String(50), default="pending")
    priority = Column(String(20))
    due_date = Column(DateTime)
    assigned_to = Column(String(100))
    
    event = relationship("Event", back_populates="tasks")

class Expense(Base):
    __tablename__ = "expenses"
    
    id = Column(Integer, primary_key=True)
    event_id = Column(Integer, ForeignKey("events.id"))
    category = Column(String(100))
    description = Column(String(255))
    amount = Column(Float)
    vendor = Column(String(255))
    status = Column(String(50))
    date_incurred = Column(DateTime, default=datetime.utcnow)
    
    event = relationship("Event", back_populates="expenses")
```

#### 4. API Endpoints Implementation

**FastAPI Application** (`src/api/main.py`):
```python
from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel
from sqlalchemy.orm import Session
from typing import List, Dict
import asyncio

from .database import get_db
from .models import Event, Venue, Task
from ..crew import EventPlanningCrew

app = FastAPI(title="Event Planning AI System", version="1.0.0")

class EventCreateRequest(BaseModel):
    name: str
    description: str
    event_type: str
    event_date: str
    location: str
    expected_attendees: int
    budget: float

class EventResponse(BaseModel):
    id: int
    name: str
    status: str
    progress: Dict
    recommendations: List[Dict]

@app.post("/events/", response_model=EventResponse)
async def create_event(
    event_request: EventCreateRequest, 
    db: Session = Depends(get_db)
):
    """Create new event and initiate AI planning process."""
    
    # Create event record
    event = Event(**event_request.dict())
    db.add(event)
    db.commit()
    db.refresh(event)
    
    # Initialize AI crew
    crew = EventPlanningCrew()
    
    # Start asynchronous planning process
    planning_task = asyncio.create_task(
        run_ai_planning(crew, event_request.dict())
    )
    
    return EventResponse(
        id=event.id,
        name=event.name,
        status="initiated",
        progress={"venue_search": "started"},
        recommendations=[]
    )

@app.get("/events/{event_id}/progress")
async def get_event_progress(event_id: int, db: Session = Depends(get_db)):
    """Get real-time progress of AI planning process."""
    
    event = db.query(Event).filter(Event.id == event_id).first()
    if not event:
        raise HTTPException(status_code=404, detail="Event not found")
    
    # Get latest task statuses
    tasks = db.query(Task).filter(Task.event_id == event_id).all()
    
    progress = {
        "venue_research": _get_task_progress(tasks, "venue_intelligence"),
        "logistics": _get_task_progress(tasks, "logistics_optimization"), 
        "marketing": _get_task_progress(tasks, "marketing_strategy"),
        "risk_assessment": _get_task_progress(tasks, "risk_assessment"),
        "financial": _get_task_progress(tasks, "financial_controller"),
        "content": _get_task_progress(tasks, "content_creation")
    }
    
    return {"event_id": event_id, "progress": progress}

@app.get("/events/{event_id}/recommendations")
async def get_recommendations(event_id: int, db: Session = Depends(get_db)):
    """Get AI-generated recommendations for the event."""
    
    venues = db.query(Venue).filter(Venue.event_id == event_id).all()
    
    recommendations = {
        "venues": [
            {
                "name": venue.name,
                "address": venue.address,
                "capacity": venue.capacity,
                "price": venue.price_per_person,
                "rating": venue.rating
            }
            for venue in venues
        ]
    }
    
    return recommendations

async def run_ai_planning(crew: EventPlanningCrew, event_data: Dict):
    """Execute AI planning workflow."""
    
    try:
        # Run the crew workflow
        result = crew.crew().kickoff(inputs=event_data)
        
        # Process and store results
        await process_planning_results(result, event_data)
        
    except Exception as e:
        print(f"Error in AI planning: {e}")
        # Handle error and update event status

def _get_task_progress(tasks: List[Task], agent_type: str) -> str:
    """Get progress status for specific agent tasks."""
    agent_tasks = [task for task in tasks if task.agent_type == agent_type]
    
    if not agent_tasks:
        return "not_started"
    
    completed = sum(1 for task in agent_tasks if task.status == "completed")
    total = len(agent_tasks)
    
    if completed == total:
        return "completed"
    elif completed > 0:
        return "in_progress"
    else:
        return "started"
```

#### 5. Real-time Communication Setup

**WebSocket Implementation** (`src/api/websockets.py`):
```python
from fastapi import WebSocket, WebSocketDisconnect
from typing import List, Dict
import json
import asyncio

class ConnectionManager:
    def __init__(self):
        self.active_connections: List[WebSocket] = []
        self.event_subscribers: Dict[int, List[WebSocket]] = {}
    
    async def connect(self, websocket: WebSocket, event_id: int):
        await websocket.accept()
        self.active_connections.append(websocket)
        
        if event_id not in self.event_subscribers:
            self.event_subscribers[event_id] = []
        self.event_subscribers[event_id].append(websocket)
    
    def disconnect(self, websocket: WebSocket, event_id: int):
        self.active_connections.remove(websocket)
        if event_id in self.event_subscribers:
            self.event_subscribers[event_id].remove(websocket)
    
    async def broadcast_event_update(self, event_id: int, message: Dict):
        if event_id in self.event_subscribers:
            for connection in self.event_subscribers[event_id]:
                await connection.send_text(json.dumps(message))

manager = ConnectionManager()

@app.websocket("/ws/events/{event_id}")
async def websocket_endpoint(websocket: WebSocket, event_id: int):
    await manager.connect(websocket, event_id)
    try:
        while True:
            data = await websocket.receive_text()
            # Handle incoming messages if needed
    except WebSocketDisconnect:
        manager.disconnect(websocket, event_id)
```

#### 6. Deployment Configuration

**Docker Configuration** (`docker-compose.yml`):
```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=postgresql://postgres:password@db:5432/event_planning
      - REDIS_URL=redis://redis:6379
    depends_on:
      - db
      - redis
    volumes:
      - ./src:/app/src

  db:
    image: postgres:14
    environment:
      POSTGRES_DB: event_planning
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  redis:
    image: redis:6-alpine
    ports:
      - "6379:6379"

  celery:
    build: .
    command: celery -A src.tasks worker --loglevel=info
    environment:
      - DATABASE_URL=postgresql://postgres:password@db:5432/event_planning
      - REDIS_URL=redis://redis:6379
    depends_on:
      - db
      - redis

volumes:
  postgres_data:
```

**Dockerfile**:
```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD ["uvicorn", "src.api.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

### Testing & Quality Assurance

#### Unit Testing Setup
```python
# tests/test_agents.py
import pytest
from src.crew import EventPlanningCrew

@pytest.fixture
def event_crew():
    return EventPlanningCrew()

def test_venue_agent_initialization(event_crew):
    agent = event_crew.venue_intelligence_agent()
    assert agent.role == "Venue Research & Selection Specialist"
    assert len(agent.tools) > 0

def test_venue_search_integration():
    # Test venue search functionality
    pass

# Integration tests
def test_full_planning_workflow():
    # Test complete agent workflow
    pass
```

#### Performance Monitoring
```python
# src/monitoring/metrics.py
from prometheus_client import Counter, Histogram, Gauge
import time

# Metrics
REQUEST_COUNT = Counter('requests_total', 'Total requests', ['method', 'endpoint'])
REQUEST_DURATION = Histogram('request_duration_seconds', 'Request duration')
AGENT_TASKS = Gauge('agent_tasks_active', 'Active agent tasks', ['agent_type'])

def monitor_agent_performance(agent_type: str, task_duration: float):
    """Monitor individual agent performance."""
    AGENT_TASKS.labels(agent_type=agent_type).inc()
    # Log performance metrics
```

This implementation guide provides the complete technical foundation for deploying the event planning AI automation system with scalability, monitoring, and real-time capabilities.
