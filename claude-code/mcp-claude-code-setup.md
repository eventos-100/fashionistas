# MCP (Model Context Protocol) Setup Guide for Claude Code

> Complete step-by-step guide to configure MCP with Claude Code for enhanced functionality.

## Table of Contents

1. [Understanding MCP](#understanding-mcp)
2. [Server Configuration Steps](#server-configuration-steps)
3. [Authentication Setup](#authentication-setup)
4. [Database Integration](#database-integration)
5. [Advanced Configuration](#advanced-configuration)
6. [Usage and Testing](#usage-and-testing)
7. [Troubleshooting](#troubleshooting)

---

## Understanding MCP

**Model Context Protocol (MCP)** is an open protocol that enables LLMs to access external tools and data sources. It follows a client-server architecture where Claude Code acts as the client connecting to specialized servers.

### Key Benefits
- Access external APIs and databases
- Integrate with third-party services
- Extend Claude Code capabilities
- Enable real-time data access

⚠️ **Security Warning**: Use third-party MCP servers at your own risk. Be especially careful with internet-connected servers due to prompt injection risks.

---

## Server Configuration Steps

### Step 1: Add MCP stdio Server
**Purpose:** Basic local server setup for command-line tools

**Command:**
```bash
claude mcp add <server-name> <command> [args...]
```

**Example:**
```bash
# Basic server addition
claude mcp add my-server /path/to/server arg1 arg2

# Server with environment variables
claude mcp add my-server -e API_KEY=123 -- /path/to/server arg1 arg2
```

**Tasks:**
- [ ] Identify server executable path
- [ ] Configure necessary environment variables
- [ ] Test server connection
- [ ] Verify server arguments

### Step 2: Add MCP SSE Server
**Purpose:** Server-Sent Events for real-time communication

**Command:**
```bash
claude mcp add --transport sse <server-name> <url>
```

**Examples:**
```bash
# Basic SSE server
claude mcp add --transport sse sse-server https://example.com/sse-endpoint

# SSE server with authentication
claude mcp add --transport sse api-server https://api.example.com/mcp --header "X-API-Key: your-key"
```

**Tasks:**
- [ ] Verify SSE endpoint URL
- [ ] Configure authentication headers
- [ ] Test real-time connectivity
- [ ] Monitor connection stability

### Step 3: Add MCP HTTP Server
**Purpose:** HTTP-based streamable server integration

**Command:**
```bash
claude mcp add --transport http <server-name> <url>
```

**Examples:**
```bash
# Basic HTTP server
claude mcp add --transport http http-server https://example.com/mcp

# HTTP server with Bearer token
claude mcp add --transport http secure-server https://api.example.com/mcp --header "Authorization: Bearer your-token"
```

**Tasks:**
- [ ] Configure HTTP endpoint
- [ ] Set up authentication tokens
- [ ] Test HTTP connectivity
- [ ] Verify API responses

### Step 4: Manage MCP Servers
**Purpose:** Monitor and maintain server configurations

**Commands:**
```bash
# List all configured servers
claude mcp list

# Get details for specific server
claude mcp get <server-name>

# Remove a server
claude mcp remove <server-name>
```

**Tasks:**
- [ ] Regular server health checks
- [ ] Monitor server performance
- [ ] Update server configurations
- [ ] Clean up unused servers

---

## Server Scope Configuration

### Understanding Scopes

**Scope Hierarchy (highest to lowest priority):**
1. **Local** (default) - Project-specific, private to you
2. **Project** - Shared via `.mcp.json`, team accessible
3. **User** - Cross-project, private to your account

### Local Scope Setup
**Use Case:** Personal development, experimental configs, sensitive credentials

**Commands:**
```bash
# Add local-scoped server (default)
claude mcp add my-private-server /path/to/server

# Explicitly specify local scope
claude mcp add my-private-server -s local /path/to/server
```

**Tasks:**
- [ ] Configure personal development servers
- [ ] Set up experimental configurations
- [ ] Secure sensitive credentials
- [ ] Test local-only functionality

### Project Scope Setup
**Use Case:** Team collaboration, shared tools, version-controlled configs

**Commands:**
```bash
# Add project-scoped server
claude mcp add shared-server -s project /path/to/server
```

**Generated `.mcp.json`:**
```json
{
  "mcpServers": {
    "shared-server": {
      "command": "/path/to/server",
      "args": [],
      "env": {}
    }
  }
}
```

**Tasks:**
- [ ] Create shared server configurations
- [ ] Add `.mcp.json` to version control
- [ ] Document server purposes for team
- [ ] Test team accessibility

### User Scope Setup
**Use Case:** Cross-project utilities, personal tools, development aids

**Commands:**
```bash
# Add user-scoped server
claude mcp add my-user-server -s user /path/to/server
```

**Tasks:**
- [ ] Configure personal utility servers
- [ ] Set up development tools
- [ ] Test cross-project availability
- [ ] Maintain user-specific configs

### Environment Variable Configuration
**Purpose:** Flexible configurations with machine-specific values

**Supported Syntax:**
- `${VAR}` - Environment variable value
- `${VAR:-default}` - Variable with fallback default

**Example `.mcp.json` with variables:**
```json
{
  "mcpServers": {
    "api-server": {
      "type": "sse",
      "url": "${API_BASE_URL:-https://api.example.com}/mcp",
      "headers": {
        "Authorization": "Bearer ${API_KEY}"
      }
    }
  }
}
```

**Tasks:**
- [ ] Define environment variables
- [ ] Set fallback defaults
- [ ] Test variable expansion
- [ ] Document required variables

---

## Authentication Setup

### Step 1: Configure OAuth 2.0 Authentication
**Purpose:** Secure connection to remote MCP servers

**Commands:**
```bash
# Add server requiring authentication
claude mcp add --transport sse github-server https://api.github.com/mcp
```

**Tasks:**
- [ ] Add servers requiring OAuth
- [ ] Prepare OAuth credentials
- [ ] Configure redirect URLs
- [ ] Test authentication flow

### Step 2: Authenticate Using /mcp Command
**Purpose:** Interactive authentication management

**Command:**
```bash
# Within Claude Code session
/mcp
```

**Interactive Menu Options:**
- View connection status
- Authenticate with servers
- Clear existing authentication
- View server capabilities

**Tasks:**
- [ ] Open `/mcp` interactive menu
- [ ] Select servers for authentication
- [ ] Complete OAuth flows
- [ ] Verify authentication status

### Step 3: Complete OAuth Flow
**Process:**
1. Browser opens automatically to OAuth provider
2. Complete authentication in browser
3. Claude Code receives and stores access token
4. Server connection becomes active

**Tasks:**
- [ ] Complete browser authentication
- [ ] Verify token storage
- [ ] Test authenticated connections
- [ ] Monitor token refresh

**Authentication Management Commands:**
```bash
# Clear authentication for specific server
# Use /mcp menu option "Clear authentication"

# Reset project choices
claude mcp reset-project-choices
```

---

## Database Integration

### PostgreSQL MCP Server Setup
**Purpose:** Read-only database access for querying and schema inspection

**Step 1: Add Postgres Server**
```bash
claude mcp add postgres-server /path/to/postgres-mcp-server --connection-string "postgresql://user:pass@localhost:5432/mydb"
```

**Step 2: Test Database Queries**
```bash
# Within Claude Code session
> describe the schema of our users table
> what are the most recent orders in the system?
> show me the relationship between customers and invoices
```

**Tasks:**
- [ ] Install Postgres MCP server
- [ ] Configure connection string
- [ ] Set minimum required permissions
- [ ] Test read-only access
- [ ] Verify schema exploration
- [ ] Test analytical queries

**Security Best Practices:**
- Use read-only database credentials
- Limit permissions to necessary tables
- Monitor database access logs
- Regular credential rotation

---

## Advanced Configuration

### JSON Configuration Import
**Purpose:** Add servers from existing JSON configurations

**Command:**
```bash
claude mcp add-json <server-name> '<json-config>'
```

**Example:**
```bash
claude mcp add-json weather-api '{"type":"stdio","command":"/path/to/weather-cli","args":["--api-key","abc123"],"env":{"CACHE_DIR":"/tmp"}}'
```

**Tasks:**
- [ ] Prepare JSON configurations
- [ ] Validate JSON schema
- [ ] Test JSON import
- [ ] Verify server functionality

### Import from Claude Desktop
**Purpose:** Migrate existing Claude Desktop MCP configurations

**Command:**
```bash
claude mcp add-from-claude-desktop
```

**Supported Platforms:**
- macOS
- Windows Subsystem for Linux (WSL)

**Tasks:**
- [ ] Run import command
- [ ] Select servers to import
- [ ] Resolve naming conflicts
- [ ] Verify imported configurations

### Claude Code as MCP Server
**Purpose:** Use Claude Code itself as an MCP server for other applications

**Commands:**
```bash
# Start Claude as MCP server
claude mcp serve
```

**Client Configuration for Claude Desktop:**
```json
{
  "command": "claude",
  "args": ["mcp", "serve"],
  "env": {}
}
```

**Tasks:**
- [ ] Start Claude MCP server
- [ ] Configure client applications
- [ ] Test tool exposure
- [ ] Monitor server performance

### Windows-Specific Configuration
**Issue:** Native Windows requires `cmd /c` wrapper for `npx` commands

**Solution:**
```bash
# Correct Windows configuration
claude mcp add my-server -- cmd /c npx -y @some/package
```

**Tasks:**
- [ ] Use `cmd /c` wrapper on Windows
- [ ] Test npx command execution
- [ ] Verify Windows compatibility
- [ ] Handle path differences

---

## Usage and Testing

### MCP Resources Usage
**Purpose:** Reference external resources using @ mentions

**Commands:**
```bash
# List available resources
# Type @ in Claude Code prompt

# Reference specific resources
> Can you analyze @github:issue://123 and suggest a fix?
> Please review the API documentation at @docs:file://api/authentication
> Compare @postgres:schema://users with @docs:file://database/user-model
```

**Tasks:**
- [ ] Explore available resources
- [ ] Test resource references
- [ ] Verify automatic fetching
- [ ] Use multiple resources in prompts

### MCP Prompts as Slash Commands
**Purpose:** Execute MCP server prompts as slash commands

**Commands:**
```bash
# Discover available prompts
# Type / in Claude Code

# Execute prompts
> /mcp__github__list_prs
> /mcp__github__pr_review 456
> /mcp__jira__create_issue "Bug in login flow" high
```

**Tasks:**
- [ ] Discover available prompts
- [ ] Test prompt execution
- [ ] Use prompts with arguments
- [ ] Monitor prompt results

### Configuration Verification
**Commands:**
```bash
# Check MCP server status
/mcp

# List all servers
claude mcp list

# Get server details
claude mcp get <server-name>

# Test specific server
claude mcp test <server-name>
```

**Tasks:**
- [ ] Verify all server connections
- [ ] Check authentication status
- [ ] Test server capabilities
- [ ] Monitor performance metrics

---

## Troubleshooting

### Common Issues and Solutions

#### Connection Errors
**Problem:** "Connection closed" errors

**Solutions:**
```bash
# Windows: Use cmd wrapper
claude mcp add server -- cmd /c npx -y @package

# Check server status
claude mcp get <server-name>

# Increase timeout
MCP_TIMEOUT=10000 claude
```

#### Authentication Issues
**Problem:** OAuth authentication failures

**Solutions:**
```bash
# Clear and reauthenticate
# Use /mcp menu to clear auth

# Reset project choices
claude mcp reset-project-choices

# Check browser settings
# Ensure popup blockers disabled
```

#### Configuration Problems
**Problem:** Server not found or misconfigured

**Solutions:**
```bash
# Verify server path
which <server-command>

# Check environment variables
echo $API_KEY

# Validate JSON configuration
# Use online JSON validator
```

### Environment Configuration
**Setup:**
```bash
# Configure MCP timeout
export MCP_TIMEOUT=10000

# Set API keys
export API_KEY=your-api-key
export DATABASE_URL=postgresql://user:pass@localhost:5432/db
```

### Debug Commands
```bash
# Debug MCP with verbose output
claude --mcp-debug

# Check server logs
claude mcp logs <server-name>

# Test connection
claude mcp ping <server-name>
```

**Tasks:**
- [ ] Configure debug environment
- [ ] Monitor server logs
- [ ] Test connectivity regularly
- [ ] Document common solutions

---

## Best Practices

### Security
- [ ] Use read-only credentials where possible
- [ ] Regularly rotate API keys
- [ ] Monitor server access logs
- [ ] Validate third-party servers

### Performance
- [ ] Configure appropriate timeouts
- [ ] Monitor server response times
- [ ] Clean up unused servers
- [ ] Optimize connection pooling

### Team Collaboration
- [ ] Document server purposes
- [ ] Share configurations via `.mcp.json`
- [ ] Establish naming conventions
- [ ] Regular configuration reviews

### Maintenance
- [ ] Regular server health checks
- [ ] Update server versions
- [ ] Monitor authentication status
- [ ] Backup configurations

---

## Summary

This guide provides comprehensive steps to configure MCP with Claude Code, enabling enhanced functionality through external integrations. Follow the steps systematically, test each configuration, and maintain regular monitoring for optimal performance.

For detailed technical documentation, refer to the [MCP documentation](https://modelcontextprotocol.io/introduction).
