---
id: em:63b4cd
type: concept
title: llms.txt
description: A plain-text index published at a documentation site's root that enumerates its pages for machine consumption, letting an agent read the site's structure instead of guessing at URLs or relying on search.
provenance: "Agent-distilled glossary definition, Claude Code session"
verified: false
sense: common
tags: [glossary, documentation, agents, research-methodology, web]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-27 CCA study-program thread; fetching it is the concrete index-first remedy the source-surface analysis recommends"
---

# llms.txt

The convention matters to research method rather than to content. A search query
scoped by `site:` encodes a guess about where material lives and fails silently
when the guess is wrong; an index converts the same task into enumeration, where
a gap is visible rather than invisible.

Both `code.claude.com/docs/llms.txt` and `modelcontextprotocol.io/llms.txt`
publish one, which is why the
[`/intake`](/.claude/skills/intake/SKILL.md) gather step now calls for fetching
it before searching either host.

*Seen in:* [Anthropic's primary-source surfaces](/meta/analysis/anthropic-primary-source-surfaces.md) · [source recall probe](/meta/evals/source-recall-probe.md)
