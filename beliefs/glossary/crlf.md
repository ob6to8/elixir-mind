---
id: sb:a48aeb
type: concept
title: CRLF
description: The two-byte carriage-return + line-feed line ending (Windows convention), versus Unix's bare LF; tools that pattern-match on line boundaries must normalize it or honor the file's own ending when writing.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, formats, encoding]
timestamp: 2026-07-12
---

# CRLF

Concretely the byte sequence `\r\n`, versus `\n`. In this bundle, the frontmatter parser normalizes CRLF away on read, and `mix brain.id` honors the file's own ending when inserting an id line — matching only `\n` while writing `\n` into a `\r\n` file silently mixes endings.

*Seen in:* [code-review toolchain hardening plan](/meta/plans/code-review-toolchain-hardening.md)
