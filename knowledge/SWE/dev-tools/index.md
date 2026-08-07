# Dev tools

Developer-tools products and the companies that build them: terminals, editors,
and related workstation/session infrastructure, read as primary sources rather
than used.

## Contents

- [Superlogical](/knowledge/SWE/dev-tools/superlogical.md) — Mitchell Hashimoto's
  new company, building a persistent multiplexer for human/automated/agent work,
  launching with a terminal multiplexer built atop libghostty
- [herdr](/knowledge/SWE/dev-tools/herdr.md) — open-source Rust terminal
  multiplexer that runs inside your existing terminal and tracks AI coding
  agents as first-class runtime objects (blocked/working/done/idle)
- [cmux](/knowledge/SWE/dev-tools/cmux.md) — open-source, libghostty-based
  native macOS terminal with per-pane git/PR/port status for running AI coding
  agents in parallel
- [herdr and cmux — two shapes of the same agent multiplexer](/knowledge/SWE/dev-tools/herdr-and-cmux-two-shapes.md) —
  a practitioner's comparison resolving the choice to who does the scheduling,
  the human or another agent, with a falsifiable tripwire for switching
- [LLM — Simon Willison's multi-provider CLI and Python library](/knowledge/SWE/dev-tools/llm-cli-tool.md) — one interface across OpenAI, Claude, Gemini, Llama, and Ollama, logging every run to SQLite, with embeddings, structured extraction, and a plugin ecosystem
- [Litestream — streaming SQLite replication](/knowledge/SWE/dev-tools/litestream.md) — a standalone process that streams SQLite's write-ahead log to cheap object storage with no code changes, giving single-server apps disaster recovery without a multi-server database
