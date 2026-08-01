---
type: doctrine
title: "Verified increments: agent work lands test-first and review-sized"
description: The standing direction that agent-produced change arrives in increments a protected test contract has verified and a human can actually review — tests written first and guarded from the agent that satisfies them, delivery sized to the matter rather than the batch — because verification has moved from reading to checking, and review attention is the scarce resource work must be shaped to fit.
provenance: "Claude Code session (Claude Fable 5), 2026-08-01 — ratified by the operator from the TDD research spike, in place of piloting the methodology in a second repo"
tags: [meta, doctrine, tdd, verification, atomic-prs, review, direction, agents]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T19:20:00Z
  channel: agent-authored
  agent: "Claude Code agent, TDD research-spike session"
  why: "the operator directed recording the methodology's standing direction as doctrine (with its policy) rather than piloting in a second repo that doesn't yet exist"
---

# Verified increments: agent work lands test-first and review-sized

This is a **standing direction** — the *why* behind the stricter development
methodology, citable by plans, analyses, and policies the way
[bound adaptation](/meta/doctrine/bound-adaptation.md) is. The
[atomic-pull-requests policy](/meta/policy/git-atomic-pull-requests.md)
enforces its delivery half in this repo; the
[agent development methodology](/knowledge/SWE/agentic/code-quality/agent-development-methodology.md)
(`em:cab2c5`) carries the full prescription outward via the
[two-level guidance plan](/meta/plans/two-level-agent-methodology-guidance.md).

## The direction (quote-seeded)

> "Verified" used to mean "read by you". With modern agent throughput, it has
> to mean "checked by tests, by type checkers, by automated gates, or by you
> where your judgement matters".
>
> — Chris Parsons, quoted by Martin Fowler
> ([fragment, 2026-04-29](https://martinfowler.com/fragments/2026-04-29.html))

When agents produce most of the code, the two scarce resources are the
**oracle** (something mechanical that says pass/fail) and **human judgment**
(the attention that reviews intent, architecture, and the tests themselves).
The direction: shape all agent work so both are spent well — every increment
arrives *verified* by a test contract that existed before the implementation,
and *review-sized* so judgment is applied to one matter at a time.

## What it commits the brain and its agents to

- **Tests precede implementation by default.** The exceptions (explicitly
  throwaway exploration) are scoped and named, never assumed. A test never
  seen red proves nothing.
- **The test suite is a protected contract.** An agent changes a test only in
  its own visible step with the reason stated — never weakened, skipped, or
  special-cased to reach green. The reward-hacking evidence
  ([the ranking analysis](/meta/analysis/tdd-rank-for-coding-agent-development.md))
  makes this load-bearing rather than stylistic.
- **The matter is the unit of delivery; size is only a signal.** Work lands in
  increments a reviewer can hold — one intent per pull request — and review
  effort tracks decision density, not line count.
- **Verification is layered so judgment is spent last**: machine gates, then
  agent self-review, then the human — on architecture, intent-vs-tests
  alignment, and the tests themselves.

## Implementations

- [git-atomic-pull-requests](/meta/policy/git-atomic-pull-requests.md) — the
  delivery rule for this repo's sessions.
- The [gate suite](/meta/tutorials/the-gate-suite-and-where-it-runs.md) — the
  machine layer, already unconditional here.
- The [methodology doc](/knowledge/SWE/agentic/code-quality/agent-development-methodology.md)
  and its vendorable block — the direction's form in consuming repos.

# Citations

Chris Parsons via Martin Fowler,
[fragment 2026-04-29](https://martinfowler.com/fragments/2026-04-29.html);
grounded in
[where TDD ranks for coding-agent development](/meta/analysis/tdd-rank-for-coding-agent-development.md).
