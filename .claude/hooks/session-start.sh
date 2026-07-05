#!/bin/bash
set -euo pipefail

# Ensure the Elixir/OTP toolchain is present so the contract compiler
# (`mix brain.contract`) and the test suite (`mix test`) work in the session.
#
# Only needed in Claude Code on the web (remote) sessions; local machines are
# expected to already have Elixir installed.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

log=/tmp/second-brain-session-start.log

if ! command -v mix >/dev/null 2>&1; then
  export DEBIAN_FRONTEND=noninteractive
  # The package is usually directly installable; fall back to an index refresh.
  apt-get install -y elixir >"$log" 2>&1 \
    || { apt-get update -y >>"$log" 2>&1 && apt-get install -y elixir >>"$log" 2>&1; }
fi

# Warm the build cache (this project has no external deps to fetch).
if command -v mix >/dev/null 2>&1; then
  (cd "${CLAUDE_PROJECT_DIR:-$PWD}" && mix compile >>"$log" 2>&1) || true
  echo "second-brain: $(elixir --version 2>/dev/null | tail -1) ready — mix brain.contract available."
else
  echo "second-brain: WARNING — failed to install Elixir; see $log." >&2
fi
