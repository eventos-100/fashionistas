const fs = require('fs');
const path = require('path');

console.log('🔍 Test 4: Form Structure and Validation\n');

// Read the form component
const formPath = path.join(__dirname, 'components/IncidentReportForm.tsx');
const formContent = fs.readFileSync(formPath, 'utf8');

// Check form fields
console.log('📋 Form Field Validation:');
const formFields = [
  { field: 'name', type: 'string', required: true },
  { field: 'email', type: 'email', required: true },
  { field: 'incidentType', type: 'select', required: true },
  { field: 'date', type: 'date', required: true },
  { field: 'description', type: 'textarea', required: true },
  { field: 'impactLevel', type: 'select', required: true },
  { field: 'suggestedActions', type: 'textarea', required: true }
];

formFields.forEach(({ field, type }) => {
  if (formContent.includes(`"${field}"`)) {
    console.log(`✅ Form field "${field}" (${type}) is defined`);
  } else {
    console.log(`❌ Form field "${field}" not found`);
  }
});

// Check Zod schema
console.log('\n📋 Zod Schema Validation:');
if (formContent.includes('z.object({')) {
  console.log('✅ Zod schema is defined');
  
  // Check validation rules
  const validations = [
    { pattern: /name.*min\(2/, desc: 'Name min length validation' },
    { pattern: /email.*email\(/, desc: 'Email format validation' },
    { pattern: /description.*min\(10/, desc: 'Description min length validation' },
    { pattern: /required_error/, desc: 'Required field validation' }
  ];
  
  validations.forEach(({ pattern, desc }) => {
    if (pattern.test(formContent)) {
      console.log(`✅ ${desc} exists`);
    } else {
      console.log(`⚠️  ${desc} not found`);
    }
  });
} else {
  console.log('❌ Zod schema not found');
}

// Check CopilotKit integration
console.log('\n📋 CopilotKit Integration:');
const copilotFeatures = [
  { hook: 'useCopilotReadable', desc: 'Form state sharing with AI' },
  { hook: 'useCopilotAction', desc: 'AI form filling action' },
  { hook: 'fillIncidentReportForm', desc: 'Named action for form filling' }
];

copilotFeatures.forEach(({ hook, desc }) => {
  if (formContent.includes(hook)) {
    console.log(`✅ ${desc} (${hook}) is implemented`);
  } else {
    console.log(`❌ ${desc} (${hook}) not found`);
  }
});

// Check form submission
if (formContent.includes('onSubmit')) {
  console.log('\n✅ Form submission handler is defined');
} else {
  console.log('\n❌ Form submission handler not found');
}