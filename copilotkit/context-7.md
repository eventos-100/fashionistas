========================
CODE SNIPPETS
========================
TITLE: Install Dependencies for Starter Template
DESCRIPTION: Installs all required project dependencies for the CopilotKit starter template using the configured package manager.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/mastra/quickstart.mdx#_snippet_1

LANGUAGE: package-install
CODE:
```

```

----------------------------------------

TITLE: Install Copilot Runtime and Dependencies
DESCRIPTION: Installs the necessary packages for self-hosting the Copilot Runtime in your frontend application.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/quickstart.mdx#_snippet_12

LANGUAGE: bash
CODE:
```
npm install @copilotkit/runtime class-validator
```

----------------------------------------

TITLE: Setup and Run UI for Quick Start
DESCRIPTION: Installs UI dependencies with pnpm, configures the OpenAI API key in a .env file, and starts the UI development server.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-starter/README.md#_snippet_2

LANGUAGE: Shell
CODE:
```
cd ui
pnpm i
echo "OPENAI_API_KEY=your_key_here" > .env
pnpm run dev
```

----------------------------------------

TITLE: Install CopilotKit and Mastra Packages
DESCRIPTION: Installs the necessary CopilotKit UI, core, runtime, and Mastra client packages required for integrating CopilotKit into an existing Mastra Agent.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/mastra/quickstart.mdx#_snippet_5

LANGUAGE: package-install
CODE:
```
@copilotkit/react-ui @copilotkit/react-core @copilotkit/runtime @ag-ui/mastra @mastra/client-js
```

----------------------------------------

TITLE: Installing UI Dependencies with pnpm
DESCRIPTION: Commands to navigate to the UI directory and install dependencies using pnpm.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-ai-researcher/README.md#2025-04-23_snippet_3

LANGUAGE: sh
CODE:
```
cd ./ui
pnpm i
```

----------------------------------------

TITLE: Clone CopilotKit CoAgents Starter Repository
DESCRIPTION: Clones the official CopilotKit repository from GitHub and navigates into the examples/agno/starter directory, providing a quick way to get started with a pre-configured Agno Agent setup.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/agno/quickstart/agno.mdx#_snippet_1

LANGUAGE: bash
CODE:
```
git clone https://github.com/CopilotKit/CopilotKit
cd CopilotKit/examples/agno/starter
```

----------------------------------------

TITLE: Setup Python Agent for Quick Start
DESCRIPTION: Initial setup steps for the Python agent, including installing dependencies with Poetry and configuring the OpenAI API key in a .env file.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-starter/README.md#_snippet_0

LANGUAGE: Shell
CODE:
```
cd agent-py
poetry install
echo "OPENAI_API_KEY=your_key_here" > .env
```

----------------------------------------

TITLE: Installing UI Dependencies with pnpm
DESCRIPTION: Commands to navigate to the UI directory and install dependencies using pnpm.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-qa/README.md#2025-04-23_snippet_3

LANGUAGE: sh
CODE:
```
cd ./ui
pnpm i
```

----------------------------------------

TITLE: Start Frontend Development Server
DESCRIPTION: Instructions to navigate to the 'ui' directory, copy the example environment file, install project dependencies, and start the development server for the frontend application.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/demo-viewer/agent/demo/crewai_crew_enterprise/restaurant_finder_crew/README.md#_snippet_0

LANGUAGE: bash
CODE:
```
> cd ui
> cp .env.example .env  # Copy the example env file
> # Edit the .env file with your Copilot Cloud Public API Key
> pnpm install
> pnpm run dev
```

----------------------------------------

TITLE: Example Chat Prompts
DESCRIPTION: These are example prompts to interact with the AI agent after setup, demonstrating how to query its capabilities and general knowledge through the CopilotSidebar.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/agno/quickstart.mdx#_snippet_11

LANGUAGE: Plaintext
CODE:
```
What tools do you have access to?
```

LANGUAGE: Plaintext
CODE:
```
What do you think about React?
```

----------------------------------------

TITLE: Start Frontend Development Server with pnpm
DESCRIPTION: This snippet provides the necessary commands to initialize and run the frontend development server. It guides the user to the `ui` directory, sets up environment variables by copying an example file, installs project dependencies using pnpm, and finally starts the development server.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-enterprise-crewai-crews/README.md#_snippet_0

LANGUAGE: bash
CODE:
```
cd ui
cp .env.example .env
# Edit the .env file with your Copilot Cloud Public API Key
pnpm install
pnpm run dev
```

----------------------------------------

TITLE: Set Up CopilotKit UI Frontend (Bash)
DESCRIPTION: Navigates to the UI directory, installs Node.js dependencies using pnpm, and starts the frontend development server. The application will be accessible at http://localhost:3000.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/ag2/quickstart.mdx#_snippet_4

LANGUAGE: bash
CODE:
```
cd ui
pnpm i
pnpm run dev
```

----------------------------------------

TITLE: Installing UI Dependencies with pnpm
DESCRIPTION: Commands to navigate to the UI directory and install dependencies using pnpm.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-routing/README.md#2025-04-23_snippet_3

LANGUAGE: sh
CODE:
```
cd ./ui
pnpm i
```

----------------------------------------

TITLE: Install Dependencies for CopilotKit Agno Starter
DESCRIPTION: These commands install both frontend and agent dependencies for the CopilotKit Agno starter template. The `install:agent` script is crucial as it manages the installation of Python dependencies for the Agno agent via pip, orchestrated through the project's package.json.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/agno/quickstart.mdx#_snippet_1

LANGUAGE: npm
CODE:
```
npm install
npm run install:agent
```

LANGUAGE: pnpm
CODE:
```
pnpm install
pnpm install:agent
```

LANGUAGE: yarn
CODE:
```
yarn install
yarn install:agent
```

LANGUAGE: bun
CODE:
```
bun install
bun install:agent
```

----------------------------------------

TITLE: Installing Agent Dependencies with Poetry
DESCRIPTION: Commands to navigate to the agent directory and install dependencies using Poetry.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-ai-researcher/README.md#2025-04-23_snippet_0

LANGUAGE: sh
CODE:
```
cd agent
poetry install
```

----------------------------------------

TITLE: Installing UI Dependencies with pnpm
DESCRIPTION: Commands to navigate to the UI directory and install dependencies using pnpm package manager.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-shared-state/README.md#2025-04-23_snippet_3

LANGUAGE: sh
CODE:
```
cd ./ui
pnpm i
```

----------------------------------------

TITLE: Setting Up Local Documentation Site
DESCRIPTION: Commands to install dependencies and start the documentation site in development mode using pnpm.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/(root)/(other)/contributing/docs-contributions.mdx#2025-04-23_snippet_1

LANGUAGE: shell
CODE:
```
pnpm install
pnpm run dev
```

----------------------------------------

TITLE: Installing Agent Dependencies with Poetry
DESCRIPTION: Commands to navigate to the agent directory and install dependencies using Poetry.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-qa/README.md#2025-04-23_snippet_0

LANGUAGE: sh
CODE:
```
cd agent
poetry install
```

----------------------------------------

TITLE: Navigating to Example Directory
DESCRIPTION: Command to navigate to the coagents-travel example directory containing the UI and agent components.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/tutorials/ai-travel-app/step-1-checkout-repo.mdx#2025-04-23_snippet_1

