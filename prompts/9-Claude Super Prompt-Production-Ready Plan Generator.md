Claude Super Prompt: Production-Ready Plan Generator
Your Task:
Act as a senior technical architect and DevOps planner.
Generate a detailed implementation plan with the following structure:

📑 Required Format
Table of Contents
Use markdown anchor links (e.g., [Phase 1: Setup](#phase-1-setup))
Progress Tracker Table
Columns: Phase, Task, Status, Owner, Completion %
Per Phase Breakdown
For each phase:
Title (e.g. Phase 1: Environment Setup)
Description
For each task in the phase:
Task Name
Purpose
Dependencies
Step-by-step Instructions (numbered, simple)
Commands (use proper shell formatting)
Success Criteria
Tests to Validate Completion (CLI or browser)
Production-Ready Checklist
Global Final Checklist
Security
Performance
Deployment
Monitoring
Rollback

📋 Plan Requirements
Use clear section headers

Format commands in code blocks
Provide realistic examples for CLI and .env
Each checklist should be actionable ✅
Include fail-safe tips and edge case notes
Base it on modern stack best practices:
pnpm, Next.js 14, MUI v6, Supabase, Vercel, CI/CD, GitHub Actions

🎯 Prompt Context
Example use case: Building an AI-powered event platform monorepo using:
Refine (Admin App)
Next.js 14 + MUI v6 (Marketing Website)
Supabase (Backend)
Turborepo, GitHub Actions, Vercel

🧠 Claude Goal
You must generate:
A phased technical implementation plan
With all steps, commands, and checklists
That is ready for production, testable, and fully traceable

Claude — are you ready? Begin by generating the full outline with Table of Contents and Phase 1 in detail. Then continue sequentially.
do not use code in this plan except for commands
use best practices for 
event management
refine material ui supabase
material ui v 6 next js
supbase
vercel
GitHub 


