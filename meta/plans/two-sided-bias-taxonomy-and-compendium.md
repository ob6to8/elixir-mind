---
type: plan
title: "Two-sided bias taxonomy: cognitive biases, agentic biases, and their in-the-wild instance registers"
description: Build parallel registers for human cognitive biases and agentic biases — separate evidence bases, same-slug cross-links marked analogical never identical, entries staying type concept with the path carrying the domain — plus mechanically-accreting in-the-wild instance logs via route tags, a per-entry literature-name rule, glossary pointer surfacing, and the derive-don't-recall doctrine as capstone; paths punted to implementation-time ratification with the operator's leading candidate recorded.
status: accepted
provenance: "Claude Code session (Claude Fable 5), 2026-08-01 — designed across the TDD research-spike session's bias dialog, from the einstellung/stale-premise exchange through the operator's two-register refinement"
tags: [meta, plan, cognitive-biases, agentic-biases, taxonomy, failure-modes, glossary, route-tags]
timestamp: 2026-08-01
attribution:
  when: 2026-08-02T00:15:00Z
  channel: agent-authored
  agent: "Claude Code agent, TDD research-spike session"
  why: "the operator directed a compendium of agentic cognitive biases plus recorded in-the-wild instances, then refined it into a two-sided human/agentic taxonomy and asked for the plan committed"
  from: [/meta/threads/2026-08-01-tdd-research-spike-and-methodology-adoption.md]
---

# Two-sided bias taxonomy and compendium

## Problem

