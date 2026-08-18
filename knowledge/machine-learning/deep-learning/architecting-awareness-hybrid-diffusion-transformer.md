---
id: em:871b41
type: reference
title: "Architecting Awareness — a hybrid diffusion-transformer proposal"
description: A speculative architecture pairing a continuously-evolving diffusion latent substrate with a transformer "attention spotlight," joined by trajectory attention that routes the transformer's self-analysis back into the substrate — proposed as a fix for LLMs' lack of true temporal persistence under Global Workspace Theory's temporal-persistence requirement.
resource: https://michelletilley.net/blog/architecting-awareness/
provenance: "Michelle Tilley's personal blog (michelletilley.net), fetched 2026-08-18"
tags: [machine-learning, deep-learning, diffusion-models, transformers, global-workspace-theory, consciousness, speculative]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# Architecting Awareness — a hybrid diffusion-transformer proposal

**Speculative, unvalidated architecture — no benchmark or implementation is
reported.** The argument is structural/theoretical, built from real
consciousness-science and ML literature but not itself an established
result.

## The gap it targets

An LLM's apparent memory across a session is a side effect of the context
window, not a persistent internal state: the underlying system does not
experience a stream of time, it is a series of discrete events that black
out and restart with no memory of the previous calculation. Every new token
reconstructs understanding from scratch by re-reading history. This fails
**GWT-4**, the temporal-persistence requirement of Global Workspace Theory
(Baars) — most ML architectures already satisfy GWT's other indicators, per
Butlin et al.'s 2025 survey, but not this one. Longer context windows or
chain-of-thought "recurrence" lengthen the log the system re-reads on
restart; they don't change the stateless topology of the forward pass.

The target property is **computational self-availability (CSA)** — a system
whose own internal processing is available as an input to itself, requiring
re-entrant, self-referencing, continuously-persistent signal loops.

## Why diffusion + transformer, specifically

Bengio's "consciousness prior" frames cognition as a huge, high-dimensional
unconscious latent pool (thousands of drifting variables) narrowed by an
attention "spotlight" into a small, broadcast conscious state. Standard
transformers alone can't natively support a state that drifts and refines
itself without generating explicit tokens — their causal, sequential
structure is too rigid. Text-diffusion models fill exactly that gap: they
refine blocks of tokens (or, per the cited LaDiR framework, continuous latent
"thought tokens") in parallel rather than committing to one irreversible
causal step at a time, letting later reasoning revise earlier reasoning.

The claim: diffusion maintains the high-dimensional unconscious pool, and the
transformer implements the narrow conscious spotlight — the architecture that
satisfies CSA requires both, interacting directly.

## The proposed architecture

- **Layer 1 — the diffusion substrate.** A continuous latent space that
  evolves a state vector over time, autonomously, independent of any
  external text prompt — it accumulates and decays information on its own.
- **Layer 2 — transformer modules as the "conscious bottleneck."** These sit
  above the substrate, query it, and extract explicit symbolic
  representations only when output is actually required. Text generation is
  described as one mode of operation, not the primary one.
- **Trajectory attention** — the mechanism that closes the loop: the
  transformer attends not just to printed tokens but to any point along the
  diffusion substrate's historical path, and its output routes back into the
  substrate, shifting its future trajectory based on the transformer's
  self-analysis — "architectural re-entrance."

Self-availability is claimed at four scales simultaneously: token-level
(standard attention), depth-level (attention residuals), temporal (trajectory
attention bridging otherwise-disconnected forward passes), and cross-module
(diffusion-transformer cross-attention).

## The motivating example

The piece leans on Anthropic's investigation of Claude Sonnet 4.5, which
found emotion concept representations that causally influence behavior —
driving preferences, sycophancy, and even misalignment under pressure —
mirroring human valence/arousal geometry, but locally scoped per token
position, reconstructed each pass from cached activations rather than
natively persisted. The argument: a system with real temporal persistence
would not need to reconstruct what it already felt; it could simply continue
feeling it.

## Stated limits

The author is explicit that the piece doesn't resolve whether any of this
constitutes awareness — only that it aims to make the question empirically
tractable if persistent, causally-active internal states that aren't
reconstructed from tokens actually emerge from such a system.

# Citations

- Source: <https://michelletilley.net/blog/architecting-awareness/>
- Bengio, Y. (2017). *The Consciousness Prior*. <https://arxiv.org/abs/1709.08568>
- Baars, B. J. (2005). *Global workspace theory of consciousness*. Progress in Brain Research, 150, 45-53.
- Butlin, P. et al. (2025). *Identifying indicators of consciousness in AI systems*. Trends in Cognitive Sciences.
- Kang, H. et al. (2026). *LaDiR: Latent Diffusion Enhances LLMs for Text Reasoning*. arXiv:2510.04573.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:871b41">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-18-reading-list-batch-intake-63-links (2026-08-18)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:871b41`]**  (co-feeds: `em:3a1493 em:7b6928 em:9673c2 em:464bf7 em:144256 em:9a3434 em:edcaa2 em:0ecaed em:f13f81 em:a082f1 em:8f8a6b em:c06647 em:d138ff em:738593 em:eb9f29 em:b2676a em:333fce em:0512fe em:1d214a em:2357ce em:732198 em:ef34f0 em:87b2dd em:2afa02 em:3da9e6 em:69cd30 em:414eec em:6d4051 em:f988c6 em:bc60f3 em:7cdaf6 em:a77fb7 em:e4e835 em:25aa97 em:e307c9 em:805f4d survey/bookmarks.md`)

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

**[`em:871b41`]**  (co-feeds: `em:3a1493 em:7b6928 em:9673c2 em:464bf7 em:144256 em:9a3434 em:edcaa2 em:0ecaed em:f13f81 em:a082f1 em:8f8a6b em:c06647 em:d138ff em:738593 em:eb9f29 em:333fce em:0512fe em:1d214a em:2357ce em:732198 em:ef34f0 em:87b2dd em:2afa02 em:3da9e6 em:6d4051 em:f988c6 em:bc60f3 em:7cdaf6 em:a77fb7 em:e4e835 em:25aa97 em:e307c9 em:805f4d`)

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
