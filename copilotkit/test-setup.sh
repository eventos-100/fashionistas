#!/bin/bash

echo "🚀 CopilotKit Form-Filling Setup Test"
echo "====================================="

# Check if in correct directory
if [ ! -f "CopilotKit/examples/copilot-form-filling/package.json" ]; then
    echo "❌ Not in the correct directory. Please run from /home/sk/fx/copilotkit"
    exit 1
fi

cd CopilotKit/examples/copilot-form-filling

# Check Node.js version
echo "📌 Checking Node.js version..."
node_version=$(node -v)
echo "Node.js version: $node_version"

# Check if dependencies are installed
echo "📦 Checking dependencies..."
if [ ! -d "node_modules" ]; then
    echo "❌ Dependencies not installed. Run: pnpm install"
    exit 1
else
    echo "✅ Dependencies installed"
fi

# Check .env file
echo "🔑 Checking .env configuration..."
if [ ! -f ".env" ]; then
    echo "❌ .env file not found"
    exit 1
fi

if grep -q "your_api_key_here" .env; then
    echo "⚠️  API key not configured. Please add your CopilotKit API key"
    echo "   Get your key from: https://cloud.copilotkit.ai"
else
    echo "✅ API key configured"
fi

# Check if port 3000 is available
echo "🌐 Checking port 3000..."
if lsof -Pi :3000 -sTCP:LISTEN -t >/dev/null ; then
    echo "⚠️  Port 3000 is already in use"
else
    echo "✅ Port 3000 is available"
fi

echo ""
echo "📋 Next Steps:"
echo "1. Get your API key from https://cloud.copilotkit.ai"
echo "2. Add it to the .env file"
echo "3. Run: pnpm dev"
echo "4. Open http://localhost:3000"