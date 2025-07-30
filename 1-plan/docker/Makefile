# Secure Docker Makefile
# Project: EventsOps
# Security-first approach with filtered operations

.PHONY: help setup build test run stop clean security push deploy

# Load project configuration
include .env.project
export

# Default target
help: ## Show this help message
	@echo "EventsOps Docker - Security First"
	@echo "================================"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

setup: ## Install security tools and create directories
	@echo "🔧 Setting up security tools..."
	@./scripts/setup-security.sh
	@./scripts/generate-secrets.sh

build: ## Build secure Docker image
	@echo "🏗️  Building secure image..."
	@./scripts/secure-build.sh

test: ## Run security tests
	@echo "🧪 Running security tests..."
	@./tests/security-test.sh $(REGISTRY)/$(PROJECT):$(VERSION)

run: ## Start services with docker-compose
	@echo "🚀 Starting services..."
	@docker compose -f docker-compose.secure.yml up -d
	@echo "✅ Services started. Check health: make status"
stop: ## Stop all services
	@echo "⏹️  Stopping services..."
	@docker compose -f docker-compose.secure.yml down

clean: ## Clean project resources (filtered by label)
	@echo "🧹 Cleaning project resources..."
	@docker compose -f docker-compose.secure.yml down -v
	@docker system prune --filter "label=project=$(PROJECT)" -af
	@echo "✅ Cleaned resources for project: $(PROJECT)"

security: ## Run full security audit
	@echo "🔒 Running security audit..."
	@hadolint dockerfiles/Dockerfile.secure || true
	@docker scout cves $(REGISTRY)/$(PROJECT):$(VERSION) || true
	@dockle $(REGISTRY)/$(PROJECT):$(VERSION) || true
	@trivy image $(REGISTRY)/$(PROJECT):$(VERSION) || true

push: ## Push image to registry (requires auth)
	@echo "📤 Pushing to registry..."
	@PUSH=true ./scripts/secure-build.sh

deploy: ## Deploy to production (with validation)
	@echo "🚀 Deploying to production..."
	@./scripts/production-validate.sh
	@docker compose -f docker-compose.secure.yml up -d

status: ## Check service health
	@echo "📊 Service Status:"
	@docker compose -f docker-compose.secure.yml ps
	@echo ""
	@echo "🏥 Health Checks:"
	@docker ps --filter "label=project=$(PROJECT)" --format "table {{.Names}}\t{{.Status}}"

logs: ## View service logs
	@docker compose -f docker-compose.secure.yml logs -f

shell: ## Open shell in app container (for debugging)
	@docker compose -f docker-compose.secure.yml exec -u appuser app /bin/sh

cosign-init: ## Initialize cosign keys
	@echo "🔐 Generating cosign key pair..."
	@cosign generate-key-pair
	@echo "✅ Keys generated. Keep cosign.key safe!"

verify: ## Verify image signature
	@echo "🔐 Verifying image signature..."
	@cosign verify --key cosign.pub $(REGISTRY)/$(PROJECT):$(VERSION)

scan: ## Quick security scan
	@docker scout quickview $(REGISTRY)/$(PROJECT):$(VERSION)