---
type: matter
title: "Contract-synchronization sweep"
description: Edit the source policies so the contract matches what the machine enforces (epistemology review §2) and no longer contradicts itself (§3), plus two cheap reference-integrity fixes from §4 — all policy edits in one reviewable pass, /render-contract riding.
status: open
plan: /meta/plans/decision-queue-matter-sequence.md
order: 1
provenance: "Claude Fable 5, decision-queue session"
tags: [meta, matter, contract, policy, synchronization, review]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T11:24:00Z
  channel: agent-authored
  agent: "Claude Code agent, decision-queue session"
  why: "the review's contract-sync sweep, broken out of the decision-queue thread as matter 1 of its sequence"
  from: [/meta/threads/2026-08-01-decision-queue-matter-breakout.md]
---

# Contract-synchronization sweep

Execute the one-session sweep the
[epistemology review](/meta/analysis/epistemology-and-governance-review.md)
recommends (its §2 desync table and §3 contradictions carry the full argued
case): edit the source policies, never `CLAUDE.md` directly, then
`/render-contract`. **Begin with the refresh step** — re-verify every row
below against `HEAD`; the states here were checked 2026-08-02, pre-delivery,
and the fix thread plus the matter-system build-out have already satisfied
parts of the original list.

Row states at filing:

1. **§2#1 open** — [frontmatter-schema](/meta/policy/frontmatter-schema.md)
   lacks the `sense` row; `mix brain.verify` hard-fails a glossary term
   without `sense: common/repo/dual`.
2. **§2#2 residue** — the index-listing coverage gate is now *built* (verify
   rule 9, per the delivered
   [gate-index-listing-coverage matter](/meta/matters/gate-index-listing-coverage.md):
   a stale-but-present `index.md` hard-fails; a wholly absent one stays
   advisory). No policy names it — add the sentence (natural home:
   [maintain-reserved-files](/meta/policy/maintain-reserved-files.md) or
   [reserved-filenames](/meta/policy/reserved-filenames.md)), keeping the
   [okf-conformance](/meta/policy/okf-conformance.md) tolerant-consumer rule
   intact (it governs foreign bundles; the gate governs this one's
   production).
3. **§2#3 residue** — [resource-attribution](/meta/policy/resource-attribution.md)
   now names `survey/` and `journal/` (fix thread); still unnamed:
   `meta/preamble.md` and `meta/flows/lineage.md`, which the verifier exempts
   (`attribution.ex`).
4. **§2#4 open** — the same policy's "Machine-enforced" sentence includes
   `from` under presence; `from`-presence is advisory ("never fail the
   gate"). Reword to match.
5. **§2#5 open** — [document-anatomy](/meta/policy/document-anatomy.md) names
   four non-bundle neighbors; the registry excludes seven content namespaces
   (also `inbox/`, `survey/`, `journal/`).
6. **§2#6 open** — the generated, `--check`-gated artifact enumeration misses
   `meta/code-map.md` and `meta/flows/lineage.md` (hand-edit-forbidden,
   stated nowhere) and the CI `dedup_probe` run.
7. **§2#7 superseded** — lib/ "concept" strings ride the accepted
   [concept-terminology plan](/meta/plans/concept-terminology-and-type-redefinition.md)'s
   code-side vocabulary sweep. Skip; do not duplicate.
8. **§3 open** — persist-plans ↔ plan-vs-capture present opposite defaults
   for the same trigger with the arbiter two policies away: add the
   precedence cross-reference (governance-artifact-routing's "answers
   *whether* to persist" sentence) into
   [persist-plans](/meta/policy/persist-plans.md) itself.
9. **§3 open, confirmed live 2026-08-02** — the
   [model-attribution](/meta/policy/model-attribution.md) gloss in
   [`meta/policy/index.md`](/meta/policy/index.md) says "in model-id form";
   the body mandates the trailer's display form and forbids a second form.
   Fix the gloss. (Edge: the
   [settle-model-attribution matter](/meta/matters/settle-model-attribution.md)
   rules on the policy's fate — this fix is worthwhile regardless and is not
   that ruling.)
10. **§3 open, confirmed live 2026-08-02** — the
    [skills-registry](/meta/policy/skills-registry.md) `/capture` gloss says
    "substantive exchanges only", a substance filter
    [session-capture](/meta/policy/session-capture.md) explicitly disclaims;
    and session-capture states its threshold as "~300 chars" in one sentence
    and "exactly … `len < 300`" later. Align the gloss; state the exact rule
    once.
11. **§3 open** — living-text violations inside the contract: the squash-era
    account and trailer-arrival narration in
    [merge-strategy](/meta/policy/merge-strategy.md) /
    [session-capture](/meta/policy/session-capture.md). Trim conservatively:
    keep operative rules and present-tense carve-outs (the `sb:` → `em:`
    mapping, the backfill-from-recorded-evidence rule, the
    coverage-gap classes), drop history that binds no one.
12. **§3 open** — route-tag materialization demotes ATX headers in lifted
    regions — systematic, disclosed normalization that
    [quote-primary-sources](/meta/policy/quote-primary-sources.md) ("never
    silently normalize") does not carve out. Add the one-sentence carve-out.
13. **§4 additions (cheap, beyond strict §2–3 — strike at approval if
    unwanted)** — the contract's capture drop rule cites "cb
    `transcript_hook.py`", a file in no checkout, with `cb` unexpanded:
    state the rule without the external citation. And the plainspeak
    worked example names `meta/dev-history.md`, absent from checkouts —
    **check first**: if the queued
    [dev-history recommit matter](/meta/matters/dev-history-recommit-and-regeneration-fold-in.md)
    has landed, the example is valid again and this sub-item drops.

Delivery: one pass, all source-policy edits + `/render-contract`, gate suite
green. The epistemology review's §2 table is the checkable oracle: after the
sweep, each row's "contract says" column should match its "machine does"
column.
