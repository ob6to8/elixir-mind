# Context engineering

How to structure, curate, and manage the context an LLM conversation or agent
holds — distinct from the [agentic-loop](/knowledge/SWE/agentic/agentic-loop/index.md)'s
tool-calling mechanics.

## Concepts

- [Routing non-linear work sessions — per-topic pages plus a dispatch ledger](/knowledge/SWE/agentic/context-engineering/routing-non-linear-work-sessions.md) — synthesize each topic into a durable per-topic page and track dispatch in a per-thread ledger of pointers/states; the durable-artifact analogue of conversation-tree branching. `em:d479e3` _(concept)_

## References

- [Graph serialization format as an unmeasured GraphRAG stage (ISONGraph, r/LLMDevs)](/knowledge/SWE/agentic/context-engineering/graph-serialization-format-in-the-prompt.md) — how a retrieved subgraph is rendered into the prompt goes uninstrumented; the promoted "40% to 80% multi-hop swing" turns out to rest on a 10-question subset under one model, while the repo's own limitations section says so. `em:c81829` _(reference)_
- [Conversation Tree Architecture — branching context to avoid logical context poisoning](/knowledge/SWE/agentic/context-engineering/conversation-tree-architecture.md) — structures conversations as trees with selective downstream/upstream context flow between branches. `em:784985` _(reference)_
- [When F1 fails: granularity-aware evaluation for dialogue topic segmentation (Michael Coen)](/knowledge/SWE/agentic/context-engineering/granularity-aware-evaluation-for-dialogue-topic-segmentation.md) — separates boundary scoring from boundary selection; shows sweeping boundary density changes W-F1 more than switching segmentation methods does. `em:649457` _(reference)_
- [Context rot — LLM performance degrades non-uniformly as input length grows (Chroma)](/knowledge/SWE/agentic/context-engineering/context-rot-chroma-research.md) — 18 frontier models show non-uniform degradation as context grows; bigger windows don't remove the need for curation. `em:77d68a` _(reference)_
- [Context editing and the memory tool — productizing compaction and note-taking (Anthropic)](/knowledge/SWE/agentic/context-engineering/claude-context-editing-and-memory-tool.md) — the Context Editing API and Memory Tool turn two context-engineering techniques into literal API primitives. `em:bf8a85` _(reference)_
- [AI agent memory management — when markdown files are all you need (dev.to)](/knowledge/SWE/agentic/context-engineering/ai-agent-memory-management-markdown-files.md) — Manus, OpenClaw, and Claude Code independently converged on plain markdown files for agent memory; search scales grep → BM25 → hybrid vector as the corpus grows. `em:41a1e3` _(reference)_
- [Context engineering for AI agents — lessons from building Manus (Yichao 'Peak' Ji)](/knowledge/SWE/agentic/context-engineering/context-engineering-lessons-from-manus.md) — six field-tested rules (KV-cache discipline, mask don't remove, file system as context, recitation, keep failures visible, avoid few-shot ruts), with terms defined inline for newcomers and a 2026 currency check on how each aged. `em:b4440a` _(reference)_
