---
id: em:aa3f68
type: reference
title: "LilyBench — a symbolic music generation and understanding benchmark for LLMs"
description: A benchmark evaluating whether LLMs can generate valid LilyPond music notation and understand its musical structure, finding executable generation is easy zero-shot while structural understanding stays hard.
resource: https://github.com/CSCPadova/lilybench
provenance: "CSCPadova, GitHub README and project site (cscpadova.github.io/lilybench), fetched 2026-08-21"
tags: [evals, benchmarking, symbolic-music, music-generation, llm-evaluation, open-source]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# LilyBench

LilyBench evaluates LLMs on [LilyPond](https://lilypond.org/), a text-based
musical score notation language, across two complementary axes: whether a
model can **generate** valid, stylistically plausible scores, and whether it
can **understand** one it's given. The project accompanies a paper accepted
at Ital-IA 2026.

## Generation benchmark

Models are prompted from a fixed bank of 200 metadata-conditioned prompts
(composer, period, form, ensemble, part) drawn from three datasets — BMdataset
(in-domain), the Mutopia Project (out-of-domain), and EMOPIA (emotion-specific)
— across three regimes: zero-shot, few-shot from the training distribution,
and a few-shot ablation. Output is scored on:

- **Compile rate** — whether the generated LilyPond actually compiles (validated
  against the LilyPond 2.24.4 binary).
- **Jensen-Shannon similarity** across three MusPy descriptors.
- **Fréchet Music Distance**, via LilyBERT embeddings.

## Understanding benchmark

Ten tasks adapted from ABC-Eval probe structural comprehension at varying
depth: bar counting, metadata Q&A, bar sequencing, next-bar prediction,
metadata prediction, music captioning, composer/genre/emotion recognition,
and error detection — scored by accuracy, exact match, penalized Kendall-τ,
or macro-F1 depending on task, using greedy decoding.

## Findings

Four open-weight backbones were evaluated (Phi-4, Qwen2.5-Coder-14B,
DeepSeek-Coder-V2-Lite, Codestral-22B). The headline result: **executable
LilyPond generation is achievable zero-shot, while structural understanding
tasks remain hard despite strong composer and genre recognition** — models
are good at recognizing *what* a piece is but weak at reasoning about *how it
is put together* (bar counting, error detection). The paper also reports that
its descriptor- and embedding-based generation metrics **systematically
disagree** with each other, arguing against relying on any single generation
metric.

## Architecture

The codebase is built for extension: new generation regimes subclass
`Regime`, new understanding tasks register via `@register_task`, and new
models plug in through `ModelSpec`.

# Citations

- <https://github.com/CSCPadova/lilybench> — project repository and README
- <https://cscpadova.github.io/lilybench/> — project site, same benchmark

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:aa3f68">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-21-reading-list-batch-intake-65-links (2026-08-21)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:aa3f68`]**  (co-feeds: `em:f38c06 em:8be1fe em:b9158a`)

All four batches are running in the background. While those work, here's where things stand and what still needs your input.

**A batch of ~65 unique links, four are running now:**
- Batch A — agent memory, MCP dedup, AI code-review tooling, Cursor's agent-orchestration posts → `knowledge/SWE/agentic/*`
- Batch B — benchmarks and papers (lilybench, livebench, SYCON-Bench, arxiv/alphaxiv) → `knowledge/SWE/evals/`, `ai-industry/`, `machine-learning/`
- Batch C — the Rust cluster (rust-analyzer/cargo-xtask, matklad essays, zinit/bottom/zoxide, rustlings, bash guide) → new `knowledge/SWE/rust/` + `dev-tools/`
- Batch D — general SWE essays (abstraction, reasoning, testing, AI-era practice) → `software-design/`, `testing/`, `agentic/expertise/`

---

**[`em:aa3f68`]**  (co-feeds: `em:f38c06 em:8be1fe em:b9158a em:0a7cd9`)

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
