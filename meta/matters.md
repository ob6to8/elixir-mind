---
type: reference
title: "Matters — the pending-delivery register"
description: The ordered pointer view over queued matters — the global delivery sequence across initiatives is the one datum authored here (Type/Order columns project each doc's plan membership); each row points at a matter doc under meta/matters/, consumed top-down by fresh threads under the atomic-pull-requests policy.
provenance: "Maintained by agent sessions under the matter-docs plan; seeded 2026-08-02 from the TDD research-spike session's approved sequence"
tags: [meta, matters, work-queue, handoff, atomic-prs]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T04:05:00Z
  channel: agent-authored
  agent: "Claude Code agent, TDD research-spike session"
  why: "the compaction-driven handoff: persist the approved matter queue so remaining dev continues in fresh threads with no dependence on this session's memory"
  from: [/meta/threads/2026-08-02-stand-up-meta-matters-and-thin-the-register.md, /meta/threads/2026-08-02-matters-register-plan-metadata.md, /meta/threads/2026-08-02-todo-fold-into-matters.md, /meta/threads/2026-08-02-build-the-matter-skill.md, /meta/threads/2026-08-02-mix-brain-matters-and-consumed-retirement.md]
---

# Matters

The pending-delivery register, per the
[matter-docs plan](/meta/plans/matter-docs-architecture.md): the ordered
pointer view over queued matters. Each matter is a doc under
[`meta/matters/`](/meta/matters/index.md) — the handoff packet lives there;
the **global delivery order is the one datum authored here**. Each row's
**Type** and **Order** columns project its doc's `plan`/`order`
frontmatter: `planned` links the plan whose build order emitted the matter,
with Order the matter's position in that plan's own sequence; a standalone
matter is `independent`, Order `-`. One
[matter](/beliefs/glossary/matter.md) per row, one PR per matter
([policy](/meta/policy/git-atomic-pull-requests.md)).

Protocol — operationalized by
[`/matter`](/.claude/skills/matter/SKILL.md): consume top-down, each matter in
a fresh thread with its doc (plus the refs it carries) as the entire handoff. A matter whose doc records an
unmet blocker is skipped — consume the next row. Delivering a matter flips
its doc `done` and drops its row here, the move landing with the matter's
PR; the landing PR is stamped into the done doc (`pr: <N>`) at close, once
`/create-pull-request` opens it — the done docs under
[`meta/matters/`](/meta/matters/index.md) are the delivery history. An open
matter doc with no row here is backlog: filed, not yet committed to the
queue. `mix brain.matters` verifies this register against the docs: refs
resolve, row↔doc agreement, and the global order never inverting a plan's
internal order.

Queueing inserts at the **head**, never the tail
([revision-enters-through-scoping](/meta/policy/revision-enters-through-scoping.md)):
a row sits lower only when it depends on preceding rows, so the order here
carries real prioritization rather than arrival time. A matter that cannot be
ranked stays an unsequenced backlog doc.

| # | Matter | Type | Order |
|---|---|---|---|
| 1 | [Extract the model settings to a repo config surface](/meta/matters/extract-model-settings-to-repo-config.md) | [planned](/meta/plans/separate-the-model-roster-concerns.md) | 1 |
| 2 | [The model-stamping policy](/meta/matters/model-stamping-policy.md) | [planned](/meta/plans/separate-the-model-roster-concerns.md) | 2 |
| 3 | [Gate model values against the configured roster](/meta/matters/gate-model-values-against-the-roster.md) | [planned](/meta/plans/separate-the-model-roster-concerns.md) | 3 |
| 4 | [Backfill model stamps on matter docs](/meta/matters/backfill-model-stamps-on-matter-docs.md) | [planned](/meta/plans/model-column-in-the-matter-register.md) | 1 |
| 5 | [Register Model column and its agreement check](/meta/matters/register-model-column-and-agreement-check.md) | [planned](/meta/plans/model-column-in-the-matter-register.md) | 2 |
| 6 | [/create-pull-request scoping edit](/meta/matters/create-pull-request-scoping-edit.md) | independent | - |
| 7 | [dev-history recommit + regeneration fold-in](/meta/matters/dev-history-recommit-and-regeneration-fold-in.md) | independent | - |
| 8 | [Contract-synchronization sweep](/meta/matters/contract-synchronization-sweep.md) | [planned](/meta/plans/decision-queue-matter-sequence.md) | 1 |
| 9 | [Excerpt-log discipline](/meta/matters/excerpt-log-discipline.md) | [planned](/meta/plans/decision-queue-matter-sequence.md) | 2 |
| 10 | [Standardize the verbatim-capture filing pattern](/meta/matters/standardize-verbatim-capture-filing.md) | [planned](/meta/plans/decision-queue-matter-sequence.md) | 3 |
| 11 | [Settle model-attribution](/meta/matters/settle-model-attribution.md) | [planned](/meta/plans/decision-queue-matter-sequence.md) | 4 |
| 12 | [Contract-size counterweight](/meta/matters/contract-size-counterweight.md) | [planned](/meta/plans/decision-queue-matter-sequence.md) | 5 |
| 13 | [response-resource-links / Pages-sunset revision](/meta/matters/response-resource-links-pages-sunset-revision.md) | independent | - |
| 14 | [Two-sided bias taxonomy implementation](/meta/matters/two-sided-bias-taxonomy-implementation.md) | [planned](/meta/plans/two-sided-bias-taxonomy-and-compendium.md) | 1 |
| 15 | [TDD bookmark promotions](/meta/matters/tdd-bookmark-promotions.md) | independent | - |
| 16 | [Vendor-block pilot](/meta/matters/vendor-block-pilot.md) | [planned](/meta/plans/two-level-agent-methodology-guidance.md) | 3 |
