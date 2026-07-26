---
id: em:3a8b96
type: concept
title: presubmit
description: A check that runs before a change is allowed to land, gating the merge itself — the last barrier that can keep a defect out of the trunk entirely.
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

# presubmit

Its value is preventive: a presubmit failure means the trunk was never broken. The
cost is latency on every change, so presubmits are kept fast and the expensive
verification is pushed to a [postsubmit](/beliefs/glossary/postsubmit.md) or a
later release gate. In this repo the presubmit is the
[gate suite](/beliefs/glossary/gate-suite.md) running on each pull request; the
[pre-commit hook](/beliefs/glossary/pre-commit-hook.md) is a local mirror of it that
runs earlier still.

*Seen in:* [2026-07-26 version-control-audit thread](/meta/threads/2026-07-26-version-control-audit-and-response-format-policies.md)
