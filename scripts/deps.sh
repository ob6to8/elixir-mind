#!/usr/bin/env bash
set -euo pipefail

# deps.sh — Walk the assertion DAG upward from a given assertion.
# Shows dependency tree (deps) and evidence sources at leaf nodes.
#
# Usage: ./scripts/deps.sh <assertion-id>
#
# Requires: jq

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
INDEX_FILE="$REPO_ROOT/index.json"

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <assertion-id>" >&2
  exit 1
fi

if [[ ! -f "$INDEX_FILE" ]]; then
  echo "Error: index.json not found. Run ./scripts/build-index.sh first." >&2
  exit 1
fi

ROOT_ID="$1"

# Verify assertion exists
exists=$(jq --arg id "$ROOT_ID" '.assertions | any(.id == $id)' "$INDEX_FILE")
if [[ "$exists" != "true" ]]; then
  echo "Error: assertion '$ROOT_ID' not found in index." >&2
  exit 1
fi

# Track visited nodes to prevent cycles
declare -A visited

walk_tree() {
  local id="$1"
  local indent="$2"

  if [[ -n "${visited[$id]+x}" ]]; then
    echo "${indent}(cycle: $id)"
    return
  fi
  visited[$id]=1

  # Check if it's an assertion
  local assertion
  assertion=$(jq --arg id "$id" '.assertions[] | select(.id == $id)' "$INDEX_FILE" 2>/dev/null)

  if [[ -n "$assertion" ]]; then
    local claim tier confidence
    claim=$(echo "$assertion" | jq -r '.claim')
    tier=$(echo "$assertion" | jq -r '.tier')
    confidence=$(echo "$assertion" | jq -r '.confidence // "high"')
    echo "${indent}[$tier|$confidence] $id"
    echo "${indent}  \"$claim\""

    # Walk deps (compounds)
    local deps
    deps=$(echo "$assertion" | jq -r '.deps[]? // empty' | sed 's/^\[\[//; s/\]\]$//')
    while IFS= read -r dep; do
      [[ -z "$dep" ]] && continue
      walk_tree "$dep" "${indent}  "
    done <<< "$deps"

    # Show evidence sources at this node
    local evidence_sources
    evidence_sources=$(jq --arg id "$id" '
      .edges[] | select(.from == $id and .type == "evidence") | .to
    ' -r "$INDEX_FILE" 2>/dev/null)
    while IFS= read -r src; do
      [[ -z "$src" ]] && continue
      local title
      title=$(jq --arg id "$src" '.sources[] | select(.id == $id) | .title' -r "$INDEX_FILE" 2>/dev/null)
      if [[ -n "$title" ]]; then
        echo "${indent}  <- [source] $src (\"$title\")"
      else
        echo "${indent}  <- [source] $src"
      fi
    done <<< "$evidence_sources"
  else
    # It's a source reference (leaf)
    local title
    title=$(jq --arg id "$id" '.sources[] | select(.id == $id) | .title' -r "$INDEX_FILE" 2>/dev/null)
    if [[ -n "$title" ]]; then
      echo "${indent}[source] $id (\"$title\")"
    else
      echo "${indent}[unknown] $id"
    fi
  fi
}

walk_tree "$ROOT_ID" ""
