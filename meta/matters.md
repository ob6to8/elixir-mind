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
  from: [/meta/threads/2026-08-02-stand-up-meta-matters-and-thin-the-register.md, /meta/threads/2026-08-02-matters-register-plan-metadata.md]
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

Protocol: consume top-down, each matter in a fresh thread with its doc (plus
the refs it carries) as the entire handoff. A matter whose doc records an
unmet blocker is skipped — consume the next row. Delivering a matter flips
its doc `done`, drops its row here, and logs it under Consumed below (the
move lands with the matter's PR). An open matter doc with no row here is
backlog: filed, not yet committed to the queue.

| # | Matter | Type | Order |
|---|---|---|---|
| 1 | [Todo fold](/meta/matters/todo-fold.md) | [planned](/meta/plans/matter-docs-architecture.md) | 3 |
| 2 | [The /matter skill](/meta/matters/matter-skill.md) | [planned](/meta/plans/matter-docs-architecture.md) | 4 |
| 3 | [mix brain.matters verifier](/meta/matters/mix-brain-matters-verifier.md) | [planned](/meta/plans/matter-docs-architecture.md) | 5 |
| 4 | [/create-pull-request scoping edit](/meta/matters/create-pull-request-scoping-edit.md) | independent | - |
| 5 | [dev-history recommit + regeneration fold-in](/meta/matters/dev-history-recommit-and-regeneration-fold-in.md) | independent | - |
| 6 | [response-resource-links / Pages-sunset revision](/meta/matters/response-resource-links-pages-sunset-revision.md) | independent | - |
| 7 | [Two-sided bias taxonomy implementation](/meta/matters/two-sided-bias-taxonomy-implementation.md) | [planned](/meta/plans/two-sided-bias-taxonomy-and-compendium.md) | 1 |
| 8 | [TDD bookmark promotions](/meta/matters/tdd-bookmark-promotions.md) | independent | - |
| 9 | [Vendor-block pilot](/meta/matters/vendor-block-pilot.md) | [planned](/meta/plans/two-level-agent-methodology-guidance.md) | 3 |

## Consumed

Delivered matters, newest first — the human-readable index of the queue's
history (retires at matter-docs build 5 in favor of landing metadata on done
docs). Each row names its landing PR once one exists (a row logged before
its PR opens gets the number appended then); a pre-migration row's full
scope packet stays in git history, in the commit that removed it from the
queue, while a matter delivered since the migration keeps its packet in its
`done` doc. Type and Order read as in the queue above; a pre-migration
row's values derive from its git-history packet and the emitting plan's
build order.

| Date | Matter | Type | Order | Landed |
|---|---|---|---|---|
| 2026-08-02 | [Matters-register plan metadata](/meta/matters/matters-register-plan-metadata.md) | independent | - | Type/Order columns on both of this register's tables, projected from the matter docs' `plan`/`order` frontmatter; the instruction filed and consumed as this row's doc |
| 2026-08-02 | Stand up `meta/matters/` + thin this register | [planned](/meta/plans/matter-docs-architecture.md) | 2 | ten matter docs under [`meta/matters/`](/meta/matters/index.md) + this register thinned to the order-only pointer view; [matter-docs plan](/meta/plans/matter-docs-architecture.md) build 2 — PR #230 |
| 2026-08-02 | `type: matter` vocabulary adoption | [planned](/meta/plans/matter-docs-architecture.md) | 1 | [vocabulary entry](/meta/policy/controlled-type-vocabulary.md) + contract recompile; matter-docs plan flipped `in-progress` riding — PR #229 |
| 2026-08-02 | Matters-vs-plans definition question | independent | - | [matters-vs-plans analysis](/meta/analysis/matters-vs-plans.md) + the ratified [matter-docs plan](/meta/plans/matter-docs-architecture.md) (`type: matter`, order-only register, todo fold, term kept, former rows 2+3 merged, build queued as rows 1–5); glossary retag riding — PR #228 |
| 2026-08-02 | `deferred-work-is-filed` policy | independent | - | [the policy](/meta/policy/deferred-work-is-filed.md), section `filing`, compiled into the contract — ratified at review, PR #227 |
| 2026-08-02 | Methodology finalization (the A-package remnant) | independent | - | protection ladder, de-"exempt" wording, block v1 final in [`em:cab2c5`](/knowledge/SWE/agentic/code-quality/agent-development-methodology.md) — PR #226 |
