---
id: em:c71155
type: reference
title: "GrapeRoot — pre-loaded, usage-weighted code context for coding assistants"
description: Python context engine that builds a semantic code graph and pre-packs graph-ranked code into the prompt before the model sees it — the push pole of the retrieval-posture axis — with vendor-run cost/turn claims, an Apache launcher over a proprietary graph engine, and session memory kept in gitignored JSON outside version control.
resource: https://github.com/kunal12203/graperoot
provenance: "Distilled by Claude Fable 5 from the repository README and GitHub page (fetched 2026-08-01)"
tags: [code-context, context-engineering, pre-loading, semantic-graph, token-economics, session-memory, mcp, proprietary-core]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T22:35:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator pointed /intake at the repo asking whether it changes the memory-spike strategy analysis"
---

# GrapeRoot

Tagline, verbatim: **"Compounding Context for AI Coding Assistants."** A
Python engine (PyPI `graperoot`, 3.10.1 per libraries.io; ~969 stars and 118
forks on the 2026-08-01 GitHub page fetch; graperoot.dev, with a Pro tier
whose pricing the README does not state) that builds a semantic graph of a
codebase — files, symbols, imports, call chains across twelve languages —
and **pre-loads** graph-ranked code into the prompt before the model sees
it. Retrieval is usage-weighted and session-cumulative: "Files you've read,
edited, or queried are weighted higher in future turns" (README, per fetch),
under a configurable token budget. Integrates as CLI launchers for Claude
Code/Codex plus MCP; "All processing is **local**. No code leaves your
machine."

## The posture: push, not pull

GrapeRoot is the productized opposite of the agentic-search bet: where
Claude Code deliberately dropped RAG for just-in-time grep-and-read (the
Cherny position in the
[landscape](/knowledge/SWE/agentic/agent-memory/memory-systems-landscape.md)),
GrapeRoot spends a deterministic graph pass up front so "your AI spends
tokens reasoning, not exploring" (site framing). Its objective function is
**token economics** — turns and cost — rather than recall quality: the
README's benchmark table reports, verbatim, "Cost per prompt | $0.49 |
**$0.27**", "Avg turns per task | 11.7 | **3.5**", "Quality (scored) |
76.6 / 100 | **86.6 / 100**", and "Cost win rate | — | **10 out of 10
prompts**", introduced as "Benchmarked across multiple real-world codebases
(7,700+ files) and 50+ engineering prompts:". The README names no model
under test; methodology lives on the vendor's own site
(graperoot.dev/benchmarks). Vendor-run, small-n, self-scored quality —
plausibility signals, not evidence.

## Storage and the license split

The graph lives in `.dual-graph/` as three JSON files — the semantic graph,
a session-memory graph, and `context-store.json` ("Persistent
decisions/tasks/facts across sessions") — and the directory is "auto-added
to `.gitignore`". Its cross-session memory is therefore **outside version
control**: unversioned, unreviewable, provenance-free — the exact polarity
the 2026 field convergence moved away from when Letta rebuilt memory on
git-versioned files. Licensing splits the same way, verbatim: "Launcher
scripts and tooling in this repository: Apache License 2.0 / The
`graperoot` graph engine (PyPI): proprietary." — an "open-source context
engine" label over a closed core.

## Where it sits

Fourth entrant in this directory's genre — deterministic code graph serving
agent context — beside [GitNexus](/knowledge/SWE/agentic/code-context/gitnexus.md),
[Codebase-Memory](/knowledge/SWE/agentic/code-context/codebase-memory-mcp.md),
and [mex](/knowledge/SWE/agentic/code-context/mex.md). Against mex the
contrast is clean: both route context proactively, but mex keeps the
knowledge layer as version-controlled, human-editable markdown with drift
detection, where GrapeRoot keeps graph and memory as gitignored JSON under
a proprietary engine. Reception: no Hacker News or Reddit threads were
located in the single web search run for this intake (results were the
vendor's own surfaces, PyPI mirrors, and site testimonials).

# Citations

- README, github.com/kunal12203/graperoot (fetched 2026-08-01; benchmark
  rows, license split, and storage lines re-confirmed verbatim against the
  raw file) — all quoted spans above.
- GitHub page fetch 2026-08-01 (stars/forks/tree); libraries.io PyPI record;
  graperoot.dev.
