---
type: reference
title: 2026-07-28-kimi-k3-weight-release-implications
description: Intake of the Kimi K3 model card with an implications analysis, split into a machine-learning reference and an ai-industry claim that the open frontier has stopped being a price weapon, plus ten glossary terms.
provenance: "Claude Code session (Claude Opus 5), 2026-07-28; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, kimi, open-weights, ai-economics, licensing, intake, glossary]
timestamp: 2026-07-28
pr: 157
session: https://claude.ai/code/session_01PNFB6CSofNa3rBnNwPVp2D
---

# 2026-07-28-kimi-k3-weight-release-implications

## Where this landed

The operator asked what Moonshot's Kimi K3 weight release implies, asked for the
Hugging Face model card to be intaken, and asked that the analysis be attached to
the intake doc. Ten sources were fetched and cross-checked — the model card, the
LICENSE file, Artificial Analysis, Interconnects, the-decoder, Kili, techi.

The load-bearing finding is a pricing inversion: the leading open-weight model
now prices at Claude Sonnet 5 parity ($3/$15 per MTok, 3–4× its own predecessor),
which cuts against the margin-collapse thesis already filed as `em:07610c`. On
the operator's direction the analysis was then split — the model-level capture
stayed as a `reference` under `machine-learning/`, and the economic argument
moved to a `claim` under `ai-industry/` that revises the earlier thesis, with a
forward pointer added to it. A factual error was corrected in passing: the
landscape doc `em:28fac6` recorded K3's license as "unrestricted download" when
it is revenue-tiered and classified "Commercial Use Restricted".

Ten glossary terms were then added, and that work landed as PR 157.

The session continued past that merge through two follow-ups, landing in a second
PR. First, `em:51aede` was **grounded**: five `type: source` captures under
[`knowledge/ai-industry/sources/`](/knowledge/ai-industry/sources/index.md) —
Moonshot's own K3 and K2.6 pricing pages, Artificial Analysis's index and
AA-Briefcase articles, and the LICENSE file — wired through `verified_by` to flip
the claim to `verified: true`. These are the bundle's first real primary-source
captures; the grounding pass also caught two figures asserted beyond what the
sources stated, both corrected. Second, `mix brain.dev_history` was regenerated
from an unshallowed clone, clearing a lag that had reached six PRs rather than
the one the design tolerates.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Kimi K3 model card — architecture, benchmarks, license, deployment | closed | [kimi-k3](/knowledge/machine-learning/kimi-k3.md) | - |
| The pricing inversion and what it does to the margin-collapse thesis | open | [open-weights-stopped-being-a-price-weapon](/knowledge/ai-industry/open-weights-stopped-being-a-price-weapon.md) | whether Moonshot's premium pricing holds, or a competitor takes the top open slot at DeepSeek-tier pricing and restores the undercut mechanism |
| Grounding the claim on primary sources — the bundle's first `type: source` captures | closed | [sources](/knowledge/ai-industry/sources/index.md) | - |
| Dev-history regeneration and the size of the accumulated lag | paused | `unrouted` | the lag reached six PRs against a design that tolerates one — whether that is shallow-clone sessions failing the step silently, or the step being skipped, is undiagnosed |
| License-column error in the open-weight landscape snapshot | closed | [open-weight-frontier-models-mid-2026](/knowledge/machine-learning/open-weight-frontier-models-mid-2026.md) | - |
| Terminology introduced by the release (MXFP4, QAT, KDA, MaaS, revenue tiers) | closed | [glossary](/beliefs/glossary/index.md) | - |

## User

what are the implications of kimi k3 releasing its weights?
/intake https://huggingface.co/moonshotai/Kimi-K3
attach your analysis to the intake doc

## Assistant

<routes ref="em:68d1b3">
## The implications

Seven, in rough order of how much they should change your priors.

**The open-to-closed gap is now months.** K3 scores 57 on the AA Intelligence Index — third overall, comparable to Opus 4.8 and GPT-5.5, behind only Fable 5 and GPT-5.6 Sol — and 1543 Elo on AA-Briefcase, second only to Fable 5 and *above* Opus 4.8 (1347). Lambert's read: "the open-to-closed or American-to-Chinese model performance gap has been reduced from the debated 6-9 months to something shorter, say 3-5 months."
</routes>

