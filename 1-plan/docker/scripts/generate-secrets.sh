#!/bin/bash
# Secret Management Script
# Generates secure secrets for local development

set -e

echo "🔐 Generating Development Secrets"
echo "================================"

# Create secrets directory with proper permissions
chmod 700 ./secrets

# Generate secure passwords
DB_PASSWORD=$(openssl rand -base64 32)
REDIS_PASSWORD=$(openssl rand -base64 32)
APP_SECRET=$(openssl rand -hex 32)

# Create secret files
echo "Creating secret files..."

# Database password
echo -n "$DB_PASSWORD" > ./secrets/db_password
chmod 600 ./secrets/db_password

# Redis password  
echo -n "$REDIS_PASSWORD" > ./secrets/redis_password
chmod 600 ./secrets/redis_password

# Database URL
cat > ./secrets/db_url << EOF
postgresql://appuser:${DB_PASSWORD}@postgres:5432/appdb?sslmode=require
EOF
chmod 600 ./secrets/db_url

# App secret
echo -n "$APP_SECRET" > ./secrets/app_secret
chmod 600 ./secrets/app_secret

# Create .gitignore for secrets
cat > ./secrets/.gitignore << 'EOF'
# Ignore all files in this directory
*
# Except this file
!.gitignore
EOF

echo "✅ Secrets generated successfully!"
echo ""
echo "⚠️  IMPORTANT: Never commit these secrets to git!"
echo "For production, use a proper secret management system like:"
echo "  - HashiCorp Vault"
echo "  - AWS Secrets Manager" 
echo "  - Doppler"
echo "  - Azure Key Vault"