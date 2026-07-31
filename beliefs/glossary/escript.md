---
id: em:d8ef12
type: concept
title: escript
description: An Erlang/Elixir executable packaged as a single file that the BEAM runs directly, trading a build step for startup fast enough to invoke from a shell loop or an editor, where a `mix` invocation's project-loading cost would not be tolerable.
provenance: "Agent-distilled glossary definition, 2026-07-31 session"
verified: false
sense: common
tags: [glossary, elixir, beam, cli, packaging, terminology]
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-31 todo-surface thread cited in Seen in"
---

# escript

Built with `mix escript.build`, which bundles the project's compiled `.beam`
modules and its dependencies into one executable file. It still requires the
[BEAM](/beliefs/glossary/beam.md) to be installed — the escript is not a static
binary — but it skips the project resolution and compile check that `mix`
performs on every invocation.

That difference is what makes it the standard escape hatch when an Elixir tool
must be called by something latency-sensitive: a shell prompt, a git hook, or
an editor plugin fetching a list. The tradeoffs are a build artifact that can
go stale against its source, and a packaging step that must run somewhere
before the tool is usable.

*Seen in:* [2026-07-31 todo-surface thread](/meta/threads/2026-07-31-todo-surface-cli-and-neovim-plan.md)
