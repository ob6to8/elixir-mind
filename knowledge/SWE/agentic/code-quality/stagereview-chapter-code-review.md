---
id: em:74eb72
type: reference
title: "Stage (stagereview) — chapter-organized local code review"
description: A local-first CLI/browser tool that groups a git diff into logical review chapters with a prologue and risk context before the reviewer opens a single line, so unfamiliar or AI-generated diffs get a guided read instead of a flat file list.
resource: https://www.npmjs.com/package/stagereview
provenance: "stagereview README (npm registry), fetched 2026-08-21"
tags: [code-review, cli, git, agentic-coding, claude-code, tooling]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# Stage (stagereview) — chapter-organized local code review

`stagereview` (installed via `npm install -g stagereview`, MIT-licensed,
published by ReviewStage) is a code-review CLI that "organizes local code
changes into logical chapters and points out what to review before you dive
into the code." Run locally as a skill (`/stage-chapters`) inside an
agent harness, it never uploads source: "Stage runs locally and opens its
review UI in your browser. It does not upload your source code."

## What it does

Given a diff — staged, unstaged, untracked, a branch comparison, or a GitHub
PR (via `--pr`, using an authenticated `gh`) — Stage groups related changes
into review chapters, each with a prologue and risk context, then opens a
browser UI with a file-by-file review surface: inline comments, full-file
previews, image diffs, syntax themes, continuous chapter review, and keyboard
navigation. `.stageinstructions` (repo-root) or a one-off `--instructions`
flag inject persistent or per-run review guidance — project conventions or
areas deserving extra attention — into the chapter-generation prompt.
`.stageignore` (gitignore-syntax) excludes files from analysis without hiding
them entirely — ignored files still surface in an "Other changes" chapter.

When reviewing a GitHub PR by number or URL, Stage loads the PR's review
timeline, comments, labels, viewed-file state, merge status, and stacked-PR
navigation, and any GitHub action taken through the UI (submitting comments,
marking files viewed, merging) stays subject to the reviewer's own GitHub
permissions.

## Why it exists

The tool answers the same problem
[reviewing AI-generated code](/knowledge/SWE/agentic/code-quality/reviewing-ai-generated-code-two-tool-workflow.md)
names directly: an AI-authored diff is often technically correct but
unfamiliar, and a reviewer facing a flat list of changed files has to build
the map of "what changed and why" themselves before they can evaluate
anything. Chapters pre-build that map — the review starts oriented instead of
starting blind.

# Citations

- stagereview README, npm registry — <https://www.npmjs.com/package/stagereview>
- Repository — <https://github.com/ReviewStage/stage-cli>
