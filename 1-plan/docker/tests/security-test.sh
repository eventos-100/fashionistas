#!/bin/bash
# Security Test Suite for Docker Images
# Validates security best practices

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default image to test
IMAGE="${1:-${REGISTRY}/${PROJECT}:${VERSION:-latest}}"

echo "🔒 Docker Security Test Suite"
echo "Testing image: $IMAGE"
echo "=============================="

FAILED_TESTS=0
TOTAL_TESTS=0

# Test function
run_test() {
    local test_name="$1"
    local test_command="$2"
    local expected_result="$3"
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    echo -n "Testing $test_name... "
    
    if eval "$test_command"; then
        echo -e "${GREEN}✅ PASS${NC}"
    else
        echo -e "${RED}❌ FAIL${NC} - $expected_result"
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
}
# Test 1: Non-root user
test_non_root() {
    USER_ID=$(docker run --rm "$IMAGE" id -u 2>/dev/null)
    [ "$USER_ID" -gt 0 ] 2>/dev/null
}
run_test "non-root user" test_non_root "Container must run as non-root user"

# Test 2: No exposed secrets
test_no_secrets() {
    SECRETS=$(docker run --rm "$IMAGE" env 2>/dev/null | grep -E "(PASSWORD|SECRET|KEY|TOKEN|PASS)" | grep -v "_FILE" | wc -l)
    [ "$SECRETS" -eq 0 ]
}
run_test "no exposed secrets" test_no_secrets "No secrets in environment variables"

# Test 3: Health check exists
test_healthcheck() {
    docker inspect "$IMAGE" 2>/dev/null | jq -e '.[0].Config.Healthcheck.Test | length > 0' >/dev/null
}
run_test "health check configured" test_healthcheck "Healthcheck must be defined"

# Test 4: Read-only filesystem compatibility
test_readonly_fs() {
    docker run --rm --read-only --tmpfs /tmp "$IMAGE" echo "test" >/dev/null 2>&1
}
run_test "read-only filesystem" test_readonly_fs "Must work with read-only root"

# Test 5: No unnecessary packages
test_minimal_packages() {
    # Check if common unnecessary packages are absent
    docker run --rm "$IMAGE" sh -c 'command -v sudo || command -v wget || command -v gcc' >/dev/null 2>&1
    [ $? -ne 0 ]  # Should fail (packages not found)
}
run_test "minimal packages" test_minimal_packages "No unnecessary packages installed"
# Test 6: Capability dropping works
test_capabilities() {
    docker run --rm --cap-drop ALL "$IMAGE" echo "test" >/dev/null 2>&1
}
run_test "capability dropping" test_capabilities "Must work with all capabilities dropped"

# Test 7: Security labels present
test_labels() {
    LABELS=$(docker inspect "$IMAGE" | jq -r '.[0].Config.Labels | keys | length')
    [ "$LABELS" -gt 3 ]  # Should have metadata labels
}
run_test "metadata labels" test_labels "Should have proper metadata labels"

# Test 8: No SUID/SGID binaries
test_no_suid() {
    SUID_COUNT=$(docker run --rm "$IMAGE" find / -type f \( -perm -4000 -o -perm -2000 \) 2>/dev/null | wc -l)
    [ "$SUID_COUNT" -lt 5 ]  # Allow some essential system binaries
}
run_test "minimal SUID binaries" test_no_suid "Should have minimal SUID/SGID binaries"

# Test 9: User exists and has proper setup
test_user_setup() {
    docker run --rm "$IMAGE" sh -c 'id appuser && [ -d /home/appuser ]' >/dev/null 2>&1
}
run_test "user properly configured" test_user_setup "User 'appuser' should exist with home directory"

# Test 10: Entrypoint uses dumb-init
test_dumb_init() {
    ENTRYPOINT=$(docker inspect "$IMAGE" | jq -r '.[0].Config.Entrypoint[0]')
    [[ "$ENTRYPOINT" == *"dumb-init"* ]]
}
run_test "signal handling (dumb-init)" test_dumb_init "Should use dumb-init for proper signal handling"
# Summary
echo "=============================="
echo "Test Summary:"
echo "Total Tests: $TOTAL_TESTS"
echo -e "Passed: ${GREEN}$((TOTAL_TESTS - FAILED_TESTS))${NC}"
echo -e "Failed: ${RED}$FAILED_TESTS${NC}"

if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "${GREEN}✅ All security tests passed!${NC}"
    
    # Run additional security scans if all tests pass
    echo ""
    echo "Running additional security scans..."
    
    if command -v dockle >/dev/null 2>&1; then
        echo "Running Dockle..."
        dockle --exit-code 0 "$IMAGE" || echo -e "${YELLOW}⚠️  Dockle found some issues${NC}"
    fi
    
    if command -v trivy >/dev/null 2>&1; then
        echo "Running Trivy..."
        trivy image --severity HIGH,CRITICAL "$IMAGE"
    fi
    
    exit 0
else
    echo -e "${RED}❌ Security tests failed!${NC}"
    echo "Please fix the issues before deploying to production."
    exit 1
fi