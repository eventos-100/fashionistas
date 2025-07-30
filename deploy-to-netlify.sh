#!/bin/bash

# Netlify Deployment Script
echo "🚀 Starting Netlify Deployment Process..."

# Check if Netlify CLI is installed
if ! command -v netlify &> /dev/null; then
    echo "❌ Netlify CLI not found. Installing..."
    npm install -g netlify-cli
fi

# Check if we're logged in
echo "📝 Checking Netlify authentication..."
netlify status

# If not logged in, prompt for login
if [ $? -ne 0 ]; then
    echo "🔐 Please login to Netlify..."
    netlify login
fi

# Link to existing site or create new one
echo "🔗 Linking to Netlify site..."
netlify link

# Build the project
echo "🏗️ Building project..."
pnpm run build

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    
    # Deploy to production
    echo "🚀 Deploying to production..."
    netlify deploy --prod
    
    if [ $? -eq 0 ]; then
        echo "✅ Deployment successful!"
        echo "🌐 Your site is now live!"
        netlify open
    else
        echo "❌ Deployment failed. Check the logs above."
    fi
else
    echo "❌ Build failed. Please fix errors before deploying."
fi