# Orchestration

Coordinating multiple agent sessions as one delivery system — partitioning
shared surfaces, leveling dependencies, and sequencing merges so parallel work
lands without colliding.

## Documents

- [Wave-based concurrent delivery of a serialized work queue](/knowledge/SWE/agentic/orchestration/wave-based-concurrent-delivery.md) — audit the queue against HEAD, partition units into disjoint write-surface lanes, cut dependency-leveled waves, and resolve the residual merge classes (queue serials, generated artifacts, listings) mechanically.
- [Agent swarms and the new model economics (Cursor)](/knowledge/SWE/agentic/orchestration/cursor-agent-swarm-model-economics.md) — a planner/worker swarm rebuilding SQLite in Rust from documentation alone, cutting cost 5-8x by reserving frontier models for decomposition and letting cheap models execute the resulting instructions.
- [Scaling long-running autonomous coding (Cursor)](/knowledge/SWE/agentic/orchestration/cursor-scaling-long-running-agents.md) — what let hundreds of concurrent agents genuinely advance month-long codebases: a planner/worker/judge hierarchy replacing lock-based coordination, arrived at by simplifying away an added integrator role.
- [Multi-agent GPU kernel optimization (Cursor)](/knowledge/SWE/agentic/orchestration/cursor-multi-agent-gpu-kernel-optimization.md) — a planner-distributed swarm optimized 235 CUDA kernels for Blackwell GPUs over three weeks, a 38% geometric-mean speedup with agents spanning inline-PTX assembly to a novel high-level DSL.
