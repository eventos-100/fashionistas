.## Title and Purpose

**Title:** CopilotKit Blueprint Series for "I Love Medellín" AI-Powered Platform

**Purpose:** These documents form the foundational and phased technical strategy for implementing the CopilotKit AI assistant in the "I Love Medellín" platform. They guide developers in setting up AI-enhanced workflows for tourism, real estate, events, and restaurants using tools like Supabase, Pinecone, LangChain, and Stripe.


---

### Phase 4: Advanced Technical Integration Research

This phase outlines the specific integration patterns and architectural considerations for incorporating CopilotKit with LangChain, LangGraph, Webflow, WhatsApp, and Stripe Connect to power the "I Love Medellín" platform.

**4.1 LangChain Integration Patterns with CopilotKit**

LangChain will serve as the primary engine for conversational AI logic, tool usage, and complex reasoning within the CopilotKit backend.

* **Agent Architecture with CopilotKit Context Awareness:**
    * **Pattern:** Implement LangChain agents (e.g., ReAct, OpenAI Functions Agent, or custom agents) within your `CopilotBackend` service. The application context gathered by CopilotKit's frontend components (e.g., current page, user selections, form data via `useCopilotReadable`) will be passed to these agents as part of the initial input or as context available to tools.
    * **Implementation:**
        * The `CopilotBackend` will receive user queries and application context.
        * This data will initialize a LangChain agent executor.
        * The agent will have access to a set of tools, which are essentially the `CopilotAction`s defined in your application, wrapped for LangChain compatibility.
    * **Example:** A tourist on the "Guatapé Tour" page asks the Copilot, "Are there any discounts for groups?" CopilotKit frontend sends the query and `{ "currentPage": "/tours/guatape", "user_id": "user123" }`. The LangChain agent in the backend receives this, uses a `fetch_tour_details` tool (a `CopilotAction`) that internally knows to check for group discounts for "Guatapé" based on the context.

* **Tool Calling Patterns for Tourism-Specific Functions:**
    * **Pattern:** Define granular, well-documented LangChain tools that map to your platform's core functionalities (the `CopilotAction`s). These tools will interact with Supabase, external APIs (weather, payment), and N8N workflows.
    * **Implementation:**
        * Each `CopilotAction` (e.g., `book_tour`, `find_restaurant_availability`, `calculate_property_roi`) will be exposed as a LangChain `Tool`.
        * Use clear naming and descriptions for tools so the LLM can accurately choose them.
        * Input schemas for tools should be well-defined (e.g., using Pydantic models if using Python for LangChain backend).
    * **Example Tool (Conceptual):**
        ```typescript
        // In your CopilotKit backend actions file
        import { createSupabaseClient } from '@/utils/supabase'; // Your Supabase client
        // ... (other imports)

        export const findAvailableTours = new CopilotAction<{ date: string; interests: string[] }>({
          name: "findAvailableTours",
          description: "Finds available tours based on a specific date and user interests. Returns a list of tour names and IDs.",
          argumentSchema: z.object({ // Using Zod for schema validation
            date: z.string().describe("The desired date for the tour, in YYYY-MM-DD format."),
            interests: z.array(z.string()).describe("A list of user interests, e.g., ['coffee', 'history', 'nature']."),
          }),
          handler: async ({ date, interests }) => {
            const supabase = createSupabaseClient(); // Or get it from context
            // Logic to query Supabase 'experiences' table based on date and interest tags
            const { data, error } = await supabase
              .from('experiences')
              .select('id, name_en, price')
              .eq('is_active', true)
              // ... more filtering logic for date availability and interest matching
              // This is a simplified example; actual availability might be complex
            if (error) throw error;
            return data || [];
          },
        });
        ```
        This `CopilotAction` would then be wrapped and provided to a LangChain agent.

