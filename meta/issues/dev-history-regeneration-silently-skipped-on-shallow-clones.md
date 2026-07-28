---
type: issue
title: "Dev-history regeneration silently no-ops for a whole session when its clone is shallow"
description: Both mix brain.dev_history and its --check exit zero on a shallow clone, so a session that starts shallow never regenerates meta/dev-history.md and CI never notices — measured across 18 PRs, the outcome clusters perfectly by session rather than by PR.
status: open
provenance: "Claude Code session, 2026-07-28 — diagnosed against the merge graph at operator direction, after the file was found six PRs stale"
tags: [meta, issue, dev-history, generated-artifacts, ci, shallow-clone, gates, silent-failure]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, Kimi K3 weight-release intake session"
  why: "the diagnosis confirmed a defect whose fix is a separate design decision, which the originating todo said should be split into an issue"
  from: [/meta/threads/2026-07-28-kimi-k3-weight-release-implications.md]
---

# Dev-history regeneration silently no-ops for a whole session when its clone is shallow

[`meta/dev-history.md`](/meta/dev-history.md) is a generated-but-committed view of
the merge graph, designed to lag by exactly one PR, kept current by
[`/create-pull-request`](/.claude/skills/create-pull-request/SKILL.md) step 4 —
which has existed since 2026-07-23 (`8bb4d4a`). On 2026-07-28 the file was six
PRs stale.

## The defect

`mix brain.dev_history` refuses on a shallow clone
(`shallow clone — refusing to derive a truncated dev history`) and
`mix brain.dev_history --check` skips (`dev-history check skipped`). **Both exit
zero.** Web-session sandboxes clone shallowly, so in that environment the
regeneration no-ops and the gate meant to catch the resulting drift is blind —
the same environment, and the same run.

Silent-on-refusal is defensible for the task in isolation (deriving a truncated
history would be worse than deriving none). The defect is that nothing anywhere
converts that refusal into a signal.

## The evidence

Measured across the 18 PRs merged since step 4 existed, counting only
**branch-authored non-merge commits** that modify the file — an earlier count
that included merge commits produced two false positives (#147, #153), so this
is the corrected measurement:

| Session branch | PRs | Regenerated |
|---|---|---|
| `code-cleanliness-trust` | #147, #150, #153 | **all yes** |
| `channels-document-sources` | #152, #154 | **all yes** |
| `add-ai-sources-channels` | #146 | yes |
| `routing-ledger-orphaned-todos` | #162 | yes |
| `secure-local-financial-agent` | #148, #155, #156, #158, #161 | **all no** |
| `cca-program-status` | #149 | no |
| `second-brains-avatars` | #151 | no |
| `intake-video-review` | #163 | no |
| `kimi-k3-weights-analysis` | #157 → #159, #160 | **no, then yes** |

**The outcome clusters perfectly by session, not by PR.** Every branch is
uniformly yes or uniformly no — with one exception, which is the confirming case
rather than a counterexample: `kimi-k3-weights-analysis` failed at #157 and
succeeded at #159 and #160, and the behavior flipped at exactly the point that
session ran `git fetch --unshallow`, directly observed in-session.

That rules out the alternative hypothesis. An agent skipping step 4 would fail
sporadically, scattered across sessions; a property fixed at container start
fails uniformly for a session's whole life. The data shows the latter.

## What this does not establish

- Whether *every* one of the nine misses was a shallow refusal. The clustering
  makes agent-skip implausible as the dominant cause, not impossible as a
  contributing one.
- Branch identity is used as a proxy for session identity. A branch reused across
  sessions would blur the mapping; none here shows internal inconsistency, so the
  proxy holds for this window.
- Whether `git fetch --unshallow` succeeds in every sandbox. It succeeded here
  (802 commits), which is one observation, not a guarantee.

## The ongoing part

This is not historical. #161 and #163 both merged *after* the file was brought
current on 2026-07-28 and both failed to regenerate, so the drift is
re-accumulating now.

## Candidate fixes — none chosen

1. **Make the skip loud.** `--check` fails, rather than skips, when the clone is
   shallow *and* the tree is a PR branch. Cheapest, and converts a silent no-op
   into a visible one — but turns an environment property into a red gate, which
   is hostile if unshallowing is not always available.
2. **Unshallow in step 4.** `/create-pull-request` runs `git fetch --unshallow`
   before regenerating. Fixes the cause rather than reporting it; costs a full
   fetch per PR and depends on the unshallow being reliably permitted.
3. **Regenerate outside the session.** A scheduled job, or a post-merge workflow,
   derives the file from a full clone on the default branch. Removes the
   dependence on session environments entirely; adds automation to maintain, and
   the [self-referential lag](/beliefs/glossary/self-referential-lag.md) argument
   for regenerating in-PR would need revisiting.

Fix 1 and fix 2 compose — make it loud *and* fix the cause — and that is the
shape I would recommend, but the choice is the operator's. The
[staleness analysis](/meta/analysis/dev-history-staleness-and-ci-regeneration.md)
is the design record this would amend.
