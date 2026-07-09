# Tutorials

Long-form explanatory notes about how the brain's tooling and governance work —
the "why", written to be read start to finish. Distinct from `policy` (the rules
that compile into the contract) and `threads` (verbatim conversation archives).

## Contents

- [Why the brain's toolchain runs offline in CI and any sandbox](/meta/tutorials/why-the-toolchain-runs-offline.md) — how zero external dependencies (`deps: []`) let every `mix brain.*` task, including the site generator, build with no network, and the CI/sandbox specifics that make that matter.
- [What makes a commit show as "Verified" on GitHub](/meta/tutorials/what-makes-a-commit-verified-on-github.md) — author vs committer identities, why "Verified" is a signature check (not an email), why re-authoring an agent commit to `noreply@anthropic.com` lets this environment's signature attach, and the only-rewrite-unpushed-commits rule.
