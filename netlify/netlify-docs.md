========================
CODE SNIPPETS
========================
TITLE: Netlify API and CLI Reference
DESCRIPTION: Provides links to comprehensive API and CLI documentation for Netlify. This includes getting started guides, specific deployment guides, client library references, and the full API reference.

SOURCE: https://docs.netlify.com/api-and-cli-guides/cli-guides/get-started-with-cli

LANGUAGE: APIDOC
CODE:
```
Netlify API & CLI Guides:

*   Overview: /api-and-cli-guides/overview/

API Guides:
    *   Get started with API: /api-and-cli-guides/api-guides/get-started-with-api/
    *   Deploy project from a zip file with API: https://developers.netlify.com/videos/deploy-new-build-from-zip-file-using-netlify-api/
    *   Deploy zip file to production: https://developers.netlify.com/guides/deploy-zip-file-to-production-website/
    *   More API guides: https://developers.netlify.com/tag/api/
    *   API reference docs: https://open-api.netlify.com
    *   Go client: https://github.com/netlify/open-api?tab=readme-ov-file#go-client
    *   JS client: https://github.com/netlify/open-api?tab=readme-ov-file#js-client

CLI Guides:
    *   Get started with CLI: /api-and-cli-guides/cli-guides/get-started-with-cli/
    *   Local development: /api-and-cli-guides/cli-guides/local-development/
    *   Manage functions: /api-and-cli-guides/cli-guides/manage-functions/
    *   Debug with VSCode: /api-and-cli-guides/cli-guides/debug-with-vscode/
    *   More CLI guides: https://developers.netlify.com/tag/cli/
    *   CLI reference docs: https://cli.netlify.com
```

----------------------------------------

TITLE: Netlify API and CLI Reference
DESCRIPTION: Provides links to comprehensive API and CLI documentation for Netlify. This includes getting started guides, specific deployment guides, client library references, and the full API reference.

SOURCE: https://docs.netlify.com/api-and-cli-guides/api-guides/get-started-with-api

LANGUAGE: APIDOC
CODE:
```
Netlify API & CLI Guides:

*   Overview: /api-and-cli-guides/overview/

API Guides:
    *   Get started with API: /api-and-cli-guides/api-guides/get-started-with-api/
    *   Deploy project from a zip file with API: https://developers.netlify.com/videos/deploy-new-build-from-zip-file-using-netlify-api/
    *   Deploy zip file to production: https://developers.netlify.com/guides/deploy-zip-file-to-production-website/
    *   More API guides: https://developers.netlify.com/tag/api/
    *   API reference docs: https://open-api.netlify.com
    *   Go client: https://github.com/netlify/open-api?tab=readme-ov-file#go-client
    *   JS client: https://github.com/netlify/open-api?tab=readme-ov-file#js-client

CLI Guides:
    *   Get started with CLI: /api-and-cli-guides/cli-guides/get-started-with-cli/
    *   Local development: /api-and-cli-guides/cli-guides/local-development/
    *   Manage functions: /api-and-cli-guides/cli-guides/manage-functions/
    *   Debug with VSCode: /api-and-cli-guides/cli-guides/debug-with-vscode/
    *   More CLI guides: https://developers.netlify.com/tag/cli/
    *   CLI reference docs: https://cli.netlify.com
```

----------------------------------------

TITLE: Framework Setup Guides Overview
DESCRIPTION: Lists various frontend frameworks and provides links to their specific setup guides within the Starlight documentation. Includes detailed sections for Next.js.

SOURCE: https://docs.netlify.com/build/frameworks/framework-setup-guides/nextjs/legacy-runtime/redirects-and-rewrites

LANGUAGE: markdown
CODE:
```
Frameworks

*   [Frameworks overview](/build/frameworks/overview/)
*   Framework setup guides
    
    *   [Angular](/build/frameworks/framework-setup-guides/angular/)
    *   [Astro](/build/frameworks/framework-setup-guides/astro/)
    *   [Eleventy](/build/frameworks/framework-setup-guides/eleventy/)
    *   [Express](/build/frameworks/framework-setup-guides/express/)
    *   [Gatsby](/build/frameworks/framework-setup-guides/gatsby/)
    *   [Hugo](/build/frameworks/framework-setup-guides/hugo/)
    *   [Hydrogen](/build/frameworks/framework-setup-guides/hydrogen/)
    *   Next.js
        
        *   [Overview](/build/frameworks/framework-setup-guides/nextjs/overview/)
        *   Legacy Runtime
            
            *   [Overview](/build/frameworks/framework-setup-guides/nextjs/legacy-runtime/overview/)
            *   [Upgrading or reverting the Next.js adapter](/build/frameworks/framework-setup-guides/nextjs/legacy-runtime/upgrading-or-reverting-adapter/)
            *   [Middleware](/build/frameworks/framework-setup-guides/nextjs/legacy-runtime/middleware/)
            *   [Redirects and rewrites](/build/frameworks/framework-setup-guides/nextjs/legacy-runtime/redirects-and-rewrites/)
            *   [Advanced API routes](/build/frameworks/framework-setup-guides/nextjs/legacy-runtime/advanced-api-routes/)
            *   [Troubleshooting](/build/frameworks/framework-setup-guides/nextjs/legacy-runtime/troubleshooting/)
            
        
    *   [Nuxt](/build/frameworks/framework-setup-guides/nuxt/)
    *   [React](/build/frameworks/framework-setup-guides/react/)
    *   [React Router](/build/frameworks/framework-setup-guides/react-router/)
    *   [Remix](/build/frameworks/framework-setup-guides/remix/)
    *   [SvelteKit](/build/frameworks/framework-setup-guides/sveltekit/)
```

----------------------------------------

TITLE: Install Netlify CLI Globally
DESCRIPTION: Installs the Netlify CLI globally using npm, making it available from any directory. Requires Node.js version 18.14.0 or later.

