---
id: sb:7adc45
type: concept
title: parse-the-log
description: A session-capture implementation path that renders a transcript by mechanically parsing the host session log file rather than reproducing text from the agent's live context, for higher fidelity.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, capture, tooling]
timestamp: 2026-07-12
---

# parse-the-log

The host log file is typically a `.jsonl`. The fidelity gain is that parsing yields the exact delivered text, where the contrasting path — render-from-context — reproduces a memory reconstruction.

*Seen in:* [2026-07-08 session-capture thread](/meta/threads/2026-07-08-adopt-session-capture-routing-and-route-tags.md)
