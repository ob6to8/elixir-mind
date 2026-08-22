---
id: em:f38c06
type: reference
title: "The shapes of agent memory — a controlled comparison of file, structured, and experience-based stores"
description: A from-scratch benchmark holding model and evaluation protocol fixed across three agent-memory architectures, finding structured stores beat file-based curation on both accuracy and token cost while experience-trained memory helps only actors with remaining capability headroom.
resource: https://pinglin.tw/blog/the-shapes-of-agent-memory/
provenance: "pinglin.tw, \"The Shapes of Agent Memory\", fetched 2026-08-21"
tags: [agent-memory, benchmarks, longmemeval, locomo, structured-memory, file-based-memory, reinforcement-learning, evaluation-methodology]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# The shapes of agent memory

Most agent-memory writing argues for one architecture from first principles;
this piece instead builds all three and measures them under one held-fixed
model and evaluation protocol, on [LongMemEval](/beliefs/glossary/longmemeval.md)
and [LoCoMo](/beliefs/glossary/locomo.md). The finding cuts against the
[curated-files convergence](/knowledge/SWE/agentic/agent-memory/memory-systems-landscape.md#the-2026-convergence-on-files)
this bundle's own landscape survey documents: structure wins on accuracy *and*
cost simultaneously, once the memory scales past what a human curator can hold
in a handful of files.

## The three architectures, controlled

- **File-based.** The model curates markdown — an index plus topic files —
  and recalls via literal grep and reading, no embeddings. What "Claude Code,
  Cline, Cursor, and Windsurf currently ship," per the piece. Strongest where
  it can say "I don't know": file-based memory remembers less, so it
  over-answers less.
- **Structured stores.** Every turn auto-extracts into atomic facts, embedded
  without LLM reasoning, held in vector indexes with temporal graphs. Two
  lineages: *place-organized* (cheap writes, no entity merging — the MemPalace
  shape) and *entity-and-time* (resolved entities with dated, validity-windowed
  facts — the Zep/Graphiti shape, at expensive per-message LLM extraction
  cost). The study's own hybrid store combines place's cheap writes with
  entity-and-time's validity windows.
- **Experience-based.** Memory behavior moves into model weights via
  reinforcement learning (the piece's own MemHarness): episodes populate a
  bank, and retrieval, critique, and reconstruction stages train end-to-end
  rather than staying frozen — the opposite bet from a retrieval layer bolted
  onto a frozen model.

## Accuracy and cost, head to head

On LongMemEval-S (356 questions): structured stores score 73.6% against
file-based memory's 44.9% — a 28.7-point gap (95% CI [22.1, 35.4]) — with the
structured store's lead concentrated in multi-session recall (61% vs. 33%) and
temporal reasoning (80% vs. 41%). File-based memory's one win is abstention
questions (88.9% vs. 77.8%): remembering less means fewer confident wrong
answers.

Token cost per correct answer inverts nobody's intuition about "simpler is
cheaper": file-based memory spends 665k tokens against structured memory's
27k, because curation itself — reading and reorganizing files before an
answer is even attempted — adds roughly 246k tokens per history (~35 minutes
of ingestion). Structure wins the cost line too.

Store-to-store, on LoCoMo: raw dated facts scored 78.3%, entity-and-time
(Zep Cloud) 74.6%, and the Graphiti OSS engine 53.4% — "raw dated facts beat
LLM-distilled graphs, and cost less twice over," with the graph lineage's
per-message extraction pricing at roughly $14 to ingest one long user history
against $0.03 for embedder-only approaches. On long haystacks (LongMemEval-M)
the hybrid store beat the place-organized store 75% to 60% (p = 0.008),
concentrated exactly where multi-session organization starts to matter.

## Where experience-based memory pays off — and where it doesn't

Retrieved experience helped only actors with capability headroom left to use
it: a weak 35B actor gained +4.2 points on WebShop (p = 0.022) from retrieved
episodes, while frontier Claude-sonnet-5 gained only +0.6 (p = 0.8) —
"retrieved memory paid only where the actor had headroom." The trained
MemHarness (7B), by contrast, reached 75.6% success on tasks inaccessible to
any untrained system regardless of what it retrieves — training reaches task
classes where the reward structure itself has to be learned, not just recalled.

Background consolidation passes (promoting files, merging facts) produced null
results at the scale measured, though the piece's own theory predicts the
benefit should emerge once histories outgrow what a reader can hold — an
untested-at-scale claim, not a refuted one.

## The evaluation-stack caveat

The piece's sharpest methodological finding: swapping the judge and reader
model moved scores by 6.9 points on *identical* retrieval — more than the
0.3–3.6-point spread between competing store architectures on the same
benchmark. Evaluation methodology can dominate the architectural effect being
measured, which is a caution against reading any single benchmark run
(including this one) as settling the question.

## Reading against this bundle

This bundle's own [memory-systems landscape](/knowledge/SWE/agentic/agent-memory/memory-systems-landscape.md)
found the field's 2026 vendor motion pointing toward curated files (Letta's
Context Repositories, LangChain's OpenWiki, Claude Code's auto memory) and
treated that motion as directional evidence for the files-canonical position.
This piece is a controlled counter-data-point at a different scale regime:
files win small, human-owned, and transparent; structure wins once memory
outgrows what a curator can hold and multi-session joins start to matter. The
two findings are not in tension so much as regime-dependent — worth reading
together rather than as a resolved dispute, and a reminder that the field's
LoCoMo-family benchmarks stay [contested](/knowledge/SWE/agentic/agent-memory/memory-systems-landscape.md#the-benchmark-wars)
regardless of which architecture is under test.

# Citations

- pinglin.tw, "The Shapes of Agent Memory" — <https://pinglin.tw/blog/the-shapes-of-agent-memory/>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:f38c06">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-21-reading-list-batch-intake-65-links (2026-08-21)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:f38c06`]**  (co-feeds: `em:aa3f68 em:8be1fe em:b9158a`)

All four batches are running in the background. While those work, here's where things stand and what still needs your input.

**A batch of ~65 unique links, four are running now:**
- Batch A — agent memory, MCP dedup, AI code-review tooling, Cursor's agent-orchestration posts → `knowledge/SWE/agentic/*`
- Batch B — benchmarks and papers (lilybench, livebench, SYCON-Bench, arxiv/alphaxiv) → `knowledge/SWE/evals/`, `ai-industry/`, `machine-learning/`
- Batch C — the Rust cluster (rust-analyzer/cargo-xtask, matklad essays, zinit/bottom/zoxide, rustlings, bash guide) → new `knowledge/SWE/rust/` + `dev-tools/`
- Batch D — general SWE essays (abstraction, reasoning, testing, AI-era practice) → `software-design/`, `testing/`, `agentic/expertise/`

---

**[`em:f38c06`]**  (co-feeds: `em:aa3f68 em:8be1fe em:b9158a em:0a7cd9`)

The full batch is filed, verified, committed, and pushed. Here's where it landed.

You pasted a reading list of roughly 65 distinct links (after dedup). I split fetching and distillation across four parallel research passes by topic, each writing into its own directories to avoid collisions, then filed the handful of items none of them owned myself, minted ids and rebuilt the registry in one pass at the end, and ran the full gate suite (format, compile, `mix brain.verify`, route-tags, glossary, matters, lineage, 211 tests) before committing. Everything passed clean. The branch (`claude/research-intake-links-kqwhod`) is pushed; no PR was opened since you didn't ask for one.

**What I created**

| Area | Docs | Notes |
|---|---|---|
| Agentic tooling, agent-memory, code-review, Cursor orchestration posts | 13 | `knowledge/SWE/agentic/*` |
| Benchmarks & papers (LilyBench, LiveBench, SYCON-Bench, alphaxiv/arxiv) | 9 | `knowledge/SWE/evals/`, `machine-learning/ai-and-mathematics/` |
| Rust ecosystem | 12 | new `knowledge/SWE/rust/` + 4 in `dev-tools/` |
| SWE essays (abstraction, reasoning, testing, AI-era practice) | 11 | `software-design/`, `testing/`, `llm-engineering/`, `agentic/governance/`, new `cognitive-science/sensemaking/` |
| Items no batch owned, filed by me directly | 6 | why-steering-works, follow-md-links.nvim, claudish-to-english+Vomit (merged), Cursor's "Git at any scale", "HTML can do that", "Sol loves to cheat" |
