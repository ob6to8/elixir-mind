---
id: em:1394b9
type: reference
title: "r/LLMDevs — \"evaluation is so much harder than actually building the model wrapper\""
description: A Reddit r/LLMDevs discussion thread capturing the community's default answer for RAG evaluation — split retrieval eval from generation eval, calibrate any LLM-judge, and cut manual review down with a lightweight annotation UI.
resource: https://www.reddit.com/r/LLMDevs/comments/1v9m8d5/evaluation_is_so_much_harder_than_actually/
provenance: "Reddit r/LLMDevs thread, posted by u/nighthawk2906, 12 comments; pasted verbatim by the operator 2026-07-29"
tags: [evals, rag, retrieval, llm-as-judge, evaluation, annotation, reddit]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked to persist the thread verbatim, along with analysis"
---

# r/LLMDevs — "evaluation is so much harder than actually building the model wrapper"

Verbatim capture of the post and comment thread (reddit chrome, ads, and
tracking links stripped; comment text and ordering otherwise unchanged). The
distilled synthesis of the techniques this thread converges on is
[splitting retrieval and generation evaluation for RAG](/knowledge/SWE/evals/split-retrieval-and-generation-evaluation-for-rag.md).

## Post — u/nighthawk2906

> spent the last few weeks building a RAG pipeline for a client. the retrieval
> part works fine, the llm integration works fine, the whole thing comes
> together nicely
>
> but now i'm stuck on evaluation. how do i know if the answers are good? the
> client wants metrics but every metric i can think of feels kinda fake
>
> like BLEU scores? useless for open-ended questions. ROUGE? same problem.
> even the more modern LLM-as-judge approaches feel shaky cause they're biased
> toward whatever model you're using as the judge
>
> i've been manually reviewing like 50 responses every day and it's driving me
> crazy. my eyes start glazing over after the 20th based on the provided
> context answer lol . a friend mentioned he uses some automation tools to
> track his evaluation processes
>
> what are you all using for evaluation? especially for RAG where the ground
> truth is kinda fuzzy

## Comments

**u/No_Holiday1810:**

> ah the eval rabbit hole, welcome. i started just building a tiny set of 20
> questions where i the right answer should pull from a specific doc chunk,
> then checking if the retrieval actually grabbed that chunk. way less
> soul-crushing than staring at generated text all day
>
> your friend is onto something with automating the tracking part, i log the
> chunk IDs and let a script flag the misses so i only look at the weird
> ones. manual review of 50 a day is a fast track to burning out your
> eyeballs

**u/nighthawk2906** (reply to No_Holiday1810):

> the chunk ID logging is a good starting point, hadn't thought about that
> either
>
> the triage thing is real though. i'm in the same spot where not all misses
> feel equal but i can't tell which ones to ignore without just reading
> through everything anyway, which kind of defeats the purpose
>
> did you land on a threshold that worked or was it more just tuning it over
> time

**u/Positive-Buddy-1258:**

> Splitting retrieval eval and generation eval helps. Retrieval you can check
> mechanically: did the right chunks surface? Log chunk IDs, script the
> misses, only look at those. Generation is harder because "correct" is
> fuzzy, but you can narrow what you're actually checking. Instead of "is
> this a good answer", ask "did the answer use the retrieved context, and did
> it add anything that isn't in the context." The second question catches
> hallucinations without needing ground truth.
>
> For annotation: what helped was a simple interface where a reviewer flags
> each output as correct/partial/wrong with one click, free-text only on the
> wrong ones. No writing something for every row. You get a labeled dataset
> useful for regression testing later, and the session takes 10 minutes
> instead of an hour.

**u/nighthawk2906** (reply to Positive-Buddy-1258):

> The annotation flow you described is pretty much what we ended up with
> too, flags with freetext only on the bad ones. The part I keep running
> into is who actually does the reviewing when the subject matter is
> specialized enough that a general reviewer misses subtly wrong answers.
> The hallucination check you mentioned helps narrow it down, but if the
> retrieved context is slightly off, that check stops catching what it needs
> to catch.

**u/Positive-Buddy-1258** (reply to nighthawk2906):

> The chunk visibility thing actually helps more with this specific failure
> mode than with general quality. If the reviewer sees what was retrieved
> alongside the answer, they're not judging correctness from scratch, they're
> just checking whether the answer matches the chunk. That's a much lower bar
> than domain expertise.
>
> The catch is when the chunk itself is the problem, retrieval pulled
> something adjacent but not quite right. Then the answer looks consistent
> with context and the check passes. That's where it stops helping and
> you're back to needing someone who actually knows the domain.

**u/Future_AGI:**

> The manual review does not scale and you do not need it for half the
> problem: retrieval eval is mechanical (log chunk ids, did the right one
> surface, script the misses) so you can automate that entirely and save
> your eyes for generation. For the judge bias, use a different model family
> than the one you are scoring and anchor it to ten answers you scored by
> hand, then spot-check the judge against those weekly, which is roughly the
> eval loop we build and it turns 50-a-day into a handful of disagreements to
> look at.

