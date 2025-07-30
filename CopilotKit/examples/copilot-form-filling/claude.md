# Project Overview

**Project Name**: CopilotKit Form-Filling Example  
**Description**: AI-powered conversational form-filling assistant that transforms tedious data entry into natural conversations. Built to demonstrate CopilotKit's capabilities for intelligent form completion.

**Repository Path**: `/home/sk/fx/CopilotKit/examples/copilot-form-filling`  
**Primary Purpose**: Showcase implementation of conversational AI for form automation using CopilotKit

## Tech Stack

| Component | Version | Purpose |
|-----------|---------|---------|
| Next.js | 15.2.0-canary.76 | React framework with App Router |
| React | 19.1.0 | UI library |
| TypeScript | 5.8.3 | Type safety |
| CopilotKit | 1.8.13 | AI integration framework |
| Tailwind CSS | 4.1.7 | Utility-first CSS |
| shadcn/ui | Latest | Component library |
| React Hook Form | 7.56.4 | Form state management |
| Zod | 3.25.17 | Schema validation |

## File Structure

```
copilot-form-filling/
├── app/                      # Next.js App Router
│   ├── layout.tsx           # Root layout with CopilotKit provider
│   ├── page.tsx             # Main page with form
│   └── globals.css          # Global styles
├── components/              
│   ├── IncidentReportForm.tsx  # Main form component with AI integration
│   └── ui/                     # shadcn/ui components
│       ├── button.tsx
│       ├── calendar.tsx
│       ├── card.tsx
│       ├── form.tsx
│       ├── input.tsx
│       ├── label.tsx
│       ├── popover.tsx
│       ├── select.tsx
│       └── textarea.tsx
├── lib/
│   ├── prompt.ts            # AI assistant prompt configuration
│   ├── user-info.ts         # User context utilities
│   └── utils.ts             # Utility functions (cn, etc.)
├── public/                  # Static assets
├── .env.local              # Environment variables (API keys)
├── next.config.ts          # Next.js configuration
├── tsconfig.json           # TypeScript configuration
└── package.json            # Dependencies and scripts
```

## Conventions

### Code Style
- **TypeScript**: Strict mode enabled, ES2017 target
- **React**: Functional components with hooks
- **Imports**: Use `@/` alias for project root imports
- **Exports**: Prefer named exports for components
- **File Naming**: 
  - Components: PascalCase (e.g., `IncidentReportForm.tsx`)
  - Utilities: camelCase (e.g., `userInfo.ts`)
  - Config: kebab-case (e.g., `next.config.ts`)

### Component Patterns
```tsx
// ✅ Preferred pattern for AI-integrated components
"use client";

import { useCopilotAction, useCopilotReadable } from "@copilotkit/react-core";

export function FormComponent() {
  // 1. Form state management
  const form = useForm<FormSchema>({ resolver: zodResolver(formSchema) });
  
  // 2. Share state with AI
  useCopilotReadable({
    description: "Current form state",
    value: form.watch()
  });
  
  // 3. Enable AI actions
  useCopilotAction({
    name: "updateForm",
    handler: async (data) => {
      // Update form fields
    }
  });
}
```

### Styling Guidelines
- Use Tailwind CSS utilities for styling
- Follow shadcn/ui component patterns
- Maintain consistent spacing: `space-y-4` for form sections
- Use semantic color variables from shadcn/ui

### Form Validation
- Define schemas with Zod
- Use React Hook Form for state management
- Display validation errors with `<FormMessage />`
- Implement progressive disclosure for complex forms

## Commands

### Development
```bash
# Install dependencies
npm install --legacy-peer-deps

# Start development server
npm run dev

# Type checking
npm run type-check

# Linting
npm run lint

# Format code
npm run format
```

### Build & Production
```bash
# Build for production
npm run build

# Start production server
npm start

# Analyze bundle size
npm run analyze
```

### Testing
```bash
# Run unit tests (when implemented)
npm run test

# Run E2E tests (when implemented)
npm run test:e2e
```

## Assistant Instructions

<details>
<summary><strong>🤖 How Claude Should Assist</strong></summary>

### Primary Responsibilities
1. **Form Development**: Help create new form fields with proper CopilotKit integration
2. **AI Integration**: Implement `useCopilotAction` and `useCopilotReadable` hooks correctly
3. **Type Safety**: Ensure all TypeScript types are properly defined
4. **Validation**: Implement Zod schemas for form validation
5. **UI Components**: Use shadcn/ui components consistently

### Code Generation Rules
- ALWAYS use `"use client"` directive for components using CopilotKit hooks
- ALWAYS define Zod schemas before implementing forms
- ALWAYS use semantic naming for CopilotKit actions (e.g., `fillIncidentForm`, not `action1`)
- NEVER hardcode sensitive data or API keys
- NEVER skip form validation

### Common Tasks
1. **Adding New Form Fields**
   ```tsx
   // 1. Update Zod schema
   const schema = z.object({
     newField: z.string().min(1, "Required"),
     // ... existing fields
   });
   
   // 2. Add to CopilotAction parameters
   parameters: [
     { name: "newField", type: "string", required: true },
     // ... existing parameters
   ]
   
   // 3. Update handler
   handler: async (data) => {
     form.setValue("newField", data.newField);
   }
   ```

