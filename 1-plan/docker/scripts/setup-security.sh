#!/bin/bash
# Docker Security Setup Script
# This script installs all required security tools for Docker

set -e

echo "🔒 Docker Security Tools Setup"
echo "=============================="

# Update system
echo "📦 Updating package lists..."
sudo apt update

# Install cosign
echo "🔐 Installing cosign..."
if ! command -v cosign &> /dev/null; then
    wget "https://github.com/sigstore/cosign/releases/download/v2.2.2/cosign-linux-amd64"
    sudo mv cosign-linux-amd64 /usr/local/bin/cosign
    sudo chmod +x /usr/local/bin/cosign
    echo "✅ Cosign installed: $(cosign version)"
else
    echo "✅ Cosign already installed: $(cosign version)"
fi

# Install hadolint
echo "🔍 Installing hadolint..."
if ! command -v hadolint &> /dev/null; then
    wget -O hadolint "https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64"
    sudo mv hadolint /usr/local/bin/hadolint
    sudo chmod +x /usr/local/bin/hadolint
    echo "✅ Hadolint installed"
else
    echo "✅ Hadolint already installed"
fi
# Install dockle
echo "🐳 Installing dockle..."
if ! command -v dockle &> /dev/null; then
    VERSION=$(curl --silent "https://api.github.com/repos/goodwithtech/dockle/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
    wget -O dockle.deb "https://github.com/goodwithtech/dockle/releases/download/v${VERSION}/dockle_${VERSION}_Linux-64bit.deb"
    sudo dpkg -i dockle.deb
    rm dockle.deb
    echo "✅ Dockle installed"
else
    echo "✅ Dockle already installed"
fi

# Install trivy
echo "🔍 Installing trivy..."
if ! command -v trivy &> /dev/null; then
    sudo apt-get install wget apt-transport-https gnupg lsb-release -y
    wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
    echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
    sudo apt-get update
    sudo apt-get install trivy -y
    echo "✅ Trivy installed"
else
    echo "✅ Trivy already installed"
fi

# Create required directories
echo "📁 Creating project directories..."
mkdir -p ../configs ../dockerfiles ../secrets ../tests

# Set permissions on secrets directory
chmod 700 ../secrets

echo ""
echo "✅ All security tools installed successfully!"
echo ""
echo "Next steps:"
echo "1. Generate cosign keys: cd .. && cosign generate-key-pair"
echo "2. Create secure Dockerfile using templates in dockerfiles/"
echo "3. Run security tests with tests/security-test.sh"