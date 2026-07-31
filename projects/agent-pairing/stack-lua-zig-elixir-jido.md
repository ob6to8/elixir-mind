---
id: em:fa721a
type: analysis
title: "Can the stack be Lua + Zig + Elixir + Jido 2 — and which layer is each language actually for?"
description: Finds the four-language stack coherent but only under a role map that differs from its labels — the per-invocation hook shim (where BEAM boot latency rules Elixir out) is Zig's real place, the resident stateful broker core belongs on the BEAM (the operator's "Zig the broker, Elixir the aspect" inverts each language's strength), and a Zig core would foreclose the in-process interposition that makes a Jido subject worth having.
tags: [projects, agent-pairing, analysis, architecture, zig, elixir, beam, jido, lua, stack]
timestamp: 2026-07-30
attribution:
  when: 2026-07-30T20:12:54Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed design session on agent-driven editor workflows"
  why: "operator proposed a Lua/Zig/Elixir/Jido stack and asked whether it holds, reopening the plan's broker-language note"
---

# Can the stack be Lua + Zig + Elixir + Jido 2?

**Question.** The operator proposes a four-language stack: **Lua** for the
Neovim plugin, **Zig** for the broker, **Elixir** for the BEAM aspect, and
**Jido 2** as the agent framework. Does it hold, or is it a language too many?

**Thesis.** It holds — but only under a division of labor that differs from the
labels. The [BEAM/Jido analysis](/projects/agent-pairing/beam-jido-integration.md)
put the stateful broker on the BEAM; this proposal moves it to Zig and demotes
Elixir to "an aspect," which **inverts each language's strength**. The right map
keeps all four but reassigns two: **Zig is the per-invocation hook shim and
distribution edge** (the one place BEAM boot latency rules Elixir out), and
**Elixir/OTP is the resident broker core** (the stateful, fault-isolated
supervision the BEAM gives for free). Read that way the stack is coherent and
every layer earns its seat. Read the operator's way — Zig owning the stateful
core — it rebuilds OTP by hand and forecloses the one thing a Jido subject is
for.

## The forcing function nobody chose

Claude Code hooks run as **a subprocess spawned per invocation** — a
`PreToolUse` hook is a command that starts, emits its JSON decision, and exits,
once per gated action (verified against the hooks reference this session; the
per-call subprocess model is how command hooks execute). That single fact
dictates the top-level shape before any language is picked:

- The hook handler is in the **critical path of every gated action**, and it
  starts cold every time.
- The BEAM boots in hundreds of milliseconds to a second. Booting it *per hook
  call* is disqualifying — it would tax every edit the agent makes.
- Therefore the architecture is **forced** into a resident daemon plus a thin
  per-call client: the daemon holds all state and lives for the session; the
  per-call client is tiny, starts in ~1 ms, opens a socket to the daemon,
  forwards the payload, blocks for the decision, prints it, exits.

This split is not a design choice — it falls out of the hook model. The only
open question is what each half is written in.

## Where each language actually lands

| Layer | Job | Language | Load-bearing? |
|---|---|---|---|
| Editor client | render pending edits, follow window, quickfix; capture keys | **Lua** | Yes — it runs inside Neovim; nothing else can |
| Hook shim / transport edge | per-call subprocess: forward payload, block, return decision | **Zig** | The *role* is forced; **Zig specifically is not** — Rust/Go/C are equivalents |
| Broker core | resident daemon: session state, pending queue, ack protocol, replay, fan-out | **Elixir/OTP** | Yes — for correctness-for-free, see below |
| Agent chassis / subject | reducer core; the born-supervisable subject | **Jido 2** (Elixir lib) | Optional; not a runtime — an in-process dependency |

The reframing is the whole finding. Zig's genuine wins are the **shim** (a
static ~1–2 MB binary that starts instantly and holds a socket — exactly what a
per-call handler needs) and **distribution** (a single dependency-free binary
competing with herdr's and cmux's Rust). Neither of those is the *broker*. The
broker is the stateful, concurrent, fault-isolated part, and that is precisely
what the operator's label hands to Zig.

## Why the stateful core wants the BEAM, not Zig

The broker's core obligations are correctness properties, not throughput:

- **A crashed session handler must not strand or corrupt its neighbours.** On
  the BEAM this is process isolation — free. In Zig it is manual: shared state,
  hand-rolled panics-don't-propagate discipline, careful teardown.
- **Blocking with a per-session deadline** (the 600 s hook budget) is a
  `GenServer` call timeout on the BEAM; in Zig it is an async runtime you build
  and own — and Zig's async story is unsettled across recent releases, so this
  is not a library call you reach for (status from training knowledge, worth
  re-checking against the Zig version at build time).
- **"Blocking degrades to `defer`, never to a stranded agent"** — the safety
  invariant from the [architecture plan](/projects/agent-pairing/architecture-and-build-order.md)
  — is a monitor plus a supervision policy on the BEAM, and bespoke lifecycle
  code in Zig.

