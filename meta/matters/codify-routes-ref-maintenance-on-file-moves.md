---
type: matter
title: "Codify routes-ref maintenance on file moves in the route-tagging policy"
description: The route-tagging policy does not say what happens to a frozen thread's <routes ref> path refs when their target moves or is deleted; the todo fold set the precedent (refs follow a move; a dead back-link is dropped, never left failing the hard gate) — decide whether to write that rule into the policy.
status: open
provenance: "Claude Fable 5, todo-fold session"
tags: [meta, matter, route-tags, threads, policy]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T12:10:00Z
  channel: agent-authored
  agent: "Claude Code agent, todo-fold session (matter-docs build 3)"
  why: "the fold moved 20 tagged targets and deleted a skill file, forcing ref edits inside five frozen thread docs with no policy sanctioning the motion beyond this session's operator approval"
  from: [/meta/threads/2026-08-02-todo-fold-into-matters.md]
---

# Codify routes-ref maintenance on file moves

`mix brain.route_tags` fails hard on a `<routes ref>` that no longer resolves,
and the [session-capture](/meta/policy/session-capture.md) freeze rule leaves
unstated whether tag *attributes* (routing metadata, not body text) may be
edited to follow a move. The todo fold (2026-08-02, operator-approved) set the
precedent: path refs are updated to the moved target, and a back-link whose
target is deleted with no successor is dropped from the ref list. Decide
whether [route-tagging](/meta/policy/route-tagging.md) gets a sentence making
that rule standing, so the next file move does not need per-session approval.
