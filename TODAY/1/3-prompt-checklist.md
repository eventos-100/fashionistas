Here’s a single prompt you can paste straight into Claude to get a detailed, production-ready checklist with commands, steps, success criteria, testing, deployment readiness, and suggested fixes:
for creating a refine man

https://github.com/mantinedev/next-app-template

- https://refine.dev/docs/ui-integrations/mantine/introduction/- 
- https://refine.dev/docs/data/packages/supabase/
- https://supabase.com/docs/guides/getting-started/quickstarts/refine
- https://refine.dev/docs/examples/data-provider/supabase/
- https://www.npmjs.com/package/@refinedev/supabase
- https://refine.dev/templates/supabase-crud-app/
- https://supabase.com/docs/guides/getting-started
- https://refine.dev/docs/ui-integrations/mantine/introduction/
- https://refine.dev/blog/mantine-ui-react/
- https://www.npmjs.com/package/@refinedev/mantine
- https://refine.dev/
- https://mantine.dev/guides/next/
- https://github.com/mantinedev/next-app-template
- https://ui.mantine.dev/



You are an expert software project planner and DevOps engineer.  
Given the list of project tasks below, generate a complete, hierarchical **checklist**. For **each** task, include:

1. **Description**: One-sentence summary of what the task accomplishes.  
feaure use cases real world examples best practices 
2. **Steps**: Numbered, ordered actions to complete the task.  
3. **Commands**: Exact shell/CLI or script snippets.  
4. **Success Criteria**: How to verify the task is done (pass/fail conditions).  
5. **Testing**: Unit, integration, end-to-end tests to run, with exact commands.  
6. **Deployment**: Steps and commands to deploy that task’s changes.  
7. **Production Readiness**: A checklist of checks (security, performance, observability) confirming it’s safe for prod.  
8. **Improvements & Fixes**: Any suggested changes, optimizations, or common pitfalls to address.

**Input**:  
```

TASKS:

* Initialize project repository
* Install and pin dependencies
* Configure CI/CD pipeline
* Implement Feature X
* Run automated test suite
* Deploy to staging
* Perform load/performance tests
* Deploy to production

```

**Output Format**:  
Return a top-level JSON (or Markdown) object/array where each task is an entry with fields:
```

{
"task": "...",
"description": "...",
"steps": \[ "...", "..." ],
"commands": \[ "...", "..." ],
"successCriteria": \[ "...", "..." ],
"testing": \[ { "type": "unit", "command": "..." }, ... ],
"deployment": \[ "...", "..." ],
"productionReadiness": \[ "...", "..." ],
"improvements": \[ "...", "..." ]
}

```

Proceed task by task in the order given. Do not move on until each section is fully populated.  
```

