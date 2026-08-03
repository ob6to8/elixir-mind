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

## Maturity and reception

~1.2k stars and 80 forks on the 2026-08-01 GitHub page fetch; GitHub
description: "Persistent project memory for AI coding agents. Structured
scaffold + drift detection CLI." The business model is the free CLI plus a
paid team dashboard in early access, pitched as "Shared, validated memory
for AI coding agents" ([mexmemory.com](https://mexmemory.com/)) — with no
customer logos, case studies, or founder/team names on the site, and none
surfaced by the landscape sweep's searches; no Hacker News thread was found
in that sweep's queries either. Its lane acquired a big-vendor competitor
in July 2026: LangChain's OpenWiki ("OpenWiki is a CLI that writes and
maintains agent documentation for your codebase" —
[github.com/langchain-ai/openwiki](https://github.com/langchain-ai/openwiki)).

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

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:a0fbd5">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-01-memory-system-research-spike (2026-08-01)

3 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:a0fbd5`]**  (co-feeds: `em:fe3522 em:dd64c2 em:6733b4`)

https://github.com/mex-memory/mex
https://github.com/qualixar/superlocalmemory
then

* do a research spike into alternatives, the landscape, learnings, what is hype what is proven etc
* do an analysis of this repo with respects to this strategy - what could be gained, and what might be tradeoffs, if there are any
* consider porting these concepts to an elixir native solution (if one does not already exist)
* if that idea is advised, viable, and its a gap in the market, create a plan

---

**[`em:a0fbd5`]**  (co-feeds: `em:fe3522`)

**Done so far** — both repos are fetched and filed as `reference` docs (verbatim spans re-confirmed against the raw READMEs before quoting):

- `knowledge/SWE/agentic/code-context/mex.md` — mex turns out to be a Tree-sitter+SQLite code graph fused to a version-controlled markdown wiki with drift detection; filed beside GitNexus and Codebase-Memory, which share its genre. Its philosophy ("Markdown is the durable interface.") is this bundle's own bet applied to codebase knowledge.
- `knowledge/SWE/agentic/agent-memory/superlocalmemory.md` — a solo-authored, AGPL, maximalist local-first memory engine (five retrieval channels, self-reported LoCoMo scores, "sheaf cohomology" branding). Filed with vendor claims quoted verbatim and marked as vendor-run; its own README scopes the headline 87.7% to a single conversation.

---

**[`em:a0fbd5`]**  (co-feeds: `em:fe3522`)

- **The seeds.** [mex](https://github.com/ob6to8/elixir-mind/blob/claude/memory-system-research-jan4n8/knowledge/SWE/agentic/code-context/mex.md) is substance-leaning (curated markdown + deterministic code graph + drift detection, on-trend with the field's convergence) filed beside GitNexus in `code-context/`; its maker is unnamed on its own site and no HN thread was found in the sweep's queries. [SuperLocalMemory](https://github.com/ob6to8/elixir-mind/blob/claude/memory-system-research-jan4n8/knowledge/SWE/agentic/agent-memory/superlocalmemory.md) is the maximalist counter-example — five retrieval channels, "sheaf cohomology" branding, self-authored preprints, a 1-point Show HN — filed with every claim quoted verbatim and marked vendor-run.
