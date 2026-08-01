---
id: em:988147
type: reference
title: "Streamlining my user-level CLAUDE.md (Chris Dzombak, 2025-12)"
description: Dzombak cuts his global agent guide down to principles the product doesn't already embody — philosophy, architecture defaults, error-handling, tooling deference, and a short NEVER/ALWAYS list — on the observation that elaborate process instructions now conflict with Claude Code's built-in planning and decision-making.
resource: https://www.dzombak.com/blog/2025/12/streamlining-my-user-level-claude-md/
provenance: "Distilled from Chris Dzombak's blog post, 2025-12-02; the final CLAUDE.md text captured verbatim"
tags: [agentic, claude-code, context-engineering, claude-md, agent-guidance, instructions]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T17:56:08Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "related update to the 2025-08 practices post — feeds the global vs repo-specific guidance design"
---

# Streamlining my user-level CLAUDE.md (2025-12)

The December 2025 revision of the global agent guide from
[Getting good results from Claude Code](/knowledge/SWE/agentic/code-quality/getting-good-results-from-claude-code.md).
Dzombak trims the guide to what the product does not already do, based on
*"informal observations about what Claude does and doesn't do well"*, a
desire to *"avoid conflicting with principles that seem to be built into
Claude Code these days, e.g. planning mode"*, and alignment with Claude Code
on the web. The result *"mainly contains guidelines that Claude should abide
by while using its own planning and decision-making tools."*

## What survives at the global level

Principles, not process: core beliefs (incremental progress, learn from
existing code, pragmatic over dogmatic, clear intent over clever code),
simplicity rules, architecture defaults (composition over inheritance,
explicit over implicit, *"Test-driven when possible - Never disable tests,
fix them"*), error-handling expectations (fail fast, never swallow
exceptions), deference to project tooling, and a short NEVER/ALWAYS list
(no `--no-verify`, no disabled tests, no non-compiling commits; commit
incrementally, update plan docs, stop after 3 failed attempts). Project
specifics — linters, formatters, test frameworks — are left to repo-level
files.

## The final file, verbatim

```markdown
# Development Guidelines

## Philosophy

### Core Beliefs

- **Incremental progress over big bangs** - Small changes that compile and pass tests
- **Learning from existing code** - Study and plan before implementing
- **Pragmatic over dogmatic** - Adapt to project reality
- **Clear intent over clever code** - Be boring and obvious

### Simplicity

- **Single responsibility** per function/class
- **Avoid premature abstractions**
- **No clever tricks** - choose the boring solution
- If you need to explain it, it's too complex

## Technical Standards

### Architecture Principles

- **Composition over inheritance** - Use dependency injection
- **Interfaces over singletons** - Enable testing and flexibility
- **Explicit over implicit** - Clear data flow and dependencies
- **Test-driven when possible** - Never disable tests, fix them

### Error Handling

- **Fail fast** with descriptive messages
- **Include context** for debugging
- **Handle errors** at appropriate level
- **Never** silently swallow exceptions

## Project Integration

### Learn the Codebase

- Find similar features/components
- Identify common patterns and conventions
- Use same libraries/utilities when possible
- Follow existing test patterns

### Tooling

- Use project's existing build system
- Use project's existing test framework
- Use project's formatter/linter settings
- Don't introduce new tools without strong justification

### Code Style

- Follow existing conventions in the project
- Refer to linter configurations and .editorconfig, if present
- Text files should always end with an empty line

## MCP Tool Use

- Use Context7 to validate current documentation about software libraries
- Use searxng if your primary Web Search or Fetch tools fail
- Use Tavily ONLY when searxng doesn't give you enough information

## Important Reminders

**NEVER**:
- Use `--no-verify` to bypass commit hooks
- Disable tests instead of fixing them
- Commit code that doesn't compile
- Make assumptions - verify with existing code

**ALWAYS**:
- Commit working code incrementally
- Update plan documentation as you go
- Learn from existing implementations
- Stop after 3 failed attempts and reassess
```

## Current-state notes (2026-08)

Two facts from current Claude Code documentation frame how far this file's
pattern reaches:

- **Size guidance now matches the streamlining instinct**: official docs cap
  CLAUDE.md files at ~200 lines, with the cut test "Would removing this cause
  Claude to make mistakes? If not, cut it."
- **User-level memory does not travel to cloud sessions**: `~/.claude/CLAUDE.md`
  loads on the local machine only; in Claude Code on the web / remote cloud
  environments, only managed policy and the repo's own files apply. A global
  guide that must bind cloud sessions has to reach the repo (its `CLAUDE.md`
  or `.claude/rules/`) by some distribution mechanism, or live in managed
  policy.

Related: [markdown files as agent memory](/knowledge/SWE/agentic/context-engineering/ai-agent-memory-management-markdown-files.md);
the [Manus context-engineering lessons](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md)
reach the same keep-it-lean conclusion from the KV-cache side.

# Citations

Chris Dzombak, "Streamlining my user-level CLAUDE.md", 2025-12-02 —
<https://www.dzombak.com/blog/2025/12/streamlining-my-user-level-claude-md/>

Claude Code memory documentation (size guidance, memory hierarchy, cloud-session
scope), fetched 2026-08-01 — <https://code.claude.com/docs>
