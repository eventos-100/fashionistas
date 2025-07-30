Python Code for Event Planning with AI Agents using CrewAI
Diptendu Das
Diptendu Das

Follow
6 min read
·
May 15, 2025





Event planning is a complex endeavor with numerous moving parts. From finding the perfect venue to managing logistics and promoting the event, each step requires meticulous attention to detail and coordination. What if you could automate significant portions of this process using a team of AI agents? Enter CrewAI, a powerful framework for orchestrating role-playing, autonomous AI agents.

Non members can read this for free — https://diptendud.medium.com/python-event-planning-with-ai-agents-using-crewai-3d2202b77ee4?sk=97adc7818a04ddde71f7386696521b23


AI Generated
This blog post will guide you through automating event planning using CrewAI, based on a practical example. We’ll explore how to define specialized AI agents and assign them tasks to collaboratively plan an event, making your life easier and your events more successful.

The Core Idea: A Crew for Your Event

CrewAI allows you to create a “crew” of AI agents, each with a specific role, goal, and set of tools. These agents can work together, delegate tasks, and share information to achieve a common objective. For our event planning scenario, we’ll design a crew to handle venue selection, logistics, and marketing.

Setting the Stage: Imports and API Keys

Before diving into creating agents, you’ll need to import the necessary components from CrewAI and other libraries. The example uses gpt-3.5-turbo (though you can use more advanced models like gpt-4-turbo locally).

import warnings
warnings.filterwarnings('ignore')
from crewai import Agent, Crew, Task
import os
from utils import get_openai_api_key, get_serper_api_key # Assuming utils.py handles API key retrieval
# Set API Keys
openai_api_key = get_openai_api_key()
os.environ["OPENAI_MODEL_NAME"] = 'gpt-3.5-turbo'
# For web search capabilities, CrewAI can use tools like SerperDevTool
os.environ["SERPER_API_KEY"] = get_serper_api_key()
from crewai_tools import ScrapeWebsiteTool, SerperDevTool
# Initialize the tools
search_tool = SerperDevTool()
scrape_tool = ScrapeWebsiteTool()
Meet the Event Planning Crew: Defining Your Agents

We’ll create three distinct AI agents, each tailored for a specific aspect of event planning.

The Venue Coordinator: This agent’s mission is to find and secure the ideal venue.
The Logistics Manager: This agent takes charge of all operational aspects, including catering and equipment.
The Marketing and Communications Agent: This agent focuses on promoting the event and engaging with potential attendees.
Here’s how they are defined in code:

Agent 1: Venue Coordinator
venue_coordinator = Agent(
    role="Venue Coordinator",
    goal="Identify and book an appropriate venue "
         "based on event requirements",
    tools=[search_tool, scrape_tool], # Can search the web and scrape website content
    verbose=True, # Provides detailed logs of the agent's actions
    backstory=(
        "With a keen sense of space and "
        "understanding of event logistics, "
        "you excel at finding and securing "
        "the perfect venue that fits the event's theme, "
        "size, and budget constraints."
    )
)
The role defines the agent's function. The goal specifies its primary objective. tools are the capabilities it can use (here, web searching and scraping). The backstory adds personality and context, which can help the LLM generate more in-character and effective responses. verbose=True is highly recommended during development to see the agent's thought process.
Agent 2: Logistics Manager
logistics_manager = Agent(
    role='Logistics Manager',
    goal=(
        "Manage all logistics for the event "
        "including catering and equipment"
    ),
    tools=[search_tool, scrape_tool],
    verbose=True,
    backstory=(
        "Organized and detail-oriented, "
        "you ensure that every logistical aspect of the event "
        "from catering to equipment setup "
        "is flawlessly executed to create a seamless experience."
    )
)
Agent 3: Marketing and Communications Agent
marketing_communications_agent = Agent(
    role="Marketing and Communications Agent",
    goal="Effectively market the event and "
         "communicate with participants",
    tools=[search_tool, scrape_tool],
    verbose=True,
    backstory=(
        "Creative and communicative, "
        "you craft compelling messages and "
        "engage with potential attendees "
        "to maximize event exposure and participation."
    )
)
Structuring Output: Pydantic Models for Clarity

When an agent completes a task, especially one involving data gathering, it’s beneficial to have the output in a structured format. Pydantic models are excellent for this. For our venue search, we can define a model to hold venue details:

from pydantic import BaseModel
class VenueDetails(BaseModel):
    name: str
    address: str
    capacity: int
    booking_status: str # e.g., "Available", "Requires Inquiry", "Booked"
This VenueDetails model ensures that the information retrieved by the Venue Coordinator will always contain a name, address, capacity, and booking status, all in the correct data types.

Defining the Work: Creating Tasks for Your Agents

With our agents and desired output structure in place, we can now define the tasks they need to perform.

