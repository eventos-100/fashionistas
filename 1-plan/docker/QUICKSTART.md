# 🚀 Docker Security-First Quick Start Guide

## Prerequisites
- Docker Desktop installed and running
- You're logged in as: `sanjiovani`
- Project directory: `/home/sk/fx/docker`

## 🔒 Quick Setup (5 minutes)

### 1. Install Security Tools
```bash
cd /home/sk/fx/docker
make setup
```
This installs:
- ✅ Cosign (image signing)
- ✅ Hadolint (Dockerfile linting)
- ✅ Dockle (security scanning)
- ✅ Trivy (vulnerability scanning)

### 2. Generate Cosign Keys
```bash
make cosign-init
```
**Important:** Keep `cosign.key` safe and NEVER commit it!

### 3. Build Your First Secure Image
```bash
make build
```
This will:
- Validate Dockerfile with Hadolint
- Build with security best practices
- Run automated security tests
- Sign the image (if cosign is configured)

### 4. Run Security Tests
```bash
make test
```
Checks for:
- Non-root user
- No exposed secrets
- Health checks
- Read-only filesystem compatibility
- Minimal packages

### 5. Start Services
```bash
make run
make status
```

## 📋 Available Commands

```bash
make help      # Show all commands
make setup     # Install tools & generate secrets
make build     # Build secure image
make test      # Run security tests
make security  # Full security audit
make run       # Start services
make stop      # Stop services
make logs      # View logs
make clean     # Clean project resources
make push      # Push to registry
```

## 🔐 Security Features Implemented

### ✅ Dockerfile Security
- Non-root user (UID 1001)
- Minimal base image (Alpine)
- No unnecessary packages
- Health checks configured
- Proper signal handling (dumb-init)

### ✅ Runtime Security
- Read-only root filesystem
- Dropped capabilities
- No new privileges
- Resource limits enforced
- Secrets via files (not env vars)

### ✅ Build Security
- Hadolint validation
- Multi-stage builds
- No secrets in layers
- Image signing with Cosign
- SBOM generation

### ✅ Compose Security
- User namespace mapping
- Network isolation
- Volume permissions
- Health checks on all services
- Filtered cleanup (by project label)

## 🚨 Common Issues & Solutions

### Issue: "Permission denied"
```bash
sudo chown -R $USER:$USER /home/sk/fx/docker
```

### Issue: "Cosign key not found"
```bash
make cosign-init
```

### Issue: "Image not signed"
```bash
cosign sign --key cosign.key docker.io/sanjiovani/eventsops:latest
```

### Issue: "Security test failed"
```bash
# Check specific failure
./tests/security-test.sh docker.io/sanjiovani/eventsops:latest
```

## 📊 Monitoring Security

### Check Vulnerabilities
```bash
make security
```

### Verify Image Signature
```bash
make verify
```

### Quick Security Scan
```bash
make scan
```

## 🎯 Next Steps

1. **Customize the Dockerfile**
   - Edit `dockerfiles/Dockerfile.secure`
   - Add your application code
   - Maintain security principles

2. **Update Secrets**
   - Never use default secrets in production
   - Integrate with secret management system
   - Use Docker Swarm or Kubernetes for production secrets

3. **CI/CD Integration**
   - Push to GitHub
   - Configure GitHub Actions secrets
   - Enable automated builds

4. **Production Deployment**
   ```bash
   make deploy
   ```

## 📚 Resources

- [Docker Security Best Practices](https://docs.docker.com/develop/security-best-practices/)
- [Cosign Documentation](https://docs.sigstore.dev/cosign/overview/)
- [OWASP Docker Security](https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html)

## 🆘 Support

- Project issues: Create an issue in the repository
- Security concerns: security@eventsops.com
- Docker Hub: [sanjiovani](https://hub.docker.com/u/sanjiovani)

---

**Remember:** Security is not a feature, it's a requirement. Always validate before deploying!