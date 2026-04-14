---
name: generate-tests
description: Use this when adding or improving tests for PolicyFlow business logic, mirroring the affected vertical slices.
---

When asked to generate tests for PolicyFlow, think slice by slice.

## Process

1. Identify the affected slice or slices.
2. Identify the business rule, workflow, or status transition being tested.
3. Prefer focused unit tests over broad UI tests.
4. Mirror the affected slice structure in the test project whenever practical.
5. Cover:
   - expected valid behavior
   - expected invalid behavior
   - boundary conditions
