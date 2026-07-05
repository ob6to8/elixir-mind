---
id: sb:52aefa
type: note
title: Claude Code cloud (CCR) — environment and orchestration architecture
description: Claude Code's cloud runtime maps sessions to operator-defined environments backed by pre-baked cached container images, so image-baked state is frozen at bake time, containers are ephemeral, and sibling sessions interleave.
tags: [claude-code, cloud, containers, orchestration, dev-environments, agentic-coding]
provenance: "In-container forensics by Claude Code agents (composablebeliefs/composable-beliefs sessions, 2026-07-05), while diagnosing a local main ref 161 commits stale in a day-old session; distilled notes pasted by the operator"
verified: false
timestamp: 2026-07-05
---

# Claude Code cloud (CCR) — environment and orchestration architecture

Confidence is marked per item: **[E]** evidenced by in-container forensics,
**[D]** documented shape (see [Citations](#citations)), **[I]** inference, unverified.

## The unit model

- **[D]** Users create an **environment** in the app and attach GitHub repos to it as
  sources. The environment also carries the network policy, env vars, and setup
  scripts. Sessions run *inside* an environment.
- **[D/E]** An orchestrator maps session → environment → container. The cache key for
  provisioned state is the **environment, not the repo**: "spinning up an agent in a
  repo" is really starting a session in whichever environment that repo is attached
  to. Two environments attached to the same repo could hand out different images.
- **[E]** Container images are **pre-baked and cached across sessions** (warm starts).
  Proof: `.git/refs/heads/main` was written 2026-06-30 inside an image handed to a
  2026-07-04 session; the repo's own session-start hook notes container state is
  cached after the hook completes.
- **[I]** Internals unverified: per-environment snapshot vs shared base layer, warm
  pools, invalidation policy. The `list_environments` MCP tool needs an interactive
  approval that never reached the operator surface, so environment enumeration was
  impossible in-session; the binding was confirmed only by forensics.

## Consequences that bite

- **[E]** Anything baked into the image is **frozen at bake time**, not session time.
  Observed: the local `main` ref (created at image build, never advanced —
  [git fetch only moves remote-tracking refs](/SWE/version-control/git/git-local-branches-dont-auto-advance-on-fetch.md)).
  Rule: base work on `origin/<default>` after a fetch, never the bare local default
  branch. In-repo mitigation: a SessionStart hook that fetches and fast-forwards.
- **[E]** Bake-time state also rots in other layers: an apt PPA in the image changed
  its release metadata upstream and plain `apt-get update` then failed (fix:
  `--allow-releaseinfo-change`). Generalization: **any image-baked cache** (refs, apt
  metadata, toolchains) can be stale or broken by the time a session sees it.
- **[E]** The container is **ephemeral** — reclaimed after inactivity. Unpushed
  commits die with it. A sibling session, finding a branch missing from origin,
  concluded the prior session's container was reclaimed before push and recreated
  the work.
- **[E]** Two hook layers with different owners: repo-tracked hooks
  (`.claude/settings.json`, versioned, fixable in-repo) and user-global hooks
  (`/root/.claude/*`, injected by the environment layer, *not* reachable from any
  repo). Defects in the global layer can only be flagged upstream; repos can only
  build read-surface defenses.
- **[E]** Commit signing is **deferred to push time**: the in-session signing key is
  empty (0-byte pub, no private key), so local commits show `%G? == N` until pushed.
  Push preserves SHAs (verified: remote tip identical to local after push).
- **[E]** Sessions on the same repo run **concurrently** and interleave: one
  session's mid-flight push was observed, recovered, and merged by a sibling session
  working the same task. Design implication: trust the remote/graph state over any
  in-container assumption; **re-fetch before reasoning about "what exists"**.

# Citations

- Documented shape ([D] items): <https://code.claude.com/docs/en/claude-code-on-the-web>
