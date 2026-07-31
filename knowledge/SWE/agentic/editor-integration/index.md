# Editor integration

How coding agents connect to the editor a developer already uses — the
protocols, the plugin ecosystems, and the architectural properties that decide
how deeply an agent can reach into a live editing session.

## Contents

- [Neovim agent tooling landscape](/knowledge/SWE/agentic/editor-integration/neovim-agent-tooling-landscape.md) —
  the plugin and CLI-bridge ecosystem around Neovim: the MCP IDE bridge, the
  three tiers of in-editor assistance, and the terminal-side agent runners

## Related

- [supervision](/knowledge/SWE/agentic/supervision/index.md) — how a human
  stays in the loop over agent work, of which editor integration is one surface
- [Claude Code hook events as the agent-supervision seam](/knowledge/SWE/agentic/anthropic/claude-code/hook-events-as-supervision-seam.md) —
  the harness-side interface an editor integration binds to
