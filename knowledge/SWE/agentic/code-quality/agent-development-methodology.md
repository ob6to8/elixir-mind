---
id: em:cab2c5
type: methodology
title: "Agent development methodology — TDD-first, atomic PRs, review-gated"
description: The operator's global-tier methodology for agent-driven development — a test-first loop where tests are the ratified contract agents may not weaken, matklad-style test architecture, an Elixir-specific fast loop, one-concern PRs sized for review, and layered gates that spend human attention only on judgment — with the lean vendorable block consuming repos embed.
provenance: "Claude Code session (Claude Fable 5), 2026-08-01 — synthesized from the TDD research spike: Gorman, the matklad references, the 2024–26 test-first and reward-hacking literature, and the Elixir ecosystem sources"
tags: [methodology, agentic, tdd, testing, atomic-prs, code-review, elixir, agent-guidance]
timestamp: 2026-08-01
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
## Development methodology (global tier v1, 2026-08-01 — source: elixir-mind em:cab2c5)

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

### Delivery
- One self-contained matter per PR, with its tests; never mix refactoring
  with behavior changes. Size is a signal, not a cap: ~50–200 changed lines
  is typical of one concern, mechanical bulk (renames, regenerations, format
  sweeps) is exempt, and no split may leave a commit that doesn't compile
  and pass.
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