SOURCE: https://docs.netlify.com/api-and-cli-guides/cli-guides/get-started-with-cli

LANGUAGE: bash
CODE:
```
npm install -g netlify-cli
```

----------------------------------------

TITLE: Install Netlify CLI in CI
DESCRIPTION: Installs the Netlify CLI as a local development dependency in a project, suitable for CI environments. This ensures a specific version is bound to the repository for reproducible builds.

SOURCE: https://docs.netlify.com/api-and-cli-guides/cli-guides/get-started-with-cli

LANGUAGE: bash
CODE:
```
npm install netlify-cli --save-dev
```

----------------------------------------

TITLE: Deploying Sites with the Netlify API
DESCRIPTION: Guides on programmatically deploying sites to Netlify, covering both new and existing sites. It outlines the two primary methods: file digest and ZIP file uploads, and the initial step of creating a site resource.

SOURCE: https://docs.netlify.com/api-and-cli-guides/api-guides/get-started-with-api

LANGUAGE: APIDOC
CODE:
```
Deploying Sites:
  Two primary methods are supported:
  1. File Digest Method: Upload a digest of files, then upload any missing files.
  2. ZIP File Method: Upload a ZIP archive of the entire site.

  The File Digest method is generally recommended for efficiency.

  Process:
  1. Create a new site (if needed):
     Method: POST
     Endpoint: /api/v1/sites

  2. Create a new deploy for the site:
     - Using File Digest: Refer to file digest method documentation.
     - Using ZIP File: Refer to ZIP file method documentation.
```

----------------------------------------

TITLE: Netlify Deploy: cURL Example for ZIP Upload
DESCRIPTION: Demonstrates how to deploy a site using a ZIP file via the command line using cURL, including necessary headers for authentication and content type.

SOURCE: https://docs.netlify.com/api-and-cli-guides/api-guides/get-started-with-api

LANGUAGE: shell
CODE:
```
curl -H "Content-Type: application/zip" \
     -H "Authorization: Bearer YOUR_OAUTH2_ACCESS_TOKEN" \
     --data-binary "@website.zip" \
     https://api.netlify.com/api/v1/sites/mysite.netlify.app/deploys
```

----------------------------------------

TITLE: Configure WordPress Data Source in Netlify
DESCRIPTION: Steps to prepare a WordPress instance and add it as a data source to Netlify Connect. This involves installing a plugin, generating application passwords, and configuring webhooks for syncing.

SOURCE: https://docs.netlify.com/build/data-and-storage/connect/get-started

LANGUAGE: APIDOC
CODE:
```
WordPress Data Source Configuration:

1.  **Prepare WordPress Instance**:
    *   Install and activate the 'Netlify Connect' WordPress plugin (download from `/assets/netlify-connect-wp-plugin.zip`).
    *   Generate an 'Application Password' in WordPress (under Edit Profile > Application Passwords).
    *   Configure the Netlify Connect plugin settings:
        *   Navigate to **Settings > Netlify Connect**.
        *   Add the Data layer Webhook URL: `https://webhook.netlify-connect.com/hooks/data_layer/data_source/publish/YOUR-DATA-LAYER-ID`.
        *   Replace `YOUR-DATA-LAYER-ID` with your actual data layer ID.
        *   Optionally, use a custom authenticated webhook.
        *   Save changes.
```

----------------------------------------

TITLE: Netlify SDK for Extensions
DESCRIPTION: Information on the Netlify SDK, a JavaScript library designed for building Netlify extensions and integrating with Netlify services programmatically. Includes examples for common extension tasks.

SOURCE: https://docs.netlify.com/api-and-cli-guides/cli-guides/get-started-with-cli

LANGUAGE: APIDOC
CODE:
```
Netlify SDK for Extensions:
  Library: Netlify SDK
  URL: https://developers.netlify.com/sdk
  Description: A JavaScript SDK for building Netlify extensions and interacting with the Netlify API.
  Key Capabilities:
    - Authentication: Handle user authentication within extensions.
    - API Interaction: Make calls to the Netlify API.
    - UI Integration: Extend the Netlify UI with custom panels and components.
  Example Usage:
    import { netlifyAuth } from '@netlify/sdk';

    async function getUserInfo(context) {
      const auth = netlifyAuth(context);
      const user = await auth.getUser();
      return user;
    }
```

----------------------------------------

TITLE: Netlify API Base URL and Request Example
DESCRIPTION: Demonstrates the base URL for Netlify API v1 requests and provides an example using curl to fetch all sites, including necessary headers for User-Agent and Authorization.

SOURCE: https://docs.netlify.com/api-and-cli-guides/api-guides/get-started-with-api

LANGUAGE: APIDOC
CODE:
```
Base URL:
https://api.netlify.com/api/v1/

Example Request:
curl -H "User-Agent: MyApp (YOUR_NAME@EXAMPLE.COM)" \
     -H "Authorization: Bearer YOUR_OAUTH2_ACCESS_TOKEN" \
     https://api.netlify.com/api/v1/sites
```

----------------------------------------

TITLE: Netlify CLI: Get Help
DESCRIPTION: Provides instructions on how to access help documentation for the Netlify CLI. Users can get general usage tips or detailed information about specific commands and sub-commands.

SOURCE: https://docs.netlify.com/api-and-cli-guides/cli-guides/get-started-with-cli

LANGUAGE: APIDOC
CODE:
```
netlify help
  - Description: Displays general usage tips and lists available Netlify CLI commands.

netlify help <command-name>
  - Description: Provides detailed usage information for a specific Netlify CLI command.
  - Parameters:
    - command-name: The name of the command to get help for (e.g., 'deploy', 'sites:create').
  - Example:
    netlify help deploy
    netlify help sites:create
