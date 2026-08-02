---
type: analysis
title: "Herdr vs. the Claude Code app: a multiplexer for agents next to one of the agents it multiplexes"
description: Herdr is a self-hosted, vendor-agnostic terminal multiplexer that gives any CLI coding agent persistent, remote-reattachable PTY sessions behind a mouse-driven pane UI and a control API; the Claude Code app is Anthropic's own agent bundled with a first-party harness (CLI, Anthropic-hosted cloud runtime, desktop/mobile, IDE extensions) that already ships persistence, remote access, and peer multi-agent coordination for its own sessions but nothing that hosts other vendors' agents — so the two overlap on capability more than they compete on category, and herdr lists Claude Code as one of its native backends rather than as a rival. Extended with a concrete build: splitting compute into an always-on herdr control-plane node plus disposable per-session VMs cloned from a shared base image (Shellbox `duplicate`/Fly Machine or Sprite clone) reproduces CCR's environment→snapshot→ephemeral-session model, though org-managed settings injection, native cross-vendor agent-teaming, and CCR's own credential-custody boundary have no off-the-shelf equivalent and would need bespoke glue.
provenance: "Claude Code session (Claude Sonnet 5), 2026-08-02 — operator asked for a compare-and-contrast analysis of herdr (https://herdr.dev/) against the Claude Code app, then to expand it with the infra design needed to approximate CCR's architecture using herdr plus Fly.io (https://fly.io/) and Shellbox (https://shellbox.dev/); herdr.dev, shellbox.dev, and Fly.io's Machines/pricing/private-networking docs fetched directly this session, Fly Sprites facts drawn from secondary press coverage after Fly's own Sprites page returned only its CLI-install stub, Claude Code facts grounded against this bundle's existing documented/verified notes on Claude Code's cloud runtime and agent teams, plus this session's own live Claude Code tool roster (Monitor, ScheduleWakeup, mcp__Claude_Code_Remote__* triggers) as direct evidence of its remote/background surface."
tags: [meta, analysis, claude-code, herdr, fly-io, shellbox, sandboxes, infrastructure, agentic, terminal, multiplexer, remote-access, comparison]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02
  channel: agent-authored
  agent: "Claude Code agent, operator request in chat"
  why: "operator asked for a compare-and-contrast analysis of herdr against the Anthropic Claude Code app"
---

# Herdr vs. the Claude Code app

