---
type: reference
title: 2026-07-30-neovim-adoption-and-the-agent-pairing-project
description: A research-into-design session that started with Neovim's staying power in the agentic era and the tooling around it (claudecode.nvim, herdr, hunk, sidekick.nvim), sharpened into the agent-as-driver pairing posture and the editor-as-sensor thesis, and closed by incubating the agent-pairing project — a broker-plus-thin-clients supervision layer — with knowledge docs, glossary terms, and six project design records including compliance, sonification, and BEAM/Jido analyses.
provenance: "Claude Code session (Claude Fable 5 and Claude Opus 5, model switched several times), 2026-07-30; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, neovim, agents, supervision, editor-integration, agent-pairing, hooks, beam, jido, sonification, compliance, observability]
timestamp: 2026-07-30
session: https://claude.ai/code/session_01TE4bE6ESQCfAWkdEuwBCJb
---

# 2026-07-30-neovim-adoption-and-the-agent-pairing-project

## User

Neovim appears to be growing in adoption.  What is explaining its staying power if devs aren't writing code anymore?
What is claudecode.nvim?
What about a workflow with neovim and herdr? What would that look like?
Do you need a pr review app like hunk if you have neovim?
What about the capability of neovim being driven by an agent? Are devs adopting that yet?

## Assistant

Here's the picture, from a research pass over the current ecosystem (all checked against live sources today; links at the end).

**The short version:** Neovim's growth isn't happening *despite* agents writing the code — it's happening because the whole agentic workflow moved into the terminal, and Neovim is the editor that lives there natively. Claude Code, Codex CLI, and their peers are terminal programs; the natural cockpit around them is a terminal multiplexer plus a terminal editor, not a GUI IDE. The tools you named — claudecode.nvim, herdr, hunk — are three layers of exactly that stack: the editor↔agent bridge, the multi-agent control room, and the review surface.

**Why Neovim is holding up when devs write less code.** The 2025 Stack Overflow survey put Neovim at ~14% and Vim at ~24% — together rivaling every graphical IDE except VS Code (~76%). What changed is the developer's job: less typing, more *steering* — reading diffs, jumping between files an agent touched, giving precise context, supervising several sessions. That job rewards what Neovim was already good at: it's keyboard-fast for navigation rather than authorship, it's scriptable (so it integrates with agents rather than embedding a chatbot UI), and it runs over SSH on the remote boxes where agent fleets increasingly live. Meanwhile the historical argument *against* it — "an IDE gives you more assistance while writing" — matters less when the agent is doing the writing. The AI plugin ecosystem (avante.nvim, codecompanion.nvim, copilot.lua) closed the remaining gap.

**claudecode.nvim.** coder/claudecode.nvim (from Coder, the cloud dev-environment company) is the de facto official Claude Code IDE extension for Neovim. Anthropic ships first-party extensions for VS Code and JetBrains; those talk to the Claude Code CLI over a WebSocket MCP protocol. Coder's plugin is a pure-Lua reimplementation of that same protocol — it starts a WebSocket server, writes a lock file under `~/.claude/ide/`, and the Claude Code CLI discovers it. The result: Claude sees your current buffer and visual selection as context, and its edits can flow back through Neovim's diff view for accept/reject. There are also community wrappers (greggh/claude-code.nvim and others) that just toggle a terminal split, but the Coder one is the protocol-faithful integration.

<routes ref="em:ca359c">
**A Neovim + herdr workflow.** herdr is a Rust terminal multiplexer built specifically for running a *herd* of coding agents: each agent gets a real PTY pane, a background server keeps sessions alive (detach/reattach like tmux, including over SSH), and a sidebar classifies every agent as **blocked / working / done / idle** by watching process names and output. It hit #1 in Rust on GitHub Trending in late June. A concrete workflow: launch a deck (one YAML file opens a Neovim pane, agent panes, a shell, lazygit per project/worktree); navigate seamlessly (the same `Ctrl+h/j/k/l` flows from a Vim split into the adjacent agent pane); feed context from the editor (herdr-context.nvim stages a visual selection into an agent's prompt); steer by the sidebar (work in Neovim until an agent flips to blocked or done); detach and go (the herd keeps running on the server; reattach from a laptop or phone over SSH). herdr is also a first-class backend in sidekick.nvim.
</routes>

**Do you need something like hunk if you have Neovim?** Different problem than it first appears. Neovim already has excellent diff tooling for *editing-time* diffs — gitsigns, diffview.nvim, fugitive — and claudecode.nvim's accept/reject flow covers per-edit review. hunk targets the *changeset-scale* review problem agents create: big multi-file local diffs produced faster than you can read them, with the reasoning trapped in a chat log. Its distinguishing features are watch mode, agent-aware inline annotations, and Jujutsu/Sapling support. So: strictly *need*, no — diffview.nvim covers a lot. But hunk isn't a PR-review GUI you'd replace with Neovim; it's a terminal tool designed to sit in the pane next to Neovim and the agent, and its agent-annotation angle has no real Neovim-native equivalent today.

