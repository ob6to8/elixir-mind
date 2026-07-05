# meta

Governance and tooling for the brain itself — a separate namespace from the knowledge
taxonomy. This is where the rules that compile into the operating contract live.

## Contents

- [policy](/meta/policy/index.md) — the `type: policy` rules that compile into `/CLAUDE.md`
- [preamble.md](/meta/preamble.md) — fixed framing text prepended to the compiled contract
- [registry.md](/meta/registry.md) — **generated** stable-id → concept view (`mix brain.registry`)

## Related tooling (not part of the knowledge bundle)

- `mix.exs`, `lib/`, `test/` — the Elixir toolchain:
  - `mix brain.contract [--check]` — compile `/CLAUDE.md` from preamble + policies.
  - `mix brain.id` — mint stable ids for bundle concepts that lack one.
  - `mix brain.registry [--check]` — compile `/meta/registry.md` (id → concept).
  - `mix brain.verify` — enforce conformance, id uniqueness/format, `verified_by`
    edge resolution, and grounding of every `verified: true`.
  - `mix brain.evidence <sb:id|path>` — derive a concept's verification narrative
    (the prose is never committed; only the edges are).
- `.github/workflows/ci.yml` — CI enforcement on every push/PR: compile, format check,
  tests, and `mix brain.contract --check` (blocks a stale or hand-edited `CLAUDE.md`).
- `.githooks/pre-commit` — optional fast local mirror of CI. Enable once with
  `git config core.hooksPath .githooks`.
- `.claude/hooks/session-start.sh` — installs Elixir in Claude-on-web sandboxes so the
  above works there too.