LANGUAGE: shell
CODE:
```
cd examples/coagents-travel
```

----------------------------------------

TITLE: Installing Agent Dependencies with Poetry
DESCRIPTION: Commands to navigate to the agent directory and install dependencies using Poetry.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-routing/README.md#2025-04-23_snippet_0

LANGUAGE: sh
CODE:
```
cd agent
poetry install
```

----------------------------------------

TITLE: Installing UI Dependencies with pnpm
DESCRIPTION: Commands to navigate to the UI directory and install dependencies using pnpm.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-qa-native/README.md#2025-04-23_snippet_3

LANGUAGE: sh
CODE:
```
cd ./ui
pnpm i
```

----------------------------------------

TITLE: Run CopilotKit Documentation Site Locally
DESCRIPTION: Steps to install project dependencies using pnpm and start the documentation site in development mode, making it accessible for local review at `http://localhost:3000`.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/public/llms-full.txt#_snippet_246

LANGUAGE: Bash
CODE:
```
pnpm install
pnpm run dev
```

----------------------------------------

TITLE: Running the Next.js UI Project
DESCRIPTION: Command to start the Next.js development server for the UI component. This should be run after setting up the environment and installing dependencies.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-shared-state/README.md#2025-04-23_snippet_5

LANGUAGE: sh
CODE:
```
pnpm run dev
```

----------------------------------------

TITLE: Installing Dependencies and Running the Frontend UI (Shell)
DESCRIPTION: These shell commands, executed within the `ui` directory, first install the project's Node.js dependencies using pnpm and then start the frontend development server using pnpm. This makes the user interface accessible.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/langgraph-tutorial-customer-support/README.md#2025-04-23_snippet_2

LANGUAGE: shell
CODE:
```
pnpm install
pnpm dev
```

----------------------------------------

TITLE: Installing UI Dependencies with pnpm
DESCRIPTION: Commands to navigate to the UI directory and install frontend dependencies using pnpm.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-starter-crewai-flows/README.md#2025-04-23_snippet_3

LANGUAGE: sh
CODE:
```
cd ./ui
pnpm i
```

----------------------------------------

TITLE: Installing Copilot Runtime Package
DESCRIPTION: This command installs the `@copilotkit/runtime` package, which serves as a production-ready proxy for your CrewAI Flows. It is a crucial component for self-hosting the Copilot Runtime.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/crewai-flows/quickstart.mdx#_snippet_9

LANGUAGE: npm
CODE:
```
npm install @copilotkit/runtime
```

----------------------------------------

TITLE: Installing Agent Dependencies with Poetry
DESCRIPTION: Commands to navigate to the agent directory and install dependencies using Poetry.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-qa-native/README.md#2025-04-23_snippet_0

LANGUAGE: sh
CODE:
```
cd agent
poetry install
```

----------------------------------------

TITLE: Start Development Server for CopilotKit Template
DESCRIPTION: Initiates the development server for the CopilotKit template, concurrently starting both the UI and agent servers. Instructions are provided for npm, pnpm, yarn, and bun package managers.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/mastra/quickstart.mdx#_snippet_3

LANGUAGE: bash
CODE:
```
npm run dev
```

LANGUAGE: bash
CODE:
```
pnpm dev
```

LANGUAGE: bash
CODE:
```
yarn dev
```

LANGUAGE: bash
CODE:
```
bun dev
```

----------------------------------------

TITLE: Starting Frontend Development Server with pnpm
DESCRIPTION: This sequence of shell commands navigates into the 'ui' directory, copies the example environment file to '.env', prompts the user to edit the '.env' file with their Copilot Cloud Public API Key, installs project dependencies using pnpm, and starts the development server. It requires pnpm to be installed and the .env file to be properly configured with NEXT_PUBLIC_AGENT_NAME and NEXT_PUBLIC_CPK_PUBLIC_API_KEY.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/demo-viewer/agent/demo/crewai_crew_enterprise/restaurant_finder_crew/README.mdx#2025-04-23_snippet_0

LANGUAGE: sh
CODE:
```
> cd ui
> cp .env.example .env  # Copy the example env file
> # Edit the .env file with your Copilot Cloud Public API Key
> pnpm install
> pnpm run dev
```

----------------------------------------

TITLE: Running the Next.js UI Project
DESCRIPTION: Command to start the Next.js development server for the UI.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-routing/README.md#2025-04-23_snippet_5

LANGUAGE: sh
CODE:
```
pnpm run dev
```

----------------------------------------

TITLE: Start Development Servers for CopilotKit Agno Starter
DESCRIPTION: These commands initiate both the frontend UI and the Agno agent servers concurrently, enabling a complete development environment. Select the command that corresponds to your preferred package manager to launch the application.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/agno/quickstart.mdx#_snippet_3

LANGUAGE: npm
CODE:
```
npm run dev
```

LANGUAGE: pnpm
CODE:
```
pnpm dev
```

LANGUAGE: yarn
CODE:
```
yarn dev
```

LANGUAGE: bun
CODE:
```
bun dev
```

----------------------------------------

TITLE: Install CopilotKit React UI and Core packages
DESCRIPTION: Installs the necessary `@copilotkit/react-ui` and `@copilotkit/react-core` packages into your frontend project, providing the UI components and core functionalities for CopilotKit.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/crewai-flows/quickstart.mdx#_snippet_2

LANGUAGE: npm
CODE:
```
npm install @copilotkit/react-ui @copilotkit/react-core
```

----------------------------------------

TITLE: Starting Next.js Development Server
DESCRIPTION: Commands to start the Next.js development server using different package managers. The server can be started using npm, yarn, pnpm, or bun.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/CopilotKit/examples/next-pages-router/README.md#2025-04-23_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Installing Frontend Dependencies
DESCRIPTION: Navigate to the frontend directory and install project dependencies using pnpm package manager.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/tutorials/agent-native-app/step-1-checkout-repo.mdx#2025-04-23_snippet_1

LANGUAGE: shell
CODE:
```
cd frontend
pnpm install
```

----------------------------------------

TITLE: Running the Agent Demo
DESCRIPTION: Command to run the agent demo using Poetry. This should be executed after setting up the environment and installing dependencies.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-shared-state/README.md#2025-04-23_snippet_2

LANGUAGE: sh
CODE:
```
poetry run demo
```

----------------------------------------

TITLE: Starting Next.js Development Server
DESCRIPTION: Commands to run the Next.js development server using different package managers. This allows developers to start the local development environment for the Next.js application.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-starter/ui/README.md#2025-04-23_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Start the project
DESCRIPTION: Now, you are ready to start the project by running:

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/direct-to-llm/tutorials/ai-powered-textarea/step-1-checkout-repo.mdx#_snippet_2

LANGUAGE: shell
CODE:
```
npm run dev
```

----------------------------------------

TITLE: Running the Next.js UI Project
DESCRIPTION: Command to start the Next.js development server for the UI.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-ai-researcher/README.md#2025-04-23_snippet_5

LANGUAGE: sh
CODE:
```
pnpm run dev
```

----------------------------------------

TITLE: Installing Agent Dependencies with Poetry
DESCRIPTION: Command to install the agent dependencies using Poetry package manager. This should be run in the agent directory.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-shared-state/README.md#2025-04-23_snippet_0

