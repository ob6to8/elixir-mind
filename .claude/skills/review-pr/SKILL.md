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

### 2. Enumerate the operator's asks from the transcript — never from memory

**Read the session transcript**, the same way step 1 reads git. Both columns of
this audit must rest on evidence; an asks column built from recollection or from
a context-compaction summary is the agent's account of what it was told, which is
the failure this skill exists to catch. A compacted session is exactly when the
audit matters most and exactly when memory is thinnest — an ask made before the
compaction boundary can be missing from the summary entirely and will then be
missing from the audit, silently.

The transcript is at
`~/.claude/projects/<slugified-cwd>/<session-id>.jsonl`, one JSON object per
line. Extract the user turns:

```
python3 - <<'EOF'
import json, glob
for p in glob.glob("<transcript-path>"):
    for line in open(p):
        try: d = json.loads(line)
        except: continue
        if d.get("type") != "user": continue
        c = d.get("message", {}).get("content")
        if isinstance(c, list):
            c = "".join(x.get("text", "") for x in c if isinstance(x, dict))
        if isinstance(c, str) and c.strip():
            print("---", c[:400].replace("\n", " "))
EOF
```

Skip the envelopes that are not operator speech: skill-body injections (they
begin `Base directory for this skill:`), `<system-reminder>` blocks, hook
feedback, and context-continuation summaries. What remains — including
`<command-name>`/`<command-args>` blocks — is the ask list.

List each **request** in the order made. Include asks that were declined,
deferred, or superseded; the audit is incomplete without them. Slash-command
invocations count as asks (`/intake <url>` is "file this link"). Corrections and
mid-course redirections are their own rows, not silent edits to an earlier one.

If the transcript cannot be read, say so in the report and mark the asks column
**unverified** — do not quietly fall back to recollection.

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
- **Both columns rest on evidence, not recall.** Git is the oracle for what was
  delivered; the transcript is the oracle for what was asked. Where recollection
  disagrees with either, the artifact wins and the discrepancy is reported. An
  audit with one evidenced column and one remembered column fails in the
  remembered one.
- **Report an ask as `partial` or `not done` when it is** — an audit that
  grades its own work generously is worth nothing to the reviewer.
- Never touch `deprecated/`.
