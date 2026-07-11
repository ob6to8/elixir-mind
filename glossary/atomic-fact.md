---
id: sb:fd5a1e
type: concept
title: atomic fact
description: The decomposition unit of factuality evaluation — a short statement carrying a single independently checkable piece of information, extracted from a longer generation so each can be verified against a knowledge source on its own.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, evals, factuality, claim-decomposition, epistemics]
timestamp: 2026-07-11
---

# atomic fact

The decomposition unit of factuality evaluation: a short statement carrying a
single, independently checkable piece of information, extracted (by an LM)
from a longer generation so that each can be verified against a knowledge
source on its own and the results aggregated mechanically. The granularity is
the whole method — real generations mix true and false, and only atomic
statements localize the error. The general belief-decomposition analogue is
the atomic belief node; extraction requires
[decontextualization](/glossary/decontextualization.md) to keep meaning intact.

*Seen in:* [decompose-then-verify factuality reference](/SWE/evals/decompose-then-verify-factuality.md), [belief-decomposition analysis](/meta/analysis/belief-decomposition-derived-vs-authored.md)
