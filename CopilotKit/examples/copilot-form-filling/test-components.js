const https = require('https');
const http = require('http');

console.log('🔍 Test 3: Verify CopilotKit Components\n');

// Test if CopilotKit scripts are loaded
const testUrl = 'http://localhost:3002';

http.get(testUrl, (res) => {
  let data = '';
  
  res.on('data', (chunk) => {
    data += chunk;
  });
  
  res.on('end', () => {
    // Check for CopilotKit components
    const checks = [
      { pattern: /@copilotkit\/react-core/, name: 'CopilotKit React Core' },
      { pattern: /@copilotkit\/react-ui/, name: 'CopilotKit React UI' },
      { pattern: /CopilotKit/, name: 'CopilotKit Provider' },
      { pattern: /useCopilotAction/, name: 'useCopilotAction hook' },
      { pattern: /useCopilotReadable/, name: 'useCopilotReadable hook' },
      { pattern: /_next\/static/, name: 'Next.js static assets' },
      { pattern: /IncidentReportForm/, name: 'Form component' }
    ];
    
    console.log('📋 Component Loading Check:');
    checks.forEach(check => {
      if (data.includes(check.pattern.source) || check.pattern.test(data)) {
        console.log(`✅ ${check.name} found`);
      } else {
        console.log(`⚠️  ${check.name} not found in initial HTML`);
      }
    });
    
    // Check for API key in client-side code
    if (data.includes('ck_pub_')) {
      console.log('✅ API key is included in client bundle');
    } else {
      console.log('⚠️  API key not found in initial response');
    }
    
    // Check for error messages
    if (data.includes('error') || data.includes('Error')) {
      console.log('\n⚠️  Potential errors detected in response');
    } else {
      console.log('\n✅ No obvious errors in response');
    }
  });
}).on('error', (err) => {
  console.error('❌ Failed to connect to server:', err.message);
});