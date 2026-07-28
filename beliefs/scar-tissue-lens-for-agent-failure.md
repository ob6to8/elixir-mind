---
id: em:f35b8f
type: belief
title: The scar-tissue lens is the right frame for reasoning about agent failure modes
description: The operator's adopted working frame — long-running agent failure is best understood as trauma-like accumulation of adaptive local fixes into maladaptive standing behavior — chosen over rival frames (software entropy, local minima) that fit the same facts, so the choice guides design priorities without being settled by evidence.
provenance: "Operator-held prior, affirmed 2026-07-27; surfaced in the analogy-decomposition exchange of the scar-tissue session"
tags: [belief, agentic, drift, framing, reliability]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: intake
  agent: "Claude Code agent, scar-tissue session follow-up — operator-directed belief filing"
  why: "operator directed filing the lens-adoption prior the defenses analysis identified as genuinely belief-shaped, once the belief type's arrival on main made it filable"
---

# The scar-tissue lens is the right frame for reasoning about agent failure modes

The belief, in the operator's verbatim words from the
[originating session](/meta/threads/2026-07-27-scar-tissue-drift-doctrine-and-link-policy.md):

> "I will act as if the analogy to scar tissue is appropriate for this failure
> mode."

Held as a prior because frame choice is not settled by evidence: the same
facts about long-running agent drift support rival lenses — the source post's
own comment thread offers *software entropy* and *error-minimizers stuck in
local minima* for the identical phenomenon — and choosing among
extensionally-equivalent frames is a value-laden commitment that guides
action. Under this frame, the countermeasures that matter are the ones that
treat adaptation as the risk surface: receipts binding each behavior change
to its trigger, a frozen baseline the drift cannot corrupt, and
[fingerprints](/beliefs/glossary/behavioral-fingerprinting.md) watching the
distribution — which is why the
[bound-adaptation doctrine](/meta/doctrine/bound-adaptation.md) reads as this
belief's governance-side consequence. The frame's *fit*, by contrast, is
epistemic and case-checkable; the
[defenses analysis](/meta/analysis/scar-tissue-drift-defenses-and-persistence.md)
records that decomposition (lexical fact / aptness claim / lens adoption),
and the [glossary entry](/beliefs/glossary/scar-tissue.md) holds the term
itself.

# Citations

- [Scar-tissue capture](/knowledge/SWE/agentic/agentic-loop/scar-tissue-behavioral-drift-in-long-running-agents.md)
  (`em:60242a`) — the source material the lens was adopted from.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:f35b8f">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-27-scar-tissue-drift-doctrine-and-link-policy (2026-07-27)

3 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:f35b8f`]**  (co-feeds: `em:1434d9`)

file the lens-adoption prior
ratify the plans
approve the fingerprint rider
yes flip to ratification-immutable
yes link policy

---

**[`em:f35b8f`]**

All five ratifications executed, full gate suite green (pre-commit ran everything: format, xref, contract/registry/code-map checks, verify, route tags, glossary, lineage, dev-history, 183 tests), committed and pushed. Since PR #147 merged and its branch was deleted, this work sits on the **restarted** `claude/code-cleanliness-trust-dkff57` (rebuilt from latest `main`) — a PR from it will be a new one; say `/create-pull-request` (or `merge`) when you want it opened.

**What I created**

| type | doc | why this type |
|---|---|---|
| belief | [scar-tissue-lens-for-agent-failure](https://github.com/ob6to8/elixir-mind/blob/claude/code-cleanliness-trust-dkff57/beliefs/scar-tissue-lens-for-agent-failure.md) (`em:f35b8f`) | your verbatim "I will act as if…" phrase quoted as the seed, per the quote-primary-sources rule; frame choice is value-laden, so `belief`, with the aptness/lexical halves left where the analysis filed them |

---

**[`em:f35b8f`]**  (co-feeds: `meta/analysis/is-to-ought-belief-grounds-doctrine.md`)

**The tension turned out to be apparent, not real — and the reason is worth having on record.** The analysis rejected a `belief` type on collision grounds: *"the descriptive work is already covered by `claim`/`note`/`concept`, so a `belief` type would collide with them."* That objection was correct and still is. But the type that shipped isn't descriptive — it's a value-laden decision prior that *"stays outside the verification ladder"*, with the rule that one turning out empirically checkable is refiled as a `claim`. That refile rule **is** the analysis's collision-avoidance, made mechanical: anything that would collide with `claim` is by definition not a `belief`. So the analysis rejected a descriptive belief type; the bundle adopted a value-laden one; both stand.

What the original genuinely missed is a *third* register. Its two columns were "checkable fact" and "direction for the brain" — and the seed beliefs fit neither: Dex Horthy's spec-length thesis isn't a checkable claim about this brain, nor a direction the brain serves; it's a prior that bounds how plans get written. The corrected stack in the update puts belief **parallel to** doctrine (four tiers: statement / belief / doctrine / policy), not as a relabeling of the descriptive tier.

Crucially, **the is-to-ought bridge itself is untouched** — the move from premise to direction works the same whether the premise is a verifiable `claim` or an unverifiable `belief`. All that changed is that the premise now has two possible homes, split by whether evidence could settle it.

Two judgment calls in how I made the edit:

- **I marked the superseded passages rather than rewriting them.** An `analysis` is historical by construction — a point-in-time judgment — so silently editing its conclusion would destroy the record of what was actually thought on 2026-07-22. The old tier table and the "not a controlled type" paragraph stay as written, with a blockquote pointing to the update; the reconciliation lives in a dated section at the end.
- **I added a back-link from the beliefs index**, since the layer's own docs cited the plan but not the analysis — the reconciliation was only discoverable from the analysis side.
