# n8n Workflow Automation Implementation Plan for FashionOS

## 📋 Table of Contents

1. [Progress Overview](#progress-overview)
2. [Phase 1: Foundation Setup](#phase-1-foundation-setup)
3. [Phase 2: Core Integrations](#phase-2-core-integrations)
4. [Phase 3: Event Workflows](#phase-3-event-workflows)
5. [Phase 4: Model Management Automation](#phase-4-model-management-automation)
6. [Phase 5: Communication Workflows](#phase-5-communication-workflows)
7. [Phase 6: Payment Automations](#phase-6-payment-automations)
8. [Phase 7: AI-Powered Workflows](#phase-7-ai-powered-workflows)
9. [Phase 8: Monitoring & Optimization](#phase-8-monitoring-optimization)
10. [Phase 9: Production Deployment](#phase-9-production-deployment)

---

## 📊 Progress Overview

| Phase | Description | Status | % Complete |
|-------|-------------|--------|------------|
| Phase 1 | n8n setup and configuration | Not Started | 0% |
| Phase 2 | Connect Supabase, APIs, webhooks | Not Started | 0% |
| Phase 3 | Event lifecycle automation | Not Started | 0% |
| Phase 4 | Model booking and confirmations | Not Started | 0% |
| Phase 5 | WhatsApp, email, SMS workflows | Not Started | 0% |
| Phase 6 | Stripe payments and payouts | Not Started | 0% |
| Phase 7 | AI agents and smart automation | Not Started | 0% |
| Phase 8 | Monitoring, alerts, optimization | Not Started | 0% |
| Phase 9 | Production deployment and scaling | Not Started | 0% |

---

## Phase 1: Foundation Setup

### Task 1.1: n8n Installation and Configuration

**Purpose**: Install and configure n8n with proper security, database persistence, and scalability for handling thousands of fashion event workflows.

**Features**:
1. **Self-hosted deployment** - Full control over data and workflows
2. **PostgreSQL backend** - Reliable workflow execution history
3. **Queue management** - Handle high-volume event triggers
4. **Webhook security** - Authenticated endpoints for external triggers
5. **Environment isolation** - Separate dev/staging/production instances

**Use Cases**:
1. **Automated model confirmations** - Send contracts when models are booked
2. **Event reminders** - Schedule notifications 24 hours before shows
3. **Sponsor onboarding** - Multi-step welcome sequences
4. **Ticket sales triggers** - Update inventory and send confirmations
5. **Post-event surveys** - Automated feedback collection

**Real-World Examples**:
1. When Versace books 30 models, n8n sends 30 personalized contracts in parallel
2. Fashion Week ticket sales trigger instant WhatsApp confirmations to VIP buyers
3. Model cancellations automatically suggest replacements and notify designers
4. Sponsor payments trigger benefit activation and access credential generation
5. Show delays broadcast updates to all affected models and attendees instantly

**Steps to Complete**:

1. **Install n8n with Docker**
   ```bash
   DC: write "docker-compose.yml" "
   version: '3.8'
   
   services:
     n8n:
       image: n8nio/n8n:latest
       container_name: fashionos-n8n
       restart: unless-stopped
       ports:
         - '5678:5678'
       environment:
         - N8N_BASIC_AUTH_ACTIVE=true
         - N8N_BASIC_AUTH_USER=admin
         - N8N_BASIC_AUTH_PASSWORD=\${N8N_PASSWORD}
         - N8N_HOST=\${N8N_HOST}
         - N8N_PORT=5678
         - N8N_PROTOCOL=https
         - N8N_PATH=/n8n/
         - NODE_ENV=production
         - WEBHOOK_URL=\${N8N_WEBHOOK_URL}
         - GENERIC_TIMEZONE=America/Toronto
         - N8N_ENCRYPTION_KEY=\${N8N_ENCRYPTION_KEY}
         - DB_TYPE=postgresdb
         - DB_POSTGRESDB_HOST=postgres
         - DB_POSTGRESDB_PORT=5432
         - DB_POSTGRESDB_DATABASE=n8n
         - DB_POSTGRESDB_USER=n8n
         - DB_POSTGRESDB_PASSWORD=\${DB_PASSWORD}
         - EXECUTIONS_MODE=queue
         - QUEUE_BULL_REDIS_HOST=redis
         - QUEUE_HEALTH_CHECK_ACTIVE=true
       volumes:
         - n8n_data:/home/node/.n8n
         - ./workflows:/workflows
       depends_on:
         - postgres
         - redis
       networks:
         - n8n-network
   
     postgres:
       image: postgres:15-alpine
       container_name: fashionos-n8n-postgres
       restart: unless-stopped
       environment:
         - POSTGRES_USER=n8n
         - POSTGRES_PASSWORD=\${DB_PASSWORD}
         - POSTGRES_DB=n8n
       volumes:
         - postgres_data:/var/lib/postgresql/data
       networks:
         - n8n-network
   
     redis:
       image: redis:7-alpine
       container_name: fashionos-n8n-redis
       restart: unless-stopped
       command: redis-server --requirepass \${REDIS_PASSWORD}
       volumes:
         - redis_data:/data
       networks:
         - n8n-network
   
   volumes:
     n8n_data:
     postgres_data:
     redis_data:
   
   networks:
     n8n-network:
       driver: bridge
   "
   ```

2. **Create environment configuration**
   ```bash
   DC: write ".env" "
   N8N_PASSWORD=SecureAdminPass123!
   N8N_HOST=n8n.fashionos.com
   N8N_WEBHOOK_URL=https://n8n.fashionos.com/webhook/
   N8N_ENCRYPTION_KEY=\$(openssl rand -hex 32)
   DB_PASSWORD=SecureDBPass456!
   REDIS_PASSWORD=SecureRedisPass789!
   "
   ```

3. **Start n8n services**
   ```bash
   DC: exec "docker-compose up -d"
   DC: exec "docker-compose logs -f n8n"
   ```

4. **Configure n8n settings**
   ```bash
   DC: exec "docker exec -it fashionos-n8n n8n user-management:reset"
   ```

5. **Setup SSL with Nginx**
   ```bash
   DC: write "nginx.conf" "
   server {
     listen 80;
     server_name n8n.fashionos.com;
     return 301 https://\$server_name\$request_uri;
   }
   
   server {
     listen 443 ssl http2;
     server_name n8n.fashionos.com;
     
     ssl_certificate /etc/letsencrypt/live/n8n.fashionos.com/fullchain.pem;
     ssl_certificate_key /etc/letsencrypt/live/n8n.fashionos.com/privkey.pem;
     
     location /n8n/ {
       proxy_pass http://localhost:5678/;
       proxy_set_header Connection '';
       proxy_http_version 1.1;
       chunked_transfer_encoding off;
       proxy_buffering off;
       proxy_set_header Host \$host;
       proxy_set_header X-Real-IP \$remote_addr;
       proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
       proxy_set_header X-Forwarded-Proto \$scheme;
     }
   }
   "
   ```

**Success Criteria**:
- [ ] n8n accessible at https://n8n.fashionos.com
- [ ] Database persistence working
- [ ] Redis queue operational
- [ ] SSL certificates valid
- [ ] Admin authentication enabled

**Testing**:
```bash
# Test n8n is running
DC: exec "curl -I https://n8n.fashionos.com/n8n/"

# Test database connection
DC: exec "docker exec fashionos-n8n-postgres psql -U n8n -d n8n -c '\dt'"

# Test Redis connection
DC: exec "docker exec fashionos-n8n-redis redis-cli -a $REDIS_PASSWORD ping"

# Create test workflow via API
DC: exec "curl -X POST https://n8n.fashionos.com/api/v1/workflows \
  -H 'Authorization: Basic $(echo -n admin:$N8N_PASSWORD | base64)' \
  -H 'Content-Type: application/json' \
  -d '{\"name\": \"Test Workflow\", \"nodes\": [], \"active\": false}'"
```

**Troubleshooting**:
- **Cannot access n8n**: Check Docker logs and port mappings
- **Database connection failed**: Verify PostgreSQL credentials
- **SSL errors**: Ensure certificates are properly mounted
- **Queue not processing**: Check Redis connection and password

**Checklist**:
- [ ] Docker Compose running all services
- [ ] n8n web interface accessible
- [ ] Database storing workflow data
- [ ] Redis queue processing jobs
- [ ] SSL properly configured

---

### Task 1.2: n8n Core Configuration

**Purpose**: Configure n8n with optimal settings for fashion event automation, including execution modes, resource limits, and security policies.

**Features**:
1. **Execution timeout controls** - Prevent runaway workflows
2. **Memory management** - Handle large file processing
3. **Error handling policies** - Automatic retries and notifications
4. **Audit logging** - Track all workflow executions
5. **API rate limiting** - Prevent abuse and ensure stability

**Use Cases**:
1. **Bulk operations** - Process 500+ model confirmations without timeout
2. **Large file handling** - Process sponsor asset uploads (50MB+)
3. **Failed payment retries** - Automatically retry failed Stripe charges
4. **Compliance tracking** - Log all data processing for GDPR
5. **Partner API protection** - Rate limit external service calls

**Real-World Examples**:
1. Milan Fashion Week processes 10,000 ticket orders in 1 hour without crashes
2. Designer uploads 2GB lookbook, n8n processes and distributes to press
3. Payment failure at 2AM automatically retries and succeeds at 2:15AM
4. GDPR audit shows complete log of all model data processing
5. Instagram API rate limits respected when posting 100 show updates

**Steps to Complete**:

1. **Configure execution settings**
   ```bash
   DC: write "n8n-config/settings.json" "
   {
     \"executions\": {
       \"timeout\": 3600,
       \"maxTimeout\": 7200,
       \"saveDataOnError\": \"all\",
       \"saveDataOnSuccess\": \"all\",
       \"saveExecutionProgress\": true,
       \"pruneData\": true,
       \"pruneDataMaxAge\": 336
     },
     \"queue\": {
       \"bull\": {
         \"queueRecoveryInterval\": 60,
         \"gracefulShutdownTimeout\": 30,
         \"prefix\": \"fashionos\"
       }
     },
     \"nodes\": {
       \"maxRequestSizeInMb\": 100,
       \"errorTriggerType\": \"n8n-nodes-base.errorTrigger\"
     },
     \"security\": {
       \"audit\": {
         \"enabled\": true,
         \"logLevel\": \"info\",
         \"destination\": \"database\"
       }
     }
   }
   "
   ```

2. **Create workflow templates**
   ```bash
   DC: write "n8n-config/templates/model-confirmation.json" "
   {
     \"name\": \"Model Booking Confirmation\",
     \"nodes\": [
       {
         \"parameters\": {
           \"httpMethod\": \"POST\",
           \"path\": \"model-confirmed\",
           \"responseMode\": \"responseNode\",
           \"options\": {
             \"authRequired\": true
           }
         },
         \"name\": \"Webhook\",
         \"type\": \"n8n-nodes-base.webhook\",
         \"position\": [250, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"model\",
           \"operation\": \"get\",
           \"id\": \"={{$json.model_id}}\"
         },
         \"name\": \"Get Model Details\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"contract\",
           \"operation\": \"generate\",
           \"template\": \"model_booking\",
           \"data\": \"={{$json}}\"
         },
         \"name\": \"Generate Contract\",
         \"type\": \"n8n-nodes-base.documentGeneration\",
         \"position\": [650, 300]
       }
     ]
   }
   "
   ```

3. **Setup error handling workflow**
   ```bash
   DC: write "n8n-config/error-handler.js" "
   const errorHandler = {
     name: 'Global Error Handler',
     nodes: [
       {
         name: 'Error Trigger',
         type: 'n8n-nodes-base.errorTrigger',
         parameters: {},
         position: [250, 300]
       },
       {
         name: 'Log Error',
         type: 'n8n-nodes-base.postgres',
         parameters: {
           operation: 'insert',
           table: 'workflow_errors',
           columns: 'workflow_id,error_message,error_time,execution_id',
           values: '={{$json.workflow.id}},={{$json.error.message}},={{new Date()}},={{$json.execution.id}}'
         },
         position: [450, 300]
       },
       {
         name: 'Send Alert',
         type: 'n8n-nodes-base.slack',
         parameters: {
           channel: '#n8n-errors',
           text: 'Workflow Error: {{$json.workflow.name}}\\nError: {{$json.error.message}}',
           attachments: [{
             color: 'danger',
             fields: [
               {title: 'Workflow', value: '{{$json.workflow.name}}'},
               {title: 'Time', value: '{{new Date()}}'},
               {title: 'Execution ID', value: '{{$json.execution.id}}'}
             ]
           }]
         },
         position: [650, 300]
       }
     ]
   };
   "
   ```

4. **Configure resource limits**
   ```bash
   DC: exec "docker exec fashionos-n8n sh -c 'echo \"
   export NODE_OPTIONS='--max-old-space-size=4096'
   export N8N_PAYLOAD_SIZE_MAX=100
   export N8N_METRICS=true
   export N8N_METRICS_PREFIX=fashionos_n8n_
   \" >> ~/.bashrc'"
   ```

5. **Setup monitoring endpoints**
   ```bash
   DC: write "n8n-config/health-check.js" "
   module.exports = {
     checkHealth: async () => {
       const checks = {
         database: false,
         redis: false,
         workflows: false,
         webhooks: false
       };
       
       try {
         // Check database
         const dbResult = await db.query('SELECT 1');
         checks.database = !!dbResult;
         
         // Check Redis
         const redisResult = await redis.ping();
         checks.redis = redisResult === 'PONG';
         
         // Check active workflows
         const workflows = await getActiveWorkflows();
         checks.workflows = workflows.length > 0;
         
         // Check webhook endpoint
         const webhookTest = await fetch(process.env.WEBHOOK_URL + '/health');
         checks.webhooks = webhookTest.ok;
         
         return {
           status: Object.values(checks).every(v => v) ? 'healthy' : 'degraded',
           checks,
           timestamp: new Date()
         };
       } catch (error) {
         return {
           status: 'unhealthy',
           error: error.message,
           checks,
           timestamp: new Date()
         };
       }
     }
   };
   "
   ```

**Success Criteria**:
- [ ] Execution timeouts configured
- [ ] Error handling workflow active
- [ ] Resource limits set appropriately
- [ ] Audit logging enabled
- [ ] Health monitoring operational

**Testing**:
```bash
# Test execution timeout
DC: exec "curl -X POST https://n8n.fashionos.com/webhook-test/timeout-test"

# Test error handling
DC: exec "curl -X POST https://n8n.fashionos.com/webhook-test/trigger-error"

# Check health endpoint
DC: exec "curl https://n8n.fashionos.com/health"

# Verify audit logs
DC: exec "docker exec fashionos-n8n-postgres psql -U n8n -d n8n -c 'SELECT * FROM execution_entity ORDER BY startedAt DESC LIMIT 5;'"
```

**Troubleshooting**:
- **Workflows timing out**: Increase timeout in settings
- **Memory errors**: Adjust NODE_OPTIONS max-old-space-size
- **Audit logs missing**: Check audit configuration
- **Health check failing**: Verify all services are running

**Checklist**:
- [ ] Execution settings optimized
- [ ] Error workflow created and active
- [ ] Resource limits configured
- [ ] Monitoring endpoints working
- [ ] Templates ready for use

---

## Phase 2: Core Integrations

### Task 2.1: Supabase Integration

**Purpose**: Connect n8n to Supabase for real-time database triggers, data operations, and event-driven automation.

**Features**:
1. **Real-time triggers** - React to database changes instantly
2. **Batch operations** - Process multiple records efficiently
3. **Transaction support** - Ensure data consistency
4. **RLS bypass** - Admin operations with service role
5. **Connection pooling** - Handle high-volume operations

**Use Cases**:
1. **Model booking triggers** - Auto-send contracts on confirmation
2. **Event status changes** - Notify all stakeholders
3. **Payment completions** - Update records and send receipts
4. **Inventory updates** - Sync available tickets/seats
5. **Sponsor tier upgrades** - Activate new benefits

**Real-World Examples**:
1. Chanel confirms 25 models → n8n sends 25 contracts in 30 seconds
2. Show cancelled → 500 attendees notified via SMS/email within 2 minutes
3. Platinum sponsor payment received → VIP benefits activated instantly
4. Last 10 VIP tickets sold → Public waitlist opens automatically
5. Model cancels → Designer notified + 3 replacement suggestions sent

**Steps to Complete**:

1. **Install Supabase node**
   ```bash
   DC: exec "docker exec fashionos-n8n npm install n8n-nodes-supabase"
   ```

2. **Configure Supabase credentials**
   ```bash
   DC: exec "curl -X POST https://n8n.fashionos.com/api/v1/credentials \
     -H 'Authorization: Basic $(echo -n admin:$N8N_PASSWORD | base64)' \
     -H 'Content-Type: application/json' \
     -d '{
       \"name\": \"Supabase FashionOS\",
       \"type\": \"supabaseApi\",
       \"data\": {
         \"host\": \"https://your-project.supabase.co\",
         \"serviceRole\": \"your-service-role-key\"
       }
     }'"
   ```

3. **Create database trigger workflow**
   ```bash
   DC: write "workflows/model-booking-trigger.json" "
   {
     \"name\": \"Model Booking Trigger\",
     \"nodes\": [
       {
         \"parameters\": {
           \"resource\": \"event_models\",
           \"events\": [\"INSERT\", \"UPDATE\"],
           \"additionalFields\": {
             \"filter\": \"status=eq.confirmed\"
           }
         },
         \"name\": \"Supabase Trigger\",
         \"type\": \"n8n-nodes-base.supabaseTrigger\",
         \"position\": [250, 300],
         \"webhookId\": \"model-booking-webhook\"
       },
       {
         \"parameters\": {
           \"conditions\": {
             \"boolean\": [
               {
                 \"value1\": \"={{$json.old.status}}\",
                 \"operation\": \"notEqual\",
                 \"value2\": \"confirmed\"
               }
             ]
           }
         },
         \"name\": \"Check New Confirmation\",
         \"type\": \"n8n-nodes-base.if\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"models\",
           \"operation\": \"get\",
           \"id\": \"={{$json.model_id}}\"
         },
         \"name\": \"Get Model Details\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [650, 200]
       },
       {
         \"parameters\": {
           \"resource\": \"designers\",
           \"operation\": \"get\",
           \"id\": \"={{$json.designer_id}}\"
         },
         \"name\": \"Get Designer Details\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [650, 400]
       },
       {
         \"parameters\": {
           \"functionName\": \"generate_contract\",
           \"payload\": {
             \"model\": \"={{$node['Get Model Details'].json}}\",
             \"designer\": \"={{$node['Get Designer Details'].json}}\",
             \"booking\": \"={{$json}}\"
           }
         },
         \"name\": \"Generate Contract\",
         \"type\": \"n8n-nodes-base.supabaseFunction\",
         \"position\": [850, 300]
       }
     ]
   }
   "
   ```

4. **Setup batch operations workflow**
   ```bash
   DC: write "workflows/batch-model-update.json" "
   {
     \"name\": \"Batch Model Updates\",
     \"nodes\": [
       {
         \"parameters\": {
           \"operation\": \"getAll\",
           \"resource\": \"models\",
           \"filters\": {
             \"availability\": \"cs.{2024-10-15}\"
           },
           \"limit\": 100
         },
         \"name\": \"Get Available Models\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [250, 300]
       },
       {
         \"parameters\": {
           \"batchSize\": 10,
           \"options\": {
             \"reset\": false
           }
         },
         \"name\": \"Split Into Batches\",
         \"type\": \"n8n-nodes-base.splitInBatches\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"event_models\",
           \"operation\": \"upsert\",
           \"columns\": [
             \"model_id\",
             \"event_id\",
             \"status\",
             \"updated_at\"
           ],
           \"values\": \"={{$json.model_id}},{{$parameter.event_id}},available,{{new Date().toISOString()}}\"
         },
         \"name\": \"Update Availability\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [650, 300]
       }
     ]
   }
   "
   ```

5. **Create real-time sync workflow**
   ```bash
   DC: write "workflows/realtime-sync.json" "
   {
     \"name\": \"Real-time Event Sync\",
     \"nodes\": [
       {
         \"parameters\": {
           \"channel\": \"event_updates\",
           \"events\": [\"UPDATE\"],
           \"filter\": \"id=eq.{{$parameter.event_id}}\"
         },
         \"name\": \"Realtime Subscription\",
         \"type\": \"n8n-nodes-base.supabaseRealtime\",
         \"position\": [250, 300]
       },
       {
         \"parameters\": {
           \"value\": \"={{$json.new.status}}\",
           \"rules\": [
             {
               \"output\": 0,
               \"value\": \"cancelled\"
             },
             {
               \"output\": 1,
               \"value\": \"postponed\"
             }
           ]
         },
         \"name\": \"Route by Status\",
         \"type\": \"n8n-nodes-base.switch\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"sql\": \"SELECT DISTINCT em.model_id, m.phone, m.email FROM event_models em JOIN models m ON em.model_id = m.id WHERE em.event_id = '{{$json.id}}' AND em.status = 'confirmed'\"
         },
         \"name\": \"Get Affected Models\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [650, 200]
       },
       {
         \"parameters\": {
           \"content\": \"Event {{$json.new.name}} has been {{$json.new.status}}. New date: {{$json.new.start_date}}\"
         },
         \"name\": \"Prepare Notification\",
         \"type\": \"n8n-nodes-base.set\",
         \"position\": [650, 400]
       }
     ]
   }
   "
   ```

**Success Criteria**:
- [ ] Supabase credentials configured
- [ ] Database triggers working
- [ ] Batch operations efficient
- [ ] Real-time subscriptions active
- [ ] Error handling implemented

**Testing**:
```bash
# Test Supabase connection
DC: exec "curl -X POST https://n8n.fashionos.com/webhook-test/supabase-connection"

# Trigger database change
DC: @supabase sql "UPDATE event_models SET status = 'confirmed' WHERE id = 'test-booking-id';"

# Verify workflow triggered
DC: exec "curl https://n8n.fashionos.com/api/v1/executions?workflowId=model-booking-trigger"

# Test batch operation
DC: exec "curl -X POST https://n8n.fashionos.com/webhook/batch-update-test"
```

**Troubleshooting**:
- **Connection refused**: Verify Supabase URL and keys
- **Triggers not firing**: Check webhook registration
- **Timeout on batch**: Reduce batch size
- **Real-time not working**: Verify channel names

**Checklist**:
- [ ] Supabase node installed
- [ ] Credentials stored securely
- [ ] Trigger workflows created
- [ ] Batch processing tested
- [ ] Real-time sync verified

---

### Task 2.2: External API Integrations

**Purpose**: Connect n8n to external services including WhatsApp, Stripe, email providers, and social media platforms for comprehensive automation.

**Features**:
1. **OAuth2 authentication** - Secure API connections
2. **Rate limit handling** - Respect API quotas
3. **Retry mechanisms** - Handle temporary failures
4. **Webhook endpoints** - Receive external events
5. **Data transformation** - Map between different formats

**Use Cases**:
1. **WhatsApp notifications** - Send call sheets to models
2. **Stripe payment processing** - Handle charges and refunds
3. **Email campaigns** - Designer announcements
4. **Instagram posting** - Automated show updates
5. **Calendar syncing** - Google Calendar integration

**Real-World Examples**:
1. Model books show → WhatsApp message with details sent in 5 seconds
2. VIP ticket purchased → Stripe processes → Email receipt → SMS confirmation
3. Show starts in 1 hour → Instagram story posted → Twitter announcement
4. Designer updates schedule → Google Calendar updated → Models notified
5. Sponsor logo uploaded → Resized for all platforms → Distributed to venues

**Steps to Complete**:

1. **Configure WhatsApp Business API**
   ```bash
   DC: write "credentials/whatsapp-config.json" "
   {
     \"name\": \"WhatsApp Business\",
     \"type\": \"whatsappBusinessApi\",
     \"data\": {
       \"accessToken\": \"{{WHATSAPP_ACCESS_TOKEN}}\",
       \"phoneNumberId\": \"{{WHATSAPP_PHONE_ID}}\",
       \"businessAccountId\": \"{{WHATSAPP_BUSINESS_ID}}\",
       \"webhookVerifyToken\": \"fashionos-webhook-2024\"
     }
   }
   "
   
   DC: write "workflows/whatsapp-integration.json" "
   {
     \"name\": \"WhatsApp Message Handler\",
     \"nodes\": [
       {
         \"parameters\": {
           \"authentication\": \"headerAuth\",
           \"httpMethod\": \"POST\",
           \"path\": \"whatsapp-webhook\",
           \"options\": {
             \"responseHeaders\": {
               \"X-Hub-Signature-256\": \"={{$headers['x-hub-signature-256']}}\"
             }
           }
         },
         \"name\": \"WhatsApp Webhook\",
         \"type\": \"n8n-nodes-base.webhook\",
         \"position\": [250, 300]
       },
       {
         \"parameters\": {
           \"jsCode\": \"// Verify webhook signature\\nconst crypto = require('crypto');\\nconst signature = $headers['x-hub-signature-256'];\\nconst payload = JSON.stringify($input.all()[0].json);\\nconst expectedSignature = 'sha256=' + crypto\\n  .createHmac('sha256', $credentials.webhookSecret)\\n  .update(payload)\\n  .digest('hex');\\n\\nif (signature !== expectedSignature) {\\n  throw new Error('Invalid signature');\\n}\\n\\nreturn $input.all();\"
         },
         \"name\": \"Verify Signature\",
         \"type\": \"n8n-nodes-base.code\",
         \"position\": [450, 300]
       }
     ]
   }
   "
   ```

2. **Setup Stripe integration**
   ```bash
   DC: write "workflows/stripe-payment-handler.json" "
   {
     \"name\": \"Stripe Payment Processing\",
     \"nodes\": [
       {
         \"parameters\": {
           \"httpMethod\": \"POST\",
           \"path\": \"stripe-webhook\",
           \"responseMode\": \"responseNode\"
         },
         \"name\": \"Stripe Webhook\",
         \"type\": \"n8n-nodes-base.webhook\",
         \"position\": [250, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"event\",
           \"operation\": \"retrieve\",
           \"eventId\": \"={{$json.id}}\"
         },
         \"name\": \"Verify Stripe Event\",
         \"type\": \"n8n-nodes-base.stripe\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"conditions\": {
             \"string\": [
               {
                 \"value1\": \"={{$json.type}}\",
                 \"operation\": \"equals\",
                 \"value2\": \"payment_intent.succeeded\"
               }
             ]
           }
         },
         \"name\": \"Check Payment Success\",
         \"type\": \"n8n-nodes-base.if\",
         \"position\": [650, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"tickets\",
           \"operation\": \"update\",
           \"id\": \"={{$json.data.object.metadata.ticket_id}}\",
           \"updateFields\": {
             \"status\": \"paid\",
             \"payment_intent\": \"={{$json.data.object.id}}\",
             \"paid_at\": \"={{new Date().toISOString()}}\"
           }
         },
         \"name\": \"Update Ticket Status\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [850, 200]
       }
     ]
   }
   "
   ```

3. **Configure email service**
   ```bash
   DC: write "workflows/email-automation.json" "
   {
     \"name\": \"Email Campaign Automation\",
     \"nodes\": [
       {
         \"parameters\": {
           \"fromEmail\": \"events@fashionos.com\",
           \"toEmail\": \"={{$json.email}}\",
           \"subject\": \"{{$parameter.subject}}\",
           \"emailType\": \"html\",
           \"htmlBody\": \"={{$parameter.template}}\"
         },
         \"name\": \"Send Email\",
         \"type\": \"n8n-nodes-base.sendGrid\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"email_logs\",
           \"operation\": \"insert\",
           \"columns\": \"recipient,subject,status,sent_at\",
           \"values\": \"{{$json.email}},{{$parameter.subject}},sent,{{new Date()}}\"
         },
         \"name\": \"Log Email\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [650, 300]
       }
     ]
   }
   "
   ```

4. **Setup social media posting**
   ```bash
   DC: write "workflows/social-media-automation.json" "
   {
     \"name\": \"Social Media Scheduler\",
     \"nodes\": [
       {
         \"parameters\": {
           \"resource\": \"post\",
           \"operation\": \"create\",
           \"mediaType\": \"image\",
           \"imageUrl\": \"={{$json.image_url}}\",
           \"caption\": \"={{$json.caption}}\",
           \"accessToken\": \"={{$credentials.instagramToken}}\"
         },
         \"name\": \"Post to Instagram\",
         \"type\": \"n8n-nodes-base.instagram\",
         \"position\": [450, 200]
       },
       {
         \"parameters\": {
           \"text\": \"={{$json.caption.substring(0, 280)}}\",
           \"additionalFields\": {
             \"attachments\": [\"={{$json.image_url}}\"]
           }
         },
         \"name\": \"Post to Twitter\",
         \"type\": \"n8n-nodes-base.twitter\",
         \"position\": [450, 400]
       },
       {
         \"parameters\": {
           \"channelId\": \"fashion-updates\",
           \"messageText\": \"New post published!\",
           \"blocks\": [
             {
               \"type\": \"image\",
               \"image_url\": \"={{$json.image_url}}\",
               \"alt_text\": \"Fashion show update\"
             }
           ]
         },
         \"name\": \"Notify Team\",
         \"type\": \"n8n-nodes-base.slack\",
         \"position\": [650, 300]
       }
     ]
   }
   "
   ```

5. **Create API rate limiter**
   ```bash
   DC: write "workflows/rate-limiter.json" "
   {
     \"name\": \"API Rate Limit Handler\",
     \"nodes\": [
       {
         \"parameters\": {
           \"functionCode\": \"const redis = require('redis');\\nconst client = redis.createClient();\\n\\nconst key = `rate_limit:${$json.api}:${$json.endpoint}`;\\nconst limit = $json.limit || 100;\\nconst window = $json.window || 3600;\\n\\nconst current = await client.incr(key);\\nif (current === 1) {\\n  await client.expire(key, window);\\n}\\n\\nif (current > limit) {\\n  throw new Error('Rate limit exceeded');\\n}\\n\\nreturn {\\n  allowed: true,\\n  remaining: limit - current,\\n  reset: await client.ttl(key)\\n};\"
         },
         \"name\": \"Check Rate Limit\",
         \"type\": \"n8n-nodes-base.function\",
         \"position\": [450, 300]
       }
     ]
   }
   "
   ```

**Success Criteria**:
- [ ] All API credentials configured
- [ ] Webhook endpoints verified
- [ ] Rate limiting implemented
- [ ] Error handling active
- [ ] Social media posting works

**Testing**:
```bash
# Test WhatsApp webhook
DC: exec "curl -X POST https://n8n.fashionos.com/webhook/whatsapp-webhook \
  -H 'X-Hub-Signature-256: test-signature' \
  -d '{\"entry\": [{\"messaging\": []}]}'"

# Test Stripe webhook
DC: exec "curl -X POST https://n8n.fashionos.com/webhook/stripe-webhook \
  -H 'Stripe-Signature: test-sig' \
  -d '{\"type\": \"payment_intent.succeeded\"}'"

# Test email sending
DC: exec "curl -X POST https://n8n.fashionos.com/webhook-test/send-test-email"

# Test social media
DC: exec "curl -X POST https://n8n.fashionos.com/webhook-test/social-media-test"
```

**Troubleshooting**:
- **Invalid credentials**: Re-check API keys and secrets
- **Webhook verification fails**: Ensure signatures match
- **Rate limit hit**: Implement exponential backoff
- **Social media fails**: Check OAuth tokens

**Checklist**:
- [ ] WhatsApp API connected
- [ ] Stripe webhooks verified
- [ ] Email service operational
- [ ] Social media APIs linked
- [ ] Rate limiting active

---

## Phase 3: Event Workflows

### Task 3.1: Event Lifecycle Automation

**Purpose**: Automate the complete event lifecycle from creation to post-event analysis, ensuring nothing falls through the cracks.

**Features**:
1. **Multi-stage workflows** - Draft → Published → Active → Completed
2. **Conditional branching** - Different paths based on event type
3. **Scheduled triggers** - Time-based automation
4. **Approval workflows** - Human-in-the-loop for critical decisions
5. **Rollback mechanisms** - Undo changes if needed

**Use Cases**:
1. **Event publishing** - Auto-notify all stakeholders when event goes live
2. **Countdown sequences** - T-7 days, T-1 day, T-1 hour automations
3. **Capacity monitoring** - Alert when 80% tickets sold
4. **Weather contingency** - Auto-communicate venue changes
5. **Post-event workflow** - Surveys, payments, thank you messages

**Real-World Examples**:
1. Fashion Week published → 10,000 SMS + 50,000 emails sent in 10 minutes
2. Show starts in 24h → Models get call sheets, sponsors get VIP instructions
3. Outdoor show + rain forecast → Indoor backup venue activated + all notified
4. Event ends → Feedback survey at 9AM next day (not at 2AM)
5. 90% capacity reached → Waitlist opens + marketing push activated

**Steps to Complete**:

1. **Create event publishing workflow**
   ```bash
   DC: write "workflows/event-publishing.json" "
   {
     \"name\": \"Event Publishing Workflow\",
     \"nodes\": [
       {
         \"parameters\": {
           \"resource\": \"events\",
           \"events\": [\"UPDATE\"],
           \"additionalFields\": {
             \"filter\": \"status=eq.published\"
           }
         },
         \"name\": \"Event Published Trigger\",
         \"type\": \"n8n-nodes-base.supabaseTrigger\",
         \"position\": [250, 300]
       },
       {
         \"parameters\": {
           \"conditions\": {
             \"string\": [
               {
                 \"value1\": \"={{$json.old.status}}\",
                 \"operation\": \"notEqual\",
                 \"value2\": \"published\"
               }
             ]
           }
         },
         \"name\": \"Check First Publication\",
         \"type\": \"n8n-nodes-base.if\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"attendees\",
           \"operation\": \"getAll\",
           \"filters\": {
             \"subscribed\": \"true\",
             \"city\": \"={{$json.venue.city}}\"
           }
         },
         \"name\": \"Get Target Audience\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [650, 200]
       },
       {
         \"parameters\": {
           \"batchSize\": 100
         },
         \"name\": \"Batch Recipients\",
         \"type\": \"n8n-nodes-base.splitInBatches\",
         \"position\": [850, 200]
       },
       {
         \"parameters\": {
           \"to\": \"={{$json.phone}}\",
           \"message\": \"🎉 {{$node['Event Published Trigger'].json.name}} is now LIVE! Get your tickets: https://fashionos.com/{{$node['Event Published Trigger'].json.slug}}\"
         },
         \"name\": \"Send SMS\",
         \"type\": \"n8n-nodes-base.twilio\",
         \"position\": [1050, 200]
       },
       {
         \"parameters\": {
           \"resource\": \"sponsors\",
           \"operation\": \"getAll\",
           \"filters\": {
             \"event_id\": \"={{$json.id}}\"
           }
         },
         \"name\": \"Get Event Sponsors\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [650, 400]
       },
       {
         \"parameters\": {
           \"subject\": \"Your Sponsored Event is Live!\",
           \"htmlBody\": \"<h2>{{$json.name}} is Published!</h2><p>Dear {{$json.company_name}},</p><p>The event you're sponsoring is now live. Your benefits package includes:</p><ul>{{$json.benefits}}</ul>\",
           \"toEmail\": \"={{$json.email}}\"
         },
         \"name\": \"Email Sponsors\",
         \"type\": \"n8n-nodes-base.sendGrid\",
         \"position\": [850, 400]
       }
     ]
   }
   "
   ```

2. **Setup countdown automation**
   ```bash
   DC: write "workflows/event-countdown.json" "
   {
     \"name\": \"Event Countdown Automation\",
     \"nodes\": [
       {
         \"parameters\": {
           \"rule\": \"0 9 * * *\",
           \"timezone\": \"America/Toronto\"
         },
         \"name\": \"Daily at 9AM\",
         \"type\": \"n8n-nodes-base.cron\",
         \"position\": [250, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"events\",
           \"operation\": \"getAll\",
           \"filters\": {
             \"status\": \"published\",
             \"start_date\": \"gte.{{new Date().toISOString()}}\",
             \"start_date\": \"lt.{{new Date(Date.now() + 8*24*60*60*1000).toISOString()}}\"
           }
         },
         \"name\": \"Get Upcoming Events\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"functionCode\": \"return items.map(item => {\\n  const event = item.json;\\n  const daysUntil = Math.floor((new Date(event.start_date) - new Date()) / (1000 * 60 * 60 * 24));\\n  \\n  return {\\n    json: {\\n      ...event,\\n      daysUntil,\\n      trigger: daysUntil === 7 ? 'week' : daysUntil === 1 ? 'tomorrow' : daysUntil === 0 ? 'today' : null\\n    }\\n  };\\n}).filter(item => item.json.trigger);\"
         },
         \"name\": \"Calculate Trigger\",
         \"type\": \"n8n-nodes-base.function\",
         \"position\": [650, 300]
       },
       {
         \"parameters\": {
           \"values\": {
             \"string\": [
               {
                 \"name\": \"message\",
                 \"value\": \"={{$json.trigger === 'week' ? '📅 1 week until ' + $json.name + '! Have you gotten your tickets?' : $json.trigger === 'tomorrow' ? '⏰ TOMORROW: ' + $json.name + ' - Don\\'t forget!' : '🎉 TODAY: ' + $json.name + ' starts at ' + $json.start_time}}\"
               }
             ]
           }
         },
         \"name\": \"Prepare Message\",
         \"type\": \"n8n-nodes-base.set\",
         \"position\": [850, 300]
       }
     ]
   }
   "
   ```

3. **Create capacity monitoring**
   ```bash
   DC: write "workflows/capacity-monitor.json" "
   {
     \"name\": \"Capacity Monitoring\",
     \"nodes\": [
       {
         \"parameters\": {
           \"resource\": \"tickets\",
           \"events\": [\"INSERT\"],
           \"additionalFields\": {
             \"filter\": \"status=eq.sold\"
           }
         },
         \"name\": \"Ticket Sold Trigger\",
         \"type\": \"n8n-nodes-base.supabaseTrigger\",
         \"position\": [250, 300]
       },
       {
         \"parameters\": {
           \"sql\": \"SELECT e.*, COUNT(t.id) as sold_count, (COUNT(t.id)::float / e.capacity * 100) as capacity_percentage FROM events e LEFT JOIN tickets t ON e.id = t.event_id WHERE e.id = '{{$json.event_id}}' AND t.status = 'sold' GROUP BY e.id\"
         },
         \"name\": \"Check Capacity\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"rules\": [
             {
               \"operation\": \"largerEqual\",
               \"value\": \"={{$json.capacity_percentage}}\",
               \"value2\": 80,
               \"output\": 0
             },
             {
               \"operation\": \"largerEqual\",
               \"value\": \"={{$json.capacity_percentage}}\",
               \"value2\": 90,
               \"output\": 1
             },
             {
               \"operation\": \"equal\",
               \"value\": \"={{$json.capacity_percentage}}\",
               \"value2\": 100,
               \"output\": 2
             }
           ],
           \"fallbackOutput\": 3
         },
         \"name\": \"Check Threshold\",
         \"type\": \"n8n-nodes-base.switch\",
         \"position\": [650, 300]
       },
       {
         \"parameters\": {
           \"channel\": \"#event-alerts\",
           \"text\": \"🎫 {{$json.name}} is now {{$json.capacity_percentage}}% sold!\",
           \"attachments\": [
             {
               \"color\": \"warning\",
               \"fields\": [
                 {
                   \"title\": \"Tickets Sold\",
                   \"value\": \"{{$json.sold_count}} / {{$json.capacity}}\"
                 }
               ]
             }
           ]
         },
         \"name\": \"Alert 80% Sold\",
         \"type\": \"n8n-nodes-base.slack\",
         \"position\": [850, 200]
       }
     ]
   }
   "
   ```

4. **Setup contingency workflows**
   ```bash
   DC: write "workflows/weather-contingency.json" "
   {
     \"name\": \"Weather Contingency Plan\",
     \"nodes\": [
       {
         \"parameters\": {
           \"url\": \"https://api.weather.com/v1/location/{{$json.venue.coordinates}}/forecast\",
           \"authentication\": \"genericCredentialType\",
           \"genericAuthType\": \"httpHeaderAuth\",
           \"sendHeaders\": true,
           \"headerParameters\": {
             \"parameters\": [
               {
                 \"name\": \"API-Key\",
                 \"value\": \"={{$credentials.weatherApiKey}}\"
               }
             ]
           }
         },
         \"name\": \"Check Weather\",
         \"type\": \"n8n-nodes-base.httpRequest\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"conditions\": {
             \"boolean\": [
               {
                 \"value1\": \"={{$json.rain_probability}}\",
                 \"operation\": \"largerEqual\",
                 \"value2\": 70
               }
             ]
           }
         },
         \"name\": \"High Rain Probability\",
         \"type\": \"n8n-nodes-base.if\",
         \"position\": [650, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"events\",
           \"operation\": \"update\",
           \"id\": \"={{$json.event_id}}\",
           \"updateFields\": {
             \"venue\": \"={{$json.backup_venue}}\",
             \"notes\": \"Moved indoors due to weather\"
           }
         },
         \"name\": \"Update Venue\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [850, 200]
       },
       {
         \"parameters\": {
           \"message\": \"⚠️ VENUE CHANGE: {{$json.name}} moved to {{$json.backup_venue.name}} due to weather. Same time. Indoor location: {{$json.backup_venue.address}}\"
         },
         \"name\": \"Notify All Stakeholders\",
         \"type\": \"n8n-nodes-base.twilio\",
         \"position\": [1050, 200]
       }
     ]
   }
   "
   ```

5. **Create post-event workflow**
   ```bash
   DC: write "workflows/post-event.json" "
   {
     \"name\": \"Post-Event Automation\",
     \"nodes\": [
       {
         \"parameters\": {
           \"resource\": \"events\",
           \"events\": [\"UPDATE\"],
           \"additionalFields\": {
             \"filter\": \"status=eq.completed\"
           }
         },
         \"name\": \"Event Completed\",
         \"type\": \"n8n-nodes-base.supabaseTrigger\",
         \"position\": [250, 300]
       },
       {
         \"parameters\": {
           \"value\": \"={{new Date($json.end_date).getTime() + 12*60*60*1000}}\",
           \"mode\": \"everyX\",
           \"unit\": \"milliseconds\"
         },
         \"name\": \"Wait 12 Hours\",
         \"type\": \"n8n-nodes-base.wait\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"event_attendees\",
           \"operation\": \"getAll\",
           \"filters\": {
             \"event_id\": \"={{$json.id}}\",
             \"attended\": true
           }
         },
         \"name\": \"Get Attendees\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [650, 200]
       },
       {
         \"parameters\": {
           \"subject\": \"Thank you for attending {{$node['Event Completed'].json.name}}!\",
           \"htmlBody\": \"<p>We hope you enjoyed the show! Please take 2 minutes to share your feedback:</p><a href='https://fashionos.com/feedback/{{$json.event_id}}?attendee={{$json.id}}'>Give Feedback</a>\"
         },
         \"name\": \"Send Feedback Request\",
         \"type\": \"n8n-nodes-base.sendGrid\",
         \"position\": [850, 200]
       },
       {
         \"parameters\": {
           \"resource\": \"event_models\",
           \"operation\": \"getAll\",
           \"filters\": {
             \"event_id\": \"={{$json.id}}\",
             \"status\": \"completed\"
           }
         },
         \"name\": \"Get Models to Pay\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [650, 400]
       },
       {
         \"parameters\": {
           \"resource\": \"payout\",
           \"operation\": \"create\",
           \"amount\": \"={{$json.rate * 0.9}}\",
           \"currency\": \"usd\",
           \"destination\": \"={{$json.stripe_account_id}}\",
           \"metadata\": {
             \"event_id\": \"={{$json.event_id}}\",
             \"model_id\": \"={{$json.model_id}}\"
           }
         },
         \"name\": \"Process Model Payment\",
         \"type\": \"n8n-nodes-base.stripe\",
         \"position\": [850, 400]
       }
     ]
   }
   "
   ```

**Success Criteria**:
- [ ] Event publishing triggers notifications
- [ ] Countdown automation runs daily
- [ ] Capacity alerts working
- [ ] Weather contingency ready
- [ ] Post-event workflow completes

**Testing**:
```bash
# Test event publishing
DC: @supabase sql "UPDATE events SET status = 'published' WHERE id = 'test-event-id';"

# Test countdown trigger
DC: exec "curl -X POST https://n8n.fashionos.com/webhook-test/countdown-test"

# Test capacity alert
DC: @supabase sql "INSERT INTO tickets (event_id, status) SELECT 'test-event-id', 'sold' FROM generate_series(1, 80);"

# Test post-event
DC: @supabase sql "UPDATE events SET status = 'completed' WHERE id = 'test-event-id';"
```

**Troubleshooting**:
- **Notifications not sending**: Check recipient lists
- **Countdown wrong time**: Verify timezone settings
- **Capacity not calculating**: Check SQL query
- **Post-event too soon**: Adjust wait timer

**Checklist**:
- [ ] Publishing workflow active
- [ ] Daily countdown running
- [ ] Capacity monitoring live
- [ ] Weather backup ready
- [ ] Post-event automated

---

## Phase 4: Model Management Automation

### Task 4.1: Model Booking Workflows

**Purpose**: Automate the complete model booking process from initial request to payment, ensuring smooth operations for hundreds of models per event.

**Features**:
1. **Availability checking** - Real-time calendar verification
2. **Conflict detection** - Prevent double bookings
3. **Contract generation** - Automated PDF creation
4. **Approval workflows** - Multi-party confirmations
5. **Payment processing** - Escrow and release systems

**Use Cases**:
1. **Booking requests** - Designer selects model → availability checked → contract sent
2. **Bulk bookings** - Book 20 models for one show in one action
3. **Substitutions** - Model cancels → find replacement → notify designer
4. **Rate negotiations** - Special rates for exclusive bookings
5. **Portfolio updates** - New photos trigger re-evaluation for premium shows

**Real-World Examples**:
1. Dior books Bella Hadid → System checks calendar → Contract for $15K sent → Signed within 1 hour
2. Prada needs 25 models → Bulk selection → 25 contracts sent → 23 confirmed same day
3. Model sick morning of show → AI suggests 3 replacements with same measurements → Designer selects → New model confirmed in 30 minutes
4. Versace wants exclusive model for 3 shows → System calculates package rate → Approval workflow → Deal closed
5. Model uploads new portfolio → AI evaluates → Automatically qualified for high-tier shows → Designers notified

**Steps to Complete**:

1. **Create booking request workflow**
   ```bash
   DC: write "workflows/model-booking-request.json" "
   {
     \"name\": \"Model Booking Request\",
     \"nodes\": [
       {
         \"parameters\": {
           \"httpMethod\": \"POST\",
           \"path\": \"model-booking-request\",
           \"responseMode\": \"responseNode\",
           \"authentication\": \"headerAuth\"
         },
         \"name\": \"Booking Request\",
         \"type\": \"n8n-nodes-base.webhook\",
         \"position\": [250, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"models\",
           \"operation\": \"get\",
           \"id\": \"={{$json.model_id}}\"
         },
         \"name\": \"Get Model Details\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"functionCode\": \"const modelAvailability = $json.availability || [];\\nconst requestedDate = new Date($('Booking Request').item.json.show_date);\\nconst dateStr = requestedDate.toISOString().split('T')[0];\\n\\n// Check if date is in availability array\\nconst isAvailable = modelAvailability.includes(dateStr);\\n\\n// Check for existing bookings\\nconst { data: existingBookings } = await $('Supabase').getAll({\\n  resource: 'event_models',\\n  filters: {\\n    model_id: $json.id,\\n    show_date: `${dateStr}T00:00:00.000Z,${dateStr}T23:59:59.999Z`,\\n    status: 'in.{confirmed,pending}'\\n  }\\n});\\n\\nconst hasConflict = existingBookings && existingBookings.length > 0;\\n\\nreturn {\\n  available: isAvailable && !hasConflict,\\n  reason: !isAvailable ? 'Not available on this date' : hasConflict ? 'Already booked' : null,\\n  model: $json,\\n  existingBookings\\n};\"
         },
         \"name\": \"Check Availability\",
         \"type\": \"n8n-nodes-base.function\",
         \"position\": [650, 300]
       },
       {
         \"parameters\": {
           \"conditions\": {
             \"boolean\": [
               {
                 \"value1\": \"={{$json.available}}\",
                 \"value2\": true
               }
             ]
           }
         },
         \"name\": \"Is Available?\",
         \"type\": \"n8n-nodes-base.if\",
         \"position\": [850, 300]
       },
       {
         \"parameters\": {
           \"operation\": \"generateDocument\",
           \"documentType\": \"contract\",
           \"template\": \"model_booking_contract\",
           \"data\": {
             \"model_name\": \"={{$json.model.name}}\",
             \"designer_name\": \"={{$('Booking Request').item.json.designer_name}}\",
             \"show_date\": \"={{$('Booking Request').item.json.show_date}}\",
             \"rate\": \"={{$json.model.rate_per_show}}\",
             \"call_time\": \"={{$('Booking Request').item.json.call_time}}\",
             \"venue\": \"={{$('Booking Request').item.json.venue}}\"
           }
         },
         \"name\": \"Generate Contract\",
         \"type\": \"n8n-nodes-base.documentGeneration\",
         \"position\": [1050, 200]
       },
       {
         \"parameters\": {
           \"resource\": \"event_models\",
           \"operation\": \"insert\",
           \"columns\": \"event_id,model_id,designer_id,show_date,rate,status,contract_url\",
           \"values\": \"{{$('Booking Request').item.json.event_id}},{{$json.model.id}},{{$('Booking Request').item.json.designer_id}},{{$('Booking Request').item.json.show_date}},{{$json.model.rate_per_show}},pending,{{$('Generate Contract').item.json.url}}\"
         },
         \"name\": \"Create Booking Record\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [1250, 200]
       },
       {
         \"parameters\": {
           \"to\": \"={{$json.model.phone}}\",
           \"message\": \"📋 New booking request from {{$('Booking Request').item.json.designer_name}} for {{$('Booking Request').item.json.show_date}}. Contract: {{$('Generate Contract').item.json.url}}\"
         },
         \"name\": \"Notify Model\",
         \"type\": \"n8n-nodes-base.whatsApp\",
         \"position\": [1450, 200]
       },
       {
         \"parameters\": {
           \"functionCode\": \"// Find alternative models\\nconst unavailableModel = $('Check Availability').item.json.model;\\nconst requestedDate = $('Booking Request').item.json.show_date;\\n\\n// Get similar models\\nconst { data: alternatives } = await $('Supabase').getAll({\\n  resource: 'models',\\n  filters: {\\n    experience_level: unavailableModel.experience_level,\\n    rate_per_show: `lte.${unavailableModel.rate_per_show * 1.2}`,\\n    rate_per_show: `gte.${unavailableModel.rate_per_show * 0.8}`\\n  },\\n  limit: 5\\n});\\n\\n// Check their availability\\nconst availableAlternatives = [];\\nfor (const alt of alternatives) {\\n  const available = alt.availability?.includes(requestedDate.split('T')[0]);\\n  if (available) {\\n    availableAlternatives.push(alt);\\n  }\\n}\\n\\nreturn {\\n  original_model: unavailableModel.name,\\n  reason: $('Check Availability').item.json.reason,\\n  alternatives: availableAlternatives\\n};\"
         },
         \"name\": \"Find Alternatives\",
         \"type\": \"n8n-nodes-base.function\",
         \"position\": [1050, 400]
       }
     ]
   }
   "
   ```

2. **Setup bulk booking workflow**
   ```bash
   DC: write "workflows/bulk-model-booking.json" "
   {
     \"name\": \"Bulk Model Booking\",
     \"nodes\": [
       {
         \"parameters\": {
           \"httpMethod\": \"POST\",
           \"path\": \"bulk-booking\",
           \"responseMode\": \"lastNode\"
         },
         \"name\": \"Bulk Request\",
         \"type\": \"n8n-nodes-base.webhook\",
         \"position\": [250, 300]
       },
       {
         \"parameters\": {
           \"fieldToSplitOut\": \"model_ids\",
           \"options\": {}
         },
         \"name\": \"Split Model IDs\",
         \"type\": \"n8n-nodes-base.itemLists\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"batchSize\": 5,
           \"options\": {}
         },
         \"name\": \"Process in Batches\",
         \"type\": \"n8n-nodes-base.splitInBatches\",
         \"position\": [650, 300]
       },
       {
         \"parameters\": {
           \"url\": \"https://n8n.fashionos.com/webhook/model-booking-request\",
           \"method\": \"POST\",
           \"sendBody\": true,
           \"bodyParameters\": {
             \"parameters\": [
               {
                 \"name\": \"model_id\",
                 \"value\": \"={{$json}}\",
               },
               {
                 \"name\": \"event_id\",
                 \"value\": \"={{$('Bulk Request').item.json.event_id}}\"
               },
               {
                 \"name\": \"designer_id\",
                 \"value\": \"={{$('Bulk Request').item.json.designer_id}}\"
               },
               {
                 \"name\": \"show_date\",
                 \"value\": \"={{$('Bulk Request').item.json.show_date}}\"
               }
             ]
           }
         },
         \"name\": \"Book Each Model\",
         \"type\": \"n8n-nodes-base.httpRequest\",
         \"position\": [850, 300]
       },
       {
         \"parameters\": {
           \"functionCode\": \"const results = $items().map(item => item.json);\\nconst successful = results.filter(r => r.status === 'success').length;\\nconst failed = results.filter(r => r.status === 'failed').length;\\n\\nreturn {\\n  total_requested: results.length,\\n  successful_bookings: successful,\\n  failed_bookings: failed,\\n  success_rate: (successful / results.length * 100).toFixed(1) + '%',\\n  details: results\\n};\"
         },
         \"name\": \"Summarize Results\",
         \"type\": \"n8n-nodes-base.function\",
         \"position\": [1050, 300]
       }
     ]
   }
   "
   ```

3. **Create substitution workflow**
   ```bash
   DC: write "workflows/model-substitution.json" "
   {
     \"name\": \"Model Substitution Workflow\",
     \"nodes\": [
       {
         \"parameters\": {
           \"resource\": \"event_models\",
           \"events\": [\"UPDATE\"],
           \"additionalFields\": {
             \"filter\": \"status=eq.cancelled\"
           }
         },
         \"name\": \"Cancellation Trigger\",
         \"type\": \"n8n-nodes-base.supabaseTrigger\",
         \"position\": [250, 300]
       },
       {
         \"parameters\": {
           \"functionCode\": \"const cancelledBooking = $json;\\nconst showDate = new Date(cancelledBooking.show_date);\\nconst hoursUntilShow = (showDate - new Date()) / (1000 * 60 * 60);\\n\\nreturn {\\n  ...cancelledBooking,\\n  hoursUntilShow,\\n  isUrgent: hoursUntilShow < 24,\\n  priority: hoursUntilShow < 6 ? 'critical' : hoursUntilShow < 24 ? 'high' : 'normal'\\n};\"
         },
         \"name\": \"Calculate Urgency\",
         \"type\": \"n8n-nodes-base.function\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"models\",
           \"operation\": \"get\",
           \"id\": \"={{$json.model_id}}\"
         },
         \"name\": \"Get Cancelled Model\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [650, 300]
       },
       {
         \"parameters\": {
           \"method\": \"POST\",
           \"url\": \"https://api.openai.com/v1/embeddings\",
           \"authentication\": \"headerAuth\",
           \"sendHeaders\": true,
           \"headerParameters\": {
             \"parameters\": [
               {
                 \"name\": \"Authorization\",
                 \"value\": \"Bearer {{$credentials.openaiApiKey}}\"
               }
             ]
           },
           \"sendBody\": true,
           \"bodyParameters\": {
             \"parameters\": [
               {
                 \"name\": \"model\",
                 \"value\": \"text-embedding-ada-002\"
               },
               {
                 \"name\": \"input\",
                 \"value\": \"{{$json.measurements}} {{$json.experience_level}} {{$json.style_tags}}\"
               }
             ]
           }
         },
         \"name\": \"Get Model Embedding\",
         \"type\": \"n8n-nodes-base.httpRequest\",
         \"position\": [850, 300]
       },
       {
         \"parameters\": {
           \"sql\": \"WITH model_vectors AS (\\n  SELECT \\n    m.*,\\n    1 - (m.embedding <=> '{{$json.data[0].embedding}}') as similarity\\n  FROM models m\\n  WHERE m.id != '{{$('Get Cancelled Model').item.json.id}}'\\n    AND '{{$('Cancellation Trigger').item.json.show_date}}'::date = ANY(m.availability)\\n    AND NOT EXISTS (\\n      SELECT 1 FROM event_models em \\n      WHERE em.model_id = m.id \\n        AND em.show_date = '{{$('Cancellation Trigger').item.json.show_date}}'\\n        AND em.status IN ('confirmed', 'pending')\\n    )\\n)\\nSELECT * FROM model_vectors \\nWHERE similarity > 0.8\\nORDER BY similarity DESC\\nLIMIT 5\"
         },
         \"name\": \"Find Similar Available\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [1050, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"messages\",
           \"operation\": \"create\",
           \"to\": \"={{$('Cancellation Trigger').item.json.designer_phone}}\",
           \"templateName\": \"model_cancellation\",
           \"templateData\": {
             \"model_name\": \"={{$('Get Cancelled Model').item.json.name}}\",
             \"show_date\": \"={{$('Cancellation Trigger').item.json.show_date}}\",
             \"alternatives_count\": \"={{$json.length}}\",
             \"urgency\": \"={{$('Calculate Urgency').item.json.priority}}\"
           }
         },
         \"name\": \"Notify Designer\",
         \"type\": \"n8n-nodes-base.whatsApp\",
         \"position\": [1250, 200]
       },
       {
         \"parameters\": {
           \"subject\": \"Urgent: Model Replacement Needed\",
           \"toEmail\": \"={{$('Cancellation Trigger').item.json.designer_email}}\",
           \"htmlBody\": \"<h2>Model Cancellation - {{$('Calculate Urgency').item.json.priority}} Priority</h2>\\n<p>{{$('Get Cancelled Model').item.json.name}} has cancelled for your show on {{$('Cancellation Trigger').item.json.show_date}}.</p>\\n<h3>Recommended Replacements:</h3>\\n<ul>\\n{{#each $('Find Similar Available').item.json}}\\n<li>{{this.name}} - {{this.rate_per_show}} - {{(this.similarity * 100).toFixed(0)}}% match</li>\\n{{/each}}\\n</ul>\\n<a href='https://fashionos.com/quick-book/{{$('Cancellation Trigger').item.json.id}}'>Quick Book Replacement</a>\"
         },
         \"name\": \"Email Alternatives\",
         \"type\": \"n8n-nodes-base.sendGrid\",
         \"position\": [1250, 400]
       }
     ]
   }
   "
   ```

4. **Setup rate negotiation workflow**
   ```bash
   DC: write "workflows/rate-negotiation.json" "
   {
     \"name\": \"Rate Negotiation Workflow\",
     \"nodes\": [
       {
         \"parameters\": {
           \"httpMethod\": \"POST\",
           \"path\": \"rate-negotiation\",
           \"responseMode\": \"responseNode\"
         },
         \"name\": \"Negotiation Request\",
         \"type\": \"n8n-nodes-base.webhook\",
         \"position\": [250, 300]
       },
       {
         \"parameters\": {
           \"functionCode\": \"const request = $json;\\nconst standardRate = request.model_rate;\\nconst proposedRate = request.proposed_rate;\\nconst showCount = request.show_count || 1;\\n\\n// Calculate discount percentage\\nconst discountPercent = ((standardRate - proposedRate) / standardRate * 100);\\n\\n// Business rules for auto-approval\\nconst autoApprove = (\\n  (showCount >= 3 && discountPercent <= 15) ||\\n  (showCount >= 5 && discountPercent <= 25) ||\\n  (request.designer_tier === 'luxury' && discountPercent <= 10)\\n);\\n\\n// Calculate package value\\nconst standardTotal = standardRate * showCount;\\nconst proposedTotal = proposedRate * showCount;\\nconst savings = standardTotal - proposedTotal;\\n\\nreturn {\\n  ...request,\\n  discountPercent,\\n  autoApprove,\\n  standardTotal,\\n  proposedTotal,\\n  savings,\\n  requiresApproval: !autoApprove\\n};\"
         },
         \"name\": \"Evaluate Offer\",
         \"type\": \"n8n-nodes-base.function\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"conditions\": {
             \"boolean\": [
               {
                 \"value1\": \"={{$json.autoApprove}}\",
                 \"value2\": true
               }
             ]
           }
         },
         \"name\": \"Auto-Approve?\",
         \"type\": \"n8n-nodes-base.if\",
         \"position\": [650, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"rate_negotiations\",
           \"operation\": \"insert\",
           \"columns\": \"model_id,designer_id,standard_rate,proposed_rate,show_count,status,approved_at\",
           \"values\": \"{{$json.model_id}},{{$json.designer_id}},{{$json.standardRate}},{{$json.proposedRate}},{{$json.show_count}},approved,{{new Date()}}\"
         },
         \"name\": \"Approve Deal\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [850, 200]
       },
       {
         \"parameters\": {
           \"resource\": \"approval_requests\",
           \"operation\": \"insert\",
           \"columns\": \"type,data,priority,requested_by\",
           \"values\": \"rate_negotiation,{{JSON.stringify($json)}},high,{{$json.designer_id}}\"
         },
         \"name\": \"Create Approval Request\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [850, 400]
       },
       {
         \"parameters\": {
           \"channel\": \"#rate-approvals\",
           \"text\": \"New rate negotiation requires approval\",
           \"attachments\": [
             {
               \"color\": \"warning\",
               \"fields\": [
                 {\"title\": \"Model\", \"value\": \"{{$json.model_name}}\", \"short\": true},
                 {\"title\": \"Designer\", \"value\": \"{{$json.designer_name}}\", \"short\": true},
                 {\"title\": \"Shows\", \"value\": \"{{$json.show_count}}\", \"short\": true},
                 {\"title\": \"Discount\", \"value\": \"{{$json.discountPercent}}%\", \"short\": true},
                 {\"title\": \"Total Value\", \"value\": \"${{$json.proposedTotal}}\", \"short\": true},
                 {\"title\": \"Savings\", \"value\": \"${{$json.savings}}\", \"short\": true}
               ],
               \"actions\": [
                 {
                   \"type\": \"button\",
                   \"text\": \"Approve\",
                   \"style\": \"primary\",
                   \"value\": \"approve_{{$json.id}}\"
                 },
                 {
                   \"type\": \"button\",
                   \"text\": \"Reject\",
                   \"style\": \"danger\",
                   \"value\": \"reject_{{$json.id}}\"
                 }
               ]
             }
           ]
         },
         \"name\": \"Slack Approval\",
         \"type\": \"n8n-nodes-base.slack\",
         \"position\": [1050, 400]
       }
     ]
   }
   "
   ```

5. **Create portfolio evaluation workflow**
   ```bash
   DC: write "workflows/portfolio-evaluation.json" "
   {
     \"name\": \"Portfolio Auto-Evaluation\",
     \"nodes\": [
       {
         \"parameters\": {
           \"resource\": \"file_uploads\",
           \"events\": [\"INSERT\"],
           \"additionalFields\": {
             \"filter\": \"entity_type=eq.model\"
           }
         },
         \"name\": \"New Portfolio Upload\",
         \"type\": \"n8n-nodes-base.supabaseTrigger\",
         \"position\": [250, 300]
       },
       {
         \"parameters\": {
           \"url\": \"https://api.openai.com/v1/chat/completions\",
           \"method\": \"POST\",
           \"authentication\": \"headerAuth\",
           \"sendHeaders\": true,
           \"headerParameters\": {
             \"parameters\": [{
               \"name\": \"Authorization\",
               \"value\": \"Bearer {{$credentials.openaiApiKey}}\"
             }]
           },
           \"sendBody\": true,
           \"bodyParameters\": {
             \"parameters\": [
               {
                 \"name\": \"model\",
                 \"value\": \"gpt-4-vision-preview\"
               },
               {
                 \"name\": \"messages\",
                 \"value\": [
                   {
                     \"role\": \"system\",
                     \"content\": \"You are a fashion industry expert evaluating model portfolios. Rate: Professional quality, Versatility, High-fashion potential, Commercial appeal, Unique features.\"
                   },
                   {
                     \"role\": \"user\",
                     \"content\": [
                       {\"type\": \"text\", \"text\": \"Evaluate this model portfolio photo\"},
                       {\"type\": \"image_url\", \"image_url\": {\"url\": \"{{$json.file_url}}\"}}
                     ]
                   }
                 ]
               }
             ]
           }
         },
         \"name\": \"AI Evaluation\",
         \"type\": \"n8n-nodes-base.httpRequest\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"functionCode\": \"const evaluation = JSON.parse($json.choices[0].message.content);\\nconst scores = evaluation.scores || {};\\n\\n// Calculate tier based on scores\\nconst avgScore = Object.values(scores).reduce((a, b) => a + b, 0) / Object.values(scores).length;\\n\\nconst tier = \\n  avgScore >= 4.5 ? 'supermodel' :\\n  avgScore >= 4.0 ? 'high_fashion' :\\n  avgScore >= 3.5 ? 'professional' :\\n  avgScore >= 3.0 ? 'commercial' : 'emerging';\\n\\n// Determine which designer tiers to notify\\nconst qualifiedForTiers = [];\\nif (tier === 'supermodel' || tier === 'high_fashion') {\\n  qualifiedForTiers.push('luxury', 'haute_couture');\\n}\\nif (avgScore >= 3.5) {\\n  qualifiedForTiers.push('established');\\n}\\nif (avgScore >= 3.0) {\\n  qualifiedForTiers.push('emerging');\\n}\\n\\nreturn {\\n  model_id: $('New Portfolio Upload').item.json.entity_id,\\n  evaluation,\\n  avgScore,\\n  tier,\\n  qualifiedForTiers,\\n  notify: qualifiedForTiers.length > 0\\n};\"
         },
         \"name\": \"Calculate Tier\",
         \"type\": \"n8n-nodes-base.function\",
         \"position\": [650, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"models\",
           \"operation\": \"update\",
           \"id\": \"={{$json.model_id}}\",
           \"updateFields\": {
             \"portfolio_score\": \"={{$json.avgScore}}\",
             \"tier\": \"={{$json.tier}}\",
             \"last_evaluated\": \"={{new Date()}}\",
             \"qualified_tiers\": \"={{$json.qualifiedForTiers}}\"
           }
         },
         \"name\": \"Update Model Profile\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [850, 300]
       },
       {
         \"parameters\": {
           \"conditions\": {
             \"boolean\": [{
               \"value1\": \"={{$json.notify}}\",
               \"value2\": true
             }]
           }
         },
         \"name\": \"Should Notify?\",
         \"type\": \"n8n-nodes-base.if\",
         \"position\": [1050, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"designers\",
           \"operation\": \"getAll\",
           \"filters\": {
             \"brand_tier\": \"in.{{$json.qualifiedForTiers}}\",
             \"actively_booking\": true
           }
         },
         \"name\": \"Get Qualified Designers\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [1250, 200]
       },
       {
         \"parameters\": {
           \"subject\": \"New {{$('Calculate Tier').item.json.tier}} Model Available\",
           \"toEmail\": \"={{$json.email}}\",
           \"htmlBody\": \"<p>A new model matching your tier has updated their portfolio.</p><p>Average Score: {{$('Calculate Tier').item.json.avgScore}}/5</p><a href='https://fashionos.com/models/{{$('Calculate Tier').item.json.model_id}}'>View Profile</a>\"
         },
         \"name\": \"Notify Designers\",
         \"type\": \"n8n-nodes-base.sendGrid\",
         \"position\": [1450, 200]
       }
     ]
   }
   "
   ```

**Success Criteria**:
- [ ] Booking requests process automatically
- [ ] Bulk bookings work efficiently
- [ ] Substitutions find good matches
- [ ] Rate negotiations follow rules
- [ ] Portfolio evaluations accurate

**Testing**:
```bash
# Test single booking
DC: exec "curl -X POST https://n8n.fashionos.com/webhook/model-booking-request \
  -H 'Content-Type: application/json' \
  -d '{\"model_id\": \"test-model\", \"designer_id\": \"test-designer\", \"show_date\": \"2024-10-15T14:00:00Z\"}'"

# Test bulk booking
DC: exec "curl -X POST https://n8n.fashionos.com/webhook/bulk-booking \
  -H 'Content-Type: application/json' \
  -d '{\"model_ids\": [\"model1\", \"model2\", \"model3\"], \"event_id\": \"test-event\"}'"

# Test cancellation
DC: @supabase sql "UPDATE event_models SET status = 'cancelled' WHERE id = 'test-booking';"

# Test rate negotiation
DC: exec "curl -X POST https://n8n.fashionos.com/webhook/rate-negotiation \
  -d '{\"model_id\": \"test-model\", \"proposed_rate\": 4500, \"show_count\": 3}'"
```

**Troubleshooting**:
- **Availability check fails**: Verify date format matching
- **Contract generation error**: Check template exists
- **Alternatives not found**: Adjust similarity threshold
- **Notifications not sent**: Verify contact information

**Checklist**:
- [ ] Booking workflow complete
- [ ] Bulk operations tested
- [ ] Substitution AI working
- [ ] Rate logic implemented
- [ ] Portfolio evaluation active

---

## Phase 5: Communication Workflows

### Task 5.1: Multi-Channel Messaging

**Purpose**: Create unified communication workflows that reach stakeholders through their preferred channels with consistent messaging and tracking.

**Features**:
1. **Channel preference routing** - WhatsApp, SMS, Email based on user preference
2. **Message templating** - Consistent branding across channels
3. **Delivery tracking** - Know who received what when
4. **Language localization** - Auto-translate for international events
5. **Unsubscribe handling** - Respect communication preferences

**Use Cases**:
1. **Event announcements** - Reach 50,000 people across 3 channels
2. **Urgent updates** - Show delay notifications in under 2 minutes
3. **Personalized reminders** - Custom messages based on ticket type
4. **Follow-up sequences** - Multi-touch post-event engagement
5. **Emergency broadcasts** - Venue evacuation instructions

**Real-World Examples**:
1. Runway show delayed 30min → 500 attendees get SMS, 200 VIPs get WhatsApp, 1000 general get email
2. Sponsor commits $100K → CEO gets personal WhatsApp, team gets Slack, accounting gets email
3. Model confirms booking → Agent gets SMS in English, model gets WhatsApp in Portuguese
4. Fire alarm at venue → Everyone gets SMS + automated phone call with evacuation instructions
5. Post-show → VIPs get thank you video via WhatsApp, general attendees get email survey

**Steps to Complete**:

1. **Create unified messaging workflow**
   ```bash
   DC: write "workflows/unified-messaging.json" "
   {
     \"name\": \"Unified Messaging System\",
     \"nodes\": [
       {
         \"parameters\": {
           \"httpMethod\": \"POST\",
           \"path\": \"send-message\",
           \"responseMode\": \"responseNode\"
         },
         \"name\": \"Message Request\",
         \"type\": \"n8n-nodes-base.webhook\",
         \"position\": [250, 300]
       },
       {
         \"parameters\": {
           \"functionCode\": \"// Determine recipient list\\nconst request = $json;\\nlet recipients = [];\\n\\nif (request.recipient_type === 'individual') {\\n  recipients = [request.recipient];\\n} else if (request.recipient_type === 'segment') {\\n  // Get segment from database\\n  const { data } = await $('Supabase').getAll({\\n    resource: request.segment_table,\\n    filters: request.segment_filters\\n  });\\n  recipients = data;\\n} else if (request.recipient_type === 'custom_list') {\\n  recipients = request.recipients;\\n}\\n\\n// Get communication preferences\\nfor (let recipient of recipients) {\\n  const { data: prefs } = await $('Supabase').get({\\n    resource: 'communication_preferences',\\n    id: recipient.user_id || recipient.id\\n  });\\n  \\n  recipient.preferences = prefs || {\\n    primary_channel: 'email',\\n    language: 'en',\\n    timezone: 'America/Toronto'\\n  };\\n}\\n\\nreturn recipients;\"
         },
         \"name\": \"Get Recipients\",
         \"type\": \"n8n-nodes-base.function\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"batchSize\": 50,
           \"options\": {}
         },
         \"name\": \"Batch Recipients\",
         \"type\": \"n8n-nodes-base.splitInBatches\",
         \"position\": [650, 300]
       },
       {
         \"parameters\": {
           \"mode\": \"multipleFields\",
           \"fields\": {
             \"values\": [
               {
                 \"fieldName\": \"recipient.preferences.primary_channel\",
                 \"fieldValue\": \"whatsapp\"
               },
               {
                 \"fieldName\": \"recipient.preferences.primary_channel\",
                 \"fieldValue\": \"sms\"
               },
               {
                 \"fieldName\": \"recipient.preferences.primary_channel\",
                 \"fieldValue\": \"email\"
               }
             ]
           },
           \"outputs\": 3
         },
         \"name\": \"Route by Channel\",
         \"type\": \"n8n-nodes-base.switch\",
         \"position\": [850, 300]
       },
       {
         \"parameters\": {
           \"to\": \"={{$json.recipient.phone}}\",
           \"templateName\": \"{{$('Message Request').item.json.template_name}}\",
           \"templateLanguage\": \"{{$json.recipient.preferences.language}}\",
           \"templateData\": \"{{$('Message Request').item.json.template_data}}\"
         },
         \"name\": \"Send WhatsApp\",
         \"type\": \"n8n-nodes-base.whatsApp\",
         \"position\": [1050, 200]
       },
       {
         \"parameters\": {
           \"to\": \"={{$json.recipient.phone}}\",
           \"message\": \"{{$('Message Request').item.json.message}}\",
           \"fromNumber\": \"+1234567890\"
         },
         \"name\": \"Send SMS\",
         \"type\": \"n8n-nodes-base.twilio\",
         \"position\": [1050, 300]
       },
       {
         \"parameters\": {
           \"toEmail\": \"={{$json.recipient.email}}\",
           \"subject\": \"{{$('Message Request').item.json.subject}}\",
           \"htmlBody\": \"{{$('Message Request').item.json.html_body}}\",
           \"fromEmail\": \"notifications@fashionos.com\"
         },
         \"name\": \"Send Email\",
         \"type\": \"n8n-nodes-base.sendGrid\",
         \"position\": [1050, 400]
       },
       {
         \"parameters\": {
           \"resource\": \"message_logs\",
           \"operation\": \"insert\",
           \"columns\": \"recipient_id,channel,template,status,sent_at,message_id\",
           \"values\": \"{{$json.recipient.id}},{{$json.channel}},{{$('Message Request').item.json.template_name}},sent,{{new Date()}},{{$json.messageId}}\"
         },
         \"name\": \"Log Message\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [1250, 300]
       }
     ]
   }
   "
   ```

2. **Setup urgent broadcast system**
   ```bash
   DC: write "workflows/emergency-broadcast.json" "
   {
     \"name\": \"Emergency Broadcast System\",
     \"nodes\": [
       {
         \"parameters\": {
           \"httpMethod\": \"POST\",
           \"path\": \"emergency-broadcast\",
           \"responseMode\": \"responseNode\",
           \"authentication\": \"headerAuth\"
         },
         \"name\": \"Emergency Trigger\",
         \"type\": \"n8n-nodes-base.webhook\",
         \"position\": [250, 300]
       },
       {
         \"parameters\": {
           \"functionCode\": \"const emergency = $json;\\n\\n// Validate emergency level\\nconst validLevels = ['info', 'warning', 'urgent', 'critical'];\\nif (!validLevels.includes(emergency.level)) {\\n  throw new Error('Invalid emergency level');\\n}\\n\\n// Get all affected people\\nlet affected = [];\\n\\nif (emergency.scope === 'event') {\\n  // Get everyone at specific event\\n  const { data: attendees } = await $('Supabase').getAll({\\n    resource: 'event_attendees',\\n    filters: { event_id: emergency.event_id }\\n  });\\n  const { data: models } = await $('Supabase').getAll({\\n    resource: 'event_models',\\n    filters: { event_id: emergency.event_id, status: 'confirmed' }\\n  });\\n  const { data: staff } = await $('Supabase').getAll({\\n    resource: 'event_staff',\\n    filters: { event_id: emergency.event_id }\\n  });\\n  \\n  affected = [...attendees, ...models, ...staff];\\n} else if (emergency.scope === 'venue') {\\n  // Get everyone at venue today\\n  const { data } = await $('Supabase').sql({\\n    query: `SELECT DISTINCT u.* FROM users u\\n            JOIN event_attendees ea ON u.id = ea.user_id\\n            JOIN events e ON ea.event_id = e.id\\n            WHERE e.venue->>'name' = $1 \\n            AND e.start_date::date = CURRENT_DATE`,\\n    params: [emergency.venue_name]\\n  });\\n  affected = data;\\n}\\n\\n// For critical emergencies, override all preferences\\nif (emergency.level === 'critical') {\\n  affected = affected.map(person => ({\\n    ...person,\\n    force_sms: true,\\n    force_call: true\\n  }));\\n}\\n\\nreturn {\\n  emergency,\\n  affected_count: affected.length,\\n  recipients: affected\\n};\"
         },
         \"name\": \"Get Affected People\",
         \"type\": \"n8n-nodes-base.function\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"batchSize\": 100,
           \"options\": {}
         },
         \"name\": \"Batch for Speed\",
         \"type\": \"n8n-nodes-base.splitInBatches\",
         \"position\": [650, 300]
       },
       {
         \"parameters\": {
           \"to\": \"={{$json.phone}}\",
           \"message\": \"🚨 {{$('Get Affected People').item.json.emergency.level.toUpperCase()}} ALERT: {{$('Get Affected People').item.json.emergency.message}}\",
           \"messagingServiceSid\": \"{{$credentials.twilioEmergencyServiceSid}}\"
         },
         \"name\": \"Send Emergency SMS\",
         \"type\": \"n8n-nodes-base.twilio\",
         \"position\": [850, 200]
       },
       {
         \"parameters\": {
           \"conditions\": {
             \"boolean\": [{
               \"value1\": \"={{$json.force_call}}\",
               \"value2\": true
             }]
           }
         },
         \"name\": \"Needs Call?\",
         \"type\": \"n8n-nodes-base.if\",
         \"position\": [850, 400]
       },
       {
         \"parameters\": {
           \"to\": \"={{$json.phone}}\",
           \"twiml\": \"<Response><Say voice='alice' language='en-US'>This is an emergency alert from Fashion OS. {{$('Get Affected People').item.json.emergency.message}}. Please follow emergency procedures immediately.</Say></Response>\"
         },
         \"name\": \"Emergency Call\",
         \"type\": \"n8n-nodes-base.twilio\",
         \"position\": [1050, 400]
       },
       {
         \"parameters\": {
           \"resource\": \"emergency_logs\",
           \"operation\": \"insert\",
           \"columns\": \"level,scope,message,affected_count,triggered_by,sent_at\",
           \"values\": \"{{$('Get Affected People').item.json.emergency.level}},{{$('Get Affected People').item.json.emergency.scope}},{{$('Get Affected People').item.json.emergency.message}},{{$('Get Affected People').item.json.affected_count}},{{$('Emergency Trigger').item.json.triggered_by}},{{new Date()}}\"
         },
         \"name\": \"Log Emergency\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [1250, 300]
       }
     ]
   }
   "
   ```

3. **Create localization workflow**
   ```bash
   DC: write "workflows/message-localization.json" "
   {
     \"name\": \"Message Localization\",
     \"nodes\": [
       {
         \"parameters\": {
           \"functionCode\": \"const message = $json.message;\\nconst targetLanguage = $json.language;\\nconst templateData = $json.template_data || {};\\n\\n// Check if translation exists in cache\\nconst cacheKey = `translation:${targetLanguage}:${Buffer.from(message).toString('base64')}`;\\nconst { data: cached } = await $('Supabase').get({\\n  resource: 'translation_cache',\\n  filters: { cache_key: cacheKey }\\n});\\n\\nif (cached) {\\n  return {\\n    original: message,\\n    translated: cached.translated_text,\\n    language: targetLanguage,\\n    from_cache: true\\n  };\\n}\\n\\n// If not cached, proceed to translation\\nreturn {\\n  message,\\n  targetLanguage,\\n  templateData,\\n  needs_translation: true\\n};\"
         },
         \"name\": \"Check Cache\",
         \"type\": \"n8n-nodes-base.function\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"conditions\": {
             \"boolean\": [{
               \"value1\": \"={{$json.needs_translation}}\",
               \"value2\": true
             }]
           }
         },
         \"name\": \"Needs Translation?\",
         \"type\": \"n8n-nodes-base.if\",
         \"position\": [650, 300]
       },
       {
         \"parameters\": {
           \"method\": \"POST\",
           \"url\": \"https://api.deepl.com/v2/translate\",
           \"authentication\": \"headerAuth\",
           \"sendHeaders\": true,
           \"headerParameters\": {
             \"parameters\": [{
               \"name\": \"Authorization\",
               \"value\": \"DeepL-Auth-Key {{$credentials.deeplApiKey}}\"
             }]
           },
           \"sendBody\": true,
           \"bodyParameters\": {
             \"parameters\": [
               {\"name\": \"text\", \"value\": \"{{$json.message}}\"},
               {\"name\": \"target_lang\", \"value\": \"{{$json.targetLanguage.toUpperCase()}}\"},
               {\"name\": \"source_lang\", \"value\": \"EN\"},
               {\"name\": \"formality\", \"value\": \"prefer_more\"}
             ]
           }
         },
         \"name\": \"Translate Message\",
         \"type\": \"n8n-nodes-base.httpRequest\",
         \"position\": [850, 200]
       },
       {
         \"parameters\": {
           \"resource\": \"translation_cache\",
           \"operation\": \"insert\",
           \"columns\": \"cache_key,original_text,translated_text,language,created_at\",
           \"values\": \"{{$('Check Cache').item.json.cacheKey}},{{$('Check Cache').item.json.message}},{{$json.translations[0].text}},{{$('Check Cache').item.json.targetLanguage}},{{new Date()}}\"
         },
         \"name\": \"Cache Translation\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [1050, 200]
       }
     ]
   }
   "
   ```

4. **Setup follow-up sequences**
   ```bash
   DC: write "workflows/follow-up-sequence.json" "
   {
     \"name\": \"Multi-Touch Follow-up Sequence\",
     \"nodes\": [
       {
         \"parameters\": {
           \"resource\": \"events\",
           \"events\": [\"UPDATE\"],
           \"additionalFields\": {
             \"filter\": \"status=eq.completed\"
           }
         },
         \"name\": \"Event Completed\",
         \"type\": \"n8n-nodes-base.supabaseTrigger\",
         \"position\": [250, 300]
       },
       {
         \"parameters\": {
           \"functionCode\": \"const event = $json;\\nconst sequences = {\\n  'vip': [\\n    { delay_hours: 12, template: 'vip_thank_you', channel: 'whatsapp' },\\n    { delay_hours: 48, template: 'vip_photos', channel: 'email' },\\n    { delay_hours: 168, template: 'vip_next_event', channel: 'whatsapp' }\\n  ],\\n  'general': [\\n    { delay_hours: 24, template: 'general_thank_you', channel: 'email' },\\n    { delay_hours: 72, template: 'general_survey', channel: 'email' },\\n    { delay_hours: 336, template: 'general_discount', channel: 'sms' }\\n  ],\\n  'sponsor': [\\n    { delay_hours: 6, template: 'sponsor_recap', channel: 'email' },\\n    { delay_hours: 24, template: 'sponsor_metrics', channel: 'email' },\\n    { delay_hours: 168, template: 'sponsor_renewal', channel: 'whatsapp' }\\n  ]\\n};\\n\\n// Get all stakeholders\\nconst stakeholders = [];\\n\\n// Get VIP attendees\\nconst { data: vips } = await $('Supabase').getAll({\\n  resource: 'event_attendees',\\n  filters: { event_id: event.id, ticket_type: 'vip' }\\n});\\nvips.forEach(v => stakeholders.push({ ...v, type: 'vip' }));\\n\\n// Get general attendees\\nconst { data: general } = await $('Supabase').getAll({\\n  resource: 'event_attendees',\\n  filters: { event_id: event.id, ticket_type: 'in.{general,student}' }\\n});\\ngeneral.forEach(g => stakeholders.push({ ...g, type: 'general' }));\\n\\n// Get sponsors\\nconst { data: sponsors } = await $('Supabase').getAll({\\n  resource: 'event_sponsors',\\n  filters: { event_id: event.id }\\n});\\nsponsors.forEach(s => stakeholders.push({ ...s, type: 'sponsor' }));\\n\\n// Create sequence tasks\\nconst tasks = [];\\nstakeholders.forEach(stakeholder => {\\n  const sequence = sequences[stakeholder.type];\\n  sequence.forEach(step => {\\n    tasks.push({\\n      stakeholder,\\n      ...step,\\n      scheduled_at: new Date(Date.now() + step.delay_hours * 60 * 60 * 1000)\\n    });\\n  });\\n});\\n\\nreturn tasks;\"
         },
         \"name\": \"Generate Sequences\",
         \"type\": \"n8n-nodes-base.function\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"scheduled_messages\",
           \"operation\": \"insert\",
           \"columns\": \"recipient_id,recipient_type,template,channel,scheduled_at,event_id,status\",
           \"values\": \"{{$json.stakeholder.id}},{{$json.stakeholder.type}},{{$json.template}},{{$json.channel}},{{$json.scheduled_at}},{{$('Event Completed').item.json.id}},pending\"
         },
         \"name\": \"Schedule Messages\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [650, 300]
       },
       {
         \"parameters\": {
           \"rule\": \"*/30 * * * *\",
           \"name\": \"Every 30 minutes\"
         },
         \"name\": \"Sequence Processor\",
         \"type\": \"n8n-nodes-base.cron\",
         \"position\": [250, 500]
       },
       {
         \"parameters\": {
           \"resource\": \"scheduled_messages\",
           \"operation\": \"getAll\",
           \"filters\": {
             \"status\": \"pending\",
             \"scheduled_at\": \"lte.{{new Date().toISOString()}}\"\n           },
           \"limit\": 100
         },
         \"name\": \"Get Due Messages\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [450, 500]
       },
       {
         \"parameters\": {
           \"url\": \"https://n8n.fashionos.com/webhook/send-message\",
           \"method\": \"POST\",
           \"sendBody\": true,
           \"bodyParameters\": {
             \"parameters\": [
               {\"name\": \"recipient_type\", \"value\": \"individual\"},
               {\"name\": \"recipient\", \"value\": \"{{$json}}\"},
               {\"name\": \"template_name\", \"value\": \"{{$json.template}}\"},
               {\"name\": \"channel_override\", \"value\": \"{{$json.channel}}\"}
             ]
           }
         },
         \"name\": \"Send Message\",
         \"type\": \"n8n-nodes-base.httpRequest\",
         \"position\": [650, 500]
       }
     ]
   }
   "
   ```

5. **Create unsubscribe handler**
   ```bash
   DC: write "workflows/unsubscribe-handler.json" "
   {
     \"name\": \"Unsubscribe Handler\",
     \"nodes\": [
       {
         \"parameters\": {
           \"httpMethod\": \"POST\",
           \"path\": \"unsubscribe\",
           \"responseMode\": \"lastNode\"
         },
         \"name\": \"Unsubscribe Request\",
         \"type\": \"n8n-nodes-base.webhook\",
         \"position\": [250, 300]
       },
       {
         \"parameters\": {
           \"functionCode\": \"const request = $json;\\nlet userId;\\nlet channel;\\n\\n// Identify user\\nif (request.email) {\\n  const { data: user } = await $('Supabase').getAll({\\n    resource: 'users',\\n    filters: { email: request.email }\\n  });\\n  userId = user[0]?.id;\\n  channel = 'email';\\n} else if (request.phone) {\\n  const { data: user } = await $('Supabase').getAll({\\n    resource: 'users',\\n    filters: { phone: request.phone }\\n  });\\n  userId = user[0]?.id;\\n  channel = request.from_sms ? 'sms' : 'whatsapp';\\n}\\n\\nif (!userId) {\\n  throw new Error('User not found');\\n}\\n\\nreturn {\\n  userId,\\n  channel,\\n  unsubscribe_type: request.type || 'all',\\n  reason: request.reason\\n};\"
         },
         \"name\": \"Identify User\",
         \"type\": \"n8n-nodes-base.function\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"communication_preferences\",
           \"operation\": \"upsert\",
           \"additionalFields\": {
             \"onConflict\": \"user_id\"
           },
           \"columns\": \"user_id,{{$json.channel}}_enabled,updated_at\",
           \"values\": \"{{$json.userId}},false,{{new Date()}}\"
         },
         \"name\": \"Update Preferences\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [650, 300]
       },
       {
         \"parameters\": {
           \"resource\": \"unsubscribe_logs\",
           \"operation\": \"insert\",
           \"columns\": \"user_id,channel,reason,unsubscribed_at\",
           \"values\": \"{{$json.userId}},{{$json.channel}},{{$json.reason}},{{new Date()}}\"
         },
         \"name\": \"Log Unsubscribe\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [850, 300]
       },
       {
         \"parameters\": {
           \"values\": {
             \"string\": [
               {
                 \"name\": \"message\",
                 \"value\": \"You've been unsubscribed from {{$json.channel}} notifications. You can update your preferences at https://fashionos.com/preferences\"
               }
             ]
           }
         },
         \"name\": \"Confirmation Message\",
         \"type\": \"n8n-nodes-base.set\",
         \"position\": [1050, 300]
       }
     ]
   }
   "
   ```

**Success Criteria**:
- [ ] Multi-channel routing works
- [ ] Emergency broadcast fast
- [ ] Translations accurate
- [ ] Follow-ups scheduled correctly
- [ ] Unsubscribe respected

**Testing**:
```bash
# Test unified messaging
DC: exec "curl -X POST https://n8n.fashionos.com/webhook/send-message \
  -d '{\"recipient_type\": \"segment\", \"segment_table\": \"event_attendees\", \"message\": \"Test message\"}'"

# Test emergency broadcast
DC: exec "curl -X POST https://n8n.fashionos.com/webhook/emergency-broadcast \
  -H 'X-Emergency-Auth: secret-key' \
  -d '{\"level\": \"urgent\", \"scope\": \"event\", \"event_id\": \"test-event\", \"message\": \"Test emergency\"}'"

# Test translation
DC: exec "curl -X POST https://n8n.fashionos.com/webhook-test/translate \
  -d '{\"message\": \"Welcome to Fashion Week\", \"language\": \"es\"}'"

# Test unsubscribe
DC: exec "curl -X POST https://n8n.fashionos.com/webhook/unsubscribe \
  -d '{\"email\": \"test@example.com\", \"reason\": \"Too many emails\"}'"
```

**Troubleshooting**:
- **Messages not routing**: Check preferences exist
- **Emergency slow**: Increase batch size
- **Translation fails**: Verify API keys
- **Follow-ups not sending**: Check cron schedule

**Checklist**:
- [ ] Channel routing configured
- [ ] Emergency system tested
- [ ] Translations working
- [ ] Sequences scheduled
- [ ] Preferences respected

---

## Phase 6: Payment Automations

### Task 6.1: Payment Processing Workflows

**Purpose**: Automate complete payment lifecycle from processing to reconciliation, handling complex multi-party transactions for fashion events.

**Features**:
1. **Multi-party payments** - Split payments between platform, organizers, venues
2. **Escrow management** - Hold designer payments until show completion
3. **Automated payouts** - Pay models after show verification
4. **Refund handling** - Process cancellations and disputes
5. **Financial reporting** - Generate statements and tax documents

**Use Cases**:
1. **Ticket sales** - Process payment → Issue ticket → Send confirmation
2. **Sponsor packages** - Invoice → Payment → Benefit activation
3. **Model payments** - Show complete → Verify attendance → Process payout
4. **Refund requests** - Validate → Process → Update records
5. **Revenue sharing** - Calculate splits → Process transfers → Send statements

**Real-World Examples**:
1. VIP table for 10 at $10K → Stripe processes → 10% platform fee → 90% to organizer → Instant confirmation
2. Model completes 3 shows at $5K each → $15K held in escrow → Shows verified → $13.5K paid (10% fee)
3. Weather cancels outdoor show → 500 tickets auto-refunded → Sponsors get credits → Models get kill fees
4. Monthly statement shows: $1M revenue, $100K platform fees, $50K processing fees, detailed breakdown
5. Sponsor pays $50K → Benefits activate → Logo appears on site → VIP tickets generated → ROI tracking starts

**Steps to Complete**:

1. **Create payment processing workflow**
   ```bash
   DC: write "workflows/payment-processing.json" "
   {
     \"name\": \"Payment Processing Hub\",
     \"nodes\": [
       {
         \"parameters\": {
           \"httpMethod\": \"POST\",
           \"path\": \"stripe-webhook\",
           \"responseMode\": \"responseNode\",
           \"rawBody\": true
         },
         \"name\": \"Stripe Webhook\",
         \"type\": \"n8n-nodes-base.webhook\",
         \"position\": [250, 300]
       },
       {
         \"parameters\": {
           \"functionCode\": \"const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);\\nconst endpointSecret = process.env.STRIPE_WEBHOOK_SECRET;\\n\\nconst sig = $headers['stripe-signature'];\\nconst body = $binary.data.data;\\n\\ntry {\\n  const event = stripe.webhooks.constructEvent(body, sig, endpointSecret);\\n  return {\\n    verified: true,\\n    event\\n  };\\n} catch (err) {\\n  throw new Error(`Webhook signature verification failed: ${err.message}`);\\n}\"
         },
         \"name\": \"Verify Webhook\",
         \"type\": \"n8n-nodes-base.function\",
         \"position\": [450, 300]
       },
       {
         \"parameters\": {
           \"rules\": [
             {
               \"field\": \"={{$json.event.type}}\",
               \"operation\": \"equals\",
               \"value\": \"payment_intent.succeeded\",
               \"output\": 0
             },
             {
               \"field\": \"={{$json.event.type}}\",
               \"operation\": \"equals\",
               \"value\": \"payment_intent.payment_failed\",
               \"output\": 1
             },
             {
               \"field\": \"={{$json.event.type}}\",
               \"operation\": \"equals\",
               \"value\": \"charge.refunded\",
               \"output\": 2
             },
             {
               \"field\": \"={{$json.event.type}}\",
               \"operation\": \"equals\",
               \"value\": \"transfer.created\",
               \"output\": 3
             }
           ],
           \"fallbackOutput\": 4
         },
         \"name\": \"Route by Event Type\",
         \"type\": \"n8n-nodes-base.switch\",
         \"position\": [650, 300]
       },
       {
         \"parameters\": {
           \"functionCode\": \"const payment = $json.event.data.object;\\nconst metadata = payment.metadata;\\n\\n// Calculate platform fee (10%)\\nconst totalAmount = payment.amount;\\nconst platformFee = Math.floor(totalAmount * 0.10);\\nconst organizerAmount = totalAmount - platformFee;\\n\\n// Update based on payment type\\nif (metadata.type === 'ticket') {\\n  // Update ticket status\\n  await $('Supabase').update({\\n    resource: 'tickets',\\n    id: metadata.ticket_id,\\n    updateFields: {\\n      status: 'paid',\\n      payment_intent: payment.id,\\n      paid_at: new Date()\\n    }\\n  });\\n  \\n  // Create transfer to organizer\\n  const transfer = await stripe.transfers.create({\\n    amount: organizerAmount,\\n    currency: 'usd',\\n    destination: metadata.organizer_stripe_account,\\n    transfer_group: `event_${metadata.event_id}`,\\n    metadata: {\\n      event_id: metadata.event_id,\\n      ticket_id: metadata.ticket_id,\\n      platform_fee: platformFee\\n    }\\n  });\\n  \\n  return {\\n    type: 'ticket_sale',\\n    payment,\\n    transfer,\\n    platformFee,\\n    organizerAmount\\n  };\\n} else if (metadata.type === 'sponsor_package') {\\n  // Activate sponsor benefits\\n  await $('Supabase').update({\\n    resource: 'event_sponsors',\\n    id: metadata.sponsor_id,\\n    updateFields: {\\n      payment_status: 'paid',\\n      payment_intent: payment.id,\\n      benefits_active: true,\\n      activated_at: new Date()\\n    }\\n  });\\n  \\n  return {\\n    type: 'sponsor_payment',\\n    payment,\\n    sponsor_id: metadata.sponsor_id\\n  };\\n}\"
         },
         \"name\": \"Process Payment\",
         \"type\": \"n8n-nodes-base.function\",
         \"position\": [850, 200]
       },
       {
         \"parameters\": {
           \"resource\": \"payment_logs\",
           \"operation\": \"insert\",
           \"columns\": \"stripe_event_id,type,amount,status,metadata,processed_at\",
           \"values\": \"{{$json.event.id}},{{$json.event.type}},{{$json.event.data.object.amount}},failed,{{JSON.stringify($json.event.data.object)}},{{new Date()}}\"
         },
         \"name\": \"Log Failed Payment\",
         \"type\": \"n8n-nodes-base.supabase\",
         \"position\": [850, 300]
       },
       {
         \"parameters\": {
           \"functionCode\": \"const refund = $json.event.data.object;\\nconst chargeId = refund.charge;\\n\\n// Get original payment details\\nconst { data: payment } = await $('Supabase').getAll({\\n  resource: 'payment_logs',\\n  filters: {\\n    stripe_charge_id: chargeId\\n  }\\n});\\n\\nif (!payment[0]) {\\n  throw new Error('Original payment not found');\\n}\\n\\nconst originalPayment = payment[0];\\nconst refundAmount = refund.amount;\\nconst isPartialRefund = refundAmount < originalPayment.amount;\\n\\n// Update ticket or booking status\\nif (originalPayment.metadata.type === 'ticket') {\\n  await $('Supabase').update({\\n    resource: 'tickets',\\n    id: originalPayment.metadata.ticket_id,\\n    updateFields: {\\n      status: isPartialRefund ? 'partially_refunded' : 'refunded',\\n      refund_amount: refundAmount,\\n      refunded_at: new Date()\\n    }\\n  });\\n} else if (originalPayment.metadata.type === 'model_payment') {\\n  // Handle model payment refund\\n  await $('Supabase').update({\\n    resource: 'event_models',\\n    id: originalPayment.metadata.booking_id,\\n    updateFields: {\\n      payment_status: 'refunded',\\n      refund_amount: refundAmount\\n    }\\n  });\\n}\\n\\nreturn {\\n  refund,\\n  originalPayment,\\n  isPartialRefund\\n};\"\n         },\n         \"name\": \"Process Refund\",\n         \"type\": \"n8n-nodes-base.function\",\n         \"position\": [850, 400]\n       }\n     ]\n   }\n   "\n   ```\n\n2. **Setup escrow management**\n   ```bash\n   DC: write "workflows/escrow-management.json" "\n   {\n     \"name\": \"Escrow Management System\",\n     \"nodes\": [\n       {\n         \"parameters\": {\n           \"resource\": \"event_models\",\n           \"events\": [\"UPDATE\"],\n           \"additionalFields\": {\n             \"filter\": \"status=eq.confirmed\"\n           }\n         },\n         \"name\": \"Model Confirmed\",\n         \"type\": \"n8n-nodes-base.supabaseTrigger\",\n         \"position\": [250, 300]\n       },\n       {\n         \"parameters\": {\n           \"functionCode\": \"const booking = $json;\\nconst modelRate = booking.rate;\\nconst platformFee = modelRate * 0.10;\\nconst modelPayout = modelRate - platformFee;\\n\\n// Create escrow record\\nconst escrow = await $('Supabase').insert({\\n  resource: 'escrow_accounts',\\n  fields: {\\n    booking_id: booking.id,\\n    model_id: booking.model_id,\\n    designer_id: booking.designer_id,\\n    event_id: booking.event_id,\\n    amount: modelRate,\\n    platform_fee: platformFee,\\n    payout_amount: modelPayout,\\n    status: 'held',\\n    show_date: booking.show_date,\\n    release_date: new Date(booking.show_date).setDate(new Date(booking.show_date).getDate() + 1)\\n  }\\n});\\n\\n// Create Stripe transfer hold\\nconst stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);\\nconst hold = await stripe.accounts.createExternalAccount(\\n  booking.designer_stripe_account,\\n  {\\n    external_account: {\\n      object: 'bank_account',\\n      account_holder_name: 'FashionOS Escrow',\\n      account_holder_type: 'company',\\n      routing_number: process.env.ESCROW_ROUTING,\\n      account_number: process.env.ESCROW_ACCOUNT\\n    },\\n    metadata: {\\n      type: 'escrow',\\n      booking_id: booking.id,\\n      release_date: escrow.release_date\\n    }\\n  }\\n);\\n\\nreturn {\\n  booking,\\n  escrow,\\n  hold\\n};\"\n         },\n         \"name\": \"Create Escrow\",\n         \"type\": \"n8n-nodes-base.function\",\n         \"position\": [450, 300]\n       },\n       {\n         \"parameters\": {\n           \"rule\": \"0 2 * * *\",\n           \"timezone\": \"America/Toronto\"\n         },\n         \"name\": \"Daily Escrow Check\",\n         \"type\": \"n8n-nodes-base.cron\",\n         \"position\": [250, 500]\n       },\n       {\n         \"parameters\": {\n           \"resource\": \"escrow_accounts\",\n           \"operation\": \"getAll\",\n           \"filters\": {\n             \"status\": \"held\",\n             \"release_date\": \"lte.{{new Date().toISOString()}}\"\n           }\n         },\n         \"name\": \"Get Releasable Escrows\",\n         \"type\": \"n8n-nodes-base.supabase\",\n         \"position\": [450, 500]\n       },\n       {\n         \"parameters\": {\n           \"functionCode\": \"const escrow = $json;\\n\\n// Verify show completion\\nconst { data: booking } = await $('Supabase').get({\\n  resource: 'event_models',\\n  id: escrow.booking_id\\n});\\n\\nif (booking.status !== 'completed') {\\n  // Show not completed, hold escrow\\n  return {\\n    action: 'hold',\\n    reason: 'Show not marked as completed',\\n    escrow\\n  };\\n}\\n\\n// Verify model attended\\nif (!booking.attended) {\\n  // Model didn't attend, refund designer\\n  return {\\n    action: 'refund_designer',\\n    reason: 'Model did not attend',\\n    escrow\\n  };\\n}\\n\\n// All good, release to model\\nreturn {\\n  action: 'release_to_model',\\n  escrow,\\n  booking\\n};\"\n         },\n         \"name\": \"Verify Release\",\n         \"type\": \"n8n-nodes-base.function\",\n         \"position\": [650, 500]\n       },\n       {\n         \"parameters\": {\n           \"conditions\": {\n             \"string\": [{\n               \"value1\": \"={{$json.action}}\",\n               \"operation\": \"equals\",\n               \"value2\": \"release_to_model\"\n             }]\n           }\n         },\n         \"name\": \"Should Release?\",\n         \"type\": \"n8n-nodes-base.if\",\n         \"position\": [850, 500]\n       },\n       {\n         \"parameters\": {\n           \"resource\": \"transfer\",\n           \"operation\": \"create\",\n           \"amount\": \"={{$json.escrow.payout_amount}}\",\n           \"currency\": \"usd\",\n           \"destination\": \"={{$json.booking.model_stripe_account}}\",\n           \"transfer_group\": \"event_{{$json.escrow.event_id}}\",\n           \"metadata\": {\n             \"type\": \"model_payout\",\n             \"booking_id\": \"={{$json.escrow.booking_id}}\",\n             \"escrow_id\": \"={{$json.escrow.id}}\"\n           }\n         },\n         \"name\": \"Pay Model\",\n         \"type\": \"n8n-nodes-base.stripe\",\n         \"position\": [1050, 400]\n       },\n       {\n         \"parameters\": {\n           \"resource\": \"escrow_accounts\",\n           \"operation\": \"update\",\n           \"id\": \"={{$json.escrow.id}}\",\n           \"updateFields\": {\n             \"status\": \"released\",\n             \"released_at\": \"={{new Date()}}\",\n             \"transfer_id\": \"={{$('Pay Model').item.json.id}}\"\n           }\n         },\n         \"name\": \"Update Escrow\",\n         \"type\": \"n8n-nodes-base.supabase\",\n         \"position\": [1250, 400]\n       }\n     ]\n   }\n   "\n   ```\n\n3. **Create automated payout system**\n   ```bash\n   DC: write "workflows/automated-payouts.json" "\n   {\n     \"name\": \"Automated Payout System\",\n     \"nodes\": [\n       {\n         \"parameters\": {\n           \"resource\": \"events\",\n           \"events\": [\"UPDATE\"],\n           \"additionalFields\": {\n             \"filter\": \"status=eq.completed\"\n           }\n         },\n         \"name\": \"Event Completed\",\n         \"type\": \"n8n-nodes-base.supabaseTrigger\",\n         \"position\": [250, 300]\n       },\n       {\n         \"parameters\": {\n           \"amount\": 6,\n           \"unit\": \"hours\"\n         },\n         \"name\": \"Wait 6 Hours\",\n         \"type\": \"n8n-nodes-base.wait\",\n         \"position\": [450, 300]\n       },\n       {\n         \"parameters\": {\n           \"sql\": \"SELECT \\n            em.*,\\n            m.stripe_account_id,\\n            m.name as model_name,\\n            m.email as model_email,\\n            d.brand_name as designer_name\\n          FROM event_models em\\n          JOIN models m ON em.model_id = m.id\\n          JOIN designers d ON em.designer_id = d.id\\n          WHERE em.event_id = '{{$('Event Completed').item.json.id}}'\\n            AND em.status = 'completed'\\n            AND em.attended = true\\n            AND em.paid = false\"\n         },\n         \"name\": \"Get Unpaid Models\",\n         \"type\": \"n8n-nodes-base.supabase\",\n         \"position\": [650, 300]\n       },\n       {\n         \"parameters\": {\n           \"batchSize\": 10,\n           \"options\": {}\n         },\n         \"name\": \"Batch Payouts\",\n         \"type\": \"n8n-nodes-base.splitInBatches\",\n         \"position\": [850, 300]\n       },\n       {\n         \"parameters\": {\n           \"functionCode\": \"const payouts = [];\\nconst stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);\\n\\nfor (const model of $items()) {\\n  try {\\n    const booking = model.json;\\n    const payoutAmount = booking.rate * 0.9; // 10% platform fee\\n    \\n    // Create payout\\n    const payout = await stripe.transfers.create({\\n      amount: Math.floor(payoutAmount * 100), // Convert to cents\\n      currency: 'usd',\\n      destination: booking.stripe_account_id,\\n      description: `Payment for ${booking.designer_name} show on ${booking.show_date}`,\\n      metadata: {\\n        booking_id: booking.id,\\n        model_id: booking.model_id,\\n        event_id: booking.event_id\\n      }\\n    });\\n    \\n    // Update booking as paid\\n    await $('Supabase').update({\\n      resource: 'event_models',\\n      id: booking.id,\\n      updateFields: {\\n        paid: true,\\n        paid_at: new Date(),\\n        payout_id: payout.id,\\n        payout_amount: payoutAmount\\n      }\\n    });\\n    \\n    payouts.push({\\n      success: true,\\n      booking_id: booking.id,\\n      model_name: booking.model_name,\\n      amount: payoutAmount,\\n      payout_id: payout.id\\n    });\\n    \\n  } catch (error) {\\n    payouts.push({\\n      success: false,\\n      booking_id: booking.id,\\n      model_name: booking.model_name,\\n      error: error.message\\n    });\\n  }\\n}\\n\\nreturn payouts;\"\n         },\n         \"name\": \"Process Payouts\",\n         \"type\": \"n8n-nodes-base.function\",\n         \"position\": [1050, 300]\n       },\n       {\n         \"parameters\": {\n           \"resource\": \"payout_batches\",\n           \"operation\": \"insert\",\n           \"columns\": \"event_id,total_models,successful_payouts,failed_payouts,total_amount,processed_at\",\n           \"values\": \"{{$('Event Completed').item.json.id}},{{$json.length}},{{$json.filter(p => p.success).length}},{{$json.filter(p => !p.success).length}},{{$json.reduce((sum, p) => sum + (p.amount || 0), 0)}},{{new Date()}}\"\n         },\n         \"name\": \"Log Batch Results\",\n         \"type\": \"n8n-nodes-base.supabase\",\n         \"position\": [1250, 300]\n       },\n       {\n         \"parameters\": {\n           \"toEmail\": \"={{$json.model_email}}\",\n           \"subject\": \"Payment Processed - {{$json.designer_name}} Show\",\n           \"htmlBody\": \"<h2>Payment Confirmation</h2><p>Hi {{$json.model_name}},</p><p>Your payment of ${{$json.amount}} for the {{$json.designer_name}} show has been processed.</p><p>The funds will be available in your account within 2-3 business days.</p><p>Thank you for your professionalism!</p>\"\n         },\n         \"name\": \"Send Payment Confirmation\",\n         \"type\": \"n8n-nodes-base.sendGrid\",\n         \"position\": [1250, 500]\n       }\n     ]\n   }\n   "\n   ```\n\n4. **Setup financial reporting**\n   ```bash\n   DC: write "workflows/financial-reporting.json" "\n   {\n     \"name\": \"Financial Reporting System\",\n     \"nodes\": [\n       {\n         \"parameters\": {\n           \"rule\": \"0 0 1 * *\",\n           \"timezone\": \"America/Toronto\"\n         },\n         \"name\": \"Monthly Report\",\n         \"type\": \"n8n-nodes-base.cron\",\n         \"position\": [250, 300]\n       },\n       {\n         \"parameters\": {\n           \"functionCode\": \"const lastMonth = new Date();\\nlastMonth.setMonth(lastMonth.getMonth() - 1);\\nconst startDate = new Date(lastMonth.getFullYear(), lastMonth.getMonth(), 1);\\nconst endDate = new Date(lastMonth.getFullYear(), lastMonth.getMonth() + 1, 0);\\n\\n// Get all transactions\\nconst { data: transactions } = await $('Supabase').getAll({\\n  resource: 'payment_logs',\\n  filters: {\\n    created_at: `gte.${startDate.toISOString()}`,\\n    created_at: `lte.${endDate.toISOString()}`\\n  }\\n});\\n\\n// Calculate totals\\nconst summary = {\\n  month: lastMonth.toLocaleString('default', { month: 'long', year: 'numeric' }),\\n  gross_revenue: 0,\\n  platform_fees: 0,\\n  processing_fees: 0,\\n  model_payouts: 0,\\n  refunds: 0,\\n  net_revenue: 0,\\n  transactions_by_type: {},\\n  top_events: [],\\n  top_models: []\\n};\\n\\n// Process transactions\\ntransactions.forEach(t => {\\n  if (t.type === 'payment_intent.succeeded') {\\n    summary.gross_revenue += t.amount;\\n    summary.platform_fees += t.amount * 0.10;\\n    summary.processing_fees += t.amount * 0.029 + 30; // Stripe fees\\n  } else if (t.type === 'transfer.created' && t.metadata?.type === 'model_payout') {\\n    summary.model_payouts += t.amount;\\n  } else if (t.type === 'charge.refunded') {\\n    summary.refunds += t.amount;\\n  }\\n  \\n  // Count by type\\n  summary.transactions_by_type[t.metadata?.type || 'other'] = \\n    (summary.transactions_by_type[t.metadata?.type || 'other'] || 0) + 1;\\n});\\n\\nsummary.net_revenue = summary.gross_revenue - summary.platform_fees - summary.processing_fees - summary.model_payouts - summary.refunds;\\n\\n// Get top events by revenue\\nconst { data: topEvents } = await $('Supabase').sql({\\n  query: `SELECT e.name, e.id, SUM(p.amount) as revenue\\n          FROM events e\\n          JOIN payment_logs p ON p.metadata->>'event_id' = e.id::text\\n          WHERE p.created_at BETWEEN $1 AND $2\\n            AND p.type = 'payment_intent.succeeded'\\n          GROUP BY e.id\\n          ORDER BY revenue DESC\\n          LIMIT 5`,\\n  params: [startDate, endDate]\\n});\\nsummary.top_events = topEvents;\\n\\n// Get top earning models\\nconst { data: topModels } = await $('Supabase').sql({\\n  query: `SELECT m.name, m.id, SUM(p.amount) as earnings\\n          FROM models m\\n          JOIN payment_logs p ON p.metadata->>'model_id' = m.id::text\\n          WHERE p.created_at BETWEEN $1 AND $2\\n            AND p.type = 'transfer.created'\\n          GROUP BY m.id\\n          ORDER BY earnings DESC\\n          LIMIT 10`,\\n  params: [startDate, endDate]\\n});\\nsummary.top_models = topModels;\\n\\nreturn summary;\"\n         },\n         \"name\": \"Generate Report Data\",\n         \"type\": \"n8n-nodes-base.function\",\n         \"position\": [450, 300]\n       },\n       {\n         \"parameters\": {\n           \"operation\": \"generateDocument\",\n           \"documentType\": \"financial_report\",\n           \"template\": \"monthly_financial_report\",\n           \"format\": \"pdf\",\n           \"data\": \"={{$json}}\"\n         },\n         \"name\": \"Create PDF Report\",\n         \"type\": \"n8n-nodes-base.documentGeneration\",\n         \"position\": [650, 300]\n       },\n       {\n         \"parameters\": {\n           \"resource\": \"financial_reports\",\n           \"operation\": \"insert\",\n           \"columns\": \"report_month,gross_revenue,net_revenue,report_url,generated_at\",\n           \"values\": \"{{$json.month}},{{$json.gross_revenue}},{{$json.net_revenue}},{{$('Create PDF Report').item.json.url}},{{new Date()}}\"\n         },\n         \"name\": \"Save Report\",\n         \"type\": \"n8n-nodes-base.supabase\",\n         \"position\": [850, 300]\n       },\n       {\n         \"parameters\": {\n           \"toEmail\": \"finance@fashionos.com\",\n           \"subject\": \"Monthly Financial Report - {{$json.month}}\",\n           \"htmlBody\": \"<h2>Monthly Financial Summary</h2><p>The financial report for {{$json.month}} is ready.</p><ul><li>Gross Revenue: ${{($json.gross_revenue / 100).toFixed(2)}}</li><li>Net Revenue: ${{($json.net_revenue / 100).toFixed(2)}}</li><li>Total Transactions: {{Object.values($json.transactions_by_type).reduce((a,b) => a+b, 0)}}</li></ul><p><a href='{{$('Create PDF Report').item.json.url}}'>Download Full Report</a></p>\",\n           \"attachments\": [{\n             \"filename\": \"financial-report-{{$json.month}}.pdf\",\n             \"url\": \"{{$('Create PDF Report').item.json.url}}\"\n           }]\n         },\n         \"name\": \"Email Report\",\n         \"type\": \"n8n-nodes-base.sendGrid\",\n         \"position\": [1050, 300]\n       }\n     ]\n   }\n   "\n   ```\n\n5. **Create reconciliation workflow**\n   ```bash\n   DC: write "workflows/payment-reconciliation.json" "\n   {\n     \"name\": \"Payment Reconciliation\",\n     \"nodes\": [\n       {\n         \"parameters\": {\n           \"rule\": \"0 3 * * *\",\n           \"timezone\": \"America/Toronto\"\n         },\n         \"name\": \"Daily Reconciliation\",\n         \"type\": \"n8n-nodes-base.cron\",\n         \"position\": [250, 300]\n       },\n       {\n         \"parameters\": {\n           \"functionCode\": \"const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);\\nconst yesterday = new Date();\\nyesterday.setDate(yesterday.getDate() - 1);\\nyesterday.setHours(0, 0, 0, 0);\\nconst today = new Date();\\ntoday.setHours(0, 0, 0, 0);\\n\\n// Get Stripe transactions\\nconst charges = await stripe.charges.list({\\n  created: {\\n    gte: Math.floor(yesterday.getTime() / 1000),\\n    lt: Math.floor(today.getTime() / 1000)\\n  },\\n  limit: 100\\n});\\n\\nconst transfers = await stripe.transfers.list({\\n  created: {\\n    gte: Math.floor(yesterday.getTime() / 1000),\\n    lt: Math.floor(today.getTime() / 1000)\\n  },\\n  limit: 100\\n});\\n\\nconst refunds = await stripe.refunds.list({\\n  created: {\\n    gte: Math.floor(yesterday.getTime() / 1000),\\n    lt: Math.floor(today.getTime() / 1000)\\n  },\\n  limit: 100\\n});\\n\\nreturn {\\n  date: yesterday.toISOString().split('T')[0],\\n  stripe_charges: charges.data,\\n  stripe_transfers: transfers.data,\\n  stripe_refunds: refunds.data\\n};\"\n         },\n         \"name\": \"Get Stripe Data\",\n         \"type\": \"n8n-nodes-base.function\",\n         \"position\": [450, 300]\n       },\n       {\n         \"parameters\": {\n           \"resource\": \"payment_logs\",\n           \"operation\": \"getAll\",\n           \"filters\": {\n             \"created_at\": \"gte.{{$json.date}}T00:00:00Z\",\n             \"created_at\": \"lt.{{new Date(new Date($json.date).getTime() + 24*60*60*1000).toISOString()}}\"\n           }\n         },\n         \"name\": \"Get Database Records\",\n         \"type\": \"n8n-nodes-base.supabase\",\n         \"position\": [650, 300]\n       },\n       {\n         \"parameters\": {\n           \"functionCode\": \"const stripeData = $('Get Stripe Data').item.json;\\nconst dbRecords = $json;\\n\\n// Reconcile charges\\nconst chargeDiscrepancies = [];\\nstripeData.stripe_charges.forEach(charge => {\\n  const dbRecord = dbRecords.find(r => r.stripe_charge_id === charge.id);\\n  if (!dbRecord) {\\n    chargeDiscrepancies.push({\\n      type: 'missing_in_db',\\n      stripe_id: charge.id,\\n      amount: charge.amount,\\n      created: charge.created\\n    });\\n  } else if (dbRecord.amount !== charge.amount) {\\n    chargeDiscrepancies.push({\\n      type: 'amount_mismatch',\\n      stripe_id: charge.id,\\n      stripe_amount: charge.amount,\\n      db_amount: dbRecord.amount\\n    });\\n  }\\n});\\n\\n// Check for DB records not in Stripe\\ndbRecords.forEach(record => {\\n  if (record.type === 'payment_intent.succeeded') {\\n    const stripeCharge = stripeData.stripe_charges.find(c => c.id === record.stripe_charge_id);\\n    if (!stripeCharge) {\\n      chargeDiscrepancies.push({\\n        type: 'missing_in_stripe',\\n        db_id: record.id,\\n        amount: record.amount\\n      });\\n    }\\n  }\\n});\\n\\n// Similar checks for transfers and refunds...\\n\\nconst summary = {\\n  date: stripeData.date,\\n  total_stripe_charges: stripeData.stripe_charges.length,\\n  total_db_records: dbRecords.length,\\n  discrepancies: chargeDiscrepancies.length,\\n  details: chargeDiscrepancies\\n};\\n\\nreturn summary;\"\n         },\n         \"name\": \"Reconcile Records\",\n         \"type\": \"n8n-nodes-base.function\",\n         \"position\": [850, 300]\n       },\n       {\n         \"parameters\": {\n           \"conditions\": {\n             \"number\": [{\n               \"value1\": \"={{$json.discrepancies}}\",\n               \"operation\": \"larger\",\n               \"value2\": 0\n             }]\n           }\n         },\n         \"name\": \"Has Discrepancies?\",\n         \"type\": \"n8n-nodes-base.if\",\n         \"position\": [1050, 300]\n       },\n       {\n         \"parameters\": {\n           \"channel\": \"#finance-alerts\",\n           \"text\": \"Payment Reconciliation Alert\",\n           \"attachments\": [{\n             \"color\": \"danger\",\n             \"title\": \"Discrepancies Found for {{$json.date}}\",\n             \"fields\": [\n               {\"title\": \"Total Discrepancies\", \"value\": \"{{$json.discrepancies}}\", \"short\": true},\n               {\"title\": \"Stripe Records\", \"value\": \"{{$json.total_stripe_charges}}\", \"short\": true},\n               {\"title\": \"Database Records\", \"value\": \"{{$json.total_db_records}}\", \"short\": true}\n             ],\n             \"text\": \"Details:\\n{{$json.details.map(d => `${d.type}: ${d.stripe_id || d.db_id}`).join('\\n')}}\"\n           }]\n         },\n         \"name\": \"Alert Finance Team\",\n         \"type\": \"n8n-nodes-base.slack\",\n         \"position\": [1250, 200]\n       },\n       {\n         \"parameters\": {\n           \"resource\": \"reconciliation_logs\",\n           \"operation\": \"insert\",\n           \"columns\": \"reconciliation_date,stripe_count,db_count,discrepancy_count,status,details\",\n           \"values\": \"{{$json.date}},{{$json.total_stripe_charges}},{{$json.total_db_records}},{{$json.discrepancies}},{{$json.discrepancies > 0 ? 'failed' : 'success'}},{{JSON.stringify($json.details)}}\"\n         },\n         \"name\": \"Log Results\",\n         \"type\": \"n8n-nodes-base.supabase\",\n         \"position\": [1250, 400]\n       }\n     ]\n   }\n   "\n   ```\n\n**Success Criteria**:\n- [ ] Payment webhooks processed correctly\n- [ ] Escrow system holds and releases funds\n- [ ] Automated payouts work reliably\n- [ ] Financial reports accurate\n- [ ] Reconciliation catches discrepancies\n\n**Testing**:\n```bash\n# Test payment webhook\nDC: exec "curl -X POST https://n8n.fashionos.com/webhook/stripe-webhook \\\n  -H 'Stripe-Signature: test-sig' \\\n  -d '{\"type\": \"payment_intent.succeeded\", \"data\": {\"object\": {\"amount\": 10000}}}'\"\n\n# Test escrow creation\nDC: @supabase sql \"UPDATE event_models SET status = 'confirmed' WHERE id = 'test-booking';\"\n\n# Test payout batch\nDC: @supabase sql \"UPDATE events SET status = 'completed' WHERE id = 'test-event';\"\n\n# Trigger reconciliation\nDC: exec \"curl -X POST https://n8n.fashionos.com/webhook-test/reconcile\"\n```\n\n**Troubleshooting**:\n- **Webhook verification fails**: Check Stripe signature secret\n- **Escrow not releasing**: Verify all conditions met\n- **Payouts failing**: Check Stripe account status\n- **Reports incomplete**: Increase query limits\n\n**Checklist**:\n- [ ] Payment processing automated\n- [ ] Escrow management working\n- [ ] Payouts scheduled and processed\n- [ ] Reports generated monthly\n- [ ] Reconciliation running daily\n\n---\n\n## Phase 7: AI-Powered Workflows\n\n### Task 7.1: Intelligent Automation\n\n**Purpose**: Integrate AI capabilities into n8n workflows for smart decision-making, content generation, and predictive automation.\n\n**Features**:\n1. **AI decision making** - Let AI handle complex routing decisions\n2. **Content generation** - Automated copywriting for events\n3. **Predictive analytics** - Forecast attendance and revenue\n4. **Smart matching** - AI-powered model-designer pairing\n5. **Anomaly detection** - Identify unusual patterns\n\n**Use Cases**:\n1. **Smart routing** - AI decides best channel for each message\n2. **Content creation** - Generate event descriptions and social posts\n3. **Demand forecasting** - Predict ticket sales and adjust pricing\n4. **Model recommendations** - Match models to designer aesthetics\n5. **Fraud detection** - Identify suspicious payment patterns\n\n**Real-World Examples**:\n1. AI analyzes past events → Predicts Milan Fashion Week will sell out → Auto-increases prices by 20%\n2. Designer uploads mood board → AI finds 10 models matching aesthetic → 8 book within 24 hours\n3. Unusual ticket pattern detected → AI flags potential bot activity → Manual review prevents fraud\n4. Event approaching → AI generates 50 social media posts → Scheduled across 7 days\n5. Weather + historical data → AI predicts 30% no-show rate → Oversells by exactly 30%\n\n**Steps to Complete**:\n\n1. **Create AI decision engine**\n   ```bash\n   DC: write \"workflows/ai-decision-engine.json\" \"\n   {\n     \\\"name\\\": \\\"AI Decision Engine\\\",\n     \\\"nodes\\\": [\n       {\n         \\\"parameters\\\": {\n           \\\"httpMethod\\\": \\\"POST\\\",\n           \\\"path\\\": \\\"ai-decision\\\",\n           \\\"responseMode\\\": \\\"responseNode\\\"\n         },\n         \\\"name\\\": \\\"Decision Request\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.webhook\\\",\n         \\\"position\\\": [250, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"resource\\\": \\\"chat\\\",\n           \\\"model\\\": \\\"gpt-4\\\",\n           \\\"messages\\\": {\n             \\\"messageValues\\\": [\n               {\n                 \\\"role\\\": \\\"system\\\",\n                 \\\"content\\\": \\\"You are an expert fashion event coordinator AI. Make decisions based on data and return structured JSON responses.\\\"\n               },\n               {\n                 \\\"role\\\": \\\"user\\\",\n                 \\\"content\\\": \\\"Decision needed: {{$json.decision_type}}\\\\n\\\\nContext: {{JSON.stringify($json.context)}}\\\\n\\\\nOptions: {{JSON.stringify($json.options)}}\\\\n\\\\nReturn a JSON object with: {\\\\\\\"decision\\\\\\\": \\\\\\\"selected_option\\\\\\\", \\\\\\\"confidence\\\\\\\": 0-100, \\\\\\\"reasoning\\\\\\\": \\\\\\\"explanation\\\\\\\", \\\\\\\"recommendations\\\\\\\": []}\\\"\n               }\n             ]\n           },\n           \\\"options\\\": {\n             \\\"temperature\\\": 0.7\n           }\n         },\n         \\\"name\\\": \\\"AI Analysis\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.openAi\\\",\n         \\\"position\\\": [450, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"functionCode\\\": \\\"const aiResponse = JSON.parse($json.message.content);\\n\\n// Log decision for training\\nawait $('Supabase').insert({\\n  resource: 'ai_decisions',\\n  fields: {\\n    decision_type: $('Decision Request').item.json.decision_type,\\n    context: $('Decision Request').item.json.context,\\n    decision: aiResponse.decision,\\n    confidence: aiResponse.confidence,\\n    reasoning: aiResponse.reasoning,\\n    created_at: new Date()\\n  }\\n});\\n\\n// Route based on confidence\\nif (aiResponse.confidence < 70) {\\n  // Low confidence - escalate to human\\n  return {\\n    action: 'escalate',\\n    ...aiResponse,\\n    escalation_reason: 'Low AI confidence'\\n  };\\n}\\n\\nreturn {\\n  action: 'execute',\\n  ...aiResponse\\n};\\\"\n         },\n         \\\"name\\\": \\\"Process Decision\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.function\\\",\n         \\\"position\\\": [650, 300]\n       }\n     ]\n   }\n   \"\n   ```\n\n2. **Setup content generation**\n   ```bash\n   DC: write \"workflows/ai-content-generation.json\" \"\n   {\n     \\\"name\\\": \\\"AI Content Generator\\\",\n     \\\"nodes\\\": [\n       {\n         \\\"parameters\\\": {\n           \\\"resource\\\": \\\"events\\\",\n           \\\"events\\\": [\\\"INSERT\\\", \\\"UPDATE\\\"],\n           \\\"additionalFields\\\": {\n             \\\"filter\\\": \\\"description=is.null\\\"\n           }\n         },\n         \\\"name\\\": \\\"Event Needs Content\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.supabaseTrigger\\\",\n         \\\"position\\\": [250, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"functionCode\\\": \\\"const event = $json;\\n\\n// Gather context\\nconst { data: designers } = await $('Supabase').getAll({\\n  resource: 'event_designers',\\n  filters: { event_id: event.id }\\n});\\n\\nconst { data: sponsors } = await $('Supabase').getAll({\\n  resource: 'event_sponsors',\\n  filters: { event_id: event.id }\\n});\\n\\nreturn {\\n  event,\\n  designers: designers.map(d => d.brand_name),\\n  sponsors: sponsors.map(s => s.company_name),\\n  venue: event.venue,\\n  dates: {\\n    start: new Date(event.start_date).toLocaleDateString(),\\n    end: new Date(event.end_date).toLocaleDateString()\\n  }\\n};\\\"\n         },\n         \\\"name\\\": \\\"Gather Context\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.function\\\",\n         \\\"position\\\": [450, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"resource\\\": \\\"chat\\\",\n           \\\"model\\\": \\\"gpt-4\\\",\n           \\\"messages\\\": {\n             \\\"messageValues\\\": [\n               {\n                 \\\"role\\\": \\\"system\\\",\n                 \\\"content\\\": \\\"You are a luxury fashion copywriter. Create compelling, sophisticated content for high-end fashion events.\\\"\n               },\n               {\n                 \\\"role\\\": \\\"user\\\",\n                 \\\"content\\\": \\\"Create content for this fashion event:\\\\n\\\\nEvent: {{$json.event.name}}\\\\nDates: {{$json.dates.start}} - {{$json.dates.end}}\\\\nVenue: {{$json.venue.name}}\\\\nDesigners: {{$json.designers.join(', ')}}\\\\nSponsors: {{$json.sponsors.join(', ')}}\\\\n\\\\nGenerate:\\\\n1. Short description (50 words)\\\\n2. Long description (200 words)\\\\n3. 5 Instagram captions\\\\n4. Email subject lines\\\\n5. Press release headline\\\"\n               }\n             ]\n           }\n         },\n         \\\"name\\\": \\\"Generate Content\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.openAi\\\",\n         \\\"position\\\": [650, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"functionCode\\\": \\\"const content = $json.message.content;\\n\\n// Parse AI response\\nconst sections = content.split('\\\\n\\\\n');\\nconst shortDesc = sections.find(s => s.includes('Short description'))?.replace(/.*:\\\\s*/, '');\\nconst longDesc = sections.find(s => s.includes('Long description'))?.replace(/.*:\\\\s*/, '');\\nconst captions = sections.find(s => s.includes('Instagram'))?.split('\\\\n').slice(1).filter(c => c.trim());\\nconst subjects = sections.find(s => s.includes('Email subject'))?.split('\\\\n').slice(1).filter(s => s.trim());\\nconst headline = sections.find(s => s.includes('Press release'))?.replace(/.*:\\\\s*/, '');\\n\\nreturn {\\n  event_id: $('Event Needs Content').item.json.id,\\n  short_description: shortDesc,\\n  long_description: longDesc,\\n  instagram_captions: captions,\\n  email_subjects: subjects,\\n  press_headline: headline\\n};\\\"\n         },\n         \\\"name\\\": \\\"Parse Content\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.function\\\",\n         \\\"position\\\": [850, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"resource\\\": \\\"events\\\",\n           \\\"operation\\\": \\\"update\\\",\n           \\\"id\\\": \\\"={{$json.event_id}}\\\",\n           \\\"updateFields\\\": {\n             \\\"description\\\": \\\"={{$json.short_description}}\\\",\n             \\\"long_description\\\": \\\"={{$json.long_description}}\\\",\n             \\\"marketing_content\\\": \\\"={{JSON.stringify($json)}}\\\"\n           }\n         },\n         \\\"name\\\": \\\"Save Content\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.supabase\\\",\n         \\\"position\\\": [1050, 300]\n       }\n     ]\n   }\n   \"\n   ```\n\n3. **Create predictive analytics**\n   ```bash\n   DC: write \"workflows/predictive-analytics.json\" \"\n   {\n     \\\"name\\\": \\\"Predictive Analytics Engine\\\",\n     \\\"nodes\\\": [\n       {\n         \\\"parameters\\\": {\n           \\\"rule\\\": \\\"0 */6 * * *\\\",\n           \\\"timezone\\\": \\\"America/Toronto\\\"\n         },\n         \\\"name\\\": \\\"Every 6 Hours\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.cron\\\",\n         \\\"position\\\": [250, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"resource\\\": \\\"events\\\",\n           \\\"operation\\\": \\\"getAll\\\",\n           \\\"filters\\\": {\n             \\\"status\\\": \\\"published\\\",\n             \\\"start_date\\\": \\\"gte.{{new Date().toISOString()}}\\\"\n           }\n         },\n         \\\"name\\\": \\\"Get Upcoming Events\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.supabase\\\",\n         \\\"position\\\": [450, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"functionCode\\\": \\\"const event = $json;\\n\\n// Get historical data\\nconst { data: historicalEvents } = await $('Supabase').sql({\\n  query: `SELECT \\n    e.*,\\n    COUNT(DISTINCT t.id) as tickets_sold,\\n    AVG(t.price) as avg_ticket_price,\\n    (COUNT(DISTINCT t.id)::float / e.capacity) as sell_through_rate\\n  FROM events e\\n  LEFT JOIN tickets t ON e.id = t.event_id\\n  WHERE e.venue->>'city' = $1\\n    AND EXTRACT(MONTH FROM e.start_date) = $2\\n    AND e.status = 'completed'\\n  GROUP BY e.id`,\\n  params: [event.venue.city, new Date(event.start_date).getMonth() + 1]\\n});\\n\\n// Get current sales velocity\\nconst { data: currentSales } = await $('Supabase').sql({\\n  query: `SELECT \\n    DATE_TRUNC('day', created_at) as sale_date,\\n    COUNT(*) as daily_sales\\n  FROM tickets\\n  WHERE event_id = $1\\n  GROUP BY sale_date\\n  ORDER BY sale_date`,\\n  params: [event.id]\\n});\\n\\n// Calculate days until event\\nconst daysUntilEvent = Math.floor((new Date(event.start_date) - new Date()) / (1000 * 60 * 60 * 24));\\n\\n// Prepare data for AI\\nreturn {\\n  event,\\n  historical_data: historicalEvents,\\n  current_sales: currentSales,\\n  days_until_event: daysUntilEvent,\\n  current_capacity_sold: currentSales.reduce((sum, day) => sum + day.daily_sales, 0) / event.capacity\\n};\\\"\n         },\n         \\\"name\\\": \\\"Gather Analytics Data\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.function\\\",\n         \\\"position\\\": [650, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"resource\\\": \\\"chat\\\",\n           \\\"model\\\": \\\"gpt-4\\\",\n           \\\"messages\\\": {\n             \\\"messageValues\\\": [\n               {\n                 \\\"role\\\": \\\"system\\\",\n                 \\\"content\\\": \\\"You are a data scientist specializing in event analytics. Analyze historical data and current trends to predict ticket sales and revenue. Return predictions as JSON.\\\"\n               },\n               {\n                 \\\"role\\\": \\\"user\\\",\n                 \\\"content\\\": \\\"Analyze this event data and predict:\\\\n\\\\nEvent: {{$json.event.name}}\\\\nCapacity: {{$json.event.capacity}}\\\\nDays until event: {{$json.days_until_event}}\\\\nCurrent sold: {{$json.current_capacity_sold * 100}}%\\\\n\\\\nHistorical similar events:\\\\n{{JSON.stringify($json.historical_data)}}\\\\n\\\\nCurrent sales trend:\\\\n{{JSON.stringify($json.current_sales)}}\\\\n\\\\nPredict:\\\\n1. Final sell-through rate (%)\\\\n2. Optimal pricing adjustments\\\\n3. Marketing urgency level (1-10)\\\\n4. Risk of not selling out\\\\n5. Recommended actions\\\"\n               }\n             ]\n           }\n         },\n         \\\"name\\\": \\\"AI Prediction\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.openAi\\\",\n         \\\"position\\\": [850, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"functionCode\\\": \\\"const prediction = JSON.parse($json.message.content);\\nconst event = $('Gather Analytics Data').item.json.event;\\n\\n// Save prediction\\nawait $('Supabase').insert({\\n  resource: 'event_predictions',\\n  fields: {\\n    event_id: event.id,\\n    predicted_sell_through: prediction.final_sell_through_rate,\\n    pricing_adjustment: prediction.optimal_pricing_adjustments,\\n    marketing_urgency: prediction.marketing_urgency_level,\\n    risk_level: prediction.risk_of_not_selling_out,\\n    recommendations: prediction.recommended_actions,\\n    created_at: new Date()\\n  }\\n});\\n\\n// Take automated actions based on predictions\\nif (prediction.marketing_urgency_level >= 8) {\\n  // Trigger urgent marketing campaign\\n  await fetch('https://n8n.fashionos.com/webhook/urgent-marketing', {\\n    method: 'POST',\\n    body: JSON.stringify({ event_id: event.id, urgency: prediction.marketing_urgency_level })\\n  });\\n}\\n\\nif (prediction.optimal_pricing_adjustments.increase_by && prediction.final_sell_through_rate > 95) {\\n  // Recommend price increase\\n  await $('Supabase').insert({\\n    resource: 'pricing_recommendations',\\n    fields: {\\n      event_id: event.id,\\n      current_price: event.ticket_price,\\n      recommended_price: event.ticket_price * (1 + prediction.optimal_pricing_adjustments.increase_by / 100),\\n      reason: 'High demand detected',\\n      auto_apply: false\\n    }\\n  });\\n}\\n\\nreturn prediction;\\\"\n         },\n         \\\"name\\\": \\\"Apply Predictions\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.function\\\",\n         \\\"position\\\": [1050, 300]\n       }\n     ]\n   }\n   \"\n   ```\n\n4. **Setup smart matching**\n   ```bash\n   DC: write \"workflows/ai-model-matching.json\" \"\n   {\n     \\\"name\\\": \\\"AI Model Matching\\\",\n     \\\"nodes\\\": [\n       {\n         \\\"parameters\\\": {\n           \\\"httpMethod\\\": \\\"POST\\\",\n           \\\"path\\\": \\\"ai-match-models\\\",\n           \\\"responseMode\\\": \\\"responseNode\\\"\n         },\n         \\\"name\\\": \\\"Match Request\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.webhook\\\",\n         \\\"position\\\": [250, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"functionCode\\\": \\\"const request = $json;\\n\\n// Get designer info\\nconst { data: designer } = await $('Supabase').get({\\n  resource: 'designers',\\n  id: request.designer_id\\n});\\n\\n// Get past shows\\nconst { data: pastShows } = await $('Supabase').getAll({\\n  resource: 'event_models',\\n  filters: {\\n    designer_id: request.designer_id,\\n    status: 'completed'\\n  },\\n  limit: 50\\n});\\n\\n// Get collection details\\nconst collectionInfo = {\\n  designer,\\n  theme: request.collection_theme,\\n  color_palette: request.color_palette,\\n  style_keywords: request.style_keywords,\\n  past_model_ids: pastShows.map(s => s.model_id)\\n};\\n\\nreturn collectionInfo;\\\"\n         },\n         \\\"name\\\": \\\"Get Designer Context\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.function\\\",\n         \\\"position\\\": [450, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"resource\\\": \\\"models\\\",\n           \\\"operation\\\": \\\"getAll\\\",\n           \\\"filters\\\": {\n             \\\"availability\\\": \\\"cs.{{{$('Match Request').item.json.show_date}}}\\\"\n           }\n         },\n         \\\"name\\\": \\\"Get Available Models\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.supabase\\\",\n         \\\"position\\\": [650, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"model\\\": \\\"gpt-4-vision-preview\\\",\n           \\\"messages\\\": {\n             \\\"messageValues\\\": [\n               {\n                 \\\"role\\\": \\\"system\\\",\n                 \\\"content\\\": \\\"You are a fashion casting director AI. Match models to designer aesthetics based on photos, measurements, and style. Consider diversity, brand fit, and past success.\\\"\n               },\n               {\n                 \\\"role\\\": \\\"user\\\",\n                 \\\"content\\\": \\\"Match models for:\\\\n\\\\nDesigner: {{$('Get Designer Context').item.json.designer.brand_name}}\\\\nTheme: {{$('Get Designer Context').item.json.theme}}\\\\nColors: {{$('Get Designer Context').item.json.color_palette}}\\\\nStyle: {{$('Get Designer Context').item.json.style_keywords}}\\\\n\\\\nAvailable models:\\\\n{{JSON.stringify($json.map(m => ({id: m.id, name: m.name, measurements: m.measurements, experience: m.experience_level, portfolio: m.portfolio_url})))}}\\\\n\\\\nRank the top 20 models and explain why each fits. Return as JSON array with scores 1-10.\\\"\n               }\n             ]\n           }\n         },\n         \\\"name\\\": \\\"AI Matching\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.openAi\\\",\n         \\\"position\\\": [850, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"functionCode\\\": \\\"const matches = JSON.parse($json.message.content);\\nconst designerId = $('Match Request').item.json.designer_id;\\n\\n// Save recommendations\\nfor (const match of matches) {\\n  await $('Supabase').insert({\\n    resource: 'model_recommendations',\\n    fields: {\\n      designer_id: designerId,\\n      model_id: match.model_id,\\n      score: match.score,\\n      reasoning: match.reasoning,\\n      recommended_for: $('Match Request').item.json.collection_theme,\\n      created_at: new Date()\\n    }\\n  });\\n}\\n\\n// Auto-book if score > 9\\nconst autoBookModels = matches.filter(m => m.score >= 9);\\nfor (const model of autoBookModels) {\\n  await fetch('https://n8n.fashionos.com/webhook/model-booking-request', {\\n    method: 'POST',\\n    body: JSON.stringify({\\n      model_id: model.model_id,\\n      designer_id: designerId,\\n      show_date: $('Match Request').item.json.show_date,\\n      auto_booked: true,\\n      ai_score: model.score\\n    })\\n  });\\n}\\n\\nreturn {\\n  total_matches: matches.length,\\n  auto_booked: autoBookModels.length,\\n  recommendations: matches\\n};\\\"\n         },\n         \\\"name\\\": \\\"Process Matches\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.function\\\",\n         \\\"position\\\": [1050, 300]\n       }\n     ]\n   }\n   \"\n   ```\n\n5. **Create anomaly detection**\n   ```bash\n   DC: write \"workflows/anomaly-detection.json\" \"\n   {\n     \\\"name\\\": \\\"Anomaly Detection System\\\",\n     \\\"nodes\\\": [\n       {\n         \\\"parameters\\\": {\n           \\\"rule\\\": \\\"*/15 * * * *\\\",\n           \\\"timezone\\\": \\\"America/Toronto\\\"\n         },\n         \\\"name\\\": \\\"Every 15 Minutes\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.cron\\\",\n         \\\"position\\\": [250, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"functionCode\\\": \\\"// Get recent activity\\nconst fifteenMinutesAgo = new Date(Date.now() - 15 * 60 * 1000);\\n\\n// Check ticket purchases\\nconst { data: recentTickets } = await $('Supabase').getAll({\\n  resource: 'tickets',\\n  filters: {\\n    created_at: `gte.${fifteenMinutesAgo.toISOString()}`\\n  }\\n});\\n\\n// Check payment patterns\\nconst { data: recentPayments } = await $('Supabase').getAll({\\n  resource: 'payment_logs',\\n  filters: {\\n    created_at: `gte.${fifteenMinutesAgo.toISOString()}`\\n  }\\n});\\n\\n// Check model bookings\\nconst { data: recentBookings } = await $('Supabase').getAll({\\n  resource: 'event_models',\\n  filters: {\\n    created_at: `gte.${fifteenMinutesAgo.toISOString()}`\\n  }\\n});\\n\\nreturn {\\n  period_start: fifteenMinutesAgo,\\n  period_end: new Date(),\\n  ticket_count: recentTickets.length,\\n  payment_count: recentPayments.length,\\n  booking_count: recentBookings.length,\\n  tickets: recentTickets,\\n  payments: recentPayments,\\n  bookings: recentBookings\\n};\\\"\n         },\n         \\\"name\\\": \\\"Gather Recent Data\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.function\\\",\n         \\\"position\\\": [450, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"functionCode\\\": \\\"const data = $json;\\nconst anomalies = [];\\n\\n// Check ticket velocity\\nif (data.ticket_count > 100) {\\n  // Unusual high volume\\n  const uniqueBuyers = new Set(data.tickets.map(t => t.email)).size;\\n  const avgTicketsPerBuyer = data.ticket_count / uniqueBuyers;\\n  \\n  if (avgTicketsPerBuyer > 10) {\\n    anomalies.push({\\n      type: 'ticket_velocity',\\n      severity: 'high',\\n      message: `Potential ticket bot: ${avgTicketsPerBuyer} tickets per buyer`,\\n      details: { ticket_count: data.ticket_count, unique_buyers: uniqueBuyers }\\n    });\\n  }\\n}\\n\\n// Check payment patterns\\nconst failedPayments = data.payments.filter(p => p.status === 'failed').length;\\nif (failedPayments > 10) {\\n  anomalies.push({\\n    type: 'payment_failures',\\n    severity: 'medium',\\n    message: `High payment failure rate: ${failedPayments} in 15 minutes`,\\n    details: { failed_count: failedPayments, total: data.payment_count }\\n  });\\n}\\n\\n// Check duplicate bookings\\nconst bookingsByModel = {};\\ndata.bookings.forEach(b => {\\n  bookingsByModel[b.model_id] = (bookingsByModel[b.model_id] || 0) + 1;\\n});\\nconst duplicateBookings = Object.values(bookingsByModel).filter(count => count > 1);\\nif (duplicateBookings.length > 0) {\\n  anomalies.push({\\n    type: 'duplicate_bookings',\\n    severity: 'high',\\n    message: 'Models booked multiple times in same period',\\n    details: { duplicate_count: duplicateBookings.length }\\n  });\\n}\\n\\n// Check unusual payment amounts\\nconst amounts = data.payments.map(p => p.amount);\\nconst avgAmount = amounts.reduce((a, b) => a + b, 0) / amounts.length;\\nconst outliers = amounts.filter(a => a > avgAmount * 5 || a < avgAmount * 0.1);\\nif (outliers.length > 0) {\\n  anomalies.push({\\n    type: 'payment_outliers',\\n    severity: 'medium',\\n    message: 'Unusual payment amounts detected',\\n    details: { outlier_count: outliers.length, amounts: outliers }\\n  });\\n}\\n\\nreturn {\\n  period: { start: data.period_start, end: data.period_end },\\n  anomalies,\\n  summary: {\\n    total_anomalies: anomalies.length,\\n    high_severity: anomalies.filter(a => a.severity === 'high').length,\\n    requires_action: anomalies.length > 0\\n  }\\n};\\\"\n         },\n         \\\"name\\\": \\\"Detect Anomalies\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.function\\\",\n         \\\"position\\\": [650, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"conditions\\\": {\n             \\\"number\\\": [{\n               \\\"value1\\\": \\\"={{$json.summary.total_anomalies}}\\\",\n               \\\"operation\\\": \\\"larger\\\",\n               \\\"value2\\\": 0\n             }]\n           }\n         },\n         \\\"name\\\": \\\"Has Anomalies?\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.if\\\",\n         \\\"position\\\": [850, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"resource\\\": \\\"anomaly_logs\\\",\n           \\\"operation\\\": \\\"insert\\\",\n           \\\"columns\\\": \\\"period_start,period_end,anomaly_count,anomalies,created_at\\\",\n           \\\"values\\\": \\\"{{$json.period.start}},{{$json.period.end}},{{$json.summary.total_anomalies}},{{JSON.stringify($json.anomalies)}},{{new Date()}}\\\"\n         },\n         \\\"name\\\": \\\"Log Anomalies\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.supabase\\\",\n         \\\"position\\\": [1050, 200]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"channel\\\": \\\"#security-alerts\\\",\n           \\\"text\\\": \\\"🚨 Anomalies Detected\\\",\n           \\\"attachments\\\": [{\n             \\\"color\\\": \\\"danger\\\",\n             \\\"title\\\": \\\"{{$json.summary.total_anomalies}} anomalies found\\\",\n             \\\"fields\\\": \\\"{{$json.anomalies.map(a => ({title: a.type, value: a.message, short: false}))}}\\\",\n             \\\"footer\\\": \\\"Period: {{new Date($json.period.start).toLocaleTimeString()}} - {{new Date($json.period.end).toLocaleTimeString()}}\\\"\n           }]\n         },\n         \\\"name\\\": \\\"Alert Security\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.slack\\\",\n         \\\"position\\\": [1050, 400]\n       }\n     ]\n   }\n   \"\n   ```\n\n**Success Criteria**:\n- [ ] AI makes accurate decisions\n- [ ] Content generation produces quality output\n- [ ] Predictions improve over time\n- [ ] Model matching increases booking rates\n- [ ] Anomalies detected and prevented\n\n**Testing**:\n```bash\n# Test AI decision\nDC: exec \"curl -X POST https://n8n.fashionos.com/webhook/ai-decision \\\n  -d '{\\\"decision_type\\\": \\\"channel_selection\\\", \\\"context\\\": {\\\"user_type\\\": \\\"vip\\\"}}'\"\n\n# Test content generation\nDC: @supabase sql \"INSERT INTO events (name, start_date, end_date) VALUES ('Test AI Event', NOW() + INTERVAL '30 days', NOW() + INTERVAL '37 days');\"\n\n# Test predictions\nDC: exec \"curl -X POST https://n8n.fashionos.com/webhook-test/run-predictions\"\n\n# Test anomaly detection\nDC: @supabase sql \"INSERT INTO tickets (event_id, email, created_at) SELECT 'test-event', 'bot@test.com', NOW() FROM generate_series(1, 150);\"\n```\n\n**Troubleshooting**:\n- **AI responses not JSON**: Add explicit JSON instruction\n- **Predictions inaccurate**: More historical data needed\n- **Content generic**: Improve context gathering\n- **False anomalies**: Adjust thresholds\n\n**Checklist**:\n- [ ] AI decision engine working\n- [ ] Content auto-generated\n- [ ] Predictions running hourly\n- [ ] Model matching improving\n- [ ] Anomaly detection active\n\n---\n\n## Phase 8: Monitoring & Optimization\n\n### Task 8.1: Workflow Monitoring\n\n**Purpose**: Implement comprehensive monitoring to ensure all workflows run reliably and optimize performance based on real usage data.\n\n**Features**:\n1. **Execution tracking** - Monitor success/failure rates\n2. **Performance metrics** - Track execution times\n3. **Resource monitoring** - CPU, memory, queue depth\n4. **Error analysis** - Identify common failure patterns\n5. **Optimization recommendations** - AI-driven improvements\n\n**Use Cases**:\n1. **Workflow health** - Dashboard showing all workflow statuses\n2. **Bottleneck identification** - Find slow operations\n3. **Error patterns** - Detect recurring issues\n4. **Resource planning** - Scale before problems occur\n5. **Cost optimization** - Reduce unnecessary operations\n\n**Real-World Examples**:\n1. Model booking workflow takes 45s → Analysis shows Stripe API slow → Add caching → Now 5s\n2. Memory spikes at 6PM daily → Fashion Week ticket rush → Auto-scale workers → No more crashes\n3. 10% of WhatsApp messages fail → All to Brazil → Add regional gateway → 99% success\n4. Email workflow uses 80% of budget → Many unopened → Add engagement check → 50% cost reduction\n5. Friday deploys cause weekend issues → Block Friday deployments → 90% fewer incidents\n\n**Steps to Complete**:\n\n1. **Create monitoring dashboard**\n   ```bash\n   DC: write \"workflows/monitoring-dashboard.json\" \"\n   {\n     \\\"name\\\": \\\"Workflow Monitoring Dashboard\\\",\n     \\\"nodes\\\": [\n       {\n         \\\"parameters\\\": {\n           \\\"httpMethod\\\": \\\"GET\\\",\n           \\\"path\\\": \\\"monitoring-dashboard\\\",\n           \\\"responseMode\\\": \\\"responseNode\\\"\n         },\n         \\\"name\\\": \\\"Dashboard Request\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.webhook\\\",\n         \\\"position\\\": [250, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"functionCode\\\": \\\"// Get workflow statistics\\nconst timeRange = $json.timeRange || '24h';\\nconst startTime = new Date();\\n\\nswitch(timeRange) {\\n  case '1h':\\n    startTime.setHours(startTime.getHours() - 1);\\n    break;\\n  case '24h':\\n    startTime.setDate(startTime.getDate() - 1);\\n    break;\\n  case '7d':\\n    startTime.setDate(startTime.getDate() - 7);\\n    break;\\n  case '30d':\\n    startTime.setDate(startTime.getDate() - 30);\\n    break;\\n}\\n\\n// Get execution data\\nconst { data: executions } = await $('Supabase').sql({\\n  query: `SELECT \\n    workflow_name,\\n    status,\\n    COUNT(*) as count,\\n    AVG(execution_time_ms) as avg_time,\\n    MAX(execution_time_ms) as max_time,\\n    MIN(execution_time_ms) as min_time,\\n    PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY execution_time_ms) as p95_time\\n  FROM workflow_executions\\n  WHERE started_at >= $1\\n  GROUP BY workflow_name, status`,\\n  params: [startTime]\\n});\\n\\n// Get error details\\nconst { data: errors } = await $('Supabase').sql({\\n  query: `SELECT \\n    workflow_name,\\n    error_message,\\n    COUNT(*) as count,\\n    MAX(created_at) as last_occurrence\\n  FROM workflow_errors\\n  WHERE created_at >= $1\\n  GROUP BY workflow_name, error_message\\n  ORDER BY count DESC\\n  LIMIT 10`,\\n  params: [startTime]\\n});\\n\\n// Get resource usage\\nconst { data: resources } = await $('Supabase').sql({\\n  query: `SELECT \\n    DATE_TRUNC('hour', measured_at) as hour,\\n    AVG(cpu_usage) as avg_cpu,\\n    AVG(memory_usage) as avg_memory,\\n    MAX(queue_depth) as max_queue\\n  FROM system_metrics\\n  WHERE measured_at >= $1\\n  GROUP BY hour\\n  ORDER BY hour`,\\n  params: [startTime]\\n});\\n\\nreturn {\\n  timeRange,\\n  summary: {\\n    total_executions: executions.reduce((sum, e) => sum + parseInt(e.count), 0),\\n    success_rate: (executions.filter(e => e.status === 'success').reduce((sum, e) => sum + parseInt(e.count), 0) / executions.reduce((sum, e) => sum + parseInt(e.count), 0) * 100).toFixed(2),\\n    avg_execution_time: (executions.reduce((sum, e) => sum + e.avg_time * e.count, 0) / executions.reduce((sum, e) => sum + parseInt(e.count), 0)).toFixed(2)\\n  },\\n  workflows: executions,\\n  top_errors: errors,\\n  resource_usage: resources\\n};\\\"\n         },\n         \\\"name\\\": \\\"Gather Metrics\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.function\\\",\n         \\\"position\\\": [450, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"options\\\": {\n             \\\"contentType\\\": \\\"text/html\\\"\n           },\n           \\\"responseData\\\": \\\"<html>\\n<head>\\n  <title>n8n Monitoring Dashboard</title>\\n  <script src='https://cdn.jsdelivr.net/npm/chart.js'></script>\\n  <style>\\n    body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }\\n    .metric-card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); margin-bottom: 20px; }\\n    .metric-value { font-size: 2em; font-weight: bold; color: #333; }\\n    .metric-label { color: #666; margin-bottom: 5px; }\\n    .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; }\\n    .status-success { color: #28a745; }\\n    .status-error { color: #dc3545; }\\n    canvas { max-height: 300px; }\\n  </style>\\n</head>\\n<body>\\n  <h1>n8n Workflow Monitoring</h1>\\n  \\n  <div class='grid'>\\n    <div class='metric-card'>\\n      <div class='metric-label'>Total Executions</div>\\n      <div class='metric-value'>{{$json.summary.total_executions}}</div>\\n    </div>\\n    <div class='metric-card'>\\n      <div class='metric-label'>Success Rate</div>\\n      <div class='metric-value status-success'>{{$json.summary.success_rate}}%</div>\\n    </div>\\n    <div class='metric-card'>\\n      <div class='metric-label'>Avg Execution Time</div>\\n      <div class='metric-value'>{{$json.summary.avg_execution_time}}ms</div>\\n    </div>\\n  </div>\\n  \\n  <div class='metric-card'>\\n    <h2>Workflow Performance</h2>\\n    <canvas id='performanceChart'></canvas>\\n  </div>\\n  \\n  <div class='metric-card'>\\n    <h2>Top Errors</h2>\\n    <table style='width: 100%'>\\n      <thead>\\n        <tr>\\n          <th>Workflow</th>\\n          <th>Error</th>\\n          <th>Count</th>\\n          <th>Last Seen</th>\\n        </tr>\\n      </thead>\\n      <tbody>\\n        {{#each $json.top_errors}}\\n        <tr>\\n          <td>{{this.workflow_name}}</td>\\n          <td>{{this.error_message}}</td>\\n          <td>{{this.count}}</td>\\n          <td>{{new Date(this.last_occurrence).toLocaleString()}}</td>\\n        </tr>\\n        {{/each}}\\n      </tbody>\\n    </table>\\n  </div>\\n  \\n  <script>\\n    const ctx = document.getElementById('performanceChart').getContext('2d');\\n    const data = {{JSON.stringify($json.workflows)}};\\n    \\n    new Chart(ctx, {\\n      type: 'bar',\\n      data: {\\n        labels: [...new Set(data.map(d => d.workflow_name))],\\n        datasets: [{\\n          label: 'Success',\\n          data: data.filter(d => d.status === 'success').map(d => d.count),\\n          backgroundColor: '#28a745'\\n        }, {\\n          label: 'Error',\\n          data: data.filter(d => d.status === 'error').map(d => d.count),\\n          backgroundColor: '#dc3545'\\n        }]\\n      },\\n      options: {\\n        responsive: true,\\n        scales: {\\n          x: { stacked: true },\\n          y: { stacked: true }\\n        }\\n      }\\n    });\\n  </script>\\n</body>\\n</html>\\\"\n         },\n         \\\"name\\\": \\\"Render Dashboard\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.respondToWebhook\\\",\n         \\\"position\\\": [650, 300]\n       }\n     ]\n   }\n   \"\n   ```\n\n2. **Setup performance tracking**\n   ```bash\n   DC: write \"workflows/performance-tracking.json\" \"\n   {\n     \\\"name\\\": \\\"Performance Tracking\\\",\n     \\\"nodes\\\": [\n       {\n         \\\"parameters\\\": {\n           \\\"events\\\": [\\\"workflow.postExecute\\\"],\n           \\\"options\\\": {}\n         },\n         \\\"name\\\": \\\"Execution Complete\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.n8nTrigger\\\",\n         \\\"position\\\": [250, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"functionCode\\\": \\\"const execution = $json;\\n\\n// Calculate execution time\\nconst startTime = new Date(execution.startedAt);\\nconst endTime = new Date(execution.stoppedAt);\\nconst executionTime = endTime - startTime;\\n\\n// Count nodes executed\\nconst nodeCount = Object.keys(execution.data.resultData.runData).length;\\n\\n// Check for errors\\nconst hasError = execution.data.resultData.error !== undefined;\\nconst errorMessage = hasError ? execution.data.resultData.error.message : null;\\n\\n// Get workflow info\\nconst workflowName = execution.workflowData.name;\\nconst workflowId = execution.workflowData.id;\\n\\n// Save metrics\\nawait $('Supabase').insert({\\n  resource: 'workflow_executions',\\n  fields: {\\n    workflow_id: workflowId,\\n    workflow_name: workflowName,\\n    execution_id: execution.id,\\n    status: hasError ? 'error' : 'success',\\n    execution_time_ms: executionTime,\\n    node_count: nodeCount,\\n    error_message: errorMessage,\\n    started_at: startTime,\\n    stopped_at: endTime\\n  }\\n});\\n\\n// Check if performance degraded\\nif (executionTime > 30000) { // 30 seconds\\n  await $('Supabase').insert({\\n    resource: 'performance_alerts',\\n    fields: {\\n      workflow_name: workflowName,\\n      execution_time: executionTime,\\n      threshold: 30000,\\n      alert_type: 'slow_execution',\\n      created_at: new Date()\\n    }\\n  });\\n}\\n\\nreturn {\\n  tracked: true,\\n  workflow: workflowName,\\n  execution_time: executionTime,\\n  status: hasError ? 'error' : 'success'\\n};\\\"\n         },\n         \\\"name\\\": \\\"Track Performance\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.function\\\",\n         \\\"position\\\": [450, 300]\n       }\n     ]\n   }\n   \"\n   ```\n\n3. **Create resource monitoring**\n   ```bash\n   DC: write \"workflows/resource-monitoring.json\" \"\n   {\n     \\\"name\\\": \\\"Resource Monitoring\\\",\n     \\\"nodes\\\": [\n       {\n         \\\"parameters\\\": {\n           \\\"rule\\\": \\\"*/5 * * * *\\\",\n           \\\"timezone\\\": \\\"America/Toronto\\\"\n         },\n         \\\"name\\\": \\\"Every 5 Minutes\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.cron\\\",\n         \\\"position\\\": [250, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"functionCode\\\": \\\"const os = require('os');\\nconst process = require('process');\\n\\n// Get system metrics\\nconst metrics = {\\n  cpu: {\\n    usage: process.cpuUsage(),\\n    load: os.loadavg(),\\n    cores: os.cpus().length\\n  },\\n  memory: {\\n    total: os.totalmem(),\\n    free: os.freemem(),\\n    used: os.totalmem() - os.freemem(),\\n    usage_percent: ((os.totalmem() - os.freemem()) / os.totalmem() * 100).toFixed(2)\\n  },\\n  process: {\\n    uptime: process.uptime(),\\n    memory: process.memoryUsage(),\\n    pid: process.pid\\n  }\\n};\\n\\n// Get queue depth from Redis\\nconst redis = require('redis');\\nconst client = redis.createClient({\\n  host: 'redis',\\n  password: process.env.REDIS_PASSWORD\\n});\\n\\nconst queueDepth = await new Promise((resolve) => {\\n  client.llen('bull:fashionos:wait', (err, length) => {\\n    resolve(err ? 0 : length);\\n  });\\n});\\n\\nmetrics.queue = {\\n  depth: queueDepth,\\n  status: queueDepth > 100 ? 'high' : queueDepth > 50 ? 'medium' : 'normal'\\n};\\n\\nreturn metrics;\\\"\n         },\n         \\\"name\\\": \\\"Get System Metrics\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.function\\\",\n         \\\"position\\\": [450, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"resource\\\": \\\"system_metrics\\\",\n           \\\"operation\\\": \\\"insert\\\",\n           \\\"columns\\\": \\\"cpu_usage,memory_usage,queue_depth,measured_at\\\",\n           \\\"values\\\": \\\"{{$json.cpu.load[0]}},{{$json.memory.usage_percent}},{{$json.queue.depth}},{{new Date()}}\\\"\n         },\n         \\\"name\\\": \\\"Save Metrics\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.supabase\\\",\n         \\\"position\\\": [650, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"conditions\\\": {\n             \\\"boolean\\\": [\\n               {\\n                 \\\"value1\\\": \\\"={{$json.memory.usage_percent > 80 || $json.cpu.load[0] > 4 || $json.queue.depth > 100}}\\\",\n                 \\\"value2\\\": true\\n               }\\n             ]\\n           }\n         },\n         \\\"name\\\": \\\"Check Thresholds\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.if\\\",\n         \\\"position\\\": [850, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"channel\\\": \\\"#ops-alerts\\\",\n           \\\"text\\\": \\\"Resource Alert\\\",\n           \\\"attachments\\\": [{\n             \\\"color\\\": \\\"warning\\\",\n             \\\"title\\\": \\\"High Resource Usage Detected\\\",\n             \\\"fields\\\": [\n               {\\\"title\\\": \\\"CPU Load\\\", \\\"value\\\": \\\"{{$json.cpu.load[0]}}\\\", \\\"short\\\": true},\n               {\\\"title\\\": \\\"Memory Usage\\\", \\\"value\\\": \\\"{{$json.memory.usage_percent}}%\\\", \\\"short\\\": true},\n               {\\\"title\\\": \\\"Queue Depth\\\", \\\"value\\\": \\\"{{$json.queue.depth}}\\\", \\\"short\\\": true},\n               {\\\"title\\\": \\\"Status\\\", \\\"value\\\": \\\"{{$json.queue.status}}\\\", \\\"short\\\": true}\\n             ]\\n           }]\\n         },\n         \\\"name\\\": \\\"Alert Ops Team\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.slack\\\",\n         \\\"position\\\": [1050, 200]\n       }\n     ]\n   }\n   \"\n   ```\n\n4. **Setup error analysis**\n   ```bash\n   DC: write \"workflows/error-analysis.json\" \"\n   {\n     \\\"name\\\": \\\"Error Analysis & Recovery\\\",\n     \\\"nodes\\\": [\n       {\n         \\\"parameters\\\": {\n           \\\"rule\\\": \\\"0 * * * *\\\",\n           \\\"timezone\\\": \\\"America/Toronto\\\"\n         },\n         \\\"name\\\": \\\"Hourly Analysis\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.cron\\\",\n         \\\"position\\\": [250, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"functionCode\\\": \\\"// Get errors from last hour\\nconst oneHourAgo = new Date();\\noneHourAgo.setHours(oneHourAgo.getHours() - 1);\\n\\nconst { data: errors } = await $('Supabase').getAll({\\n  resource: 'workflow_errors',\\n  filters: {\\n    created_at: `gte.${oneHourAgo.toISOString()}`\\n  }\\n});\\n\\n// Group errors by type\\nconst errorPatterns = {};\\nerrors.forEach(error => {\\n  const key = `${error.workflow_name}:${error.error_type || 'unknown'}`;\\n  if (!errorPatterns[key]) {\\n    errorPatterns[key] = {\\n      workflow: error.workflow_name,\\n      error_type: error.error_type,\\n      count: 0,\\n      examples: [],\\n      first_seen: error.created_at,\\n      last_seen: error.created_at\\n    };\\n  }\\n  errorPatterns[key].count++;\\n  errorPatterns[key].last_seen = error.created_at;\\n  if (errorPatterns[key].examples.length < 3) {\\n    errorPatterns[key].examples.push(error.error_message);\\n  }\\n});\\n\\n// Identify critical patterns\\nconst criticalPatterns = Object.values(errorPatterns).filter(p => \\n  p.count > 10 || \\n  p.error_type === 'timeout' ||\\n  p.error_type === 'authentication_failed'\\n);\\n\\nreturn {\\n  period: { start: oneHourAgo, end: new Date() },\\n  total_errors: errors.length,\\n  unique_patterns: Object.keys(errorPatterns).length,\\n  critical_patterns: criticalPatterns,\\n  all_patterns: errorPatterns\\n};\\\"\n         },\n         \\\"name\\\": \\\"Analyze Errors\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.function\\\",\n         \\\"position\\\": [450, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"functionCode\\\": \\\"const analysis = $json;\\nconst recommendations = [];\\n\\n// Generate recommendations based on patterns\\nanalysis.critical_patterns.forEach(pattern => {\\n  if (pattern.error_type === 'timeout') {\\n    recommendations.push({\\n      workflow: pattern.workflow,\\n      issue: 'Frequent timeouts',\\n      recommendation: 'Increase timeout settings or optimize slow operations',\\n      priority: 'high'\\n    });\\n  } else if (pattern.error_type === 'authentication_failed') {\\n    recommendations.push({\\n      workflow: pattern.workflow,\\n      issue: 'Authentication failures',\\n      recommendation: 'Check API credentials and token expiration',\\n      priority: 'critical'\\n    });\\n  } else if (pattern.count > 20) {\\n    recommendations.push({\\n      workflow: pattern.workflow,\\n      issue: `High error rate: ${pattern.count} errors`,\\n      recommendation: 'Review workflow logic and add error handling',\\n      priority: 'medium'\\n    });\\n  }\\n});\\n\\n// Check for workflows that need retry\\nconst retriableErrors = analysis.all_patterns.filter(p => \\n  p.error_type === 'network' || \\n  p.error_type === 'rate_limit'\\n);\\n\\nreturn {\\n  analysis,\\n  recommendations,\\n  retriable_workflows: retriableErrors\\n};\\\"\n         },\n         \\\"name\\\": \\\"Generate Recommendations\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.function\\\",\n         \\\"position\\\": [650, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"resource\\\": \\\"error_analysis\\\",\n           \\\"operation\\\": \\\"insert\\\",\n           \\\"columns\\\": \\\"period_start,period_end,total_errors,patterns,recommendations,created_at\\\",\n           \\\"values\\\": \\\"{{$json.analysis.period.start}},{{$json.analysis.period.end}},{{$json.analysis.total_errors}},{{JSON.stringify($json.analysis.all_patterns)}},{{JSON.stringify($json.recommendations)}},{{new Date()}}\\\"\n         },\n         \\\"name\\\": \\\"Save Analysis\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.supabase\\\",\n         \\\"position\\\": [850, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"conditions\\\": {\n             \\\"number\\\": [{\n               \\\"value1\\\": \\\"={{$json.recommendations.filter(r => r.priority === 'critical').length}}\\\",\n               \\\"operation\\\": \\\"larger\\\",\n               \\\"value2\\\": 0\n             }]\n           }\n         },\n         \\\"name\\\": \\\"Has Critical Issues?\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.if\\\",\n         \\\"position\\\": [1050, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"toEmail\\\": \\\"ops@fashionos.com\\\",\n           \\\"subject\\\": \\\"Critical Workflow Issues Detected\\\",\n           \\\"htmlBody\\\": \\\"<h2>Error Analysis Report</h2><p>Period: {{new Date($json.analysis.period.start).toLocaleString()}} - {{new Date($json.analysis.period.end).toLocaleString()}}</p><h3>Critical Issues:</h3><ul>{{#each ($json.recommendations.filter(r => r.priority === 'critical'))}}<li><strong>{{this.workflow}}</strong>: {{this.issue}}<br>Recommendation: {{this.recommendation}}</li>{{/each}}</ul><p>Total errors in period: {{$json.analysis.total_errors}}</p>\\\"\n         },\n         \\\"name\\\": \\\"Email Ops Team\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.sendGrid\\\",\n         \\\"position\\\": [1250, 200]\n       }\n     ]\n   }\n   \"\n   ```\n\n5. **Create optimization workflow**\n   ```bash\n   DC: write \"workflows/workflow-optimization.json\" \"\n   {\n     \\\"name\\\": \\\"Workflow Optimization\\\",\n     \\\"nodes\\\": [\n       {\n         \\\"parameters\\\": {\n           \\\"rule\\\": \\\"0 0 * * 0\\\",\n           \\\"timezone\\\": \\\"America/Toronto\\\"\n         },\n         \\\"name\\\": \\\"Weekly Optimization\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.cron\\\",\n         \\\"position\\\": [250, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"functionCode\\\": \\\"// Get performance data from last week\\nconst oneWeekAgo = new Date();\\noneWeekAgo.setDate(oneWeekAgo.getDate() - 7);\\n\\n// Get slowest workflows\\nconst { data: slowWorkflows } = await $('Supabase').sql({\\n  query: `SELECT \\n    workflow_name,\\n    COUNT(*) as execution_count,\\n    AVG(execution_time_ms) as avg_time,\\n    MAX(execution_time_ms) as max_time,\\n    PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY execution_time_ms) as p95_time\\n  FROM workflow_executions\\n  WHERE started_at >= $1\\n    AND status = 'success'\\n  GROUP BY workflow_name\\n  HAVING AVG(execution_time_ms) > 5000\\n  ORDER BY avg_time DESC`,\\n  params: [oneWeekAgo]\\n});\\n\\n// Get most error-prone workflows\\nconst { data: errorProne } = await $('Supabase').sql({\\n  query: `SELECT \\n    workflow_name,\\n    COUNT(*) as error_count,\\n    COUNT(DISTINCT error_message) as unique_errors\\n  FROM workflow_errors\\n  WHERE created_at >= $1\\n  GROUP BY workflow_name\\n  HAVING COUNT(*) > 10\\n  ORDER BY error_count DESC`,\\n  params: [oneWeekAgo]\\n});\\n\\n// Get unused workflows\\nconst { data: allWorkflows } = await $('Supabase').getAll({\\n  resource: 'workflows',\\n  filters: { active: true }\\n});\\n\\nconst { data: recentExecutions } = await $('Supabase').sql({\\n  query: `SELECT DISTINCT workflow_name \\n          FROM workflow_executions \\n          WHERE started_at >= $1`,\\n  params: [oneWeekAgo]\\n});\\n\\nconst executedWorkflows = new Set(recentExecutions.map(e => e.workflow_name));\\nconst unusedWorkflows = allWorkflows.filter(w => !executedWorkflows.has(w.name));\\n\\nreturn {\\n  analysis_period: { start: oneWeekAgo, end: new Date() },\\n  slow_workflows: slowWorkflows,\\n  error_prone_workflows: errorProne,\\n  unused_workflows: unusedWorkflows\\n};\\\"\n         },\n         \\\"name\\\": \\\"Analyze Performance\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.function\\\",\n         \\\"position\\\": [450, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"resource\\\": \\\"chat\\\",\n           \\\"model\\\": \\\"gpt-4\\\",\n           \\\"messages\\\": {\n             \\\"messageValues\\\": [\n               {\n                 \\\"role\\\": \\\"system\\\",\n                 \\\"content\\\": \\\"You are an n8n workflow optimization expert. Analyze performance data and suggest specific improvements.\\\"\n               },\n               {\n                 \\\"role\\\": \\\"user\\\",\n                 \\\"content\\\": \\\"Analyze these workflows and suggest optimizations:\\\\n\\\\nSlow workflows (avg time > 5s):\\\\n{{JSON.stringify($json.slow_workflows)}}\\\\n\\\\nError-prone workflows:\\\\n{{JSON.stringify($json.error_prone_workflows)}}\\\\n\\\\nUnused workflows:\\\\n{{JSON.stringify($json.unused_workflows.map(w => w.name))}}\\\\n\\\\nProvide specific recommendations for each issue.\\\"\n               }\n             ]\n           }\n         },\n         \\\"name\\\": \\\"AI Optimization\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.openAi\\\",\n         \\\"position\\\": [650, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"resource\\\": \\\"optimization_reports\\\",\n           \\\"operation\\\": \\\"insert\\\",\n           \\\"columns\\\": \\\"period_start,period_end,slow_workflows,error_prone,unused,recommendations,created_at\\\",\n           \\\"values\\\": \\\"{{$('Analyze Performance').item.json.analysis_period.start}},{{$('Analyze Performance').item.json.analysis_period.end}},{{$('Analyze Performance').item.json.slow_workflows.length}},{{$('Analyze Performance').item.json.error_prone_workflows.length}},{{$('Analyze Performance').item.json.unused_workflows.length}},{{$json.message.content}},{{new Date()}}\\\"\n         },\n         \\\"name\\\": \\\"Save Report\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.supabase\\\",\n         \\\"position\\\": [850, 300]\n       },\n       {\n         \\\"parameters\\\": {\n           \\\"channel\\\": \\\"#workflow-optimization\\\",\n           \\\"text\\\": \\\"Weekly Optimization Report\\\",\n           \\\"blocks\\\": [\n             {\n               \\\"type\\\": \\\"header\\\",\n               \\\"text\\\": {\\n                 \\\"type\\\": \\\"plain_text\\\",\\n                 \\\"text\\\": \\\"Workflow Performance Analysis\\\"\n               }\n             },\n             {\n               \\\"type\\\": \\\"section\\\",\n               \\\"fields\\\": [\n                 {\\n                   \\\"type\\\": \\\"mrkdwn\\\",\\n                   \\\"text\\\": \\\"*Slow Workflows:* {{$('Analyze Performance').item.json.slow_workflows.length}}\\\"\n                 },\n                 {\n                   \\\"type\\\": \\\"mrkdwn\\\",\\n                   \\\"text\\\": \\\"*Error-Prone:* {{$('Analyze Performance').item.json.error_prone_workflows.length}}\\\"\n                 },\n                 {\n                   \\\"type\\\": \\\"mrkdwn\\\",\\n                   \\\"text\\\": \\\"*Unused:* {{$('Analyze Performance').item.json.unused_workflows.length}}\\\"\n                 }\n               ]\n             },\n             {\n               \\\"type\\\": \\\"section\\\",\n               \\\"text\\\": {\n                 \\\"type\\\": \\\"mrkdwn\\\",\n                 \\\"text\\\": \\\"*AI Recommendations:*\\\\n{{$json.message.content.substring(0, 500)}}...\\\"\n               }\n             }\n           ]\n         },\n         \\\"name\\\": \\\"Share Report\\\",\n         \\\"type\\\": \\\"n8n-nodes-base.slack\\\",\n         \\\"position\\\": [1050, 300]\n       }\n     ]\n   }\n   \"\n   ```\n\n**Success Criteria**:\n- [ ] Dashboard shows real-time metrics\n- [ ] Performance tracking automatic\n- [ ] Resource alerts working\n- [ ] Error patterns identified\n- [ ] Optimization recommendations generated\n\n**Testing**:\n```bash\n# Access monitoring dashboard\nDC: exec \"curl https://n8n.fashionos.com/webhook/monitoring-dashboard\"\n\n# Simulate high load\nfor i in {1..100}; do\n  DC: exec \"curl -X POST https://n8n.fashionos.com/webhook-test/create-load\"\ndone\n\n# Check resource alerts\nDC: @supabase sql \"SELECT * FROM system_metrics WHERE cpu_usage > 80 OR memory_usage > 80;\"\n\n# Review error analysis\nDC: @supabase sql \"SELECT * FROM error_analysis ORDER BY created_at DESC LIMIT 1;\"\n```\n\n**Troubleshooting**:\n- **Metrics not collecting**: Check cron jobs active\n- **Dashboard slow**: Add caching layer\n- **False alerts**: Adjust thresholds\n- **Missing errors**: Check error capture workflow\n\n**Checklist**:\n- [ ] Monitoring dashboard live\n- [ ] Performance tracked\n- [ ] Resources monitored\n- [ ] Errors analyzed\n- [ ] Optimizations identified\n\n---\n\n## Phase 9: Production Deployment\n\n### Task 9.1: Production Setup and Launch\n\n**Purpose**: Deploy n8n to production with high availability, security, and scalability for mission-critical fashion event automation.\n\n**Features**:\n1. **High availability** - Multi-instance deployment\n2. **Security hardening** - SSL, authentication, network isolation\n3. **Backup strategy** - Automated backups and recovery\n4. **Monitoring** - Production-grade observability\n5. **Scaling** - Auto-scaling based on load\n\n**Use Cases**:\n1. **Zero-downtime deployment** - Update without interrupting Fashion Week\n2. **Disaster recovery** - Restore operations within 15 minutes\n3. **Peak handling** - Scale for 10,000 ticket sales in 1 hour\n4. **Security compliance** - Meet enterprise requirements\n5. **Global distribution** - Low latency for international events\n\n**Real-World Examples**:\n1. Milan Fashion Week starts → n8n scales from 2 to 20 instances → Handles 50K workflows/hour\n2. Database failure at 3AM → Automatic failover → Back online in 90 seconds\n3. DDoS attack during ticket sale → WAF blocks attack → Legitimate sales continue\n4. New version deployed → Blue-green switch → Zero downtime, instant rollback available\n5. Paris event needs low latency → Edge deployment activated → 50ms response times\n\n**Steps to Complete**:\n\n1. **Create production infrastructure**\n   ```bash\n   DC: write \"infrastructure/production-setup.sh\" \"\n   #!/bin/bash\n   \n   # Create production namespace\n   kubectl create namespace n8n-production\n   \n   # Create secrets\n   kubectl create secret generic n8n-secrets \\\n     --from-literal=N8N_ENCRYPTION_KEY=$(openssl rand -hex 32) \\\n     --from-literal=DB_PASSWORD=$(openssl rand -base64 32) \\\n     --from-literal=REDIS_PASSWORD=$(openssl rand -base64 32) \\\n     --from-literal=BASIC_AUTH_PASSWORD=$(openssl rand -base64 32) \\\n     -n n8n-production\n   \n   # Apply production configs\n   kubectl apply -f k8s/production/ -n n8n-production\n   \"\n   \n   DC: write \"k8s/production/deployment.yaml\" \"\n   apiVersion: apps/v1\n   kind: Deployment\n   metadata:\n     name: n8n\n     namespace: n8n-production\n   spec:\n     replicas: 3\n     strategy:\n       type: RollingUpdate\n       rollingUpdate:\n         maxSurge: 1\n         maxUnavailable: 0\n     selector:\n       matchLabels:\n         app: n8n\n     template:\n       metadata:\n         labels:\n           app: n8n\n       spec:\n         affinity:\n           podAntiAffinity:\n             requiredDuringSchedulingIgnoredDuringExecution:\n             - labelSelector:\n                 matchExpressions:\n                 - key: app\n                   operator: In\n                   values:\n                   - n8n\n               topologyKey: kubernetes.io/hostname\n         containers:\n         - name: n8n\n           image: n8nio/n8n:latest\n           ports:\n           - containerPort: 5678\n           env:\n           - name: N8N_BASIC_AUTH_ACTIVE\n             value: 'true'\n           - name: N8N_BASIC_AUTH_USER\n             value: 'admin'\n           - name: N8N_BASIC_AUTH_PASSWORD\n             valueFrom:\n               secretKeyRef:\n                 name: n8n-secrets\n                 key: BASIC_AUTH_PASSWORD\n           - name: N8N_ENCRYPTION_KEY\n             valueFrom:\n               secretKeyRef:\n                 name: n8n-secrets\n                 key: N8N_ENCRYPTION_KEY\n           - name: DB_TYPE\n             value: postgresdb\n           - name: DB_POSTGRESDB_HOST\n             value: postgres-service\n           - name: DB_POSTGRESDB_DATABASE\n             value: n8n\n           - name: DB_POSTGRESDB_USER\n             value: n8n\n           - name: DB_POSTGRESDB_PASSWORD\n             valueFrom:\n               secretKeyRef:\n                 name: n8n-secrets\n                 key: DB_PASSWORD\n           - name: EXECUTIONS_MODE\n             value: queue\n           - name: QUEUE_BULL_REDIS_HOST\n             value: redis-service\n           - name: QUEUE_BULL_REDIS_PASSWORD\n             valueFrom:\n               secretKeyRef:\n                 name: n8n-secrets\n                 key: REDIS_PASSWORD\n           - name: N8N_METRICS\n             value: 'true'\n           resources:\n             requests:\n               memory: '1Gi'\n               cpu: '500m'\n             limits:\n               memory: '4Gi'\n               cpu: '2000m'\n           livenessProbe:\n             httpGet:\n               path: /healthz\n               port: 5678\n             initialDelaySeconds: 30\n             periodSeconds: 10\n           readinessProbe:\n             httpGet:\n               path: /ready\n               port: 5678\n             initialDelaySeconds: 5\n             periodSeconds: 5\n   \"\n   ```\n\n2. **Setup database and storage**\n   ```bash\n   DC: write \"k8s/production/postgres.yaml\" \"\n   apiVersion: v1\n   kind: Service\n   metadata:\n     name: postgres-service\n   spec:\n     selector:\n       app: postgres\n     ports:\n     - port: 5432\n       targetPort: 5432\n   ---\n   apiVersion: apps/v1\n   kind: StatefulSet\n   metadata:\n     name: postgres\n   spec:\n     serviceName: postgres-service\n     replicas: 1\n     selector:\n       matchLabels:\n         app: postgres\n     template:\n       metadata:\n         labels:\n           app: postgres\n       spec:\n         containers:\n         - name: postgres\n           image: postgres:15-alpine\n           ports:\n           - containerPort: 5432\n           env:\n           - name: POSTGRES_DB\n             value: n8n\n           - name: POSTGRES_USER\n             value: n8n\n           - name: POSTGRES_PASSWORD\n             valueFrom:\n               secretKeyRef:\n                 name: n8n-secrets\n                 key: DB_PASSWORD\n           - name: PGDATA\n             value: /var/lib/postgresql/data/pgdata\n           volumeMounts:\n           - name: postgres-storage\n             mountPath: /var/lib/postgresql/data\n           resources:\n             requests:\n               memory: '2Gi'\n               cpu: '1000m'\n             limits:\n               memory: '8Gi'\n               cpu: '4000m'\n     volumeClaimTemplates:\n     - metadata:\n         name: postgres-storage\n       spec:\n         accessModes: ['ReadWriteOnce']\n         resources:\n           requests:\n             storage: 100Gi\n         storageClassName: fast-ssd\n   \"\n   \n   DC: write \"k8s/production/redis.yaml\" \"\n   apiVersion: v1\n   kind: Service\n   metadata:\n     name: redis-service\n   spec:\n     selector:\n       app: redis\n     ports:\n     - port: 6379\n       targetPort: 6379\n   ---\n   apiVersion: apps/v1\n   kind: Deployment\n   metadata:\n     name: redis\n   spec:\n     replicas: 1\n     selector:\n       matchLabels:\n         app: redis\n     template:\n       metadata:\n         labels:\n           app: redis\n       spec:\n         containers:\n         - name: redis\n           image: redis:7-alpine\n           ports:\n           - containerPort: 6379\n           command:\n           - redis-server\n           - --requirepass\n           - $(REDIS_PASSWORD)\n           - --maxmemory\n           - 2gb\n           - --maxmemory-policy\n           - allkeys-lru\n           env:\n           - name: REDIS_PASSWORD\n             valueFrom:\n               secretKeyRef:\n                 name: n8n-secrets\n                 key: REDIS_PASSWORD\n           resources:\n             requests:\n               memory: '512Mi'\n               cpu: '250m'\n             limits:\n               memory: '2Gi'\n               cpu: '1000m'\n   \"\n   ```\n\n3. **Configure load balancing and SSL**\n   ```bash\n   DC: write \"k8s/production/ingress.yaml\" \"\n   apiVersion: v1\n   kind: Service\n   metadata:\n     name: n8n-service\n   spec:\n     selector:\n       app: n8n\n     ports:\n     - port: 80\n       targetPort: 5678\n   ---\n   apiVersion: networking.k8s.io/v1\n   kind: Ingress\n   metadata:\n     name: n8n-ingress\n     annotations:\n       kubernetes.io/ingress.class: nginx\n       cert-manager.io/cluster-issuer: letsencrypt-prod\n       nginx.ingress.kubernetes.io/proxy-body-size: 100m\n       nginx.ingress.kubernetes.io/proxy-read-timeout: '600'\n       nginx.ingress.kubernetes.io/proxy-send-timeout: '600'\n       nginx.ingress.kubernetes.io/rate-limit: '100'\n   spec:\n     tls:\n     - hosts:\n       - n8n.fashionos.com\n       secretName: n8n-tls\n     rules:\n     - host: n8n.fashionos.com\n       http:\n         paths:\n         - path: /\n           pathType: Prefix\n           backend:\n             service:\n               name: n8n-service\n               port:\n                 number: 80\n   \"\n   ```\n\n4. **Setup monitoring and alerting**\n   ```bash\n   DC: write \"k8s/production/monitoring.yaml\" \"\n   apiVersion: v1\n   kind: ServiceMonitor\n   metadata:\n     name: n8n-metrics\n   spec:\n     selector:\n       matchLabels:\n         app: n8n\n     endpoints:\n     - port: metrics\n       interval: 30s\n       path: /metrics\n   ---\n   apiVersion: monitoring.coreos.com/v1\n   kind: PrometheusRule\n   metadata:\n     name: n8n-alerts\n   spec:\n     groups:\n     - name: n8n.rules\n       interval: 30s\n       rules:\n       - alert: N8nHighErrorRate\n         expr: rate(n8n_workflow_errors_total[5m]) > 0.1\n         for: 5m\n         labels:\n           severity: warning\n         annotations:\n           summary: High error rate in n8n workflows\n           description: 'Error rate is {{ $value }} errors per second'\n       \n       - alert: N8nHighMemoryUsage\n         expr: container_memory_usage_bytes{pod=~\"n8n-.*\"} / container_spec_memory_limit_bytes > 0.8\n         for: 5m\n         labels:\n           severity: warning\n         annotations:\n           summary: High memory usage in n8n pod\n           description: 'Memory usage is above 80%'\n       \n       - alert: N8nPodDown\n         expr: up{job=\"n8n\"} == 0\n         for: 1m\n         labels:\n           severity: critical\n         annotations:\n           summary: n8n pod is down\n           description: 'n8n pod has been down for more than 1 minute'\n   \"\n   ```\n\n5. **Create backup and recovery**\n   ```bash\n   DC: write \"k8s/production/backup-cronjob.yaml\" \"\n   apiVersion: batch/v1\n   kind: CronJob\n   metadata:\n     name: n8n-backup\n   spec:\n     schedule: '0 2 * * *' # Daily at 2 AM\n     jobTemplate:\n       spec:\n         template:\n           spec:\n             containers:\n             - name: backup\n               image: postgres:15-alpine\n               env:\n               - name: PGPASSWORD\n                 valueFrom:\n                   secretKeyRef:\n                     name: n8n-secrets\n                     key: DB_PASSWORD\n               command:\n               - /bin/sh\n               - -c\n               - |\n                 DATE=$(date +%Y%m%d_%H%M%S)\n                 pg_dump -h postgres-service -U n8n -d n8n > /backup/n8n_$DATE.sql\n                 \n                 # Upload to S3\n                 aws s3 cp /backup/n8n_$DATE.sql s3://fashionos-backups/n8n/\n                 \n                 # Keep only last 30 days\n                 aws s3 ls s3://fashionos-backups/n8n/ | while read -r line; do\n                   createDate=$(echo $line | awk {'print $1\" \"$2'})\n                   createDate=$(date -d\"$createDate\" +%s)\n                   olderThan=$(date -d\"30 days ago\" +%s)\n                   if [[ $createDate -lt $olderThan ]]; then\n                     fileName=$(echo $line | awk {'print $4'})\n                     aws s3 rm s3://fashionos-backups/n8n/$fileName\n                   fi\n                 done\n               volumeMounts:\n               - name: backup\n                 mountPath: /backup\n             volumes:\n             - name: backup\n               emptyDir: {}\n             restartPolicy: OnFailure\n   \"\n   \n   DC: write \"scripts/restore-backup.sh\" \"\n   #!/bin/bash\n   # Restore n8n from backup\n   \n   if [ -z \\\"$1\\\" ]; then\n     echo \\\"Usage: ./restore-backup.sh <backup-date>\\\"\n     echo \\\"Example: ./restore-backup.sh 20240315_020000\\\"\n     exit 1\n   fi\n   \n   BACKUP_FILE=\\\"n8n_$1.sql\\\"\n   \n   # Download backup from S3\n   aws s3 cp s3://fashionos-backups/n8n/$BACKUP_FILE /tmp/\n   \n   # Scale down n8n\n   kubectl scale deployment n8n --replicas=0 -n n8n-production\n   \n   # Restore database\n   kubectl exec -it postgres-0 -n n8n-production -- psql -U n8n -c \\\"DROP DATABASE n8n;\\\"\n   kubectl exec -it postgres-0 -n n8n-production -- psql -U n8n -c \\\"CREATE DATABASE n8n;\\\"\n   kubectl exec -i postgres-0 -n n8n-production -- psql -U n8n n8n < /tmp/$BACKUP_FILE\n   \n   # Scale up n8n\n   kubectl scale deployment n8n --replicas=3 -n n8n-production\n   \n   echo \\\"Restore completed!\\\"\n   \"\n   ```\n\n6. **Production deployment script**\n   ```bash\n   DC: write \"scripts/deploy-production.sh\" \"\n   #!/bin/bash\n   set -e\n   \n   echo \\\"🚀 Deploying n8n to Production\\\"\n   \n   # Pre-deployment checks\n   echo \\\"\\n📋 Running pre-deployment checks...\\\"\n   \n   # Check cluster connectivity\n   kubectl cluster-info\n   \n   # Check namespace\n   kubectl get namespace n8n-production || kubectl create namespace n8n-production\n   \n   # Backup current state\n   echo \\\"\\n💾 Creating backup of current state...\\\"\n   ./scripts/backup-current.sh\n   \n   # Apply configurations\n   echo \\\"\\n⚙️ Applying configurations...\\\"\n   kubectl apply -f k8s/production/ -n n8n-production\n   \n   # Wait for rollout\n   echo \\\"\\n⏳ Waiting for rollout to complete...\\\"\n   kubectl rollout status deployment/n8n -n n8n-production\n   kubectl rollout status statefulset/postgres -n n8n-production\n   \n   # Run health checks\n   echo \\\"\\n🏥 Running health checks...\\\"\n   ./scripts/health-check.sh\n   \n   # Run smoke tests\n   echo \\\"\\n🧪 Running smoke tests...\\\"\n   ./scripts/smoke-tests.sh\n   \n   echo \\\"\\n✅ Deployment completed successfully!\\\"\n   echo \\\"\\n📊 Access n8n at: https://n8n.fashionos.com\\\"\n   echo \\\"📈 Monitoring at: https://grafana.fashionos.com/d/n8n\\\"\n   \"\n   \n   DC: write \"scripts/health-check.sh\" \"\n   #!/bin/bash\n   \n   echo \\\"Checking n8n health...\\\"\n   \n   # Check pods\n   kubectl get pods -n n8n-production -l app=n8n\n   \n   # Check endpoints\n   for i in {1..30}; do\n     if curl -s https://n8n.fashionos.com/healthz | grep -q \\\"ok\\\"; then\n       echo \\\"✓ n8n is healthy\\\"\n       break\n     fi\n     echo \\\"Waiting for n8n to be ready... ($i/30)\\\"\n     sleep 10\n   done\n   \n   # Check database\n   kubectl exec postgres-0 -n n8n-production -- psql -U n8n -c \\\"SELECT COUNT(*) FROM workflow_entity;\\\"\n   \n   # Check Redis\n   kubectl exec deployment/redis -n n8n-production -- redis-cli ping\n   \"\n   \n   DC: write \"scripts/smoke-tests.sh\" \"\n   #!/bin/bash\n   \n   echo \\\"Running smoke tests...\\\"\n   \n   # Test webhook\n   curl -X POST https://n8n.fashionos.com/webhook-test/smoke \\\n     -H \\\"Content-Type: application/json\\\" \\\n     -d '{\\\"test\\\": \\\"smoke\\\"'\n   \n   # Test workflow execution\n   curl -X POST https://n8n.fashionos.com/api/v1/workflows/test/execute \\\n     -H \\\"Authorization: Bearer $N8N_API_KEY\\\" \\\n     -H \\\"Content-Type: application/json\\\"\n   \n   echo \\\"\\n✓ Smoke tests passed\\\"\n   \"\n   ```\n\n**Success Criteria**:\n- [ ] Production infrastructure deployed\n- [ ] High availability confirmed\n- [ ] SSL certificates active\n- [ ] Monitoring and alerts working\n- [ ] Backup and restore tested\n\n**Testing**:\n```bash\n# Deploy to production\nDC: exec \"chmod +x scripts/*.sh && ./scripts/deploy-production.sh\"\n\n# Test high availability\nDC: exec \"kubectl delete pod n8n-0 -n n8n-production\" # Should auto-recover\n\n# Test backup\nDC: exec \"kubectl create job --from=cronjob/n8n-backup test-backup -n n8n-production\"\n