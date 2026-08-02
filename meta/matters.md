---
type: reference
title: "Matters — the pending-delivery register"
description: The ordered, cross-session queue of pending matters — each row a self-contained handoff packet (matter, scope with decisions and refs, context flag) consumed top-down by fresh threads under the atomic-pull-requests policy; a consumed row moves to the in-doc Consumed log when its matter is delivered, and git history is the full archive.
provenance: "Maintained by agent sessions under the matter-queue plan; seeded 2026-08-02 from the TDD research-spike session's approved sequence"
tags: [meta, matters, work-queue, handoff, atomic-prs]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T04:05:00Z
  channel: agent-authored
  agent: "Claude Code agent, TDD research-spike session"
  why: "the compaction-driven handoff: persist the approved matter queue so remaining dev continues in fresh threads with no dependence on this session's memory"
---

# Matters

The pending-delivery register, per the
[matter-queue plan](/meta/plans/matter-queue-and-present-matters.md). One
[matter](/beliefs/glossary/matter.md) per row, one PR per matter
([policy](/meta/policy/git-atomic-pull-requests.md)); consume top-down;
when a row's matter is delivered, move it from the queue to the Consumed
log below (the move lands with the matter's PR). `fresh` = execute in a new
thread with this row (plus its refs) as the entire handoff.

| # | Matter | Scope — decisions made, where detail lives | Context |
|---|---|---|---|
| 1 | `/present-matters` skill | Per the [matter-queue plan](/meta/plans/matter-queue-and-present-matters.md): SKILL.md rendering this register, skills-registry policy entry, contract recompile. Consider the `/priorities` surfacing line (plan build-order 3). | fresh |
| 2 | `/create-pull-request` scoping edit | Two gaps, identified in the origin session: the commit step says "the current working changes" and needs *scope to the finished matter*; a repeat invocation in one session appends capture per `brain.thread_tail`, skips re-glossarying already-captured content, and records the follow-up PR in thread prose (`pr:` stays origin — already policy). | fresh |
| 3 | dev-history recommit + regeneration fold-in | Decision made (operator-approved): recommit the derived `meta/dev-history.md` (currently gitignored, deploy-only — Pages is de-prioritized and a referenced doc needs an in-repo home); fold regeneration into the `/create-pull-request` motion beside the other regenerate-before-commit artifacts, per the [staleness analysis](/meta/analysis/dev-history-staleness-and-ci-regeneration.md)'s own recommendation; include an unshallow guard (the original drift came from shallow clones — [resolved issue](/meta/issues/dev-history-regeneration-silently-skipped-on-shallow-clones.md)); accept the one-PR self-referential lag; update the [meta index](/meta/index.md)'s dev-history line. | fresh |
| 4 | response-resource-links / Pages-sunset revision | **Blocked on the operator firming the sunset decision.** When it firms: revise [response-resource-links](/meta/policy/response-resource-links.md) (Pages URL is currently "the durable, canonical form" — moves to blob-at-`main` or successor), `mix brain.url --pages`, and the site machinery's disposition. | fresh |
| 5 | Two-sided bias taxonomy implementation | Per the [plan](/meta/plans/two-sided-bias-taxonomy-and-compendium.md) — agent-side path ratification (leading: `knowledge/SWE/agentic/failure-modes/biases/`), per-entry literature-name pass, registers + einstellung refile (`em:837963` → the created [`knowledge/cognitive-science/biases/`](/knowledge/cognitive-science/biases/index.md)) + glossary pointer, thread-corpus backfill tagging, derive-don't-recall doctrine capstone. | fresh |
| 6 | TDD bookmark promotions | Per the [todo](/meta/todos/promote-the-tdd-survey-bookmarks.md): promote Willison red/green, Superpowers, Swett; intake arXiv 2602.07900 carrying the weighing the todo embeds. | fresh |
| 7 | Vendor-block pilot | **Blocked on an active consuming repo existing** ([two-level plan](/meta/plans/two-level-agent-methodology-guidance.md) build-order 3): paste the block from `em:cab2c5` into its `CLAUDE.md`, add repo specifics beneath. | fresh |

## Consumed

Delivered matters, newest first — the human-readable index of the queue's
history. Each row names its landing PR once one exists (a row logged before
its PR opens gets the number appended then); the row's full scope packet
stays in git history, in the commit that removed it from the queue.

| Date | Matter | Landed |
|---|---|---|
| 2026-08-02 | `deferred-work-is-filed` policy | [the policy](/meta/policy/deferred-work-is-filed.md), section `filing`, compiled into the contract — drafted for ratification at PR review |
| 2026-08-02 | Methodology finalization (the A-package remnant) | protection ladder, de-"exempt" wording, block v1 final in [`em:cab2c5`](/knowledge/SWE/agentic/code-quality/agent-development-methodology.md) — PR #226 |
