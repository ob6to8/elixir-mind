---
id: em:6e0097
type: concept
title: compare-and-swap
description: An atomic primitive that updates a value only if it still matches an expected previous value, and otherwise fails — the standard way to coordinate concurrent writers without holding a lock.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, concurrency, distributed-systems]
sense: common
timestamp: 2026-07-31
attribution:
  when: 2026-07-31
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-31 GitLord intake thread (git ref updates use compare-and-swap to let concurrent subagent writers avoid contending on a lock)"
---

# compare-and-swap

Abbreviated CAS. The caller supplies both the expected current value and the
new value; the update commits only if the target still holds the expected
value, and the caller retries (or gives up) on mismatch rather than blocking.
This makes it **optimistic**: writers proceed without acquiring anything up
front, and contention shows up as a failed-and-retried update rather than as
one writer waiting on another. Git itself uses the pattern for ref updates
(`update-ref` with an expected old SHA) — a foundation other tools build on to
let independent processes race to update the same ref safely.

*Seen in:* [2026-07-31 GitLord intake thread](/meta/threads/2026-07-31-gitlord-git-backed-agent-orchestration-intake.md)
