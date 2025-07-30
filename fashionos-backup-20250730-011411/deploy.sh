#!/bin/bash
# Deploy script for FashionOS

echo "Deploying FashionOS to Vercel..."

# Navigate to the Next.js app directory
cd apps/website/nextapp

# Deploy using Vercel CLI
vercel --prod

echo "Deployment complete!"
