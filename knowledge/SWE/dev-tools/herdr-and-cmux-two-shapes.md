---
id: em:2ffa8b
type: reference
title: "herdr and cmux — two shapes of the same agent multiplexer"
description: A practitioner's comparison of herdr (daemon plus TUI client, PTY-owning, agent-facing wait verb) against cmux (native macOS terminal embedding Ghostty, human-facing approval feed), concluding that the choice reduces to who does the scheduling — the human or another agent — and stating a falsifiable tripwire for switching.
resource: https://blog.debedb.com/2026/07/26/herdr-and-cmux-two-shapes-of-the-same-agent-multiplexer/
provenance: "Distilled from the DEBEDb blog post of 2026-07-26, fetched 2026-08-07"
tags: [terminal, terminal-multiplexer, ai-agents, developer-tools, herdr, cmux, orchestration, comparison]
timestamp: 2026-08-07
attribution:
  when: 2026-08-07T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked to intake the post and to explain its claim that herdr's daemon owns the PTYs while clients attach and detach"
---

# herdr and cmux — two shapes of the same agent multiplexer

A daily user of [cmux](/knowledge/SWE/dev-tools/cmux.md) compares it against
[herdr](/knowledge/SWE/dev-tools/herdr.md) and commits to a decision rather
than a both-are-fine shrug. The post's value is less the feature inventory
(both product sites carry that) than the **axis it isolates** and the
**falsifiable review condition** it attaches to the choice.

## The structural difference, and what follows from it

> "herdr is a daemon plus a TUI client that runs inside the terminal you
> already have. The daemon owns the PTYs; clients attach and detach."

Against that, cmux "is a native macOS app that embeds Ghostty as its renderer.
It is the terminal, not a program running inside one." The author's claim is
that "almost everything below follows from that one choice" — the rest of the
comparison is downstream of daemon-plus-client versus single GUI process.

Unpacked at length in
[the daemon owns the PTYs; clients attach and detach](/meta/elaborations/herdr-daemon-owns-the-ptys.md).

## The axis: which seat is being optimized

The post's organizing claim, stated before the evidence rather than after:

- **herdr optimizes the seat the agent sits in.** `agent wait --until done` is
  "a primitive for a program coordinating other programs"; occupant pinning,
  fused prompt-and-wait, and the `HERDR_ENV` gate are "the concerns of a caller
  that is not a person."
- **cmux optimizes the seat the human sits in.** The approval feed,
  notifications, browser panes, and hook-recorded session restore "matter when
  a human is the scheduler and the agents are the ones asking permission."

So "which is better" resolves to **who does the scheduling in your workflow**.
The author's answer for today is: still the human, which is cmux's shape; the
day agent-spawns-agent-and-blocks-on-it dominates, herdr's design is the right
one.

## Where each is judged stronger

**herdr** — the `wait` verb (`herdr agent wait w1:p1 --until done|blocked`),
server-owned and event-driven rather than polled, pinning the resolved pane
occupant so a replacement agent cannot satisfy the wait; `agent.prompt` accepts
an optional wait object, collapsing submit-then-wait into one request with no
race. cmux has the underlying state (`running`/`idle`/`needsInput`/`unknown`
from hook integrations) and a durable event stream, but "does not expose a verb
that joins them." Also: detach as a first-class concept rather than a
workaround; running on Linux/remote hosts where cmux is macOS-only by
construction; and a shipped plugin surface (`herdr-plugin.toml`, marketplace,
third-party sidebars and phone clients).

**cmux** — it is the terminal, so no nested-multiplexer key contention and real
GPU-rendered tabs. Panes are not only PTYs: surfaces can be browsers, markdown
viewers, or file previews, with the browser scriptable from the same CLI, where
"in herdr everything is a character grid." Agent state is **told, not
inferred** — `cmux hooks setup` installs session hooks for 14 agents and stores
each one's native resume command, so a relaunch continues the real
conversation, whereas "herdr detects state by evaluating manifests against a
terminal snapshot." The author's verdict on that contrast: "Detection is
clever; being told is sturdier." And the human is in the protocol: one approval
queue rather than per-agent toasts — "six running agents need one blocked-list,
not six toasts."

## The decision and its tripwire

cmux stays the cockpit on macOS — explicitly *not* because it wins on paper
("on the agent-facing API it does not") but because switching cockpits forfeits
everything built around the human loop. herdr gets adopted where cmux
structurally cannot go: Linux, remote hosts, SSH-first work. No dual-running on
one machine, since "two multiplexers on one machine means two keymaps, two
session stores, and two places to look for the agent that is blocked."

The switch conditions are stated in advance so the decision is falsifiable:
primary development moving off macOS, or agent-to-agent orchestration becoming
the dominant mode while cmux still has no wait verb. Review date January 2027 —
"A decision with no review date is just a preference."

## Two transferable process notes

- **Filing beats forking when the maintainer is responsive.** A fork found 0
  commits ahead and 3,171 behind is "not a fork, it is a stale bookmark that
  quietly implies we carry local changes" — and "a fork you do not rebase is a
  liability with a nice URL."
- **A feature request from a non-user is a maintainer tax.** The author files
  issues against the tool used daily and keeps the other tool's suggestions "at
  blog volume," because a maintainer would otherwise "have to reconstruct my
  context before they can even judge whether I found a real gap or just did not
  finish the manual."

Also recorded: getting the expected behavior for an unexplained reason "is not
a fixed bug, it is a deferred one."

# Citations

- herdr and cmux: two shapes of the same agent multiplexer, DEBEDb, 2026-07-26 —
  <https://blog.debedb.com/2026/07/26/herdr-and-cmux-two-shapes-of-the-same-agent-multiplexer/>
- Product captures: [herdr](/knowledge/SWE/dev-tools/herdr.md),
  [cmux](/knowledge/SWE/dev-tools/cmux.md)
- This bundle's own three-way comparison against the agent-pairing supervision
  layer: [agent pairing vs. herdr and cmux](/projects/agent-pairing/comparison-herdr-cmux.md)