**Question.** How does herdr (a terminal-based agent multiplexer) compare to the
Claude Code app (Anthropic's own coding agent plus its harness)?

**Bottom line.** They sit at different layers and are not a clean substitute for
one another. Herdr is a **session host**: a self-hosted binary that gives *any*
CLI coding agent — Claude Code included — a persistent PTY, a mouse-driven pane
UI, remote reattachment, and a control API, without opinions about which agent
runs inside it. The Claude Code app is an **agent plus its own first-party
harness**: one vendor's model, wrapped in a CLI, an Anthropic-hosted cloud
runtime, a desktop/mobile surface, IDE extensions, and (experimentally) peer
multi-agent coordination among its own sessions. Much of what herdr adds on top
of a bare terminal agent — persistence past disconnect, remote/mobile
reattachment, live status, multi-session visibility — Claude Code already ships
natively for its *own* sessions through its cloud runtime. What herdr adds that
Claude Code does not is **agent-agnosticism**: one pane-based UI and one control
API across Claude Code, Codex, OpenCode, Cursor, and other terminal agents at
once, self-hosted on infrastructure the operator controls. The two compose more
than they compete — herdr names Claude Code as one of its native integrations.

## What each thing is

### Herdr — a self-hosted, agent-agnostic terminal multiplexer

Fetched from herdr.dev (2026-08-02). Herdr's own framing: *"One terminal. The
whole herd,"* and *"a binary, not an app."* It is a multiplexer purpose-built
for running several coding agents at once, not a coding agent itself:

- **Persistent PTY sessions.** Each agent runs *"in its own real terminal, on a
  server that keeps it alive when you close the laptop,"* so a session survives
  disconnect the way a `tmux`/`screen` session does — the persistence lives in
  the terminal process, on the operator's own server.
- **Remote/mobile reattachment.** Detach and reattach from any terminal,
  including over SSH or as a thin client, with a mobile-responsive UI and
  clipboard bridging.
- **Visual, multi-agent surface.** A mouse-driven pane layout with tabs and
  workspaces, and real-time per-pane status (blocked / working / done / idle /
  explore) — *"See blocked, working, and done at a glance, and reattach from
  your phone."*
- **Programmable control.** A CLI for workspace/pane/tab management and a JSON
  socket API that lets agents control the multiplexer itself (spawn panes,
  read status, and so on).
- **Backend-agnostic.** *"Native integrations include Claude Code, Codex,
  OpenCode, Cursor, and others. Any terminal agent works out of the box."*
- **Distribution.** Open-source; self-hosted (script or Homebrew install on
  Linux/macOS, Windows in public beta); *"no Electron, no account, no
  telemetry"*; a plugin ecosystem of *"150+ community extensions"* installable
  via GitHub topics.

### The Claude Code app — one vendor's agent, with its own harness attached

Claude Code is not a multiplexer; it is the agent plus the harness Anthropic
ships around it. Distilled from this bundle's grounded notes on Claude Code
(cited inline) and this session's own operating context:

- **Multiple runtime surfaces, one vendor.** CLI (local terminal), a
  cloud runtime reachable from the web app, a desktop/mobile app, and IDE
  extensions (VS Code, JetBrains) — all running the same underlying agent, not
  a container for other vendors' agents.
- **Cloud persistence and remote access, natively.** The cloud runtime (CCR)
  maps each session to an operator-defined **environment**, provisions a VM
  from a per-environment filesystem snapshot, and — per the official docs
  quoted in this bundle's grounded note — *"Cloud sessions stop after a period
  of inactivity and the underlying environment is reclaimed"*
  ([Claude Code cloud (CCR) — environment and orchestration architecture](/knowledge/SWE/agentic/anthropic/claude-code/cloud-environment-architecture.md),
  `em:52aefa`, `verified: false` — grounded against Anthropic's docs but still
  carrying unverified forensic detail). So cloud persistence is real but
  **bounded** — reclaimed on inactivity — unlike herdr's own-server session,
  which stays alive as long as the operator's box does.
- **Background/remote control surface, observed directly this session.** This
  session's own tool roster is itself evidence: scheduled wake-ups
  (`ScheduleWakeup`, `CronCreate`), a `Monitor` tool for streaming background
  process events, and `mcp__Claude_Code_Remote__*` tools for creating,
  listing, firing, and updating **Routines** (scheduled triggers that resume a
  session or spawn a fresh one) — Anthropic's own answer to "reattach and get
  notified remotely," architecturally distinct from herdr's SSH/thin-client
  reattachment but functionally adjacent.
- **Multi-agent coordination, Claude-only.** *Agent teams* (experimental) let
  several full Claude Code sessions coordinate as peers through a shared,
  file-locked task list and JSON mailboxes, messaging each other by name and
  remaining individually steerable by the operator
  ([Claude Code agent teams](/knowledge/SWE/agentic/anthropic/claude-code/agent-teams.md),
  `em:33e0c7`). This is Claude Code's structural analog to herdr's multi-pane
  view — but it coordinates *only* Claude Code instances; there is no
  documented surface for teaming a Claude Code session with a Codex or Cursor
  session the way herdr's panes can sit side by side regardless of vendor.
- **Extensibility is prompt/config-level, not session-level.** Hooks, skills,
  subagents, MCP servers, and slash commands extend *what one agent does*;
  none of them multiplex a different agent binary the way herdr's plugin
  ecosystem and socket API do.
- **Cost model.** Anthropic's commercial product: the harness (CLI, IDE
  extensions) installs freely, but running the agent draws on a Claude
  subscription or API usage — the inverse of herdr's open-source,
  no-account, no-telemetry stance, which charges nothing for the multiplexer
  itself but assumes the operator is already paying for whatever agent(s) run
  inside it.

## Feature-by-feature

