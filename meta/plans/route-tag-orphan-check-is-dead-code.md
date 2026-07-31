---
type: plan
title: "Repair the route-tag orphan check: an assignment-as-filter makes the no-such-thread branch unreachable"
description: The log-fidelity orphan clause in ElixirMind.RouteTags binds `t = by_slug[slug]` inside a comprehension, where a bare assignment acts as a filter — so a block naming a thread that does not exist is dropped before the `t == nil` test runs, and a hand-written excerpt block passes the gate.
status: done
provenance: "model undisclosed"
tags: [meta, plan, route-tags, verifier, gate-suite, elixir, dead-code]
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed session on the /review-pr audit"
  why: "operator asked for a plan building the mechanical check that would catch a hand-written route-tag block; the check already exists and is silently unreachable"
---

# Repair the route-tag orphan check

## Outcome

**Done**, executed in the session that filed it, in the planned order. The
regression test failed first with `log fidelity :ok` over a fabricated block;
the sentinel lookup turned it green and simultaneously turned
`mix brain.route_tags` **red on the live bundle** —
`em:712e01: block for 2026-07-31-agent-says-done-reconciliation-patterns but no
such thread` — which is the check firing for the first time. Rewriting that
block as body prose returned the suite to green at 189 tests.

The open question below — does the same assignment-as-filter shape appear
elsewhere in `lib/`? — was **swept and closed**. Across 13 comprehensions in 5
files (`glossary`, `contract`, `dedup_probe`, `site`, `route_tags`), three
assignments sit inside a comprehension and all are in `route_tags.ex`: `:431`
(the sentinel fix), `:421` (`Enum.filter/2` returns a list, and `[]` is truthy —
safe), and `:419` (`block = get_in(…)`, which *is* the same shape and *is* a
filter, but benignly: the divergent clause wants only pairs whose block exists,
and a missing block is `check_sink_logs`' business).

`:419` leaves a fingerprint worth recognizing in future review: the next line,
`block != nil`, can never be false, because the assignment already dropped those
rows. A redundant nil-guard immediately after an assignment in a comprehension
is the signature of this misreading — the author wrote the check the semantics
had silently already applied. It is left in place; deleting it buys nothing.

## The problem

The route-tagged excerpt log is declared a **generated** artifact:
[route-tagging](/meta/policy/route-tagging.md) holds that the section is
"**generated, not hand-kept** — `mix brain.route_tags --materialize` writes it
from the current tags", and the verifier's job is to make that freshness
structural rather than procedural. `ElixirMind.RouteTags.check_log_fidelity/2`
carries two clauses for this: `divergent` (a block that no longer matches its
re-derivation) and `orphans` (a block whose thread no longer tags the sink, or
does not exist at all).

The orphan clause cannot fire on the second case. It reads:

```elixir
for {sink, %{blocks: blocks}} <- sinks,
    {slug, _} <- blocks,
    t = by_slug[slug],
    t == nil or not Enum.any?(t.regions, &(sink in doc_refs(&1.refs))),
    do: "#{sink}: block for #{slug} but #{if t, do: "…", else: "no such thread"}"
```

In an Elixir comprehension every expression that is not a generator is a
**filter**. `t = by_slug[slug]` is an assignment whose value is the map lookup,
so when the slug names no thread the lookup returns `nil`, the filter is falsy,
and the row is discarded — before reaching the `t == nil` test written to catch
exactly that row. The `else: "no such thread"` branch of the message is
unreachable code.

Measured, not inferred:

```
blocks = %{"real" => [], "ghost" => []}          # by_slug has only "real"
for {slug, _} <- blocks, t = by_slug[slug], t == nil or true, do: slug
#=> ["real"]                                      # "ghost" silently dropped
```

**The live instance.** `knowledge/SWE/agentic/supervision/normative-records-vs-descriptive-traces.md`
(`em:712e01`) currently carries a hand-written block headed
`### 2026-07-31-agent-says-done-reconciliation-patterns`. No such file exists
under `meta/threads/`. `scan_sinks/2` parses the block, `scan_threads/1` yields
no matching thread, and `mix brain.route_tags` reports
`[ok] log fidelity: 195 materialized block(s) match their re-derivation`. The
gate is green over a document containing a citation to a session record that was
never captured.

The failure shape matters more than the instance: a generated section whose
generator is not the only writer, guarded by a check that cannot see the one
edit a human is most likely to make by hand.

## Current state

```
check_log_fidelity(threads, sinks)
├── divergent ─ for each (thread, sink) feeding pair with a block present
│   └── normalize(block) != normalize(derive_block(…))    → fail        ✓ works
└── orphans ─ for each sink block
    ├── t = by_slug[slug]                                  → FILTER      ✗ drops nil
    ├── t == nil                                           → unreachable ✗
    └── not Enum.any?(t.regions, sink in refs)             → fail        ✓ works
```

## Desired state

```
check_log_fidelity(threads, sinks)
├── divergent ─ unchanged
└── orphans ─ for each sink block
    ├── thread = Map.get(by_slug, slug, :no_such_thread)   → BINDING, never falsy
    ├── thread == :no_such_thread                          → fail  "no such thread"
    └── not Enum.any?(thread.regions, sink in refs)        → fail  "no longer tags"
```

The sentinel is the whole fix: any non-`nil`, non-`false` value restores the row
to the filter chain. Nothing else in the check's contract changes — same check
name, same `:fail` status, same two message forms, both now reachable.

## File-tree diff

```
lib/elixir_mind/route_tags.ex                 # MODIFIED — orphan clause: sentinel lookup
test/elixir_mind/route_tags_test.exs          # MODIFIED — regression test per branch
knowledge/SWE/agentic/supervision/
  normative-records-vs-descriptive-traces.md  # MODIFIED — remove the hand-written block
```

No new modules, no new mix task, no new gate. The check is already wired into
`run_checks/1`, `mix brain.route_tags`, CI, and the pre-commit hook.

## Call topology

Production — unchanged; only the marked frame's internals move:

```
mix brain.route_tags
└── RouteTags.run_checks/1
    ├── scan_threads/1          → [%{slug, regions, …}]
    ├── scan_sinks/2            → %{id => %{path, blocks}}
    └── check_log_fidelity/2    ← the repair lands here
```

Test — the seam is the filesystem, so scenario tests build a bundle in `tmp_dir`
and call `run_checks/1`; no module is substituted:

```
route_tags_test
└── tmp bundle fixture
    ├── thread tagging a sink + matching block      → :ok
    ├── block whose thread file is absent           → :fail  "no such thread"   # NEW
    └── block whose thread no longer tags the sink  → :fail  "no longer tags"   # guard
```

The second existing-behavior case is written alongside the new one deliberately:
the two branches share a clause, and a future edit that fixes one by breaking the
other should fail.

## Signatures

No public API changes. `check_log_fidelity/2` stays private with its current
shape:

```elixir
@spec check_log_fidelity([thread :: map()], sinks :: map()) :: result
```

`result` is the module's existing `{String.t(), status, String.t()}`.

## Boundary decisions

- **The verifier detects; it never repairs.** `check_log_fidelity/2` reports the
  orphan and fails. Removing the offending block stays a human or
  `--materialize` action — a check that silently rewrote the document would
  destroy the evidence it exists to surface.
- **The existing document is fixed in this change, not tracked separately.** The
  repair turns the gate red on `main`; landing the fix without landing the
  content correction would leave the suite failing.
- **The hand-written content is not deleted outright.** Its substance moves into
  the concept's body as ordinary prose — the material is sound, only its
  placement in a generated section was wrong.

## Anchors

| What | Where |
|---|---|
| The defect | `lib/elixir_mind/route_tags.ex:425` (`orphans` comprehension) |
| Enclosing check | `check_log_fidelity/2`, `lib/elixir_mind/route_tags.ex:414` |
| Sink parsing | `scan_sinks/2` and `parse_log_section/1`, same file, from `:241` |
| Thread parsing | `scan_threads/1`, same file, from `:93` |
| Test file | `test/elixir_mind/route_tags_test.exs` |
| Policy the check enforces | [route-tagging](/meta/policy/route-tagging.md) |
| The live orphan | `em:712e01`, block `### 2026-07-31-agent-says-done-reconciliation-patterns` |

## Build order

1. Add the two regression tests; confirm the `no such thread` case fails
   (red before green — this defect is invisible without it).
2. Apply the sentinel lookup; both tests pass.
3. Rewrite the `em:712e01` block as body prose, so the suite is green.
4. Run the full gate suite.

## Decisions, alternatives, open questions

**Recommended shape: the sentinel lookup.** One expression, no restructuring,
keeps the two message branches in one clause where they belong.

**Alternatives rejected.**

- *Split the orphan check into two comprehensions,* one over slugs absent from
  `by_slug` and one over slugs present but untagged. Correct and slightly more
  legible, but doubles a clause that reads fine once the binding is not a filter.
- *Bind with a generator* (`thread <- [by_slug[slug]]`). Fixes the falsy-drop but
  reads as a trick; the sentinel says what it means.
- *A separate `mix brain.*` task validating excerpt-block headers.* Rejected: the
  check exists and is wired everywhere it needs to be. Adding a second checker
  for a live defect in the first is how a suite accretes overlapping partial
  checks.
- *Have the check auto-remove orphan blocks.* Rejected under the boundary
  decision above.

**Open question — is this pattern elsewhere in `lib/`?** A comprehension binding
a map lookup that can legitimately be `nil` has the same silent-drop shape
wherever it appears. This plan does not sweep for it; a grep for `= .*\[` inside
`for` comprehensions across `lib/` is cheap and belongs in the same session if
the executing agent has budget for it. Whether the sweep finds anything is
unknown — the claim here is scoped to the one clause measured.

**Not in scope.** The second check discussed alongside this one — warning when an
intake commit files a bundle `reference` without touching
[`meta/evals/dedup-probe.md`](/meta/evals/dedup-probe.md) — is deliberately
deferred at operator direction and is not part of this plan.
