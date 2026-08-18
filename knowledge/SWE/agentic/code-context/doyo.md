---
id: em:7b6928
type: reference
title: "doyo — single-binary documentation yoinker for LLM context"
description: A dependency-light Odin binary that pulls a GitHub repo's or arbitrary site's documentation into a local Markdown tree — preferring llms.txt manifests, then docs folders, then scattered markdown, falling back to heuristic HTML-to-Markdown conversion — so a coding agent (and its sibling tool doma) has real docs on disk instead of memorized knowledge.
resource: https://github.com/L34Z/doyo
provenance: "Distilled from the doyo README (github.com/L34Z/doyo), fetched 2026-08-18"
tags: [documentation, docs-extraction, agent-tooling, code-context, single-binary, odin, llms-txt, html-to-markdown]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# doyo — single-binary documentation yoinker for LLM context

**doyo** (**DO**cument **YO**inker) is "a small and relatively fast single
binary tool to yoink project documentation for LLM use" — written in
[Odin](https://odin-lang.org/), the same language as its sibling
[doma](/knowledge/SWE/agentic/code-context/doma.md), which indexes and
BM25-searches whatever doyo fetches. Runtime dependencies are `curl`
(HTTPS/redirects/compression) and `tar` (archive extraction) — no bundled
HTML/XML libraries; the HTML tokenizer is hand-rolled.

## Two input modes

- **GitHub repo mode** (`doyo owner/repo`): downloads the whole repo as one
  tarball from `codeload.github.com` — no API token, no rate-limit fight —
  then filters it by priority: an `llms.txt`/`llms-full.txt` manifest first,
  then a `docs/`/`doc/`/`documentation/` folder, then a fallback sweep of
  every `*.md`/`*.rst` plus the README. Vendored (`node_modules/`, `vendor/`)
  and tooling directories (`.github/`, `_static/`) are excluded
  automatically.
- **URL mode** (`doyo https://...`): a three-rung fetch — machine-readable
  manifests (`llms.txt`) first, then the page's own markdown form (`.md`
  suffix, `?plain=1`, markdown-typed headers), then HTML-to-Markdown
  conversion as a last resort, stripping nav/header/footer/script/style
  boilerplate and crawling same-section links. Heuristic HTML extraction is
  flagged in the output rather than silently trusted; it fails loudly on
  JS-rendered or bot-blocked sites rather than returning junk.

## CLI

`doyo <owner/repo | github-url | arbitrary-url>`, with `--path` (override
docs-folder detection), `--out` (output dir, defaults to
`./<owner>-<repo>/` or `./<host>/`), `--force` (allow overwrite), `--jobs <n>`
(concurrency, default 8). Output mirrors the source doc tree as files plus a
generated, sorted `index.md`.

**Determinism:** identical input bytes produce a byte-identical output tree
across runs, matching the design stance doma also takes.

**License:** MIT. **Maturity:** single-author, released alongside doma; the
author states it was built for personal use with limited planned ongoing
maintenance, though contributions are welcomed.

# Citations

- doyo repository — <https://github.com/L34Z/doyo>
- Sibling tool: [doma — single-binary BM25 ranked search over code and docs for agents](/knowledge/SWE/agentic/code-context/doma.md)