**u/cmtape:**

> Evaluating RAG with BLEU/ROUGE is like judging a chef by how many times
> they used the word 'salt' in a recipe. The metric is technically correct,
> but it tells you absolutely nothing about whether the food actually tastes
> good.

**u/roger_ducky:**

> It's easier to evaluate all steps individually, IMO.
>
> Ensure there's no drift in the harness. (Ie, it's pulling in the most
> recent info in the system)
>
> Then have example "good" answers based on user feedback and use that to
> evaluate. Or, if the prompt expected specific information to be mentioned
> then check if that's true.

**u/DancesWithWhales:**

> Yeah, this is the hard part for sure! I think I've spent more time on eval
> than on my mcp itself.
>
> I'm working on end to end evals now where I record a whole actual session,
> and then replay it with changes to the mcp, and measure the outcomes of the
> session rather than just measure the outcomes of the mcp.
>
> It involves a "simulated human" run by another LLM to act as the user.
> Happy to share more if anyone's interested.

**u/Key_Medicine_8284:**

> This is the part nobody warns you about. The retrieval works, the LLM
> integration works, and then you hit the eval wall.
>
> You're right that BLEU and ROUGE are the wrong tool for open-ended QA. The
> approach that tends to hold up better in practice: separate retrieval eval
> from generation eval, because they fail for different reasons and need
> different metrics.
>
> For retrieval, you can get ground truth relatively cheaply. Have someone
> (or another LLM) annotate a set of test questions with which chunks should
> have been retrieved. Then measure hit rate and MRR. That's not fake — if
> your retrieval isn't surfacing the right chunks, the generation step can't
> fix it.
>
> For generation, LLM-as-judge is imperfect but not useless if you calibrate
> it carefully. The bias issue you named is real, so use a judge model
> different from your generator, define a rubric explicitly (groundedness,
> relevance, completeness separately), and have humans grade a random sample
> to check how well the judge tracks human preferences. That calibration
> step is what turns "kinda fake" into "good enough to catch regressions."
>
> On tooling: MLflow's eval framework on Databricks lets you run
> reference-based and LLM-judge metrics in the same run, track them over
> time, and compare across pipeline versions. Worth trying if you want to
> stop manually computing this stuff in notebooks. Self-hosted MLflow works
> too if you're not on Databricks.

# Citations

- u/nighthawk2906 et al., "evaluation is so much harder than actually
  building the model wrapper", r/LLMDevs, fetched 2026-07-29 —
  <https://www.reddit.com/r/LLMDevs/comments/1v9m8d5/evaluation_is_so_much_harder_than_actually/>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:1394b9">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-29-rag-evaluation-reddit-intake (2026-07-29)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:1394b9`]**  (co-feeds: `em:9baaad`)

The Reddit thread on RAG evaluation is now filed in two documents under
`knowledge/SWE/evals/`, and the branch is pushed.

**What happened, in plain terms:** the thread argues that scoring a RAG
pipeline's answers with one blended metric (BLEU/ROUGE, or a single
LLM-judge score) hides which half is broken. The fix the commenters converge
on is to score retrieval and generation separately — retrieval against a
small hand-built answer key (hit rate/MRR), generation by whether it stuck
to the retrieved text (a hallucination check) — and to keep any LLM-judge
honest by testing it against answers a human already scored, using a
different model as the judge. I captured the raw thread verbatim, and wrote
a second document distilling that technique for reuse.

**What I created**

| Type | Doc | Why this type |
|---|---|---|
| `reference` | [r/LLMDevs thread, verbatim](https://github.com/ob6to8/elixir-mind/blob/claude/rag-evaluation-metrics-zesc6s/knowledge/SWE/evals/rag-evaluation-is-harder-than-the-pipeline-reddit-thread.md) (`em:1394b9`) | External material captured per your instruction to persist it verbatim; `resource` holds the source URL |
| `methodology` | [Split retrieval/generation eval for RAG](https://github.com/ob6to8/elixir-mind/blob/claude/rag-evaluation-metrics-zesc6s/knowledge/SWE/evals/split-retrieval-and-generation-evaluation-for-rag.md) (`em:9baaad`) | A repeatable, prescriptive how-to distilled from the thread — the analysis half of the ask |

Both filed under the existing `knowledge/SWE/evals/` directory (no new
directory or type needed), cross-linked to each other and to existing
bundle concepts: [gold set](https://github.com/ob6to8/elixir-mind/blob/main/beliefs/glossary/gold-set.md),
[test oracle](https://github.com/ob6to8/elixir-mind/blob/main/beliefs/glossary/test-oracle.md),
[decompose-then-verify factuality](https://github.com/ob6to8/elixir-mind/blob/main/knowledge/SWE/evals/decompose-then-verify-factuality.md),
[an instrument without a control](https://github.com/ob6to8/elixir-mind/blob/main/beliefs/an-instrument-without-a-control-measures-itself.md),
and [coverage and quality must be measured jointly](https://github.com/ob6to8/elixir-mind/blob/main/beliefs/coverage-and-quality-must-be-measured-jointly.md).
