# meta

Governance and tooling for the brain itself — a separate namespace from the knowledge
taxonomy. This is where the rules that compile into the operating contract live.

## Contents

- [policy](/meta/policy/index.md) — the `type: policy` rules that compile into `/CLAUDE.md`
- [preamble.md](/meta/preamble.md) — fixed framing text prepended to the compiled contract

## Related tooling (not part of the knowledge bundle)

- `mix.exs`, `lib/`, `test/` — the Elixir contract compiler. Run `mix brain.contract`
  to regenerate `/CLAUDE.md` from the sources above; `mix brain.contract --check`
  verifies it is current.
- `.github/workflows/ci.yml` — CI enforcement on every push/PR: compile, format check,
  tests, and `mix brain.contract --check` (blocks a stale or hand-edited `CLAUDE.md`).
- `.githooks/pre-commit` — optional fast local mirror of CI. Enable once with
  `git config core.hooksPath .githooks`.
- `.claude/hooks/session-start.sh` — installs Elixir in Claude-on-web sandboxes so the
  above works there too.
