# Specs

Design specs and implementation plans — durable records of decisions, rationale,
and build order for changes to the brain's shape or tooling. Governance namespace
(no `sb:` ids), like `tutorials` and `threads`. A spec is persisted once the
operator approves it, per the [persist-specs policy](/meta/policy/persist-specs.md);
it carries a `status` (`draft` · `approved` · `superseded`) and keeps any
commissioned design review alongside the plan. Distinct from `tutorials` (the
*why* behind existing tooling) and `policy` (the standing rules): a spec is the
*plan for a change not yet fully built*.

## Contents

- [The flows genre + formal scenario testing](/meta/specs/flows-genre-and-scenario-testing.md) — collapse the capture flow's overlapping prose docs into one `meta/flows/` doc, back it with a scenario test over the deterministic tool spine, and keep the skill as the terse agent procedure; includes the harness research spike.