LANGUAGE: sh
CODE:
```
cd agent
poetry install
```

----------------------------------------

TITLE: Setup CopilotKit in Next.js page.tsx
DESCRIPTION: An example `page.tsx` component demonstrating the integration of CopilotKit. It includes importing styles, setting up the `CopilotKit` provider, integrating `CopilotChat` UI, and showcasing a `useCopilotAction` hook for dynamic background changes based on AI interaction.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/crewai-flows/quickstart.mdx#_snippet_3

LANGUAGE: tsx
CODE:
```
"use client";
import "@copilotkit/react-ui/styles.css";
import { CopilotKit, useCopilotAction } from "@copilotkit/react-core";
import { CopilotChat } from "@copilotkit/react-ui";
import React, { useState } from "react";

const publicApiKey = process.env.NEXT_PUBLIC_COPILOT_API_KEY || "";
/**
 * AgentName refers to the Crew Flow Agent you have saved via CLI during setup.
 * It is used to identify the agent you want to use for the chat.
 */
const agentName =
  process.env.NEXT_PUBLIC_COPILOTKIT_AGENT_NAME || "DefaultAgent";

// Main Chat Component: Handles chat interface and background customization
const Chat = () => {
  const [background, setBackground] = useState(
    "linear-gradient(135deg, #667eea 0%, #764ba2 100%)"
  );

  // Action: Allow AI to change background color dynamically
  useCopilotAction({
    name: "change_background",

```

----------------------------------------

TITLE: Install CopilotKit Frontend Packages
DESCRIPTION: Install the core CopilotKit React UI and core packages into your frontend application. These packages are essential for building interactive AI-powered user interfaces when taking the manual code-along approach.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/quickstart.mdx#_snippet_3

LANGUAGE: bash
CODE:
```
npm install @copilotkit/react-ui @copilotkit/react-core
```

----------------------------------------

TITLE: Install Copilot Runtime Package
DESCRIPTION: This command installs the `@copilotkit/runtime` package, which is a production-ready proxy for Agno Agents. It's the first step in setting up a self-hosted Copilot Runtime in your frontend project.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/agno/quickstart/agno.mdx#_snippet_7

LANGUAGE: package-install
CODE:
```
@copilotkit/runtime
```

----------------------------------------

TITLE: Run Next.js Development Server
DESCRIPTION: Commands to start the development server for a Next.js application using different package managers like npm, yarn, pnpm, or bun.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-starter/ui/README.md#_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Installing UI Dependencies
DESCRIPTION: Commands to navigate to the UI directory and install project dependencies using pnpm.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/tutorials/ai-travel-app/step-1-checkout-repo.mdx#2025-04-23_snippet_2

LANGUAGE: shell
CODE:
```
cd ui
pnpm install
```

----------------------------------------

TITLE: Clone CopilotKit Starter Template
DESCRIPTION: Clones the `coagents-starter-mastra` repository from GitHub and navigates into the newly created directory, providing a quick starting point for CopilotKit development.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/mastra/quickstart.mdx#_snippet_0

LANGUAGE: bash
CODE:
```
git clone https://github.com/CopilotKit/coagents-starter-mastra
cd coagents-starter-mastra
```

----------------------------------------

TITLE: Clone and Navigate to Agent Directory
DESCRIPTION: Instructions to clone the CopilotKit repository, perform a sparse-checkout of the specific agent example (Python or TypeScript), and navigate into its respective directory.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/quickstart.mdx#_snippet_4

LANGUAGE: bash
CODE:
```
git clone -n --depth=1 --filter=tree:0 https://github.com/CopilotKit/CopilotKit && cd CopilotKit && git sparse-checkout set --no-cone examples/coagents-starter/agent-py && git checkout && cd ..
cd CopilotKit/examples/coagents-starter/agent-py
```

LANGUAGE: bash
CODE:
```
git clone -n --depth=1 --filter=tree:0 https://github.com/CopilotKit/CopilotKit && cd CopilotKit && git sparse-checkout set --no-cone examples/coagents-starter/agent-js && git checkout && cd ..
cd CopilotKit/examples/coagents-starter/agent-js
```

----------------------------------------

TITLE: Clone AG2 CopilotKit Starter Repository (Bash)
DESCRIPTION: Clones the AG2 CopilotKit starter repository from GitHub and navigates into its directory to begin the setup process.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/ag2/quickstart.mdx#_snippet_0

LANGUAGE: bash
CODE:
```
git clone https://github.com/ag2ai/ag2-copilotkit-starter.git
cd ag2-copilotkit-starter
```

----------------------------------------

TITLE: Install CopilotKit React and Runtime Packages for Self-Hosting
DESCRIPTION: Installs @copilotkit/react-ui, @copilotkit/react-core, and @copilotkit/runtime packages, which are necessary for integrating CopilotKit when self-hosting its backend runtime.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/direct-to-llm/guides/quickstart.mdx#_snippet_3

LANGUAGE: npm
CODE:
```
npm install @copilotkit/react-ui @copilotkit/react-core @copilotkit/runtime
```

----------------------------------------

TITLE: Start the project
DESCRIPTION: Start the development server to run the todo list application.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/direct-to-llm/tutorials/ai-todo-app/step-1-checkout-repo.mdx#_snippet_2

LANGUAGE: shell
CODE:
```
npm run dev
```

----------------------------------------

TITLE: Provide Quickstart Guide with CTACards
DESCRIPTION: This JSX snippet shows how to use the `CTACards` component to present a quickstart guide for CoAgents, linking to the 'Quickstart' page. It serves as a call to action for users to begin building their first CoAgent.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/agno/index.mdx#_snippet_1

LANGUAGE: jsx
CODE:
```
<CTACards
  columns={1}
  cards={[
    {
      icon: LuPlay,
      title: "Quickstart",
      description: "Learn how to build your first CoAgent in 10 minutes.",
      href: "/agno/quickstart/agno",
    },
  ]}
/>
```

----------------------------------------

TITLE: Starting Next.js Development Server
DESCRIPTION: This snippet shows various package manager commands to start the Next.js development server. It includes options for npm, yarn, pnpm, and bun.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-routing/ui/README.md#2025-04-23_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Install Agent Dependencies
DESCRIPTION: Commands to install project dependencies for the respective LangGraph agent (Python using Poetry or TypeScript using pnpm).

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/quickstart.mdx#_snippet_5

LANGUAGE: bash
CODE:
```
poetry install
```

LANGUAGE: bash
CODE:
```
pnpm install
```

----------------------------------------

TITLE: Running Agent Demo - Poetry Script
DESCRIPTION: Launches the sample agent application using Poetry. This command should be run from the 'agent' directory after all dependencies have been installed and environment variables configured. It will start the agent demo, relying on prior environment setup.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-qa-text/README.md#2025-04-23_snippet_2

LANGUAGE: sh
CODE:
```
poetry run demo
```

----------------------------------------

TITLE: Starting Development Server
DESCRIPTION: Command to launch the NextJS development server for the travel application.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/tutorials/ai-travel-app/step-1-checkout-repo.mdx#2025-04-23_snippet_3

LANGUAGE: shell
CODE:
```
pnpm run dev
```

----------------------------------------

