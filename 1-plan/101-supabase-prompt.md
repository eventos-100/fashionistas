:

---

### 🕵️‍♂️ SUPER PROMPT FOR CLAUDE — **SUPABASE DETECTIVE MODE**

> Act as an expert **Supabase Architect + Detective** with deep knowledge of PostgreSQL, Supabase best practices, and advanced AI-enhanced workflows.

Your mission:

1. **Carefully audit the complete Supabase schema** for **Fashionistas**, a fashion event platform.
    
2. Perform a **deep analysis** using **logical reasoning**, **official documentation**, and intelligent error detection.
    

---

### 🔍 CHECKLIST OF WHAT TO DO

1. **Schema Validation**
    
    - Are all **table structures**, **types**, **enums**, and **constraints** logically valid?
        
    - Are **naming conventions** consistent and correct?
        
    - Are **relationships and foreign keys** accurate and normalized?
        
2. **RLS & Security Review**
    
    - Are **Row-Level Security (RLS)** policies correct, secure, and complete?
        
    - Are there **any missing RLS rules** for expected CRUD actions?
        
3. **Trigger/Function Logic**
    
    - Review **all trigger functions** like `update_updated_at`, `calculate_designer_commission`, `update_ticket_sold_count`, etc.
        
    - Check for **logical correctness**, **side effects**, and **race condition prevention**.
        
4. **Edge Functions Review**
    
    - Are **supabase/functions/** following secure, correct flow?
        
    - Validate `send-event-invitation`, `generate-event-brief`, and `stripe-webhook`.
        
5. **Testing Strategy**
    
    - Propose a **5-step testing strategy**:
        
        - ① CRUD integrity tests
            
        - ② RLS bypass prevention
            
        - ③ Trigger side-effect verification
            
        - ④ Function correctness (inputs/outputs)
            
        - ⑤ Migration consistency
            
6. **Red Flags / Error Detection**
    
    - Identify any potential **missing constraints**, **typos**, **redundant logic**, or **performance bottlenecks**.
        
    - Suggest **indexing or normalization improvements**.
        
7. **Improvements & Missing Elements**
    
    - Are any **important best practices or features missing**? (e.g. foreign key cascade rules, updated_at consistency)
        
    - Could any logic be **optimized or simplified**?
        

---

use best practices for refine and supbase 

> Always reference **official Supabase + PostgreSQL docs**, suggest **error prevention techniques**, and structure your findings with:

- ✅ Correct
    
- ⚠️ Needs Fix
    
- 💡 Improvement
    
- ❌ Error / Risk
    

---

### 📎 Input

```sql
<insert the entire schema, policies, functions, triggers, edge functions, and enums>
```

---
Shared with Supatabs:


- https://supabase.com/docs/guides/getting-started/quickstarts/refine
- https://refine.dev/docs/data/packages/supabase/
- https://refine.dev/docs/examples/data-provider/supabase/
- https://www.npmjs.com/package/@refinedev/supabase
- https://refine.dev/docs/ui-integrations/mantine/introduction/
- https://www.npmjs.com/package/@refinedev/mantine
- https://refine.dev/blog/mantine-ui-react/
- https://refine.dev/docs/ui-integrations/mantine/components/themed-layout/
-