---
type: tutorial
title: The SessionStart hook and why a fresh web sandbox skips the local gate
description: What .claude/hooks/session-start.sh does (provision and warm the Elixir toolchain), how git hooks and core.hooksPath work, and why a freshly-cloned Claude-on-web sandbox never runs the opt-in .githooks/pre-commit gate — so a red gate there is only caught in CI, unless the SessionStart hook re-wires core.hooksPath.
tags: [meta, tooling, git-hooks, pre-commit, sessionstart-hook, ci, sandbox, workflow]
timestamp: 2026-07-23
attribution:
  when: 2026-07-23T18:48:28Z
  channel: agent-authored
  agent: "Claude Code agent, interactive session (explaining the session-start.sh core.hooksPath comment)"
  why: "the operator asked for a concept-by-concept explanation of the git-hooks/core.hooksPath wiring in session-start.sh; persisted as a tutorial so the mechanism and the fresh-sandbox gap are durable knowledge"
  from: [/meta/threads/2026-07-23-session-start-hook-gate-and-machinery-reference-plan.md]
---

# The SessionStart hook and why a fresh web sandbox skips the local gate

The repository ships its own commit-time checks. A newly-started Claude-on-web
session does not run them. Both facts are true at once, and the reason is a small
pile of git mechanics worth understanding, because it explains why "green locally"
and "green in a fresh sandbox" are different claims — and why CI is the only gate
that no session can route around.

This note is the companion to
[the gate suite — what the checks prove and where they run](/meta/tutorials/the-gate-suite-and-where-it-runs.md):
that one owns *what the gates are and their three surfaces*; this one owns *the
fresh-sandbox provisioning story* — the [SessionStart hook](/beliefs/glossary/sessionstart-hook.md),
git hooks, and `core.hooksPath`.

## The SessionStart hook: provision the toolchain

A **SessionStart hook** is a script Claude Code runs once when a session begins.
This repo's is [`.claude/hooks/session-start.sh`](/.claude/hooks/session-start.sh),
and its sole job is to make the `mix brain.*` toolchain work in the session:

1. **Install Elixir when it's missing.** Only in Claude-on-web (remote) sandboxes
   — gated on `CLAUDE_CODE_REMOTE=true` and `command -v mix` failing — it
   `apt-get install`s Elixir (with an index-refresh fallback). Local machines are
   assumed to already have it, so the install is skipped there.
2. **Warm the build cache.** It `cd`s into `$CLAUDE_PROJECT_DIR` and runs
   `mix compile` so the first real `mix brain.*` call in the session isn't paying
   compile latency. (This project has [no external deps to fetch](/meta/tutorials/why-the-toolchain-runs-offline.md),
   so warming is just a local compile.)
3. **Print a ready line** naming the Elixir version, or a warning if the install
   failed.

That is *all* it does today. It used to also emit the open-work digest into every
session's context; that appraisal now lives behind the on-demand
[`/priorities`](/.claude/skills/priorities/SKILL.md) skill, so the hook is purely
toolchain provisioning.

Note what it does **not** do: it does not wire up the local commit gate. That is
the gap the rest of this note is about.

## Git hooks live in a directory that never travels with a clone

A **git hook** is a script git runs automatically at a lifecycle point — the one
that matters here is `pre-commit`, which git runs just before it records a commit;
a non-zero exit aborts the commit. By default git looks for these scripts in
`.git/hooks/`.

The crucial fact: **`.git/hooks/` is inside the `.git/` directory, which is not
version-controlled.** Nothing under `.git/` is part of the tree that gets cloned,
so a default-location hook cannot ship with the repo — every clone starts with an
empty `.git/hooks/`.

This repo works around that by keeping its gate as a **checked-in** file at
[`.githooks/pre-commit`](/.githooks/pre-commit) (note: `.githooks`, a normal
tracked directory, *not* `.git/hooks`). Being tracked, it clones like any other
file. But git won't *look* there until you tell it to.

## `core.hooksPath`: a config setting, also not cloned