Task 1: Find Venue (for the Venue Coordinator)
venue_task = Task(
    description="Find a venue in {event_city} "
                "that meets criteria for {event_topic}.",
    expected_output="All the details of a specifically chosen "
                    "venue you found to accommodate the event, "
                    "structured as a JSON object matching the VenueDetails model.",
    human_input=True, # Pauses for human feedback/approval before finalizing
    output_json=VenueDetails, # Specifies the Pydantic model for the output
    output_file="venue_details.json",  # Saves the output to a JSON file
    agent=venue_coordinator # Assigns this task to the Venue Coordinator
)
Let’s break down the key parameters:
description: A clear instruction for the agent. Notice the use of placeholders like {event_city} and {event_topic}. These will be filled in when the crew is run with specific inputs.
expected_output: Describes what a successful task completion looks like.
human_input=True: This is a powerful feature. When set to True, the task execution will pause at a certain point, allowing a human to review the agent's findings or provide additional input before the agent finalizes its response. This is invaluable for critical decisions like venue selection.
output_json=VenueDetails: Instructs the agent to format its output according to the VenueDetails Pydantic model. CrewAI will guide the LLM to produce a JSON object that conforms to this schema.
output_file="venue_details.json": This handy parameter tells CrewAI to save the resulting JSON output from this task into a file named venue_details.json.
agent: Specifies which agent is responsible for this task.
Task 2: Coordinate Logistics (for the Logistics Manager)
logistics_task = Task(
    description="Coordinate catering and "
                 "equipment for an event "
                 "with {expected_participants} participants "
                 "on {tentative_date}.",
    expected_output="Confirmation of all logistics arrangements "
                    "including catering and equipment setup. "
                    "Include vendor names, contact details, and confirmed services.",
    human_input=True, # Allows for human oversight on logistics plans
    async_execution=True, # This task can potentially run in parallel
    agent=logistics_manager
)
Key new parameter here:
async_execution=True: Setting this to True allows this task to be executed asynchronously. If you have multiple tasks in your crew that can run independently without waiting for each other, async_execution can speed up the overall workflow by enabling parallel processing. The crew doesn't necessarily have to wait for this task to fully complete before potentially starting other independent tasks.
Task 3: Promote Event (for the Marketing and Communications Agent)

marketing_task = Task(
    description="Promote the {event_topic} "
                "aiming to engage at least "
                "{expected_participants} potential attendees. "
                "Develop a brief marketing plan including key messages and channels.",
    expected_output="Report on marketing activities, "
                    "key messages, chosen channels, and initial attendee engagement metrics (if any).",
    agent=marketing_communications_agent
)
This task focuses on the promotional aspects, and the agent will use its creative and communicative abilities (as defined in its backstory) to generate a marketing plan and engagement report.
Bringing It All Together: The Crew (Conceptual)

While the provided snippet focuses on defining agents and tasks, the next step in a CrewAI workflow is to assemble them into a Crew.

Python

# Conceptual example of how the Crew would be formed:
# from crewai import Crew, Process
# event_planning_crew = Crew(
#     agents=[venue_coordinator, logistics_manager, marketing_communications_agent],
#     tasks=[venue_task, logistics_task, marketing_task],
#     process=Process.sequential, # Or Process.hierarchical
#     verbose=2
# )
# And then you would kick off the crew with specific inputs:
# event_details = {
#     'event_topic': "AI in Sustainable Agriculture",
#     'event_city': "San Francisco",
#     'expected_participants': 150,
#     'tentative_date': "2025-10-15"
# }
# result = event_planning_crew.kickoff(inputs=event_details)
# print(result)
The Crew class orchestrates the agents and tasks. You can define the process as sequential (tasks run one after another, with output from one potentially feeding into the next) or hierarchical (a more complex manager-worker structure).

When kickoff(inputs=event_details) is called, the placeholders in your task descriptions (e.g., {event_topic}, {event_city}) are populated with the values from the event_details dictionary.

Why Automate Event Planning with CrewAI?

Efficiency: Agents can perform research, draft communications, and outline plans much faster than humans.
Structured Output: Using Pydantic models (output_json) and output_file ensures data is organized and easily accessible.
Human-in-the-Loop: The human_input feature allows for crucial human oversight and decision-making at key points, blending AI power with human judgment.
Scalability: Easily adjust the complexity of tasks or add more agents as your event planning needs grow.
Consistency: Agents follow their instructions and backstories, leading to more consistent outputs.
Parallel Processing: async_execution can significantly reduce the total time taken for tasks that can run concurrently.
This will transform event planning from a manual, time-consuming chore into a streamlined, AI-assisted operation. The example above is a starting point; you can customize agents, tools, and tasks to fit an even wider array of complex projects. Happy automating!