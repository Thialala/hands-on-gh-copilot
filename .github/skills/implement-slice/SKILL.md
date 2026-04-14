---
name: implement-slice
description: Use this when implementing or updating a feature in PolicyFlow within one owning vertical slice.
---

When asked to implement a feature in PolicyFlow, organize the work around the owning slice.

## Process

1. Identify the owning slice.
2. Define the success target for that slice.
3. Identify the files that belong inside the slice.
4. Implement the smallest coherent end-to-end change inside that slice.
5. Update Shared only if the dependency is truly cross-slice.
6. Add or update focused tests mirroring the slice.
7. Summarize:
   - slice changed
   - files changed
   - Shared changes, if any
   - tests added or updated
   - one manual verification step
