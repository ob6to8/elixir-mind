---
id: em:a0fbd5
type: reference
title: "mex — a living wiki for your codebase, maintained by coding agents"
description: Fuses a deterministic Tree-sitter+SQLite code graph with a version-controlled markdown wiki — task-aware context routing under token budgets, drift detection between docs and code, and symbol grounding that pins wiki claims to exact code nodes.
resource: https://github.com/mex-memory/mex
provenance: "Distilled by Claude Fable 5 from the repository README (fetched 2026-08-01)"
tags: [code-context, codebase-wiki, agent-memory, tree-sitter, sqlite, drift-detection, context-routing, mcp, markdown]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T21:20:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator pointed /intake at the repo as one of two seeds for a memory-system research spike"
---

# mex — a living wiki for your codebase

Tagline, verbatim: **"A living wiki for your codebase, maintained by your AI
coding agents."** An npm CLI (`mex-agent`, requiring "Node.js >=22.5", MIT
license) that pairs two artifacts most tools keep separate: a **deterministic
code graph** (Tree-sitter parses across "TypeScript, TSX, JavaScript, JSX,
Python, and Rust", indexed into SQLite) and a **structured markdown wiki**
(architecture, decisions, conventions, patterns — version-controlled and
human-editable). The graph is derived and rebuildable; the markdown is the
canonical layer: "Markdown is the durable interface." — "Humans and agents can
both read and edit it."

## The mechanisms

- **Task-aware context routing.** Instead of dumping repository context, a
  router selects the wiki pages and code regions relevant to the task at hand,
  producing scored symbol neighborhoods under a token budget.
- **Drift detection.** `mex check` and `mex sync` identify wiki knowledge
  affected by code changes — the code graph gives the diff a structural anchor,
  so staleness is detected rather than discovered.
- **Symbol grounding.** Wiki claims link to exact code nodes with fingerprints,
  making a documentation statement navigable to (and checkable against) the
  code it describes.
- **Integration surface.** Tool-specific anchor files (Claude Code, Cursor,
  Windsurf, Copilot), an MCP server, decision/event logs, and an agent memory
  mode for persistent operational agents.

## Vendor-reported results

The README's evaluation, run on the mex repository itself: graph-scoped
retrieval was "916.38×" smaller than the full corpus ("Full repository corpus ÷
graph scope"), with minimal-context tasks at "5/5" completed and "0/5"
requiring fallback Read/Grep. Self-measured on the vendor's own repo over five
tasks — a plausibility signal, not an independent benchmark.

## Where it sits

Same genre as [GitNexus](/knowledge/SWE/agentic/code-context/gitnexus.md) and
[Codebase-Memory](/knowledge/SWE/agentic/code-context/codebase-memory-mcp.md) —
precompute a Tree-sitter code graph, serve it to agents — with two additions:
the curated wiki layer above the graph, and drift detection wiring the two
together. The philosophy (markdown canonical, database derived, context routed
not dumped) is the same bet as
[when markdown files are all you need](/knowledge/SWE/agentic/context-engineering/ai-agent-memory-management-markdown-files.md)
and the architecture this bundle itself runs on — mex applies it to *codebase*
knowledge specifically, where this bundle applies it to a general knowledge
corpus with governance gates instead of graph-anchored drift checks. Its
position in the wider memory-tool field is mapped in the
[memory-systems landscape](/knowledge/SWE/agentic/agent-memory/memory-systems-landscape.md).

# Citations

- README, github.com/mex-memory/mex (fetched 2026-08-01) — all quoted spans
  above.
