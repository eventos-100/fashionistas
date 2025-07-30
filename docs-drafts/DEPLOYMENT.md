# Deployment Guide

## Production Build
```bash
npm run build
```

## Docker Deployment
```bash
docker build -t fashionos .
docker run -p 3000:3000 fashionos
```

## Vercel Deployment
1. Connect GitHub repository
2. Configure environment variables
3. Deploy
