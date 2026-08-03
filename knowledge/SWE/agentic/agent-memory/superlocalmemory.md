---
id: em:fe3522
type: reference
title: "SuperLocalMemory — a maximalist local-first memory engine for AI agents"
description: Solo-authored AGPL memory engine with a SQLite+sqlite-vec canonical store, five retrieval channels (dense, BM25, temporal, Hopfield associative, spreading activation), scoped multi-profile memory, three cloud-involvement modes, enterprise governance features, self-reported LoCoMo scores, and mathematical branding with no independent evaluation found.
resource: https://github.com/qualixar/superlocalmemory
provenance: "Distilled by Claude Fable 5 from the repository README (fetched 2026-08-01, V3.8.10)"
tags: [agent-memory, local-first, sqlite, sqlite-vec, hybrid-retrieval, mcp, locomo, claude-code, dual-license]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T21:20:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator pointed /intake at the repo as one of two seeds for a memory-system research spike"
---

# SuperLocalMemory

Tagline, verbatim: **"Enterprise-grade, local-first memory for AI agents and
teams."** A solo-authored engine (copyright Varun Pratap Bhardwaj / Qualixar,
AGPL-3.0 with paid commercial licensing) at V3.8.10 as of capture, shipping as
an npm CLI, a Python CLI/SDK, an MCP server (HTTP/stdio), a Claude Code plugin,
a dashboard, and nine agent-framework adapters (LangGraph, LangChain,
LlamaIndex, CrewAI, AutoGen, Semantic Kernel, Google ADK, OpenAI Agents,
Microsoft Agent Framework).

## Architecture

- **Canonical store:** SQLite + sqlite-vec, with optional CozoDB graph and
  LanceDB vector *projections* — derived views over one canonical store rather
  than parallel sources of truth.
- **Five retrieval channels**, verbatim: "dense semantic, BM25 lexical,
  temporal, Hopfield associative, and spreading activation" — hybrid retrieval
  taken to its maximal form.
- **Memory model:** atomic facts, episodic scenes, temporal events, and
  canonical entities; "Memory with a sense of time" — ingestion timing and
  provenance ride every fact, and temporal ranking is a first-class signal.
- **Scoped memory:** personal (default), shared (named readers), or global;
  cross-profile recall is default-deny.
- **Three operating modes:** A (zero-cloud), B (local Ollama enrichment),
  C (local storage, cloud LLM calls). Its own EU-AI-Act self-assessment flags
  Mode C non-compliant.
- **Enterprise layer:** per-workspace RBAC, GDPR export/erasure/retention,
  hash-chained audit trail, PII redaction, trusted-peer mesh sync.
- **Bounded loops:** tasks terminate only when an independent gate (test
  suite, linter, JSON schema, or a recall condition) passes — not on the
  agent's own completion claim. The one design element here that converges
  with this bundle's doctrine that
  [completion claims are not evidence of completion](/beliefs/completion-claims-are-not-evidence-of-completion.md).

## Self-reported benchmarks

README-published LoCoMo protocol results (vendor-run): "Mode A Raw" 60.4% on
"10 conversations; 1,276 scored questions; local embeddings, local retrieval,
and zero-LLM answer construction"; "Mode A Retrieval" 74.8% with GPT-4.1-mini
answer synthesis over the same questions; "Mode C" 87.7% on "Conv-30 only; 81
scored questions" — which the README itself scopes as "not a full-dataset
result". LoCoMo is the contested benchmark of the memory field (see the
[landscape](/knowledge/SWE/agentic/agent-memory/memory-systems-landscape.md)
on the Mem0/Zep dispute); vendor-run LoCoMo numbers are marketing surface
first, evidence second.

## The mathematical branding