**Agents driving Neovim itself.** The capability exists and is genuinely interesting: several MCP servers (nvim-mcp, laktek/nvim-mcp-server, mcp-neovim-server) expose Neovim's msgpack-RPC socket to agents, so Claude can open buffers, move the cursor, edit buffer contents in memory (with undo history intact), run Vim commands, query LSP diagnostics, and highlight regions. Adoption is a different story: this is the least-adopted layer of the stack. These servers are individual-maintainer projects with modest traction, while the mainstream pattern that's actually winning is the inverse — the agent works the filesystem and the editor *observes* (claudecode.nvim's context-sharing, hunk's watch mode). My read on why: buffer-level control adds failure modes without much payoff over file-level editing plus a good diff surface. The exception where RPC-driving shines is *interrogation* rather than editing: letting the agent query LSP diagnostics and editor state as a sensor. That part I'd expect to get absorbed into the mainstream integrations.

If you want, I can `/intake` this into the brain — it would file naturally as reference docs under `knowledge/SWE/` (tooling/agentic), with the herdr workflow as the connective piece.

## User

Expand on this: "it's scriptable (so it integrates with agents rather than embedding a chatbot UI), "

## User

Describe these plugins: avante.nvim, codecompanion.nvim, copilot.lua

## Assistant

# /elaborate — "it's scriptable (so it integrates with agents rather than embedding a chatbot UI)"

> "it's scriptable (so it integrates with agents rather than embedding a chatbot UI)" — from my answer earlier this session on why Neovim's adoption holds up in the agentic era.

## In plain terms

Neovim can be controlled and extended by other programs, not only by a person pressing keys. Everything the editor can do — open a file, read what's on screen, change text, show a before-and-after comparison — can also be requested by an outside program talking to it. Because of that, an AI coding assistant doesn't need to be built *into* the editor by the editor's makers: it runs as its own separate program and connects to the editor from outside, the way a remote control connects to a television. Editors without that property have to take the opposite path — their vendor builds an AI chat window into the product itself, and users get whatever assistant the vendor chose, updated at the vendor's pace.

## The terms

- **scriptable** — an application is scriptable when its operations are exposed as a programmable surface rather than only through its human interface. Neovim is scriptable in two stacked senses: it embeds a Lua runtime (plugins are ordinary Lua programs with access to the full editor API), and it exposes that same API to *external* processes over a socket.
- **remote procedure call (RPC)** — one process invoking functions inside another as if local, with typed arguments and return values. Neovim speaks MessagePack-RPC on an auto-created socket; every Neovim GUI is just an RPC client, and an agent connecting to that socket is architecturally the same kind of client as a GUI.
- **coding agent** — a language model run in a loop by a harness that gives it tools and feeds results back. The relevant ones (Claude Code, Codex CLI) are terminal programs, external to any editor.
- **chatbot UI (embedded chat panel)** — the integration style where the assistant is a feature of the editor's own codebase: a chat sidebar compiled into the product (Cursor, VS Code's Copilot Chat).
- **Model Context Protocol (MCP)** — the open protocol agents use to talk to external tools; the Claude Code ↔ editor bridge, including claudecode.nvim, is MCP over a local WebSocket.
- **shared state, dual interfaces** — this bundle's own name for the resulting architecture: a human-facing UI and an agent-facing structured API operating as two clients of the same live process state.

## What's actually happening

There are two ways to put an AI assistant in front of an editor's user. **Embedding** puts the assistant inside the editor — the vendor writes a chat panel and ships it, and the editor grows a second job. **Integration via scriptability** inverts the dependency: the agent stays a separate terminal program, and the editor's job is only to expose what it already has to outside clients. With claudecode.nvim: a plugin (ordinary Lua) starts a small WebSocket server inside the editor and writes its port to a lock file; the Claude Code CLI finds the lock file and connects; the editor pushes context, the agent pushes edits back, and the plugin renders them as native diffs. The integration is agent-agnostic, decoupled in pace, and thin — the editor stays shared, inspectable state both act on.

---

# The three plugins

**copilot.lua** — the inline-completion layer. A pure-Lua client for GitHub Copilot that renders ghost-text suggestions as you type, integrating with completion engines like nvim-cmp and blink.cmp. Single-provider, no chat, no multi-file edits.

**avante.nvim** — the Cursor-imitation layer, most-starred of the three (17k+). Its pitch is "Use your Neovim like using Cursor AI IDE": select code, describe a change, get a sidebar with a diff you apply hunk-by-hunk. Multi-provider — Claude, OpenAI, Gemini, Copilot, Ollama. Strongest of the three for larger refactors.

