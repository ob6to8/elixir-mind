---
type: todo
title: "Promote the TDD survey bookmarks and intake the agent-written-tests counter-study"
description: Promote the three TDD-with-agents bookmarks already surveyed in the register — Simon Willison's red/green TDD pattern, obra's Superpowers, Jason Swett's TDD agent skill — into filed references via /intake, and intake arXiv 2602.07900 (the agent-generated-tests counter-study the ranking analysis cites from its abstract) as a filed source; operator approved 2026-08-01, expected as its own PR per the atomic-PR policy.
status: open
provenance: "Claude Code session (Claude Fable 5), 2026-08-01"
tags: [meta, todo, intake, survey, tdd, promotion]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T19:20:00Z
  channel: agent-authored
  agent: "Claude Code agent, TDD research-spike session"
  why: "operator approved promoting the surveyed TDD bookmarks as follow-up work in its own PR"
---

# Promote the TDD survey bookmarks and intake the counter-study

Approved by the operator 2026-08-01, deliberately deferred to its own PR per
[atomic pull requests](/meta/policy/git-atomic-pull-requests.md). Four items:

1. **Simon Willison — Red/green TDD** (`/bookmarks promote
   https://simonwillison.net/guides/agentic-engineering-patterns/red-green-tdd/`) —
   quoted at length in [the ranking analysis](/meta/analysis/tdd-rank-for-coding-agent-development.md)
   but still only a surveyed register row; the natural filing neighbor of
   [Gorman](/knowledge/SWE/agentic/code-quality/why-tdd-works-in-ai-assisted-programming.md).
2. **Superpowers** (github.com/obra/superpowers) — the TDD-centric agent
   skills framework, surveyed 2026-07-23.
3. **Jason Swett — My Agent Skill for Test-Driven Development**
   (saturnci.com) — the specify-encode-fulfill variant, surveyed 2026-07-23.
4. **arXiv 2602.07900** ("Rethinking the Value of Agent-Generated Tests for
   LLM-Based Software Engineering Agents") — the counter-study the analysis
   cites from its abstract plus HN-relayed body figures; a full capture would
   let the analysis's caveated numbers be checked against the paper body.

Each promotion runs the full `/intake` distill pass and records
`status: promoted → <link>` on its register row in
[`survey/bookmarks.md`](/survey/bookmarks.md).
