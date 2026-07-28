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

The session continued past that merge through two follow-ups, landing in PR 159
(`pr:` stays at its origin, 157, per the write-once rule). First, `em:51aede` was
**grounded**: five `type: source` captures under
[`knowledge/ai-industry/sources/`](/knowledge/ai-industry/sources/index.md) —
Moonshot's own K3 and K2.6 pricing pages, Artificial Analysis's index and
AA-Briefcase articles, and the LICENSE file — wired through `verified_by` to flip
the claim to `verified: true`. These are the bundle's first real primary-source
captures; the grounding pass also caught two figures asserted beyond what the
sources stated, both corrected. Second, `mix brain.dev_history` was regenerated
from an unshallowed clone, clearing a lag that had reached six PRs rather than
the one the design tolerates.

A third round then turned the grounding pass's own lesson into artifacts. The
fetch-synthesis failure it caught — a summarizing fetch asserting a comparison
its source never states — became a
[`quote-primary-sources`](/meta/policy/quote-primary-sources.md) rule (take the
quote from the source's text, never from a summary of it) and the
[fetch fidelity probe](/meta/evals/fetch-fidelity-probe.md) that measures whether
that rule does anything, seeded with the observed instance and carrying a
falsification condition that would revert the rule. The dev-history cause was
filed as a [todo](/meta/todos/diagnose-the-dev-history-regeneration-lag.md)
rather than diagnosed, with the shallow-clone silent-skip recorded explicitly as
a hypothesis. That round landed in PR 160.

Two further rounds followed. The probe's build was persisted as a
[structured plan](/meta/plans/build-the-fetch-fidelity-probe.md) — its
load-bearing decision being the split at the network boundary, so the scorer
stays offline and a metric revision can be told apart from a vendor model change
— and the operator ratified that a `proposed` eval backlog is the intended state
rather than a debt to clear, recorded in
[the evals index](/meta/evals/index.md) so no future session proposes a pruning
sweep. Then the dev-history hypothesis was **tested and confirmed**: across the
18 PRs since the regeneration step existed, the outcome clusters perfectly by
session rather than by PR, and the one session that flipped mid-flight did so
exactly when it unshallowed — ruling out sporadic agent-skip as the dominant
cause. An earlier count that included merge commits produced two false positives
and was corrected before the finding was written. The todo closed to
[an issue](/meta/issues/dev-history-regeneration-silently-skipped-on-shallow-clones.md)
carrying the evidence and three candidate fixes, none chosen. Both of those
rounds landed together in PR 164 — the plan round was committed and pushed
without a PR of its own, since the operator had not asked for one, and the
diagnosis round opened the PR over both. `pr:` stays at its origin, 157.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Kimi K3 model card — architecture, benchmarks, license, deployment | closed | [kimi-k3](/knowledge/machine-learning/kimi-k3.md) | - |
| The pricing inversion and what it does to the margin-collapse thesis | open | [open-weights-stopped-being-a-price-weapon](/knowledge/ai-industry/open-weights-stopped-being-a-price-weapon.md) | whether Moonshot's premium pricing holds, or a competitor takes the top open slot at DeepSeek-tier pricing and restores the undercut mechanism |
| Grounding the claim on primary sources — the bundle's first `type: source` captures | closed | [sources](/knowledge/ai-industry/sources/index.md) | - |
| Dev-history regeneration — the lag, then its diagnosis | closed | [dev-history-regeneration-silently-skipped-on-shallow-clones](/meta/issues/dev-history-regeneration-silently-skipped-on-shallow-clones.md) | - |
| Which of the three candidate fixes to adopt for the silent skip | paused | `unrouted` | loud skip, unshallow in `/create-pull-request` step 4, or regenerate outside the session — recommendation is 1+2 composed, but the choice is the operator's |
| Building the fetch fidelity probe | paused | [build-the-fetch-fidelity-probe](/meta/plans/build-the-fetch-fidelity-probe.md) | plan is `proposed`; the policy bullet it tests stays unfalsifiable until the instrument exists |
| Whether the fetch-synthesis failure is eval fodder | closed | [fetch-fidelity-probe](/meta/evals/fetch-fidelity-probe.md) | - |
| The verbatim-before-quoting rule that probe measures | closed | [quote-primary-sources](/meta/policy/quote-primary-sources.md) | - |
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

Both landed. [PR #159](https://github.com/ob6to8/elixir-mind/pull/159) merged as `2d813e4`, branch deleted.

The grounding pass earned its keep by falsifying two of my own figures. I had written that K3 runs "~2.5× Fable 5's wall-clock" on AA-Briefcase and that Fable 5 finishes in 67 turns against K3's 83 — both came from a summarizing fetch, and neither survived re-reading the article for quotable text. That's a specific, repeatable failure mode: a fetch that answers a question in prose will happily synthesize a comparison the source never made, and it reads exactly like a quoted figure once it's in your notes. Demanding verbatim text is what separates them. Artificial Analysis's own summary turned out to be stronger evidence than my paraphrase anyway — *"particularly expensive when comparing to other open weight models of similar size. It's also notably slow and very verbose."*

The dev-history finding is worth your attention more than the grounding was. The design tolerates a one-PR lag; the actual lag was **six** (#148–#158). `mix brain.dev_history --check` skips silently on a shallow clone, which is what every cloud session gets — so the gate that was supposed to catch drift is structurally blind in exactly the environment where the regeneration step is most likely to be skipped. I regenerated it and left the diagnosis alone: I don't know whether sessions are hitting the shallow-clone path and moving on, or skipping the step entirely, and guessing would put a wrong cause into the record. It's a paused strand in the routing ledger, so `/priorities` will surface it.

## User

re: "a fetch that answers a question in prose will happily synthesize a comparison the source never made, and it reads exactly like a quoted figure once it's in your notes" - is this good fodder to add into evals?

restate "The dev-history finding is worth your attention more than the grounding was. The design tolerates a one-PR lag; the actual lag was six (#148–#158). mix brain.dev_history --check skips silently on a shallow clone, which is what every cloud session gets — so the gate that was supposed to catch drift is structurally blind in exactly the environment where the regeneration step is most likely to be skipped. I regenerated it and left the diagnosis alone: I don't know whether sessions are hitting the shallow-clone path and moving on, or skipping the step entirely, and guessing would put a wrong cause into the record. It's a paused strand in the routing ledger, so /priorities will surface it." in plainspeak

## Assistant

<routes ref="/meta/evals/fetch-fidelity-probe.md /meta/policy/quote-primary-sources.md">
## On the eval question

Yes — but it's a sharper fit for a *fidelity probe* than for anything the existing evals measure, and it's worth being precise about why.

The reason this one is attractive is that its ground truth is cheap and exact. `source-recall-probe` has a hard time constructing ground truth: "the complete set of primary sources for a subject" is a judgment call, which is why that probe is still `proposed`. Here the question is decidable by string containment — either the phrase appears in the fetched page or it doesn't. The bundle already has machinery of exactly that shape (`mix brain.glossary`'s containment scoring, `route_tags`' log-fidelity re-derivation), so the primitive isn't new.

The shape I'd build: a small frozen corpus of `(page snapshot, question, a verbatim answer the page supports, a tempting comparison the page does *not* state)`. Score whether a summarizing fetch invents the absent comparison, and whether a "quote verbatim" prompt suppresses it relative to a "summarize" prompt. Falsification condition, mirroring source-recall's: **if the verbatim prompt scores no better than the summarizing one, the prompting discipline is theater and the fix belongs in tooling or policy, not in how the fetch is worded.**

Two real objections you should weigh before I build anything:

**It measures a vendor's model, not the brain.** WebFetch's summarizer isn't something this repo versions. The score would move when that model changes, so the trend line tracks Anthropic's behavior rather than the brain's — different in kind from `dedup-probe`, which measures the bundle's own lexical layer. That's still useful (it tells you how much to trust the tool), but it's a weaker claim on the eval namespace.

**It needs frozen fixtures to stay offline.** The toolchain's zero-dependency, offline stance means the eval can't fetch live pages. Snapshots work, but they're a corpus to maintain, and they age.

Given that, my recommendation is that the *first* artifact here is a policy rule, not an eval: **a figure that will be quoted, or that will back `verified: true`, gets re-fetched demanding verbatim text before it's asserted.** That fires unprompted in every session because policies compile into the contract; an eval sits inert until someone runs it. The eval is the right *second* move — it tells you whether the rule is doing anything. And it pairs naturally with `source-recall-probe`: recall asks *did you find the source*, fidelity asks *did you report what it actually said*. Two halves of one pipeline, and the second is the easier one to measure.
</routes>

## The dev-history thing, plainly

There's a file that lists every PR the project has merged. It's meant to be rebuilt whenever someone opens a new PR, so it should never be more than one PR behind. It was six behind.

The reason it drifted is the part that matters. There's a check whose whole job is to catch this. But the check needs the full git history, and this session — like other cloud sessions, as far as I can tell from what I saw here — only downloads a shallow slice of it. When the history isn't there, the check doesn't fail. It prints "skipping" and passes. So the safeguard quietly does nothing in the environment where the problem actually happens.

I rebuilt the file. I did not try to work out why it fell so far behind. It might be that sessions hit that shallow-clone path and moved on, or that the rebuild step is being skipped for some other reason. I don't know which, and writing down a guess would put a wrong answer into a permanent record. So I left it flagged as an open question, which means it'll show up the next time you run `/priorities`.

### Your options from here

| # | option | what it entails |
|---|---|---|
| 1 | Add the verbatim-before-quoting rule to policy | small amendment to `quote-primary-sources` or `verification-grounding`; fires unprompted, recompiles the contract |
| 2 | File the fidelity probe as a `proposed` eval | mirrors `source-recall-probe`'s shape; I'd write the hypothesis and falsification condition but not the fixtures until you want it run |
| 3 | Both, in that order | the rule now, the eval as the measurement of whether the rule earned its place — this is what I'd do |
| 4 | The dev-history diagnosis | separate work; needs looking at how other sessions ran the step, not a guess from here |

## User

3, then persist 4 as a todo
then /create-pull-request  merge

## Assistant

Worth naming what the sequence actually produced, because it wasn't the plan going in. The Kimi K3 intake was the task; the durable output is a rule about how agents read sources. The chain ran: file a claim → ground it → discover the grounding falsified two of my own figures → convert that failure into a standing rule → file the instrument that can retire the rule. The knowledge document was the occasion, not the yield.

One thing I want to flag rather than bury. The probe's falsification condition points at *my own bullet* — if demanding verbatim text doesn't lower the invention rate, the policy comes back out. That's deliberate, but it only works if someone actually builds and runs it. A `proposed` eval whose falsification condition is never exercised is just a rule with a plausible-sounding justification attached, and the brain now has three of them sitting at `proposed`. That's the shape worth watching, not any one of them.

On the todo: I followed your call to file it as a todo rather than an issue. The routing table would push it toward `issue` — something behaves wrongly and the cause is unknown — but framed as *do the diagnosis*, the approach is known and the task is plain. I noted in the doc that it graduates to an issue if the diagnosis confirms a defect worth tracking separately from its fix, so the classification resolves on evidence instead of on my read now.

## User

restate in plainspeak

## Assistant

The pull request is merged. Three things went in.

**What happened, in order.** The job was to file what I'd learned about Kimi K3. Along the way I wrote a claim about AI pricing, then went back to check it against the original sources. That check caught me: two of the numbers I'd written weren't in the sources at all. I'd asked a tool to read a web page and summarize it, and the summary had quietly made up a comparison the page never made. So the real result of all this isn't the Kimi K3 write-up. It's a rule about how to read sources, plus a test that could prove the rule worthless.

**The rule.** Don't take a quote from a summary of a page. Go get the actual sentence. If you can't produce the actual sentence, don't put quote marks around it. This is now part of the standing instructions, which means every future session sees it automatically without anyone having to go look for it.

**The test.** I designed — but did not build — a way to check whether that rule does anything. You'd save some web pages, then ask about them two ways: normally, and with "give me the exact sentence or tell me it isn't there." Then count how often each way invents something. If the strict version doesn't do better, the rule is useless and should be deleted.

**The thing I'd rather say out loud than hide.** That test is deliberately built so it can kill my own rule. But that only means something if someone actually builds and runs it. There are now three tests sitting in this repo that were designed and never built. A test that never runs is just a rule with a nice-sounding excuse attached to it. That pattern is worth watching more than any single one of them is.

**One judgment call.** You asked me to file the dev-history problem as a "todo." The repo's own filing rules would lean toward calling it an "issue," since something is behaving wrongly and nobody knows why. I filed it as a todo the way you asked, and wrote in the doc that it should be reclassified if the investigation turns up a real defect. That way the label gets settled by what's found, not by my guess today.

**What's in the repo now:** the new rule, the test design, the todo, an updated session record, and the regenerated PR-history file. All checks passed, 183 tests, nothing failing. The working branch is gone, as it should be after merging.

## User

1 - persist into a plan
2 - proceed, if doing this ensures the integrity of this pr
3 - eval tests? let them pile up to be run later

## Assistant

Committed and pushed to the branch — but **I have not opened a PR**, since you didn't ask for one this time. Two of your three items are done; the middle one I'm declining on the condition you set.

<routes ref="/meta/issues/dev-history-regeneration-silently-skipped-on-shallow-clones.md">
## On #2 — no, and here's the honest reason

You said "proceed, **if** doing this ensures the integrity of this PR." It doesn't, so I didn't.

The dev-history problem is a *generated summary file* falling behind. It has no bearing on whether any PR's actual content is correct — no knowledge document, no claim, no piece of code is affected by it. And specifically in this session it can't bite: I unshallowed the git history a few rounds back, so the rebuild command works here and its check genuinely passes rather than skipping. The commit I just made confirms that — `meta/dev-history.md is consistent with the merge graph`, not "skipped."

So the risk the diagnosis addresses is about *other* sessions, on *other* days. It's real, and it's already written down as a task. Doing it now would be work you told me to do only if it protected this change, and it doesn't.
</routes>

<routes ref="/meta/plans/build-the-fetch-fidelity-probe.md">
## What did get done

**The build plan** for the fidelity probe is filed. The decision it exists to record is where the network sits. Every other tool in this repo runs offline with no dependencies, and this one can't, because it has to fetch web pages. So I split it: one command goes and fetches, and saves the raw answers to a file that gets committed. Everything else — the actual scoring — reads that saved file and does plain text comparison, offline, testable like everything else. The payoff is that when you later change how you score, you re-score the *same saved answers*, so you can tell a scoring change apart from the web tool having quietly gotten better or worse. Two things I ruled out and wrote down why: doing it in one pass that fetches and scores together (loses that distinction), and using an AI to judge whether an answer made something up (that's the exact failure being measured — you'd be using the broken thing to test the broken thing).

**Your call on the backlog** is now written into the evals index: a pile of designed-but-unbuilt tests is the intended state, not a mess to clean up. I said the opposite last message — that the pile was the thing to watch — so this overrides me, and I wrote it in a way that tells a future session not to propose tidying them. I did add one carve-out: when an unbuilt test is the only thing that could disprove a live rule, that gets escalated by writing a build plan, which is exactly what #1 just did.
</routes>

## User

2, then /create-pull-request  merge

## Assistant

*(the closing report of this turn was delivered after this section was written;
the PR it landed in is named in the narrative above.)*