```

----------------------------------------

TITLE: Install @netlify/async-workloads
DESCRIPTION: Install the Async Workloads extension module for your Netlify project using npm, pnpm, or yarn. This module provides the necessary functionality and types for using the extension, especially beneficial for TypeScript projects.

SOURCE: https://docs.netlify.com/build/async-workloads/get-started

LANGUAGE: bash
CODE:
```
npm install @netlify/async-workloads
```

LANGUAGE: bash
CODE:
```
pnpm add @netlify/async-workloads
```

LANGUAGE: bash
CODE:
```
yarn add @netlify/async-workloads
```

----------------------------------------

TITLE: Netlify CLI Environment Variable Commands
DESCRIPTION: Comprehensive guide to Netlify CLI commands for managing environment variables. Covers setting, listing, importing, and cloning variables, with detailed explanations of scopes and deploy contexts.

SOURCE: https://docs.netlify.com/api-and-cli-guides/cli-guides/get-started-with-cli

LANGUAGE: APIDOC
CODE:
```
Netlify CLI Environment Variable Management:

Link Project ID:
  Assign your Netlify Site ID (Project ID) to the NETLIFY_SITE_ID environment variable.

Manage Environment Variables:
  Use the Netlify CLI's `env` command to manage site environment variables.
  Changes made via CLI are reflected in the Netlify UI and require a build/deploy to take effect.

CLI Deploy Context:
  Defaults to `dev` context. Commands use variables set for `dev` or `all` contexts unless specified.
  Use `--context` and `--scope` flags to set contextual or scope values, or filter results.

Create or Update Environment Variables:
  netlify env:set <key> <value> [--scope <scope>] [--context <context>]
    - Sets a single environment variable value.
    - Parameters:
      - key: The name of the environment variable.
      - value: The value to assign to the variable.
      - --scope: (Optional) The scope for the variable (e.g., `builds`, `functions`). Defaults to `all`.
      - --context: (Optional) The deploy context (e.g., `dev`, `production`, `deploy-preview`, `branch:<branch-name>`). Defaults to `all`.
    - If --scope or --context are omitted, the variable is set for all scopes and contexts.
    - Example:
      netlify env:set API_KEY someValue --scope functions --context production
      netlify env:set ANOTHER_API_KEY someValue --scope builds --context dev
    - To set different values for different contexts, run the command multiple times:
      netlify env:set API_KEY someValue --context production deploy-preview
      netlify env:set API_KEY someOtherValue --context branch:staging

Import Environment Variables:
  netlify env:import <filename>
    - Imports environment variables from a specified file (e.g., `.env`).
    - Imported variables are set to all scopes and contexts.
    - Example:
      netlify env:import .env

Clone Environment Variables:
  netlify env:clone --to <destinationSiteId> --from <sourceSiteID>
    - Copies environment variables from a source project to a destination project.
    - Example:
      netlify env:clone --to destinationSiteId --from sourceSiteID

Set Secret Variables:
  netlify env:set <key> <value> [--context <context>] [--secret]
    - Flags a variable value as secret.
    - Example:
      netlify env:set API_KEY someValue --context production --secret

List Environment Variables:
  netlify env:list [--scope <scope>] [--context <context>]
    - Lists environment variables, optionally filtered by scope and context.
    - Example:
      netlify env:list --scope builds --context deploy-preview
```

----------------------------------------

TITLE: Install Node.js Dependencies with npm
DESCRIPTION: Installs project dependencies listed in `package.json` using npm. This command is crucial for ensuring all required packages are available for Node.js function execution.

SOURCE: https://docs.netlify.com/api-and-cli-guides/cli-guides/get-started-with-cli

LANGUAGE: shell
CODE:
```
npm install
```

----------------------------------------

TITLE: Netlify SDK for Extensions
DESCRIPTION: Information on the Netlify SDK, designed for building extensions and integrating with Netlify's platform programmatically.

SOURCE: https://docs.netlify.com/api-and-cli-guides/api-guides/get-started-with-api

LANGUAGE: APIDOC
CODE:
```
Netlify SDK for Extensions:
  Description: SDK for developing Netlify extensions and integrations.
  Documentation: https://developers.netlify.com/sdk

Key Features:
  - Authentication helpers
  - API client for Netlify services
  - Event handling for Netlify events

Example Use Cases:
  - Creating custom build plugins.
  - Building Netlify UI extensions.
  - Automating Netlify workflows.
```

----------------------------------------

TITLE: Install Node.js Dependencies with Yarn
DESCRIPTION: Installs project dependencies listed in `package.json` using Yarn. This serves as an alternative to npm for managing Node.js project dependencies.

SOURCE: https://docs.netlify.com/api-and-cli-guides/cli-guides/get-started-with-cli

LANGUAGE: shell
CODE:
```
yarn
```

----------------------------------------

TITLE: Netlify Connect UI Entry Point
DESCRIPTION: Reference to the Netlify UI page for managing Connect features, specifically for accessing the Connect page for a given team.

SOURCE: https://docs.netlify.com/build/data-and-storage/connect/get-started

LANGUAGE: APIDOC
CODE:
```
Netlify Connect UI:
  Endpoint: /teams/{team_name}/connect
  Description: The primary page in the Netlify UI for managing Connect features, including data layers, data sources, and site connections.
  Parameters:
    - team_name: The unique identifier for your Netlify team.
  Usage:
    Access this URL in your browser to navigate to the Connect dashboard for your team.
  Notes:
    This URL is used in the Netlify UI and may be dynamically resolved by client-side scripts.
