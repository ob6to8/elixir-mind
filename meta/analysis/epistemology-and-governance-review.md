---
type: analysis
title: "Epistemological review: the ladder holds where it is used, the contract has desynchronized from its enforcement at the edges, and one rule has zero conforming instances"
description: Audits the verification machinery in substance (all four verified docs checked against their evidence, three sources fetched live for quote fidelity) and the 41-policy contract for internal coherence — finding verbatim-quote discipline that is real, a support-asymmetry failure mode at claim edges, seven policy-vs-enforcement desyncs, one two-policy contradiction with opposite defaults, and a monotonic growth pressure no rule bounds.
provenance: "Claude Fable 5, Claude Code session — two delegated audit passes (policy coherence; verification substance) with every severe claim re-verified directly against the files, greps, or live fetches named inline"
tags: [meta, analysis, epistemology, verification, governance, policy, review]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T10:30:00Z
  channel: agent-authored
  agent: "Claude Code agent, comprehensive-review session"
  why: "the epistemological third of the operator-commissioned comprehensive repo review"
  from: [/meta/threads/2026-08-01-comprehensive-repo-review-session-1.md]
---

# Epistemological review

**Method.** Two delegated audit passes — one over `meta/preamble.md`, all 41
policies, all 9 doctrines, and `CLAUDE.md` against the enforcement code; one
over every `verified: true` document, its full evidence set, and three live
source fetches — with each severe finding below re-verified directly (the
verifying grep, file read, or fetch is named where it matters). Companion
docs: [the tooling review](/meta/analysis/tooling-implementation-review.md)
(code-side findings, two filed issues) and
[the development arc](/meta/analysis/development-arc-read-backwards-from-the-prs.md)
(where the practices below came from).

## 1. The verification ladder, in substance

The ladder is small and honest. Exactly **four** documents carry
`verified: true` (grep over live frontmatter; `tmp/` fixtures excluded):
two media-production concepts, the git-fetch concept from PR #1, and the
open-weights pricing claim. Every one of their nine `verified_by` edges
resolves; every quoted span that could be checked against a live source was
checked and came back **verbatim** — eight spans across Pro Git, gitglossary,
and the Kimi K3 license, including one elision that turned out to be
correctly marked against the live text. The open-weights doc's frozen log
even records a grounding pass deleting two figures a summarizing fetch had
interpolated — the [quote-primary-sources](/meta/policy/quote-primary-sources.md)
discipline demonstrably ran.

The characteristic failure is **support asymmetry at the claim's edges**,
not fabrication at its core:

- The open-weights claim's headline anchor — "prices at Claude Sonnet 5
  parity" — is verified on one side only: five captures ground the K3 side,
  while no capture anywhere under `knowledge/` states Sonnet's prices
  (`grep -ril "sonnet" knowledge/ai-industry/sources/` returns nothing).
  The comparison's other half rests on model memory.
- Agent-authored enumerations and extensions ride inside verified
  statements' titles and descriptions beyond what any target states: the
  git concept's description says a local branch "moves only when you pull,
  merge, reset, or commit" (an exhaustive-sounding list the sources never
  state, and incomplete as one — `rebase`, `branch -f` also move it); the
  ramps-as-time description folds the agent's own "video cut points"
  extension into what "the book builds on".
- One evidence capture (`em:8ad00c`, the K2.6 pricing) contains no verbatim
  span at all — a summarized table where the
  [verification-grounding policy](/meta/policy/verification-grounding.md)
  prescribes "verbatim quotes".

So `verified: true` today reliably certifies *the quoted predicates were
checked against captured primary text*; it does not yet guarantee *every
load-bearing element of the statement — especially comparative anchors and
description-level framing — sits inside the evidence set*. With four docs,
the exposure is a few sentences; the pattern is what matters as the ladder
grows.

Ladder hygiene elsewhere is clean: the `belief` boundary holds (0 of 14
beliefs carry `verified`; four of five sampled beliefs argue their own
type-boundary at filing time), sampled glossary entries match the usage in
their citing docs, and the unverified-claim backlog is two documents. The
imbalance is usage: ~600 statements sit at `verified: false` — 569 of them
glossary concepts that will never be verified — so the ladder's top rung
carries 4 of ~600. Verification is currently a ceremony for exceptional
documents, not a working gradient. (The 2026-08-01
[type-redefinition ratification](/meta/plans/concept-terminology-and-type-redefinition.md)
already moves on part of this: once executed, `verified` narrows to
`claim`/`note` and the glossary's perpetual `verified: false` fields drop —
the census above describes the pre-execution state.)

## 2. The contract has desynchronized from its own enforcement

