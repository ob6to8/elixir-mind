---
type: reference
title: "Matters — the pending-delivery register"
description: The ordered pointer view over queued matters — the global delivery sequence across initiatives is the one datum authored here (Type/Order columns project each doc's plan membership); each row points at a matter doc under meta/matters/, consumed top-down by fresh threads under the atomic-pull-requests policy.
provenance: "Maintained by agent sessions under the matter-docs plan; seeded 2026-08-02 from the TDD research-spike session's approved sequence"
tags: [meta, matters, work-queue, handoff, atomic-prs]
timestamp: 2026-08-03
attribution:
  when: 2026-08-02T04:05:00Z
  channel: agent-authored
  agent: "Claude Code agent, TDD research-spike session"
  why: "the compaction-driven handoff: persist the approved matter queue so remaining dev continues in fresh threads with no dependence on this session's memory"
  from: [/meta/threads/2026-08-02-stand-up-meta-matters-and-thin-the-register.md, /meta/threads/2026-08-02-matters-register-plan-metadata.md, /meta/threads/2026-08-02-todo-fold-into-matters.md, /meta/threads/2026-08-02-build-the-matter-skill.md, /meta/threads/2026-08-02-mix-brain-matters-and-consumed-retirement.md, /meta/threads/2026-08-03-matter-list-audit-and-wave-delivery-methodology.md]
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
| 1 | [Union-safe attribution.from lists](/meta/matters/union-safe-attribution-from-lists.md) | independent | - |
| 2 | [Encode hook-directives-are-never-answers as a policy and a sync-skill guardrail](/meta/matters/encode-hook-directives-are-never-answers.md) | independent | - |
| 3 | [brain.search build 1: the BM25 core](/meta/matters/brain-search-bm25-core.md) | [planned](/meta/plans/brain-search-ranked-retrieval.md) | 1 |
| 4 | [brain.search build 2: the CLI and corpora](/meta/matters/brain-search-cli-and-corpora.md) | [planned](/meta/plans/brain-search-ranked-retrieval.md) | 2 |
| 5 | [brain.search build 3: probe trend line and intake wiring](/meta/matters/brain-search-probe-and-intake-wiring.md) | [planned](/meta/plans/brain-search-ranked-retrieval.md) | 3 |
| 6 | [brain.search build 4: the static-embedding tier](/meta/matters/brain-search-static-embedding-tier.md) | [planned](/meta/plans/brain-search-ranked-retrieval.md) | 4 |
| 7 | [Auto-wire the pre-commit hook in session-start.sh](/meta/matters/wire-pre-commit-hook-in-session-start.md) | independent | - |
| 8 | [Derive the register's row numbering](/meta/matters/derive-the-register-row-numbering.md) | independent | - |
| 9 | [Ratify the skill section vocabulary](/meta/matters/ratify-skill-section-vocabulary.md) | [planned](/meta/plans/skill-section-vocabulary.md) | 1 |
| 10 | [Migrate the 18 skills onto the section vocabulary](/meta/matters/migrate-skills-onto-section-vocabulary.md) | [planned](/meta/plans/skill-section-vocabulary.md) | 2 |
| 11 | [Gate skill section conformance](/meta/matters/gate-skill-section-conformance.md) | [planned](/meta/plans/skill-section-vocabulary.md) | 3 |
| 12 | [Disambiguate `order` from `sequence` in /scope-unit-of-work](/meta/matters/disambiguate-order-versus-sequence-in-scope-unit-of-work.md) | independent | - |
| 13 | [Extract the model settings to a repo config surface](/meta/matters/extract-model-settings-to-repo-config.md) | [planned](/meta/plans/separate-the-model-roster-concerns.md) | 1 |
| 14 | [The model-stamping policy](/meta/matters/model-stamping-policy.md) | [planned](/meta/plans/separate-the-model-roster-concerns.md) | 2 |
| 15 | [Gate model values against the configured roster](/meta/matters/gate-model-values-against-the-roster.md) | [planned](/meta/plans/separate-the-model-roster-concerns.md) | 3 |
| 16 | [Backfill model stamps on matter docs](/meta/matters/backfill-model-stamps-on-matter-docs.md) | [planned](/meta/plans/model-column-in-the-matter-register.md) | 1 |
| 17 | [Register Model column and its agreement check](/meta/matters/register-model-column-and-agreement-check.md) | [planned](/meta/plans/model-column-in-the-matter-register.md) | 2 |
| 18 | [Reconcile the plans index against plan status, and gate the agreement](/meta/matters/gate-plans-index-status-sections.md) | independent | - |
| 19 | [/create-pull-request scoping edit](/meta/matters/create-pull-request-scoping-edit.md) | independent | - |
| 20 | [dev-history recommit + regeneration fold-in](/meta/matters/dev-history-recommit-and-regeneration-fold-in.md) | independent | - |
| 21 | [Two-sided bias taxonomy implementation](/meta/matters/two-sided-bias-taxonomy-implementation.md) | [planned](/meta/plans/two-sided-bias-taxonomy-and-compendium.md) | 1 |
| 22 | [TDD bookmark promotions](/meta/matters/tdd-bookmark-promotions.md) | independent | - |
| 23 | [Contract-synchronization sweep](/meta/matters/contract-synchronization-sweep.md) | [planned](/meta/plans/decision-queue-matter-sequence.md) | 1 |
| 24 | [Excerpt-log discipline](/meta/matters/excerpt-log-discipline.md) | [planned](/meta/plans/decision-queue-matter-sequence.md) | 2 |
| 25 | [Standardize the verbatim-capture filing pattern](/meta/matters/standardize-verbatim-capture-filing.md) | [planned](/meta/plans/decision-queue-matter-sequence.md) | 3 |
| 26 | [Settle model-attribution](/meta/matters/settle-model-attribution.md) | [planned](/meta/plans/decision-queue-matter-sequence.md) | 4 |
| 27 | [Contract-size counterweight](/meta/matters/contract-size-counterweight.md) | [planned](/meta/plans/decision-queue-matter-sequence.md) | 5 |