Both the operator and the agents working this repo exhibit systematic,
directional reasoning failures. The human kind has an established name —
cognitive biases — and a literature; the agent kind has neither a settled
name nor a home in this bundle, yet two live specimens occurred in the
originating session alone: a retracted framing that kept steering later prose
(the "exempt" slip), and a removed artifact recalled as current (the
dev-history conflation). Some biases are human-only, some agent-only, and
some form parallel pairs (Einstellung/anchoring ↔ stale-premise
perseveration). The taxonomy must carry that venn structure explicitly, the
instances must accrete somewhere durable instead of dissolving into thread
history, and the mediation direction (derive-don't-recall) needs its doctrine
anchor pointing both backward at the bias and forward at the design decisions
that embody it.

## Decisions — ratified 2026-08-01 (this thread)

- **D1 — Two-sided structure.** Human cognitive biases and agentic biases are
  **separate registers with separate evidence bases**: the cognitive-bias
  side holds strictly human-behavioral evidence, the agentic side strictly
  agent evidence. Overlapping pairs cross-link under an explicit **parallel**
  relation, stated as *analogical, never mechanistic identity* — the human
  Einstellung effect arises from practiced procedural set, the agent
  counterpart from an append-only context with no retraction operation; same
  phenomenology, different machinery, and each entry says which side it
  speaks for.
- **D2 — Entries stay `type: concept`.** No new controlled type: the type
  vocabulary names document *kind*, the path names domain
  ([tree-is-the-taxonomy](/meta/policy/tree-is-the-taxonomy.md)). A
  same-slug pair is differentiated by path alone.
- **D3 — Per-entry naming rule.** An agentic-bias entry takes the
  **literature's name for that particular agentic bias when one exists**;
  it reuses the human-side name (same slug as its parallel) **only when the
  literature has no agent-specific name**. Every filing therefore starts
  with a literature check, recorded in the entry's provenance.
- **D4 — Biases are a subclass of failure modes, not the whole of them.**
  Agentic biases = systematic directional deviations arising from
  architecture or training (stale-premise perseveration, position/recency
  effects, sycophancy, format anchoring, verbosity preference). Discrete
  goal-directed failure *behaviors* — reward hacking, test-gaming — are
  failure modes but not biases: they keep their existing homes
  ([reward hacking](/beliefs/glossary/reward-hacking.md) and its reference
  cluster) and cross-link as consequences. The operator's leading path
  candidate (`…/failure-modes/biases/`) encodes exactly this genus/subclass
  nesting.
- **D5 — Glossary surfacing via pointer entries.** Terms stay findable in
  the glossary as thin pointers deferring to the filed register docs (the
  existing pointer-entry convention); bodies are not duplicated.
- **D6 — Instances accrete via route tags, never a hand-kept register.**
  Each bias entry is a route-tag sink; when `/capture` freezes a thread
  containing an instance, the region is tagged with the entry's `em:` id and
  the doc-side excerpt log accretes it, CI-verified. A bounded backfill
  sweep mines the existing thread corpus. (A hand-kept instance register is
  rejected as a second shadow log.)
- **D7 — The derive-don't-recall doctrine is the capstone.** Filed after the
  agentic register exists, pointing **backward** at the stale-premise entry
  and the [remembered-surfaces belief](/beliefs/remembered-surfaces-are-forgotten-surfaces.md)
  (siblings: dropped obligations vs. superseded frames still steering), and
  **forward** at the implementations already in force: session-capture's
  derive-the-append-boundary rule (`mix brain.thread_tail`),
  structured-plan-bodies' refresh rule, route-tagging's
  re-derive-and-fail-on-divergence gate, `/review-pr`'s
  artifacts-never-recall rule, and the generated-artifact `--check` family.

## Open questions — punted to implementation-time ratification

1. **Paths.** The operator's leading candidate for the agent side:
   `knowledge/SWE/agentic/failure-modes/biases/` (creating the wider
   `failure-modes/` register D4 implies, into which biases nest). The human
   side is genuinely open: `beliefs/cognitive-biases/` was floated, but the
   session's own answer to "are these biases in fact beliefs?" is **no** —
   this bundle's `belief` type is an operator-held, value-laden decision
   prior, while a bias description is epistemic knowledge (`concept`), so a
   `knowledge/` home is more principled; no cognitive-science domain exists
   yet, so the human side likely needs a **new top-level or new domain
   directory**, which requires its own ratification. Interim state stands:
   [einstellung-effect](/beliefs/glossary/einstellung-effect.md)
   (`em:837963`) remains a glossary entry until refile — stable ids survive
   moves by design, so nothing durable is spent by waiting.
2. **A sub-glossary for agentic biases.** Whether the agentic register also
   surfaces as its own glossary section (the operator: surfacing
   "agentic-bias" itself "leads to a sub glossary") versus plain pointer
   entries in the main glossary. Interacts with `mix brain.glossary`'s
   index-sync scope; decide when the register's size is known.

## Desired shape (paths illustrative pending Q1)

```
knowledge/SWE/agentic/failure-modes/          # NEW — the genus register (hub + index)
  biases/                                     # NEW — agentic biases (D4 subclass)
    index.md
    stale-premise-perseveration.md            # or the literature's name, per D3
    <position-effects, sycophancy, …>.md      # each: em: id, concept, agent evidence only
<human-side path per Q1>/
    einstellung-effect.md                     # refiled em:837963; human evidence only
beliefs/glossary/
  einstellung-effect.md                       # MODIFIED — becomes a pointer entry (D5)
meta/doctrine/
  derive-dont-recall.md                       # NEW — capstone (D7)
```

## Build order (fresh implementing thread)

1. Ratify Q1 (paths) and Q2 (sub-glossary) at the thread's opening.
2. Literature pass per seed entry (D3's naming rule): the stale-premise /
   Einstellung parallel first, then position/recency effects, sycophancy,
   format anchoring — each grounded in its reference docs
   ([context poisoning](/knowledge/SWE/agentic/context-engineering/conversation-tree-architecture.md),
   [context rot](/knowledge/SWE/agentic/context-engineering/context-rot-chroma-research.md),
   [SlopCodeBench](/knowledge/SWE/agentic/agentic-loop/slopcodebench-iterative-degradation.md),
   [TMS](/knowledge/knowledge-management/knowledge-representation/truth-maintenance-systems.md)
   for the missing-faculty frame).
3. Create both registers with hubs and indexes; refile `em:837963`; convert
   its glossary entry to a pointer; cross-link the first parallel pair.
4. Route-tag backfill sweep over existing threads for recorded instances —
   the originating thread's two specimens are the seed
   ([the TDD research-spike thread](/meta/threads/2026-08-01-tdd-research-spike-and-methodology-adoption.md)).
5. File the derive-don't-recall doctrine (D7) and update doctrine index.
6. Consider a `/capture` guidance line (tag bias instances at capture time)
   once tagging has been exercised manually — per the coding-standards
   admission posture, procedure before automation.

## Decision list

- **Recommended shape:** D1–D7 as ratified, Q1/Q2 resolved at implementation.
- **Rejected:** a single mixed human+agent register (loses the evidence-base
  separation and invites analogy-as-identity errors); a controlled
  `type: agentic-bias` (redundant with the path, per the operator's own
  path-implies-type argument); a hand-kept instance register (shadow log —
  route tags already aggregate cross-thread instances mechanically);
  identity framing of parallel pairs (the mechanisms demonstrably differ).
- **Assumption:** the venn's three cases (human-only, agent-only, parallel)
  are exhaustive; a bias that is genuinely *identical* in mechanism across
  both would be a new case requiring its own treatment, not silent filing to
  one side.
