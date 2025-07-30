const fs = require('fs');
const path = require('path');

console.log('🔍 Test 2: CopilotKit API Key Configuration\n');

// Check .env.local file exists
const envPath = path.join(__dirname, '.env.local');
if (fs.existsSync(envPath)) {
  console.log('✅ .env.local file exists');
  
  const envContent = fs.readFileSync(envPath, 'utf8');
  const hasApiKey = envContent.includes('NEXT_PUBLIC_COPILOT_PUBLIC_API_KEY');
  const apiKeyValue = envContent.match(/NEXT_PUBLIC_COPILOT_PUBLIC_API_KEY=(.+)/);
  
  if (hasApiKey && apiKeyValue) {
    const key = apiKeyValue[1].trim();
    if (key.startsWith('ck_pub_')) {
      console.log('✅ API key is properly formatted (starts with ck_pub_)');
      console.log(`✅ API key length: ${key.length} characters`);
    } else {
      console.log('❌ API key format is incorrect');
    }
  } else {
    console.log('❌ API key not found in .env.local');
  }
} else {
  console.log('❌ .env.local file not found');
}

// Check if API key is accessible in process.env
console.log('\n📋 Environment variable check:');
if (process.env.NEXT_PUBLIC_COPILOT_PUBLIC_API_KEY) {
  console.log('✅ API key is loaded in environment');
} else {
  console.log('⚠️  API key not in process.env (normal for Node.js scripts)');
}