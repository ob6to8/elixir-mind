---
id: em:eb9f29
type: reference
title: "herdr — agent-aware terminal multiplexer"
description: An open-source (Apache-2.0), single-binary Rust terminal multiplexer that runs inside whatever terminal emulator you already have and tracks AI coding agents as first-class runtime objects — blocked/working/done/idle per pane, detach/reattach over SSH, and a CLI/socket API agents can drive.
resource: https://herdr.dev/
provenance: "Distilled from herdr.dev, its /compare comparison matrix (https://herdr.dev/compare/#matrix), and the ogulcancelik/herdr GitHub repository, fetched 2026-07-29"
tags: [terminal, terminal-multiplexer, ai-agents, developer-tools, rust]
timestamp: 2026-08-18
attribution:
  when: 2026-07-29T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked to compare herdr against warp/cmux/tmux/ghostty/superlogical, citing herdr's own comparison matrix, and to file whichever of those tools weren't already captured"
---

# herdr

Herdr is a [terminal multiplexer](/beliefs/glossary/terminal-multiplexer.md) —
architecturally a peer of tmux and Zellij, not a
[terminal emulator](/beliefs/glossary/terminal-emulator.md) — built by
Ogulcancelik (open source, Apache-2.0, GitHub) and distributed as a single Rust
binary with "no Electron, no account, no telemetry." It runs *inside* an
existing terminal rather than replacing it, and ships tmux-style keybindings
(`ctrl+b q` to detach). Install via `curl -fsSL https://herdr.dev/install.sh |
sh`, `brew install herdr`, or `mise use -g herdr`; stable on Linux/macOS, beta
on Windows.

## What it adds over a plain multiplexer

Herdr's differentiator is treating agents as first-class runtime objects
rather than opaque processes in a pane:

- **Semantic agent state** per pane — `blocked` / `working` / `done` / `idle` —
  rather than a multiplexer's usual "process running or not."
- **Direct attach to a single agent's terminal**, not just a whole session.
- **Detach, reattach, and SSH access**, matching tmux/Zellij.
- **Agent-shaped API**: `read`, `send`, `wait`, `split`, `attach` — a CLI and
  socket API through which an agent (or another program) can drive Herdr
  itself, not just be hosted by it.
- **150+ community plugins** via a GitHub-based marketplace.
- **Remote attachment** from a phone or any SSH client, with a responsive
  mobile interface.

## Usage

Herdr is mouse-native but fully keyboard-driven as an option. Run `herdr` from
any project directory to launch or reattach to a background session — it
auto-creates a workspace if none exists. Workspaces are project-level
containers holding tabs, panes, and agents. Mouse controls: click to focus,
drag borders to resize, right-click for context menus, all with full keyboard
alternatives. Detaching (`prefix+q`, default prefix `Ctrl+B`) or simply
closing the terminal leaves the server and any running agents alive — "you do
not manage sockets; if you detach, agents keep running." Reattach by running
`herdr` again from the same directory; `herdr server stop` ends the session
for good. Common bindings: `prefix+v` split pane, `prefix+c` new tab,
`prefix+w` switch workspace.

## Positioning against the field