```

----------------------------------------

TITLE: Check Netlify CLI Version and Info
DESCRIPTION: Runs the Netlify CLI to display its version and basic information.

SOURCE: https://docs.netlify.com/api-and-cli-guides/cli-guides/get-started-with-cli

LANGUAGE: bash
CODE:
```
netlify
```

----------------------------------------

TITLE: Salesforce Commerce Cloud API Client Setup
DESCRIPTION: Requirements for setting up an API Client in Salesforce Account Manager for Netlify Connect integration. This involves specific scopes and noting API credentials.

SOURCE: https://docs.netlify.com/build/data-and-storage/connect/get-started

LANGUAGE: APIDOC
CODE:
```
SalesforceAdminAPIClient:
  Purpose: Enable Netlify Connect to sync product data using the Salesforce Admin API.
  Setup: Follow Salesforce instructions for creating an API Client in Account Manager.
  Required Scopes:
    - `sfcc.products`: Grants access to product data.
    - `sfcc.catalogs`: Grants access to catalog data.
  Credentials to Note:
    - API Client ID: Unique identifier for the client (e.g., `1d763261-6522-4913-9d52-5d947d3b94c4`).
    - Client Secret: The password set for the API Client.
```

----------------------------------------

TITLE: Netlify CLI Reference
DESCRIPTION: Documentation for the Netlify Command Line Interface (CLI), used for deploying sites, managing Netlify projects locally, and interacting with Netlify services.

SOURCE: https://docs.netlify.com/api-and-cli-guides/api-guides/get-started-with-api

LANGUAGE: APIDOC
CODE:
```
Netlify CLI:
  Description: Command-line interface for Netlify.
  Documentation: https://cli.netlify.com

Common Commands:
  netlify deploy
    Deploys your site to Netlify.

  netlify dev
    Starts a local development server with Netlify features.

  netlify login
    Logs you into your Netlify account.

  netlify status
    Shows the status of your Netlify project.
```

----------------------------------------

TITLE: Netlify Deploy API: Create Site and Deploy
DESCRIPTION: Combines site creation and initial deployment into a single API request, supporting either file digest or ZIP file methods.

SOURCE: https://docs.netlify.com/api-and-cli-guides/api-guides/get-started-with-api

LANGUAGE: APIDOC
CODE:
```
POST /api/v1/sites

Headers:
- Content-Type: application/zip (or application/json for file digest)
- Authorization: Bearer YOUR_OAUTH2_ACCESS_TOKEN

Body:
ZIP file contents OR JSON with file digest

Description:
- Creates a new site and deploys it in one step.
- Example shown uses ZIP file upload.
```

----------------------------------------

TITLE: Netlify CLI Site Initialization and Linking
DESCRIPTION: Commands to connect your local project to Netlify. Use `netlify link` to associate with an existing Netlify site or `netlify init` to set up continuous deployment for new projects.

SOURCE: https://docs.netlify.com/api-and-cli-guides/cli-guides/get-started-with-cli

LANGUAGE: bash
CODE:
```
# Link a local project to an existing Netlify site
netlify link

# Initialize a new Netlify project for continuous deployment (automated setup for GitHub)
netlify init

# Initialize a new Netlify project manually for other Git providers or specific GitHub access
netlify init --manual
```

----------------------------------------

TITLE: Netlify API and CLI Reference
DESCRIPTION: Provides links to comprehensive API and CLI documentation for Netlify. This includes getting started guides, specific deployment guides, client library references, and the full API reference.

SOURCE: https://docs.netlify.com/api-and-cli-guides/cli-guides/manage-functions

LANGUAGE: APIDOC
CODE:
```
Netlify API & CLI Guides:

*   Overview: /api-and-cli-guides/overview/

API Guides:
    *   Get started with API: /api-and-cli-guides/api-guides/get-started-with-api/
    *   Deploy project from a zip file with API: https://developers.netlify.com/videos/deploy-new-build-from-zip-file-using-netlify-api/
    *   Deploy zip file to production: https://developers.netlify.com/guides/deploy-zip-file-to-production-website/
    *   More API guides: https://developers.netlify.com/tag/api/
    *   API reference docs: https://open-api.netlify.com
    *   Go client: https://github.com/netlify/open-api?tab=readme-ov-file#go-client
    *   JS client: https://github.com/netlify/open-api?tab=readme-ov-file#js-client

CLI Guides:
    *   Get started with CLI: /api-and-cli-guides/cli-guides/get-started-with-cli/
    *   Local development: /api-and-cli-guides/cli-guides/local-development/
    *   Manage functions: /api-and-cli-guides/cli-guides/manage-functions/
    *   Debug with VSCode: /api-and-cli-guides/cli-guides/debug-with-vscode/
    *   More CLI guides: https://developers.netlify.com/tag/cli/
    *   CLI reference docs: https://cli.netlify.com
```

----------------------------------------

TITLE: Netlify SDK for Extensions
DESCRIPTION: Information on the Netlify SDK, designed for building extensions and integrating with Netlify's platform programmatically.

SOURCE: https://docs.netlify.com/build/async-workloads/get-started

LANGUAGE: APIDOC
CODE:
```
Netlify SDK for Extensions:
  Description: SDK for developing Netlify extensions and integrations.
  Documentation: https://developers.netlify.com/sdk

Key Features:
  - Authentication helpers
  - API client for Netlify services
  - Event handling for Netlify events

Example Use Cases:
  - Creating custom build plugins.
  - Building Netlify UI extensions.
  - Automating Netlify workflows.
```

----------------------------------------

TITLE: Netlify CLI Reference
DESCRIPTION: Documentation for the Netlify Command Line Interface (CLI), used for deploying sites, managing Netlify projects locally, and interacting with Netlify services.

SOURCE: https://docs.netlify.com/build/async-workloads/get-started

LANGUAGE: APIDOC
CODE:
```
Netlify CLI:
  Description: Command-line interface for Netlify.
  Documentation: https://cli.netlify.com

Common Commands:
  netlify deploy
    Deploys your site to Netlify.

  netlify dev
    Starts a local development server with Netlify features.

  netlify login
    Logs you into your Netlify account.

  netlify status
    Shows the status of your Netlify project.