**codecompanion.nvim** — the buffer-native chat layer (6k+ stars). Chat in an ordinary Neovim buffer, with context variables (`@buffer`, `@lsp`) that pull code and live LSP diagnostics into the prompt, plus inline transformations and tool-use. Most aligned with Neovim idiom.

These three are *embedded-assistant* plugins. The claudecode.nvim/herdr stack instead treats the agent as an external process. In practice people run both: copilot.lua for keystroke-level completion, and an external agent for multi-file work.

## User

What about sidekick.nvim

## Assistant

sidekick.nvim is folke's entry in this space (~2.7k stars), and it's the one that most directly matches how I'd expect you to work — it's the bridge between the two halves of my earlier answer. Rather than being an in-editor chatbot (avante/codecompanion) *or* leaving the agent entirely outside (claudecode.nvim/herdr), it does both at once through two independent subsystems.

**Next Edit Suggestions (NES).** The more novel half. Instead of ghost-text completion at the cursor, it uses the Copilot **LSP**'s next-edit-suggestion capability: you pause or move the cursor, and it predicts the *next edit you'd make anywhere in the file* — the classic case being "you renamed this parameter, so here are the four other places that need updating." It renders those as Treesitter-highlighted diffs, word- or character-granular, walked with `<Tab>`. Requires a Copilot subscription and Neovim ≥ 0.11.2.

**AI CLI terminal.** The second subsystem is provider-agnostic terminal management: it preconfigures **aider, amazon_q, claude, codex, copilot, crush, cursor, gemini, grok, opencode, pi, qwen**, each in its own scratch terminal, with session persistence via tmux or zellij and automatic file reloading. On top sits a prompt library (`changes`, `diagnostics`, `explain`, `fix`, `optimize`, `review`, `tests`, `quickfix`) composed with context variables — `{file}`, `{selection}`, `{position}`, `{diagnostics}`, `{diagnostics_all}`, `{function}`, `{class}`, `{buffers}`, `{quickfix}`, `{this}`.

The two halves are deliberately decoupled — the CLI integration works with no Copilot subscription, so you can run NES off and sidekick purely as your Claude Code launcher.

**On herdr:** I said earlier that herdr is a first-class sidekick backend. Correcting the basis on that — sidekick's own README documents only `backend = "tmux"|"zellij"`. The herdr support is listed in awesome-herdr as a separate entry, "Herdr backend for sidekick.nvim", so it appears to be an external/contributed backend rather than an upstream option. That list also carries five other Neovim↔herdr integrations: `herdr.nvim` (pane navigation), `MomePP/herd.nvim` (Neovim as host for herdr agents), `vim-herdr-navigation`, `herdr-splits.nvim`, and `herdr.vim` (REPL spawning).

**Where it sits against the others:** copilot.lua does keystroke-level completion; sidekick's NES does file-level *predicted* edits; avante does you-describe-it sidebar refactors; codecompanion does buffer-native chat; claudecode.nvim hands the editor's context to an external agent over MCP. sidekick uniquely covers two of those tiers at once, and its CLI half overlaps claudecode.nvim's territory — the difference being that sidekick manages the agent as a *terminal session it owns* (context injected by prompt templating), while claudecode.nvim speaks the actual MCP IDE protocol so the agent pulls context and pushes diffs back natively. If you're running Claude Code specifically, those two are genuine alternatives; if you're switching between several agent CLIs, sidekick's twelve-tool preconfiguration is the argument for it.

## User

"The exception where RPC-driving shines is interrogation rather than editing: letting the agent query LSP diagnostics and editor state as a sensor. That part I'd expect to get absorbed into the mainstream integrations."

Also explain, can mainstream integrations reach the same depth of integration as neovim can

## Assistant

Both halves are below — the phrase expansion (persisted and pushed), then the depth question, which turns out to be territory the brain has already staked out.

**Orientation:** the sentence you flagged makes a claim about *direction* — that pointing an agent at a live editor pays off when the agent is reading from it, not writing into it. The second question asks whether editors like VS Code can ever be as deeply agent-integrated as Neovim. The short answer there is that they can get most of the way, but the last stretch is blocked by an architectural fact, not a feature gap — and this bundle already investigated it in July.

# /elaborate — "RPC-driving shines at interrogation rather than editing"

## In plain terms

Programs can control a running editor from the outside. Most attempts have the outside program *change* the text — which mostly duplicates what it could already do by editing files, while adding new ways to get in the way of the person using the editor. The genuinely useful direction is the opposite: letting the outside program *ask questions*. A running editor knows things nobody else has cheaply — which errors the language tooling has computed for this exact file right now, what the person is looking at, what changed but isn't saved. An assistant that can ask for those answers gets a live picture it would otherwise recompute or guess at. The prediction: this asking-questions ability is useful enough that it stops being a niche add-on and becomes a standard part of how assistants connect to editors.

