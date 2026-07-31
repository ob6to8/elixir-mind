---
name: review-pr
description: Render an ask-vs-delivered audit of the current session as two tables — every request the operator made, and what the agent actually did with which files — so the operator can review the PR against what was asked. Use when the operator says "/review-pr", "what did you actually do", or wants an audit before reviewing a pull request.
---

# /review-pr — ask-vs-delivered audit

Render what the operator **asked for** this session against what the agent
**actually did**, as two tables, so the operator reviews the PR against the
asks rather than against the agent's account of them. Read-only: this skill
inspects and reports, it changes nothing.

The audit exists because a session's own narration is the agent's testimony,
not evidence — see
[normative records vs. descriptive traces](/knowledge/SWE/agentic/supervision/normative-records-vs-descriptive-traces.md).
The delivered column is therefore built from **git**, not from recollection.

## Procedure

### 1. Derive the delivered set from git — never from memory

Establish what actually changed on the branch, and let that drive the second
table:

```
git log --oneline origin/main..HEAD          # commits on this branch
git diff --stat origin/main...HEAD           # files touched, with churn
git status --short                           # uncommitted work, if any
```

Uncommitted changes are part of the delivered set and are marked as such — a
file edited but not committed has not landed and the operator must know.

### 2. Enumerate the operator's asks

Walk the session's operator messages in order and list each **request** — the
things the operator asked to have done. One row per ask, in the order they were
made. Include asks that were declined, deferred, or superseded; the audit is
incomplete without them.

Slash-command invocations count as asks (`/intake <url>` is "file this link").
Corrections and mid-course redirections are their own rows, not silent edits to
an earlier one.

### 3. Render the two tables

**What was asked**

| # | Ask (operator's own words, trimmed) | Status |
|---|---|---|

`Status` is one of **done** · **partial** · **not done** · **declined** ·
**superseded**. Nothing else — a status that needs a sentence goes in the prose
below the tables, not in the cell.

**What was delivered**

| # | What the agent did | Files touched | Committed |
|---|---|---|---|

- **#** cross-references the ask it serves, or `—` for work no ask requested
  (which is itself a finding worth the operator's attention).
- **Files touched** are repo-relative paths from the git diff, marked
  `new` / `modified` / `deleted`.
- **Committed** is the short SHA, or **uncommitted** for working-tree changes.

### 4. Report the gaps in prose

Below the tables, in a few sentences: any ask with no delivered row, any
delivered row with no ask, and anything still uncommitted. If there are none,
say so in one line.

Then hand back to the operator — this skill does not open, merge, or modify
a PR.

## Guardrails

- **Read-only.** No files are written, no commits made, no PR touched.
- **Git is the oracle for the delivered column.** Where recollection and the
  diff disagree, the diff wins and the discrepancy is reported.
- **Report an ask as `partial` or `not done` when it is** — an audit that
  grades its own work generously is worth nothing to the reviewer.
- Never touch `deprecated/`.
