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
- [LLM — Simon Willison's multi-provider CLI and Python library](/knowledge/SWE/dev-tools/llm-cli-tool.md) — one interface across OpenAI, Claude, Gemini, Llama, and Ollama, logging every run to SQLite, with embeddings, structured extraction, and a plugin ecosystem
- [Litestream — streaming SQLite replication](/knowledge/SWE/dev-tools/litestream.md) — a standalone process that streams SQLite's write-ahead log to cheap object storage with no code changes, giving single-server apps disaster recovery without a multi-server database
- [Neovim command-discovery plugins — the genre map](/knowledge/SWE/dev-tools/neovim-command-discovery-plugins.md) — the four genres that answer "what's the command?" inside Neovim (cheatsheet search, config palettes, mapping introspection, prefix discovery), a maintained exemplar of each, and the file-per-entry corpus model none of them uses
