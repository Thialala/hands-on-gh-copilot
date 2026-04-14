# PolicyFlow

PolicyFlow is a demo application built for **GitHub Copilot Days**.

Its purpose is not only to build a small internal **expense management application**, but also to demonstrate how to use **GitHub Copilot customization** in a realistic engineering workflow:

- Repository Instructions
- Custom Agents
- Skills
- Hooks
- MCP

PolicyFlow is intentionally designed to stay simple on the product side and strong on the architecture and developer experience side.

---

## Demo goal

PolicyFlow shows how to teach GitHub Copilot **how a team builds software**, not just how to generate code.

This repository demonstrates:

- a **light Vertical Slice Architecture**
- **slice-oriented agent delegation**
- **focused automated tests aligned with slices**
- **guardrails through hooks**
- **MCP for browser validation with Playwright**
- a repository structure that is easy to explain live

---

## Business scope

PolicyFlow is an internal expense management application.

Core workflow:

1. An employee creates an expense
2. The employee submits the expense
3. A manager approves or rejects it
4. The application records a simple decision history

Core categories:

- Transport
- Meal
- Hotel
- Equipment

Core business rules:

- a receipt may be required depending on policy thresholds
- manager approval may be required depending on policy thresholds
- rejection requires a reason

---

## Architecture

PolicyFlow uses a **light Vertical Slice Architecture**.

The repository is organized by **business use case**, not by horizontal technical layers.

### High-level architecture diagram

```text
┌─────────────────────────────────────────────────────────────┐
│                         PolicyFlow                          │
│                  ASP.NET Core Razor Pages                   │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    Features / Vertical Slices               │
│                                                             │
│  Expenses/List      Expenses/Create      Expenses/Details   │
│  Expenses/Submit    Expenses/Approve     Expenses/Reject    │
│                                                             │
│  Each slice contains only the code needed for that use case │
└─────────────────────────────────────────────────────────────┘
                              │
                ┌─────────────┤
                │             │
                ▼             ▼
┌────────────────────┐ ┌────────────────┐
│ Shared/Domain      │ │ Shared/Data    │
│ Expense            │ │ AppDbContext   │
│ ExpenseStatus      │ │ EF Core        │
│ ExpenseDecision    │ └────────────────┘
└────────────────────┘
```

---

## Repository structure

```text
src/
  PolicyFlow.Web/
    Features/
      Expenses/
        List/
        Create/
        Submit/
        Details/
        Approve/
        Reject/
      Shared/
        Data/
        Domain/
        UI/
    Program.cs

  PolicyFlow.Tests/
    Features/
      Expenses/
        Create/
        Submit/
        Approve/
        Reject/
        Details/

.github/
  copilot-instructions.md
  agents/
  skills/
  hooks/

.vscode/
  mcp.json
```

---

## Suggested local flow

1. Open this repository in VS Code
2. Make sure `.vscode/mcp.json` is configured (Playwright MCP for browser validation)
3. Use GitHub Copilot in Agent mode
4. Work slice by slice

---

## Key message

PolicyFlow is not a CRUD demo.

It is a **Copilot customization demo** built around a realistic internal application:

- Instructions define the house rules
- The orchestrator plans and delegates
- Implementation happens slice by slice
- Skills package repeatable workflows
- Hooks add guardrails
- MCP enables browser validation with Playwright

---

## Resources

Curated links to learn more about GitHub Copilot customization and the broader AI-assisted development ecosystem.

### Copilot customization

| Resource | Description |
|----------|-------------|
| [Awesome GitHub Copilot](https://awesome-copilot.github.com/) | Community-contributed agents, instructions, skills, hooks, workflows, plugins, and tools for GitHub Copilot |
| [Awesome Coding Assistants](https://marketplace.visualstudio.com/items?itemName=jlacube.awesome-coding-assistants) | VS Code extension by Jérôme Lacube to browse, install, and manage AI coding assistant customizations across multiple tools |
| [APM — Agent Package Manager](https://microsoft.github.io/apm/reference/cli-commands/) | Microsoft CLI for managing AI agent primitives (instructions, agents, skills, prompts, hooks) across coding tools |

### Agent skills ecosystem

| Resource | Description |
|----------|-------------|
| [Anthropic Skills](https://github.com/anthropics/skills) | Official repository of Agent Skills for Claude — reusable folders of instructions, scripts, and resources |
| [Skills.sh](https://skills.sh/) | Open agent skills ecosystem by Vercel — leaderboard and registry to discover and install skills for 20+ AI agents |

### Agentic workflows

| Resource | Description |
|----------|-------------|
| [GitHub Agentic Workflows (gh-aw)](https://github.github.com/gh-aw/) | Repository automation running coding agents (Copilot, Claude, Codex) in GitHub Actions with sandboxed execution and guardrails |

### Learning

| Resource | Description |
|----------|-------------|
| [GitHub Copilot CLI for Beginners](https://github.com/github/copilot-cli-for-beginners) | Hands-on course by Dan Wahlin — from zero to productive with GitHub Copilot in the terminal |
| [Burke Holland — YouTube](https://www.youtube.com/user/burkeholland) | Developer content covering VS Code, GitHub Copilot, and modern web development |
| [GitHub Copilot Dev Days](https://copilot-dev-days.github.io/) | Hands-on workshops to master GitHub Copilot across every IDE, language, and workflow