```

----------------------------------------

TITLE: Netlify API and CLI Reference Documentation
DESCRIPTION: Provides links to comprehensive API and CLI reference documentation for Netlify. This includes guides for getting started, specific deployment tasks, and links to client libraries.

SOURCE: https://docs.netlify.com/api-and-cli-guides/cli-guides/local-development

LANGUAGE: APIDOC
CODE:
```
Netlify API Reference:
  URL: https://open-api.netlify.com
  Description: Official OpenAPI specification and reference documentation for the Netlify API.

Netlify API Client Libraries:
  Go Client:
    Repository: https://github.com/netlify/open-api
    Section: README.md#go-client
    Description: Client library for interacting with the Netlify API using Go.
  JS Client:
    Repository: https://github.com/netlify/open-api
    Section: README.md#js-client
    Description: Client library for interacting with the Netlify API using JavaScript.

Netlify CLI Reference:
  URL: https://cli.netlify.com
  Description: Official documentation for the Netlify Command Line Interface, covering installation, usage, and commands.

Related Netlify Guides:
  API Guides:
    - Get started with API: /api-and-cli-guides/api-guides/get-started-with-api/
    - Deploy project from a zip file with API: https://developers.netlify.com/videos/deploy-new-build-from-zip-file-using-netlify-api/
    - Deploy zip file to production: https://developers.netlify.com/guides/deploy-zip-file-to-production-website/
    - More API guides: https://developers.netlify.com/tag/api/
  CLI Guides:
    - Get started with CLI: /api-and-cli-guides/cli-guides/get-started-with-cli/
    - Local development: /api-and-cli-guides/cli-guides/local-development/
    - Manage functions: /api-and-cli-guides/cli-guides/manage-functions/
    - Debug with VSCode: /api-and-cli-guides/cli-guides/debug-with-vscode/
    - More CLI guides: https://developers.netlify.com/tag/cli/
```

----------------------------------------

TITLE: Netlify Frameworks API
DESCRIPTION: Details on the API for integrating custom frameworks with Netlify's build system, enabling framework-specific optimizations and configurations.

SOURCE: https://docs.netlify.com/api-and-cli-guides/api-guides/get-started-with-api

LANGUAGE: APIDOC
CODE:
```
Netlify Frameworks API:
  Description: API for framework adapters to integrate with Netlify builds.
  Documentation: /build/frameworks/frameworks-api

Purpose:
  Allows frameworks to define build commands, asset bundling, and deployment configurations.

Key Concepts:
  - Framework Adapters: Code that bridges a specific framework to Netlify's build process.
  - Build Configuration: Defining how Netlify should build and deploy a project using a specific framework.
```

----------------------------------------

TITLE: Netlify API Reference
DESCRIPTION: Provides access to the comprehensive Netlify API for programmatic interaction with Netlify resources. This includes endpoints for managing sites, deploys, domains, functions, and more.

SOURCE: https://docs.netlify.com/api-and-cli-guides/cli-guides/get-started-with-cli

LANGUAGE: APIDOC
CODE:
```
Netlify API:
  URL: https://open-api.netlify.com
  Description: Comprehensive API for managing Netlify sites, deploys, domains, users, billing, and more.
  Key Areas:
    - Site Management: Create, read, update, delete sites.
    - Deploy Management: Trigger deploys, retrieve deploy status, manage deploy contexts.
    - Domain Management: Add, configure, and manage custom domains.
    - Function Management: Deploy and manage serverless functions.
    - User & Team Management: Control access and team settings.
    - Webhooks: Configure and manage webhooks for events.
  Authentication: API key or OAuth 2.0.
```

----------------------------------------

TITLE: Netlify CLI: Perform Production Deploy
DESCRIPTION: Explains how to execute a production deploy to the main site URL using the `--prod` flag (or its shorthand `-p`) with the `netlify deploy` command.

SOURCE: https://docs.netlify.com/api-and-cli-guides/cli-guides/get-started-with-cli

LANGUAGE: shell
CODE:
```
netlify deploy --prod
```

----------------------------------------

TITLE: Google Tag Manager and Analytics Setup
DESCRIPTION: Configures Google Tag Manager (GTM) and Google Analytics (GA) by dynamically injecting script tags into the document. It initializes GTM with 'GTM-NMKKF2M' and GA with 'G-X2FMMZSSS9', ensuring proper tracking setup.

SOURCE: https://docs.netlify.com/api-and-cli-guides/api-guides/get-started-with-api

LANGUAGE: javascript
CODE:
```
(function(){const id = "GTM-NMKKF2M"; (function (w, d, s, l, i) { w[l] = w[l] || []; w[l].push({ 'gtm.start': new Date().getTime(), event: 'gtm.js' }); var f = d.getElementsByTagName(s)[0], j = d.createElement(s), dl = l != 'dataLayer' ? '&l=' + l : ''; j.async = true; j.src = 'https://www.googletagmanager.com/gtm.js?id=' + i + dl; f.parentNode.insertBefore(j, f); })(window, document, 'script', 'dataLayer', id); })();(function(){const id = "G-X2FMMZSSS9"; function gtag(){dataLayer.push(arguments);} gtag('js', new Date()); gtag('config', id); })();
```

----------------------------------------

TITLE: Netlify TOML Plugin Inputs Configuration Example
DESCRIPTION: An example of how to configure plugin inputs in the `netlify.toml` file when installing a plugin. This allows users to provide specific values for plugin options.

SOURCE: https://docs.netlify.com/extend/develop-and-share/develop-build-plugins

LANGUAGE: toml
CODE:
```
[[plugins]]
package = "./plugins/netlify-plugin-lighthouse"

  [plugins.inputs]
  output_path = "reports/lighthouse.html"
  fail_deploy_on_score_thresholds = "true"

  [plugins.inputs.thresholds]
  performance = 0.9
  accessibility = 0.9
  "best-practices" = 0.9
  seo = 0.9
  pwa = 0.9
