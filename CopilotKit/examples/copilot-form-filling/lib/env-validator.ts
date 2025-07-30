import { z } from 'zod';

const envSchema = z.object({
  NEXT_PUBLIC_COPILOT_PUBLIC_API_KEY: z
    .string()
    .min(20, 'CopilotKit API key must be at least 20 characters')
    .startsWith('ck_pub_', 'CopilotKit API key must start with ck_pub_'),
  NODE_ENV: z.enum(['development', 'production', 'test']).optional().default('development'),
});

export type EnvConfig = z.infer<typeof envSchema>;

export function validateEnv(): { success: boolean; error?: z.ZodError; data?: EnvConfig } {
  try {
    const data = envSchema.parse(process.env);
    return { success: true, data };
  } catch (error) {
    if (error instanceof z.ZodError) {
      console.error('❌ Invalid environment configuration:');
      error.errors.forEach(err => {
        console.error(`  - ${err.path.join('.')}: ${err.message}`);
      });
      return { success: false, error };
    }
    throw error;
  }
}

// Validate on module load in development
if (process.env.NODE_ENV === 'development') {
  const result = validateEnv();
  if (!result.success) {
    console.warn('⚠️  Environment validation failed. Please check your .env.local file.');
  }
}