# PolicyFlow repository instructions

PolicyFlow is a demo application for GitHub Copilot Days.
The goal is not only to build an expense management application, but to demonstrate how GitHub Copilot can work with repository instructions, custom agents, skills, hooks, and MCP.

Copilot should optimize for:
- clarity
- architectural discipline
- small reviewable changes
- predictable demo flow
- maintainable code

## Product scope

Build an internal expense management application.

Core workflow:
- an employee creates an expense
- the employee submits it
- a manager approves or rejects it
- the application keeps a simple decision history

Core categories:
- Transport
- Meal
- Hotel
- Equipment

Core rules:
- receipt may be required depending on policy thresholds
- manager approval may be required depending on policy thresholds
- rejection requires a reason
- policy values should come from the policy provider when available

## General working principles

- Think before acting.
- For non-trivial work, start with a short plan.
- Prefer the best simple design over the fastest patch.
- Fix issues from first principles instead of stacking bandaids.
- Keep the full request in mind and do not lose the plot halfway through.
- Leave the repository better than you found it when the cleanup is small, low-risk, and directly related to the current work.
- If requirements change mid-task, refresh context before continuing or summarizing.

## Assumptions and ambiguity handling

- State important assumptions explicitly before implementing when they affect design, behavior, or business rules.
- If multiple reasonable interpretations exist, surface them instead of choosing one silently.
- Do not hide ambiguity behind implementation.
- If the ambiguity would significantly change architecture, rules, or user-visible behavior, raise it before proceeding.
- If the ambiguity is limited and the current demo flow benefits from continuing, proceed with the safest reasonable interpretation and state it briefly.

## Architecture-first approach

When taking on new work, follow this order:

1. Understand the product requirement
2. Review the repository instructions and current architecture
3. Inspect the existing codebase and patterns
4. If needed, check official documentation or current framework guidance
5. Choose the simplest solution that fits the existing architecture
6. Implement incrementally
7. Add or update tests for business rules

## Simplicity rules

- Prefer the minimum code that correctly solves the problem.
- Do not add flexibility, configurability, or abstractions that were not requested.
- Do not introduce single-use abstractions unless they clearly improve readability.
- If a simpler implementation fits the architecture, prefer it.
- Avoid speculative handling for scenarios that are not relevant to the current design or demo.
- Favor explicit code over clever code.

## Technical stack

- Use the latest version of the .NET SDK
- Use ASP.NET Core
- Prefer Razor Pages for speed of implementation during live demo
- Use Entity Framework Core with SQLite
- Use xUnit for tests
- Use FluentAssertions for test assertions
- Use Bootstrap for a simple clean UI
- Keep dependencies minimal

## Architecture rules

PolicyFlow uses a light Vertical Slice Architecture.

Organize code by business use case, not by technical layer.
A slice should contain the files needed to implement one feature or request end to end.

Examples of slices:
- Expenses/Create
- Expenses/Submit
- Expenses/Details
- Expenses/Approve
- Expenses/Reject
- Expenses/List

Rules:
- Prefer one folder per use case or request
- Keep UI, validation, mapping, and request-specific logic close to the slice that owns them
- Keep shared code to a minimum
- Only place truly cross-slice concerns in Shared
- Do not create broad horizontal folders such as Services, Validators, or Repositories unless they are genuinely shared
- Keep business logic out of Razor Page markup
- Keep business logic out of generic shared helpers unless multiple slices truly need it
- Favor high cohesion within a slice and low coupling between slices
- Use clear names and small files
- Use explicit models and types
- Prefer simple APIs over smart abstractions
- Remove dead code when it becomes unnecessary
- Do not leave breadcrumbs in old code locations such as comments saying code was moved elsewhere

## Vertical slice conventions

Each slice should be easy to understand in isolation.

A slice may contain:
- Razor Page files
- page model
- request or command models
- validator
- mapping helper
- slice-specific view model
- focused tests in the matching test project

Prefer:
- small, self-contained slices
- direct and readable logic
- request-specific code close to the request
- one business change mostly staying inside one slice