TITLE: Install CopilotKit and Agno UI Packages
DESCRIPTION: This command installs the necessary npm packages for CopilotKit's React UI, React Core, Runtime, and the Agno UI integration. These packages provide the core functionalities for the CopilotKit runtime and UI components.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/agno/quickstart.mdx#_snippet_7

LANGUAGE: npm
CODE:
```
npm install @copilotkit/react-ui @copilotkit/react-core @copilotkit/runtime @ag-ui/agno
```

----------------------------------------

TITLE: Install CopilotKit React Packages for Cloud Hosting
DESCRIPTION: Installs the essential @copilotkit/react-ui and @copilotkit/react-core packages required for integrating CopilotKit when utilizing the hosted Copilot Cloud backend.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/direct-to-llm/guides/quickstart.mdx#_snippet_2

LANGUAGE: npm
CODE:
```
npm install @copilotkit/react-ui @copilotkit/react-core
```

----------------------------------------

TITLE: Starting the Frontend Application with CopilotKit and CrewAI
DESCRIPTION: This snippet shows the commands to navigate to the UI directory, set up the environment, install dependencies, and start the development server for the frontend application that uses CopilotKit and CrewAI.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-enterprise-crewai-crews/README.md#2025-04-23_snippet_0

LANGUAGE: bash
CODE:
```
> cd ui
> cp .env.example .env  # Copy the example env file
> # Edit the .env file with your Copilot Cloud Public API Key
> pnpm install
> pnpm run dev
```

----------------------------------------

TITLE: Starting Development Server
DESCRIPTION: Launch the NextJS development server to run the application locally on port 3000.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/tutorials/agent-native-app/step-1-checkout-repo.mdx#2025-04-23_snippet_2

LANGUAGE: shell
CODE:
```
pnpm run dev
```

----------------------------------------

TITLE: Start CoAgent Example Development Environment
DESCRIPTION: Executes a script to start a development environment for the 'coagents-starter' example. This setup provides hot reload capabilities, allowing developers to work on CopilotKit internals (TypeScript and Python) and see changes reflected instantly.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/llamaindex/(other)/contributing/code-contributions/index.mdx#_snippet_8

LANGUAGE: bash
CODE:
```
./scripts/develop/example.sh coagents-starter
```

----------------------------------------

TITLE: Installing Python Dependencies with Poetry
DESCRIPTION: Command to install Python dependencies for the backend using Poetry package manager.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-starter-crewai-flows/README.md#2025-04-23_snippet_0

LANGUAGE: sh
CODE:
```
cd agent-py
poetry install
```

----------------------------------------

TITLE: Starting UI Development Server
DESCRIPTION: Command to start the UI development server using pnpm.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-starter/README.md#2025-04-23_snippet_5

LANGUAGE: sh
CODE:
```
pnpm run dev
```

----------------------------------------

TITLE: Run Next.js Development Server
DESCRIPTION: Commands to start the Next.js development server using various package managers (npm, yarn, pnpm, bun). The server will be accessible at http://localhost:3000.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/langgraph-tutorial-quickstart/ui/README.md#_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
```

LANGUAGE: bash
CODE:
```
yarn dev
```

LANGUAGE: bash
CODE:
```
pnpm dev
```

LANGUAGE: bash
CODE:
```
bun dev
```

----------------------------------------

TITLE: Create a new Next.js application
DESCRIPTION: Use this command to quickly scaffold a new Next.js project if you don't already have one, providing a base for CopilotKit integration.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/crewai-crews/quickstart.mdx#_snippet_0

LANGUAGE: bash
CODE:
```
npx create-next-app@latest
```

----------------------------------------

TITLE: Run a CopilotKit Example for Real-time Testing
DESCRIPTION: Navigates to a specific example directory (e.g., next-openai), sets the OPENAI_API_KEY environment variable, and starts the example in development mode to test changes to CopilotKit packages.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/(root)/(other)/contributing/code-contributions/index.mdx#_snippet_4

LANGUAGE: bash
CODE:
```
cd examples/next-openai
export OPENAI_API_KEY=<your-openai-api-key>
pnpm run example-dev
```

----------------------------------------

TITLE: Installing Dependencies and Running Demo Viewer (Bash)
DESCRIPTION: Installs project dependencies using pnpm (`pnpm install`) and then starts the Next.js development server (`pnpm run dev`) from the project's root directory. Assumes pnpm is installed. The viewer will typically be accessible at http://localhost:3000.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/demo-viewer/README.md#2025-04-23_snippet_12

LANGUAGE: bash
CODE:
```
pnpm install
pnpm run dev
```

----------------------------------------

TITLE: Cloning Tutorial Repository with Git
DESCRIPTION: Clone the tutorial-start branch of the open-research-ana repository which contains the starter code for both frontend and agent components.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/tutorials/agent-native-app/step-1-checkout-repo.mdx#2025-04-23_snippet_0

LANGUAGE: shell
CODE:
```
git clone -b tutorial-start https://github.com/CopilotKit/open-research-ana.git
cd open-research-ana
```

----------------------------------------

TITLE: Install CopilotKit React UI and Core Packages
DESCRIPTION: Installs the @copilotkit/react-ui and @copilotkit/react-core packages, which provide the necessary frontend components and core functionalities for integrating CopilotKit into a React application.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/agno/quickstart/agno.mdx#_snippet_0

LANGUAGE: bash
CODE:
```
npm install @copilotkit/react-ui @copilotkit/react-core
```

----------------------------------------

TITLE: Running the Next.js UI Project
DESCRIPTION: Command to start the Next.js development server for the UI.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-qa-native/README.md#2025-04-23_snippet_5

LANGUAGE: sh
CODE:
```
pnpm run dev
```

----------------------------------------

TITLE: Example Agent Interaction Prompts
DESCRIPTION: These are examples of questions you can ask the integrated LangGraph agent to test its functionality and observe its responses. They demonstrate typical conversational inputs for an AI chatbot.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/quickstart.mdx#_snippet_2

LANGUAGE: text
CODE:
```
Can you tell me a joke?
```

LANGUAGE: text
CODE:
```
Can you help me understand AI?
```

LANGUAGE: text
CODE:
```
What do you think about React?
```

----------------------------------------

TITLE: Clone CopilotKit LlamaIndex Starter Template
DESCRIPTION: Clones the official CopilotKit LlamaIndex starter template repository from GitHub and changes the current directory into the newly created project folder, preparing for further setup.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/llamaindex/quickstart.mdx#_snippet_0

LANGUAGE: bash
CODE:
```
git clone https://github.com/CopilotKit/with-llamaindex copilotkit-llamaindex-starter
cd copilotkit-llamaindex-starter
```

----------------------------------------

TITLE: Run CoAgents Demo
DESCRIPTION: This command executes the CoAgents demo application after dependencies are installed and the API key is configured. It starts the agent backend, making it ready for interaction.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-routing/README.md#_snippet_2

LANGUAGE: Shell
CODE:
```
poetry run demo
```

----------------------------------------

TITLE: Clone CopilotKit Agno Starter Template
DESCRIPTION: This command clones the CopilotKit Agno starter template repository from GitHub and navigates into the newly created directory. It's the essential first step for users opting to begin with the provided template.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/agno/quickstart.mdx#_snippet_0

LANGUAGE: bash
CODE:
```
git clone https://github.com/CopilotKit/with-agno copilotkit-agno-starter
cd copilotkit-agno-starter
```

----------------------------------------

TITLE: Installing UI Dependencies
DESCRIPTION: Commands to install dependencies for the UI component using pnpm.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-starter/README.md#2025-04-23_snippet_4

LANGUAGE: sh
CODE:
```
cd ./ui
pnpm i
```

----------------------------------------

TITLE: Starting the Next.js Development Server
DESCRIPTION: Command to run the development server for the CopilotKit project. This launches the application in development mode with hot-reloading enabled.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/CopilotKit/examples/next-openai/README.md#2025-04-23_snippet_0

LANGUAGE: bash
CODE:
```
yarn dev
```

----------------------------------------

TITLE: Install CopilotKit LlamaIndex Project Dependencies
DESCRIPTION: Installs both frontend and agent dependencies for the CopilotKit LlamaIndex starter project. The agent's Python dependencies are managed via a `package.json` script, `install:agent`, executed by the chosen JavaScript package manager.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/llamaindex/quickstart.mdx#_snippet_1

LANGUAGE: npm
CODE:
```
npm install
npm run install:agent
```

LANGUAGE: pnpm
CODE:
```
pnpm install
pnpm install:agent
```

LANGUAGE: yarn
CODE:
```
yarn install
yarn install:agent
```

LANGUAGE: bun
CODE:
```
bun install
bun install:agent
```

----------------------------------------

TITLE: Run Next.js Development Server
DESCRIPTION: Provides commands to start the Next.js development server using different package managers (npm, yarn, pnpm, bun). The application will be accessible at `http://localhost:3000`.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-travel/ui/README.md#_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Installing Copilot Runtime Dependencies
DESCRIPTION: Installs the necessary packages for the Copilot Runtime, which acts as a production-ready proxy for LangGraph agents. This command uses a package manager (e.g., npm) to add the specified dependencies to your project.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/quickstart.mdx#_snippet_19

