---
type: matter
title: "TDD bookmark promotions"
description: Promote the three surveyed TDD-with-agents bookmarks — Willison's red/green pattern, obra's Superpowers, Swett's TDD agent skill — into filed references and intake arXiv 2602.07900, the counter-study, carrying the operator-directed weighing below.
status: open
provenance: "Claude Fable 5, matter-register consumption session (matter-docs build 2)"
tags: [meta, matter, bookmarks, tdd]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T08:32:00Z
  channel: agent-authored
  agent: "Claude Code agent, matter-register consumption session (matter-docs build 2)"
  why: "migrated from the matters register's row packet when the register thinned to the order-only pointer view"
  from: [/meta/matters.md, /meta/threads/2026-08-02-stand-up-meta-matters-and-thin-the-register.md, /meta/threads/2026-08-02-todo-fold-into-matters.md]
---

# TDD bookmark promotions

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
   **The intake carries this weighing** (operator-directed): the paper's
   subjects are agents *improvising* tests mid-solve on SWE-bench — mostly
   print-statement observation probes, weakly correlated with resolution,
   unmoved by prompt interventions ("Current agent-written testing practices
   reshape process and cost more than final task outcomes", abstract) — so it
   cuts against *unreviewed improvised test-writing motion*, not against
   tests-as-ratified-contract (human-reviewed assertions, red-confirmed,
   protected from edits), which is precisely what its subjects lacked. It
   sharpens the ranking's contract-discipline conditional rather than
   reversing the verdict. HN-relayed body figures to check against the paper:
   +19.8% output tokens for no gain; regressions 6.08%→9.94% under imposed
   TDD prompting.

Each promotion runs the full `/intake` distill pass and records
`status: promoted → <link>` on its register row in
[`survey/bookmarks.md`](/survey/bookmarks.md).
