---
id: em:c81829
type: reference
title: "Graph serialization format as an unmeasured GraphRAG stage (ISONGraph, r/LLMDevs)"
description: A promoted benchmark claims the format a retrieved subgraph is serialized into swings multi-hop accuracy from 40% to 80% and costs ~70% more tokens; the underlying repository's own numbers support a narrower result — one model, one run, a 10-question subset — and the thread's hostile critic attacks it on grounds that do not hold.
resource: https://www.reddit.com/r/LLMDevs/comments/1v7su76/your_graphrag_pipeline_has_an_unmeasured_stage/
provenance: "r/LLMDevs post and comment thread by u/Immediate-Cake6519 and u/Actual__Wizard, 2026-07-28; benchmark figures read from the isongraph/isongraph repository at main"
tags: [context-engineering, graphrag, serialization, knowledge-graph, token-efficiency, evaluation-methodology, benchmark-rigor, retrieval]
timestamp: 2026-07-29T03:00:47Z
attribution:
  when: 2026-07-29T03:00:47Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked for the details of what the OP claims, what the responder pushes back on, and an assessment of the apparent contrast between a convincing influencer and an AI engineer calling them out"
---

# Graph serialization format as an unmeasured GraphRAG stage (ISONGraph, r/LLMDevs)

A post to r/LLMDevs on 2026-07-28 argues that GraphRAG pipelines instrument
every stage except the last one — how the retrieved subgraph is turned into
text for the prompt — and offers a ten-format benchmark plus an open-source
format (ISONGraph) as evidence. It drew one sustained critical responder. The
post sat at **0 points, 50% upvoted, 7 comments** when captured.

The underlying question is real and under-measured. The specific numbers in the
headline are weaker than the headline makes them sound — and, separately, the
critic's objections do not survive contact with the artifact.

## The claim as posted

> We benchmark retrievers, rerankers, chunkers, embedding models. Then the
> retrieved subgraph goes into the prompt via json.dumps and nobody measures
> that step.

> I compared 10 graph serialization formats (JSON, GraphML, RDF/Turtle
> variants, edge lists, adjacency lists, others) with the same graph and same
> model. Measured token count, traversal QA, and 2-3 hop reasoning. Results:
> 40% to 80% multi-hop accuracy spread on format alone, and about 70% token
> cost difference between the most verbose and most compact formats. Verbose
> syntax does not just cost tokens, it appears to actively hurt the model's
> attention over graph structure.

The post links `github.com/isongraph/isongraph` (MIT) as "the winning format
with the benchmark methodology" and closes by asking what format others pass
to the model.

## What the repository actually reports

The repo carries two separate suites, and the headline numbers come from
different ones.

**Knowledge Graph benchmark** — 100 questions, 7 datasets, **10 formats**:

| Format | Tokens | vs JSON (pretty) | vs JSON (minified) | Accuracy |
|---|---|---|---|---|
| ISONGraph | 1,698 | 68.6% | 41.3% | 90.0% |
| ISON | 1,976 | 63.4% | 31.7% | 88.0% |
| JSON Compact | 2,893 | 46.5% | 0.0% | 88.0% |
| TOON | 2,934 | 45.7% | −1.4% | 85.0% |
| Cypher (Neo4j) | 3,522 | 34.9% | −21.7% | 89.0% |
| JSON | 5,406 | 0.0% | −86.9% | 87.0% |
| RDF/Turtle | 4,166 | 22.9% | −44.0% | 58.0% |
| GraphML | 9,093 | −68.2% | −214.3% | 87.0% |

Its multi-hop category is **21 questions**: ISONGraph 18/21, Cypher 18/21, and
every other format 16–17/21 — except RDF/Turtle at 10/21. Among the nine
non-RDF formats the entire multi-hop spread is **two questions out of
twenty-one**.

**Data Traversal benchmark** — 50 questions, 4 datasets, **5 formats**. Its
multi-hop category is **10 questions**: ISONGraph 8/10, ISON 7/10, JSON 5/10,
JSON Compact 4/10, TOON 4/10. This is where "40% to 80%" comes from — a
four-question difference on a ten-question subset, in the *five*-format suite.

Both suites are scored by **one model (DeepSeek Chat, temperature 0), one run**,
with token counts under the `o200k_base` tokenizer.

## Where the headline diverges from the evidence

Three specific gaps, all checkable against the repo:

1. **The benchmark is misattributed.** "10-format benchmark shows it swings
   multi-hop accuracy 40% to 80%" attaches the traversal suite's five-format,
   ten-question result to the ten-format suite. The ten-format suite's own
   multi-hop range is 47.6%–85.7%, and it is driven almost entirely by
   RDF/Turtle.
2. **The dramatic spread is one bad format, not a general property.** Excluding
   RDF/Turtle, the ten-format suite shows a 2/21 multi-hop spread and a 3-point
   overall accuracy spread. The defensible claim is *verbose RDF-style syntax
   hurts graph reasoning*, not *format choice swings accuracy by half*.
3. **"~70% token cost" is measured against a baseline nobody ships.** The 68.6%
   figure is against pretty-printed JSON (`indent=2`); against minified JSON it
   is 41.3%.