Herdr's own [comparison matrix](https://herdr.dev/compare/#matrix) frames the
market as five positions, reproduced here (Herdr's own framing, not this
bundle's judgment):

| Capability | Herdr | tmux/Zellij | cmux/Warp | Solo | Conductor/Emdash/Superset |
|---|---|---|---|---|---|
| Runs inside existing terminal | yes | yes | no, terminal app | no, desktop app | no, app workspace |
| Persistent PTY session runtime | yes | yes | session/app restore | managed processes | embedded terminals |
| Detach, reattach, SSH access | yes | yes | partial | no | remote projects |
| Direct attach to single agent terminal | yes | no | no | no | no |
| Semantic agent state | blocked/working/done/idle | no | attention or native-agent status | process status | workspace status |
| Agent-shaped API | read, send, wait, split, attach | terminal scripting | app APIs | MCP for processes | workflow APIs |
| Git worktree and diff review flow | pairs with it | no | partial | no | yes |

Herdr's own summary: it is "the intersection other tools miss" — persistent,
terminal-native runtime (tmux's territory) crossed with agent-lifecycle
awareness (which terminal apps like [cmux](/knowledge/SWE/dev-tools/cmux.md)
and Warp have, but only for agents running inside their own app, not
arbitrary remote sessions).

## Relationship to libghostty

Herdr does **not** use [libghostty](/beliefs/glossary/libghostty.md).
It is not a terminal emulator and does no rendering of its own — like tmux, it
runs *inside* whichever terminal emulator the operator already uses, so it has
no surface where an embeddable rendering/VT-parsing library like libghostty
would apply. This mirrors tmux's position: both are pure multiplexers sitting
above the emulator layer, architecturally orthogonal to the GUI-terminal wave
(Ghostty, [cmux](/knowledge/SWE/dev-tools/cmux.md),
[Superlogical](/knowledge/SWE/dev-tools/superlogical.md)) that libghostty is
consumed by.

# Citations

- herdr.dev — <https://herdr.dev/>
- herdr quick-start docs — <https://herdr.dev/docs/quick-start/>
- herdr comparison matrix — <https://herdr.dev/compare/#matrix>
- GitHub: ogulcancelik/herdr — <https://github.com/ogulcancelik/herdr>
- Compared against the Claude Code app, with a concrete build for
  approximating Claude Code's cloud architecture using herdr plus Fly.io/Shellbox,
  in [Herdr vs. the Claude Code app](/meta/analysis/herdr-vs-claude-code-app.md).

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:eb9f29">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-31-herdr-cmux-terminal-tool-comparison-intake (2026-07-31)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:eb9f29`]**  (co-feeds: `em:16581e`)

Pushed to `claude/terminal-multiplexer-compare-dmzt6h`. Here's the comparison and what got filed.

**In plain terms**

You asked how six terminal tools stack up and where `libghostty` fits. The short version: two different games are being played. **tmux** and **herdr** are multiplexers — they run *inside* whatever terminal you already have and just manage panes/sessions; herdr's twist is that it also tracks whether an AI agent in each pane is blocked, working, or done. **Warp**, **cmux**, **Ghostty**, and **Superlogical**'s upcoming multiplexer are all terminal *emulators* — they own the window and do the actual pixel rendering. `libghostty` is Ghostty's rendering engine, pulled out into a reusable library — and it's being picked up specifically by that second group (cmux and Superlogical build on it directly; Ghostty *is* its origin), while Warp built its own renderer from scratch before libghostty existed, and the pure multiplexers (tmux, herdr) don't render anything themselves so libghostty doesn't apply to them at all. Two of the six — **herdr** and **cmux** — weren't in the bundle yet, so I filed them; Warp, tmux, and Ghostty were already covered (glossary terms plus the existing Superlogical capture), and Superlogical itself was captured in this same session's earlier turn.

**The comparison**

**The two axes.** Herdr's own [comparison matrix](https://herdr.dev/compare/#matrix) draws exactly this line: "runs inside existing terminal" (Herdr, tmux/Zellij) vs. "no, terminal app" (cmux/Warp). That's the load-bearing distinction across all six:

| Tool | Kind | Renders its own pixels? | Uses `libghostty`? | Agent-aware? |
|---|---|---|---|---|
| [herdr](https://herdr.dev/) | multiplexer (Rust) | No — hosted by another terminal | No — nothing to render | Yes, per-pane state: blocked/working/done/idle |
| tmux | multiplexer (C) | No | No | No |
| [cmux](https://cmux.com/) | terminal emulator (Swift/AppKit, macOS) | Yes, via libghostty | **Yes** — rendering engine | Yes, sidebar + notifications |
| Warp | terminal emulator (Rust) | Yes, custom `WarpUI` on `wgpu` | No — predates libghostty, own renderer | Yes, native "Agentic Development Environment" |
| Ghostty | terminal emulator (Zig) | Yes | Is the source of libghostty | No (general-purpose) |
| [Superlogical](/knowledge/SWE/dev-tools/superlogical.md) | multiplexer (pre-launch) | Yes (its clients render) | **Yes**, explicitly built atop it | Framed around durable sessions across human/automated/agent work |

**libghostty's actual role.** It's a C-ABI library (currently just `libghostty-vt`: VT-sequence parsing + terminal state, extracted from Ghostty's proven core, zero dependencies) meant to let anyone embed correct terminal rendering instead of writing another ad-hoc ANSI parser. Its adopters so far are, unsurprisingly, exactly the tools that need a renderer and didn't want to build one: cmux wraps it in a native macOS shell; Superlogical's multiplexer clients build on it. tmux and herdr have no rendering surface to put it in — libghostty's own pitch does name multiplexers like tmux/zellij as *potential* future consumers (for VT parsing rather than rendering), but neither has adopted it. Warp is the interesting outlier: it needs exactly what libghostty offers but built `WarpUI` in-house years before libghostty existed, so it's a case of prior art rather than rejection.

**Where herdr and cmux actually differ from each other**, despite both being "agent-aware": herdr is infrastructure-first (SSH-reachable, remote, tmux-compatible keybindings, tracks *any* terminal-based agent anywhere) while cmux is experience-first (native macOS chrome, git/PR/port status in a sidebar, notification rings) — they're solving the same problem (agent visibility) from opposite ends of the stack (headless multiplexer vs. polished native app), which is exactly the pairing herdr/cmux occupy on opposite sides of its own matrix.

**What I did**

| Doc | Type | Why this type |
|---|---|---|
| `knowledge/SWE/dev-tools/herdr.md` (`em:eb9f29`) | `reference` | Captured/summarized external material (herdr.dev, its compare matrix, GitHub repo) |
| `knowledge/SWE/dev-tools/cmux.md` (`em:16581e`) | `reference` | Captured/summarized external material (cmux.com, GitHub repo) |

| File | Change |
|---|---|
| `knowledge/SWE/dev-tools/index.md` | Added herdr and cmux entries |
| `meta/registry.md` | Regenerated for the two new ids |
| `meta/evals/dedup-probe.md` | Harvested a gold row from your comparison phrasing; refreshed baseline (6/20, no regression) |

| Action | Result |
|---|---|
| Dedup search (herdr/cmux/warp/tmux/ghostty/libghostty) | No existing docs for herdr or cmux; warp/tmux/ghostty already represented via glossary + the Superlogical capture, so skipped per your instruction |
| Full pre-commit gate suite (`format`, `xref`, `verify`, `route_tags`, `glossary`, `lineage`, `test`) | All green — 188 tests passing |
| Committed and pushed | `40345be` on `claude/terminal-multiplexer-compare-dmzt6h` |

No new directory or type was needed (both filed autonomously under the already-established `dev-tools`), so nothing is awaiting ratification. No PR opened, since none was requested — let me know if you'd like one.

### 2026-08-18-reading-list-batch-intake-63-links (2026-08-18)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:eb9f29`]**  (co-feeds: `em:3a1493 em:7b6928 em:9673c2 em:464bf7 em:144256 em:9a3434 em:edcaa2 em:0ecaed em:f13f81 em:a082f1 em:8f8a6b em:c06647 em:d138ff em:738593 em:b2676a em:333fce em:871b41 em:0512fe em:1d214a em:2357ce em:732198 em:ef34f0 em:87b2dd em:2afa02 em:3da9e6 em:69cd30 em:414eec em:6d4051 em:f988c6 em:bc60f3 em:7cdaf6 em:a77fb7 em:e4e835 em:25aa97 em:e307c9 em:805f4d survey/bookmarks.md`)

All 8 research batches (covering all ~63 URLs) are launched in the background — dev-tools/terminal tooling, version control, Sean Goedecke's AI-expertise essays, MCP/security/evals, ML models, media-production/audio, Elixir/misc SWE, and the 9 bare HN links (which needed resolving before I could even group them). I'll wait for these to complete before drafting and filing the actual documents, since dedup and directory placement decisions depend on their findings.

The 8 research agents are running in the background. I'll wait for their results before drafting and filing the actual documents — I'll pick this back up as notifications arrive.

Batch 2 is filed. Now waiting for the remaining 7 background research batches to continue with the rest of the intake.

All 8 research batches are complete. I found some cross-batch duplication (the HN batch independently surfaced the same Qwen 3.8, Piffer, and Wolfram-boids links that batch 5 already covered) — I'll consolidate those into single documents rather than filing twice. Let me check the remaining target directories before writing this large next wave of files.

All ~63 links have been processed. Bundle verifies clean, 5 commits on the branch, nothing pushed/PR'd since that wasn't requested. Here's the summary.

**What happened**

I ran this as an `/intake` pass over a large batch of ~63 pasted links spanning developer tooling, AI/agentic security and evals, Elixir, media-production/audio, and AI-and-mathematics topics. Because the batch was so large, I split it into 8 parallel research passes (grouped by topic) to fetch and draft each document, then filed everything myself sequentially — checking for existing coverage first, since several links turned out to duplicate documents this brain already had (herdr, the LLM CLI tool, the MCP spec post, the MAGE book, several Sean Goedecke essays, the UML intro, and the Circles/Sines/Signals explainer were all already filed from earlier sessions). Two links independently resurfaced the same underlying release from two different angles (Qwen 3.8 27B, and the Wolfram boids post) — I merged those into one document each rather than filing twice. 32 new documents got filed across 6 new subdirectories, all created autonomously since each sits under an already-established top-level domain (`SWE`, `machine-learning`, `version-control`). Three links couldn't be resolved (two X/Twitter posts blocked by fetch, one Reddit thread blocked entirely) — details below. Everything is committed to this branch (`claude/research-intake-links-soavsl`); no PR has been opened since that wasn't requested.

**What I created (32 documents, 6 new subdirectories)**

| Doc | Type | Directory |
|---|---|---|
| Jujutsu (jj) | reference | `version-control/jujutsu/` (new) |
| doyo | reference | `SWE/agentic/code-context/` |
| 9 dev-tools docs (SSH-terminal writeup, cheatsheet.nvim, chezmoi, Rousseau's dotfiles, Catppuccin, Starship, Atuin, zsh guide, OpenTUI) | reference | `SWE/dev-tools/` |
| Three real-world AI cybersecurity incidents | reference | `SWE/security/` |
| smevals | reference | `SWE/evals/` |
| GenStage demand-driven backpressure | reference | `SWE/elixir/` (new) |
| ISO 704:2022 | reference | `knowledge-management/knowledge-representation/` |
| Actual Budget self-hosting | reference | `SWE/self-hosting/` (new) |
| Pets vs. cattle history | reference | `SWE/infrastructure/` (new) |
| Architecting Awareness (diffusion-transformer proposal) | reference | `machine-learning/deep-learning/` |
| feedpaper (RSS→e-ink) | reference | `SWE/dev-tools/` |
| Going Dark (AI bug-hunting & backdoors) | reference | `SWE/security/` |
| AI financial-advice prompt specificity | reference | `SWE/agentic/prompt-design/` |
| Indie-developer decade (Jeff Johnson) | reference | `startups/` |
| Programming as Theory Building (Naur, 1985) | **source** | `SWE/agentic/expertise/` |
| Numerology (generative MIDI) | reference | `media-production/sequencing/` |
| loopmaster/groovemaster, rust-audio ecosystem, serum2gen | reference | `media-production/audio-synthesis/` |
| Qwen 3.8 27B, DeepSeek V4 Flash (**source**), AI-and-mathematics ×2, boids swarm | reference/source | `machine-learning/` (+2 new subdirs) |

**What I modified**

| File | Change |
|---|---|
| `doma.md` | sibling link now points to the new doyo doc |
| `herdr.md` | added a Usage section from its quick-start docs |
| `normalization-of-deviance-in-ai.md` | cross-linked the new cybersecurity-incidents doc |
| `programming-with-ai-agents-as-theory-building.md`, glossary `theory-building.md` | Naur citation now a bundle link instead of a bare URL |
| `survey/bookmarks.md` | Naur row flipped to `promoted`; Underpass added (see below) |
| 13 `index.md` files | new/updated entries for everything above |

**Not filed**

- **Underpass** (Jeff Johnson's P2P file-transfer app) — thin product page, parked in `survey/bookmarks.md` and cross-linked from his indie-developer retrospective rather than fully filed.
- **@GithubProjects tweet** — fetch blocked (HTTP 402) on every route tried; the account itself turned out to be an unofficial fan account, not GitHub's.
- **@mitchellh tweet** — resolved (a multi-model Fable+GPT-5.5 cost workflow, explicitly framed by him as untested/provisional); too thin and ephemeral to warrant filing.
- **r/LLMDevs "if AI writes the code in 2 days..."** — Reddit unreachable through every fetch path tried (direct, proxy, JSON API).

**Your options from here**

| # | Option | What it entails |
|---|---|---|
| 1 | Open a PR now | `/create-pull-request` — captures this session as a thread doc, glossaries new terms, and opens the PR for the 5 commits already on this branch |
| 2 | Revisit the 3 unresolved links | Paste the tweet/thread content directly and I'll draft proper documents from it |
| 3 | Leave as-is | Commits stay on the branch for later review |

---

**[`em:eb9f29`]**  (co-feeds: `em:3a1493 em:7b6928 em:9673c2 em:464bf7 em:144256 em:9a3434 em:edcaa2 em:0ecaed em:f13f81 em:a082f1 em:8f8a6b em:c06647 em:d138ff em:738593 em:333fce em:871b41 em:0512fe em:1d214a em:2357ce em:732198 em:ef34f0 em:87b2dd em:2afa02 em:3da9e6 em:6d4051 em:f988c6 em:bc60f3 em:7cdaf6 em:a77fb7 em:e4e835 em:25aa97 em:e307c9 em:805f4d`)

Good catch — the gap is real and accounted for, not a dropped batch. Here's the reconciliation:

| Category | Links | Notes |
|---|---|---|
| **Filed as new documents** | 42 | Several links merged into one doc each (see below) |
| **Already covered by earlier intake sessions** | 16 | Confirmed by dedup search — same `resource` URL or same essay already filed; a few got a cross-link update, no new doc |
| **Unresolved / not filed** | 4 | Reddit thread (blocked), @GithubProjects tweet (blocked, turned out unofficial anyway), @mitchellh tweet (thin/ephemeral, reviewed not filed), Underpass (thin product page, parked in bookmarks instead) |
| **Update-in-place, not a new doc** | 1 | herdr's quick-start page added a Usage section to the *existing* herdr.md |
| **Total** | **63** | |

The 42→32 gap is 9 cases where multiple links were the same underlying thing, filed once:

| Merged into | From links |
|---|---|
| Qwen 3.8 27B | direct Willison link + HN link to the same post + HN link to the HF model card (3 links) |
| GenStage backpressure | the blog post + the Reddit thread discussing it |
| Sebastien Rousseau's dotfiles | the repo + its companion design post |
| smevals | the blog post + the project's own README |
| Catppuccin | the nvim port + the tmux port (one theming project, two ports) |
| rust.audio ecosystem | rust.audio + awesome-audio-dsp (the former just points at the latter) |
| Atuin | atuin.sh + the atuinsh/atuin GitHub repo (same tool) |
| Boids swarm post | the direct Wolfram link + an HN link to the same post |
| Piffer's AI-and-math essay | the direct link + an HN link to the same essay |

So: 42 links → 32 docs (9 merges saving 10), 16 links were dedup no-ops, 4 were dead ends, 1 was an edit rather than a new file. 42 + 16 + 4 + 1 = 63.

Pushed. The branch `claude/research-intake-links-soavsl` is now up to date on the remote with all 5 commits — no PR opened yet, since that wasn't requested. Let me know if you'd like me to open one (`/create-pull-request`).