| Dimension | Herdr | Claude Code app |
|---|---|---|
| What it fundamentally is | A terminal multiplexer / session host (a binary) | An agent (model + harness), not a multiplexer |
| Agents it can run | Agent-agnostic — Claude Code, Codex, OpenCode, Cursor, "any terminal agent" | Itself only |
| Session persistence | PTY kept alive on the operator's own server, indefinitely | Cloud sessions persist independent of the local machine but are reclaimed after inactivity (documented) |
| Remote / mobile access | SSH, thin client, mobile-responsive UI, clipboard bridging | Web app (claude.ai/code), plus this session's own observed surface: push notifications, scheduled wake-ups/Routines, background task monitoring |
| Multi-agent view | One pane grid across any mix of agent vendors, with live per-pane status | Agent teams: peer Claude Code sessions only, coordinated via shared task list + mailboxes |
| Control surface | CLI + JSON socket API for scripting the multiplexer itself | Hooks, skills, subagents, MCP — extend one agent's behavior, not a fleet of different agents |
| Hosting | Self-hosted, on infrastructure the operator controls | Client-side (CLI/IDE/desktop) and/or Anthropic-hosted cloud VMs; no self-hosting option |
| Extension ecosystem | "150+ community extensions" via GitHub topics | Skills, MCP servers, hooks — Anthropic/community-authored, scoped to one session |
| Openness / telemetry | Open-source; "no Electron, no account, no telemetry" | Commercial product; harness install is free, agent usage is metered |

## Where they actually meet

The overlap is real but narrower than it first looks. Herdr's headline
value — *persistence past disconnect* and *remote/mobile reattachment* — is
functionality Claude Code already ships for its own sessions via CCR and the
Routines/notification surface, just architecturally different: Anthropic-hosted
and ephemeral-on-inactivity versus operator-hosted and alive for as long as the
box is. A Claude Code operator who only ever runs Claude Code gains comparatively
little from herdr on the persistence/remote axis specifically, since that axis
is already covered.

What herdr adds that nothing in Claude Code's own surface does is running
**several different agent vendors in one place** with one UI and one control
API — the use case is an operator who wants Codex, Cursor, and Claude Code side
by side, not an operator committed to one vendor. Consistent with that, herdr
does not position itself as a Claude Code competitor: Claude Code is one of its
listed native integrations, so the two compose — an operator could run this
bundle's own Claude Code sessions *inside* herdr instead of (or alongside) CCR,
trading Anthropic-hosted ephemeral persistence for self-hosted indefinite
persistence and cross-vendor panes, at the cost of running and securing that
server themselves.

## Approximating CCR's architecture with herdr + infra

Herdr says nothing about *where* the compute it multiplexes lives or how it's
snapshotted — that's a genuine gap next to CCR, and it's exactly what Fly.io and
Shellbox fill. This section works out what building that approximation would
actually take.

### The four properties worth reproducing

Distilled from this bundle's grounded CCR note
([em:52aefa](/knowledge/SWE/agentic/anthropic/claude-code/cloud-environment-architecture.md)),
CCR's architecture is load-bearing on four things, not just "a remote VM":

1. **Environment as a cached snapshot.** An environment bundles network-access
   level, env vars, and a setup script; the *first* session in it builds a
   filesystem snapshot, and later sessions warm-start from that snapshot
   (invalidated on setup-script/allowed-hosts change, or ~7-day expiry) —
   *"Anthropic snapshots the filesystem and reuses that snapshot as the
   starting point for later sessions."*
2. **Session as a disposable VM cloned from that snapshot.** *"Cloud sessions
   stop after a period of inactivity and the underlying environment is
   reclaimed"* — bounded persistence, not indefinite.
3. **Credentials never baked into the sandbox.** *"Sensitive credentials such
   as git credentials or signing keys are never inside the sandbox"* — signing
   is deferred to push time, on Anthropic's own trust boundary.
4. **Concurrent, independent sessions.** Each `--cloud` invocation is its own
   VM off the same environment; sessions don't share mutable state unless the
   operator wires that up deliberately.

Herdr covers none of these — it covers the *human-facing* half CCR also has
(reattach from anywhere, see status at a glance) but takes no position on the
compute underneath a pane. Fly.io and Shellbox are both infra that supplies
exactly properties 1 and 2; property 3 and the org-governance layer behind
property 1's setup script are things you'd still have to build yourself.

### Two VM roles, not one

CCR blurs "the thing you reattach to" and "the thing your session runs on"
into one product, but they're actually separable, and reproducing that split is
the key move:

```
 operator's laptop / phone
        │  (thin client, SSH or mobile-responsive web UI)
        ▼
 ┌───────────────────────────┐
 │  control-plane node        │   always-on (or wake-on-request), cheap,
 │  runs the herdr server     │   holds pane layout + per-pane status;
 │  (panes, tabs, status API) │   this is what "keeps it alive when you
 └──────────┬──────────────┬─┘   close the laptop"
            │ pane N: `ssh` │ pane M: `ssh`
            ▼               ▼
   ┌─────────────────┐  ┌─────────────────┐
   │ session VM N     │  │ session VM M     │   one per agent session,
   │ (Shellbox box /  │  │ (Shellbox box /  │   cloned from a shared base
   │  Fly Machine)     │  │  Fly Machine)     │   image, reclaimed/paused
   │ agent CLI + repo │  │ agent CLI + repo │   on idle
   └─────────────────┘  └─────────────────┘
```

Herdr itself makes this split cheap: it says it *"works locally, over SSH, or
as a thin client connecting to remote sessions,"* and — like `tmux` — a pane's
underlying process is just whatever command you give it. There's no
documented reason a pane's command couldn't be `ssh` into a separate remote
box rather than a locally-spawned agent process; this analysis did not fetch
herdr's docs beyond the homepage, so treat "panes can run an SSH command as
their process" as a reasonable inference from herdr's own tmux-like framing,
not a confirmed API.

### Mapping CCR's primitives onto Fly.io / Shellbox

| CCR primitive | Shellbox equivalent | Fly.io equivalent |
|---|---|---|
| Environment = image + setup script, snapshotted once | Bake a "golden" box: `create`, install agent CLI(s) + dotfiles, `git clone` the target repo, then leave it **stopped** as the template | Build a base image (Dockerfile) with the same contents, or start from a **Fly Sprite** (per secondary coverage, ships with Claude Code preinstalled) |
| Per-session VM cloned from that snapshot | `ssh shellbox.dev duplicate <golden-box> <session-name>` — instant, COW via btrfs reflinks, *"regardless of disk size"* (checked, quoted from shellbox.dev) | `fly machine clone` off the golden Machine, or a fresh Sprite instantiation (recalled — not confirmed against Fly's own docs this session) |
| Reclaim on inactivity | Default **stop** mode: pauses after 120s idle, billed $0.50/mo per slot while stopped, state preserved (checked, quoted) | Sprites' claimed checkpoint/restore (~1s per one press write-up; "under 25ms" resume per another — the two figures disagree and neither is confirmed against Fly's own docs, so treat both as unverified) |
| Repo cloned per session, not from the operator's machine | Bake the clone into the golden box, or `git clone` fresh in the setup step — same staleness risk this bundle's own CCR note already found, with the same fix (fetch-and-fast-forward before trusting local refs) | Same pattern; Fly's setup equivalent is the image build/entrypoint script |
| Credentials never baked into the sandbox | Don't store long-lived PATs in the golden box; forward the operator's SSH agent (`ssh -A`) transiently for pushes, or route pushes through a broker the box never holds keys for | Same approach; Fly's **secrets** mechanism can hold short-lived tokens injected at boot rather than baked into the image, but a genuinely never-in-the-sandbox design still means routing the actual push through something the box doesn't have standing credentials for |
| Concurrent, independent sessions | Each session = its own `duplicate`d box; no shared state unless wired | Each session = its own cloned Machine; **6PN private networking** (checked — a WireGuard mesh, `.internal` DNS) lets session VMs reach shared private services if that's wanted, which Shellbox's public-IPv6-per-box model doesn't offer without adding your own overlay |
| Remote reachability / notifications (Routines, push, Monitor) | **cron** mode (scheduled wake/run/stop cycles, checked) approximates Routines' scheduled firing; there's nothing on the fetched homepage resembling push notifications — that's a gap | No equivalent found in what was fetched either; both would need a small external watcher |

### Build order

1. **Provision the control-plane node.** A single small, cheap, always-on
   Shellbox box (`keepalive` mode) or Fly Machine, install herdr's server on
   it, expose it over SSH/HTTPS the way herdr documents.
2. **Build the golden session image.** One box/Machine with the target agent
   CLI(s) (Claude Code, Codex, …), language toolchains, and dotfiles installed;
   `git clone` the repo(s) you want sessions to start from; stop it once
   configured — this is the environment-snapshot analog.