Avoid:
- pushing slice logic into generic shared services too early
- introducing abstractions used by only one slice
- scattering one feature across many unrelated folders
- centralizing request-specific validation or mapping without a real cross-slice need

## Shared code rules

Shared code should remain small and intentional.

Good candidates for Shared:
- domain entities
- enums
- AppDbContext
- tiny UI helpers used by multiple slices

Do not move code to Shared just because it feels reusable.
Move code to Shared only when at least two slices genuinely benefit and the shared abstraction stays simple.

## Orchestration and agent cooperation

PolicyFlow uses an entry-point orchestrator agent plus specialist agents.

General expectation:
- the orchestrator handles planning and delegation
- specialist agents should work slice by slice whenever possible
- backend work should stay close to the slice that owns the behavior
- UI work should stay close to the slice that owns the page flow
- test work should mirror the affected slices

When operating as a specialist:
- stay within your slice or clearly identified shared dependency
- avoid unnecessary overlap with other slices
- return concise summaries of what changed, what remains, and any dependencies

When operating as the entry-point agent:
- start with planning for non-trivial requests
- delegate to specialist agents when appropriate
- consolidate the final result into one coherent change set

## Demo-friendly coding rules

- Prefer incremental changes over large rewrites
- Keep the app visually simple and stage-friendly
- Optimize for code that is easy to explain live
- Avoid unrelated refactors during the demo
- Before large changes, explain the plan briefly
- When possible, propose the next best prompt to run
- Prefer a repository shape that makes the feature story obvious on screen

## UI and UX rules

Required pages:
- Expense list
- Create expense
- Expense details
- Manager approval page

### Design philosophy

PolicyFlow should feel like a polished, modern internal tool — not a generic Bootstrap scaffold.
The UI should impress during a live demo and feel intentionally designed, not auto-generated.

Think: refined SaaS dashboard meets editorial clarity — clean but with personality.

### Visual identity

- Use Bootstrap 5 as the structural foundation, but override aggressively with custom CSS
- Use the Spring color theme defined below as the brand identity
- Add a distinctive Google Fonts pairing loaded from CDN:
  - Display / headings: **DM Serif Display** (elegant, editorial)
  - Body / UI: **DM Sans** (clean, geometric, modern)
- Use CSS custom properties for all theme values so changes propagate everywhere
- No generic sans-serif stacks — every text element should use the brand fonts

### Spring color theme (CSS custom properties):

| Token             | Hex       | Usage                                                  |
|--------------------|-----------|--------------------------------------------------------|
| --spring-green     | #488C03   | primary buttons, links, active states                  |
| --spring-olive     | #A6BF49   | secondary buttons, success badges, hover accents       |
| --spring-pale      | #EFF294   | highlights, info alerts, selected rows                 |
| --spring-yellow    | #F2E205   | warnings, attention badges                             |
| --spring-cream     | #F2E8B3   | page background, card backgrounds, soft containers     |