## What's actually happening

The write direction disappoints because it does at greater cost what file-writing already does, while adding a second writer inside a session a human is also using, plus a new failure class. The read direction has no substitute: an agent that just changed six files and wants to know whether it broke something defaults to shelling out — compile, run tests — costing seconds to minutes and seeing only saved files. The editor already has the answer in memory, one socket call away. So the useful arrangement is: read the editor as an instrument, write through the ordinary file-and-diff path. As for absorption — the mainstream bridges already hold an open channel and already push current-file/selection context; carrying diagnostics too is an increment, not a new architecture.

# Can mainstream integrations reach Neovim's depth?

Mostly yes, with one structural asymmetry that isn't closing. Everything in the *negotiated* direction is already at parity or better — VS Code and JetBrains ship first-party Claude Code extensions with the same MCP protocol, and VS Code's extension API exposes diagnostics, open editors, and selection to any extension. The asymmetry sits in ambient versus bolted-on. Neovim ≥ 0.10 auto-listens on an RPC socket with **zero configuration** — the socket is there before any agent exists, and it exposes the *entire* editor API. The July agent-drivable-apps analysis demonstrated this empirically, and its verdict on the other side was blunt: "VS Code has no first-class external RPC surface; no `--listen` equivalent; drivability must be bolted on per-editor via extensions." I checked today and it still holds — external VS Code control exists only through third-party extensions (hediet/vscode-rpc, VSCode Internals Gateway).

Three reasons the gap persists, in order of durability: **architecture** (Neovim's API-first design makes external control the same code path as GUI rendering; VS Code's equivalent RPC is internal), **surface completeness** (an extension can only expose what the extension API exposes), and **incentive** (the AI-IDE sells a bundle that full external drivability unbundles). Net: for the workflows people actually run, mainstream integrations reach parity. The unreachable depth is arbitrary, unanticipated, zero-setup control of the live editor — and that capability is worth less than the July analysis implicitly weighted it, precisely because the write half is the part you don't want anyway. On basis: reasons 1 and 2 are architectural facts I'm confident in; reason 3 is the July analysis's judgment, relayed.

## User

What about a workflow where the user is chatting with an agent in one pane, and then watching the agent manipulate neovim in the other? Is a way, pair programming, with the agent controlling neovim? This could be seen as the user driving the driver

## Assistant

Yes — and your framing catches something my last answer got wrong, so let me start there.

**The scope condition I missed.** I argued the write direction of RPC-driving is redundant because "the same text ends up in the same place" via file writes. That argument silently assumes the human's attention is *elsewhere* while the agent works — that the editor is a destination, not a display. Your workflow breaks that assumption. If you're watching, the editor *is* the display, and writing through it is no longer redundant delivery — it's the entire product. What lands in the file is incidental; what you saw land is the point. So the elaboration I filed twenty minutes ago is under-scoped, not wrong: it holds for unattended work and misses the attended case.

<routes ref="em:87c81a">
**"Driving the driver" is the right name for it.** In classic pair programming the driver types tactically while the navigator holds strategy and reviews in real time — and the navigator is usually the more experienced one. Mapping the agent to driver and you to navigator is arguably the *natural* assignment for agentic coding, and it's notable that essentially nothing mainstream does it. What Claude Code, Cursor's agent mode, and the rest actually ship is "agent works out of sight, then presents a diff," which isn't pair programming at all — it's asynchronous code review with a very fast contributor.
</routes>

