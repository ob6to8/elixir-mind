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
