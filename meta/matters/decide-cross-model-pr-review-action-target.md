---
type: matter
title: "Decide the cross-model PR review Action's target repo and default reviewer model"
description: The cross-model PR review GitHub Action is designed and documented but not installed anywhere, blocked on two operator decisions — which dev repo receives cross-model-review.yml, and which model reviews by default.
status: open
provenance: "Claude Code session (2026-07-21) — the Shape C artifact from the multi-model dev-environment work"
tags: [meta, matter, ci, github-actions, multi-model, code-review]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, ledger-strand reconciliation sweep"
  why: "promoted from an untracked routing-ledger strand; the artifact is built and waiting on two decisions only the operator can make"
  from: [/meta/threads/2026-07-21-multi-model-dev-environment-and-cross-model-pr-review.md, /meta/threads/2026-07-28-routing-ledger-orphan-sweep-and-record-queue-split.md]
---

# Decide the cross-model PR review Action's target and reviewer

[The cross-model PR review Action](/knowledge/SWE/agentic/multi-model/cross-model-pr-review-github-action.md)
is designed and written up. It is installed nowhere, because two questions were
raised and never answered:

1. **Which repository gets `cross-model-review.yml`?** This one, a dev repo, or
   both. Installing it here would make the brain its own first subject, which is
   the usual dogfooding argument — and also means every governance PR draws a
   model review it may not need.
2. **Which model reviews by default?** The value of a cross-model pass is that the
   reviewer is *not* the author, so the default should name a model from a
   different family than the one that typically authors here.

**Related, not blocking.** The
[gate-suite hardening plan](/meta/plans/gate-suite-hardening-review-depth.md)
covers second-model review as one of its proposals. If that plan is ratified with
a CI-hosted review design, this Action may be its implementation rather than a
separate install — check before answering question 1.

**Done when.** Both questions are answered and the Action is either installed or
explicitly retired in favour of the hardening plan's design.
