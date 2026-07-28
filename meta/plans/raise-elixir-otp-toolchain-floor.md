---
type: plan
title: "Raise the Elixir/OTP toolchain floor"
description: Move the repo off Ubuntu's packaged Elixir 1.14/OTP 25 to 1.17+/OTP 26+, in the order environment-setup-script first and repo pins second, since the sandbox toolchain is environment configuration rather than a repo artifact and reversing the order bricks brain tasks in every new session.
status: proposed
tags: [meta, plan, tooling, elixir, otp, ci, sandbox]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, secure-financial-agent architecture session"
  why: "operator asked for the process to raise the pin after the investigation showed the current floor is an unexamined distro default, not a decision"
  from: [/meta/threads/2026-07-27-secure-financial-agent-and-projects-namespace.md]
---

# Raise the Elixir/OTP toolchain floor

## The problem

The repo pins `elixir: "~> 1.14"` in `mix.exs`, and both `.github/workflows/ci.yml`
and `.github/workflows/pages.yml` pin `otp-version: "25"` / `elixir-version: "1.14"`.

That floor was never a decision. The cloud sandbox reports:

```
elixir  1.14.0.dfsg-2   from  archive.ubuntu.com/ubuntu noble/universe
erlang-base  1:25.3.2.8+dfsg-1ubuntu4.6
Ubuntu 24.04.4 LTS (Noble Numbat)
```

`1.14.0.dfsg-2` is exactly what `apt install elixir` yields on Ubuntu 24.04. The
repo pins were written to match whatever the sandbox happened to ship, and Elixir
1.14 dates from September 2022. Claude Code's documented pre-installed toolchains
do not include the BEAM at all, so Elixir is arriving through an environment
setup script rather than the base image.

**Nothing currently needs the raise.** The toolchain is zero-dependency and
standard-library-only, so it compiles and passes on 1.14 today. The motivation is
optionality and age, not a blocked change — which makes this deferrable, and makes
getting the *order* right the only thing that matters.

## The decision that shapes everything

The sandbox toolchain lives in **environment configuration, not the repo.** A
setup script is stored with the environment, runs before each session, and its
output is cached, so packages installed there are present at session start. It
cannot be changed by committing to the repo.

That asymmetry sets the build order. Raise the repo pins first and the next
session starts, `mix` refuses the version requirement, and **every `brain.*` task,
the pre-commit hook, and the SessionStart hook fail** until the environment is
fixed — from inside a session that can no longer run the tooling. Raise the
environment first and the repo simply continues working on a newer toolchain
until the pins catch up.

**Environment first, repo second. The reverse order is self-blocking.**

## Build order

1. **Choose the install method.** `apt` is disqualified — it will keep serving
   1.14 on Ubuntu 24.04 regardless of the requested version. Use the Erlang
   Solutions apt repository, or a version manager (`asdf` / `mise`) pinned to an
   explicit version pair. Prefer whichever the operator's local machine already
   uses, so local and sandbox agree.
2. **Update the environment setup script** to install the chosen Elixir/OTP pair.
   The script's output is cached per environment, so this is a one-time cost.
3. **Verify in a fresh session** — `elixir --version` reports the new pair, and
   `mix brain.verify` plus `mix test` pass unchanged. Do not proceed past a
   failure here; this step exists to catch a bad script while the repo still
   builds on the old floor.
4. **Confirm the CI runner supports the pair.** `setup-beam` resolves versions
   against its own build matrix; an unavailable combination fails the workflow.
   Check before committing, not after.
5. **Raise the repo pins** in one commit: `mix.exs` `elixir:`, plus
   `elixir-version` and `otp-version` in **both** `ci.yml` and `pages.yml`.
   Missing `pages.yml` breaks the site deploy while CI stays green — a failure
   that surfaces late and in a different place than the change.
6. **Confirm the full gate suite** on the branch before merge.

## Scope boundaries

- **The zero-dependency constraint is untouched.** `mix.exs` declaring no deps is
  load-bearing — it is what lets the toolchain run offline in any sandbox — and
  this plan does not relax it. A newer Elixir does not admit dependencies; it
  only removes an unexamined ceiling.
- **This does not unblock Jido here.** Of the three blockers recorded in the
  [BEAM/Jido evaluation](/meta/analysis/beam-deployment-and-jido-2-evaluation.md),
  the toolchain floor was the least binding; the zero-dependency constraint and
  the duplicate-agent-runtime objection both survive the raise untouched. Jido
  work belongs in its own mix project regardless.
- **Target version is deliberately left open.** "1.17+/OTP 26+" is the floor Jido
  documents; the operator may prefer the current stable pair instead. Decide at
  step 1 against what the runner and the local machine support.

## Open questions

- Which install method — Erlang Solutions repo, `asdf`, or `mise`? Resolved by
  what the operator's local environment already uses.
- Pin an exact version pair or a permissive range? A range drifts across sandbox
  cache rebuilds; an exact pin needs periodic manual bumps.
- Is there a second environment (a Routine, a separate config) whose setup script
  also needs updating? Enumerate before step 2, since a missed one produces a
  session that fails only sometimes.