LANGUAGE: npm
CODE:
```
@copilotkit/runtime class-validator
```

----------------------------------------

TITLE: Create New Next.js Application
DESCRIPTION: This bash command creates a new Next.js project using `create-next-app` and navigates into its directory, serving as the initial setup for a React-based frontend that will integrate with CopilotKit.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/agno/quickstart.mdx#_snippet_6

LANGUAGE: Bash
CODE:
```
npx create-next-app@latest my-copilot-app
cd my-copilot-app
```

----------------------------------------

TITLE: Running the Agent Demo
DESCRIPTION: Command to run the agent demo using Poetry.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-routing/README.md#2025-04-23_snippet_2

LANGUAGE: sh
CODE:
```
poetry run demo
```

----------------------------------------

TITLE: Initialize Next.js App with CopilotKit CLI
DESCRIPTION: Use the CopilotKit CLI to automatically bootstrap a Next.js application for integration with CopilotKit, simplifying the setup process.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/direct-to-llm/guides/quickstart.mdx#_snippet_0

LANGUAGE: bash
CODE:
```
npx copilotkit@latest init
```

----------------------------------------

TITLE: Running Next.js Development Server with Different Package Managers
DESCRIPTION: Command-line instructions to start the development server for a Next.js application using npm, pnpm, or yarn package managers.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/README.md#2025-04-23_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
pnpm dev
# or
yarn dev
```

----------------------------------------

TITLE: Running Next.js Development Server
DESCRIPTION: Commands to start the Next.js development server using different package managers. This allows developers to run the project locally for development and testing.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-travel/ui/README.md#2025-04-23_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Example AI Agent Interaction Queries
DESCRIPTION: These examples demonstrate common questions and prompts users can provide to their AI agent to explore its capabilities, available tools, and general knowledge.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/llamaindex/quickstart.mdx#_snippet_11

LANGUAGE: Plaintext
CODE:
```
What tools do you have access to?
```

LANGUAGE: Plaintext
CODE:
```
What do you think about React?
```

LANGUAGE: Plaintext
CODE:
```
Show me some cool things you can do!
```

----------------------------------------

TITLE: Example Questions for LangGraph Agent Interaction
DESCRIPTION: These are example prompts to test the functionality and understanding of a newly integrated LangGraph agent chatbot. They demonstrate typical conversational queries to initiate interaction.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/quickstart.mdx#_snippet_13

LANGUAGE: plaintext
CODE:
```
Can you tell me a joke?
```

LANGUAGE: plaintext
CODE:
```
Can you help me understand AI?
```

LANGUAGE: plaintext
CODE:
```
What do you think about React?
```

----------------------------------------

TITLE: Run Next.js Development Server
DESCRIPTION: Commands to start the Next.js development server using different package managers (npm, yarn, pnpm, bun). This allows you to view the application in a browser at http://localhost:3000.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-starter-crewai-crews/ui/README.md#_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Running the Agent Demo
DESCRIPTION: Command to run the agent demo using Poetry.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-qa/README.md#2025-04-23_snippet_2

LANGUAGE: sh
CODE:
```
poetry run demo
```

----------------------------------------

TITLE: Run Next.js Development Server
DESCRIPTION: Commands to start the Next.js development server, allowing the application to be accessed locally. Multiple package managers are supported for running the development server.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/ag2/starter/README.md#_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Install Dependencies and Run Demo Viewer Frontend
DESCRIPTION: In a new terminal, navigate to the project root and install frontend dependencies using pnpm install. Then, start the Demo Viewer frontend with pnpm run dev, which will make the application accessible at http://localhost:3000.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/demo-viewer/README.md#_snippet_7

LANGUAGE: bash
CODE:
```
pnpm install
pnpm run dev
```

----------------------------------------

TITLE: Running Next.js Development Server
DESCRIPTION: Commands to start the Next.js development server using various package managers. This allows developers to run the project locally for development and testing.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-starter-crewai-crews/ui/README.md#2025-04-23_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Example User Queries for LangGraph Agent Interaction
DESCRIPTION: Demonstrates example natural language questions users can ask a LangGraph agent integrated with CopilotKit to test its functionality and capabilities after successful setup.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/public/llms-full.txt#_snippet_7

LANGUAGE: Natural Language
CODE:
```
Can you tell me a joke?
```

LANGUAGE: Natural Language
CODE:
```
Can you help me understand AI?
```

LANGUAGE: Natural Language
CODE:
```
What do you think about React?
```

----------------------------------------

TITLE: Running Next.js Development Server
DESCRIPTION: Command to start the Next.js development server for the UI.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-starter-crewai-flows/README.md#2025-04-23_snippet_5

LANGUAGE: sh
CODE:
```
pnpm run dev
```

----------------------------------------

TITLE: Install dependencies
DESCRIPTION: To install the dependencies, run the following:

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/direct-to-llm/tutorials/ai-powered-textarea/step-1-checkout-repo.mdx#_snippet_1

LANGUAGE: shell
CODE:
```
npm install
```

----------------------------------------

TITLE: Installing Dependencies and Running Travel Planner Agent
DESCRIPTION: Uses Poetry to install the required dependencies and start the Travel Planner agent server. The server is configured to run on port 8000.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-travel/agent/README.md#2025-04-23_snippet_1

LANGUAGE: sh
CODE:
```
poetry install
poetry run demo
```

----------------------------------------

TITLE: Running Next.js Development Server
DESCRIPTION: Commands to start the Next.js development server using various package managers. This allows developers to run the project locally for development and testing.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-qa/ui/README.md#2025-04-23_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Run Example Application for Testing
DESCRIPTION: Navigates to an example application (e.g., next-openai), sets the OpenAI API key, and starts the example in development mode for real-time testing of changes made to CopilotKit packages.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/mastra/(other)/contributing/code-contributions/index.mdx#_snippet_4

LANGUAGE: bash
CODE:
```
cd examples/next-openai
export OPENAI_API_KEY=<your-openai-api-key>
pnpm run example-dev
```

----------------------------------------

TITLE: Run Next.js Development Server
DESCRIPTION: Commands to start the development server for a Next.js application. This allows you to view the application in a browser, typically at `http://localhost:3000`.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-wait-user-input/ui/README.md#_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Launching Local CrewAI Flow Agent
DESCRIPTION: These commands use Poetry to manage Python dependencies: `poetry lock` updates the lock file, `poetry install` installs the dependencies, and `poetry run demo` starts the local CrewAI Flow agent server. This makes the agent accessible for connection from your frontend.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/crewai-flows/quickstart.mdx#_snippet_7

