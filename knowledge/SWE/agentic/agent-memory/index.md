# agent-memory

How LLM agents persist and reuse experience across tasks and sessions — memory
architectures, experience distillation, and the structured-vs-raw-trajectory
question. (Distinct from
[context-engineering](/knowledge/SWE/agentic/context-engineering/index.md),
which covers curating what enters a single context window; agent memory covers
what survives *between* them.)

## Contents

- [Memory systems for coding agents — the 2026 landscape](/knowledge/SWE/agentic/agent-memory/memory-systems-landscape.md) — the formation-pipeline products (Mem0, Zep/Graphiti, Letta) versus the curated-files school the field converged toward in 2026, the LoCoMo benchmark wars, memory-injection security research, and an evidence-graded proven-vs-hype ledger. `em:dd64c2` _(reference)_
- [EXG: Self-Evolving Agents with Experience Graphs (2026)](/knowledge/SWE/agentic/agent-memory/experience-graphs-exg.md) — structuring accumulated successes/failures as a relational graph beats reflection- and unstructured-memory baselines on performance-efficiency. `em:221e3e` _(reference)_
- [SkillOpt-Sleep — nightly offline consolidation of coding-agent sessions into gated skill updates](/knowledge/SWE/agentic/agent-memory/skillopt-sleep.md) — harvests local Claude Code/Codex/Cursor transcripts, mines and replays recurring tasks, and consolidates behind a held-out gate into a skill update staged for human adoption; recalled experience scales the gain, and outbound prompts are not guaranteed secret-free. `em:a2a391` _(reference)_
- [SuperLocalMemory — a maximalist local-first memory engine for AI agents](/knowledge/SWE/agentic/agent-memory/superlocalmemory.md) — solo-authored AGPL engine: SQLite+sqlite-vec canonical store, five retrieval channels (dense, BM25, temporal, Hopfield associative, spreading activation), scoped profiles, three cloud-involvement modes, and self-reported LoCoMo scores under heavy mathematical branding with no independent evaluation found. `em:fe3522` _(reference)_