* **Memory Management for Multi-Session User Interactions:**
    * **Pattern:** Utilize LangChain's memory modules (e.g., `ConversationBufferWindowMemory`, `EntityMemory`) to maintain conversation history and key extracted information across multiple interactions within a single session. For multi-session memory, persist relevant summaries or extracted entities to Supabase linked to the `user_id`.
    * **Implementation:**
        * Pass a `memory` object to your LangChain agent.
        * For logged-in users, retrieve a summarized conversation history or key preferences from their Supabase user profile before initializing the agent.
        * After an interaction, update the summary/preferences in Supabase.
    * **Example:** User: "I like quiet coffee shops." (Session 1). Copilot stores "prefers_quiet_coffee_shops" in Supabase. Next day (Session 2), User: "Find me a good café nearby." Copilot's LangChain agent loads this preference and prioritizes quieter cafés in its recommendations.

* **Chain Orchestration for Complex Business Workflows:**
    * **Pattern:** For multi-step processes like a full trip booking or event planning, use LangChain's `SequentialChain` or custom chains. Each step in the chain might involve an LLM call, a tool call, or data transformation.
    * **Implementation:**
        * Define chains where the output of one Link (e.g., identifying user needs) becomes the input for the next Link (e.g., searching for matching services).
        * CopilotKit can initiate such a chain based on a high-level user request.
    * **Example:** User: "Plan a romantic weekend getaway." This could trigger a chain:
        1.  `ClarificationChain`: Asks for dates, budget, preferences.
        2.  `AccommodationSearchChain`: Finds suitable rentals/hotels.
        3.  `ActivitySearchChain`: Finds romantic tours/restaurants.
        4.  `ItineraryCreationChain`: Compiles an itinerary.

* **Error Handling and Fallback Mechanisms:**
    * **Pattern:** Implement robust error handling within LangChain tools and chains. If a tool fails or the LLM can't fulfill a request, provide a graceful fallback response to the user via CopilotKit.
    * **Implementation:**
        * Use `try-catch` blocks within tool handlers.
        * Configure agents with `handle_parsing_errors=true` or custom error handlers.
        * Define fallback responses like, "I'm having trouble with that request right now. Could you try rephrasing, or I can connect you to human support?"
        * Log errors to Supabase for monitoring and debugging.

**4.2 LangGraph Integration Architecture**

LangGraph will be used for more complex, stateful, and potentially cyclical workflows that require more sophisticated control flow than standard LangChain chains.

* **State Management for Multi-Step Booking Processes:**
    * **Architecture:** Define a graph where each node represents a state or a processing step in a booking workflow (e.g., `collect_details`, `check_availability`, `confirm_payment`, `send_confirmation`). The graph's state (e.g., booking details, current step) will be managed by LangGraph and can be persisted in a Supabase table (e.g., `flow_states`) if long-running or resumable flows are needed.
    * **Implementation:**
        * Create a `StatefulGraph` in LangGraph. The state object would contain all relevant information (e.g., `user_id`, `item_id`, `selected_date`, `payment_status`).
        * Nodes would be functions that modify this state or call tools (LangChain tools/CopilotActions).
        * Edges would define transitions based on conditions (e.g., if payment successful, move to `send_confirmation`; if failed, move to `payment_retry`).
    * **Example:** A group tour booking where the Copilot needs to collect preferences from multiple users sequentially, check combined availability, and then proceed to payment.

* **Decision Tree Optimization for Recommendation Engines:**
    * **Architecture:** LangGraph can model complex decision trees for personalized recommendations. Nodes can represent questions to the user (prompted via CopilotKit), data fetching steps (from Supabase/Pinecone), and filtering logic, leading to a final recommendation.
    * **Implementation:**
        * The graph starts with broad user intent.
        * Conditional edges branch based on user responses or data analysis.
        * Example: "Recommend a restaurant." Graph asks: "Any cuisine preference?" -> "Specific neighborhood?" -> "Price range?" -> Fetches options -> "How about [Restaurant X]?"
    * This allows more dynamic and guided recommendation flows than a single LLM prompt.

* **Workflow Automation Integration with N8N:**
    * **Architecture:** LangGraph nodes can trigger N8N workflows via webhooks for tasks that are external to the direct user interaction or involve third-party systems not easily callable as a direct LangChain tool.
    * **Implementation:**
        * A LangGraph node, upon reaching a certain state (e.g., `booking_confirmed`), makes an HTTP request to an N8N webhook.
        * N8N workflow then handles tasks like sending a formatted email via SendGrid, updating a CRM, or notifying a vendor via WhatsApp through a separate channel.
    * **Example:** After a property is booked and payment confirmed (managed by LangGraph states), a node calls an N8N webhook that:
        1.  Sends a confirmation email to the tourist.
        2.  Adds the booking to the host's Google Calendar.
        3.  Notifies the cleaning service.