3. **Wire session creation to a pane.** From the control-plane node (or
   herdr's socket API), spawning a new session pane calls out to
   `shellbox.dev duplicate` (or `fly machine clone`) against the golden image,
   then opens a pane whose command is `ssh` into the freshly cloned box.
4. **Reproduce the "reclaimed on inactivity" property.** Rely on Shellbox's
   default `stop` mode, or Fly's Sprite standby/checkpoint behavior, rather
   than a `keepalive` mode, for session boxes specifically — the control-plane
   node is the one thing that should stay `keepalive`.
5. **Keep credentials off the session boxes.** Forward the operator's own SSH
   agent for git pushes (or route pushes through a small broker service the
   session box never holds long-lived credentials for) — this is the piece
   with no vendor primitive; it has to be built, and it's also where this
   design is weakest relative to CCR (see below).
6. **Build a status/notification watcher, if remote/mobile awareness matters.**
   Herdr's socket API already exposes per-pane status (blocked/working/done);
   a small poller that pushes a notification (ntfy/Pushover/webhook) on a
   status change approximates CCR's push-notification/Routines surface — this
   is genuinely new glue, not something either vendor ships.
7. **Add cross-agent coordination, if wanted.** Agent teams' own design — a
   shared, file-locked task list plus per-agent JSON mailboxes
   ([em:33e0c7](/knowledge/SWE/agentic/anthropic/claude-code/agent-teams.md)) —
   is a reasonable pattern to copy: a shared task-list file/SQLite DB plus
   per-pane mailbox files, read/written through herdr's socket API, gives
   herdr's cross-vendor panes something agent teams doesn't have (Claude Code
   is Claude-only) at the cost of building it from scratch.

### What still doesn't have an off-the-shelf answer

- **Org-managed, non-repo settings injection.** CCR layers organization-managed
  settings on top of the repo's own, invisibly to the repo. Reproducing that
  means building your own out-of-repo config injection at image-build or boot
  time (a secrets manager fetch in the setup script) — there's no vendor
  primitive for it.
- **The credential-custody boundary.** CCR's "never inside the sandbox" property
  is a trust claim about *Anthropic's own* hypervisor boundary. The DIY version
  moves that same boundary onto a third-party vendor (Fly or Shellbox) the
  operator doesn't control the internals of — forwarding an SSH agent into
  someone else's VM is a materially different trust posture than Anthropic's
  design, even where the mechanics (never bake in long-lived keys) look
  similar.
- **Native cross-vendor multi-agent coordination.** Agent teams ships as a
  first-party feature for Claude Code sessions; the herdr equivalent above is
  bespoke glue on top of the socket API, not a shipped capability of either
  herdr or the infra layer.
- **Push notifications / scheduled wake as a shipped feature.** Neither
  herdr's homepage nor either infra vendor's fetched pages describe this;
  Shellbox's `cron` mode covers *scheduled* wake but not *event-triggered*
  push, which is what this session's own `PushNotification`/`Monitor`/Routines
  tools give CCR natively.

### Fly.io vs Shellbox for the session-VM role

| | Shellbox | Fly.io (Machines / Sprites) |
|---|---|---|
| Purpose-fit | Explicitly *"for builders and AI agents"* | General VM platform; Sprites (Jan 2026, per secondary coverage) is purpose-built for agent workloads specifically |
| Regions | Bare metal, Hetzner Finland only (checked) | Multi-region (general Fly.io knowledge; not re-confirmed this session) |
| Private networking between session VMs | None documented on the fetched homepage — would need your own overlay (Tailscale/WireGuard) | 6PN — a WireGuard mesh with `.internal` DNS, on by default within an org (checked) |
| Snapshot/clone primitive | `duplicate` — instant COW clone regardless of disk size (checked) | `fly machine clone` (recalled, unconfirmed this session); Sprites' checkpoint/restore (unconfirmed latency, see above) |
| Auth model | SSH-key-is-your-account, no signup/tokens (checked) — fits headless automation cleanly | Standard account/API-token model (general knowledge) |
| Pricing shape | Per-minute while running (checked: $0.02/hr for a 2vCPU/4GB/50GB box), $0.50/mo per slot while stopped | Per-second while running, storage billed while stopped, volumes at $0.15/GB/mo (checked from Fly's pricing docs) |
| Maturity for this exact use case | New, narrow, single-vendor bet | Sprites is also new (Jan 2026); Fly Machines/6PN are the mature layer underneath it |

Neither vendor is a wrong choice; they trade off differently. Shellbox is the
closer conceptual match to a single disposable session box and the simpler
auth story for headless automation; Fly buys private networking between
session VMs and, via Sprites, a base image that reportedly already has Claude
Code installed — useful if the golden-image step in the build order above is
meant to matter less.

## Verdict

- **Not a strict substitute.** Herdr is infrastructure for hosting agent
  processes; Claude Code is one such agent (with its own competing
  infrastructure attached). Comparing them head-to-head only makes sense on
  the specific axis of "how do I get a persistent, remote-reachable coding
  agent session" — where they are genuine alternatives — not on agent
  capability, where they aren't comparable at all.
- **Pick herdr** when the requirement is vendor-agnostic multi-agent hosting,
  self-hosted infrastructure, or a terminal-native pane UI with a scriptable
  control API — especially if more than one agent vendor is in play.
- **Pick Claude Code's own remote surface (CCR/Routines)** when the
  requirement is zero-ops (Anthropic hosts the VM), tight integration with
  Claude Code's own feature set (skills, hooks, MCP, agent teams), and only
  one vendor is in use.
- **They are not mutually exclusive**: herdr's own claimed integration list
  means the more likely real-world shape is Claude Code sessions running
  *inside* herdr, not one replacing the other.
- **CCR's architecture is approximable, not fully reproducible.** Splitting
  compute into an always-on herdr control-plane node plus disposable
  per-session VMs cloned from a shared base image (via Shellbox's `duplicate`
  or a Fly Machine/Sprite clone) reproduces the environment→snapshot→ephemeral
  session shape CCR actually runs on — see
  [Approximating CCR's architecture](#approximating-ccrs-architecture-with-herdr--infra)
  above. Org-managed settings injection, native cross-vendor agent-teaming, and
  CCR's own credential-custody boundary are the pieces that stay bespoke or
  structurally weaker in the DIY version.

## Source notes

Herdr facts are quoted verbatim from a direct fetch of <https://herdr.dev/> on
2026-08-02; no further pages (docs, pricing, GitHub repo) were fetched, so this
analysis is scoped to what the homepage states and does not claim completeness
about herdr's plugin API, its exact pricing/support model beyond "open-source,"
or version-specific behavior. Claude Code facts are drawn from two bundle notes
grounded against Anthropic's official docs —
[cloud-environment-architecture.md](/knowledge/SWE/agentic/anthropic/claude-code/cloud-environment-architecture.md)
(fetched/grounded 2026-07-05/06) and
[agent-teams.md](/knowledge/SWE/agentic/anthropic/claude-code/agent-teams.md)
(fetched 2026-07-26, official docs stated as of v2.1.178–v2.1.207) — plus this
session's own live tool roster (observed 2026-08-02) as direct, checked
evidence of the remote/background/notification surface currently shipped.
Claude Code's pricing model is stated from general product knowledge, not a
source fetched this session, and should be treated as recalled rather than
freshly checked.

**Infra sources (added 2026-08-02).** Shellbox facts are quoted from a direct
fetch of <https://shellbox.dev/> — its full homepage, not only `#synopsis`.
Fly.io facts split by how they were obtained: Machines pricing
(<https://fly.io/docs/about/pricing/>) and private networking/6PN
(<https://fly.io/docs/networking/private-networking/>, reached via a redirect
from the `/docs/reference/` path) were fetched directly and are checked; the
plain Machines overview page (`/docs/machines/`) rendered too thin to yield
more than its top-level framing. Fly's own Sprites page
(<https://fly.io/sprites/>) returned only its CLI-install instructions on
every fetch attempted — the page appears to be a JS-rendered app shell this
tool can't execute — so every Sprites claim in this analysis (checkpoint/restore
latency, 100GB storage, free standby, Claude Code preinstalled, January 2026
launch) is drawn from secondary press coverage (opentools.ai, SDxCentral,
devclass) found via web search, **not** confirmed against Fly's own
documentation. Scope: this session did not fetch Shellbox's or Fly's API
reference docs, so claims about specific CLI/API call shapes (`duplicate`,
`fly machine clone`, Fly secrets injection) beyond what the fetched pages
stated are marked recalled/unconfirmed inline rather than asserted as checked.