Mapping to Bootstrap overrides:
- `--bs-primary` → `--spring-green` (#488C03)
- `--bs-success` → `--spring-olive` (#A6BF49)
- `--bs-warning` → `--spring-yellow` (#F2E205)
- `--bs-info` background → `--spring-pale` (#EFF294)
- `--bs-body-bg` → `--spring-cream` (#F2E8B3)
- keep `--bs-danger` as Bootstrap default red for rejection states
- use white or dark text as needed for contrast on colored backgrounds

### Layout and spatial design

- Use generous whitespace and breathing room — not cramped Bootstrap defaults
- Cards should have subtle shadows, rounded corners (0.75rem), and hover lift transitions
- Use asymmetric grid layouts where appropriate — not every row needs to be a 12-column grid
- The navbar should feel premium: Spring green background, slightly elevated with shadow, brand logo/text with the display font
- Page transitions and content should feel structured with clear visual hierarchy

### Motion and micro-interactions

- Subtle CSS transitions on all interactive elements (buttons, cards, links): 0.2s ease
- Cards should have a gentle lift effect on hover (translateY + shadow increase)
- Status badges should use soft pill shapes with slight transparency
- Form inputs should have smooth focus transitions with Spring green accent borders
- Page content should use subtle fade-in on load (CSS animation)

### Status visualization

- Draft: muted gray badge with subtle border
- Submitted: Spring green badge, confident and clear
- Approved: Spring olive badge with a subtle checkmark icon
- Rejected: danger red badge with a subtle x icon
- Use Bootstrap Icons (CDN) for status icons and action buttons

### Component patterns

- Expense list: clean table with alternating row highlights using --spring-pale, hover effects, status pills
- Create form: floating labels or clean stacked labels, generous spacing, prominent submit button with hover animation
- Details page: hero card at top with key info, clear action buttons, decision history as a timeline or clean table
- Approve/Reject pages: clear summary card with prominent action area, rejection reason textarea with character count

### Validation and feedback

- Show validation messages in plain English with friendly tone
- Use inline validation styling with smooth transitions
- Success actions should show brief visual feedback before redirect
- Error states should be clear but not alarming

### Accessibility

- Maintain WCAG AA contrast ratios on all text
- All interactive elements must have visible focus states
- Form inputs must have proper labels
- Status information must not rely solely on color — include text or icons

## Dependency rules

- Keep dependencies minimal
- Do not add a new dependency unless it is clearly justified
- Before adding a dependency, prefer well-maintained and widely used options
- If a dependency changes architecture, behavior, or demo complexity, raise it before proceeding

## Git and change-safety rules

- Treat git status and diffs as read-only context unless the user explicitly asks for git write operations
- Never revert changes you did not make
- Do not assume missing changes were yours
- Other agents or the user may have modified the repo during the session
- Refresh context before summarizing or making sensitive edits

## Surgical change rules

- Every changed line should trace back to the current request.
- Do not refactor unrelated code during feature work.
- Do not reformat or restyle unrelated files.
- Match the existing repository style and patterns unless explicitly asked to change direction.
- Remove only the dead code made obsolete by your own changes.
- If you notice unrelated dead code, design smells, or cleanup opportunities, mention them instead of cleaning them up by default.

## Testing rules

- Every business rule must have at least one automated test
- When adding or changing a rule, add or update tests in the same change
- Prefer focused unit tests over broad fragile tests
- Prefer real logic validation over mock-heavy tests
- Keep tests deterministic and fast
- Unless explicitly requested otherwise, run only the tests related to the changes instead of the full suite
- Mirror the feature slices in the test project whenever practical

Key cases to cover include:
- receipt not required below threshold
- receipt required above threshold
- approval not required below threshold
- approval required above threshold
- rejection requires a reason
- valid status transitions
- decision history is recorded correctly when applicable

## Verification and success criteria

Before implementing non-trivial work:
- define a short success target
- define how the result will be verified

Examples:
- "Add validation" means the relevant validation rules exist, tests cover valid and invalid cases, and the UI shows clear messages
- "Fix a bug" means reproduce the issue, implement the fix, and verify the failure no longer occurs
- "Refactor" means behavior stays unchanged and relevant tests still pass

When a running app is available, use Playwright MCP to validate features in the browser as a final verification step.

For multi-step work, prefer:
1. step
2. verification
3. next step

## Command and workflow rules

- Prefer existing project scripts and conventions over inventing new ones
- If there is a documented task runner or existing workflow, use it
- If a command runs unusually long or blocks the flow of the demo, stop it, capture the context, and explain the situation
- Avoid destructive operations
- Keep terminal usage focused and easy to explain

## Scope control rules

You may fix nearby small papercuts when they are:
- low risk
- directly related to the current task
- helpful for the current implementation or demo

Examples:
- a tiny typo
- a misleading validation message
- a small non-idempotent setup issue
- a trivial dead parameter or unused helper

Stop and raise it before continuing if the better fix:
- becomes a broad refactor
- changes architecture significantly
- changes user-visible behavior beyond the request
- touches multiple subsystems unnecessarily
- requires substantial new testing
- adds meaningful demo risk

## Final handoff expectations

Before finishing a task:
- confirm what was changed
- mention which tests were run
- mention any small cleanup performed beyond the main request
- call out remaining TODOs, limitations, or follow-up ideas
- suggest a sensible next prompt when useful