Seven places where `CLAUDE.md` under-describes or mis-describes what the
machine actually does. Each was verified against
`lib/elixir_mind/verifier.ex`, `attribution.ex`, or `links.ex` directly:

| # | The contract says | The machine does |
|---|---|---|
| 1 | [frontmatter-schema](/meta/policy/frontmatter-schema.md) lists 13 fields — no `sense` row | `mix brain.verify` **hard-fails** any glossary term without `sense: common/repo/dual` (`verifier.ex:121-135`) |
| 2 | No policy names the index-listing gate; [okf-conformance](/meta/policy/okf-conformance.md) says "never reject the bundle for … absent `index.md` files" | A stale-but-present `index.md` is a **hard failure** (`links.ex` `unlisted_errors/1`, folded into verify) — `grep -rin "unlisted" meta/policy/` returns nothing |
| 3 | [resource-attribution](/meta/policy/resource-attribution.md) exempts three classes (threads, `inbox/`, generated artifacts) | The verifier exempts **six** — also `survey/`, `journal/`, `meta/preamble.md`+`meta/flows/lineage.md` (`attribution.ex:73-80`) |
| 4 | The same policy's "Machine-enforced" sentence includes `from` under "presence" | `from`-presence is **advisory only** ("never fail the gate", `attribution.ex:146-150`) |
| 5 | [document-anatomy](/meta/policy/document-anatomy.md) names four non-bundle neighbors (`.claude/`, `meta/`, tooling, `deprecated/`) | The registry excludes **seven** content namespaces — also `inbox/`, `survey/`, `journal/` (`registry.ex:22`) |
| 6 | Generated, `--check`-gated artifacts are enumerated as `CLAUDE.md` + `meta/registry.md` | CI also freshness-gates `meta/code-map.md` and `meta/flows/lineage.md`, and runs `brain.dedup_probe` — `meta/flows/lineage.md` is hand-edit-forbidden and no policy says so |
| 7 | [document-anatomy](/meta/policy/document-anatomy.md) reserves "document" for the unit | Fifteen `lib/` modules say "concept" in operator-facing strings, compiled into the CI-gated code map |

Individually small; jointly they mean a fresh agent reading only the
contract will be surprised by two hard gates (1, 2) and reassured by one
false "machine-enforced" (4). The synchronization debt all points one
direction — the tooling moved and the schema policies didn't — which dates
it to the July namespace and attribution build-outs.

## 3. Contradictions inside the contract

- **Opposite defaults for the same trigger.**
  [persist-plans](/meta/policy/persist-plans.md): "Whenever the operator
  approves a plan of any substance — a new subsystem, a genre or policy
  change, a multi-step build — persist it before acting on it."
  [plan-vs-capture](/meta/policy/plan-vs-capture.md): "Default: execute
  in-session; the commit and the capture are the record" — and its
  escalation list reuses the *same three examples* under the opposite
  condition. The reconciliation exists but lives only in
  [governance-artifact-routing](/meta/policy/governance-artifact-routing.md)
  ("plan-vs-capture answers *whether* to persist anything"), two sections
  away; persist-plans itself never cites plan-vs-capture, so the
  contract's reading order presents a rule and its negation before the
  arbiter.
- **A policy's index gloss contradicts its body.**
  [model-attribution](/meta/policy/model-attribution.md) mandates "the
  trailer's display form (`Claude Opus 4.8`, `Claude Fable 5`)" and warns
  "Do not coin a second form"; its gloss in
  [`meta/policy/index.md`](/meta/policy/index.md) says "in model-id form" —
  precisely the form the body forbids. Under
  [provenance-lives-in-metadata](/meta/policy/provenance-lives-in-metadata.md),
  glosses are in scope; this one misinstructs.
- **The capture rule exists in three wordings.** The
  [session-capture](/meta/policy/session-capture.md) policy: keep "every
  exchange … verbatim", drop only noise. The
  [skills-registry](/meta/policy/skills-registry.md) gloss: "substantive
  exchanges only" — a substance filter the source policy explicitly
  disclaims. And the threshold is "~300 chars" in one sentence, "exactly
  … `len < 300`" five lines later.
- **The contract narrates its own past.** The
  [living-text policy](/meta/policy/living-text-is-present-tense.md) names
  the compiled contract a living surface and grants history asides to
  tutorials and doctrine only — while the contract carries the `sb:` → `em:`
  migration story, the squash-era account, and the trailer-arrival date.
  Some pass the policy's own present-tense-pointer carve-out (a reader
  must know the `sb:` mapping to read old tokens); the squash-era and
  trailer-date passages are history that binds no one.

