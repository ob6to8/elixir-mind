---
id: sb:a757bb
type: concept
title: decontextualization
description: Rewriting an extracted statement to be self-contained — resolving pronouns and implicit scope — because atomic claims ripped from context change or lose meaning; SAFE's revision step, and a required stage of any artifact decomposer.
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, evals, claim-decomposition, nlp, epistemics]
timestamp: 2026-07-11
---

# decontextualization

Rewriting an extracted statement so it stands alone: resolving pronouns,
naming the implicit subject, and pinning the scope ("he won it twice" → "X won
prize Y twice"), because [atomic facts](/glossary/atomic-fact.md) ripped from
their surrounding text change or lose meaning and become uncheckable. SAFE
performs it as an explicit revise-to-self-contained step before verification;
any pipeline that decomposes artifacts into beliefs needs the same stage,
since belief identity and cross-document comparison presuppose
context-independent statements.

*Seen in:* [decompose-then-verify factuality reference](/SWE/evals/decompose-then-verify-factuality.md), [belief-decomposition analysis](/meta/analysis/belief-decomposition-derived-vs-authored.md)