* **Real-time State Synchronization with Supabase:**
    * **Architecture:** While LangGraph manages the in-memory state of an active flow, key milestones or the complete state can be written to Supabase tables. This allows for persistence, auditing, and potentially resuming flows later. Supabase real-time features can then be used to update the frontend UI based on these state changes if needed.
    * **Implementation:**
        * After each significant state transition in LangGraph, a function updates a corresponding record in a Supabase table (e.g., `active_booking_flows`).
        * The Webflow frontend (or a dashboard) could subscribe to changes in this table to show users the progress of their complex request.

* **Performance Optimization for High-Throughput Scenarios:**
    * **Considerations:**
        * **Asynchronous Operations:** Ensure all I/O-bound operations within LangGraph nodes (API calls, DB queries) are asynchronous to prevent blocking.
        * **Caching:** Cache results of expensive operations or frequently accessed data (e.g., using Supabase Edge Functions with caching or a dedicated Redis instance).
        * **Stateless vs. Stateful Nodes:** Design nodes to be as stateless as possible, relying on the explicitly passed graph state.
        * **Scalability:** Deploy the LangGraph backend (likely a Node.js or Python service) on scalable infrastructure (e.g., serverless functions, container services). Consider Supabase functions for hosting LangGraph endpoints if performance characteristics match.

**4.3 Webflow CMS Integration**

CopilotKit itself won't directly manipulate Webflow's DOM, but its backend actions can trigger updates to Webflow CMS, which in turn updates the live site.

* **Dynamic Content Updates Based on User Interactions (via Backend Logic):**
    * **Pattern:** A Copilot action (e.g., `update_listing_status`) modifies data in Supabase. An N8N workflow (or a Supabase Function) listens for changes in Supabase (using triggers or webhooks) and then uses the Webflow API to update the corresponding CMS item.
    * **Implementation:**
        * User interacts with Copilot (e.g., a host marks a rental as "booked").
        * CopilotAction updates the status in Supabase.
        * Supabase trigger calls an Edge Function (or N8N webhook).
        * The function/workflow identifies the Webflow CMS item ID (which should be stored in Supabase alongside your data) and uses the Webflow API to set its status to "Booked."
    * **Example:** A host uses their admin Copilot: "Mark property ID 123 as unavailable for next week." Copilot action updates Supabase. N8N syncs this to the Webflow CMS item for property 123, removing it from public availability listings for those dates.

* **Real-time Inventory Synchronization:**
    * **Pattern:** Similar to dynamic content updates, but specifically for inventory counts (e.g., tour slots, event tickets, rental availability). Supabase acts as the source of truth, and changes are pushed to Webflow CMS.
    * **Implementation:**
        * When a booking is made via Copilot (or any other channel updating Supabase), decrease `available_slots` in Supabase.
        * A Supabase trigger/N8N workflow updates a "Slots Available" field in the Webflow CMS for that tour/event.
        * Webflow's frontend displays this updated count.
    * **Critical:** Ensure this synchronization is fast and reliable to prevent overbooking. For very high-frequency changes, consider if Webflow CMS is the right place for live inventory display or if a client-side fetch from Supabase on page load is better, with CMS for more static details.

* **Form Handling and Data Collection:**
    * **Pattern:** Webflow forms can submit data to an N8N webhook or a Supabase Edge Function. This data can then be processed, stored in Supabase, and potentially trigger a Copilot-driven follow-up or analysis.
    * **Implementation:**
        * Set Webflow form's action URL to your N8N webhook endpoint.
        * N8N workflow validates data, inserts it into Supabase.
        * Optionally, N8N can trigger a LangChain/LangGraph process via API call to analyze the submission or initiate a Copilot interaction (e.g., "New real estate inquiry received for John Doe, analyze requirements and suggest matching properties").
    * **Example:** A "Contact Us" form on Webflow submits to N8N. N8N saves the inquiry to Supabase and notifies a sales Copilot to follow up.

