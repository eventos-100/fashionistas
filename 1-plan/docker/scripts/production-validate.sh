#!/bin/bash
# Production Validation Script
# Ensures all security requirements are met before deployment

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "🎯 Production Validation Checklist"
echo "=================================="

CHECKS_PASSED=0
CHECKS_TOTAL=0

# Function to run checks
check() {
    local check_name="$1"
    local check_command="$2"
    
    CHECKS_TOTAL=$((CHECKS_TOTAL + 1))
    echo -n "Checking $check_name... "
    
    if eval "$check_command" >/dev/null 2>&1; then
        echo -e "${GREEN}✅ PASS${NC}"
        CHECKS_PASSED=$((CHECKS_PASSED + 1))
    else
        echo -e "${RED}❌ FAIL${NC}"
    fi
}

# Load configuration
source .env.project

# Check 1: Security tools installed
check "security tools" "command -v cosign && command -v hadolint && command -v dockle"
# Check 2: Cosign keys exist
check "cosign keys" "[ -f cosign.key ] && [ -f cosign.pub ]"

# Check 3: Image exists
IMAGE="${REGISTRY}/${PROJECT}:${VERSION}"
check "image exists" "docker image inspect $IMAGE"

# Check 4: Image is signed
check "image signed" "cosign verify --key cosign.pub $IMAGE 2>/dev/null"

# Check 5: Dockerfile validated
check "dockerfile valid" "hadolint dockerfiles/Dockerfile.secure"

# Check 6: Security tests pass
check "security tests" "./tests/security-test.sh $IMAGE"

# Check 7: No high vulnerabilities
check "vulnerability scan" "! (docker scout cves $IMAGE 2>/dev/null | grep -E 'CRITICAL|HIGH')"

# Check 8: Secrets configured
check "secrets exist" "[ -f secrets/db_password ] && [ -f secrets/redis_password ]"

# Check 9: Compose file valid
check "compose valid" "docker compose -f docker-compose.secure.yml config"

# Check 10: Environment configured
check "environment" "[ -f .env.project ]"

# Summary
echo ""
echo "=================================="
echo "Validation Summary:"
echo "Total Checks: $CHECKS_TOTAL"
echo -e "Passed: ${GREEN}$CHECKS_PASSED${NC}"
echo -e "Failed: ${RED}$((CHECKS_TOTAL - CHECKS_PASSED))${NC}"

if [ $CHECKS_PASSED -eq $CHECKS_TOTAL ]; then
    echo ""
    echo -e "${GREEN}✅ All production checks passed!${NC}"
    echo "Ready for deployment."
    exit 0
else
    echo ""
    echo -e "${RED}❌ Production validation failed!${NC}"
    echo "Please fix the issues before deploying."
    exit 1
fi