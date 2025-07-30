# MCP Setup for Claude Code - Simple Steps

## Basic Setup

### Step 1: Add a Local Server
```bash
claude mcp add my-server /path/to/server
```

### Step 2: Add Server with Environment Variables
```bash
claude mcp add my-server -e API_KEY=123 -- /path/to/server arg1 arg2
```

### Step 3: Add SSE Server
```bash
claude mcp add --transport sse sse-server https://example.com/sse-endpoint
```

### Step 4: Add HTTP Server
```bash
claude mcp add --transport http http-server https://example.com/mcp
```

### Step 5: Add Server with Authentication
```bash
claude mcp add --transport http secure-server https://api.example.com/mcp --header "Authorization: Bearer your-token"
```

## Management Commands

### List All Servers
```bash
claude mcp list
```

### Get Server Details
```bash
claude mcp get my-server
```

### Remove a Server
```bash
claude mcp remove my-server
```

### Check Server Status
```bash
/mcp
```

## Scope Options

### Local Scope (default)
```bash
claude mcp add my-server -s local /path/to/server
```

### Project Scope (shared team)
```bash
claude mcp add shared-server -s project /path/to/server
```

### User Scope (all projects)
```bash
claude mcp add my-tool -s user /path/to/server
```

## Authentication

### Authenticate Remote Servers
1. Add server: `claude mcp add --transport sse github-server https://api.github.com/mcp`
2. In Claude Code, run: `/mcp`
3. Select "Authenticate" and complete OAuth flow

## Database Example

### Add Postgres Server
```bash
claude mcp add postgres-server /path/to/postgres-mcp-server --connection-string "postgresql://user:pass@localhost:5432/mydb"
```

### Query Database
```
> describe the schema of our users table
> what are the most recent orders?
```

## Import/Export

### Import from JSON
```bash
claude mcp add-json weather-api '{"type":"stdio","command":"/path/to/weather-cli","args":["--api-key","abc123"]}'
```

### Import from Claude Desktop
```bash
claude mcp add-from-claude-desktop
```

### Use Claude as MCP Server
```bash
claude mcp serve
```

## Usage

### Reference Resources
```
> Analyze @github:issue://123
> Review @docs:file://api/auth
```

### Use MCP Prompts as Commands
```
> /mcp__github__list_prs
> /mcp__github__pr_review 456
```

## Troubleshooting

### Set Timeout
```bash
MCP_TIMEOUT=10000 claude
```

### Windows Fix (use cmd wrapper)
```bash
claude mcp add my-server -- cmd /c npx -y @some/package
```

### Reset Authentication
```bash
claude mcp reset-project-choices
```

### Debug Mode
```bash
claude --mcp-debug
```

