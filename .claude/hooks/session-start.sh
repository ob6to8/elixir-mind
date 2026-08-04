#!/bin/bash
set -euo pipefail

# Provision the session's toolchain — nothing more. The session-init appraisal
# (open work + a heuristic top-3) is not emitted here; it lives behind the
# on-demand `/priorities` skill (see .claude/skills/priorities/SKILL.md). This
# hook's sole job is to ensure the Elixir/OTP toolchain is present and warm so
# `mix brain.*` — including the priorities skill, the contract compiler, and the
# test suite — works.
#
# The install is only needed in Claude Code on the web (remote) sessions;
# local machines are expected to already have Elixir installed.

log=/tmp/elixir-mind-session-start.log

if [ "${CLAUDE_CODE_REMOTE:-}" = "true" ] && ! command -v mix >/dev/null 2>&1; then
  export DEBIAN_FRONTEND=noninteractive
  # The package is usually directly installable; fall back to an index refresh.
  apt-get install -y elixir >"$log" 2>&1 \
    || { apt-get update -y >>"$log" 2>&1 && apt-get install -y elixir >>"$log" 2>&1; }
fi

# Point git at the checked-in pre-commit gate. Fresh web-session sandboxes clone
# without core.hooksPath set, so the local gate suite (.githooks/pre-commit) never
# runs and a red gate is only found in CI. Harmless if already set; the hook
# degrades gracefully when mix is absent.
if command -v git >/dev/null 2>&1; then
  repo="${CLAUDE_PROJECT_DIR:-$PWD}"
  if [ -d "$repo/.git" ] && [ -d "$repo/.githooks" ]; then
    git -C "$repo" config core.hooksPath .githooks 2>/dev/null || true
    # The `regen` merge driver referenced by .gitattributes: resolve a merge
    # conflict on a generated artifact by keeping ours, to be re-derived with
    # `mix brain.regen` — the freshness gates reject the merge commit until
    # that has happened (see meta/issues/generated-artifact-merge-conflicts.md).
    git -C "$repo" config merge.regen.driver true 2>/dev/null || true
    git -C "$repo" config merge.regen.name "keep ours; re-derive via mix brain.regen" 2>/dev/null || true
  fi
fi

if command -v mix >/dev/null 2>&1; then
  cd "${CLAUDE_PROJECT_DIR:-$PWD}"
  # Warm the build cache (this project has no external deps to fetch).
  mix compile >>"$log" 2>&1 || true
  echo "elixir-mind: $(elixir --version 2>/dev/null | tail -1) ready — run /priorities to review open work."
else
  echo "elixir-mind: WARNING — failed to install Elixir; see $log." >&2
fi
