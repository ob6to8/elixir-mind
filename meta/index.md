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
