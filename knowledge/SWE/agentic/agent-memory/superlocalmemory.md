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
was found in the sources gathered for this intake (README, project pages, and
the landscape sweep's community-reception search). The Fisher quote's own
hedge — cosine does the actual candidate generation; Fisher terms "can modify
later scoring" — is the pattern in miniature: standard mechanics, exotic
labels.

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
