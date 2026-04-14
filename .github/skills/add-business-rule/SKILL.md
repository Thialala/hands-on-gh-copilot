---
name: add-business-rule
description: Use this when implementing or changing an expense policy rule in PolicyFlow using the owning vertical slice.
---

When asked to add or change a business rule in PolicyFlow, work slice first.

## Process

1. Identify the exact rule in plain language.
2. Identify the owning slice or slices.
3. Check whether the rule depends on MCP policy tools.
4. Keep the rule implementation inside the owning slice whenever possible.
5. Update only the minimal Shared code required for true cross-slice concerns.
6. Add or update focused tests that mirror the affected slice.
7. Verify that the UI in the affected slice shows meaningful validation or workflow feedback.