You point git at the checked-in directory with one setting:

```sh
git config core.hooksPath .githooks
```

`core.hooksPath` overrides the default `.git/hooks/` with a directory of your
choice. Here is the second half of the trap: **`core.hooksPath` is git *config*,
not a tracked file.** It lives in `.git/config` (or your global git config) — and
just like `.git/hooks/`, config is not part of what a clone copies. So the setting
starts **unset** in every fresh clone.

Put the two facts together:

- the gate script clones fine (`.githooks/pre-commit` is tracked), but
- the setting that activates it does not (`core.hooksPath` is config), so
- **a fresh clone has the gate on disk but git is not wired to run it.**

That is why the pre-commit gate is described as **opt-in**: each clone must run
`git config core.hooksPath .githooks` once to enable it.

## Why the fresh web sandbox is exactly this case

A Claude-on-web session runs in an ephemeral sandbox that **clones the repo
fresh** at startup. So `core.hooksPath` is unset, git falls back to the empty
`.git/hooks/`, and the local gate suite never fires — you can commit a
format violation or a stale generated artifact in-session without any local
signal. The failure surfaces only later, when [CI](/.github/workflows/ci.yml) runs
the same checks on the server.

That is the meaning of the comment this note was written to explain:

> Fresh web-session sandboxes clone without `core.hooksPath` set, so the local
> gate suite (`.githooks/pre-commit`) never runs and a red gate is only found in CI.

## Closing the gap: re-wire `core.hooksPath` at session start

Because the *only* missing piece is one config setting, the SessionStart hook is
the natural place to re-establish it — it already runs once per fresh sandbox. The
wiring is a few guarded lines:

```sh
# Point git at the checked-in pre-commit gate. Fresh web-session sandboxes clone
# without core.hooksPath set, so the local gate suite (.githooks/pre-commit) never
# runs and a red gate is only found in CI. Harmless if already set; the hook
# degrades gracefully when mix is absent.
if command -v git >/dev/null 2>&1; then
  repo="${CLAUDE_PROJECT_DIR:-$PWD}"
  if [ -d "$repo/.git" ] && [ -d "$repo/.githooks" ]; then
    git -C "$repo" config core.hooksPath .githooks 2>/dev/null || true
  fi
fi
```

Reading it against the mechanics above:

- **`command -v git` / the two `-d` guards** — act only when git exists and both
  the repo (`.git/`) and the checked-in gate (`.githooks/`) are actually present,
  so it never points git at a directory that isn't there.
- **`git -C "$repo" config core.hooksPath .githooks`** — the wiring itself, run
  against the resolved repo directory (`$CLAUDE_PROJECT_DIR`, falling back to
  `$PWD`).
- **`2>/dev/null || true`** — swallows any error so the command can never abort
  the hook, which runs under `set -e`.
- **"Harmless if already set"** — `git config` is idempotent: re-writing the same
  value costs nothing, so a machine that enabled the gate once is unaffected.
- **"degrades gracefully when mix is absent"** — this describes the *gate*, not
  the wiring: [`.githooks/pre-commit`](/.githooks/pre-commit) checks for `mix`
  first and exits `0` with a notice if it's missing, so wiring git to the gate on
  a machine without Elixir still lets commits through — the gate just no-ops.

With that block in place, a fresh sandbox runs the same pre-commit gate a
long-lived local clone does, moving gate failures from "found in CI" back to
"found at commit." CI stays the authoritative backstop either way — the wiring is
a faster feedback loop, not a replacement for it.

## In one sentence

`session-start.sh` provisions the Elixir toolchain but a freshly-cloned sandbox
still won't run the opt-in `.githooks/pre-commit` gate — because both the default
hooks directory and the `core.hooksPath` setting that activates the checked-in one
live in the un-cloned `.git/`, so the gate ships on disk while the switch to run it
does not — which is why a red gate there surfaces only in CI unless the SessionStart
hook re-establishes `core.hooksPath` itself.