LANGUAGE: bash
CODE:
```
poetry lock
poetry install
poetry run demo
```

----------------------------------------

TITLE: Set up Agno Agent Backend
DESCRIPTION: This Python code snippet demonstrates how to initialize and serve an Agno Agent application using `agui_app.get_app()` and `agui_app.serve()`. It exposes the agent on a specified port, making it accessible for CopilotKit.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/agno/quickstart.mdx#_snippet_5

LANGUAGE: Python
CODE:
```
app_id="agno_agent",
                )
                app = agui_app.get_app()
                
                # Serve the app, effectively exposing your Agno Agent
                agui_app.serve(app="agno_agent:app", port=8000, reload=True)
```

----------------------------------------

TITLE: Create a New Next.js Application
DESCRIPTION: Command to quickly scaffold a fresh Next.js application from scratch, useful when starting a new project.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/direct-to-llm/guides/quickstart.mdx#_snippet_1

LANGUAGE: bash
CODE:
```
npx create-next-app@latest
```

----------------------------------------

TITLE: Install CopilotKit Provider Package
DESCRIPTION: This snippet shows how to install a specific provider package using npm. The `{{packageName}}` placeholder should be replaced with the actual package name required for the chosen CopilotKit provider.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/snippets/self-hosting-copilot-runtime-create-endpoint.mdx#_snippet_0

LANGUAGE: shell
CODE:
```
npm install {{packageName}}
```

----------------------------------------

TITLE: Run CopilotKit Documentation Site Locally
DESCRIPTION: Commands to install the necessary dependencies and then start the CopilotKit documentation site in development mode, making it accessible locally.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/(other)/contributing/docs-contributions.mdx#_snippet_1

LANGUAGE: shell
CODE:
```
pnpm install
pnpm run dev
```

----------------------------------------

TITLE: Install AG2 Backend Dependencies (Bash)
DESCRIPTION: Navigates to the Python agent directory and installs all required Python packages listed in 'requirements.txt' using pip.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/ag2/quickstart.mdx#_snippet_1

LANGUAGE: bash
CODE:
```
cd agent-py
pip install -r requirements.txt
```

----------------------------------------

TITLE: Run Next.js Development Server
DESCRIPTION: Commands to start the Next.js development server using various package managers (npm, yarn, pnpm, bun). This allows you to view the application locally at http://localhost:3000.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-qa-native/ui/README.md#_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Running Next.js Development Server
DESCRIPTION: Commands to start the Next.js development server using different package managers. This allows developers to run the project locally for development and testing.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-starter-crewai-flows/ui/README.md#2025-04-23_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Install CopilotKit and AG-UI Packages
DESCRIPTION: This snippet lists the essential npm packages required for the CopilotKit frontend and runtime, along with the AG-UI LlamaIndex integration. These packages provide the necessary components and utilities for building the CopilotKit-powered application.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/llamaindex/quickstart.mdx#_snippet_7

LANGUAGE: package-install
CODE:
```
@copilotkit/react-ui @copilotkit/react-core @copilotkit/runtime @ag-ui/llamaindex
```

----------------------------------------

TITLE: Install Dependencies and Run Documentation Site Locally
DESCRIPTION: These commands install the necessary project dependencies using pnpm and then start the documentation website in development mode. The site will typically be accessible at http://localhost:3000.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/shared/(other)/contributing/docs-contributions.mdx#_snippet_1

LANGUAGE: shell
CODE:
```
pnpm install
pnpm run dev
```

----------------------------------------

TITLE: Run CoAgents Agent Demo
DESCRIPTION: Command to start the CoAgents agent demo using `poetry` after dependencies and API keys are configured.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-qa-native/README.md#_snippet_2

LANGUAGE: sh
CODE:
```
poetry run demo
```

----------------------------------------

TITLE: Run CopilotKit Documentation Site Locally
DESCRIPTION: Commands to install project dependencies using pnpm and then start the documentation site in development mode, making it accessible via a local URL.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/ag2/(other)/contributing/docs-contributions.mdx#_snippet_1

LANGUAGE: shell
CODE:
```
pnpm install
pnpm run dev
```

----------------------------------------

TITLE: Running Next.js Development Server
DESCRIPTION: Commands to start the Next.js development server using various package managers. This allows developers to run the project locally for development and testing purposes.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-research-canvas/ui/README.md#2025-04-23_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Run CopilotKit Example in Development Mode
DESCRIPTION: Navigates to a specific example directory, sets the OpenAI API key as an environment variable, and then starts the example's development server. This allows for real-time testing of changes made to CopilotKit packages.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/llamaindex/(other)/contributing/code-contributions/index.mdx#_snippet_5

LANGUAGE: bash
CODE:
```
cd examples/next-openai
export OPENAI_API_KEY=<your-openai-api-key>
pnpm run example-dev
```

----------------------------------------

TITLE: Run CopilotKit Documentation Site Locally
DESCRIPTION: These commands install the necessary project dependencies and then start the documentation website in development mode, making it accessible for local testing and content creation.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/llamaindex/(other)/contributing/docs-contributions.mdx#_snippet_1

LANGUAGE: shell
CODE:
```
pnpm install
pnpm run dev
```

----------------------------------------

TITLE: Install Dependencies and Start LangGraph Agent CLI
DESCRIPTION: These commands install the necessary Python dependencies from 'requirements.txt', then install the LangGraph CLI tool, and finally start the LangGraph agent server on localhost:8000. This allows for visualization and interaction with the agent via LangGraph Studio.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/tutorials/agent-native-app/step-2-start-the-agent.mdx#_snippet_2

LANGUAGE: shell
CODE:
```
pip install -r requirements.txt # Install dependencies
brew install langgraph-cli # Install LangGraph CLI
langgraph dev --host localhost --port 8000 # Start the agent
```

----------------------------------------

TITLE: Running Next.js Development Server
DESCRIPTION: Commands to start the Next.js development server using various package managers. This allows developers to run the application locally for development and testing.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-ai-researcher/ui/README.md#2025-04-23_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Run Next.js Development Server
DESCRIPTION: Commands to start the local development server for a Next.js application. This allows you to view the application in a browser at `http://localhost:3000` and enables hot-reloading for development.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-ai-researcher/ui/README.md#_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Starting the Todo List App Development Server
DESCRIPTION: Starts the development server for the todo list app, which will be accessible at http://localhost:3000.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/(root)/tutorials/ai-powered-textarea/step-1-checkout-repo.mdx#2025-04-23_snippet_2