Three "layers" are claimed to run without cloud LLMs, verbatim:
"Fisher-informed scoring" ("dense candidate generation uses cosine similarity;
Fisher-derived terms can modify later scoring when their state is available"),
"Sheaf Cohomology for Consistency" ("algebraic topology detects contradictions
via coboundary norms on the knowledge graph"), and a "Riemannian Langevin
Lifecycle" ("memory positions evolve on the Poincare ball; neglected memories
self-archive, no hardcoded thresholds"). Three self-authored arXiv preprints
(arXiv:2603.02240, arXiv:2603.14588, arXiv:2604.04514) back these; the README
calls them peer-reviewed, but arXiv posting is not peer review, and no
independent evaluation, replication, or third-party benchmark of the system
was found in the searched space (README, project site, the arXiv pages, and
the HN/Reddit reception queries recorded in the landscape sweep). The Fisher quote's own
hedge — cosine does the actual candidate generation; Fisher terms "can modify
later scoring" — is the pattern in miniature: standard mechanics, exotic
labels.

## Reception

201 stars and 34 forks on the 2026-08-01 GitHub page fetch; implementation
Python plus JS/TS surfaces. The GitHub description leads with the
superlative: "World's first local-only AI memory to break 74% retrieval and
60% zero-LLM on LoCoMo. No cloud, no APIs, no data leaves your machine.
Additionally, mode C (LLM/Cloud) - 87.7% LoCoMo. Research-backed. arXiv:
2603.14588". Its Show HN (February 2026) drew one point and no visible
comments ([HN](https://news.ycombinator.com/item?id=46926968)); the post
pitched it as "First open-source project. Built after getting tired of
Mem0's $50/month bills.", its author self-describing as an Accenture senior
manager with "basic coding skills". The landscape sweep's Reddit and
third-party-review queries found no substantive coverage — absence of
scrutiny, which cuts neither for nor against the claims.

## Reading

As a catalog of 2026 memory-engine ideas — hybrid multi-channel retrieval,
temporal ranking, scoped profiles, local-first modes, audit trails — it is
usefully exhaustive. As a system, the surface area (mesh, RBAC, compliance,
nine adapters, a dashboard) is very large for a solo project, and every
performance and rigor claim found is self-published. File under: architecture
menu worth mining, claims requiring independent verification.

# Citations

- README, github.com/qualixar/superlocalmemory (fetched 2026-08-01, verbatim
  spans re-confirmed against the raw file) — all quoted spans above.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:fe3522">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-01-memory-system-research-spike (2026-08-01)

3 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:fe3522`]**  (co-feeds: `em:a0fbd5 em:dd64c2 em:6733b4`)

https://github.com/mex-memory/mex
https://github.com/qualixar/superlocalmemory
then

* do a research spike into alternatives, the landscape, learnings, what is hype what is proven etc
* do an analysis of this repo with respects to this strategy - what could be gained, and what might be tradeoffs, if there are any
* consider porting these concepts to an elixir native solution (if one does not already exist)
* if that idea is advised, viable, and its a gap in the market, create a plan

---

**[`em:fe3522`]**  (co-feeds: `em:a0fbd5`)

**Done so far** — both repos are fetched and filed as `reference` docs (verbatim spans re-confirmed against the raw READMEs before quoting):

- `knowledge/SWE/agentic/code-context/mex.md` — mex turns out to be a Tree-sitter+SQLite code graph fused to a version-controlled markdown wiki with drift detection; filed beside GitNexus and Codebase-Memory, which share its genre. Its philosophy ("Markdown is the durable interface.") is this bundle's own bet applied to codebase knowledge.
- `knowledge/SWE/agentic/agent-memory/superlocalmemory.md` — a solo-authored, AGPL, maximalist local-first memory engine (five retrieval channels, self-reported LoCoMo scores, "sheaf cohomology" branding). Filed with vendor claims quoted verbatim and marked as vendor-run; its own README scopes the headline 87.7% to a single conversation.

---

**[`em:fe3522`]**  (co-feeds: `em:a0fbd5`)

- **The seeds.** [mex](https://github.com/ob6to8/elixir-mind/blob/claude/memory-system-research-jan4n8/knowledge/SWE/agentic/code-context/mex.md) is substance-leaning (curated markdown + deterministic code graph + drift detection, on-trend with the field's convergence) filed beside GitNexus in `code-context/`; its maker is unnamed on its own site and no HN thread was found in the sweep's queries. [SuperLocalMemory](https://github.com/ob6to8/elixir-mind/blob/claude/memory-system-research-jan4n8/knowledge/SWE/agentic/agent-memory/superlocalmemory.md) is the maximalist counter-example — five retrieval channels, "sheaf cohomology" branding, self-authored preprints, a 1-point Show HN — filed with every claim quoted verbatim and marked vendor-run.
