---
id: em:cab2c5
type: methodology
title: "Agent development methodology — TDD-first, atomic PRs, review-gated"
description: The operator's global-tier methodology for agent-driven development — a test-first loop where tests are the ratified contract agents may not weaken, matklad-style test architecture, an Elixir-specific fast loop, one-concern PRs sized for review, and layered gates that spend human attention only on judgment — with the lean vendorable block consuming repos embed.
provenance: "Claude Code session (Claude Fable 5), 2026-08-01 — synthesized from the TDD research spike: Gorman, the matklad references, the 2024–26 test-first and reward-hacking literature, and the Elixir ecosystem sources"
tags: [methodology, agentic, tdd, testing, atomic-prs, code-review, elixir, agent-guidance]
timestamp: 2026-08-02
attribution:
  when: 2026-08-01T18:20:00Z
  channel: agent-authored
  agent: "Claude Code agent, TDD research-spike session"
  why: "the operator asked to implement a stricter development methodology, TDD-ranked and matklad-prioritized, for agent-driven work"
---

# Agent development methodology — TDD-first, atomic PRs, review-gated

The **global tier** of the operator's development methodology: what binds every
agent session in every consuming repo. The evidence and ranking behind it are
in [where TDD ranks for coding-agent development](/meta/analysis/tdd-rank-for-coding-agent-development.md);
the storage/distribution design is the
[two-level guidance plan](/meta/plans/two-level-agent-methodology-guidance.md).
Repos embed only the [vendorable block](#the-vendorable-block) below; this doc
is the canonical, ratified source it derives from.

## 1. The loop — test-first, one behavior at a time

Work red → green → refactor, at behavior granularity:

1. **State the behavior** (one sentence, or one example pair) before any code.
2. **Write the failing test and run it** — a test never seen red proves
   nothing.
3. **Implement minimally to green.** Run the *focused* test, not the world.
4. **Refactor on green** — one smell at a time, re-running tests after each.
5. **Commit on green; revert on red** that resists a bounded fix — only
   working code may enter the next step's context.

Why this loop for agents specifically: small steps keep each interaction
inside the model's effective context; broken code left in context poisons
subsequent predictions; and examples-as-tests specify intent more precisely
than prose ([Gorman](/knowledge/SWE/agentic/code-quality/why-tdd-works-in-ai-assisted-programming.md)).
Keep **3–5 focused tests** in play per behavior — the measured optimum;
dumping a whole suite into context *degrades* generation.

## 2. Tests are the contract

- **The test suite is the ratified spec surface.** An agent never weakens,
  skips, deletes, or special-cases a test to make it pass. A genuinely wrong
  test is changed in its own visible step, with the reason stated.
- **A failing test is information, never an obstacle.** The documented failure
  mode — agents editing tests, overloading equality, exiting before asserts —
  is why this rule is absolute, not stylistic.
- **Humans review tests hardest.** When the agent writes most implementation
  code, the tests are where review attention buys correctness; the human adds
  the edge cases the agent missed.

### Protecting the contract

The rules above bind the agent; this is how the tests are held beyond its
reach when instruction alone is not enough. Four rungs, escalating by
threat — pick the lowest that fits the stakes, knowing mechanism beats
instruction (blocking a single cheat route diverts agents to others —
ImpossibleBench):

1. **Instructed** — "do not modify tests" stated in the agent's context,
   tests committed before implementation begins. The weakest rung, yet
   measurably real: a strict prompt cut one measured cheat rate 92%→1%.
2. **Procedural** — red confirmed before green (guards against vacuous
   tests); any test change in its own visible commit with the reason
   stated. This section's standing rules.
3. **Mechanical** — the agent *can* see but *cannot* touch: test-path edits
   denied during implementation via hooks/permissions, or roles split so
   one agent writes the tests and another implements. Visible-but-immutable
   is the marking Beck wished tests could carry, and it is buildable today.
4. **Held out** — tests the implementing agent never sees, run only at the
   gate (CI- or operator-held): the eval community's train/test split
   applied to development. Visible-suite saturation (SpecBench: held-out
   pass collapses as visible suites grow) and METR's finding that
   visibility of the scoring signal raises hacking argue for this rung on
   high-stakes contracts.

Rung 4 does not move the working suite out of the repo — the loop's
iteration oracle stays in-repo, visible, and fast (§1). The shape is the ML
two-set split: the working suite as the dev set, plus a thin held-out slice
(acceptance/spec-guard tests) for high-stakes contracts only, revealed as
pass/fail at the gate. Implementations, weakest to strongest: edit-denied
test paths (rung 3); a private sibling repo or CI-held secret suite —
cloud-session repo scoping enforces that visibility boundary mechanically;
operator-local runs at review; gate-time *generated* tests (fresh-randomness
property/fuzz runs — nothing to memorize, no shadow suite to maintain). The
costs that gate the rung by stakes: held-out failures are slower to debug
(choose a disclosure policy per slice), a shadow suite is real upkeep, and
every failure disclosure spends the holdout the way eval reuse causes
contamination — rotate or regenerate the slice. Consuming repos name their
rung and wire its mechanics in the repo tier; this repo's gate suite sits
at rungs 2–3, proportionate to its stakes.

## 3. Test architecture (the matklad tier)

- **Test features and observable contracts, not internals** — a test that
  breaks under a refactor that preserves behavior is coupled to the wrong
  thing ([test features, not code](/knowledge/SWE/testing/how-to-test-features-not-code.md)).
- **Optimize purity; let extent be natural.** Keep logic sans-IO so most
  tests are pure, fast, and unflakeable; don't shrink test extent by mocking
  your own code — **mock impure IO boundaries only**
  ([purity and extent](/knowledge/SWE/testing/unit-vs-integration-purity-and-extent.md)).
- **Funnel cases through a shared check helper / fixture builder**; drive from
  serializable data so cases survive interface changes.
- **Climb to properties** for universal invariants (round-trips, idempotence,
  bounds); keep example tests for specified behaviors.

## 4. Elixir specifics

- **Contracts are behaviours; mocks are nouns.** Every external dependency
  gets a behaviour; test doubles are Mox mocks defined against it —
  "mock" as a noun, never ad-hoc global rewriting — which is what keeps the
  suite `async: true`-safe and the loop fast.
- **The inner loop**: `mix compile --warnings-as-errors` →
  `mix test path/file_test.exs:LINE` or `mix test --stale --max-failures 1` →
  `mix test --failed` → full `mix test --warnings-as-errors` +
  `mix format --check-formatted` before commit. Tag slow/integration suites
  and exclude them from the tight loop.
- **Doctests for example-shaped contracts**; **StreamData** properties for the
  pure core, where shrinking hands back minimal counterexamples.

## 5. Atomic delivery

- **One self-contained concern per PR** — a behavior with its tests, or a
  refactor, never both mixed. **The matter is the unit; size is a signal,
  never the gate.** ~50–200 changed lines is the natural weight of one
  concern, and unexplained bulk is a smell to justify — but a large diff
  carrying one mechanical intent (a rename, a regeneration, a format sweep)
  is one reviewable decision, and a small diff carrying two separable
  decisions still splits. Small PRs review faster, revert less, and draw more
  comments per line — and with agents the constraint has inverted: generation
  is cheap and **review is the bottleneck**, so output must be decomposed to
  fit reviewer attention, not batched to amortize it.
- **Every commit compiles and passes tests.** Stack dependent PRs rather than
  letting one grow.
- **Refactorings ship separately** from behavior changes.

## 6. Layered gates — spend human attention on judgment only

1. Machine gates: compile clean, format, full tests, lint — before any human
   looks.
2. Agent self-review of the diff (cheap, catches real issues).
3. Human review: architecture, intent-vs-tests alignment, and the tests
   themselves.

## 7. Stop discipline

Three failed attempts at the same issue → stop; write down what was tried,
the exact errors, and the current hypothesis; reassess the approach (or
escalate to the operator) instead of thrashing. Document-then-reassess beats
a fourth attempt with poisoned context.

## The vendorable block

Consuming repos paste this verbatim into `CLAUDE.md` (per the
[two-level plan](/meta/plans/two-level-agent-methodology-guidance.md)), then
add repo specifics beneath it: the concrete test/build/lint commands, the
test-layer map, and any deviation — which must name the rule it overrides.
The Elixir annex is included only in Elixir repos.

```markdown
## Development methodology (global tier v1, 2026-08-02 — source: elixir-mind em:cab2c5)

### The loop
- Work test-first, one behavior at a time: write the failing test, RUN it and
  see it fail, implement minimally to green, refactor on green, commit.
- Keep 3–5 focused tests in play per behavior; run the focused test while
  iterating, the full suite before committing.
- Only working code enters the next step: commit on green; if a change resists
  a bounded fix, revert rather than pile on.

### Tests are the contract
- NEVER weaken, skip, delete, or special-case a test to make it pass. If a
  test is genuinely wrong, change it in its own commit and state why.
- Test observable behavior/contracts, not internals; a refactor that preserves
  behavior must not break tests.
- Mock only IO boundaries (network, clock, filesystem, external services) —
  never the project's own modules.
- Test protection escalates by stakes: instructed (this block) → procedural
  (red confirmed first; test changes in their own visible commits) →
  mechanical (test-path edits denied, or test-writer and implementer roles
  split) → held out (gate-time tests the implementing agent never sees).
  The repo tier names its rung and wires the mechanics.

### Delivery
- One self-contained matter per PR, with its tests; never mix refactoring
  with behavior changes. Size is a signal, not a cap: ~50–200 changed lines
  is typical of one concern, a large diff carrying one mechanical intent
  (a rename, a regeneration, a format sweep) is still one matter, and no
  split may leave a commit that doesn't compile and pass.
- Every commit compiles and passes the full suite.
- After 3 failed attempts at the same issue: stop, document what was tried and
  the exact errors, reassess the approach.

### Elixir annex
- Every external dependency sits behind a behaviour; test doubles are Mox
  mocks against that behaviour (keeps `async: true` safe). No ad-hoc mocking.
- Inner loop: `mix test <file>:<line>` or `mix test --stale --max-failures 1`;
  then `mix test --failed`; before commit: `mix test --warnings-as-errors`
  and `mix format --check-formatted`.
- Use doctests for example-shaped contracts and StreamData properties for
  pure-core invariants. Tag slow/integration tests and exclude them from the
  tight loop.
```

## Claim provenance (temporary format)

Per-claim source mapping, persisted from the originating session's research
before its context dies. **Temporary format**: pending phases 3–4 of the
[span-level attribution plan](/meta/plans/span-level-attribution.md), each row
converts one-to-one into an `<attr>` span plus structured provenance — the
*claim anchor* is the future span's content anchor. Basis for every row:
**search** (retrieved during the 2026-08-01 spike, not model memory); verbatim
quotes and figures are held in
[the ranking analysis](/meta/analysis/tdd-rank-for-coding-agent-development.md)'s
evidence sections and citations. The §2 protection-ladder rows (added
2026-08-02) draw on that same spike evidence through its persisted records —
the ranking analysis and the
[origin thread](/meta/threads/2026-08-01-tdd-research-spike-and-methodology-adoption.md)'s
protection-ladder exchange — plus one 2026-08-02 fetch recorded in its row.

| § | claim anchor | class | sources |
|---|---|---|---|
| 1 | "a test never seen red proves nothing" | synthesis | Willison, red/green TDD pattern (2026-02: confirm failure before implementing, else the test may be vacuous); Anthropic best practices (2025-04: confirm tests fail before coding); [Gorman](/knowledge/SWE/agentic/code-quality/why-tdd-works-in-ai-assisted-programming.md) `em:e7644d` |
| 1 | "3–5 focused tests … the measured optimum" / whole suite "degrades generation" | synthesis | TENET (arXiv 2509.24148: 3 selected tests 49.18% vs full-suite 33.06%); WebApp1K (2505.09027: doubling tests collapses pass@1) |
| 1 | "Commit on green; revert on red" / only working code enters context | synthesis | Gorman `em:e7644d` (commit-on-green practice; broken-code-as-context argument) |
| 1 | "small steps keep each interaction inside the model's effective context" | synthesis | Gorman `em:e7644d`; [context rot](/knowledge/SWE/agentic/context-engineering/context-rot-chroma-research.md) `em:77d68a` |
| 2 | "never weakens, skips, deletes, or special-cases a test" | synthesis | Beck (2025-06: agent "cheating, for example by disabling or deleting tests"); Böckeler (2025-08: success declared over red tests); METR (2025-06); ImpossibleBench (2510.20270); Anthropic emergent-misalignment (2025-11) |
| 2 | "agents editing tests, overloading equality, exiting before asserts" | synthesis | ImpossibleBench cheat taxonomy; Anthropic (`sys.exit(0)` harness escape) |
| 2 | "Humans review tests hardest" | synthesis | Anthropic (2025-04: commit tests once satisfied with them); Willison (2025-03: testing cannot be outsourced to the machine); Dunlop (2026-04: passing AI-written suite enshrined a bad UX — the counter-case this rule answers) |
| 2 | "mechanism beats instruction" / "blocking a single cheat route diverts" | synthesis | ImpossibleBench (2510.20270: blocking one cheat route diverts to others); via the ranking analysis's qualification 3 |
| 2 | "a strict prompt cut one measured cheat rate 92%→1%" | synthesis | ImpossibleBench mitigation data, figure held in the ranking analysis ("strict prompts cut one measured cheat rate 92%→1%") |
| 2 | rung 1 "tests committed before implementation" / rung 3 test-writer/implementer role split | synthesis | Anthropic best practices (2025-04: tests committed before coding; separate test-writer and implementer agents) |
| 2 | "the marking Beck wished tests could carry" | synthesis | Beck, Pragmatic Engineer interview (2025-06) as retrieved in the spike and recorded in the origin thread; kept synthesis, not quote — the span is not reproducible from the reachable pages (Substack post + interview free page, fetched 2026-08-02) |
| 2 | rung 4: "held-out pass collapses as visible suites grow" / "visibility of the scoring signal raises hacking" / "rotate or regenerate the slice" | synthesis | SpecBench (2605.21384: held-out pass collapsing ~28pp wider per 10× LOC); METR reward-hacking (2025-06); the eval-reuse contamination parallel assembled in the origin thread |
| 3 | "Test features and observable contracts, not internals" | synthesis | matklad `em:a5ea86` (the neural-network test) |
| 3 | "mock impure IO boundaries only" | synthesis | matklad `em:73115b`; Valim (2015) |
| 4 | "'mock' as a noun, never" a verb | quote | Valim (2015): "I always consider 'mock' to be a noun, never a verb"; Mox docs (behaviour-bound doubles keep `async: true` safe) |
| 4 | inner-loop flags (`--stale`, `--failed`, `--max-failures`) | synthesis | hexdocs `mix test` documentation |
| 4 | doctests as example contracts; StreamData shrinking | synthesis | hexdocs ExUnit + StreamData documentation |
| 5 | "Small PRs review faster, revert less, and draw more comments per line"; ~50–200-line weight | synthesis | Google eng-practices small-CLs; Graphite 50-line data (≈40% faster review, ≈15% fewer reverts) |
| 5 | "review is the bottleneck" | synthesis | Graphite (2025-10: "code review is the new bottleneck"); Codacy 2026 roundup citing CircleCI (feature-branch throughput +59% while main-branch throughput stalls) and LinearB 2026 (agentic PRs wait 5.3× longer for pickup, run 154% larger) |
| 7 | "Three failed attempts at the same issue → stop" + document what was tried | synthesis | Dzombak `em:49315a` ("Maximum 3 attempts per issue, then STOP") |

# Citations

Synthesized from the sources filed in this directory and the research spike's
evidence base — primarily
[Gorman](/knowledge/SWE/agentic/code-quality/why-tdd-works-in-ai-assisted-programming.md),
[Dzombak's playbook](/knowledge/SWE/agentic/code-quality/getting-good-results-from-claude-code.md),
the matklad pair
([features](/knowledge/SWE/testing/how-to-test-features-not-code.md),
[purity/extent](/knowledge/SWE/testing/unit-vs-integration-purity-and-extent.md)),
and the quantitative record assembled in
[the ranking analysis](/meta/analysis/tdd-rank-for-coding-agent-development.md)
(test-first gains, dose effects, PR-size and review-queue data, reward-hacking
mitigations).

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:cab2c5">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-01-tdd-research-spike-and-methodology-adoption (2026-08-01)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:cab2c5`]**

The dials in it that are preference rather than evidence-forced: the 3-attempt stop, the 3–5-focused-tests working set, "test-first by default" (vs. a harder "always"), and the Mox/behaviour mandate. Note the Delivery bullet still carries the "is exempt" wording matter C would fix, and matter D below would add a test-protection line — so the clean sequence is: you rule on C and D, I apply, then you ratify the resulting block once (matter A).

---

**[`em:cab2c5`]**

Proto-granular, done now — citations-as-enough would have bet the mapping on this session's memory surviving until PR 3, and this session has already been through one context compaction. The doc now carries a **`## Claim provenance (temporary format)`** section: fifteen rows, one per prescriptive claim, each with a verbatim *claim anchor* (which becomes the `<attr>` span's content anchor under the span-attribution plan — the rows convert one-to-one, so nothing is thrown away at refactor time), its class (`synthesis`, one `quote` — Valim's mock-as-noun line), basis (`search` — every row was retrieved this session, none from model memory), and its sources (the `em:` captures, the arXiv ids with their figures, Beck/Böckeler/METR/Anthropic for the never-weaken rule, Google/Graphite/Codacy for the delivery numbers, hexdocs for the Elixir mechanics).

### 2026-08-02-methodology-finalization (2026-08-02)

3 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:cab2c5`]**

I now have the complete picture of the matter. Before executing, I need the supporting refs: the ranking analysis (which holds the protection-ladder evidence), the two-level guidance plan (which governs the block's versioning), and the matter-queue plan (which governs how a consumed row is closed out). Let me also map every "exempt" occurrence.

---

**[`em:cab2c5`]**  (co-feeds: `meta/policy/git-atomic-pull-requests.md`)

Branch is set up at `origin/main` (PR #225's merge), working tree clean. The policy body already carries the correct framing — only its `description` frontmatter, the index gloss, and the vendorable block have the "exempt" defect. Let me create the task list and verify the Beck "immutable annotation" quote from its primary source before I write it into the doc.

---

**[`em:cab2c5`]**

Verification outcome: the "immutable annotation" span is not reproducible from either reachable Beck source (the Substack post yields only "Any indication that the genie was cheating, for example by disabling or deleting tests"; the interview's free page only confirms the deleting-tests problem; the full transcript is podcast-gated). Per the quote-primary-sources policy, that phrase gets no quotation marks — I'll attribute it as synthesis and record exactly that in the provenance row.

Now applying the edits to the methodology doc — (b) the subsection under §2:
