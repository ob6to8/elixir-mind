---
type: policy
title: Reserved filenames
description: index.md and log.md are reserved at any directory level and follow fixed structures.
section: composition
order: 3
status: active
tags: [meta, governance, okf, index, log]
timestamp: 2026-07-05
---
Reserved filenames (any directory level):

- **`index.md`** — directory listing for progressive disclosure. Markdown sections
  with bulleted links + one-line descriptions. **No frontmatter** — except the
  bundle-root `index.md`, which carries only `okf_version: "0.1"`.
- **`log.md`** — chronological change history, ISO 8601 date headings, newest first.