2. **Improving AI Context**
   ```tsx
   useCopilotReadable({
     description: "Detailed context description",
     value: {
       formData: form.watch(),
       metadata: { formType: "incident_report" }
     }
   });
   ```

3. **Error Handling**
   ```tsx
   try {
     await submitForm(data);
   } catch (error) {
     toast.error("Failed to submit form");
   }
   ```
</details>

## Environment Variables

```bash
# Required
NEXT_PUBLIC_COPILOT_PUBLIC_API_KEY=    # CopilotKit API key from https://cloud.copilotkit.ai

# Optional (for production)
NEXT_PUBLIC_API_URL=                   # Backend API endpoint
NEXT_PUBLIC_ENVIRONMENT=               # development | staging | production
```

## Architecture Decisions

<details>
<summary><strong>🏗️ Key Design Choices</strong></summary>

### 1. CopilotKit Integration Pattern
- **Provider at Root**: CopilotKit provider wraps entire app in `layout.tsx`
- **State Sharing**: Use `useCopilotReadable` to share form state
- **Action Handling**: Implement `useCopilotAction` for form updates

### 2. Form State Management
- **React Hook Form**: Chosen for performance and integration with Zod
- **Zod Validation**: Type-safe schema validation
- **Controlled Components**: All inputs are controlled for AI updates

### 3. Component Architecture
- **Separation of Concerns**: UI components separate from business logic
- **Composability**: Small, reusable shadcn/ui components
- **Client Components**: Forms use client-side rendering for interactivity

### 4. Styling Strategy
- **Tailwind CSS**: Utility-first for rapid development
- **shadcn/ui**: Consistent, accessible component library
- **CSS Variables**: Theme customization via CSS custom properties
</details>

## Testing Strategy

<details>
<summary><strong>🧪 Testing Guidelines</strong></summary>

### Unit Tests (Vitest)
```tsx
// Test CopilotKit integration
describe('IncidentReportForm', () => {
  it('should update form when AI action is triggered', async () => {
    // Test implementation
  });
});
```

### E2E Tests (Playwright)
```tsx
// Test full form flow
test('complete form with AI assistance', async ({ page }) => {
  await page.goto('/');
  await page.click('[data-testid="copilot-trigger"]');
  await page.fill('[data-testid="copilot-input"]', 'Fill form with test data');
  // Assertions
});
```

### Test Coverage Goals
- Unit: 80% coverage for utilities and hooks
- Integration: Test all CopilotKit actions
- E2E: Cover happy path and error scenarios
</details>

## Performance Optimization

<details>
<summary><strong>⚡ Performance Best Practices</strong></summary>

1. **Code Splitting**: Lazy load heavy components
2. **Image Optimization**: Use Next.js Image component
3. **Bundle Size**: Monitor with `npm run analyze`
4. **Memoization**: Use `useMemo` for expensive computations
5. **Debouncing**: Debounce form updates to AI context
</details>

## Security Considerations

<details>
<summary><strong>🔒 Security Guidelines</strong></summary>

1. **API Keys**: Always use environment variables
2. **Input Validation**: Validate all user inputs with Zod
3. **XSS Prevention**: Use React's built-in escaping
4. **CORS**: Configure appropriate CORS headers
5. **Rate Limiting**: Implement for API endpoints
</details>

## Troubleshooting

<details>
<summary><strong>🔧 Common Issues</strong></summary>

### Issue: CopilotKit not responding
```bash
# Check API key is set
echo $NEXT_PUBLIC_COPILOT_PUBLIC_API_KEY

# Verify CopilotKit provider is wrapped correctly
# Check browser console for errors
```

### Issue: Form validation errors
```tsx
// Enable form debugging
const form = useForm({
  mode: 'onChange', // Show errors immediately
  // ... rest of config
});
```

### Issue: Type errors with CopilotKit
```bash
# Ensure types are installed
npm install --save-dev @types/copilotkit
```
</details>

## Related Files

- `README.md` - Project documentation and setup guide
- `package.json` - Dependencies and scripts
- `components.json` - shadcn/ui configuration
- `.env.local` - Environment variables (create from .env.example)
- `lib/prompt.ts` - AI assistant behavior configuration

## Deployment

<details>
<summary><strong>🚀 Deployment Checklist</strong></summary>

### Vercel Deployment
1. Push to GitHub
2. Connect repository to Vercel
3. Set environment variables in Vercel dashboard
4. Deploy with `vercel --prod`

### Pre-deployment Checklist
- [ ] All tests passing
- [ ] Environment variables configured
- [ ] Build succeeds locally
- [ ] No TypeScript errors
- [ ] API keys secured
- [ ] Error tracking configured
- [ ] Performance benchmarks met
</details>

## Contributing

When contributing to this project:
1. Follow existing code patterns
2. Update this `claude.md` if adding new conventions
3. Ensure all CopilotKit integrations are documented
4. Test AI interactions thoroughly
5. Keep form accessibility in mind

---

**Last Updated**: ${new Date().toISOString()}  
**Maintained By**: AI Development Team  
**Claude Code Version Compatibility**: 0.12.0+