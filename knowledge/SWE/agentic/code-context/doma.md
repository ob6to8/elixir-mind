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
- **Sibling:** [doyo](https://github.com/L34Z/doyo) (DOcument YOinker), "which
  yoinks a project's docs into a local Markdown tree for doma to index".

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
