---
type: reference
title: "2026-08-01-schema-formalization-and-span-attribution-plans"
description: An operator-directed examination of em:712e01's frontmatter, key by key, that generalized into two ratified programs — per-key formal schema definitions checked in three tiers with an advisory evaluator lane, and PROV-aligned span-level text attribution — plus resolutions to the long-open concept-type and tags questions, closed by a mid-session model switch and a Fable review pass that overruled five design decisions.
provenance: "Claude Code session, 2026-08-01, model switched twice by the operator mid-session: Claude Opus 5 for the analysis and plan drafting, Claude Fable 5 for the review pass, Claude Opus 5 again for the capture and close; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, schema, attribution, provenance, types, vocabulary, tags, prov-dm, iso-704, evaluator, ci]
timestamp: 2026-08-01
pr: 219
session: https://claude.ai/code/session_01Y2Z4AHuUfu9JQTEosoHzj4
---

# 2026-08-01-schema-formalization-and-span-attribution-plans

## Where this landed

The operator opened by naming a document that does not exist
(`reddit-agent-says-done-reconciliation-patterns.md`); every detail quoted
matched [`em:712e01`](/knowledge/SWE/agentic/supervision/normative-records-vs-descriptive-traces.md),
which became the session's subject. Two general proposals framed the
examination — formal, evaluator-checkable definitions for every frontmatter
key, and universal attribution of every piece of text to its origin — with a
standing preference for adopting an existing standard over coining a DSL.

Working `em:712e01`'s frontmatter key by key produced findings that
generalized: the `claim`/`concept` split encodes epistemic status twice and
content-kind once; the description near-copies the body's first paragraph
while silently swapping the title's term-pair; `provenance` gestures at a
thread doc that has a resolvable address and does not use it; `tags`
duplicates the document's own path segments; `attribution.when` versus
`timestamp` is creation versus modification with nothing on the document
saying so.

Four standards were weighed and split by layer: **ISO 704** for
definition-prose structure (adopted as a distilled capture, never a committed
PDF — public Pages, unrewritable history, single-user license), **PROV-DM**
for attribution semantics, **SKOS** demoted from "alternative" to an optional
later edge layer, and **SHACL** left declined per the standing
ontology-guardrails verdict. None of the four carries a doxastic modality, so
the `claim`/`belief` axis is recorded as bundle-native.

