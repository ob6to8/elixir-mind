---
type: todo
title: "Triage what remains in deprecated/ and decide its fate"
description: deprecated/ still holds 33 markdown files across sources, assertions, intake, logs, and plans — read-only legacy content that was never dispositioned, leaving a raw-URL backlog and superseded plans sitting outside the taxonomy with no decision recorded.
status: open
provenance: "Claude Code session (2026-07-11) — raised during the deprecated-directory triage and machinery deletion; file count re-verified 2026-07-28"
tags: [meta, todo, deprecated, migration, cleanup]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, ledger-strand reconciliation sweep"
  why: "promoted from an untracked routing-ledger strand; a long-standing backlog with real content and no recorded disposition"
  from: [/meta/threads/2026-07-11-deprecated-directory-triage-and-machinery-deletion.md]
---

# Triage what remains in `deprecated/`

`deprecated/` is archived legacy content, explicitly outside the OKF bundle and
read-only. It still holds **33 markdown files** (verified 2026-07-28) across
`sources/`, `assertions/`, `intake/`, `logs/`, and `plans/`.

The original triage identified roughly 13 sources and 9 assertions worth
migrating, plus a raw-URL backlog and a set of superseded plans — and then
stopped. Nothing was migrated, deleted, or explicitly retired, so the directory
sits in the same limbo it was put in.

**Task.** Give every remaining file one of three dispositions:

- **migrate** — the content is still true and unrepresented; distil it into the
  taxonomy per [capture the knowledge, cite the source](/meta/policy/capture-knowledge-cite-the-source.md).
- **survey** — a bare link worth keeping but not ingesting; move it to
  [`survey/bookmarks.md`](/survey/bookmarks.md) per the survey-tier carve-out.
- **retire** — superseded or redundant; delete it, with the commit as the record.

**Done when.** `deprecated/` is either empty and removed, or holds only files with
a recorded reason to remain — none left undispositioned. Deletion of the directory
itself is a shape change and needs operator ratification.