One more is a scope gap rather than a contradiction: route-tag
materialization demotes ATX headers inside lifted regions —
systematic, disclosed normalization of quoted text that
[quote-primary-sources](/meta/policy/quote-primary-sources.md) ("never
silently normalize") does not carve out.

## 4. A standing rule with zero conforming instances

[model-attribution](/meta/policy/model-attribution.md) (ratified
2026-07-31) requires agent-authored governance docs to name their producing
model in `provenance`. **Zero of the 41 policies carry a `provenance` field
at all** (`grep -l "^provenance:" meta/policy/*.md` → none), including
[assertions-name-their-basis](/meta/policy/assertions-name-their-basis.md),
filed 2026-08-01 — *after* ratification, inside the rule's forward-looking
scope. The nine doctrines, the only provenance-bearing governance docs,
split across the exact forms the policy says must not coexist: bare
"Claude Code session", `Claude Fable 5`, `Claude Opus 4.8`,
`claude-opus-4-8`, and a version-less `Claude Fable`. The policy itself
concedes enforcement is editorial and scope is forward-only — which,
combined, produces a rule that nothing will ever bring into conformance.
(Separately, the open
[ratify-or-reject todo](/meta/todos/ratify-or-reject-provenance-names-producing-model.md)
still asks whether to ratify a rule that the policy set shows as already
ratified — the todo is stale on its face.)

Two smaller reference-integrity items of the same kind: the contract's
capture drop rule cites "cb `transcript_hook.py`" — a file that exists
nowhere in this repository (`grep -rn transcript_hook` finds only the
contract, its source policy, a flow doc, and a thread) and whose `cb`
expansion is not linked; and the contract's one worked example of
plainspeak orientation names `meta/dev-history.md`, a file no checkout
contains (deliberately deploy-only since the dev-history change) — the
example a fresh agent cannot open.

## 5. Growth pressure with no counterweight

The contract is **15,153 words**, loaded into every session. The five
longest policies carry about a third of it; the communication section alone
is ~27%. The terseness rule exists — "keep policies **terse**: the contract
is loaded in full every session"
([governance-artifact-routing](/meta/policy/governance-artifact-routing.md))
— but renders ~600 lines in, inside a policy about type routing, and no
gate measures contract size. The
[banned-phrases register](/meta/policy/banned-phrases.md) is monotonic by
construction (entries append; no eviction rule exists in the corpus) and
grew from one seed to seven entries in five days. Every mechanism in the
repo ratchets obligations *in* — nothing expires, merges, or retires them.
This is the governance-side twin of the arc review's plan-accretion
finding, and the place it will bind first is exactly here: each policy
added to fix a finding of this review makes the contract longer.

## 6. Where the epistemic weight actually rests

The [arc review](/meta/analysis/development-arc-read-backwards-from-the-prs.md)
measured merge latencies of 1–6 minutes on sampled PRs: the ratification
gate (plans, proposals) is thick, and the merge gate is CI. That division
makes §2 more than housekeeping — when CI is the effective reviewer, the
gap between what the contract *claims* is enforced and what the gates
*actually* enforce is the system's real epistemic exposure. Today that gap
is: `from` back-links (advisory), link resolution (advisory), verification
substance (editorial by design), model attribution (nothing), tag coverage
(warn), and the two defects filed from the tooling review — while the
contract's prose implies a tighter net.

## Judgment and recommendations

The machinery, where it runs, is trustworthy: quotes are really verbatim,
evidence edges really resolve, the belief boundary really holds, and the
one demonstrated self-correction (the open-weights grounding pass) worked
exactly as designed. The corpus's epistemic risk is not in the checks but
in the **claims about the checks** — a contract that under-describes two
hard gates, over-describes one enforcement, contradicts itself on when to
persist plans, and carries a rule with zero conforming instances. In a
repo whose distinctive bet is "the contract is the backbone," contract
fidelity *is* the epistemology. Recommended, in order:

1. **A one-session synchronization sweep** of §2's seven rows plus §3's
   gloss fix and capture-gloss fix — all source-policy edits plus
   `/render-contract`; none needs new machinery.
2. **Resolve the plan-persistence contradiction** by adding the
   routing-policy's precedence sentence (or a cross-reference) into
   persist-plans itself.
3. **Decide model-attribution's fate**: either add the warn-only
   presence-and-form check the policy already sketches and backfill the 41
   policies, or retract the rule. A ratified rule with zero instances
   teaches agents that ratified rules are optional.
4. **Give the contract a size counterweight**: a warn-only per-policy and
   total word count in CI (trend, not gate), and consider the audit's
   relocation candidates (the skills-registry behavioral specs, the
   session-capture rationale paragraphs) for the existing tutorial layer.
5. **On the ladder**: adopt the two editorial rules the substance audit
   implies — a comparative claim captures both sides, and a description
   stays inside its evidence — and the verifier clause from the tooling
   review (reject self-citation in `verified_by`).
