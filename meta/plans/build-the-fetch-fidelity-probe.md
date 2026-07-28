---
type: plan
title: "Build the fetch fidelity probe"
description: Turn the proposed fetch-fidelity eval into a running instrument — frozen page fixtures, a two-arm runner, and a committed baseline — structured so the network-dependent arm is the only part that cannot run offline, and so the probe can actually revert the policy bullet it tests.
status: proposed
provenance: "Claude Code session, 2026-07-28 — persisted at operator direction rather than executed, since the build spans sessions"
tags: [meta, plan, eval, fetch-fidelity, quotation, tooling, elixir]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, Kimi K3 weight-release intake session"
  why: "the probe's design is filed but its build spans sessions and its executor will not share this session's context, so the decisions must survive in writing"
  from: [/meta/threads/2026-07-28-kimi-k3-weight-release-implications.md]
---

# Build the fetch fidelity probe

## The problem

[`meta/evals/fetch-fidelity-probe.md`](/meta/evals/fetch-fidelity-probe.md) is
`status: proposed`: it states the question, the hypothesis, the metrics, and the
falsification condition, but no instrument exists. That matters more here than
for the other proposed evals, because this probe's falsification condition
**reverts a live rule** — the "take the quote from the source's own text" bullet
in [quote-primary-sources](/meta/policy/quote-primary-sources.md), which is
compiled into the contract and therefore shapes every session. An unbuilt probe
leaves that rule permanently unfalsifiable, which is exactly the failure mode the
probe was filed to prevent.

The build is deferred and its executor will not share this session's context, so
per [plan-vs-capture](/meta/policy/plan-vs-capture.md) the decisions are
persisted rather than left in the thread.

## The hard constraint, and the shape it forces

The probe needs **network** — the arms are live fetches — which fails the offline
half of the [admission rule](/meta/policy/elixir-coding-standards.md). Every
other `mix brain.*` task is offline, zero-dependency, and deterministic.

**Decision: split the instrument at the network boundary.** The runner performs
fetches and writes a **transcript** of raw answers; the scorer reads that
transcript and computes metrics with pure string operations. The scorer is
therefore offline, deterministic, and unit-testable like every other task; only
the runner needs the network, and it is invoked explicitly. This keeps the
zero-dependency stance intact for everything except one opt-in command, and it
means a committed transcript can be re-scored without re-fetching when the metric
definitions change.

## Current-state tree

The closest existing instrument, and the one to mirror:

```
mix brain.dedup_probe                 Mix.Tasks.Brain.DedupProbe.run/1
├── --update-baseline                 ElixirMind.DedupProbe.update_baseline/1
│   └── rewrites the gold doc's ## Baseline in place
└── (default)                         ElixirMind.DedupProbe.report/2
    └── run/2
        ├── parse_gold!/1             ## Gold set table → [Row.t()]
        ├── search_index/1            bundle → %{path => text}
        ├── score each row            lexical hit / miss
        └── parse_baseline/1          committed ## Baseline → deltas
```

Everything above is offline and deterministic. The fidelity probe cannot be,
which is why it splits.

## Desired-state tree

```
mix brain.fetch_fidelity --run        Mix.Tasks.Brain.FetchFidelity.run/1   [NETWORK]
└── ElixirMind.FetchFidelity.run_arms/2
    ├── parse_gold!/1                 ## Gold set table → [Row.t()]
    ├── read fixture snapshot         fixture_path(row) → raw markdown
    ├── for each row × each arm       summarize | verbatim
    │   └── fetch_fn.(url, prompt)    injected seam — the ONLY network call
    └── write transcript              meta/evals/fixtures/fetch-fidelity/transcript.json

mix brain.fetch_fidelity              Mix.Tasks.Brain.FetchFidelity.run/1   [offline]
└── ElixirMind.FetchFidelity.report/2
    └── score/2
        ├── parse_gold!/1
        ├── read transcript
        ├── per row × arm             pure string predicates:
        │   ├── invented?/2           unsupported comparison present
        │   ├── supported?/2          supported claim present
        │   ├── spans_contained?/2     quoted spans ⊆ snapshot
        │   └── abstained?/1          states the page does not say it
        └── parse_baseline/1          committed ## Baseline → deltas

mix brain.fetch_fidelity --update-baseline                                  [offline]
└── ElixirMind.FetchFidelity.update_baseline/1
    └── rewrites the eval doc's ## Baseline from the committed transcript
```

The default invocation is **offline** — it scores the committed transcript.
Only `--run` touches the network. That inversion is deliberate: the common
case (re-scoring after a metric change, or in CI) must never need a network.

## File-tree diff

```
lib/
  elixir_mind/
    fetch_fidelity.ex                    # NEW — parse gold, run arms, score, render, baseline
  mix/tasks/
    brain.fetch_fidelity.ex              # NEW — task boundary; --run / --update-baseline flags
meta/evals/
  fetch-fidelity-probe.md                # MODIFIED — gold rows filled out; ## Baseline added
  fixtures/
    fetch-fidelity/
      index.md                           # NEW — reserved listing for the fixture set
      aa-briefcase-kimi-k3.md            # NEW — row 1 snapshot (raw markdown, committed)
      <three more snapshots>             # NEW — pricing table, dated spec, benchmark article
      transcript.json                    # NEW — committed raw arm answers; re-scorable
test/elixir_mind/
  fetch_fidelity_test.exs                # NEW — scorer unit tests + a stubbed-fetch scenario
```

`meta/evals/fixtures/` is a new directory under an established governance
namespace, so it is created autonomously per the
[taxonomy-evolution protocol](/meta/policy/taxonomy-evolution-protocol.md); it
needs an `index.md` like any directory.

