---
id: em:f2a039
type: concept
title: unchecked premise
description: An assumption embedded in a recommendation or judgment that hasn't been verified—made visible and verifiable by being named inline or checked before delivery, per the assertions-name-their-basis policy.
sense: repo
provenance: "agent-distilled from governance policy"
verified: false
tags: [epistemics, verification, recommendations, communication]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by 2026-08-01-skill-model-selection thread"
---

# Unchecked premise

**The structural problem:** recommendations are produced *alongside* the options they rank, so they inherit the least verification of anything in a response while formatted as most decision-relevant. An unchecked premise is invisible when it lives in the recommendation cell—the operator reads the recommendation first and acts on it, while the questionable assumption stays shadowed.

**The fix:** either name the premise inline ("assuming your session runs Opus-tier…") or check it before writing the recommendation down. Checking is usually one tool call and always cheaper than the round-trip of the operator catching it later. This is the mechanism half of the broader [assertions-name-their-basis](/meta/policy/assertions-name-their-basis.md) rule, which holds that actionable assertions (facts, recommendations, any statement that could change what the operator does next) name their basis—checked or recalled—uniformly and structurally.

*Seen in:* [/meta/threads/2026-08-01-skill-model-selection](/meta/threads/2026-08-01-skill-model-selection.md), [assertions-name-their-basis](/meta/policy/assertions-name-their-basis.md)