* **SEO Optimization with AI-Generated Content:**
    * **Pattern:** Use CopilotKit's underlying LangChain capabilities (or a separate admin interface with similar AI) to generate SEO-friendly descriptions for tours, properties, events, and restaurant listings. This content is then stored in Supabase and synced to Webflow CMS.
    * **Implementation:**
        * Admin user provides key details/keywords for a new listing.
        * An AI action (available via an internal Copilot or script) generates a draft description, title tag, and meta description.
        * Admin reviews and approves; content is saved to Supabase and pushed to Webflow.
    * **Focus:** Ensure AI content is high-quality, unique, and human-reviewed for SEO best practices.

* **Mobile Responsiveness and Performance Optimization:**
    * **Webflow's Responsibility:** Webflow itself is responsible for rendering responsive pages.
    * **CopilotKit's Role:** Ensure CopilotKit's chat interface components are lightweight and mobile-friendly.
    * **Content Impact:** Images and dynamic content pulled from Webflow CMS (which might be AI-generated or frequently updated) should be optimized (e.g., compressed images, lazy loading) to not degrade Webflow's performance.

**4.4 WhatsApp Business API Integration**

Integrate CopilotKit's conversational AI with WhatsApp for broader reach and convenient communication. This will typically involve an intermediary service.

* **Conversational Booking Flows:**
    * **Pattern:** User messages the "I Love Medellín" WhatsApp number. An intermediary service (e.g., Twilio API for WhatsApp, or a custom app using WhatsApp Business API, potentially orchestrated by N8N) forwards this message to your `CopilotBackend`. The backend processes it using LangChain/LangGraph and sends a response back through the intermediary to WhatsApp.
    * **Implementation:**
        1.  User: "Book a coffee tour for 2 people next Tuesday."
        2.  WhatsApp -> Intermediary Service -> Your CopilotBackend API Endpoint.
        3.  CopilotBackend (LangChain): Parses request, checks availability (tool call to Supabase), confirms price.
        4.  CopilotBackend -> Intermediary Service -> WhatsApp: "Okay, I have the 'Artisan Coffee Experience' for 2 next Tuesday at 10 AM for $50. Shall I confirm?"
    * **Key:** Manage conversation state across WhatsApp messages, likely using the user's phone number as a session key and LangChain memory.

* **Multi-language Message Templates:**
    * **Pattern:** Use WhatsApp's pre-approved Highly Structured Messages (HSM) templates for outbound notifications (booking confirmations, reminders, updates) in both Spanish and English.
    * **Implementation:**
        * Define templates in WhatsApp Business Manager for various scenarios.
        * Your backend (triggered by Copilot actions or N8N workflows) calls the WhatsApp API with the template name and placeholder values.
        * The user's preferred language (stored in Supabase) determines which template version is sent.
    * **Example:** Booking confirmed for a Spanish-speaking user. Backend triggers sending `booking_confirmation_es` template.

* **Business API Webhook Handling:**
    * **Pattern:** Set up a webhook endpoint (e.g., on N8N or your custom app server) to receive incoming messages and status updates from the WhatsApp Business API.
    * **Implementation:**
        * This webhook is the entry point for user messages into your system.
        * It should authenticate requests from WhatsApp, parse message content (text, media), and forward it to the `CopilotBackend` for processing by the AI.
        * Handle different message types: text, images (e.g., for Photo-to-Experience Matcher), location.

* **Media Sharing and Rich Content Delivery:**
    * **Pattern:** Allow users to send images (e.g., for "find similar experiences"). CopilotKit (via the intermediary) can send images, videos, PDFs (e.g., tour vouchers, property brochures) back to the user on WhatsApp.
    * **Implementation:**
        * Webhook needs to handle incoming media messages, store the media (e.g., in Supabase Storage), and pass a reference to the AI.
        * AI actions that generate or retrieve media will provide a URL, which the intermediary service then uses to send the media via WhatsApp API.

