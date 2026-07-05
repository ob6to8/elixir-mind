# Claude Code

Anthropic's Claude Code agent — CLI, cloud runtime, hooks, and configuration.

## Notes

- [Claude Code cloud (CCR) — environment and orchestration architecture](/SWE/agentic-coding/claude-code/cloud-environment-architecture.md) — sessions map to operator-defined environments backed by pre-baked cached container images; image state is frozen at bake time, containers are ephemeral, sibling sessions interleave. `sb:52aefa` _(note, unverified)_