```

----------------------------------------

TITLE: Send Event with AsyncWorkloadsClient (JavaScript)
DESCRIPTION: Example of a Netlify serverless function written in JavaScript that triggers an asynchronous workload. It instantiates the AsyncWorkloadsClient and sends a 'say-hello' event.

SOURCE: https://docs.netlify.com/build/async-workloads/get-started

LANGUAGE: javascript
CODE:
```
import { AsyncWorkloadsClient } from "@netlify/async-workloads";
export default async (req) => {
  // do some work... authenticate the user, pull data, etc.
  const client = new AsyncWorkloadsClient();
  await client.send('say-hello');
  return new Response('', { status: 200 });
};
export const config = {
  path: '/say-hey'
}
```

----------------------------------------

TITLE: Install and Run Netlify CLI for Local Testing
DESCRIPTION: Commands to install the Netlify CLI globally and launch the Netlify Dev environment. This setup allows for local testing of edge functions, simulating deployment conditions.

SOURCE: https://docs.netlify.com/build/edge-functions/get-started

LANGUAGE: shell
CODE:
```
npm install netlify-cli -g
```

LANGUAGE: shell
CODE:
```
netlify dev
```

----------------------------------------

TITLE: Netlify API Reference
DESCRIPTION: Provides access to the Netlify API for programmatic interaction with Netlify resources. This includes endpoints for managing sites, deploys, domains, functions, and more.

SOURCE: https://docs.netlify.com/api-and-cli-guides/api-guides/get-started-with-api

LANGUAGE: APIDOC
CODE:
```
Netlify API:
  Description: Comprehensive RESTful API for managing Netlify sites and resources.
  Base URL: https://open-api.netlify.com

Key Resources:
  - Sites: Manage your Netlify sites, including creation, configuration, and deployment.
  - Deploys: Interact with site deployments, retrieve deploy logs, and manage deploy status.
  - Domains: Configure custom domains for your sites.
  - Functions: Manage serverless and edge functions.
  - Blobs: Access and manage Netlify Blobs storage.
  - Cache: Interact with Netlify's caching mechanisms.

Example Usage:
  GET /sites
    Retrieves a list of all sites associated with the authenticated user.

  POST /sites/{site_id}/deploys
    Creates a new deploy for a specified site.

  GET /functions
    Lists all serverless functions for a site.

  GET /blobs/{bucket_id}/{key}
    Retrieves a specific blob from a bucket.
```

----------------------------------------

TITLE: Netlify Frameworks API
DESCRIPTION: Details the API for integrating and building framework adapters for Netlify. This allows frameworks to leverage Netlify's build system and features effectively.

SOURCE: https://docs.netlify.com/api-and-cli-guides/cli-guides/get-started-with-cli

LANGUAGE: APIDOC
CODE:
```
Frameworks API:
  Path: /build/frameworks/frameworks-api
  Description: API for creating and managing framework adapters for Netlify builds.
  Purpose: Enables frameworks to define build processes, asset handling, and deployment configurations within Netlify.
  Key Components:
    - Adapter Configuration: Define how a framework is built and deployed.
    - Build Hooks: Integrate custom build steps.
    - Asset Optimization: Specify rules for asset processing.
```

----------------------------------------

TITLE: Initialize and Configure Pagefind
DESCRIPTION: Initializes Pagefind and merges search indexes from multiple Netlify sites (docs, www, developers). It configures index weights and ranking parameters for each site.

SOURCE: https://docs.netlify.com/api-and-cli-guides/cli-guides/get-started-with-cli

LANGUAGE: javascript
CODE:
```
(async function () { try { window.pagefind = await import('https://docs.netlify.com/pagefind/pagefind.js'); await window.pagefind.options({ mergeFilter: { site: 'docs', }, indexWeight: 2, ranking: { termFrequency: 0.2, termSimilarity: 1, termSaturation: 1, }, }); await window.pagefind.mergeIndex('https://www.netlify.com/pagefind', { mergeFilter: { site: 'www', }, indexWeight: 1, ranking: { termFrequency: 0.2, termSimilarity: 1, termSaturation: 1, }, }); await window.pagefind.mergeIndex('https://developers.netlify.com/pagefind', { mergeFilter: { site: 'developers', }, indexWeight: 1, ranking: { termFrequency: 0.2, termSimilarity: 1, termSaturation: 1, }, }); } catch (error) { console.error('Error fetching pagefind:', error); } })();
```

----------------------------------------

TITLE: Netlify API and CLI Reference
DESCRIPTION: Provides links to comprehensive API and CLI documentation for Netlify. This includes getting started guides, specific deployment guides, client library references, and the full API reference.

SOURCE: https://docs.netlify.com/api-and-cli-guides/cli-guides/debug-with-vscode

LANGUAGE: APIDOC
CODE:
```
Netlify API & CLI Guides:

*   Overview: /api-and-cli-guides/overview/

API Guides:
    *   Get started with API: /api-and-cli-guides/api-guides/get-started-with-api/
    *   Deploy project from a zip file with API: https://developers.netlify.com/videos/deploy-new-build-from-zip-file-using-netlify-api/
    *   Deploy zip file to production: https://developers.netlify.com/guides/deploy-zip-file-to-production-website/
    *   More API guides: https://developers.netlify.com/tag/api/
    *   API reference docs: https://open-api.netlify.com
    *   Go client: https://github.com/netlify/open-api?tab=readme-ov-file#go-client
    *   JS client: https://github.com/netlify/open-api?tab=readme-ov-file#js-client

CLI Guides:
    *   Get started with CLI: /api-and-cli-guides/cli-guides/get-started-with-cli/
    *   Local development: /api-and-cli-guides/cli-guides/local-development/
    *   Manage functions: /api-and-cli-guides/cli-guides/manage-functions/
    *   Debug with VSCode: /api-and-cli-guides/cli-guides/debug-with-vscode/
    *   More CLI guides: https://developers.netlify.com/tag/cli/
    *   CLI reference docs: https://cli.netlify.com