The concurrency is *modest* (dozens of mostly-idle blocked sessions), so this is
not a scale argument — Zig could carry the load. It is a **correctness-for-free
versus correctness-by-hand** argument, and the broker sits between a human's
editor and an agent holding real authority (`updatedInput` rewrites actions),
which is exactly where you want the free correctness.

## The deeper reason: a Zig core forecloses the Jido payoff

The [BEAM/Jido analysis](/projects/agent-pairing/beam-jido-integration.md)'s
sharpest point was that a signal-bus-native agent is *born supervisable*: gating
becomes **interposition on the dispatch path**, not interception via hooks. That
payoff is only clean when the broker and the Jido agent share a BEAM — the gate
is an in-process signal route, not a network hop. Put the broker in Zig and the
born-supervisable story degrades to a Zig process talking to a separate BEAM
over a socket, which is the very cross-process seam the in-process story was
supposed to remove. So "Zig broker **and** Elixir/Jido subject" quietly forces
one of two bad shapes: a socket-hop compromise, or two brokers (Zig for Claude
Code, Elixir for Jido). Keeping the core on the BEAM keeps interposition
in-process and keeps the stack to one broker.

## Is four languages too many?

Count the real boundaries, not the logos:

- editor ↔ daemon — a socket, **unavoidable** (the editor is a separate process
  by nature).
- shim ↔ daemon — a socket, and it exists **because** of the boot-latency
  forcing function; the shim cannot be Elixir (boot cost) and cannot be Lua (it
  needs the nvim host), so a third small non-BEAM language is genuinely forced.
- Elixir ↔ Jido — **no boundary**: Jido is an Elixir library, in-process.

So it is three runtimes (the Lua VM inside nvim, a tiny Zig binary, one BEAM
node) across two process seams, with Jido a dependency rather than a fourth
runtime. That is not bloat — each seam is load-bearing. The one to interrogate
is the shim, and it survives interrogation: the shim exists no matter what, and
its language is free choice. Zig is a fine pick; so is Rust or Go. It should be
treated as **swappable**, chosen by operator preference, not defended as
essential.

## Recommendation

Adopt the stack, with the roles relabelled:

- **Lua** — the editor client. Unchanged, uncontested.
- **Zig** — the per-invocation hook shim and the distribution wrapper, *not* the
  stateful broker. Explicitly swappable with Rust/Go/C; pick by preference.
- **Elixir/OTP** — the resident broker core. This is "the broker," not "an
  aspect."
- **Jido 2** — optional chassis for that core and the born-supervisable subject;
  `jido_ai` stays excluded; the dependency decision stays deferred to first-code
  as reversible.

Net effect on the plan: the broker-language question is **not** settled as a
single language — it is a **shim/core split**, Zig at the edge and Elixir/OTP at
the core. Keep the core on the BEAM specifically to preserve in-process Jido
interposition; if casual-install distribution ever proves the dominant
constraint, the fallback is not "rewrite the core in Zig" but "let the Zig shim
carry more of the transport and ship the BEAM core via a Burrito bundle."

## Open questions

- **Shim ↔ daemon protocol.** Raw newline-delimited JSON over a Unix socket, or
  MCP-shaped from the start? The hunk session daemon's `mcp:`-prefixed ids hint
  the latter is becoming the idiom.
- **Who holds the 600 s block** — the Zig shim (simple: it just waits on the
  socket) or does it hand off and let the daemon hold the decision? Simplest is
  the shim blocking on the socket read; confirm that doesn't tie up a hook
  process budget badly under many concurrent gates.
- **Distribution math.** A ~2 MB Zig shim plus a ~20–30 MB Burrito'd BEAM core
  versus a single Zig binary that does everything (hand-building the daemon).
  Only worth revisiting if adoption data says the BEAM bundle is the thing
  killing installs.
- **Zig async maturity** at build time — re-verify against the current release
  rather than this analysis's training-knowledge caveat.

## Basis

The hook per-invocation subprocess model and the 600 s timeout are from the
Claude Code hooks reference fetched this session
([hook events as the supervision seam](/knowledge/SWE/agentic/anthropic/claude-code/hook-events-as-supervision-seam.md)).
Zig's async-runtime status and BEAM boot-latency figures are from training
knowledge, not measured this session — both are flagged for re-check at
first-code.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:fa721a">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-30-neovim-adoption-and-the-agent-pairing-project (2026-07-30)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:fa721a`]**

That reframes the labels. **Zig's** genuine wins are the per-call **shim** (a static ~1–2 MB binary that starts instantly and holds a socket — exactly what a per-call handler needs) and **distribution** (a single dependency-free binary competing with herdr's and cmux's Rust). Neither of those is the *broker*. The broker is the stateful, concurrent, fault-isolated core — process isolation, blocking-with-timeout, "degrade to `defer`, never strand an agent" — which is correctness-for-free on the BEAM and correctness-by-hand in Zig. So the operator's labeling ("Zig the broker, Elixir the aspect") inverts each language's strength: it hands the stateful core to Zig and demotes Elixir to an aspect.