* **Customer Service Automation and Escalation:**
    * **Pattern:** Copilot handles common queries via WhatsApp. If the AI cannot resolve an issue or the user requests human help ("talk to an agent"), the conversation is flagged and escalated to a human agent dashboard (which could be a simple Supabase table view or integrated with a helpdesk system via N8N).
    * **Implementation:**
        * LangChain agent has a tool/logic to detect escalation triggers.
        * On escalation, a message is sent to the user: "I'm connecting you to a human agent. They'll respond here shortly."
        * An N8N workflow creates a ticket or sends a notification to the human support team with the conversation history.

**4.5 Stripe Connect Integration**

Handle marketplace payments, commissions, and payouts securely. Copilot actions will initiate these, but critical logic resides in a secure backend.

* **Multi-Party Payment Processing (Marketplace Model):**
    * **Pattern:** Use Stripe Connect with "Destination Charges" or "Separate Charges and Transfers" to handle payments where "I Love Medellín" is the platform, and funds need to be routed to vendors/hosts minus a commission.
    * **Implementation:**
        1.  **Vendor Onboarding:** Hosts/vendors create Stripe connected accounts (Express or Custom) through an onboarding flow facilitated by your platform (API calls to Stripe from backend). Store Stripe Account IDs in Supabase.
        2.  **Payment:** When a tourist pays, the Copilot action (e.g., `process_booking_payment`) calls your backend. The backend creates a Stripe PaymentIntent:
            * **Destination Charges:** Charge the customer the full amount, with a `transfer_data[destination]` set to the vendor's Stripe Account ID and an `application_fee_amount` for the platform.
            * **Separate Charges & Transfers:** Charge the customer, hold funds in platform account, then make a Transfer to the vendor.
    * **Copilot Role:** The copilot guides the user through payment but doesn't handle raw card details (use Stripe Elements on frontend or Stripe Payment Links).

* **Commission Calculation and Distribution:**
    * **Pattern:** Commission logic (fixed fee, percentage, dynamic rates) is defined in your backend (or Supabase). This logic determines the `application_fee_amount` for Stripe or the split in transfers.
    * **Implementation:**
        * When a payment is processed, your backend retrieves the applicable commission rate for that vendor/service from Supabase.
        * Calculates the platform fee.
        * This fee is specified when creating the Stripe charge/transfer.
        * Store transaction details, including commission taken, in Supabase for accounting.

* **Subscription Management for Premium Features:**
    * **Pattern:** Use Stripe Billing for host/vendor premium subscriptions (e.g., for better listing visibility, advanced Copilot features).
    * **Implementation:**
        * Copilot action `manage_subscription` allows users to subscribe, upgrade, downgrade, or cancel.
        * Backend calls Stripe Billing APIs to create/update subscriptions.
        * Use Stripe webhooks to listen for subscription events (payment success, failure, cancellation) and update user roles/permissions in Supabase.

* **Refund and Dispute Handling Automation (Partial):**
    * **Pattern:** Copilot can initiate refund requests. Backend logic validates the request against refund policies (stored in Supabase) before calling Stripe API. Dispute handling often requires manual intervention but can be logged and tracked.
    * **Implementation:**
        * User requests refund via Copilot.
        * Copilot action `request_refund` triggers backend logic.
        * Backend checks eligibility (e.g., cancellation window, terms).
        * If eligible, backend calls Stripe API to issue a refund.
        * Log all refund requests and dispute notifications (from Stripe webhooks) in Supabase. N8N can route these to support.

* **International Payment Method Support:**
    * **Pattern:** Configure Stripe to accept various international payment methods relevant to your tourist demographic and local Colombian methods (PSE, Efecty – check current Stripe support in Colombia).
    * **Implementation:**
        * Enable desired payment methods in your Stripe dashboard.
        * Ensure your Stripe checkout integration (Elements or Payment Links) dynamically shows available payment methods based on amount and currency.
        * Copilot can inform users about supported payment methods.
    * **PSE/Efecty:** If Stripe's direct support is limited or has friction, you might need to integrate a local Colombian payment aggregator alongside Stripe. Copilot actions would then direct users to the appropriate payment flow based on their choice. This adds complexity, as you'd manage two payment gateways.

---

This phase provides a technical blueprint for integrating CopilotKit with the core external services. The key is to maintain a secure and robust backend where the actual business logic and API interactions occur, with CopilotKit and its associated AI components acting as the intelligent interface and orchestrator.