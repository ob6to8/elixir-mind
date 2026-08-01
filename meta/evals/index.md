# evals

Eval gold sets, designs, and their baselines — the **repeatable instruments** that
measure the brain's behavior against constructed ground truth, filed so a
measurement can be re-run as the corpus grows rather than done once by hand. A
separate genre from [`analysis`](/meta/analysis/index.md) (a *point-in-time* judgment
on a question): an eval is an instrument that re-scores. A `status: proposed` eval
files the instrument's design (question, hypothesis, method, metrics, falsification
condition) ahead of building it, so the measurement intent survives until the
instrument exists.

Each eval is a prose-bearing markdown doc (a gold set's table is parsed by a
`mix brain.*` task); governance namespace (no `em:` id, like plans and threads).

**A `proposed` backlog is the intended state, not a debt to clear**
(operator-ratified 2026-07-28). Designs accumulate here and are built when a
question actually needs answering, so a growing count of unbuilt instruments is
not a trigger for a pruning sweep — do not propose one. The design *is* the
artifact: it preserves the measurement intent, and an eval filed years before it
runs still beats a question re-derived from scratch. Where an unbuilt probe
guards a live rule, the build is escalated by filing a plan (see
[build the fetch fidelity probe](/meta/plans/build-the-fetch-fidelity-probe.md)),
not by pressure from the backlog's size.

## Contents

- [Dedup recall probe](/meta/evals/dedup-probe.md) — the id-keyed gold set of
  natural-phrasing dedup queries scored by
  [`mix brain.dedup_probe`](/lib/mix/tasks/brain.dedup_probe.ex): can the mechanical
  search layer find the concept a new item should merge into? Seeded from the vector-DB
  recall analysis's 14 probes; carries `target`/`negative`/`quarantine` bands, synonym
  variants for `--expanded` mode, and a committed baseline.
- [Priorities recitation vs harness task reminders](/meta/evals/priorities-recitation-vs-harness-reminders.md)
  — `status: proposed`. A behavioral A/B: does reciting the brain's own objectives
  (active plan goal, `/priorities` top-3) into agent context change behavior beyond
  the harness's built-in task-state reminders? Designed with candidate metrics
  (open-strand pickup, first-action alignment, redirections, drift) and an explicit
  falsification condition; instrument not yet built.
- [Fetch fidelity probe](/meta/evals/fetch-fidelity-probe.md) — `status: proposed`.
  Does a summarizing fetch assert **comparisons** its source never states, and does
  demanding a verbatim span suppress them? The downstream half of source recall —
  recall asks *did you find the source*, fidelity asks *did you report what it said*
  — and the one probe here whose ground truth is decidable by string containment
  rather than judgment. Behavioral A/B over frozen page snapshots, seeded with a
  real observed interpolation, with a falsification condition that would revert the
  verbatim bullet in
  [quote-primary-sources](/meta/policy/quote-primary-sources.md); instrument not yet
  built.
- [Source recall probe](/meta/evals/source-recall-probe.md) — `status: proposed`.
  When an agent researches a subject, does its search surface the subject's
  *known-complete* primary-source set, and does an enumerated host map improve that
  recall? The upstream measurement for
  [negative-findings-name-their-scope](/meta/policy/negative-findings-name-their-scope.md):
  a caveat rule is only addressable if the agent can know what it missed. Behavioral
  A/B (unaided vs map-equipped), gold set seeded with a real observed miss, and a
  falsification condition that would retire the source map and revert the `/intake`
  amendment.
- [Re-derivation vs. recall under context pressure](/meta/evals/re-derivation-vs-recall.md) —
  when a fact is both in context and cheaply re-derivable from an artifact, does the
  agent re-derive or recall, and does the ratio move as a session lengthens? Design
  only; four instances across two sessions, one of them recorded independently by an
  earlier session that reached the same conclusion. `status: proposed`.
- [Belief-graph grounding eval](/meta/evals/cb-eval-export/MANIFEST.md) — an
  external snapshot, not a `mix brain.*`-scored instrument built here: the
  apples/fruit `conceptual-prototype/` that surfaced a logical-composition gap, and
  the `purity-test/` prose-vs-assertion-DAG run it motivated. Byte-identical import
  from `amieval/evals` (branch `claude/agent-grounding-eval-gwdvej`, commit
  `3545da7a191f676073df8ecfe369d1a7ba430fa7`); see its own `MANIFEST.md` for exact
  contents and exclusions.