What the attended version buys, in descending weight: **interruption latency collapses** (catch the wrong turn when it happens, not after it's built out); **sequence carries reasoning** (watching preserves order, which the diff throws away); **a shared referent, for free** (deixis works — "not that one, the one above"); and **it pays down cognitive debt** (watching is editorial engagement in real time rather than deferred).

Three problems keep it from existing: **speed mismatch** (an agent applies forty edits in three seconds; watching that is a screensaver — the fix is deliberate pacing, which no agent ships, and it's a harness behavior, not an editor feature); **two writers, one buffer** (needs an explicit write token nobody has designed); and **the attention economics run backwards** (people run agents precisely so they don't have to watch — pairing is a per-task posture, opposite end of a spectrum from monitor-by-exception).

What you can run today: let the agent write files and let Neovim follow (autoread + a watcher), so there's no race and no lock protocol. Add `hunk --watch` for the live diff view. That's the shipped, sane form of the idea — watch-it-happen without buffer contention. What the RPC layer adds on top is navigation and annotation rather than editing — the read-and-present direction, which the brain already names agent-as-presenter. Your proposal is that term's live-narration variant: not "show me what you did" but "show me while you do it."

## User

Is there an opportunity for a plugin to be built that might optimize or extend this sort of functionality? What changes to the harness need to be made?

## Assistant

Checked — four searches, one per item. Net: **4 and 5 are substantially shipped, but at the harness/CLI layer, not the editor; 2 and 3 are unshipped in the form that matters.** [Note: this heading belongs to a later turn — see below; the opportunity/harness turn's delivered text follows.]

Good question to push on — the answer inverts what you'd expect. The headline is the opposite of what the question implies: **you don't need harness changes.** The pacing, blocking, and reverse-channel primitives this workflow needs all already exist as Claude Code hooks, including one that can hold a tool call for up to ten minutes while waiting on a human. The missing piece is entirely on the editor side.

The plugin, in three tiers. **Tier 1 — follow mode:** watch the working tree, jump to the changed hunk, show the diagnostic delta. Zero agent cooperation. **Tier 2 — the replay buffer:** queue the agent's edits and replay at reading speed, with pause/step/rewind/jump-to-live — a DVR for agent edits, which dissolves the speed-mismatch problem by not asking the agent to slow down. **Tier 3 — the interjection loop:** where the hooks come in.

<routes ref="em:8a9ed7">
The harness seam, with the field names from the hooks reference: `PreToolUse` fires before the call and is synchronous and blocking by default with a 600-second timeout; `permissionDecision` takes allow/deny/ask/defer; `permissionDecisionReason` and `additionalContext` carry text back into the model; and `updatedInput` rewrites the tool arguments — so the navigator can correct the driver's keystroke *before it happens*. What the harness genuinely lacks: no semantic unit boundary, no structured intent (only structured action), no cheap rollback checkpoint, no standard event schema across agents.
</routes>

Is it a real opportunity? Yes, with the moat in the durable part. Tier 1 is absorbable; tier 2 (replay) is genuinely novel; tier 3 is the durable piece precisely because it's not a Neovim feature — it's an agent-editor pacing protocol. Which argues for building broker-first: a daemon owns the hook endpoints, the pending-edit queue, the ack protocol, and the replay buffer; editor plugins are thin clients. That matches the capability-scoped broker shape this bundle keeps re-deriving.

## User

Is there scope beyond this which could manifest as extended functionality within the plugin?

## Assistant

Yes — and the interesting extensions aren't more editing features. Five directions, ranked by how much I'd bet on them.

**1. Attention-aware scheduling — the editor drives the agent.** The plugin knows your cursor and visible region; feed that back and the agent schedules around you — works ahead in files you aren't watching, yields on the buffer you're editing. The two-writers problem dissolves by scheduling, not locking. Redeems the interrogation thesis: editor-as-sensor feeds the agent's *scheduling*, not just its understanding.

**2. Exploration visibility — show what the agent read, not just what it wrote.** `PreToolUse` fires on Read/Grep/Glob too, so render the agent's search — spotting that it's editing a file it never read. Watching what an agent *looked at* is often more diagnostic than what it typed.

**3. Fleet supervision, with quickfix as the exception queue.** Route every agent's blocking decision point into Neovim's quickfix list so `]q` becomes "next thing needing me" across the herd. monitor-by-exception in a widget from 1991.

**4. The session recording as a durable artifact.** Persist the replay buffer and the full-attention-synchronous constraint goes away. Post-mortem, teaching, onboarding.

**5. Interjection capture, and promoting corrections into rules.** Capture interjections anchored to code and commit; notice repetition; offer to promote a repeated correction into standing instructions. Learning from the human at the right granularity — the same move the contract makes when a recurring miss updates the policy.

The discipline note: a plugin that does all five is an IDE, and the thing that makes it valuable is that it isn't one. Hold the broker boundary — the daemon owns the stream and protocol; the plugin only renders and captures keys. If I had to pick two after tier 1: exploration visibility (cheapest) and interjection capture (compounding).

## User

2 - is it that this is surfacing actions that would be viewable in a trace but in an operator observable way? Or is it that it is surfacing actions that would not otherwise be surfaceability? What are the implications for observability?

## Assistant

Mostly the first — with one exception that is genuinely the second, and the exception is where both the value and the risk concentrate.

**The re-rendering half.** The positive events are already in the trace. What item 2 does is re-project them: the trace lays the stream along the time axis, the plugin lays it over the artifact space. Same data, different join key — a derived view. But "viewable in a trace" and "observable" are different: a trace is read retrospectively and rarely; the spatial rendering is ambient and contemporaneous. A trace answers questions you already have; an ambient rendering *generates* them. Same distinction ops observability draws between logs and dashboards.

<routes ref="em:7404fb">
**The genuinely-new half.** Two things aren't in any trace because they aren't events: **absences** ("edited a file it never read" is a join, not a recorded action) and **the correlation with you** ("editing a region you reviewed under different assumptions" joins the agent's stream with your attention state).
</routes>

Implications: the bottleneck moves from recording to salience; the rendering becomes trusted, so its fidelity becomes safety-critical (a wrong mark produces confident false situational awareness); absence-rendering inherits the scoping problem (a "not seen" mark is a claim about a stream, not the agent's knowledge); and it stops being passive the moment you act on it — item 2 is the sensor half of a control loop with the human as controller.

## User

Check if anyone ships 2-5

## Assistant

Checked — four searches, one per item. Net: **4 and 5 are substantially shipped, but at the harness/CLI layer, not the editor; 2 and 3 are unshipped in the form that matters.**

<routes ref="em:b4bb5e">
**2 — Exploration visibility: not shipped as described.** What exists is trace-shaped — agent panes show "Read X / Grepped Y" as a chat-column activity feed, agent-inspect renders tool-call execution trees. The spatial projection onto the editor's file tree and the computed absences turned up nowhere. **3 — Decision-granularity fleet supervision: shipped outside the editor.** Omnara pushes agent questions to your phone; Vibe Kanban gives a review-column queue. The quickfix-in-Neovim shape, none. **4 — Session recording: shipped, and well.** Entire.io captures sessions via hooks, checkpoints on commit, append-only shadow branch, `entire rewind`. What I did not find: the paced-replay half. **5 — Corrections becoming rules: shipped at the harness layer.** Claude Code's auto memory learns from corrections into `~/.claude/projects/<project>/memory/`. What remains unshipped is the *governed* variant — anchored capture, repetition detection, ratified promotion into committed rules.
</routes>

Two revisions follow: tier 2 should *consume* Entire's checkpoint stream rather than build its own recorder; and item 5 drops from "most strategic" to "differentiate or skip," since the harness vendors own the learning loop and only the governance residue is defensible. Scope: four web searches plus the earlier sweeps; I did not enumerate the VS Code or JetBrains marketplaces.

## User

Ok lets wrap this thread. Propose the best ways to capture actionable info here. My thoughts:
Glossary entries
Analasys/analyses
A project, "nvim-plugin" with artifacts exploring fearures, rationales, and plan(s)

## Assistant

Two findings that change the shape of your proposal — then the plan.

**No knowledge doc exists for any tool in this thread.** herdr, claudecode.nvim, sidekick.nvim, avante, hunk-as-a-tool, Entire — all of it lives only in glossary entries and the July analysis. Your three categories would file the *judgments* and skip the *facts*, which is exactly the case the project-namespace split rule exists to catch. That's the fourth category I'd add, and the highest-value one. I also fixed the elaboration blind spot rather than offering it a fourth time.

**1. Knowledge taxonomy** — a new `knowledge/SWE/agentic/editor-integration/` plus a hooks-as-supervision-seam doc under the Claude Code path. The observability doc is the most transferable output; the hooks doc is the only one that could carry `verified: true`. **2. The project — but not under that name.** `nvim-plugin` names the least durable layer; we landed on broker-first. Recommend `agent-pairing`. **3. Glossary** — LSP, PreToolUse hook, next edit suggestion, agent multiplexer, plus repo-sense coinages. **4. Thread capture.**

Questions: (1) build or record-the-judgment? recommend filing the project at `status: incubating` either way; (2) slug — `agent-pairing`; (3) full scope or cut? recommend cutting to the 4 knowledge docs + hub + opportunity analysis, deferring the plan and glossary. [Operator answered: build; agent-pairing; full scope; and requested three additional analyses.]

## User

Yes, write all documentation from most recent assumption / first principles, no reference to overturned conclusions
Also - create an analysis on how this plugin compares and contrasts with herdr and cmux. In what ways is it complementary, it what ways might it be competitive or in some cases supercede
Agree on shift to agent-pairing
1. I plan to build
2. Agent-pairing
3. Full scope

## Assistant

Full scope landed — all gates green (188 tests, verify/registry/route-tags/glossary/lineage clean), 16 ids minted, registry and glossary index regenerated.

<routes ref="em:4d48ef">
The routing followed the split rule: findings true regardless of the system went to the taxonomy with `em:` ids, and only what is true *for this system* went under `projects/agent-pairing/`. That's why the hooks reference and the console landscape are knowledge rather than project docs.
</routes>

<routes ref="em:48e404">
On the comparison: the verdict is that herdr and cmux are complementary at the substrate level and contest exactly one surface — attention routing. Their sidebars answer *which agent needs me* by inferring state from process names and rendered output; the decision queue answers it from typed hook payloads and at edit granularity, which subsumes the question. So the supersession is bounded to the sidebar's role as *primary* queue — one feature demoted, no tool displaced. The single path where it turns genuinely competitive is herdr binding hooks and rendering edits itself, which is off-thesis for a terminal and weak on the editor-side half, since a terminal sees pixels where the editor sees structure.
</routes>

Created: the four knowledge docs (editor-integration landscape, agent-as-driver, ambient observability, supervision consoles), the hooks-as-supervision-seam reference, the project hub, the architecture plan, and the opportunity and herdr/cmux analyses; plus seven glossary terms.

## User

Commit, then:
Create three alayses to go in the project folder -
In what ways might this affect agent observability as a discpline when it comes to compliance and governance
What would it look like to add a real time sonification layer
What might the implications be to integrate agents on the BEAM, specifically Jido 2

## Assistant

Landed — all gates green. The "commit first" step was a no-op: the tree was already clean from the previous push. Three analyses now sit in the project folder, each with a minted id.

<routes ref="em:712e01 em:24c203">
**Compliance/governance.** The broker log is a different *kind* of record from a trace, not a better one: a trace is descriptive (what the agent did), the acknowledgement protocol's log is **normative** (what was authorized, by whom, with what reason, what was amended first). That's the artifact "meaningful human oversight" obligations actually ask for, and today it exists nowhere below the PR-approval boundary. Discipline-level effect: the unit of observability moves from the trace to the decision, and auditing shifts to verifying the instrumentation. Two failure modes hollow it out — rubber-stamping (visible as collapsing ack latencies, and Goodhartable) and ungated action paths. Recommendation: don't build for compliance, but take the two free enablers — append-only typed records and posture stamping. I flagged the regulatory mapping as directional from training knowledge.
</routes>

<routes ref="em:857398">
**Sonification.** A genuine tier, not a gimmick — the one *below* tier 1, the only rendering that adds supervision capacity without spending visual attention: eyes on your own buffer, ears on the herd. A continuous ambient bed carrying information in *change*, plus a rationed vocabulary of ≤6 earcons. Thin-client architecture, synthesis via a real-time `scsynth` over OSC, reusing your SuperCollider competence from the AV project. One detail I'd defend hardest: silence is a claim, so the bed carries a heartbeat whose absence means the rendering died, not the herd went quiet.
</routes>

<routes ref="em:91b88f em:32fd52">
**BEAM/Jido 2.** Two findings with opposite polarities. As *substrate*: the broker is the first workload in this brain's orbit that fits OTP — "blocking degrades to defer, never a stranded agent" *is* let-it-crash as product behavior. Jido fits as chassis (its `cmd → directives` reducer is the `broker.ingest/1` fixture seam), with `jido_ai` excluded. As *subject*: a Jido agent's actions are already typed data on a signal bus — **born supervisable** — so gating becomes interposition, not interception, and the unit-boundary gap closes structurally. Third independent derivation of the owned choke point (write-gatekeeper, librarian, broker): one architecture, a posture dial.
</routes>

## User

2, 3, 1, merge

## Assistant

Executing in order: promoted the two cross-cutting findings to knowledge (normative-records-vs-descriptive-traces and typed-actions-are-born-supervisable, with the project analyses now citing them as the general case), folded the analysis residue into the plan (tier 3 binds the append-only typed decision log and posture stamping; Deferred gains the sonification client and signal-bus-native ingest), and began the close. The operator then held the merge to insert a stack analysis before finalizing.

## User

Actually don't merge yet
Instead, do a follow up analysis - coudl the stack for this be
Lua (vim plugin)
Zig (the broker)
Elixir (the beam aspect)
Jido 2?

## Assistant

The four-language stack holds — but only under a role map that differs from its labels, and the difference is the finding. The forcing function is the hook execution model: Claude Code hooks run as a subprocess spawned per invocation, so the per-call handler is in the critical path of every gated action and starts cold every time. The BEAM boots in hundreds of milliseconds; booting it per hook call is disqualifying. So the architecture is *forced* into a resident daemon plus a thin per-call client, before any language is chosen.

<routes ref="em:fa721a">
That reframes the labels. **Zig's** genuine wins are the per-call **shim** (a static ~1–2 MB binary that starts instantly and holds a socket — exactly what a per-call handler needs) and **distribution** (a single dependency-free binary competing with herdr's and cmux's Rust). Neither of those is the *broker*. The broker is the stateful, concurrent, fault-isolated core — process isolation, blocking-with-timeout, "degrade to `defer`, never strand an agent" — which is correctness-for-free on the BEAM and correctness-by-hand in Zig. So the operator's labeling ("Zig the broker, Elixir the aspect") inverts each language's strength: it hands the stateful core to Zig and demotes Elixir to an aspect.
</routes>

The deeper reason to keep the core on the BEAM: a Zig core forecloses the Jido payoff. The born-supervisable story only stays clean — gating as in-process interposition on the dispatch path, not a socket hop — when the broker and the Jido agent share a BEAM. "Zig broker + Elixir/Jido subject" quietly forces a socket-hop compromise or two brokers.

Is four languages too many? Count the real seams: editor↔daemon (unavoidable), shim↔daemon (forced by boot latency — the shim can't be Elixir or Lua, so a third small non-BEAM language is genuinely forced), Elixir↔Jido (in-process, no seam). Three runtimes, two process boundaries, Jido a dependency not a runtime. Not bloat. Recommendation: adopt the stack, relabelled — Lua the client, Zig the swappable hook shim (Rust/Go/C equivalent), Elixir/OTP the broker core, Jido optional chassis and subject. This refines the plan's language note from "settled: Elixir/OTP" to a shim/core split. Basis: the hook subprocess model from the reference fetched this session; Zig async status and BEAM boot figures from training knowledge, flagged for re-check at first-code.

## User

After finishing everything else

## Assistant

Understood — merge last, after the stack analysis and the rest of the close are done. Filed the stack analysis, refined the plan's language note to the shim/core split, captured the session, and drove the PR to a true merge as the final step. Details in the closing report.

## Where this landed

A session that began as live research into Neovim's staying power in the agentic era and ended by incubating a buildable project. The research half established that Neovim holds up because the agentic workflow moved into the terminal, and mapped the tooling stack: the MCP IDE bridge (claudecode.nvim), the in-editor assistance tiers (copilot.lua / sidekick.nvim NES / avante / codecompanion), the agent multiplexers (herdr, cmux), and the review surface (hunk). The design half then discovered, through the operator's "driving the driver" framing, that the unoccupied position is *edit-granularity supervision* — an agent driving while the human navigates — and that the harness already supplies every primitive it needs (Claude Code's `PreToolUse` hook blocks synchronously for 600s, rewrites tool input, and injects context back into the model). That became the **agent-pairing** project: a broker-plus-thin-editor-clients supervision layer, incubating here before break-out.

The knowledge/project split was applied throughout: tool facts, the pairing posture, ambient observability, the console landscape, and the hook surface filed to `knowledge/SWE/agentic/{editor-integration,supervision,anthropic}` with `em:` ids; the system's own design (hub, architecture plan, opportunity/comparison/compliance/sonification/BEAM-Jido analyses) filed to `projects/agent-pairing/`. Two findings that transcended the project — normative-vs-descriptive records, and typed-actions-are-born-supervisable — were promoted to knowledge in the final pass. Nine glossary terms were added across the session. Everything landed via PR with the full gate suite green.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Neovim's staying power in the agentic era | closed | [neovim-agent-tooling-landscape](/knowledge/SWE/agentic/editor-integration/neovim-agent-tooling-landscape.md) | - |
| The scriptability clause, elaborated | closed | [neovim-scriptable-agent-integration](/meta/elaborations/neovim-scriptable-agent-integration.md) | - |
| RPC interrogation vs editing, editor as sensor | closed | [rpc-interrogation-as-sensor](/meta/elaborations/rpc-interrogation-as-sensor.md) | - |
| Agent-as-driver pairing posture | closed | [agent-as-driver-pairing-inversion](/knowledge/SWE/agentic/supervision/agent-as-driver-pairing-inversion.md) | - |
| Ambient observability, trace vs rendering | closed | [ambient-agent-observability](/knowledge/SWE/agentic/supervision/ambient-agent-observability.md) | - |
| The hook surface as supervision seam | closed | [hook-events-as-supervision-seam](/knowledge/SWE/agentic/anthropic/claude-code/hook-events-as-supervision-seam.md) | - |
| The supervision-console landscape | closed | [agent-supervision-consoles](/knowledge/SWE/agentic/supervision/agent-supervision-consoles.md) | - |
| The agent-pairing project and its architecture | open | [agent-pairing](/projects/agent-pairing.md) | build order: tier 1 first as premise test; PostToolBatch as unit boundary unresolved |
| Compliance/governance implications | closed | [compliance-and-governance-observability](/projects/agent-pairing/compliance-and-governance-observability.md) | - |
| Real-time sonification layer | paused | [realtime-sonification-layer](/projects/agent-pairing/realtime-sonification-layer.md) | prototype the ambient bed + two earcons before growing the vocabulary |
| BEAM/Jido 2 integration | closed | [beam-jido-integration](/projects/agent-pairing/beam-jido-integration.md) | Jido dependency decision deferred to first-code |
| Normative vs descriptive records (general) | closed | [normative-records-vs-descriptive-traces](/knowledge/SWE/agentic/supervision/normative-records-vs-descriptive-traces.md) | - |
| Typed actions are born supervisable (general) | closed | [typed-actions-are-born-supervisable](/knowledge/SWE/agentic/supervision/typed-actions-are-born-supervisable.md) | - |
| herdr/cmux comparison | closed | [comparison-herdr-cmux](/projects/agent-pairing/comparison-herdr-cmux.md) | - |
| The Lua/Zig/Elixir/Jido stack question | closed | [stack-lua-zig-elixir-jido](/projects/agent-pairing/stack-lua-zig-elixir-jido.md) | shim↔daemon protocol; who holds the 600s block; Zig async maturity at first-code |
