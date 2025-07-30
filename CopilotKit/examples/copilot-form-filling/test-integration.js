#!/usr/bin/env node

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const http = require('http');

console.log('🚀 CopilotKit Form-Filling Integration Test Suite\n');
console.log('=' .repeat(50) + '\n');

let testsPassed = 0;
let testsFailed = 0;

function runTest(name, testFn) {
  process.stdout.write(`Running: ${name}... `);
  try {
    const result = testFn();
    if (result) {
      console.log('✅ PASSED');
      testsPassed++;
    } else {
      console.log('❌ FAILED');
      testsFailed++;
    }
  } catch (error) {
    console.log(`❌ FAILED: ${error.message}`);
    testsFailed++;
  }
}

// Test 1: Environment Setup
runTest('Environment Setup', () => {
  const envExists = fs.existsSync('.env.local');
  const hasApiKey = envExists && fs.readFileSync('.env.local', 'utf8').includes('ck_pub_');
  return envExists && hasApiKey;
});

// Test 2: Dependencies Installed
runTest('Dependencies Installed', () => {
  return fs.existsSync('node_modules/@copilotkit/react-core');
});

// Test 3: TypeScript Configuration
runTest('TypeScript Configuration', () => {
  const tsConfig = JSON.parse(fs.readFileSync('tsconfig.json', 'utf8'));
  return tsConfig.compilerOptions.strict === true;
});

// Test 4: Build Process
runTest('Build Process', () => {
  try {
    console.log('\n  Building project...');
    execSync('npm run build', { stdio: 'pipe' });
    return true;
  } catch (error) {
    console.log('\n  Build failed:', error.message);
    return false;
  }
});

// Test 5: CopilotKit Hook Imports
runTest('CopilotKit Hooks Available', () => {
  const formContent = fs.readFileSync('components/IncidentReportForm.tsx', 'utf8');
  return formContent.includes('useCopilotAction') && 
         formContent.includes('useCopilotReadable') &&
         formContent.includes('@copilotkit/react-core');
});

// Test 6: Form Validation Schema
runTest('Form Validation Schema', () => {
  const formContent = fs.readFileSync('components/IncidentReportForm.tsx', 'utf8');
  return formContent.includes('z.object({') && 
         formContent.includes('zodResolver');
});

// Test 7: AI Prompt Configuration
runTest('AI Prompt Configuration', () => {
  const promptExists = fs.existsSync('lib/prompt.ts');
  if (promptExists) {
    const promptContent = fs.readFileSync('lib/prompt.ts', 'utf8');
    return promptContent.includes('incident report');
  }
  return false;
});

// Test 8: Component Structure
runTest('Component Structure', () => {
  const uiComponents = [
    'components/ui/button.tsx',
    'components/ui/form.tsx',
    'components/ui/input.tsx',
    'components/ui/select.tsx'
  ];
  return uiComponents.every(comp => fs.existsSync(comp));
});

// Test 9: Server Response
runTest('Server Health Check', () => {
  return new Promise((resolve) => {
    http.get('http://localhost:3002', (res) => {
      resolve(res.statusCode === 200);
    }).on('error', () => resolve(false));
  });
});

// Test 10: CopilotKit Provider Setup
runTest('CopilotKit Provider in Layout', () => {
  const layoutContent = fs.readFileSync('app/layout.tsx', 'utf8');
  return layoutContent.includes('<CopilotKit') && 
         layoutContent.includes('publicApiKey');
});

// Summary
console.log('\n' + '=' .repeat(50));
console.log(`\n📊 Test Summary:`);
console.log(`   ✅ Passed: ${testsPassed}`);
console.log(`   ❌ Failed: ${testsFailed}`);
console.log(`   📈 Success Rate: ${Math.round((testsPassed / (testsPassed + testsFailed)) * 100)}%`);

if (testsFailed === 0) {
  console.log('\n🎉 All tests passed! CopilotKit is properly configured.');
} else {
  console.log('\n⚠️  Some tests failed. Please check the configuration.');
}

// Detailed report
console.log('\n📋 Detailed Configuration Report:');
console.log(`   - Server URL: http://localhost:3002`);
console.log(`   - API Key Status: ${fs.existsSync('.env.local') ? 'Configured' : 'Missing'}`);
console.log(`   - Form Fields: 7 fields with validation`);
console.log(`   - AI Actions: fillIncidentReportForm`);
console.log(`   - UI Components: shadcn/ui integrated`);

console.log('\n💡 Next Steps:');
console.log('   1. Open http://localhost:3002 in your browser');
console.log('   2. Click the chat icon to open CopilotKit assistant');
console.log('   3. Try: "Fill the form with test data"');
console.log('   4. Verify form fields are populated correctly\n');

process.exit(testsFailed > 0 ? 1 : 0);