```

----------------------------------------

TITLE: Netlify API Reference
DESCRIPTION: Provides access to the Netlify API for programmatic interaction with Netlify resources. This includes endpoints for managing sites, deploys, domains, functions, and more.

SOURCE: https://docs.netlify.com/build/async-workloads/get-started

LANGUAGE: APIDOC
CODE:
```
Netlify API:
  Description: Comprehensive RESTful API for managing Netlify sites and resources.
  Base URL: https://open-api.netlify.com

Key Resources:
  - Sites: Manage your Netlify sites, including creation, configuration, and deployment.
  - Deploys: Interact with site deployments, retrieve deploy logs, and manage deploy status.
  - Domains: Configure custom domains for your sites.
  - Functions: Manage serverless and edge functions.
  - Blobs: Access and manage Netlify Blobs storage.
  - Cache: Interact with Netlify's caching mechanisms.

Example Usage:
  GET /sites
    Retrieves a list of all sites associated with the authenticated user.

  POST /sites/{site_id}/deploys
    Creates a new deploy for a specified site.

  GET /functions
    Lists all serverless functions for a site.

  GET /blobs/{bucket_id}/{key}
    Retrieves a specific blob from a bucket.
```

----------------------------------------

TITLE: Netlify Frameworks API
DESCRIPTION: Details on the API for integrating custom frameworks with Netlify's build system, enabling framework-specific optimizations and configurations.

SOURCE: https://docs.netlify.com/build/async-workloads/get-started

LANGUAGE: APIDOC
CODE:
```
Netlify Frameworks API:
  Description: API for framework adapters to integrate with Netlify builds.
  Documentation: /build/frameworks/frameworks-api

Purpose:
  Allows frameworks to define build commands, asset bundling, and deployment configurations.

Key Concepts:
  - Framework Adapters: Code that bridges a specific framework to Netlify's build process.
  - Build Configuration: Defining how Netlify should build and deploy a project using a specific framework.
```

----------------------------------------

TITLE: Netlify API Authentication
DESCRIPTION: Explains Netlify's OAuth2 authentication mechanism. It guides users on generating a Personal Access Token (PAT) through the Netlify user interface.

SOURCE: https://docs.netlify.com/api-and-cli-guides/api-guides/get-started-with-api

LANGUAGE: APIDOC
CODE:
```
Authentication Method:
OAuth2