## Call/flow trees

**Production** — `--run` is the only path that leaves the process:

```
Mix.Tasks.Brain.FetchFidelity.run(["--run"])
└── FetchFidelity.run_arms(root, fetch_fn: &WebFetchAdapter.fetch/2)
    └── fetch_fn.(url, prompt)          ← network
```

**Under test** — the seam is substituted, so no test touches the network:

```
FetchFidelity.run_arms(root, fetch_fn: fn _url, prompt -> canned_answer(prompt) end)
└── canned answers exercising each metric branch:
    invented / supported / abstained / span-not-in-snapshot
```

The scorer needs no seam at all — it reads a transcript from disk and is pure.

## Signatures

```elixir
@type arm :: :summarize | :verbatim

@spec gold_path() :: String.t()
@spec fixture_dir() :: String.t()

@spec parse_gold!(root :: String.t()) :: [Row.t()]
@spec run_arms(root :: String.t(), opts :: keyword) :: String.t()
@spec score(root :: String.t(), opts :: keyword) :: map
@spec report(root :: String.t(), opts :: keyword) :: String.t()
@spec update_baseline(root :: String.t()) :: String.t()

@spec invented?(answer :: String.t(), Row.t()) :: boolean
@spec supported?(answer :: String.t(), Row.t()) :: boolean
@spec spans_contained?(answer :: String.t(), snapshot :: String.t()) :: boolean
@spec abstained?(answer :: String.t()) :: boolean
```

`run_arms/2` and `update_baseline/1` return the written path, matching
`DedupProbe.update_baseline/1`. Argument names are given where the type does not
reveal the role, per the
[coding standards](/meta/policy/elixir-coding-standards.md).

## Boundary decisions

- **The network lives in the task's `--run` branch only.** `ElixirMind.FetchFidelity`
  never calls a fetch directly; it takes `fetch_fn` as an injected option with a
  default supplied at the task boundary.
- **The transcript is committed, not regenerated.** It is evidence, like a
  `type: source` capture: a scoring change must be re-runnable against the same
  answers, or a metric revision and a model change become indistinguishable.
- **Scoring is pure string work.** No LLM judges the answers. `invented?/2`
  matches the row's stated unsupported comparison; if a row's comparison cannot
  be detected by a string predicate, the row is badly written and gets rewritten,
  not judged by a model.
- **The eval doc owns the gold set and the baseline**; the module parses both and
  regenerates the baseline. Never hand-edit `## Baseline`, exactly as with
  dedup-probe.
- **Not a gate.** The probe never runs in the pre-commit hook or CI. It is
  invoked at decision points, and its baseline records the fetch model's version
  so a score change can be attributed.

## Anchors

- Mirror [`lib/elixir_mind/dedup_probe.ex`](/lib/elixir_mind/dedup_probe.ex) for
  gold-table parsing, baseline rewriting, and report rendering — the table
  parsing and `## Baseline` regeneration are close enough to reuse in shape.
- Mirror [`lib/mix/tasks/brain.dedup_probe.ex`](/lib/mix/tasks/brain.dedup_probe.ex)
  for the task boundary: `@impl Mix.Task`, `OptionParser` with a strict list,
  `Mix.shell().info/1`, and a moduledoc written summary-first (it compiles into
  [`meta/code-map.md`](/meta/code-map.md), so regenerate the code map).
- Test through the task boundary and the module's public surface, per the
  [testing methodology](/knowledge/SWE/testing/elixir-mind-testing-methodology.md);
  [`test/elixir_mind/dedup_probe_test.exs`](/test/elixir_mind/dedup_probe_test.exs)
  is the pattern.
- Update [`meta/evals/index.md`](/meta/evals/index.md) when `status` moves off
  `proposed`.

## Build order

1. **Fixtures first.** Commit the row-1 snapshot and write three more rows over
   different source shapes — a pricing table, a dated-revision spec, a benchmark
   article. Fixtures before code, because a row whose `unsupported` comparison
   cannot be string-detected invalidates the scorer design, and it is cheaper to
   discover that while writing rows.
2. **The scorer**, offline and fully tested against a hand-written transcript.
3. **The runner**, with the fetch seam and its default adapter.
4. **A first baseline**, recording the fetch model's version.
5. **Flip `status`** on the eval doc and update the evals index.

## Decisions, alternatives, and open questions

**Recommended shape:** the runner/scorer split above.

**Rejected — one task that fetches and scores in a single pass.** Simpler, but
it makes every re-score a fresh network run, so a metric change and a vendor
model change confound. The split costs one committed JSON file and buys
attributable scores.

**Rejected — an LLM judge for "did the answer assert the unsupported claim?"**
It would handle paraphrase, which string matching misses. But it reintroduces
the exact failure the probe measures — a model deciding what a text says — into
the instrument measuring it. Prefer rewriting an undetectable row.

**Open — how many rows before a score means anything.** Four is enough to
exercise the code and probably not enough to move the falsification condition.
The plan does not fix a number; the first baseline should be read as a smoke
test, and the row count revisited once real variance is visible.

**Open — whether `spans_contained?/2` should be exact or content-word
containment.** Exact substring is the honest test of a quotation, but whitespace
and markdown escaping in a snapshot will produce false negatives. Starting
exact, on normalized whitespace, and loosening only against observed failures is
the safer order; `mix brain.glossary`'s containment scoring is the fallback
model if exact proves unusable.

**Assumption — the fetch tool is reachable from the runner.** If it is not
callable from an Elixir task, the runner degrades to writing prompts for an
agent to execute and paste back, and the transcript format absorbs that without
the scorer changing. Worth checking before step 3, not before step 1.