LANGUAGE: shell
CODE:
```
npm run dev
```

----------------------------------------

TITLE: Cloning CopilotKit Repository
DESCRIPTION: Commands to clone the CopilotKit repository from the coagents-travel-tutorial-start branch and navigate to the project directory.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/tutorials/ai-travel-app/step-1-checkout-repo.mdx#2025-04-23_snippet_0

LANGUAGE: shell
CODE:
```
git clone -b coagents-travel-tutorial-start https://github.com/CopilotKit/CopilotKit.git
cd CopilotKit
```

----------------------------------------

TITLE: Running Next.js Development Server
DESCRIPTION: Commands to start the Next.js development server using various package managers. This allows developers to run the project locally for development and testing.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-qa-native/ui/README.md#2025-04-23_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Installing dependencies and starting LangGraph agent
DESCRIPTION: Installs required dependencies, the LangGraph CLI, and starts the agent on localhost:8000. This process sets up the environment and launches LangGraph Studio for agent visualization and interaction.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/tutorials/agent-native-app/step-2-start-the-agent.mdx#2025-04-23_snippet_1

LANGUAGE: shell
CODE:
```
pip install -r requirements.txt # Install dependencies
brew install langgraph-cli # Install LangGraph CLI
langgraph dev --host localhost --port 8000 # Start the agent
```

----------------------------------------

TITLE: Initialize CopilotKit CLI with LangGraph
DESCRIPTION: Run this command within your Next.js application to quickly integrate CopilotKit with a LangGraph agent. It bootstraps the necessary configuration and files for a chatbot, streamlining the setup process.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/quickstart.mdx#_snippet_1

LANGUAGE: bash
CODE:
```
npx copilotkit@latest init -m LangGraph
```

----------------------------------------

TITLE: Example Chat Prompts for Agno Agent
DESCRIPTION: These are example prompts to interact with the integrated Agno Agent chatbot. They demonstrate typical questions a user might ask to test the agent's capabilities after successful integration.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/agno/quickstart/agno.mdx#_snippet_10

LANGUAGE: plaintext
CODE:
```
Can you tell me a joke?
```

LANGUAGE: plaintext
CODE:
```
Can you help me understand AI?
```

LANGUAGE: plaintext
CODE:
```
What do you think about React?
```

----------------------------------------

TITLE: Install CopilotKit Dependencies
DESCRIPTION: Instructions to install the necessary `@copilotkit/react-core` and `@copilotkit/react-ui` packages for CopilotKit integration, providing core functionality and UI components.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/direct-to-llm/tutorials/ai-todo-app/step-2-setup-copilotkit.mdx#_snippet_0

LANGUAGE: npm
CODE:
```
npm install @copilotkit/react-core @copilotkit/react-ui
```

----------------------------------------

TITLE: Run Next.js UI Project
DESCRIPTION: Starts the Next.js development server for the UI. Ensure all UI dependencies are installed and environment variables are configured.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-research-canvas/readme.md#_snippet_6

LANGUAGE: Shell
CODE:
```
pnpm run dev
```

----------------------------------------

TITLE: Example User Interactions with AG2 Agent
DESCRIPTION: Examples of natural language queries to test the deployed AG2 agent, demonstrating its travel planning capabilities for various scenarios.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/ag2/quickstart.mdx#_snippet_5

LANGUAGE: text
CODE:
```
I plan to visit the USA for 4 days on a budget.

I want to plan a trip to Paris for 5 days. I have a mid-range budget and I'm interested in art, history, and food.

I'd like a luxury weekend in New York with focus on Broadway shows and fine dining.
```

----------------------------------------

TITLE: Start UI Client Development Server
DESCRIPTION: Starts the UI client development server after dependencies are installed.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-starter/README.md#_snippet_9

LANGUAGE: Shell
CODE:
```
pnpm run dev
```

----------------------------------------

TITLE: Run Documentation Site Locally
DESCRIPTION: These commands install the necessary project dependencies using pnpm and then start the documentation website in development mode, making it accessible locally for testing changes.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/agno/(other)/contributing/docs-contributions.mdx#_snippet_1

LANGUAGE: shell
CODE:
```
pnpm install
pnpm run dev
```

----------------------------------------

TITLE: Create and Configure Environment File
DESCRIPTION: Steps to create an empty `.env` file and then add necessary API keys, such as OpenAI and LangSmith, for application configuration.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/quickstart.mdx#_snippet_6

LANGUAGE: bash
CODE:
```
touch .env
```

LANGUAGE: plaintext
CODE:
```
OPENAI_API_KEY=your_openai_api_key
LANGSMITH_API_KEY=your_langsmith_api_key
```

----------------------------------------

TITLE: Run Next.js Development Server
DESCRIPTION: Instructions to start the Next.js development server using various package managers. This command launches the application locally, typically accessible at `http://localhost:3000`.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-shared-state/ui/README.md#_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Running the Next.js UI Project
DESCRIPTION: Command to run the Next.js UI project using pnpm.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-qa/README.md#2025-04-23_snippet_5

LANGUAGE: sh
CODE:
```
pnpm run dev
```

----------------------------------------

TITLE: Start CoAgent Example on LangGraph Platform
DESCRIPTION: Runs the 'coagents-starter' example specifically on the LangGraph platform. This command is used for testing the example's integration and functionality within the LangGraph ecosystem.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/llamaindex/(other)/contributing/code-contributions/index.mdx#_snippet_9

LANGUAGE: bash
CODE:
```
./scripts/develop/example.sh coagents-starter langgraph-platform
```

----------------------------------------

TITLE: Run CoAgents Agent Demo
DESCRIPTION: Starts the CoAgents agent demo application using `poetry`.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-qa/README.md#_snippet_2

LANGUAGE: sh
CODE:
```
poetry run demo
```

----------------------------------------

TITLE: Clone CopilotKit Repository and Navigate
DESCRIPTION: Clones the CopilotKit repository, specifically the `coagents-travel-tutorial-start` branch, and then navigates into the cloned directory. This command sets up the initial project structure for the travel app tutorial.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/tutorials/ai-travel-app/step-1-checkout-repo.mdx#_snippet_0

LANGUAGE: shell
CODE:
```
git clone -b coagents-travel-tutorial-start https://github.com/CopilotKit/CopilotKit.git
cd CopilotKit
```

----------------------------------------

TITLE: Install UI Dependencies
DESCRIPTION: Navigate to the UI directory and install Node.js dependencies using pnpm.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-wait-user-input/README.md#_snippet_3

LANGUAGE: sh
CODE:
```
cd ./ui
pnpm i
```

----------------------------------------

TITLE: Clone CopilotKit Documentation Repository
DESCRIPTION: Instructions to clone the forked CopilotKit repository to your local machine and navigate into the `docs` directory, preparing for documentation contributions.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/public/llms-full.txt#_snippet_245

LANGUAGE: Bash
CODE:
```
git clone https://github.com/<your-username>/CopilotKit
cd CopilotKit/docs
```

----------------------------------------