The notable part is that **the repository states all of this itself.** Its
methodology section says the accuracy result is
"one run, one model (DeepSeek Chat, temperature 0), 100 questions", that "A
3-point gap at n=100 is inside the ~±6-9pp confidence interval, so ordering
within the 85-90% cluster should be treated as indicative, not proven", that
the robust separation is "compact formats vs the verbose tail (RDF/Turtle:
58%)", and — of the headline token figure — "Nobody should ship pretty-printed
JSON in a context window; against minified JSON the saving is 41.3%." It also
volunteers a case where its own format loses: mutating a graph inside a cached
prompt prefix invalidates "~77% of the prefix vs ~65% for compact JSON"
(see [KV cache](/beliefs/glossary/kv-cache.md) and
[KV-cache hit rate](/beliefs/glossary/kv-cache-hit-rate.md)).

So the repo is calibrated and the promotional post is not. The caveats were
written and then dropped on the way to Reddit.

## The dispute in the thread

The single critical responder (u/Actual__Wizard) made four moves across five
comments:

- **Antiquity and secrecy.** "I need to inform you that the development of
  these graphs has been on going for almost 50 years and the best formats are
  not really public at this time", and the relevant technique is "patented and
  can't be used in these systems".
- **Compression.** "I don't see any compression (of any kind) occurring
  either" — that succinct/compressed structures can "go faster than what people
  think is possible".
- **A definitional objection.** "the format is absolutely not structured data,
  you are encoding data into a structure… The purpose to structuring the data
  is so that one can pivot off of the structure with out reading any of the
  data".
- **Escalation.** After the OP did not answer a DM promptly: "So, you're just
  setting up fake benchmarking sites? So, you're setting up deceptive
  advertisements?", "Let me guess, you're a google employee?", a rule-violation
  report to the mods, and "I can not believe you people actually think BM25 is
  good".

The OP's replies conceded the compression point ("Succinct structures and
compressed indexes genuinely can go faster"), restated a standing offer — "Name
something public you think beats it and I'll run it on the same corpus and
publish the numbers, including if mine lose" — and asked for anything runnable:
"I can't benchmark a description". The critic declined: "I'm not sending you
private code".

## Assessment

**The critic's substantive objections do not land.**

- The *compression* point is real but off-target: it is about index and storage
  representation, while the benchmark measures what an LLM reads in a prompt.
  Compression that a model must decode is not applicable at that boundary; that
  is why the OP could concede the direction and still have nothing to run.
- The *structured data* objection is self-refuting against the artifact.
  ISONGraph's actual encoding is columnar — a header row of column names
  followed by positional rows (`nodes.person` / `id name age` / `1 Alice 30`) —
  which is precisely the fixed-position layout the critic defines as structured
  data. The objection reads as written without opening the repo.
- *"BM25"* appears nowhere in the post or the benchmark. The critic introduced
  it and then argued against it.
- *Secret, patented, 50-year-old, non-public formats* are unfalsifiable by
  construction. A benchmark needs a runnable artifact; refusing to supply one
  while demanding inclusion is not a testable claim.

**The OP's conduct is the better-behaved half of the exchange, and the post is
still overclaimed.** Publishing the harness, the limitations, and a
self-losing case is what good practice looks like; compressing that into
"swings multi-hop accuracy 40% to 80%" for a promotional post is not. Both can
be true, and here they are.

**The reading that fits the evidence** is neither "convincing influencer" nor
"engineer catching a fraud". It is a real, under-measured effect
([prompt sensitivity](/beliefs/glossary/prompt-sensitivity.md) applied to
serialization format rather than to wording), measured honestly at small scale
by a project that then oversold it, and challenged by someone whose specific
objections were not checked against the artifact. The critic's *suspicion* of
promotional framing was well-founded; every *technical* reason he gave for it
was wrong.

**What survives as usable knowledge:** verbose graph syntax (RDF/Turtle,
GraphML) costs both tokens and multi-hop accuracy against a compact tabular
encoding, on one model at n≈100 — enough to justify measuring the stage in your
own pipeline, not enough to justify a format migration on someone else's
numbers. The stage being unmeasured is the durable point; the size of the
effect is not yet established.

## See also

- [Context rot — LLM performance degrades non-uniformly as input length grows](/knowledge/SWE/agentic/context-engineering/context-rot-chroma-research.md) — the neighbouring result: *how much* context you spend matters non-uniformly, as well as how you shape it.
- [Context engineering for AI agents — lessons from building Manus](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md) — KV-cache discipline, which the ISONGraph columnar layout trades against.
- [Reading a self-published benchmark](/knowledge/SWE/evals/reading-a-self-published-benchmark.md) — the procedure used to adjudicate this post, generalized.

# Citations

- Post and thread: <https://www.reddit.com/r/LLMDevs/comments/1v7su76/your_graphrag_pipeline_has_an_unmeasured_stage/>
- Repository (MIT): <https://github.com/isongraph/isongraph>
- Knowledge Graph benchmark: <https://github.com/isongraph/isongraph/blob/main/benchmark/KnowledgeGraph_Benchmark/BENCHMARK.md>
- Data Traversal benchmark: <https://github.com/isongraph/isongraph/blob/main/benchmark/DataTraversal_Benchmark/BENCHMARK.md>
