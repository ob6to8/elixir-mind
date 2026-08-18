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
- [SSH terminal app via ratatui + russh](/knowledge/SWE/dev-tools/ssh-terminal-app-ratatui-russh.md) — a build write-up sharing one render function between a local Rust TUI and an SSH-served session, using ratatui for the UI and russh for the SSH transport
- [cheatsheet.nvim](/knowledge/SWE/dev-tools/cheatsheet-nvim.md) — a Telescope-backed fuzzy-searchable in-editor cheatsheet for Neovim, bundled with sheets for core commands, popular plugins, nerd-fonts, regex, and Unicode
- [chezmoi](/knowledge/SWE/dev-tools/chezmoi.md) — single-binary dotfile manager with templating, password-manager integration, and file encryption for keeping config consistent across machines
- [Sebastien Rousseau's AI-aware dotfiles](/knowledge/SWE/dev-tools/sebastien-rousseau-ai-aware-dotfiles.md) — a chezmoi-based, multi-shell dotfiles repo treating the workstation as reproducible infrastructure, with MCP-bounded AI agent access and cryptographic attestation
- [Catppuccin](/knowledge/SWE/dev-tools/catppuccin.md) — community pastel theme project, ported across dozens of tools; covers the Neovim (origin) and tmux ports
- [Starship](/knowledge/SWE/dev-tools/starship.md) — fast, minimal, infinitely customizable cross-shell prompt written in Rust
- [Atuin](/knowledge/SWE/dev-tools/atuin.md) — shell history replacement storing rich per-command metadata in local SQLite, with optional end-to-end-encrypted sync and a fuzzy-search UI
- [A User's Guide to the Z-Shell](/knowledge/SWE/dev-tools/zsh-guide.md) — Peter Stephenson's long-form Zsh reference, the canonical guide on the zsh.sourceforge.io project site
- [OpenTUI](/knowledge/SWE/dev-tools/opentui.md) — Zig-implemented terminal UI library with TypeScript/React/Solid bindings, flexbox layout, and in-terminal multimedia
