#!/bin/bash
# Secure Docker Build Script
# Builds images with security validation and signing

set -e

# Load project config
source .env.project

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "🔒 Secure Docker Build"
echo "====================="

# Set defaults
DOCKERFILE="${DOCKERFILE:-dockerfiles/Dockerfile.secure}"
IMAGE="${REGISTRY}/${PROJECT}:${VERSION:-latest}"
PLATFORMS="${PLATFORMS:-linux/amd64,linux/arm64}"

# Step 1: Validate Dockerfile
echo "🔍 Validating Dockerfile..."
if command -v hadolint >/dev/null 2>&1; then
    hadolint "$DOCKERFILE" || {
        echo -e "${RED}❌ Dockerfile validation failed!${NC}"
        exit 1
    }
    echo -e "${GREEN}✅ Dockerfile validation passed${NC}"
else
    echo "⚠️  Hadolint not installed, skipping validation"
fi
# Step 2: Build with BuildKit
echo "🏗️  Building image: $IMAGE"
DOCKER_BUILDKIT=1 docker build \
    --file "$DOCKERFILE" \
    --build-arg BUILDKIT_INLINE_CACHE=1 \
    --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
    --build-arg VCS_REF="$(git rev-parse --short HEAD 2>/dev/null || echo 'no-git')" \
    --build-arg VERSION="${VERSION}" \
    --label "project=${PROJECT}" \
    --label "security.scan=pending" \
    --tag "$IMAGE" \
    --target production \
    . || {
        echo -e "${RED}❌ Build failed!${NC}"
        exit 1
    }

echo -e "${GREEN}✅ Build successful${NC}"

# Step 3: Run security tests
echo "🧪 Running security tests..."
./tests/security-test.sh "$IMAGE" || {
    echo -e "${RED}❌ Security tests failed!${NC}"
    exit 1
}

# Step 4: Sign image (if cosign available)
if command -v cosign >/dev/null 2>&1 && [ -f "cosign.key" ]; then
    echo "🔐 Signing image..."
    cosign sign --key cosign.key "$IMAGE"
    echo -e "${GREEN}✅ Image signed${NC}"
else
    echo "⚠️  Cosign not configured, skipping signing"
fi
# Step 5: Generate SBOM (if syft available)
if command -v syft >/dev/null 2>&1; then
    echo "📋 Generating SBOM..."
    syft "$IMAGE" -o spdx-json > "sbom-${VERSION}.json"
    echo -e "${GREEN}✅ SBOM generated${NC}"
else
    echo "⚠️  Syft not installed, skipping SBOM generation"
fi

# Step 6: Push to registry (optional)
if [ "${PUSH:-false}" = "true" ]; then
    echo "📤 Pushing to registry..."
    docker push "$IMAGE"
    echo -e "${GREEN}✅ Image pushed to registry${NC}"
fi

# Summary
echo ""
echo "=============================="
echo -e "${GREEN}✅ Secure build complete!${NC}"
echo "Image: $IMAGE"
echo ""
echo "Next steps:"
echo "1. Test locally: docker run --rm -p 3000:3000 $IMAGE"
echo "2. Deploy: docker compose -f docker-compose.secure.yml up -d"
echo "3. Push to registry: PUSH=true ./scripts/secure-build.sh"