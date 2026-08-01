---
id: em:acddb7
type: concept
title: TERSE
description: A hierarchical state format (containers, bare-name objects, parenthesized attributes) with a matching query/mutation syntax, designed to store semantic state compactly and be edited by declarative patches rather than hand-written diffs.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, terse, state-format, dsl]
sense: common
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the terse-brain evaluation thread"
---

# TERSE

`#`/`##`/`###` containers carry hierarchy; bare-name lines beneath them are
objects; a trailing `(...)` carries attributes as bare flags, `key: value`
identifiers, or unkeyed raws; `@Path.To.Node` is a parser-known cross-reference.
Queries (`? Path [WHERE …]`) return results as re-parseable TERSE with ancestors
preserved; mutations are declarations — state and its intended deltas are
written together, and anything unmentioned survives unchanged ("silence
preserves"). `terse-py` implements the format with zero runtime dependencies;
`terse-mcp` exposes a TERSE store to an agent as two tools over named
namespaces. As of the 2026-08-01 evaluation the format's own specification
treats sibling order under a container as semantic state — placement
directives (`FIRST`/`LAST`/`BEFORE`/`AFTER`) exist because reordering is a
content change, not a formatting one — and neither the format's specification
nor its applications document a version-control or merge story.

*Seen in:* [2026-08-01 terse-brain evaluation and index-coverage gate thread](/meta/threads/2026-08-01-terse-brain-evaluation-and-index-coverage-gate.md)
