# Code context

Tools and techniques that build and serve structured **codebase context** —
knowledge graphs, indexes, call/dependency maps — to coding agents, so the agent
gets architectural understanding without exploring a repo file by file.

## References

- [GitNexus — client-side code knowledge graph for agent context](/knowledge/SWE/agentic/code-context/gitnexus.md) — parses a codebase into a Tree-sitter-based knowledge graph (calls, imports, clusters, execution flows) and serves it to agents over MCP. `em:b89ea1` _(reference)_
- [Codebase-Memory — tree-sitter code knowledge graph served over MCP](/knowledge/SWE/agentic/code-context/codebase-memory-mcp.md) — the same precompute-the-graph bet as GitNexus, benchmarked: ~10× fewer tokens and 2.1× fewer tool calls vs file-exploration (83% vs 92% answer quality) across 31 repos. `em:532b22` _(reference)_
- [doma — single-binary BM25 ranked search over code and docs for agents](/knowledge/SWE/agentic/code-context/doma.md) — dependency-free Odin binary that chunks markdown at headings and code at top-level definitions, returning ranked passages with breadcrumbs and snippets; deliberately lexical-only (no stemming, stopwords, or embeddings), with a disposable freshness-checked index. `em:9673c2` _(reference)_

## Subdirectories

- [sources](/knowledge/SWE/agentic/code-context/sources/index.md) — primary-source captures (release posts, announcements) backing the references in this directory