Two plans were persisted and two standing plans had their open questions
closed. The operator then switched the session model mid-conversation, which
falsified an assertion made a turn earlier ("the model is fixed at session
start") and produced a Fable review pass that overruled five ratified design
decisions — most consequentially, that the ratified schema had cured
origin-metadata sprawl by adding a fourth origin block. The session's own
commit history supplied a further finding: a commit authored under one model
carries a trailer naming the other, which bounds the trailer-recovery design
the review pass had just added.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Per-key formal schema definitions, three-tier checking, advisory evaluator lane | closed | [schema-formalization-and-evaluator-lane](/meta/plans/schema-formalization-and-evaluator-lane.md) | - |
| Span-level text attribution, PROV alignment, structured provenance, derived edges | closed | [span-level-attribution](/meta/plans/span-level-attribution.md) | - |
| Types as pure content-kinds; claim/concept/note/belief trichotomy; graduation dropped | closed | [concept-terminology-and-type-redefinition](/meta/plans/concept-terminology-and-type-redefinition.md) | - |
| Tags as cross-cutting facets; query-time path union; disjointness lint | closed | [tag-governance](/meta/plans/tag-governance.md) | - |
| ISO 704 adoption posture and the committed-PDF question | closed | [schema-formalization-and-evaluator-lane](/meta/plans/schema-formalization-and-evaluator-lane.md) | - |
| Evaluator in CI vs. Jido vs. scheduled Routine; toolchain floor as prerequisite | closed | [schema-formalization-and-evaluator-lane](/meta/plans/schema-formalization-and-evaluator-lane.md) | - |
| Commit-trailer model recovery and its mixed-model-session error mode | closed | [span-level-attribution](/meta/plans/span-level-attribution.md) | - |
| `em:712e01`'s own defects (description, provenance ref, tag, verified) | open | [schema-formalization-and-evaluator-lane](/meta/plans/schema-formalization-and-evaluator-lane.md) | the fixes are phase-1 pilot work, not yet applied to the document |

## User

consider /knowledge/SWE/agentic/supervision/reddit-agent-says-done-reconciliation-patterns.md

In general, I want to unpack and work through the following proposals while examining this document as a subject:

* we should formalize structure when determining the value of keys within a schema (ie. each key in this okf doc should have a formal definition that can be checked by an evaluator agent which would pull the formal definition then evaluate the value against it for compliance
* all text should be attributed, with the options being: 1. operator 2. verbatim source attribution (with link to url or local resource) 3. LLM thread excerpt (directly lifted verbatim from a thread) 4. LLM synthesized (work done within a document itself, outside of a thread. 3 and 4 would both be further analyzed for attribution source - whether 1. training data 2. internal source in this repo 3. external search results that the claim can be verified against 4. RAG search etc

Regarding what the dsl or logic would be, I would lean towards adopting some standard rather than creating something bespoke, ie. OWL, datalog, etc - UNLESS we could justify the cost of creation

Now for the specific analysis and questioning I for this doc, for its own sake and to inform the above:

is there a formal logical definition of concept that leads to that type being assigned?

consider the description: "The distinction between a trace, which records what an agent did, and a decision record, which records what was authorized, by whom, with what reason, and what was amended first — the second being the artifact human-oversight obligations ask for and debugging telemetry cannot supply."

Why is it being referred to as a "descriptive" record when the title is "normative" and that is what is used in the body? Also - the description almost verbatim copies the first paragraph - is that the best use of a summary description? I would propose a formal format proposal, written in the language of the dsl we adopt/create, that introduces some sort of structure to the summary description, even if the best we can do is to impose a sentence structure. One idea is to create a format which is somewhat deterministically checkable through reduction - lets say we logically define the description summary sentence as requiring certain structure types (preposition, etc), the sentence could be split by deterministic code checks into its structure fragments and and evaluator agent could check simply that the prose section is that type. this would be structural enforcement and verification, though the llm would still be responsible for the fuzzy work of summarization

question: Why is "provenance" listing "Agent-distilled from an operator-directed design session, 2026-07-30" without any way to understand why its being listed? shouldn't all verbatim excerpts be captured at the bottom of the thread, as is done currently with "2026-07-30-neovim-adoption-and-the-agent-pairing-project (2026-07-30)"? and why isn't "2026-07-30-neovim-adoption-and-the-agent-pairing-project (2026-07-30)" listed in "provenance" as well? this should also be a check - any thread listed as provenance should be included in the meta-data, then deterministically checked that is properly quoted in the body below.

verified: false - what would move this to verified: true?

tags: supervision is listed as a tag, is this redundant with the fact that the okf doc lives at the canonical path that ends in the supervision directory?

timestamp - is this creation or modification? should both be kept?

attribution:
when: same, is this creation or modification?
channel: why is this called channel, ie. the channel it came from? given where this is headed, ie. atomic provenance as described above, this will be untenable, all docs will likely be a mix
"  agent: "Claude Code agent, operator-directed session on agent supervision and governance"" - is a nothingburger. should be the agent model (ie. Opus 5) and any available parameters (temperature, etc)
"  why: "the distinction generalizes past the project that surfaced it — it applies to any agent-oversight regime"" - this reads like a justification. possibly useful, on fence

evaluate and analyze and we can discuss next steps

## Assistant

Analysis complete — no files changed; this turn is the assessment you asked for. Everything below was checked against the live checkout and the compiled contract this session.

### Orientation

First, a correction: the path you gave doesn't exist. Every detail you quote — the description, the provenance line, the tags, the excerpt block — matches [normative-records-vs-descriptive-traces.md](https://github.com/ob6to8/elixir-mind/blob/claude/reddit-agent-reconciliation-analysis-9pnily/knowledge/SWE/agentic/supervision/normative-records-vs-descriptive-traces.md) (`em:712e01`), so that is the document I analyzed. The nearest "reddit" document, [agent-says-done-reddit-discussion-thread.md](https://github.com/ob6to8/elixir-mind/blob/claude/reddit-agent-reconciliation-analysis-9pnily/knowledge/SWE/agentic/action-verification/agent-says-done-reddit-discussion-thread.md) (`em:b01e03`, matching this branch's name), is a different genre entirely — a `type: source` verbatim capture — and none of your quotes come from it.

The short version of what I found: most of your specific questions have answers already encoded in the contract (timestamp vs. `attribution.when`, why the thread isn't in frontmatter, what flips `verified`), but several of them land on genuine seams — places where the design leaks exactly the way you sensed. And two of your bigger proposals are closer to built than you may expect: the repo already contains a deterministic description-restatement checker (scoped to the glossary only), and the route-tag system is already a machine-verified, span-granular attribution mechanism for one of your four attribution classes. The meta-proposals are therefore less "build a new system" and more "generalize three existing mechanisms and fill two real gaps."

---

### The document-specific questions

#### 1. Is there a formal logical definition of `concept` that drives type assignment?

No — scoped: I checked the [controlled-type-vocabulary policy](https://github.com/ob6to8/elixir-mind/blob/claude/reddit-agent-reconciliation-analysis-9pnily/meta/policy/controlled-type-vocabulary.md) as compiled into the contract, and `lib/elixir_mind/verifier.ex` in full. The vocabulary defines `concept` as "a definition or mental model (established/accepted)" — prose, discriminated from neighbors only by filing tests that are themselves prose ("epistemic (what is true) files as `claim`/`concept`"). The verifier checks *consequences* of a type (`verified` only on `claim`/`note`/`concept`; `launch` only on `visualization`) but never whether a type *fits* its content. Type assignment is entirely editorial.

And this document exposes a latent contradiction inside the vocabulary itself. Two incompatible readings coexist:

- **Type as epistemic status**: `claim` is a statement "asserted but not independently verified" that "may graduate to `concept` once confirmed" — under this reading, `concept` ⊆ confirmed, and `em:712e01` (a `concept` born with `verified: false`) is incoherent: it self-describes as "established/accepted" while flagged unchecked.
- **Type as content-kind**: `concept` is "a definition or mental model" — under this reading `em:712e01` is correctly typed (it *is* a mental model, a two-term distinction) and verification status is an orthogonal axis, which is how [verification-grounding](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/verification-grounding.md) treats it (it allows `verified: false` on concepts).

A formal definition would force the vocabulary to pick one axis. This is the strongest single argument for your evaluator-agent proposal: the act of writing the checkable definition surfaces the ambiguity immediately, in a way three months of editorial filing did not.

#### 2. "Descriptive" vs. "normative," and the description's quality

Precision matters here: the description never uses either "normative" or "descriptive." It names the pair "a trace" / "a decision record"; the title names it "normative records vs. descriptive traces"; the body uses both vocabularies. So there's no contradiction — "decision record" is the plain gloss of "normative record" — but there *is* unchecked terminological drift: three surfaces of one document, three partially-overlapping term sets, nothing tying them.

On near-verbatim overlap with paragraph 1: confirmed. The span "what was authorized, by whom, with what stated reason, and what was amended" appears nearly identically in both. Two things follow:

- For a `concept` whose entire content is one distinction, some restatement is inherent to the genre — the summary of a distinction *is* the distinction, compressed. The defect isn't that they overlap; it's that nothing bounds *how much*.
- **The check you're proposing already exists in this repo, deterministically, for glossary entries only.** [`glossary.ex`](https://github.com/ob6to8/elixir-mind/blob/main/lib/elixir_mind/glossary.ex) check 3 ("bodies expand the description, never restate it") computes content-word containment per body sentence against the description, warns at one threshold and *fails CI* at a higher one — no LLM involved. Your "deterministic reduction" instinct is validated by working code; the question is only whether to generalize it bundle-wide (where `em:712e01` would likely trip it).

On imposing sentence structure: for `type: concept` specifically, you don't need to invent the format — **ISO 704 terminology work is the established standard** you asked for. An intensional definition = superordinate concept (genus) + delimiting characteristics, checkable by the substitution test. The current description accidentally almost conforms: "The distinction between X and Y, …" is genus ("distinction") + differentia (the two relata and what separates them). A per-type description grammar — deterministic parse into fragments, evaluator agent judging only the residual fuzzy predicate ("does the differentia actually delimit?") — is exactly the two-tier architecture you sketched, and it matches how route-tags already splits mechanical checks from editorial ones.

#### 3. Provenance, the missing thread link, and the proposed check

Three mechanisms are in play, and your confusion is the design's fault, not yours:

- **`provenance` is deliberately free text** — "the *origin of the statement*" per [resource-attribution](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/resource-attribution.md). But here it gestures at "an operator-directed design session" that *has a resolvable address* — [the 2026-07-30 thread doc](https://github.com/ob6to8/elixir-mind/blob/claude/reddit-agent-reconciliation-analysis-9pnily/meta/threads/2026-07-30-neovim-adoption-and-the-agent-pairing-project.md) — and doesn't use it. An unresolvable pointer to a resolvable artifact is a defect by the repo's own lights, even though no current rule catches it.
- **The thread isn't in `attribution.from` because policy forbids it there**: `from` is "**Governance docs only.**" Bundle documents are barred from carrying the edge. That's why the linkage lives nowhere in this doc's frontmatter.
- **The excerpt log at the bottom is generated and machine-verified** — `mix brain.route_tags` re-derives it from the thread's `<routes ref="em:712e01">` regions and fails CI on divergence. So your proposed check ("any thread in provenance must be verifiably quoted below") is *half built*: the quoted-below verification exists and is deterministic. What's missing is the doc-side structured field. The check is currently keyed from the thread side (tag in thread ⇒ block in doc); there is no doc-side frontmatter edge to verify against, because policy withholds `from` from bundle docs.

The concrete fix, if you want it: either extend `from` to bundle documents, or add a distinct field (`distilled_from`), require its targets to resolve, and require each target thread to appear in the excerpt log — all deterministic, all within the existing verifier's idiom. The free-text provenance sentence then shrinks to what genuinely has no address.

#### 4. What flips `verified: false` to `true`?

Mechanically: a non-empty `verified_by` listing existing ids (typically `type: source` captures); the verifier enforces both halves; `mix brain.evidence em:712e01` then derives the narrative. Substantively, for this document:

- Its checkable claim is "human-oversight obligations ask for a normative record." Verifying it means capturing primary regulatory text — EU AI Act Article 14 human-oversight provisions, model-risk-management guidance — as `source` docs and wiring them in. The feeding thread already flags this exact joint: "I flagged the regulatory mapping as directional from training knowledge." The document's weakest load-bearing claim is known and named; it's just not yet backed.
- The distinction *itself* (normative vs. descriptive as different kinds) is arguably not empirically checkable — under the vocabulary's own filing test, that component is belief-shaped. Doc-level `verified` forces one bit onto a document that mixes a verifiable claim with an unverifiable framing. That is an argument *for* your span-level attribution proposal, from inside the repo's own type system.

#### 5. Is the `supervision` tag redundant with the path?

Partially, and no policy governs the interaction. The contract says "the tree *is* the taxonomy," so a tag duplicating the doc's own parent directory adds nothing for tree navigation; the other tags (`compliance`, `audit`, `observability`) are cross-cutting facets the path can't express, which is what tags are for. The inconsistency cuts both ways: if tags are meant as a path-independent flat search index, then *every* path segment should be tagged and never is; if they're facets-only, `supervision` should go. A one-line deterministic lint — warn when a tag equals a segment of the doc's own path — would force the decision and cost almost nothing.

#### 6–7. `timestamp` vs. `attribution.when`

Both are already kept, and they are different fields by design: `attribution.when` is **creation** — the ingestion instant, write-once, immutable ("update-in-place merges bump `timestamp`, not attribution"); `timestamp` is **last meaningful change**, mutable. They coincide here only because the doc hasn't been revised since filing. The real defect is discoverability: nothing on the document says which is which — a reader needs the contract in hand. That's an argument for your key-level formal definitions being *resolvable from the doc*, independent of everything else.

#### 8. `channel`

Correct as designed — it names the ingestion *pathway* — and your critique lands anyway: `channel` is doc-granular and event-scoped. It records the birth event only, so under update-in-place merges the document becomes a mixture while `channel` still says how the first sentence arrived. The policy is internally honest about this ("attribution is not a log: … one write-once record"), but under span-level attribution the field either moves to spans or must be explicitly reframed as "birth channel." It cannot carry the load you're describing, and the policy never claimed it could — the untenability appears only when your proposal 2 arrives.

#### 9. `agent` as a nothingburger

The blandness is by ratified design: [resource-attribution](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/resource-attribution.md) says `agent` names "the **pathway, not the model** (the model is in the commit trailer)," and the [model-attribution policy](https://github.com/ob6to8/elixir-mind/blob/claude/reddit-agent-reconciliation-analysis-9pnily/meta/policy/model-attribution.md) puts the model in `provenance` in trailer display form. Timing matters here (checked against git history): this doc was filed 2026-07-30 20:02 UTC; model-attribution was ratified 2026-07-31 03:34 UTC — about seven hours later, and scoped forward-looking. So `em:712e01` is legally pre-policy, and it is precisely the corpus gap that policy names ("many agent-authored governance documents name no model").

On temperature and sampling parameters: a session cannot see them — the harness doesn't expose sampling configuration to the running agent. Requiring them would institutionalize guessing, and the model-attribution policy's own reasoning applies: "Omission and a guess are both defects." Model name plus harness context is what's honestly attestable; parameters are not, today.

#### 10. `why` reads like a justification

Because it is one, by design: "Why it was deemed worth filing." Its audit function is the operator's post-intake editorial pass — highest-value on `auto-intake`, where nobody directed the filing and the reason-tag is the only record of the agent's editorial judgment. On operator-directed filings like this one it's near-redundant (you directed it). Fence-sitting is the right posture: cheap to keep, and if span attribution arrives, `why` is the one attribution sub-key that stays naturally doc-granular — a document has one filing rationale even when its text has many origins.

---

### The two meta-proposals

#### Proposal 1 — formal per-key definitions, evaluator-checked

Half of this exists. `mix brain.verify` *is* a per-key checker for every mechanically-decidable predicate (attribution shape, `verified`/`verified_by` coherence, `launch`, ref resolution), and the glossary's restatement check proves the middle tier — deterministic reduction over prose — is viable. What's missing is (a) formal definitions for the semantic predicates (does this description summarize well? does this type fit?) and (b) the evaluator agent.

The binding constraint is the repo's own gate-admission doctrine: a gate must run "offline as a plain `mix` task with no dependencies." An LLM evaluator can never satisfy that, so it can never be a CI gate under current doctrine — it lands as a warn-only report or an on-demand skill. That's a feature: the tag-coverage precedent already runs warn-never-fail for exactly this reason ("no mechanical oracle … stays editorial"). The natural architecture is three tiers per key:

1. **Shape** — deterministic, already in the verifier.
2. **Reducible structure** — deterministic parse against per-type grammars: description templates, resolvable provenance refs, the tag/path lint, restatement thresholds. New code, existing idiom, gate-eligible.
3. **Semantic fit** — evaluator agent judging the value against the key's formal definition; warn-only report, run on demand or per-PR outside the gate.

The formal definitions themselves should live where the schema already lives — the policy docs — with a machine-readable companion block the evaluator pulls, so the human rule and the checked rule cannot drift apart.

#### Proposal 2 — universal four-class text attribution

Your four classes map exactly onto **W3C PROV-DM**, which is the established standard for this and a better fit than OWL or Datalog: operator text → `prov:wasAttributedTo` (Person); verbatim source → `prov:wasQuotedFrom` + `prov:hadPrimarySource` (verbatim quotation is literally a first-class PROV relation); thread excerpt → `wasQuotedFrom` a thread entity; synthesized → `wasGeneratedBy` an Activity with a `SoftwareAgent`. Your secondary axis (training data / internal / external search / RAG) is PROV's derivation chain. The right adoption posture mirrors the repo's existing SHACL decision: take the *vocabulary and semantics*, serialize in YAML frontmatter and inline markup, skip the RDF triple store.

And again, more is built than it appears:

- **Class 3 is done**: route tags are span-granular, verbatim, machine-verified thread-excerpt attribution.
- **Class 2 is editorial**: quote-primary-sources mandates the verbatim span + citation but nothing checks it. The highest-value cheap addition in this whole discussion: when a quote's source is a *local* capture (like `em:b01e03`), verbatim-match is a deterministic string-containment check — no LLM, no network. The reddit capture repeatedly quoted by the beliefs extracted from it is the perfect first target.
- **Class 1 is segregated by construction** (journal voice rules, operator messages in thread renders).
- **Class 4 is the default** — which yields the crucial cost decision: don't mark all text; mark the *exceptions* and let unmarked = LLM-synthesized. Universal marking puts most of the annotation mass on the default class for zero audit value. Class 4's sub-attribution (training vs. internal vs. search vs. RAG) is an attestation, not a measurement — same epistemics the model-attribution policy already articulates: checkable for presence and form, never truthfulness.

#### DSL verdict

- **OWL: wrong tool.** Open-world semantics means a missing field is never an error — OWL cannot *validate*, only infer; validation-in-OWL is a recognized anti-pattern. Its validation companion is SHACL, which the [ontology-guardrails analysis](https://github.com/ob6to8/elixir-mind/blob/claude/reddit-agent-reconciliation-analysis-9pnily/meta/analysis/ontology-guardrails-vs-schema-validation.md) already declined — "declined, not deferred" — with named re-open conditions (rapid constraint churn, or non-Elixir constraint authors). Fair notice: proposal 1 executed at full scale might genuinely trigger the churn condition; that's the honest re-open path, not a reversal.
- **Datalog: right shape, wrong moment.** Referential and derivation rules over the doc graph are Datalog's home turf, but that's precisely what the hand-written verifier does today; adopting it now re-litigates a settled decision without new facts.
- **Recommendation**: PROV-DM vocabulary for attribution semantics; ISO 704 for concept-definition structure; per-type description grammars as plain templates checked in Elixir (generalizing the glossary check); the LLM evaluator as a warn-only skill outside the gate suite. Bespoke only at the markup seam — where `<routes>` already sets the syntax precedent.

---

**Your options from here**

| # | Option | What it entails |
|---|---|---|
| 1 | Cheap deterministic wins first | Generalize the glossary restatement check bundle-wide; add the tag/path lint; add a `distilled_from` (or extended `from`) edge with resolve-and-quoted-below verification; add local-capture quote verification. All gate-eligible under current doctrine, no new dependencies. |
| 2 | Draft the attribution plan | A `type: plan` under `meta/plans/` adopting PROV-DM class vocabulary, exception-marking (unmarked = synthesized), and the class-4 attestation stance — the design decisions here are weighty enough to persist before building. |
| 3 | Draft the schema-formalization plan | Per-key formal definitions as machine-readable companions to the policy docs, plus the three-tier checker architecture and the evaluator-agent skill (warn-only). Should also resolve the `concept` status-vs-kind ambiguity, which needs your ratification either way. |
| 4 | Fix `em:712e01` itself | Rewrite the description (ISO 704 form, dropping the paragraph-1 overlap), resolve the provenance pointer, decide the `supervision` tag, and optionally capture EU AI Act Art. 14 as a `source` to flip `verified`. Small, and a useful pilot for whichever plan you pick. |

My recommendation: 1 and 4 together as a pilot (the fixes to this doc become the test cases for the new checks), with 2 and 3 as ratified plans before any evaluator-agent work starts — both change the shape of the brain enough to warrant the prospective artifact.

## User

what is the formal definition of a claim? if it even remotely resembles "a definition or mental model", then the claim/concept split starts to look like the same type, just verified or not

re: 2 - my mistake, i meant to say why use "normative records" (body) and "decision records" (used in the. description prop value)

I would argue there should be zero overlap between the body and summary to ensure the summary is in fact a summary. or just have the summary be the first sentence of the body copied over verbatim, scannable for progressive disclosure

yes, the glossary check does need to be generalized to be bundle wide in my opinion, at least long term

seems like adopting ISO 704 would firm up many aspects of this repos design. in fact it seems like i'm on my way to trying to re-invent it, which I would file categorically as a Bad Idea (TM). from what i am seeing it costs, https://www.iso.org/obp/ui/#iso:std:iso:704:ed-4:v1:en - is this correct? if so, would i be able to keep the pdf as a reference in this repo or would that violate terms? are there other options worth considering?

re: the three mechanisms:

* should provenance really be free text? seems like it would be enforceable, its always a pointer to a resource. 
* i don't actuall see attribution.from - only when, channel, agent, and why. regardless, why does policy forbid?

lets discuss before deciding on action here

re: 4

* this would seem to extend to each statement having provenance, as I outlined in my original message. then verified_by would be a binary question - is every claim in this document traced to provenance? this could be denoted by xml tags or something for scannability. this relates to your comment below: " Doc-level verified forces one bit onto a document that mixes a verifiable claim with an unverifiable framing"
* explain this: " under the vocabulary's own filing test, that component is belief-shaped"

5
expand on "if tags are meant as a path-independent flat search index, then every path segment should be tagged and never is; if they're facets-only, supervision should go. A one-line deterministic lint — warn when a tag equals a segment of the doc's own path — would force the decision and cost almost nothing." I am thinking the former, but not following all your logic

6
agree with "key-level formal definitions being resolvable from the doc". I am thinking that attribution.when should then be renamed to attribution.created, and timestamp should become date-modified

8
agreed

9
maybe agent should be renamed to conception or something
we should prepare for the work we do to reach into and modify design and policy documents. our work supersedes them.
confirm model plus harness

10
makes sense

proposal 1:
is this the moment when we can viably consider porting this system to the beam runtime and build a jido 2 agent layer for the llm evaluator? would it then actually be part of CI?
or do we just change the gate-admission doctrine to allow for the judge calls, and it is foldable into the ci check as is without needing to move to a runtime?
agree formal defs live where schema already lives

2:
would PROV-DM supersede SHACL or function alongside?
what are these classes referring to?
wait, now you're saying SHACL was declined?
recommendation: accepted

agree with you recs for next steps 1/4, then 2-3 as plans

lets just first work through all the points above

also - quote my points before responding so I don't need to jump back up to my original message to see what you are in fact responding to

## Assistant

All points worked through below, each under a quote of yours. Facts checked this turn: the ISO price (web search), the git history dates (last turn), and all vocabulary/policy quotes are verbatim from the compiled contract in this checkout. No files changed — this is still discussion.

---

### 1. The claim/concept split

> what is the formal definition of a claim? if it even remotely resembles "a definition or mental model", then the claim/concept split starts to look like the same type, just verified or not

Verbatim from the vocabulary: a `claim` is "a statement **asserted but not independently verified** (track status with the `verified` field; may graduate to `concept` once confirmed)."

So it doesn't resemble "a definition or mental model" — it's worse than that: `claim` is defined purely by *status*, with no content-kind at all, and the graduation clause explicitly concedes your reading — claim→concept graduation treats them as one kind at two statuses. Meanwhile `concept`'s definition carries both a kind ("a definition or mental model") and a status ("established/accepted"). The result is that epistemic status is encoded **twice** (in the type and in the `verified` field) while content-kind is encoded once, fuzzily, on only one of the two types.

The clean resolution, which ISO 704 happens to endorse: make types pure content-kinds. A `claim` is a truth-apt proposition (evaluated by truth, carries `verified`); a `concept` is a definition or mental model (evaluated by adequacy and usefulness, not truth — ISO 704 distinguishes the concept, a unit of knowledge, from propositions about objects). Delete the graduation clause: a verified claim *stays a claim*, now verified — it doesn't transmute into a definition. `verified` becomes the sole carrier of status. Under that reading `em:712e01` is coherently a `concept`, and its empirical entailments (e.g. "oversight obligations ask for this artifact") belong in the verification machinery as claims or `verified_by` evidence. This is a vocabulary change, so it needs your ratification — it should be a decision inside plan 3.

### 2. "Normative records" vs. "decision records", and the overlap rule

> why use "normative records" (body) and "decision records" (used in the description prop value)

No recorded reason exists — I checked the doc, its feeding thread excerpt, and the frontmatter; the term switch appears nowhere as a decision. The likely mechanism: the description doubles as the index gloss, and the authoring session reached for a plainer synonym there. It's exactly the unchecked drift class you're proposing to eliminate — three surfaces (title, description, body), two term-pairs, no rule tying them. A formal description schema would make "key terms in the description must appear in the title or body" a checkable predicate.

> I would argue there should be zero overlap between the body and summary to ensure the summary is in fact a summary. or just have the summary be the first sentence of the body copied over verbatim, scannable for progressive disclosure

These are the two consistent regimes, and the repo has already committed to the first one — in the glossary only. From `glossary.ex`'s moduledoc: "the lede is expansion-only — it must not restate what the description" says — i.e. description is the canonical compressed statement, the body may only *expand*, and near-restatement fails CI via the word-containment check. Your first-sentence-verbatim alternative is even more checkable (string equality, zero drift possible), but it has three costs: it inverts the glossary's shipped design; it makes the description informationally empty (any index listing title + description now shows title + body-opening, which often leans on the title for context); and it forces one sentence to serve two readers (in-flow prose and standalone gloss). The zero-overlap regime has one cost of its own to name: a "different words" requirement can be gamed into thesaurus-shuffling to dodge the checker — the containment threshold has to be tuned against that.

My recommendation stands: generalize the glossary regime bundle-wide — description canonical, body expansion-only, containment-checked — because it's built, tested, and ISO-704-compatible (description ≈ the definition; body ≈ the encyclopedic expansion).

> yes, the glossary check does need to be generalized to be bundle wide in my opinion, at least long term

Agreed, and "long term" has a cheap phasing: run it bundle-wide as **warn-only first** to measure the existing violation rate (I'd expect `em:712e01` and a good share of the corpus to trip it), then flip to fail once the corpus is cleaned. That's the same warn→gate ratchet the doctrine already uses.

### 3. ISO 704 — price, the PDF, alternatives

> from what i am seeing it costs, https://www.iso.org/obp/ui/#iso:std:iso:704:ed-4:v1:en - is this correct? if so, would i be able to keep the pdf as a reference in this repo or would that violate terms? are there other options worth considering?

Checked via web search: **ISO 704:2022 (edition 4) is CHF 204** for the PDF/e-copy from ISO. Your link is the OBP reading interface for the same standard; the purchase page is [iso.org/standard/79077.html](https://www.iso.org/standard/79077.html).

On committing the PDF: **don't.** Three reasons, in descending certainty:

- **Checked:** this bundle publishes to public GitHub Pages (`ob6to8.github.io/elixir-mind`). Anything in the repo is at minimum clonable and at worst web-served — that's redistribution, not personal use.
- **Checked (structural):** repo history is immutable here by policy — merge-strategy forbids rewriting shared history, so a committed PDF can never be truly removed if it later needs to be.
- **From memory, unchecked:** ISO's standard single-user license permits one user's copy and prohibits storage on systems accessible to others. Read the actual license text delivered with purchase, but I'd expect even a private-repo copy to violate it.

The compliant pattern is the repo's own filing rule — capture the knowledge, cite the source: buy it, read it, file a distilled `reference` with brief verbatim quotes (phrase-scale, per quote-primary-sources), `resource:` pointing at the ISO page, PDF kept locally outside the repo. Copyright protects the expression, not the principles — and the principles are what the schema work needs.

Alternatives worth knowing about: free legitimate previews exist ([iTeh sample pages](https://cdn.standards.iteh.ai/samples/79077/2dd50250582e4a9fa3420af5da705572/ISO-704-2022.pdf), [ANSI preview](https://webstore.ansi.org/standards/iso/iso7042022)); the **Pavel Terminology Tutorial** (Government of Canada, free) covers the same genus-differentia definition craft; **OMG SBVR** is a free-to-download spec that formalizes vocabularies + definitions in a controlled English — arguably closer to your DSL ambition than ISO 704 itself; **W3C SKOS** (free) is the lightweight concept-scheme vocabulary. The principles you need are fully recoverable from the free tier; buy the standard only if you want the authoritative text on your shelf.

Sources: [ISO 704:2022](https://www.iso.org/standard/79077.html), [en-standard.eu listing](https://www.en-standard.eu/iso-704-2022-terminology-work-principles-and-methods/), [ANSI webstore](https://webstore.ansi.org/standards/iso/iso7042022)

### The three mechanisms

> should provenance really be free text? seems like it would be enforceable, its always a pointer to a resource.

It isn't always a pointer — the live corpus has counterexamples. The reddit capture's provenance is origin *narrative*: "Page text pasted by the operator, 2026-07-31; the page cannot be fetched from this sandbox — Reddit returns HTTP 403…". And the model-attribution policy routes model names into provenance ("Claude Opus 4.8") — a name, not an address. Some origins genuinely have no address (a pre-capture conversation, operator memory).

But "often contains a pointer, currently unstructured" is exactly the reformable case: split it into `provenance.model` (controlled form), `provenance.ref` (resolvable id/path, **required whenever the origin has an in-repo address** — the defect in `em:712e01` was a resolvable origin left as prose), and `provenance.note` (the free-text residue). Ref-resolution is deterministic; "does the origin have an address you failed to use" is an evaluator-tier check. This folds naturally into the PROV alignment (`wasAttributedTo` / `wasDerivedFrom`).

> i don't actuall see attribution.from - only when, channel, agent, and why. regardless, why does policy forbid?

You don't see it because the policy forbids it *on this doc*: `from` is "**Governance docs only.**" and `em:712e01` is a bundle document. The recoverable design logic for the split: route tags key on `em:` ids, and governance docs *have no `em:` ids* — so they can't be route-tag sinks, get no generated excerpt log, and `from` is their substitute edge back to their thread. Bundle docs have the richer mechanism (span-granular, generated, CI-verified), so a hand-kept doc-level `from` would be a shadow copy of the route-tag edge — the repo's one-origin-one-home instinct, applied consistently.

It's coherent — and it still produces the asymmetry you caught: a bundle doc's thread-edge is only checkable from the thread side, and is invisible in its frontmatter (the excerpt log is body, not metadata). If we add a doc-side edge (`distilled_from` or extended `from`), it should be **derived from or verified against the route tags**, never hand-kept in parallel — otherwise we rebuild the shadow-copy problem the design was avoiding.

### Per-statement provenance

> this would seem to extend to each statement having provenance, as I outlined in my original message. then verified_by would be a binary question - is every claim in this document traced to provenance? this could be denoted by xml tags or something for scannability.

Endorsed, with the mechanics named. The markup precedent exists (`<routes ref="…">` regions); an attribution sibling (`<attr class="quote" src="em:…">` or similar) follows the same shape, with **unmarked = LLM-synthesized** as the default so annotation mass lands only on exceptions. Doc-level `verified` then stops being an asserted bit and becomes a **derived** one: verified ⟺ every truth-apt span carries a resolving support ref — computable, and it dissolves the one-bit-on-a-mixed-doc problem.

Two hard parts to keep in view: deciding *which spans are truth-apt* (claims vs. framing) has no mechanical oracle — that's evaluator-tier work; and unlike thread bodies, knowledge docs are **living** — route tags only ever annotate frozen text, so span markup that must survive edits and re-flows is a genuinely new problem the route-tag design never had to solve. That's the riskiest piece of the whole proposal and deserves its own section in plan 2.

> explain this: "under the vocabulary's own filing test, that component is belief-shaped"

The vocabulary's filing test, verbatim: "*epistemic (what is true) files as `claim`/`concept`; value-laden prior (what I act as if is true) files as `belief`; teleological (what standing direction) files as `doctrine`.*" And `belief` is defined as a statement "held *true enough to guide action* even where unverifiable."

The doc's core framing — "The two are different kinds, not different qualities" — is not falsifiable: no observation could refute a categorization choice. You adopt it because organizing oversight work around it pays. "Adopted because it pays, unverifiable in principle" matches the `belief` definition more than the `claim` one. Caveat: the concept/belief boundary is itself fuzzy — a "mental model" isn't falsifiable either — so this is another spot where writing the formal definitions will force a ratification decision rather than reveal an answer that already exists.

### 5. Tags

> expand on [the tags-vs-path logic] ... I am thinking the former, but not following all your logic

Concretely with this doc: its stored tags are `[supervision, observability, compliance, governance, audit, agentic]`; its path segments are `knowledge / SWE / agentic / supervision`. So it tags **two of its four** path segments (`agentic`, `supervision`) plus four cross-cutting facets.

If tags are the flat search index (your preference), then a query for `tag:agentic` should return *every* document under `agentic/` — but it only returns documents whose author happened to include the tag. The index silently under-covers, and a search surface that silently misses is worse than none, because absence from results reads as nonexistence. Making the stored-tag index complete would require every doc to tag every one of its path segments — pure denormalization of the path, guaranteed to drift on every file move.

The resolution that gives you the flat index without the drift: **store facets only, derive path tags at query time.** Path segments are implicit tags that are free and always current — a `mix brain.tags <term>` query unions stored tags with path segments, so flat search finds this doc under `SWE`, `agentic`, `supervision`, *and* `audit`, while the stored list carries only what the path can't express. The lint (error when a stored tag duplicates a segment of the doc's own path) then isn't a style rule — it's what keeps the two halves of the index disjoint. You get regime-(b) semantics with regime-(a) storage.

### 6. Renames

> I am thinking that attribution.when should then be renamed to attribution.created, and timestamp should become date-modified

Agreed, with one adjustment from prefer-established-terminology: the established pair here is **Dublin Core** — `dcterms:created` / `dcterms:modified`. So `attribution.created` and top-level `modified` (bare, not `date-modified` — DC uses the bare terms, and the value is already ISO 8601). Mechanically it's a corpus-wide sweep plus `attribution.ex`/verifier/policy edits and a contract recompile — all gate-checkable. It's a schema shape change, so it gets ratified as a decision inside plan 3 rather than done ad hoc.

### 9. `agent`, supersession, and model+harness

> maybe agent should be renamed to conception or something. we should prepare for the work we do to reach into and modify design and policy documents. our work supersedes them. confirm model plus harness

On the rename: "conception" would be a bespoke coinage a cold reader can't guess — prefer-established-terminology says reach for the standard term, and PROV-DM supplies exactly the split this field is straining under: **`prov:Agent`** (who/what acted — for us, model + harness as a software agent) vs. **`prov:Activity`** (the context it acted in — session, skill, Routine). Today's `attribution.agent` values are actually activity-flavored ("Claude Code agent, /research daily Routine"). So the reform: `agent` = model + harness; `activity` = the pathway context; `channel` likely folds into `activity`. **Model plus harness: confirmed** — and sampling parameters stay out, because a session cannot observe them, and the model-attribution policy's own rule applies: "Omission and a guess are both defects."

On supersession: agreed, with the procedural note that the supersession *mechanism* is editing the source policies and recompiling the contract, with your ratification recorded in the captured thread — that's how our work reaches into the policy layer, not an exception to it.

### Proposal 1 — evaluator in CI

> is this the moment when we can viably consider porting this system to the beam runtime and build a jido 2 agent layer for the llm evaluator? would it then actually be part of CI? or do we just change the gate-admission doctrine to allow for the judge calls, and it is foldable into the ci check as is without needing to move to a runtime?

One premise to correct: **the system already runs on the BEAM** — every `mix brain.*` task is Elixir. There's no port; there are three separable decisions being bundled:

1. **Can an LLM judge run in CI?** Mechanically yes today — CI has network; add an API-key secret; run it as a separate job. The blocker is doctrinal, not technical.
2. **What doctrine change?** Don't weaken the gate definition — add a **second lane**. The doctrine already contains the precedent structure: actionlint runs "CI-only, since their subject exists only there." The amendment: deterministic gates block; the evaluator lane is CI-only, warn-only, and can never fail the build. Nondeterminism, cost, and the API dependency are all acceptable in a lane that can't block — and unacceptable in one that can.
3. **Jido?** Orthogonal to CI admissibility. Jido buys agent structure — multi-step loops, tool use, supervision trees — and the evaluator needs none of that: it's "pull the key's formal definition, judge the value, emit a report," one API call per key per doc. A plain mix task suffices. Also, checked at session start: this environment runs **Elixir 1.14 / OTP 24**; Jido requires a much newer toolchain (from memory, unchecked: ~1.16+), so a Jido layer implies a toolchain upgrade as a prerequisite regardless.

One more option to weigh: the evaluator doesn't have to live in the Elixir toolchain at all — a scheduled Claude session (a Routine) running the report and filing results costs zero toolchain change and uses the harness you already run. The trade-off is that CI-lane runs are pinned to PRs while a Routine is time-based. Plan 3 should pick between "mix task in an advisory CI lane" and "Routine-driven report"; my lean is the CI lane, because the signal is most useful attached to the PR that introduced the violation.

### Proposal 2 — PROV-DM, SHACL, classes

> would PROV-DM supersede SHACL or function alongside? what are these classes referring to? wait, now you're saying SHACL was declined?

- **Alongside — different layers.** PROV-DM is a *vocabulary*: what provenance facts to record (agents, activities, derivations, quotations). SHACL is a *constraint language*: how to validate graph shapes. In a full W3C stack, SHACL shapes would validate PROV-O data. Adopting PROV's vocabulary while validating with the hand-written Elixir verifier is coherent — take the semantics, skip the triple store.
- **"These classes" are yours** — the four attribution categories from your first message (1 operator, 2 verbatim source, 3 thread excerpt, 4 LLM-synthesized). I was mapping each onto a PROV relation: `wasAttributedTo`, `wasQuotedFrom` + `hadPrimarySource`, `wasQuotedFrom` (thread entity), `wasGeneratedBy` (software agent).
- **SHACL was declined before this conversation** — it's in the compiled contract, from the ontology-guardrails analysis: re-expressing the verifier's rules "in a declarative constraint language (SHACL over RDF.ex/SPARQL.ex, or any equivalent) is **declined**, not deferred," with named re-open conditions: rapid constraint churn, or constraint authors who don't write Elixir. I raised it because your proposal 1 at full scale could plausibly meet the churn condition — that's the sanctioned path to reopening it, not a reversal I was proposing.

---

## Where each decision now stands

| # | Matter | Status after this exchange |
|---|---|---|
| 1 | Types = content-kinds; drop claim→concept graduation; `verified` carries status | Recommended, needs your explicit ratification (vocabulary change) → plan 3 |
| 2 | Description regime: glossary rule bundle-wide (canonical description, expansion-only body), warn→fail phased | You've endorsed generalization; regime choice (glossary-style vs. first-sentence-verbatim) still yours to call — I recommend glossary-style |
| 3 | ISO 704: adopt principles via distilled capture; no PDF in repo | Settled unless you object |
| 4 | Structure `provenance` (model / ref / note); ref required-when-resolvable | Direction agreed in spirit → plan 2/3 detail |
| 5 | Doc-side thread edge for bundle docs, derived/verified against route tags | Open — extend `from` vs. new `distilled_from` vs. derive-only |
| 6 | Tags: store facets only + query-time path union + disjointness lint | Proposed resolution of your regime question — needs your yes/no |
| 7 | `attribution.when`→`created`, `timestamp`→`modified` (Dublin Core forms) | Agreed, lands in plan 3 |
| 8 | `agent` = model+harness; add `activity`; fold `channel` | Direction agreed; naming per PROV — needs ratification |
| 9 | Evaluator: advisory CI lane, plain mix task, no Jido, doctrine amended with a second-lane carve-out | Recommended; Routine-based alternative noted |
| 10 | PROV-DM vocabulary adopted conceptually; SHACL stays declined | Settled unless you reopen |

When you're ready, rows 1, 2, 5, 6, and 8 are the ones needing your explicit call; everything else can flow into the two plans and the 1/4 pilot we already agreed on.

## User

1
it seems that claim should be re-defined. the duplicated epistemic statuses should be addressed.
 
what does "make types pure content-kinds" mean?
matter: ratifying this vocabulary change for plan 3

2

* more ammo fore a formal description schema
* agree to generalize the glossary regime bundle wide. one idea for formalizing the summary is to create a formal structure that an evaluator agent would check during ci after creation
* agree to run bundle wide warn-only first

matter: confirm glossary style

3

* before, you wrote: "Recommendation: PROV-DM vocabulary for attribution semantics; ISO 704 for concept-definition structure; per-type description grammars as plain templates checked in Elixir (generalizing the glossary check); the LLM evaluator as a warn-only skill outside the gate suite. Bespoke only at the markup seam — where `<routes>` already sets the syntax precedent." - but here, W3C SKOS is listed as an "alternative" to ISO 704
* should we spec out creating a doc-side edge, derived?
* tempted to make all explicit, including LLM synthesized, even if just to timestamp and differentiate between synthesis from memory or synthesis from search, with sources.
* agreed that sounds challenging. this may lead to us formalizing expository structure to conform to even loosely checkable guarantees. may or may not be a good idea
* how do these definitions hold up in the face of the formal specs we are adopting? how are beliefs defined in them?

matter: settled

4
matter: confirm

5
agree with this. so, lets say you have a document at knowledge / SWE / agentic / supervision, and you have another document which should be tagged supervision. then, you search for all documents tagged supervision. do they both appear, even though, for reasons you described, item 1 should not in fact have a supervision tag (dupilcation)? if they both surface, should it be indicated in the results that one was tagged but one was surfaced because of the path?
matter: what do you recommend

6
what is Dublin Core? need qualification
matter: defer to your rec

7
matter: settled

8
matter: settled

9
confirm
confirm
matter: confirm

10
matter: settled

prop 1
2 - understood
3 - what ways might jido serve functionality for this repo? environment is pinned at 1.14 for basically no good reason, no deps means no reason we need to pin

a routine could be a jido routine actually as well. but i agree that ci most useful signal, imagine a scheduled routine possibly being a periodic background audit of the knowledge base

prop 2
understood re: shacl, approved by me

## Assistant

All checks done. One empirical finding up front: the Elixir pin is looser than it looked — `mix.exs` declares `elixir: "~> 1.14"`, which already permits everything up to 2.0; only the two CI workflow files hardcode `1.14`/OTP 25. So a toolchain bump is a four-line change plus the local runtime, with nothing in the codebase depending on the old version. That reshapes the Jido answer below.

---

### 1. Types as pure content-kinds

> what does "make types pure content-kinds" mean?

Every `type` currently mixes two independent axes:

- **Content-kind** — *what sort of utterance is this?* (a definition, a proposition, a captured artifact, a rule)
- **Epistemic status** — *how well established is it?* (unchecked, checked, held-as-prior)

`claim` is defined almost entirely on the status axis ("asserted but not independently verified"), `concept` straddles both ("a definition or mental model" = kind; "established/accepted" = status). That's why they collapse into each other under your reading: on the kind axis they're barely distinguished, and on the status axis they're two points on one line — so the type is doing the `verified` field's job.

"Pure content-kinds" means each type answers *only* the kind question, and status moves entirely into `verified`/`verified_by`. Concretely, the trichotomy — and this one has formal grounding, from doxastic/epistemic modal logic plus ISO 704:

| Type | Content-kind | Truth-apt? | Evidence obligation |
|---|---|---|---|
| `concept` | a definition — fixes what a term denotes | no (definitions are adequate or inadequate, not true or false) | none; judged by adequacy |
| `claim` | a proposition about the world | yes | yes — `verified_by` or `verified: false` |
| `belief` | a holder-indexed assertion (`B_operator φ`) | yes, but assertion is indexed to a holder, not to evidence | none by construction |

That gives you a formal definition of `belief` that the current vocabulary lacks: **not** "an unverifiable claim" (which is vague and invites bickering about what's verifiable), but *an assertion whose warrant is that a specified holder holds it*. The filing test becomes mechanical-ish: if removing "I hold that…" changes the sentence's warrant, it's a belief; if it doesn't, it's a claim.

Consequences: the graduation clause dies (a verified claim stays a `claim`, now with evidence); `concept` loses "established/accepted"; `em:712e01` is coherently a `concept` whose empirical entailments split out as claims.

**Matter: ratified — carries into plan 3 as the vocabulary change.**

### 2. Description regime

> agree to generalize the glossary regime bundle wide. one idea for formalizing the summary is to create a formal structure that an evaluator agent would check during ci after creation

That's exactly the two-tier split, and the phasing matters: the deterministic containment check ships first and gates; the evaluator checks the *grammar* (per-type structure — for `concept`, genus + differentia) in the advisory lane. Note one ordering subtlety in "check during CI after creation": CI sees a PR diff, so the natural scope is *changed documents only* for the advisory lane (cheap, attached to the introducing PR) with a full-corpus sweep on a schedule.

**Matter: glossary style confirmed** — description canonical, body expansion-only, containment-checked, bundle-wide warn-only first.

### 3. SKOS vs ISO 704, and the rest

> here, W3C SKOS is listed as an "alternative" to ISO 704

My phrasing was loose and you caught a real distinction. SKOS is not an alternative to ISO 704 — they sit at different layers, and the list I gave was "free ways to get at definition-craft guidance," which SKOS isn't:

- **ISO 704** governs *the prose inside a definition* — genus + differentia, substitution test, definition vs. description. It's the standard for the description-grammar work.
- **SKOS** governs *the concept scheme around definitions* — `prefLabel`/`altLabel`, `broader`/`narrower`/`related`, `scopeNote`, `definition` as a data field. It says nothing about how to write the definition text.

They compose: ISO 704 for the text, SKOS for typed edges between concepts *if* you ever want them (this bundle's edges are currently untyped prose links plus `verified_by`; SKOS would be the standard to reach for if that changes). My earlier recommendation stands unamended for ISO 704; SKOS is a *later, optional* layer, not a substitute. The genuinely free substitutes for ISO 704's content are the Pavel tutorial and SBVR.

> should we spec out creating a doc-side edge, derived?

Yes — and "derived" is the right constraint. Sketch: a `derived_from` (or extended `from`) frontmatter list on bundle docs, **materialized by `mix brain.route_tags --materialize`** from the same tags that already generate the excerpt log, and CI-checked for divergence exactly as the log is. That gives you the frontmatter-visible, machine-checked edge you wanted with zero new hand-maintained state and no shadow copy. Any origin *not* expressible as a route tag (a pre-capture conversation) stays in structured `provenance` instead.

> tempted to make all explicit, including LLM synthesized, even if just to timestamp and differentiate between synthesis from memory or synthesis from search, with sources.

This is well-founded, and it has a policy already saying so: assertions-name-their-basis requires exactly the memory-vs-checked distinction in *delivered responses* ("**checked** in this session — cite what was checked… or **recalled** from memory/training — mark it plainly"), and explicitly names its own gap: "This policy covers the remaining surface: ephemeral assertions in delivered responses." Your proposal closes that gap on the document surface. The memory/search split isn't bookkeeping — it's the same distinction, persisted.

The cost is annotation mass, and the fix is a **document-level default with span-level overrides**: frontmatter declares the default basis (`synthesis: {mode: search, sources: [...], at: <ts>}`), spans mark only where they *depart* from it. Explicit everywhere, marked only where it varies. Same idea as unmarked-equals-default, but it doesn't lose the timestamp or the sources.

> this may lead to us formalizing expository structure to conform to even loosely checkable guarantees. may or may not be a good idea

Hold that one loosely, and the repo has the counterweight already: `em:1eebdf` — "a spec that is sufficiently detailed to generate code with a reliable degree of quality is roughly the same length and detail as the code itself." Formalized exposition hits the same wall: constrain prose structure hard enough to make claims mechanically extractable, and you've written a controlled natural language whose authoring cost approaches the checking benefit. My read: formalize the *edges* (description grammar, span attribution) and leave the body's rhetorical structure free. Revisit only if span attribution turns out to be genuinely unworkable on living text without it.

> how do these definitions hold up in the face of the formal specs we are adopting? how are beliefs defined in them?

Directly: **none of them define belief.** Scoped — I'm speaking to ISO 704, SKOS, PROV-DM, and SBVR, from training knowledge, unchecked against the current texts:

- **ISO 704** has objects, concepts, definitions, designations. No truth-status axis whatsoever — a concept is a unit of knowledge, and the standard is silent on whether propositions about it are established. Our `concept` survives contact with it cleanly; `claim`/`belief` are simply outside its scope.
- **SKOS** has concepts, labels, notes, semantic relations. No status axis.
- **PROV-DM** models *how a statement came to be* (agent, activity, derivation), never *whether it's warranted*. It gives us the holder for a belief — `wasAttributedTo` the operator — but no belief construct.
- **SBVR** is the closest, and only partially: it has genuine modality — alethic (necessity) vs. deontic (obligation) — which maps well onto our `policy` (operative rule, deontic) and `doctrine` (guidance, weaker deontic). It has no doxastic modality, so `belief` is unserved there too.

So the honest position: adopt ISO 704 for definition structure and PROV for provenance, and recognize that the `claim`/`belief` axis is **this bundle's own contribution** — it's the sanctioned bespoke case under prefer-established-terminology ("the concept is genuinely novel to this bundle"). The doxastic-logic grounding in section 1 (`B_holder φ`) is the nearest formal anchor, and it's a citation rather than an adopted standard. This is worth writing down explicitly in plan 3, because "we checked four standards and none covers this axis" is exactly the negative finding that should name its scope rather than be silently re-derived later.

### 4. Structured provenance

**Matter: confirmed** — `provenance` splits into model / ref / note, with ref required whenever the origin has an in-repo address.

### 5. Tags — what a search should return

> lets say you have a document at knowledge / SWE / agentic / supervision, and you have another document which should be tagged supervision. then, you search for all documents tagged supervision. do they both appear... should it be indicated in the results that one was tagged but one was surfaced because of the path?

Both appear, and yes — label the basis. The two matches mean genuinely different things, and collapsing them throws away information the query surface should keep:

- **Path match** = this document is *canonically about* supervision; the taxonomy placed it there, and it's the one fact that can never go stale (moving the file updates the index for free).
- **Tag match** = this document *touches* supervision as a facet while living elsewhere in the tree — it's the cross-cutting edge the path structurally cannot express.

So `mix brain.tags supervision` returns both, grouped and labeled — path matches first (canonical), then tag matches (related), each row marked `[path]` or `[tag]`. Flags for the two narrow queries: `--path-only` (what's filed here) and `--tag-only` (what references this from elsewhere). And the disjointness lint is what makes the labels trustworthy: if a doc could carry both a `supervision` tag *and* a `supervision/` path, `[tag]` would silently mean "or maybe also path," and the distinction would rot within a month.

**Recommendation: store facets only; derive path matches at query time; label the basis in results; lint duplication as an error.** That's my rec on the matter you left to me.

### 6. Dublin Core

> what is Dublin Core? need qualification

From memory, unchecked: DCMI Metadata Terms — a metadata vocabulary originating from a 1995 workshop in Dublin, Ohio, standardized as **ISO 15836** and IETF RFC 5013. Its fifteen core elements (`title`, `creator`, `date`, `subject`, `description`, `source`…) are the most widely deployed descriptive-metadata vocabulary in existence: library catalogs, institutional repositories, RDF/schema.org lineage, and most static-site frontmatter conventions inherit from it. The relevant pair is `dcterms:created` and `dcterms:modified`, both dated, both meaning exactly what we mean.

Why it matters here beyond "it's standard": several fields this bundle already uses (`title`, `description`, `source`, `subject`≈`tags`) are *de facto* Dublin Core under different names, so aligning the date fields is joining a vocabulary we're already half-speaking rather than adopting a new one. It also sits cleanly beside PROV (W3C designed PROV to interoperate with DC) and beside SKOS.

**Matter: recommendation stands — `attribution.created` and top-level `modified`.**

### 7–8, 10

**Settled** as recorded.

### 9 / Prop 1 — the evaluator, and Jido

> what ways might jido serve functionality for this repo? environment is pinned at 1.14 for basically no good reason, no deps means no reason we need to pin

Confirmed on the pin: `mix.exs` says `~> 1.14` (permissive); only `.github/workflows/ci.yml` and `pages.yml` hardcode it. Nothing depends on the old version.

And that bump largely **dissolves the Jido question for this use case**, because modern OTP/Elixir ships what an LLM judge needs in the standard library: `:httpc` for the HTTP call (always has), and native JSON (OTP 27's `:json`, Elixir 1.18's `JSON`) for encode/decode. On 1.14/OTP 24, an evaluator would have needed Jason or Req — a dependency, breaking the zero-dep stance. On a current toolchain it needs **zero dependencies**, and the advisory CI lane preserves the ratified admission rule intact rather than carving an exception into it. That's a strong independent reason to bump.

What Jido would actually buy, honestly: supervised multi-step agent loops, signal routing, retry/rate-limit structure, and a scheduler. The evaluator needs one API call per key per doc with a schema-constrained response — none of that machinery. Where Jido *would* earn its keep is a different, later system: the always-on background auditor you describe, if it grows into a supervised long-running process with concurrency control and persistent state. Even then it's a dependency against a doctrine that currently forbids them, so it needs its own ratification — and notably, Jido would also be a natural substrate for prototyping the *normative record* ideas in `em:712e01` itself, which is a pleasing loop but not a reason to adopt it now.

> a routine could be a jido routine actually as well. but i agree that ci most useful signal, imagine a scheduled routine possibly being a periodic background audit of the knowledge base

Both, then, and they're complementary rather than competing: **CI advisory lane** scoped to the PR's changed docs (fast, attached to the change that introduced the violation), plus a **scheduled full-corpus audit** filing its report as a governance doc (catches corpus-wide drift and violations that predate the checks). Same mix task, two invocations, different scopes. The scheduled one can be a harness Routine today with no new infrastructure; whether it later becomes a Jido process is a decision that doesn't block anything now.

**Matter: confirmed** — advisory CI lane, plain mix task, toolchain bump, Jido deferred with its trigger named.

---

## Matters ledger

| # | Matter | Disposition |
|---|---|---|
| 1 | Types = pure content-kinds; `concept`/`claim`/`belief` trichotomy; graduation clause dropped | **Ratified** → plan 3 |
| 2 | Glossary description regime bundle-wide, warn-only first; evaluator checks grammar in advisory lane | **Confirmed** |
| 3a | ISO 704 for definition prose; SKOS is a later optional edge layer, not a substitute | **Settled** |
| 3b | `derived_from` doc-side edge, materialized from route tags, CI-checked | **Settled** → spec in plan 2 |
| 3c | Explicit synthesis basis (memory/search + sources + timestamp): doc-level default, span-level overrides | **Settled** → plan 2 |
| 3d | No formalized expository structure beyond the edges; `em:1eebdf` is the counterweight | **Settled** (revisit only if span attribution forces it) |
| 3e | No adopted standard defines `belief`; the axis is this bundle's own, doxastic-logic-anchored | **Settled** — record as a scoped negative finding in plan 3 |
| 4 | `provenance` → model / ref / note; ref required when resolvable | **Confirmed** |
| 5 | Facets-only storage, path union at query time, `[path]`/`[tag]` labeling, duplication lint | **Recommended** — awaiting your yes |
| 6 | Dublin Core `created`/`modified` | **Confirmed** (deferred to rec) |
| 7 | Renames land in plan 3 | **Settled** |
| 8 | `agent` = model+harness; add `activity`; fold `channel`; PROV naming | **Settled** |
| 9 | Advisory CI lane + scheduled full-corpus audit; toolchain bump; Jido deferred | **Confirmed** |
| 10 | PROV-DM vocabulary adopted; SHACL stays declined | **Settled** |

Row 5 is the only one still open. Everything else is ready to flow into the 1/4 pilot and the two plans — say the word and I'll start with the pilot (the deterministic checks plus fixing `em:712e01` as their first test case), or draft the plans first if you'd rather ratify the shape before any code lands.

## User

yes begin with the plans first, then commit
i have fable as the model, is that the best model for the plans, opus for the coding?

## Assistant

Committed and pushed — the full gate suite ran clean in the pre-commit hook (193 tests, all generated artifacts fresh).

### Orientation

The program we worked out over the last several turns is now persisted as durable design records, not just conversation. Two new plans capture the two proposals you opened with — one for attributing every piece of text in a document to where it came from, one for giving every metadata field a formal, checkable definition. And because two older plans were already carrying pieces of these matters as open questions, the decisions we reached landed *in those plans* rather than being duplicated: the type-vocabulary resolution went into the concept-terminology plan, and the tags decision went into the tag-governance plan. Everything is on the session branch, gates green.

On your model question: **this session is running claude-opus-5, not Fable** — so if you selected Fable for planning, that's not what executed here. Your instinct is right by the repo's own capability-matched-model-selection doctrine: strongest model where the output *is* the judgment (plans, design, vocabulary decisions), Opus-tier where deterministic gates supply the oracle (the coding phases). But for *these* plans I'd let it stand rather than re-run under Fable: plan-vs-capture's discriminator is context-transfer, and this session holds every ratified decision — a fresh Fable session would be re-deriving from the thread record, which is the exact failure mode plans exist to prevent. A Fable *review* pass over the two plan docs is the cheap way to get the stronger tier's judgment without re-derivation, if you want it. One consequence of the model identity: the plans' `provenance` reads `model undisclosed`, which is the model-attribution policy's prescribed value for an environment that withholds the identifier from committed artifacts — chat is the sanctioned disclosure surface, and this is it.

One recording decision you can reverse: matter 5 (tags) was formally still "awaiting your yes" — you'd asked for my recommendation and then said proceed with the plans, so I recorded the facets-only design as ratified 2026-08-01 in tag-governance. If you didn't intend that as acceptance, it's a one-edit rollback.

**What I created**

| type | doc | why this type |
|---|---|---|
| plan | span-level-attribution | proposal 2's design decisions (8 ratified decisions, 4 phases) must survive this session — cold-context handoff case |
| plan | schema-formalization-and-evaluator-lane | proposal 1's design (10 decisions, 5 phases, incl. the advisory-lane doctrine amendment and the scoped belief negative finding) |

**What I modified**

| file | thrust of the change |
|---|---|
| concept-terminology-and-type-redefinition | added the ratified resolution to its Part-2 open questions (content-kinds table, belief's formal definition, graduation dropped); status → `accepted` |
| tag-governance | added the 2026-08-01 refinement answering its epistemic question (facets-only, query-time path union, `[path]`/`[tag]` labels, disjointness lint) |
| meta/plans/index.md | two new entries; concept-terminology moved Proposed → Accepted; tag-governance gloss refreshed |

**Actions I have taken**

| action | result |
|---|---|
| `mix brain.verify`, `route_tags`, `contract --check`, `registry --check` | all pass; the two new plans' missing `attribution.from` is the expected advisory warn until `/create-pull-request` stamps the thread |
| commit `db44f6a` + push | on `claude/reddit-agent-reconciliation-analysis-9pnily`; pre-commit hook ran the full suite (format, xref, contract, registry, codemap, verify, route_tags, glossary, lineage, 193 tests) — all green |

**Your options from here**

| # | option | what it entails |
|---|---|---|
| 1 | Start the pilot (phase 1 of the schema plan) | bundle-wide containment check warn-only + violation census, and the `em:712e01` fixes as the worked test case — deterministic only, in this session or a fresh Opus one |
| 2 | `/create-pull-request` | capture the thread, stamp `attribution.from` on all four plan docs, open the PR — closes this session's record cleanly first |
| 3 | Fable review pass | a Fable session reads the two new plans and flags judgment-level gaps before any execution |

My recommendation: 2 first (the thread capture is what the plans' `from` stamps are waiting on), then 1 in a fresh session executing against the persisted plans.

## User

are you fable now?

## Assistant

No — this session is still running `claude-opus-5`. A session's model is fixed at start; switching to Fable means starting a new session with Fable selected (or resuming this conversation there). Last turn's report and both plan docs were authored under Opus 5, which is why their `provenance` reads `model undisclosed` per the policy's carve-out for this environment.

If you want Fable on this work, the clean move is option 3 from last turn: close this session's record first (`/create-pull-request`), then open a Fable session pointed at the two plan docs for a review pass — it gets the stronger tier's judgment on the persisted decisions without re-deriving them from a thread it didn't live through.

## User

ok, i just changed to fable again. is it still opus? this implies that the model cannot be changed mid conversation and the ui is deceptive

## Assistant

Yes — this reply is running as `claude-fable-5`. The system reminder that accompanied your `/model` command confirms the switch took effect, so two corrections are owed:

1. **My last-turn claim was wrong.** I said the model is fixed at session start — that was asserted from memory, and the harness just falsified it: `/model` does change the model mid-conversation. The UI is not deceptive.
2. **What was true at the time:** the turns before your switch — including both plan documents and the analysis — were generated under `claude-opus-5`, which is what my configuration stated when you asked. So "is it still opus?" was answered correctly *then*; it stopped being correct the moment your `/model claude-fable-5` took effect.

The practical consequence: the conversation is now model-heterogeneous — Opus 5 authored everything committed so far, Fable 5 generates from here. The plans' `provenance: model undisclosed` remains accurate for what's committed (and the environment's disclosure constraint still applies to anything I commit going forward, regardless of tier). If you want the Fable review pass over the two plan docs, this session can now do it directly — no second session needed, and it has the full context of the dialogue that produced them, which is strictly better than the cold-read I proposed earlier.

## User

ok, proceed with first a review of the conversation, seeing if there is anything that should be caught or changed, indicate those and then review the plans with any catches in mind. prioritize your perspective over the existing plan's, feel free to overrule

## Assistant

All review findings are applied, committed (`d337525`), and pushed — gates green. Here's the full report.

### Orientation

You asked for a fresh-eyes pass over everything this conversation produced, with license to overrule. The verdict: the program's architecture holds up — the layered attribution model, the three-tier checking, the standards adoptions all survive scrutiny. But the detailed schema design that Opus ratified contained one structural mistake (curing metadata sprawl by adding a fourth metadata block), two regressions it didn't notice (destroying a machine-queried field; duplicating the model field), one factual error baked into a worked example (provably wrong against this repo's own git history), and two consequences of the vocabulary change that were never drawn and would have surfaced as surprises mid-execution. I fixed all of these in the plans directly. Because several fixes reverse things you ratified, each is marked in the plan text as a review-pass revision — every one is a single edit to veto.

### Conversation-level catches

**Catch 1 — the redesign was reproducing the disease it treats (fixed).** The ratified schema had *four* origin structures: `provenance` (model/ref/note), a new `synthesis` block (mode/sources/at), `attribution`, and `derived_from`. The conversation's founding complaint was that `provenance`/`attribution`/`resource` already confuse origin metadata across three homes — and the cure added a fourth. Overruled: `synthesis` folds into `provenance`, which becomes the single default-basis structure (`mode`/`ref`/`sources`/`note`). Bonus simplification: `synthesis.at` was redundant with `attribution.created` — one less timestamp to drift.

**Catch 2 — folding `channel` into `activity` was a regression (fixed).** The ratified D6 demoted `channel` to the leading token of a free-text string. But `channel` is machine-queried today: the escape-rate plan's entire ground-truth oracle keys on `channel: auto-intake`, and the backfill and `mix brain.attribution` filter on it. Free text can't be filtered reliably. Overruled: `channel` stays a controlled key.

**Catch 3 — the model field had two homes (fixed).** `provenance.model` and a model-bearing `attribution.agent` side by side is one fact in two fields — the exact "field that reads three ways cannot be grepped" defect the model-attribution policy warns about. Overruled: single home in `attribution.agent`; the policy gets amended in phase 1; an origin model *distinct from the filer* goes in `provenance.note`.

**Catch 4 — the worked example discarded recorded evidence (fixed, and checked).** The span plan's migration example stamped `model undisclosed` onto `em:712e01`. I checked: its filing commit `818a885` carries `Co-Authored-By: Claude Fable 5` in the trailer. The migration must *recover* models from trailers (as the attribution backfill already does) and write `model undisclosed` only where no trailer exists. The example now shows the recovered value and states the rule.

**Catch 5 — the vocabulary resolution left `note` unruled and a contradiction undrawn (fixed).** The trichotomy covered `concept`/`claim`/`belief` and skipped the fourth statement type entirely. Worse: if `concept` is not truth-apt, then `verified` must become *illegal* on it — otherwise the resolution renames the incoherence instead of curing it — which also means a mechanical sweep removing `verified: false` from ~234 glossary entries. Both are now in the resolution: statement types narrow to `claim`/`note`, and `note` is ruled truth-apt (the claim/note boundary is assertoric strength, not kind).

**Catch 6 — a dead recommendation was left standing (fixed).** Early in the conversation I proposed flipping `em:712e01` to `verified: true` by capturing EU AI Act text as sources. The trichotomy ratified later kills that path — `verified` gets *removed* from the doc, and its empirical entailments file as claims. The schema plan's pilot now says so explicitly, so no future session executes the superseded advice.

**Catches with no plan change needed:** my "model is fixed at session start" error (already retracted); the "four-line toolchain change" understatement (already corrected against the toolchain plan); the D6 negative finding about doxastic modality rests on training knowledge — it's honestly scoped as such in the plan, and verifying it against the actual standard texts is exactly what the ISO 704 capture in D4 will do.

### Plan-level review — remaining changes

- **Quote verification would have failed on legitimate quotes.** D7's containment check now specifies whitespace normalization and elision-awareness — quote-primary-sources *sanctions* marked `…` elisions, and a naive substring check fails every one.
- **Span survival is now ruled, not open.** Content-hash anchors with the verifier failing on drift; manual re-marking rejected on the bundle's own prior (a surface that must be remembered will be forgotten). Leaving both options open was deferring a decision the repo's beliefs already make.
- **Cross-plan ordering was missing.** Span phase 1 (schema realignment) must land before the schema plan's phase 2 (definition blocks), or every block formalizes an outgoing schema. Both plans now state it.
- **Phase-1 scope is now named honestly:** `timestamp` → `modified` touches every document — the widest sweep since the id migration, to be executed verifier-atomically on that pattern. The ratified draft called it "policy edits + sweep."

What I examined and left standing: the PROV class mapping, exception-marking over a declared default, derived-`from` via route-tag materialization, the advisory-lane doctrine shape, the ISO 704/PDF posture, the tags refinement (one small addition: namespace roots like `knowledge` are excluded from the implicit query union — a tag every document matches retrieves nothing), and the belief formal definition.

**What I modified**

| file | thrust of the change |
|---|---|
| span-level-attribution | catches 1–4 (D3/D5/D6 rewritten, worked example corrected with trailer evidence), elision-aware D7, span-anchoring ruling, cross-plan ordering, phase-1 scope |
| concept-terminology-and-type-redefinition | catch 5: `note` row added, statement-types narrowing + glossary sweep drawn into the resolution and execution scope |
| schema-formalization-and-evaluator-lane | catch 6 (pilot's `verified` disposition), cross-plan ordering in D2 |
| tag-governance / index.md | namespace-root exclusion clause; both revised glosses |

**Actions I have taken**

| action | result |
|---|---|
| trailer check on `em:712e01`'s filing commit | `Claude Fable 5` recorded — catch 4 confirmed against evidence |
| gates + commit `d337525` + push | full pre-commit suite green (193 tests); branch updated |

The plans now carry the reviewed design. Next step remains as agreed: `/create-pull-request` to close this session's record and stamp `attribution.from`, then the pilot in a fresh session.