TITLE: Initialize CopilotKit CLI for Next.js
DESCRIPTION: This command initializes CopilotKit in a Next.js application using the CopilotKit CLI, providing a quick way to get started with integration.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/public/llms-full.txt#_snippet_167

LANGUAGE: CLI
CODE:
```
npx copilotkit@latest init
```

----------------------------------------

TITLE: Run Next.js Development Server
DESCRIPTION: Commands to start the development server for a Next.js application using various package managers such as npm, yarn, pnpm, or bun. The server typically runs on http://localhost:3000, allowing for live updates during development.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/llamaindex/starter/ui/README.md#_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Run CopilotKit Dev Server for FastAPI
DESCRIPTION: Starts a local development server with CopilotKit, tunneling a FastAPI server running on port 8000 to Copilot Cloud for local development.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/coagents/quickstart.mdx#_snippet_10

LANGUAGE: bash
CODE:
```
npx copilotkit@latest dev --port 8000
```

----------------------------------------

TITLE: Installing Python Agent Dependencies
DESCRIPTION: Commands to install dependencies for the Python agent using Poetry.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-starter/README.md#2025-04-23_snippet_0

LANGUAGE: sh
CODE:
```
cd agent-py
poetry install
```

----------------------------------------

TITLE: Start CoAgents Starter Dev Environment with Hot Reload
DESCRIPTION: Runs a script to start a development environment for the 'coagents-starter' example, enabling hot reload for CopilotKit internals. This requires GNU parallel and langgraph CLI to be installed as prerequisites.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/agno/(other)/contributing/code-contributions/index.mdx#_snippet_8

LANGUAGE: bash
CODE:
```
./scripts/develop/example.sh coagents-starter
```

----------------------------------------

TITLE: Running Next.js Development Server
DESCRIPTION: Commands to start the Next.js development server using various package managers. This allows developers to run the application locally for development and testing purposes.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-wait-user-input/ui/README.md#2025-04-23_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

----------------------------------------

TITLE: Install Agent Dependencies
DESCRIPTION: Navigate to the agent directory and install Python dependencies using Poetry.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-wait-user-input/README.md#_snippet_0

LANGUAGE: sh
CODE:
```
cd agent
poetry install
```

----------------------------------------

TITLE: Installing Dependencies and Seeding Data for Python Backend (Shell)
DESCRIPTION: These shell commands, intended to be run within the `agent-py` directory, install the project's Python dependencies using Poetry and then run a seeding script via Poetry. This prepares the backend environment for the customer support agent.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/langgraph-tutorial-customer-support/README.md#2025-04-23_snippet_0

LANGUAGE: shell
CODE:
```
poetry install
poetry run seed
```

----------------------------------------

TITLE: Configuring UI Environment Variables
DESCRIPTION: Contents of the .env file for the UI, specifying the OpenAI API key.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-qa/README.md#2025-04-23_snippet_4

LANGUAGE: plaintext
CODE:
```
OPENAI_API_KEY=...
```

----------------------------------------

TITLE: Run CopilotKit Example for Real-Time Testing
DESCRIPTION: Navigates to a specific example project (e.g., next-openai), sets the OpenAI API key, and starts the example in development mode to test changes made to CopilotKit packages in real-time.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/shared/(other)/contributing/code-contributions/index.mdx#_snippet_4

LANGUAGE: bash
CODE:
```
cd examples/next-openai
export OPENAI_API_KEY=<your-openai-api-key>
pnpm run example-dev
```

----------------------------------------

TITLE: Run Example for Real-Time Testing
DESCRIPTION: Navigates to a specific example project, sets the OpenAI API key, and starts the example in development mode. This allows developers to test changes to CopilotKit packages in a live environment.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/crewai-crews/(other)/contributing/code-contributions/index.mdx#_snippet_4

LANGUAGE: bash
CODE:
```
cd examples/next-openai
export OPENAI_API_KEY=<your-openai-api-key>
pnpm run example-dev
```

----------------------------------------

TITLE: Install Agent Dependencies
DESCRIPTION: Instructions to navigate into the agent directory and install Python dependencies using `poetry` for the CoAgents backend.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-qa-native/README.md#_snippet_0

LANGUAGE: sh
CODE:
```
cd agent
poetry install
```

----------------------------------------

TITLE: Run CopilotKit Example in Development Mode
DESCRIPTION: Navigates to a specific example directory, sets the OpenAI API key as an environment variable, and starts the example's development server. This allows real-time testing of changes made to CopilotKit packages.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/agno/(other)/contributing/code-contributions/index.mdx#_snippet_5

LANGUAGE: bash
CODE:
```
cd examples/next-openai
export OPENAI_API_KEY=<your-openai-api-key>
pnpm run example-dev
```

----------------------------------------

TITLE: Configuring UI Environment Variables
DESCRIPTION: Content for the .env file in the UI directory, specifying the OpenAI API key.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-routing/README.md#2025-04-23_snippet_4

LANGUAGE: plaintext
CODE:
```
OPENAI_API_KEY=...
```

----------------------------------------

TITLE: Run CopilotKit Documentation Site Locally
DESCRIPTION: Commands to install project dependencies using pnpm and then start the documentation site in development mode, making it accessible via a local server for testing changes.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/mastra/(other)/contributing/docs-contributions.mdx#_snippet_1

LANGUAGE: shell
CODE:
```
pnpm install
pnpm run dev
```

----------------------------------------

TITLE: Launch local CrewAI Flow agent using Poetry
DESCRIPTION: These commands install dependencies and start a local CrewAI Flow agent server using Poetry, making it ready for connection.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/public/llms-full.txt#_snippet_152

LANGUAGE: shell
CODE:
```
# Install dependencies
poetry lock
poetry install
# Start the server
poetry run demo
```

----------------------------------------

TITLE: Installing JavaScript Agent Dependencies
DESCRIPTION: Commands to install dependencies for the JavaScript agent using pnpm.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/examples/coagents-starter/README.md#2025-04-23_snippet_1

LANGUAGE: sh
CODE:
```
cd agent-js
pnpm install
```

----------------------------------------

TITLE: Starting the Development Server
DESCRIPTION: Launches the development server for the todo list app. This makes the application accessible at http://localhost:3000 for local development and testing.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/(root)/tutorials/ai-todo-app/step-1-checkout-repo.mdx#2025-04-23_snippet_2

LANGUAGE: shell
CODE:
```
npm run dev
```

----------------------------------------

TITLE: Install CopilotKit React Dependencies
DESCRIPTION: Instructions to install the necessary `@copilotkit/react-core` (core library) and `@copilotkit/react-textarea` (textarea component) packages using npm.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/docs/content/docs/direct-to-llm/tutorials/ai-powered-textarea/step-2-setup-copilotkit.mdx#_snippet_0

LANGUAGE: npm
CODE:
```
npm install @copilotkit/react-core @copilotkit/react-textarea
```

----------------------------------------

TITLE: Run Next.js Development Server
DESCRIPTION: This snippet provides commands to start the Next.js development server locally using different package managers. The server will typically run on http://localhost:3000, allowing you to view and interact with your application.

SOURCE: https://github.com/copilotkit/copilotkit/blob/main/CopilotKit/examples/next-pages-router/README.md#_snippet_0

LANGUAGE: bash
CODE:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```