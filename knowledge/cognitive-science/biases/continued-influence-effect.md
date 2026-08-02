---
id: em:3c861f
type: concept
title: "Continued influence effect"
description: "Information encoded as true and later retracted keeps influencing memory-based inference even when the retraction itself is recalled — corrections rarely restore the pre-misinformation state."
verified: false
provenance: "Claude Code session (model undisclosed — the environment withholds the identifier from committed artifacts), 2026-08-02 — distilled from the Johnson & Seifert and Lewandowsky et al. literature"
tags: [cognitive-science, cognitive-bias, misinformation, retraction, memory, belief-revision]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T03:41:25Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed research spike on bias mapping"
  why: "the closest human analog to agent premise-retraction persistence needed a filed definition to link against"
---

# Continued influence effect

The continued influence effect (CIE) is the memory finding that information
initially encoded as true and later explicitly retracted continues to shape
reasoning and inference — often while the person can accurately report the
retraction. The correction is stored; it just does not *win* when the
retracted material is the better fit for the inference being made.

## The classic demonstration — Johnson & Seifert (1994)

In the standard paradigm, participants read an unfolding incident report
(a warehouse fire) in which an early message attributes a likely cause
(carelessly stored volatile materials) and a later message retracts it (the
storage room was actually empty). Participants who saw the retraction still
invoked the volatile materials when answering causal questions ("what caused
the explosions?") at rates comparable to participants who never saw a
retraction — while simultaneously acknowledging, when asked directly, that
the information had been withdrawn. The retracted premise and its retraction
coexist in memory; causal inference keeps reaching for the premise because
it fills a role in the event model that the bare retraction leaves empty.

## The synthesis — Lewandowsky et al. (2012)

The *Psychological Science in the Public Interest* review consolidated two
decades of retraction studies. From its abstract: "We look at people's
memory for misinformation and answer the questions of why retractions of
misinformation are so ineffective in memory updating and why efforts to
retract misinformation can even backfire and, ironically, increase
misbelief" ([PubMed abstract](https://pubmed.ncbi.nlm.nih.gov/26173286/)).
The review's central account is the **mental-model gap**: a retraction
deletes a component of a causal model without supplying a replacement, and
an incomplete-but-coherent model loses to a complete-but-discredited one.
Corrections work substantially better when they supply a *causal
alternative* (an arson finding, in the fire paradigm) rather than a bare
negation, when the audience is pre-warned about possible misinformation,
and when the correction's source is credible. Later replication work found
the "backfire" amplification rarer than the 2012 review suggested (Ecker et
al. 2022 review the revised picture), but the core persistence result is
robust.

## The structural reading

What makes CIE reusable outside psychology is its structure: **a retraction
is an addition, not a deletion.** Human memory has no erase operation over
consolidated material; the retraction is a second trace that must out-compete
the first at inference time, and it systematically fails to when the first
trace is more integrated with the reasoning task at hand. Which trace
controls behavior is decided by fit and salience, not by recency or by the
logical relation "supersedes."

The agent-side analog — a superseded premise persisting in an append-only
context — is filed at
[premise-retraction persistence](/knowledge/SWE/agentic/failure-modes/premise-retraction-persistence.md);
the [einstellung effect](/knowledge/cognitive-science/biases/einstellung-effect.md)
is the neighboring human finding for *procedures* rather than premises.

# Citations

- Johnson, H. M., & Seifert, C. M. (1994). "Sources of the continued
  influence effect: When misinformation in memory affects later inferences."
  *Journal of Experimental Psychology: Learning, Memory, and Cognition*,
  20(6).
- Lewandowsky, S., Ecker, U. K. H., Seifert, C. M., Schwarz, N., & Cook, J.
  (2012). "Misinformation and Its Correction: Continued Influence and
  Successful Debiasing." *Psychological Science in the Public Interest*,
  13(3), 106–131. <https://pubmed.ncbi.nlm.nih.gov/26173286/>
- Ecker, U. K. H., et al. (2022). "The psychological drivers of
  misinformation belief and its resistance to correction." *Nature Reviews
  Psychology*, 1, 13–29.
