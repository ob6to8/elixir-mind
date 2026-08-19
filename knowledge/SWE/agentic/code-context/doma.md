---
id: em:9673c2
type: reference
title: "doma — single-binary BM25 ranked search over code and docs for agents"
description: A dependency-free Odin binary that chunks markdown at heading boundaries and code at top-level definitions, ranks with BM25, and returns top-k passages with breadcrumbs and snippets — built so a coding agent lands on the right section instead of grepping; deliberately lexical-only, with stemming, stopwords, and embeddings all out of scope.
resource: https://github.com/L34Z/doma
provenance: "Distilled from the doma README and its r/LLMDevs release post (author Zael, posting as u/HornyNarwahl), both fetched 2026-08-02; distillation by Claude Fable 5, Claude Code session"
tags: [search, bm25, lexical-search, ranked-retrieval, agent-tooling, code-context, single-binary, odin, indexing]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T09:30:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "linked together with its release post as part of a research spike on improving the repo's grep-primary search, to be considered amongst the other options"
---

# doma — single-binary BM25 ranked search over code and docs for agents

**doma** (DOcument MAtcher) is "a small and fast single binary that runs
[BM25](/beliefs/glossary/bm25.md) search over your code and docs". Its pitch is
retrieval shaped for agents: "a query returns ranked passages with a breadcrumb
trail and a snippet, so it lands you on the right section or function rather
than the right file." The author's motivation, from the
[release post](/knowledge/SWE/agentic/code-context/sources/doma-release-post.md):
"I made it because I wanted Claude to stop grepping wildly all over the place."
Written in [Odin](https://odin-lang.org/); "No models, no server, no network."
The only dependency is an optional `git`, used to honour `.gitignore` during
indexing.

## How it works

- **Chunking.** Markdown splits at ATX heading boundaries (`#`–`######`,
  fence-aware); every other file splits at top-level definitions — a line
  starting in column 0 with real content — which the README calls "a
  language-agnostic heuristic, not a parser". Each chunk carries a breadcrumb
  (`<corpus> > <path> > <heading or signature> > ...`).
- **Tokenization.** Lowercase, split on non-alphanumeric bytes, camelCase
  boundaries, and underscores, "with no stemming and no stopwords".
- **Corpuses.** A project defines named corpuses (path + extensions +
  exclusions) in a small committed `.doma/catalog.ini`; queries name one
  (`doma docs "auth flow"`), and `doma search` works catalog-free.
- **The index.** One binary index file per corpus, gitignored: "The index is a
  cache that a query checks against disk and never trusts blindly." Freshness
  is two-tier — a cheap per-file `stat`, then content hashes for flagged files
  only — so a query never re-reads the whole corpus and a stale index is
  reported, not silently trusted.
- **Ranking.** BM25 (`k1 = 1.2`, `b = 0.75`) through a bounded min-heap for
  top-k; the snippet is read live from the source file — "the highest-density
  ~200-byte window, the one covering the most distinct query terms". `--json`
  emits one object per line for tool use.
- **Determinism.** Same source bytes → byte-identical index regardless of
  thread count; golden tests assert exact index and result bytes.

## What it deliberately is not

The v1 scope excludes "stemming, stopwords, phrase and boolean queries, fuzzy
matching", parser-based chunking, incremental reindexing, "MCP or any server
mode", and "embeddings or models of any kind". doma is therefore **purely
lexical ranked retrieval**: the release post's "semantically relevant results"
is best read as *relevance-ranked*, not semantic — a query and a passage
sharing zero tokens score zero regardless of meaning, so it cannot bridge the
vocabulary-mismatch failure that dominates
[this bundle's measured recall misses](/meta/analysis/vector-db-recall-for-the-scaling-bundle.md).
What the ranking does buy over grep: partial multi-term matching, an ordered
top-k instead of an unranked exhaustive hit set, and code-aware token
splitting.

## Performance claims

From the README (self-reported, synthetic fixture plus one real corpus): "it
builds the index in about 50 ms and searches in about 11 µs per query" on a
generated 1000-file tree; "on a real 52.6 MB index over 13,299 Markdown files,
a warm search lands at about 4 ms, faster than `grep -r` over the same tree
(~46 ms) while ranking by relevance rather than just matching." On ripgrep, the
author's comment concedes throughput and claims a different concern: "If you
need the exact bytes of a specific file very fast rg will almost certainly win,
but as far as finding the correct file in the first try when you don't know
where the content lives doma will probably be much more fit to purpose."

## Agent integration

The intended deployment is harness-level, not protocol-level: drop the binary
in the project, run `doma init` and `doma index` once, and put instructions in
the project's `CLAUDE.md` — the README's suggested prompt is "Run ./doma docs
\"<question>\" to find the relevant docs, or ./doma code \"<symbol or idea>\"
to find where something lives, before you answer."

## Meta

- **License:** MIT (copyright 2026 Zael). The README opens: "This project was
  made for my personal use and enjoyment. AI was used."
- **Maturity:** released 2026-08-01; single author, who states "I made doma for
  myself and don't plan to put much ongoing work into it" — prebuilt binaries
  per platform, little-endian hosts only.
- **Sibling:** [doyo](/knowledge/SWE/agentic/code-context/doyo.md) (DOcument
  YOinker), "which yoinks a project's docs into a local Markdown tree for doma
  to index".

## Relation to other captures

The graph-shaped siblings in this directory —
[GitNexus](/knowledge/SWE/agentic/code-context/gitnexus.md) and
[Codebase-Memory](/knowledge/SWE/agentic/code-context/codebase-memory-mcp.md) —
precompute *structure* (typed graphs served over MCP); doma precomputes a
*retrieval index* and serves it as a CLI with no server, betting that ranked
[lexical search](/beliefs/glossary/lexical-search.md) at the right chunk
granularity is enough. Its constraints — no dependencies, offline,
deterministic, a disposable freshness-checked index — converge on the same
doctrines this bundle holds for its own tooling
([derived views stay disposable](/meta/doctrine/derived-views-stay-disposable.md),
[why the toolchain runs offline](/meta/tutorials/why-the-toolchain-runs-offline.md)),
which is what makes its design portable here even where the binary is not.
Whether this bundle should adopt it, copy it, or pass is weighed in
[Beyond grep: which retrieval layer this bundle should adopt](/meta/analysis/beyond-grep-ranked-retrieval-options.md).

# Citations

- doma repository — <https://github.com/L34Z/doma>
- Release post, captured verbatim —
  [doma release post — "All my homies hate grep"](/knowledge/SWE/agentic/code-context/sources/doma-release-post.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:9673c2">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-02-retrieval-spike-doma-intake-and-static-embeddings (2026-08-02)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:9673c2`]**

Full README captured — doma is deliberately lexical (no stemming, no stopwords, no embeddings; camelCase-aware tokenization), deterministic, with a gitignored derivable index. Its engineering doctrine mirrors this repo's own. Marking source-gathering nearly done; now the dedup sweep and a check for existing search-related plans/issues.

---

**[`em:9673c2`]**  (co-feeds: `em:f65f82`)

**On doma** ([reference](https://github.com/ob6to8/elixir-mind/blob/claude/repo-search-research-e0uvk9/knowledge/SWE/agentic/code-context/doma.md), [release post captured verbatim](https://github.com/ob6to8/elixir-mind/blob/claude/repo-search-research-e0uvk9/knowledge/SWE/agentic/code-context/sources/doma-release-post.md)): its design is excellent for this bundle — heading-level chunks, breadcrumb+snippet output for agents, a gitignored freshness-checked index that independently arrives at your derived-views-stay-disposable doctrine. But adopting the binary would put a per-platform executable from a day-old, bus-factor-one project (author: "I made doma for myself and don't plan to put much ongoing work into it") into a toolchain whose admission rule is "plain `mix` task with no dependencies" — and it would still only fix failures 2 and 3. The release post's "semantically relevant results" claim is relevance *ranking*, not semantics. Verdict: decline as dependency, adopt as design template.

### 2026-08-18-reading-list-batch-intake-63-links (2026-08-18)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:9673c2`]**  (co-feeds: `em:3a1493 em:7b6928 em:464bf7 em:144256 em:9a3434 em:edcaa2 em:0ecaed em:f13f81 em:a082f1 em:8f8a6b em:c06647 em:d138ff em:738593 em:eb9f29 em:b2676a em:333fce em:871b41 em:0512fe em:1d214a em:2357ce em:732198 em:ef34f0 em:87b2dd em:2afa02 em:3da9e6 em:69cd30 em:414eec em:6d4051 em:f988c6 em:bc60f3 em:7cdaf6 em:a77fb7 em:e4e835 em:25aa97 em:e307c9 em:805f4d survey/bookmarks.md`)

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

**[`em:9673c2`]**  (co-feeds: `em:3a1493 em:7b6928 em:464bf7 em:144256 em:9a3434 em:edcaa2 em:0ecaed em:f13f81 em:a082f1 em:8f8a6b em:c06647 em:d138ff em:738593 em:eb9f29 em:333fce em:871b41 em:0512fe em:1d214a em:2357ce em:732198 em:ef34f0 em:87b2dd em:2afa02 em:3da9e6 em:6d4051 em:f988c6 em:bc60f3 em:7cdaf6 em:a77fb7 em:e4e835 em:25aa97 em:e307c9 em:805f4d`)

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