<routes ref="em:51aede">
**Open no longer implies cheap — and that inverts the margin-collapse thesis.** This is the finding I'd flag hardest, because it cuts against what's already in the brain. K3's API prices at **$3.00/$15.00 per MTok — exactly Claude Sonnet 5** — versus K2.6's $0.95/$4.00. On AA-Briefcase it costs $10.57/task and 56.4 min/task, ~2.5× Fable 5's wall-clock. [Alderson's margin-collapse argument](https://github.com/ob6to8/elixir-mind/blob/main/knowledge/ai-industry/ai-margin-collapse-glm-5-2.md) rested on open models matching frontier quality "at a fraction of the price"; K3 matches the quality and declines the discount. The pressure on closed-lab margins becomes a *floor* effect — a credible fallback exists — not the price collapse the thesis predicted.
</routes>

<routes ref="em:68d1b3">
**"Open weights" and "self-hostable" have fully separated.** 1.4TB in MXFP4 → ~18× 80GB accelerators just to load. An 8-card Blackwell node (1.5TB) "barely fits the weights with almost nothing to spare." The beneficiaries are inference providers and clouds, not individuals. For your own sizing decisions this changes nothing — the runnable frontier is still 7B–120B.
</routes>

<routes ref="em:51aede">
**The license is aimed at the intermediaries.** MaaS businesses over $20M/12mo need a separate agreement with Moonshot; products over 100M MAU or $20M/month must display "Kimi K3" branding. Internal use and certified-partner access are exempt. Artificial Analysis labels it "Commercial Use Restricted." This is Meta's 700M-MAU clause generalized into a revenue tier — give the weights away, monetize whoever resells serving them. Expect imitation, and note that "open-weight" now spans a license spectrum wide enough to carry no legal information on its own.
</routes>

<routes ref="em:51aede">
**Downloadable weights resolve the data-residency objection.** The standing enterprise counterargument to Chinese frontier models is that inference runs in the wrong jurisdiction. Weights you can run in your own answer that, and the internal-use exemption means the license doesn't bite. A compliance blocker becomes a hardware-budget problem.
</routes>

<routes ref="em:68d1b3">
**The architecture disclosure probably outlasts the weights.** KDA, Attention Residuals, Stable LatentMoE, and MXFP4 QAT-from-the-SFT-stage are now public — and per Lambert the ~2.5× scaling-efficiency gain came with "orders of magnitude less capital." Weights depreciate in months; a demonstrated efficiency technique propagates into everyone's next training run.

**Read the score and the reliability separately.** K3 climbed the leaderboard while its AA-Omniscience hallucination rate went 39% → 51% of non-correct responses, even as accuracy rose 33% → 46%.
</routes>

<routes ref="em:51aede">
**The open question I'd leave standing:** whether an *expensive* open model exerts the same pressure a cheap one does. If Moonshot's pricing holds and other Chinese labs follow it up, the open frontier stops being a price weapon and becomes an optionality guarantee — worth a lot for lock-in insurance and jurisdictional control, far less corrosive to closed-lab economics.
</routes>

<routes ref="em:28fac6">
One correction to the brain: [`em:28fac6`](https://github.com/ob6to8/elixir-mind/blob/claude/kimi-k3-weights-analysis-c9oqxn/knowledge/machine-learning/open-weight-frontier-models-mid-2026.md) recorded K3's license as "unrestricted download," sitting in a column next to Apache 2.0 and MIT. The download is unrestricted; the license is not. Fixed.
</routes>

### What I created

| type | doc | why this type |
|---|---|---|
| `reference` | [`em:68d1b3` — Kimi K3](https://github.com/ob6to8/elixir-mind/blob/claude/kimi-k3-weights-analysis-c9oqxn/knowledge/machine-learning/kimi-k3.md) (`knowledge/machine-learning/kimi-k3.md`) | external material captured and distilled from the model card; the analysis is attached as an `## Implications` section, marked agent-authored, per your instruction |

### What I modified

| file | thrust of the change |
|---|---|
| `knowledge/machine-learning/open-weight-frontier-models-mid-2026.md` | corrected the K3 license cell to "revenue-tiered, Commercial Use Restricted"; replaced the vendor-reported ranking with the AA index number; linked out to the new doc |
| `knowledge/machine-learning/index.md` | listed the new reference |
| `meta/registry.md` | regenerated |
| `meta/evals/dedup-probe.md` | harvested your phrasing as a gold row; refreshed baseline |

### Actions I have taken

| action | result |
|---|---|
| Fetched and cross-checked 10 sources (model card, LICENSE, AA, Interconnects, the-decoder, Kili, techi) | one discrepancy found and resolved: an AA tweet says 2.6T, the card and every later AA article say 2.8T — filed as 2.8T |
| `mix brain.id` / `brain.registry` / `brain.verify` | id `em:68d1b3` minted, registry compiled, bundle verifies |
| `mix brain.dedup_probe --update-baseline` | plain 6/17, expanded 16/17 — no regression |
| Full pre-commit gate suite + `mix test` | all pass; 183 tests, 0 failures |
| Committed and pushed | `f5c33a1` on `claude/kimi-k3-weights-analysis-c9oqxn` |

### Your options from here

| # | option | what it entails |
|---|---|---|
| 1 | `/create-pull-request` | captures the session, glossaries it, stamps attribution, opens the PR |
| 2 | Split the implications into `knowledge/ai-industry/` | the pricing-inversion argument is arguably industry-economics knowledge in its own right, and would sit beside `em:07610c`; I kept it attached as you asked |
| 3 | Glossary the new terms | KDA, MXFP4, QAT, and Attention Residuals aren't in `/beliefs/glossary/` yet — `/add-to-glossary` on this doc would file them |

## User

2, 3, then 1 and merge

## Assistant

All three landed. [PR #157](https://github.com/ob6to8/elixir-mind/pull/157) merged as `b4301dc`, head branch auto-deleted.

<routes ref="em:51aede">
On the split itself: separating the two docs sharpened the argument rather than just relocating it. Attached to the model card, the pricing observation read as a footnote about K3; standing on its own beside `em:07610c` it has to answer the thesis it contradicts, which forced the *floor effect vs. price collapse* distinction into the open and surfaced the jurisdictional-control channel the price framing had been hiding. The claim now carries a falsification condition — the next Chinese frontier release's price sheet — so it can be revisited rather than quietly aging.

One judgment call worth flagging: I typed it `claim` rather than `note`, which puts it on the verification ladder at `verified: false`. Grounding it later means capturing the pricing pages and AA figures as `source` documents and wiring `verified_by`. That's real work and I didn't do it — the numbers currently rest on secondary reporting, not primary captures.
</routes>

### What I created

| type | doc | why this type |
|---|---|---|
| `claim` | [`em:51aede` — Open weights stopped being a price weapon](https://github.com/ob6to8/elixir-mind/blob/main/knowledge/ai-industry/open-weights-stopped-being-a-price-weapon.md) | an asserted, not-yet-grounded statement about the industry — on the verification ladder, unlike a `note` |
| `concept` ×10 | glossary terms — MXFP4, QAT, KDA, attention residuals, MLA, AA Intelligence Index, hallucination, MaaS, revenue-tiered license, data residency | MLA is a **pointer entry** deferring to the KV-cache compression history rather than a second definition |
| `reference` | thread doc | the session record, `pr: 157` |

### Actions I have taken

| action | result |
|---|---|
| Split, glossary pass, `/capture`, `/add-to-glossary`, `from` stamping | all landed in one PR |
| Route tags materialized into 3 sinks | 349 regions, 115 sink appends, fidelity re-derivable |
| Gate suite, twice, plus CI | green — 183 tests, both `verify` jobs success |
| Merged | true merge commit `b4301dc`; branch deleted |

**Not done:** `mix brain.dev_history` could not run — the session's clone is shallow, so `meta/dev-history.md` is one PR further behind than usual. CI skips its check for the same reason.

### Your options from here

| # | option | what it entails |
|---|---|---|
| 1 | Ground `em:51aede` | capture Moonshot's pricing page and the AA figures as `type: source` docs, wire `verified_by`, flip to `verified: true` |
| 2 | Regenerate dev-history from a full clone | a one-command session that clears the accumulated lag |
| 3 | Add K3's price sheet to the channels register | make "watch the next Chinese frontier release's pricing" an actual monitored source rather than a note in a claim |

## Assistant

That was the CI wait timer finishing — it's already served its purpose. CI went green before it elapsed, and PR #157 is merged.

Nothing further pending. The three options from my last message are still open whenever you want to pick one up.

## User

1, 2
then /create-pull-request merge

## Assistant

<routes ref="em:51aede">
The grounding pass did what grounding passes are for: it caught two figures I had asserted more confidently than the sources supported. I had written that K3 runs *"~2.5× Fable 5's wall-clock"* on AA-Briefcase and that Fable 5 finishes in 67 turns to K3's 83 — both came from a summarizing fetch, and neither survived re-reading the article for verbatim text. The article states K3's 56.4 minutes and 83 turns; it does not state Fable 5's comparative figures in the passages I could quote. Both are now gone, replaced by what Artificial Analysis actually says — including its own blunt summary, which is better evidence than my paraphrase was: K3 is *"particularly expensive when comparing to other open weight models of similar size. It's also notably slow and very verbose."*

The DeepSeek V4 Pro $0.04-per-task figure survives, but attributed: it comes from the-decoder, not from Artificial Analysis, and secondary reporting does not belong in a `source` capture backing `verified: true`. It now reads as reported rather than as established.
</routes>

*(the closing report of this turn was delivered after this section was written;
the follow-up PR is named in the narrative above.)*