Procedure for Personal Access Token (PAT):
1. Navigate to Netlify User Settings: [**Applications > Personal access tokens**](https://app.netlify.com/user/applications#personal-access-tokens)
2. Select **New access token**.
```

----------------------------------------

TITLE: Contentful Webhook Setup for Netlify Connect
DESCRIPTION: Configure a webhook in Contentful to notify Netlify Connect about data changes. This involves providing the Netlify webhook URL and specifying which content types and events should trigger a sync.

SOURCE: https://docs.netlify.com/build/data-and-storage/connect/get-started

LANGUAGE: APIDOC
CODE:
```
Webhook Configuration:
  - Navigate to Contentful web app: Settings > Webhooks > Add webhook.
  - URL Field:
    - Enter the Netlify webhook URL: https://webhook.netlify-connect.com/hooks/data_layer/data_source/publish/YOUR-DATA-LAYER-ID
    - Replace YOUR-DATA-LAYER-ID with your specific data layer ID.
  - Triggers:
    - Select content types to sync.
    - Select events (e.g., content creation, update, deletion) that should trigger a sync.
  - Custom Authenticated Webhook:
    - Option to create a custom authenticated webhook instead of the default.
  - API Configuration (if using Contentful API):
    - Add header: x-connect-data-source
    - Header Value: contentful
    - Purpose: Ensures webhook triggers syncs only for this specific data source.
```

----------------------------------------

TITLE: Netlify Deploy API: ZIP File Method
DESCRIPTION: Deploys a site by uploading a single ZIP archive containing all site files. This method is suitable for smaller sites or when a ZIP archive is readily available.

SOURCE: https://docs.netlify.com/api-and-cli-guides/api-guides/get-started-with-api

LANGUAGE: APIDOC
CODE:
```
POST /api/v1/sites/{site_id}/deploys

Headers:
- Content-Type: application/zip
- Authorization: Bearer YOUR_OAUTH2_ACCESS_TOKEN

Body:
ZIP file contents

Description:
- Uploads a ZIP file directly as the request body.
- A limit of 25,000 files per ZIP extraction applies.
- The deploy enters post-processing immediately after creation.
```

----------------------------------------

TITLE: Send Event with AsyncWorkloadsClient (TypeScript)
DESCRIPTION: Example of a Netlify serverless function written in TypeScript that triggers an asynchronous workload. It instantiates the AsyncWorkloadsClient and sends a 'say-hello' event.

SOURCE: https://docs.netlify.com/build/async-workloads/get-started

LANGUAGE: typescript
CODE:
```
import type {Config} from "@netlify/functions";
import { AsyncWorkloadsClient } from "@netlify/async-workloads";
export default async (req: Request) => {
  // do some work... authenticate the user, pull data, etc.
  const client = new AsyncWorkloadsClient();
  await client.send('say-hello');
  return new Response('', { status: 200 });
};
export const config: Config = {
  path: '/say-hey'
}
```

----------------------------------------

TITLE: Netlify API Clients and Integrations
DESCRIPTION: Lists available API clients and integration options for interacting with the Netlify API. This includes official client libraries and third-party tools.

SOURCE: https://docs.netlify.com/api-and-cli-guides/api-guides/get-started-with-api

LANGUAGE: APIDOC
CODE:
```
Official Clients:
- Go Client: https://github.com/netlify/open-api#go-client
- JS Client: https://github.com/netlify/build/tree/main/packages/js-client

No-Code Integration:
- n8n.io Netlify node: https://n8n.io/integrations/netlify/
  Supported Operations:
  - Create a new deployment
  - Get a deployment
  - Get all deployments
  - Cancel a deployment
  - Get a site
  - Get all sites
  - Delete a site
```

----------------------------------------

TITLE: Netlify Build Commands
DESCRIPTION: Execute local builds using the Netlify CLI to mimic production build behavior. Supports various flags for dry runs and specific deploy contexts.

SOURCE: https://docs.netlify.com/api-and-cli-guides/cli-guides/get-started-with-cli

LANGUAGE: bash
CODE:
```
netlify build
# Builds your project using environment variables set in netlify.toml or via Netlify UI/CLI/API.

netlify build --dry
# Outputs a list of build stages and behaviors without performing a full build.

netlify build --context deploy-preview
# Runs the build as if it were a Deploy Preview, applying context-specific settings and environment variables.
```

----------------------------------------

TITLE: Netlify API OpenAPI Reference
DESCRIPTION: Provides a direct link to the OpenAPI specification for the Netlify API, allowing developers to explore all available endpoints and their details.

SOURCE: https://docs.netlify.com/api-and-cli-guides/api-guides/get-started-with-api

LANGUAGE: APIDOC
CODE:
```
OpenAPI Reference:
https://open-api.netlify.com
```

----------------------------------------

TITLE: Netlify Builder: Hello World Example
DESCRIPTION: Demonstrates a basic Netlify On-demand Builder function that returns a simple 'Hello World' HTML page. This example shows how to set up a handler and use the builder utility for serverless functions that generate static content.

SOURCE: https://docs.netlify.com/build/configure-builds/on-demand-builders

LANGUAGE: TypeScript
CODE:
```
import { builder, type Handler } from "@netlify/functions";

const myHandler: Handler = async (event, context) => {
  return {
    statusCode: 200,
    headers: {
      "Content-Type": "text/html",
    },
    body: `<!DOCTYPE html> <html> <body> Hello World </body> </html>`,
  };
};

const handler = builder(myHandler);

export { handler };
```

LANGUAGE: JavaScript
CODE:
```
const { builder } = require("@netlify/functions")

async function handler(event, context) {
  return {
    statusCode: 200,
    headers: {
      "Content-Type": "text/html",
    },
    body: `    <!DOCTYPE html>      <html>        <body>          Hello World        </body>    </html>    `,
  };
}

exports.handler = builder(handler);
```

----------------------------------------

TITLE: Authenticate with Netlify CLI
DESCRIPTION: Initiates the authentication process for the Netlify CLI. This command opens a browser window to authorize access to Netlify and stores the access token in a global configuration file.

SOURCE: https://docs.netlify.com/api-and-cli-guides/cli-guides/get-started-with-cli

LANGUAGE: bash
CODE:
```
netlify login
```

----------------------------------------

TITLE: Netlify API: Deploy Operations
DESCRIPTION: Manage and retrieve deploy information for a Netlify site. Includes listing all deploys, fetching a specific deploy, and restoring previous deploys.

SOURCE: https://docs.netlify.com/api-and-cli-guides/api-guides/get-started-with-api

LANGUAGE: APIDOC
CODE:
```
GET /api/v1/sites/{site_id}/deploys
  Retrieves a list of all deploys for a specific Netlify site.
  Parameters:
    - site_id: The unique identifier for the Netlify site.
  Returns:
    - An array of deploy objects, each containing details like id, name, url, state, and timestamps.
  Example Response:
    [
      {
        "id": "52465f435803544542000001",
        "premium": false,
        "claimed": true,
        "name": "synergy",
        "custom_domain": "www.example.com",
        "notification_email": "me@example.com",
        "url": "http://www.example.com",
        "deploy_url": "http://52465f435803544542000001.some-site.netlify.app",
        "admin_url": "https://api.netlify.com/sites/synergy",
        "screenshot_url": null,
        "created_at": "2013-09-17T05:13:08Z",
        "updated_at": "2013-09-17T05:13:19Z",
        "user_id": "51f60d2d5803545326000005",
        "state": "old"
      }
    ]

GET /api/v1/sites/{site_id}/deploys/{deploy_id}
  Retrieves details for a specific deploy.
  Parameters:
    - site_id: The unique identifier for the Netlify site.
    - deploy_id: The unique identifier for the deploy.
  Returns:
    - A single deploy object with detailed information.
  Example Response:
    {
      "id": "52465f435803544542000001",
      "premium": false,
      "claimed": true,
      "name": "synergy",
      "custom_domain": "www.example.com",
      "notification_email": "me@example.com",
      "url": "http://www.example.com",
      "deploy_url": "http://52465f435803544542000001.some-site.netlify.app",
      "admin_url": "https://api.netlify.com/sites/synergy",
      "screenshot_url": null,
      "created_at": "2013-09-17T05:13:08Z",
      "updated_at": "2013-09-17T05:13:19Z",
      "user_id": "51f60d2d5803545326000005",
      "state": "old"
    }

POST /api/v1/sites/{site_id}/deploys/{deploy_id}/restore
  Restores a previous deploy, making it the live version of the site (rollback).
  Parameters:
    - site_id: The unique identifier for the Netlify site.
    - deploy_id: The unique identifier for the deploy to restore.
  Returns:
    - The restored deploy object, with its state updated to 'current'.
  Example Response:
    {
      "id": "52465f435803544542000001",
      "premium": false,
      "claimed": true,
      "name": "synergy",
      "custom_domain": "www.example.com",
      "notification_email": "me@example.com",
      "url": "http://www.example.com",
      "deploy_url": "http://52465f435803544542000001.some-site.netlify.app",
      "admin_url": "https://api.netlify.com/sites/synergy",
      "screenshot_url": null,
      "created_at": "2013-09-17T05:13:08Z",
      "updated_at": "2013-09-17T05:13:19Z",
      "user_id": "51f60d2d5803545326000005",
      "state": "current"
    }
```