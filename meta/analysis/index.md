# Analysis

Point-in-time evaluations and decision-support write-ups — a question investigated
against evidence (often the live bundle itself), yielding findings and a
recommendation, filed so the reasoning and its conclusion persist. A separate
namespace from `plans` (intended *work* to execute) and `issues` (problems to
track): an analysis is a *reasoned judgment on a question*.

Each analysis is a `type: analysis` doc.

## Contents

- [Belief decomposition over artifacts: derive the graph, never author it](/meta/analysis/belief-decomposition-derived-vs-authored.md) — evaluates the atomic-belief-DAG idea against its own two-failure lineage (assertion graph, Composable Beliefs) and the prior art (TMS, Toulmin, decompose-then-verify, GSN, FOL/OWL); finds a derived, regenerable overlay escapes the authored-store failure mode and recommends the analysis-mode plan.
- [Would a vector DB improve recall as this bundle scales?](/meta/analysis/vector-db-recall-for-the-scaling-bundle.md) — a dedup-recall probe over the live corpus finds grep already misses existing concepts on natural-phrasing (semantic, not typographic) queries; recommends synonym-expanded intake dedup + a repeatable recall probe over any standalone vector DB.
