---
id: em:1f1256
type: methodology
title: "Reading a self-published benchmark"
description: A six-step procedure for deciding what a project's own benchmark actually establishes — find the denominator behind each percentage, check which suite the headline number came from, and read the repository's limitations section before the promotional post.
provenance: "Derived in-session 2026-07-29 while adjudicating a promoted GraphRAG serialization benchmark against its repository; every step below was executed against that artifact"
tags: [evaluation-methodology, benchmark-rigor, source-evaluation, intake, claims]
timestamp: 2026-07-29T03:00:47Z
attribution:
  when: 2026-07-29T03:00:47Z
  channel: agent-authored
  agent: "Claude Code agent, /intake session"
  why: "the adjudication procedure existed only as ad-hoc steps in one session; filed so the next promoted benchmark is checked the same way instead of by feel"
---

# Reading a self-published benchmark

A project that benchmarks itself against alternatives is not thereby dishonest,
and a project whose promotional post overstates its own repository is not
thereby fraudulent. Both happen constantly, often in the same project. The
question worth answering is narrower and answerable: **what does this benchmark
establish, at what n, under what conditions?**

The steps below are ordered by cost. The first three are usually decisive and
take minutes.

## The procedure

**1. Read the repository's limitations section before the post.** A calibrated
project states its own confidence interval, its single-model dependence, and
the cases where it loses. When such a section exists and the promotional
headline contradicts it, the gap *is* the finding — and it is the project's own
words doing the work, not your inference. When no such section exists, that is
also the finding.

**2. Find the denominator behind every percentage.** A headline percentage on a
category ("multi-hop accuracy") is a subset count. Locate the per-category
table and convert back: an "80% vs 40%" swing that is 8/10 vs 4/10 is a
four-question difference and cannot carry a general claim. Percentages hide
sample size; counts do not.

**3. Check which suite the number came from.** Projects with more than one
benchmark suite routinely have their headline attach a figure from the smaller
suite to the name of the larger one. Match every quoted number to the table it
appears in.

**4. Separate the outlier from the trend.** Rank the results and ask whether
the spread survives dropping the worst entry. A dramatic range driven by one
degenerate case ("all formats within 3 points, except RDF/Turtle") supports a
claim about *that case*, not about the axis being measured.

**5. Name the baseline, and ask whether anyone ships it.** Savings are quoted
against whichever baseline is most flattering. Recompute against the strongest
realistic alternative — the difference between "68.6% vs pretty-printed JSON"
and "41.3% vs minified JSON" is the whole distance between a headline and a
result.

**6. Record the measurement conditions as part of the claim.** One model, one
run, one tokenizer, temperature 0 is a legitimate scale; it is only illegitimate
when the conditions get dropped. Carry them into whatever you file, so the claim
cannot later be cited as broader than it was measured.

## Adjudicating a critic

Applies when the benchmark is being publicly disputed, which is often how it
reaches you.

- **Check the critic's objection against the artifact, not against the post.**
  An objection that would dissolve on opening the repository is not evidence
  about the benchmark; it is evidence about the critic's reading.
- **Ask what the critic offers that is runnable.** A claim of a superior
  private, patented, or non-public method cannot be entered into a benchmark. It
  is not necessarily false — it is unfalsifiable, which is a different and
  disqualifying property here.
- **Watch for a substituted target.** Arguing against a technique the post never
  mentioned (a critic attacking [BM25](/beliefs/glossary/bm25.md) in a thread
  about serialization formats) means the critic is answering a different post.
- **Keep suspicion and its stated reasons separate.** A critic can be right that
  a post is promotional while every technical reason they give for saying so is
  wrong. Both halves are reportable, and collapsing them loses the finding.

## Why it is worth the minutes

The failure mode is not believing a false number. It is filing a true-but-narrow
number without its conditions, so that a later session retrieves "format swings
multi-hop accuracy 40% to 80%" with no denominator attached and builds on it.
[Verification grounding](/meta/policy/verification-grounding.md) governs what a
filed statement may assert; this procedure is what produces the evidence that
grounding needs.

## Worked example

[Graph serialization format as an unmeasured GraphRAG stage](/knowledge/SWE/agentic/context-engineering/graph-serialization-format-in-the-prompt.md)
runs all six steps end to end, including a case where steps 2, 3, and 5 each
independently shrink the headline.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:1f1256">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-29-graphrag-serialization-claim-and-its-critic (2026-07-29)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:1f1256`]**  (co-feeds: `em:c81829`)

**Three checkable gaps**

1. **Wrong suite.** "10-format benchmark shows it swings multi-hop accuracy 40% to 80%" attaches the five-format suite's ten-question result to the ten-format suite. The ten-format suite's own multi-hop range is 47.6%–85.7%.
2. **One bad format, not a general property.** Drop RDF/Turtle and the ten-format spread collapses to two questions out of twenty-one. The defensible claim is *verbose RDF-style syntax hurts graph reasoning*, not *format choice swings accuracy by half*.
3. **Flattering baseline.** The ~70% token figure is against pretty-printed JSON. Against minified JSON it is 41.3%.

And the repo says all of it. Its methodology section states the result is "one run, one model (DeepSeek Chat, temperature 0), 100 questions", that "A 3-point gap at n=100 is inside the ~±6-9pp confidence interval, so ordering within the 85-90% cluster should be treated as indicative, not proven", and — of the headline token number — "Nobody should ship pretty-printed JSON in a context window; against minified JSON the saving is 41.3%." It even documents a case where its own format loses: mutating a graph inside a cached prompt prefix invalidates "~77% of the prefix vs ~65% for compact JSON."

---

**[`em:1f1256`]**  (co-feeds: `em:c81829`)

**My analysis**

**None of the critic's technical objections land.**

- *Compression* is real but aimed at the wrong layer — it's about index and storage representation, while the benchmark measures what a model reads in a prompt. Compression the model must decode doesn't apply at that boundary.
- *"Not structured data"* is self-refuting against the artifact. ISONGraph's encoding is columnar — a header row of column names then positional rows (`nodes.person` / `id name age` / `1 Alice 30`) — which is exactly the fixed-position layout he defines as structured data. The objection reads as written without opening the repo.
- *BM25* appears nowhere in the post or the benchmark. He introduced it and then argued against it.
- *Secret, patented, 50-year-old, non-public formats* are unfalsifiable by construction. Demanding inclusion in a benchmark while refusing to supply anything runnable isn't a testable claim.

**But the post is overclaimed anyway.** The critic's *suspicion* of promotional framing was well-founded; every *reason* he gave for it was wrong. That's the shape of the thing — not "influencer vs. engineer who caught them," but a real effect, measured honestly at small scale, oversold in the post, and attacked by someone who didn't check the artifact.

**What survives as usable:** verbose graph syntax costs both tokens and multi-hop accuracy against a compact tabular encoding, on one model at n≈100. Enough to justify measuring the stage in your own pipeline; not enough to justify migrating format on someone else's numbers. The stage being unmeasured is the durable point. The size of the effect is not established.
