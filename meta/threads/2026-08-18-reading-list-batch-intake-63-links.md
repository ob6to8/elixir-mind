---
type: reference
title: 2026-08-18-reading-list-batch-intake-63-links
description: "Batch /intake of a 63-link operator reading list, split into 8 parallel research passes: 32 new references/sources filed across 6 new autonomous subdirectories (version-control/jujutsu, SWE/elixir, SWE/self-hosting, SWE/infrastructure, machine-learning/ai-and-mathematics, machine-learning/agent-based-modeling), 16 exact-duplicate skips, 9 same-topic merges, 4 unresolved links, and one update-in-place; PR #258 opened externally mid-session."
provenance: "Claude Code session (Claude Sonnet 5), 2026-08-18; verbatim retained messages — tool calls, tool results, background-agent task notifications (deferred tool results), reasoning, and short pre-tool narration stripped"
tags: [meta, thread, intake, dev-tools, agentic, security, elixir, media-production, machine-learning, ai-industry]
timestamp: 2026-08-18T21:41:00Z
session: https://claude.ai/code/session_012YsYJrhdxtdnHBWNeFmDFD
pr: 258
---

# 2026-08-18-reading-list-batch-intake-63-links

## Where this landed

A single-matter `/intake` session: the operator pasted a 63-link reading
list. Given the scale, the session split the batch into 8 parallel research
passes (Agent-tool subagents, grouped by topic: dev-tools/terminal tooling,
version-control, Sean Goedecke's AI-expertise essays plus the Naur paper,
MCP/security/evals, ML models, media-production/audio, Elixir/misc SWE, and
the 9 bare Hacker News links that needed resolving before they could even be
grouped), then filed everything itself sequentially — deliberately serial,
to avoid parallel writers clobbering shared files like `index.md` and the
registry. Dedup search found 16 links already covered by earlier intake
sessions (herdr, the LLM CLI tool, the MCP spec post, the MAGE book, several
Goedecke essays, the UML intro, and the Circles/Sines/Signals explainer
among them) — no new documents there, a few got a cross-link update. Two
links (Qwen 3.8 27B, the Wolfram boids post) were independently resurfaced
by two different research passes from different angles and merged into one
document each rather than filed twice; seven more same-topic pairs (GenStage,
Rousseau's dotfiles, smevals, Catppuccin, rust.audio, Atuin, and Piffer's
AI-and-math essay) were likewise one document each from two links. 32 new
documents were filed across 6 new subdirectories, each created autonomously
since it sits under an already-established top-level domain
(`SWE/elixir`, `SWE/self-hosting`, `SWE/infrastructure`,
`version-control/jujutsu`, `machine-learning/ai-and-mathematics`,
`machine-learning/agent-based-modeling`). Four links stayed unresolved: two
X/Twitter posts blocked on fetch (one turned out to be an unofficial fan
account regardless), and one Reddit thread blocked entirely; Underpass (a
thin product page) was parked in the survey/bookmarks tier instead of fully
filed, cross-linked from its author's separately-filed indie-developer
retrospective. Five commits landed the work; ids were minted and the
registry regenerated after each; the dedup-probe baseline was refreshed with
no regression. The operator then asked for the count reconciliation (63
links vs. 32 documents), which the session answered in full before being
told, via the stop hook, to push — done, with the branch left unopened as a
PR since that hadn't been asked for. The operator then invoked
`/create-pull-request`; before this capture began, a PR (**#258**) had
already been opened externally (from the Claude Code UI) for this branch, so
this closing flow references it rather than opening a new one.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Intake: version-control + code-context (Jujutsu, doyo, doma cross-link) | closed | [Jujutsu (jj)](/knowledge/SWE/version-control/jujutsu/jujutsu.md) (+1 sibling) | - |
| Intake: dev-tools/terminal tooling (9 docs) + herdr update-in-place | closed | [chezmoi](/knowledge/SWE/dev-tools/chezmoi.md) (+8 siblings, see the [dev-tools index](/knowledge/SWE/dev-tools/index.md)) | - |
| Intake: MCP/security/evals (cybersecurity incidents, smevals; MCP spec/stateless-MCP/normalization-of-deviance/MAGE already filed) | closed | [Three real-world incidents in AI cybersecurity evals](/knowledge/SWE/security/anthropic-cybersecurity-eval-incidents.md) (+1 sibling) | - |
| Intake: Elixir + HN-sourced + Naur cluster (GenStage, ISO 704, Actual Budget, pets-vs-cattle, Architecting Awareness, feedpaper, Going Dark, AI-financial-advice prompt specificity, indie-developer decade, Naur primary source) | closed | [GenStage's demand-driven backpressure](/knowledge/SWE/elixir/genstage-demand-driven-backpressure.md) (+9 siblings) | - |
| Intake: media-production/audio (Numerology, loopmaster/groovemaster, rust-audio ecosystem, serum2gen; circles-sines-signals already filed) | closed | [Numerology](/knowledge/media-production/sequencing/numerology-generative-midi-sequencer.md) (+3 siblings) | - |
| Intake: ML/AI-industry consolidated (Qwen 3.8 27B, DeepSeek V4 Flash, AI-and-mathematics ×2, boids swarm — Qwen and boids each merged from two independently-surfaced links) | closed | [Qwen 3.8 27B](/knowledge/machine-learning/qwen-3-8-27b.md) (+4 siblings) | - |
| Unresolved / not filed (Reddit r/LLMDevs thread, @GithubProjects tweet, @mitchellh tweet, Underpass parked in bookmarks) | closed | [survey/bookmarks.md](/survey/bookmarks.md) | - |
| Session close via `/create-pull-request` | open | unrouted | PR #258 was opened externally before this closing flow began; awaiting whether the operator wants it merged |

## User

*(invoked `/intake` with a 63-URL reading list)*

```
https://news.ycombinator.com/item?id=49299081
https://news.ycombinator.com/item?id=49307383
https://news.ycombinator.com/item?id=49304447
https://news.ycombinator.com/item?id=49299605
https://hackernoon.com/how-i-turned-my-website-into-an-ssh-terminal-app
https://github.com/sudormrfbin/cheatsheet.nvim
https://herdr.dev/docs/quick-start/
https://www.chezmoi.io/
https://github.com/sebastienrousseau/dotfiles
https://sebastienrousseau.com/2026-06-16-ai-aware-dotfiles-secure-reproducible-workstation-2026/
https://www.reddit.com/r/elixir/comments/1vhxagp/elixirs_genstage_demand_a_visual_explainer/
https://andrealeopardi.com/posts/genstage-demand-visualized/
https://github.com/L34Z/doyo
https://github.com/L34Z/doma
https://cloudscaling.com/blog/cloud-computing/the-history-of-pets-vs-cattle/
https://davisjam.github.io/model-based-agentic-software-engineering/book/mage-book.pdf
https://github.com/davisjam/model-based-agentic-software-engineering
https://primeradiant.com/blog/2026/smevals.html
https://github.com/prime-radiant-inc/smevals/blob/main/README.md
https://simonwillison.net/2026/Jul/30/three-real-world-incidents/
https://blog.modelcontextprotocol.io/posts/2026-07-28/
https://github.com/catppuccin/nvim
https://github.com/catppuccin/tmux
https://starship.rs/guide/
https://files.five12.com/Numerology4Manual.pdf
https://jackschaedler.github.io/circles-sines-signals/
https://groovemaster.xyz/
https://www.reddit.com/r/LLMDevs/comments/1vqtww9/if_ai_writes_the_code_in_2_days_and_you_spend_10/
https://simonwillison.net/2026/Aug/16/qwen-38-27b/
https://news.ycombinator.com/item?id=49324985
https://community.wolfram.com/groups/-/m/t/122095
https://news.ycombinator.com/item?id=49257362
https://news.ycombinator.com/item?id=49244872
https://davidepiffer.com/p/ai-isnt-outthinking-mathematicians
https://news.ycombinator.com/item?id=49312845
https://underpassapp.com/Underpass.html
https://www.iso.org/standard/79077.html
https://simonwillison.net/2026/Aug/4/new-release-of-llm/
https://embracethered.com/blog/posts/2025/the-normalization-of-deviance-in-ai/
https://simonwillison.net/2026/Jul/31/stateless-mcp/
https://zsh.sourceforge.io/Guide/zshguide.html
https://llm.datasette.io/en/stable/index.html
https://news.ycombinator.com/item?id=49139102
https://actualbudget.org/docs/install/
https://www.seangoedecke.com/llms-reward-expertise/
https://www.seangoedecke.com/impact-of-ai-study/
https://pages.cs.wisc.edu/~remzi/Naur.pdf
https://www.seangoedecke.com/ai-makes-weak-engineers-less-harmful/
https://www.seangoedecke.com/you-cant-design-software-you-dont-work-on/
https://rust.audio/
https://codeberg.org/BillyDM/awesome-audio-dsp
https://www.seangoedecke.com/how-does-ai-impact-skill-formation/
https://www.geeksforgeeks.org/system-design/unified-modeling-language-uml-introduction/
https://www.seangoedecke.com/programming-with-ai-agents-as-theory-building/
https://artificialanalysis.ai/models/deepseek-v4-flash
https://github.com/dougwithseismic/serum2gen?utm_source=chatgpt.com
https://atuin.sh/#get-started
https://github.com/jj-vcs/jj?tab=readme-ov-file#readme
https://github.com/atuinsh/atuin
https://x.com/GithubProjects/status/2064193103989510648
https://michelletilley.net/blog/architecting-awareness/
https://opentui.com/
https://x.com/mitchellh/status/2072715852944957531
```

## Assistant

<routes ref="em:3a1493 em:7b6928 em:9673c2 em:464bf7 em:144256 em:9a3434 em:edcaa2 em:0ecaed em:f13f81 em:a082f1 em:8f8a6b em:c06647 em:d138ff em:738593 em:eb9f29 em:b2676a em:333fce em:871b41 em:0512fe em:1d214a em:2357ce em:732198 em:ef34f0 em:87b2dd em:2afa02 em:3da9e6 em:69cd30 em:414eec em:6d4051 em:f988c6 em:bc60f3 em:7cdaf6 em:a77fb7 em:e4e835 em:25aa97 em:e307c9 em:805f4d survey/bookmarks.md">
All 8 research batches (covering all ~63 URLs) are launched in the background — dev-tools/terminal tooling, version control, Sean Goedecke's AI-expertise essays, MCP/security/evals, ML models, media-production/audio, Elixir/misc SWE, and the 9 bare HN links (which needed resolving before I could even group them). I'll wait for these to complete before drafting and filing the actual documents, since dedup and directory placement decisions depend on their findings.

The 8 research agents are running in the background. I'll wait for their results before drafting and filing the actual documents — I'll pick this back up as notifications arrive.

Batch 2 is filed. Now waiting for the remaining 7 background research batches to continue with the rest of the intake.

All 8 research batches are complete. I found some cross-batch duplication (the HN batch independently surfaced the same Qwen 3.8, Piffer, and Wolfram-boids links that batch 5 already covered) — I'll consolidate those into single documents rather than filing twice. Let me check the remaining target directories before writing this large next wave of files.

All ~63 links have been processed. Bundle verifies clean, 5 commits on the branch, nothing pushed/PR'd since that wasn't requested. Here's the summary.

## What happened

I ran this as an `/intake` pass over a large batch of ~63 pasted links spanning developer tooling, AI/agentic security and evals, Elixir, media-production/audio, and AI-and-mathematics topics. Because the batch was so large, I split it into 8 parallel research passes (grouped by topic) to fetch and draft each document, then filed everything myself sequentially — checking for existing coverage first, since several links turned out to duplicate documents this brain already had (herdr, the LLM CLI tool, the MCP spec post, the MAGE book, several Sean Goedecke essays, the UML intro, and the Circles/Sines/Signals explainer were all already filed from earlier sessions). Two links independently resurfaced the same underlying release from two different angles (Qwen 3.8 27B, and the Wolfram boids post) — I merged those into one document each rather than filing twice. 32 new documents got filed across 6 new subdirectories, all created autonomously since each sits under an already-established top-level domain (`SWE`, `machine-learning`, `version-control`). Three links couldn't be resolved (two X/Twitter posts blocked by fetch, one Reddit thread blocked entirely) — details below. Everything is committed to this branch (`claude/research-intake-links-soavsl`); no PR has been opened since that wasn't requested.

## What I created (32 documents, 6 new subdirectories)

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

## What I modified

| File | Change |
|---|---|
| `doma.md` | sibling link now points to the new doyo doc |
| `herdr.md` | added a Usage section from its quick-start docs |
| `normalization-of-deviance-in-ai.md` | cross-linked the new cybersecurity-incidents doc |
| `programming-with-ai-agents-as-theory-building.md`, glossary `theory-building.md` | Naur citation now a bundle link instead of a bare URL |
| `survey/bookmarks.md` | Naur row flipped to `promoted`; Underpass added (see below) |
| 13 `index.md` files | new/updated entries for everything above |

## Not filed

- **Underpass** (Jeff Johnson's P2P file-transfer app) — thin product page, parked in `survey/bookmarks.md` and cross-linked from his indie-developer retrospective rather than fully filed.
- **@GithubProjects tweet** — fetch blocked (HTTP 402) on every route tried; the account itself turned out to be an unofficial fan account, not GitHub's.
- **@mitchellh tweet** — resolved (a multi-model Fable+GPT-5.5 cost workflow, explicitly framed by him as untested/provisional); too thin and ephemeral to warrant filing.
- **r/LLMDevs "if AI writes the code in 2 days..."** — Reddit unreachable through every fetch path tried (direct, proxy, JSON API).

## Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | Open a PR now | `/create-pull-request` — captures this session as a thread doc, glossaries new terms, and opens the PR for the 5 commits already on this branch |
| 2 | Revisit the 3 unresolved links | Paste the tweet/thread content directly and I'll draft proper documents from it |
| 3 | Leave as-is | Commits stay on the branch for later review |
</routes>

## User

63 links, but only 32 new documents?

## Assistant

<routes ref="em:3a1493 em:7b6928 em:9673c2 em:464bf7 em:144256 em:9a3434 em:edcaa2 em:0ecaed em:f13f81 em:a082f1 em:8f8a6b em:c06647 em:d138ff em:738593 em:eb9f29 em:333fce em:871b41 em:0512fe em:1d214a em:2357ce em:732198 em:ef34f0 em:87b2dd em:2afa02 em:3da9e6 em:6d4051 em:f988c6 em:bc60f3 em:7cdaf6 em:a77fb7 em:e4e835 em:25aa97 em:e307c9 em:805f4d">
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
</routes>

## User

*(invoked `/create-pull-request`)*
