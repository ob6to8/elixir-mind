---
id: em:41ab78
type: reference
title: "Profiling Rust NIFs in Elixir (Paul Ricks)"
description: A worked recipe for wiring hotpath's function-timing and allocation profiler into a rustler-based Rust NIF crate, driving it from an Elixir Benchee benchmark run via the on_load callback and a manual guard, since hotpath's usual main-function macro has nothing to attach to in a NIF.
resource: https://blog.smaller-infinity.com/posts/profiling-rust-nifs-in-elixir/
provenance: "Paul Ricks, Smaller Infinity blog, published 2026-08-02"
tags: [elixir, rust, nif, rustler, profiling, benchmarking, hotpath, performance]
timestamp: 2026-08-05T00:00:00Z
attribution:
  when: 2026-08-05T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of 20 links for filing"
---

# Profiling Rust NIFs in Elixir

Paul Ricks's recipe for getting function-level timing and allocation data out
of a Rust NIF called from Elixir. The starting problem: language-native
profiling tools (Elixir's own, or Rust's `hotpath`) generally assume you
never leave the language, and a `rustler`-based NIF crosses that boundary by
design — Elixir for the scalable system, Rust NIFs for the CPU-bound inner
loop.

## The core obstacle

`hotpath` is normally wired up via its own `hotpath::main` macro, which
instruments a Rust binary's `main` function. A NIF crate has no `main` — the
crate is loaded into the BEAM, not run standalone — so that automatic setup
has nothing to attach to.

## The recipe

1. **Gate the dependency behind a Cargo feature** (`hotpath = { version =
   "0.21", optional = true }`, plus `hotpath`/`hotpath-alloc` feature flags)
   so the profiler adds zero overhead in a normal build.
2. **Pass the feature through from Elixir at compile time**, via an
   `@hotpath_features` module attribute read from an environment variable and
   forwarded into `use Rustler, features: @hotpath_features` — because
   `use Rustler` and the attribute are both evaluated at compile time, `mix
   compile --force` picks the feature flags up.
3. **Mark each function** `#[cfg_attr(feature = "hotpath", hotpath::measure)]`
   so `hotpath` times it only when the feature is active.
4. **Do `hotpath::main`'s job manually** in `rustler::init!`'s `load`
   callback (`on_load`): build a `HotpathGuardBuilder` (percentiles, JSON
   output path, which sections to collect), store the guard in a
   `static Mutex<Option<HotpathGuard>>` — the guard's lifetime is what
   controls collection start/stop, RAII-style. Register
   `#[global_allocator]` with `hotpath::CountingAllocator` when the
   `hotpath-alloc` feature is on, to get allocation-byte data alongside
   timing.
5. **Add an explicit `hotpath_finish/0` NIF** that drops the guard (flushing
   the JSON report), and call it at the end of the Elixir benchmark script —
   there's no natural end-of-`main` moment to hook, so the Elixir side has to
   trigger the flush itself.

The output is a `hotpath_report` JSON file with per-function call counts,
average/p50/p95/p99 timings, and (with `hotpath-alloc`) exclusive allocation
bytes per function — e.g. in the article's toy example, one function
accounted for 100% of the 1.6GB allocated across ~2.1M calls, immediately
pointing at the allocation hotspot the wall-clock numbers alone wouldn't have
isolated.

## Gotchas worth carrying forward

- **Dirty NIFs.** Long-running NIFs need to run on a dirty scheduler
  (`rustler` supports this); the timing data from this setup is exactly what
  tells you which functions need that reclassification.
- **JSON-per-run doesn't diff well.** Raw JSON profiling output checked into
  git history is hard to compare across runs; the author added `bench.show`
  and `bench.compare` mix tasks specifically to make historical comparison
  usable, and recommends the same for any similar setup.

# Citations

- Source: <https://blog.smaller-infinity.com/posts/profiling-rust-nifs-in-elixir/>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:41ab78">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-05-reading-list-batch-intake (2026-08-05)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:41ab78`]**  (co-feeds: `em:b2676a em:cdd51c em:79c1a1 em:45adfd em:f9f0d5 em:86f6df em:d146ff em:d27de7 em:563b18 em:fab63b em:134093 knowledge/SWE/performance/index.md`)

**What I created**

| Doc | Type | Why this type |
|---|---|---|
| [Normalization of Deviance in AI](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/security/normalization-of-deviance-in-ai.md) | reference | captured external analysis |
| [Claude Fable is relentlessly proactive](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/anthropic/claude-code/fable-is-relentlessly-proactive.md) | reference | captured external analysis |
| [Proofreader prompt](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/prompt-design/proofreader-prompt-pattern.md) | snippet | a reusable prompt template, not a distilled argument |
| [LLM — multi-provider CLI/library](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/dev-tools/llm-cli-tool.md) | reference | product docs + its 0.32 release notes, combined |
| [OpenAI's accidental cyberattack against Hugging Face](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/security/openai-cyberattack-huggingface.md) | reference | captured external analysis |
| [Profiling Rust NIFs in Elixir](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/performance/profiling-rust-nifs-in-elixir.md) | reference | captured how-to writeup |
| [Litestream](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/dev-tools/litestream.md) | reference | promoted from the survey/bookmarks tier |
| [Model-Based Agentic Software Engineering (MAGE) — framework overview](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/governance/model-based-agentic-software-engineering-mage.md) | reference | whole-framework granularity beside the existing chapter capture |
| [METR's AI Productivity Study is Really Good](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/expertise/metr-ai-productivity-study-is-really-good.md) | reference | captured external analysis |
| [Analysis of vibecoded outputs (MostAwesomeDude)](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/expertise/vibecoded-outputs-analysis-mostawesomedude.md) | reference | captured external analysis |
| [UML — introduction](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/software-design/unified-modeling-language-introduction.md) | reference | encyclopedia-style capture |
| [Jido Assembly — a Slack clone](https://github.com/ob6to8/elixir-mind/blob/claude/research-intake-links-nhi01p/knowledge/SWE/agentic/frameworks/jido-assembly-slack-clone.md) | reference | captured case study |

Plus `knowledge/SWE/performance/index.md` for the new subdirectory, and every touched directory's `index.md` (`security`, `claude-code`, `prompt-design`, `dev-tools`, `governance`, `expertise`, `software-design`, `frameworks`, top-level `SWE`).
