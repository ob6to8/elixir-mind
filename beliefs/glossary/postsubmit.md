---
id: em:c6868c
type: concept
title: postsubmit
description: A check that runs on the trunk after a change has landed — catching defects that only appear once changes are combined, which a per-change presubmit structurally cannot see.
provenance: "Agent-distilled glossary definition, from the Google-practice vocabulary weighed in the version-control audit"
verified: false
tags: [glossary, ci, gates, testing, workflow]
sense: common
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "one of the named practices the operator asked the version-control audit to assess"
---

# postsubmit

It exists because a [presubmit](/beliefs/glossary/presubmit.md) tests a change
against the trunk *as it was*, not as it will be: two changes can each pass in
isolation and still conflict **semantically** once both have landed. The postsubmit
is the only surface that sees the combination. It cannot prevent the breakage — it
detects it — so its job is fast notification. This repo gets one for free by running
CI `on: push` to `main` as well as on pull requests, which matters given how many
sessions land in parallel.

*Seen in:* [2026-07-26 version-control-audit thread](/meta/threads/2026-07-26-version-control-audit-and-response-format-policies.md)
