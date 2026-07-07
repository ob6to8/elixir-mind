---
id: sb:649457
type: reference
title: "When F1 fails: granularity-aware evaluation for dialogue topic segmentation (Michael Coen)"
description: Standard boundary-based F1/W-F1 metrics for dialogue topic segmentation conflate boundary placement quality with segmentation granularity; the paper separates boundary scoring from boundary selection and shows that sweeping boundary density changes W-F1 more than switching segmentation methods does.
resource: https://arxiv.org/pdf/2512.17083
provenance: "Distilled from Michael Coen, arXiv:2512.17083v3 [cs.CL], preprint (under review), fetched 2026-07-06"
tags: [dialogue-systems, topic-segmentation, evaluation-methodology, context-engineering, conversational-memory, arxiv]
timestamp: 2026-07-06
---

# When F1 fails: granularity-aware evaluation for dialogue topic segmentation (Michael Coen)

**Michael Coen** (independent researcher), "When F₁ Fails: Granularity-Aware
Evaluation for Dialogue Topic Segmentation", arXiv:2512.17083v3 [cs.CL], preprint
under review, 31 Dec 2025. *(Summarized — a dense empirical paper with many
tables; full text at the resource link.)*

## Motivation: topic segmentation as a memory-control mechanism

LLM chat systems operate under finite context windows, so long conversations must
be dropped, summarized, or selectively retrieved — and **topic segmentation
decides which parts of history get kept**. The paper is motivated by building
*Episodic*, a topic-structured conversational memory system: in early
prototyping, small changes to the boundary-density parameter visibly changed the
context assembled for the LLM and the resulting responses, even when tolerant F1
barely moved. This is the same problem space as
[Conversation Tree Architecture](/SWE/agentic-coding/context-engineering/conversation-tree-architecture.md)
(structuring history to avoid pollution) and
[Anthropic's context engineering](/SWE/agentic-coding/agentic-loop/effective-context-engineering-for-agents.md)
(curating what stays in context) — this paper instead attacks how we'd know
whether a segmentation method is *any good* in the first place.

## The core problem with standard evaluation

Dialogue topic segmentation is usually scored with boundary-matching F1 (or a
window-tolerant "W-F1", counting a predicted boundary correct if within a small
tolerance of a gold one). The paper's central claim: **F1/W-F1 conflates two
different things** — (1) whether predicted boundaries are placed near true topic
transitions (localization), and (2) whether the *number* of predicted boundaries
matches what the annotation scheme implies (granularity/density alignment). A
model whose boundary *count* happens to match gold density can score well with
no semantic grounding at all — demonstrated with non-semantic baselines (random,
periodic-every-N) that achieve competitive W-F1 purely by matching gold boundary
counts.

A worked example (Figure 2) makes this concrete: gold annotation marks one coarse
topic boundary in a 12-turn dialogue; the model *correctly* also detects three
finer subtopic transitions within that span. Under exact-match F1, those three
correct detections count as false positives — precision 1/4, F1 = 0.40 — despite
the model correctly identifying the coarse transition. The failure is a
granularity mismatch, not a placement error, and standard F1 can't tell the two
apart.

## The fix: separate boundary scoring from boundary selection

The paper's structural move is to decouple two operations usually collapsed
together:

1. **Boundary scoring** — assign each candidate position a continuous relevance
   score.
2. **Boundary selection** — a separate, explicit rule (threshold `τ` + minimum
   spacing `g`) that converts scores into actual output boundaries, controlling
   density directly.

With that separation, density becomes a variable you can sweep and report,
instead of an implicit side effect of wherever a threshold happens to land.

## Reported diagnostics (alongside W-F1)

- **BOR (Boundary Over-segmentation Ratio)** — predicted boundary count ÷ gold
  boundary count. >1 = oversegmentation, <1 = undersegmentation, ≈1 = matched
  density.
- **Purity** — does each predicted segment draw from mostly one gold segment
  (low cross-gold mixing)?
- **Coverage** — is each gold segment captured mostly by one predicted segment
  (low fragmentation)?

These three, read together, distinguish five regimes (Table 3): calibrated
(aligned density, high scores both ways), oversegmentation (fine-grained but
gold-consistent), granularity mismatch (not necessarily noisy, just differently
grained), undersegmentation (coarser than gold), and genuine detection failure
(misplaced/noisy boundaries).

## Key empirical findings

- **Density dominates method comparisons.** Sweeping the boundary-selection
  threshold on a *single fixed* scoring model (producing "density–quality
  curves") changes W-F1 by more than switching between structurally different
  segmentation methods does. This directly undercuts leaderboard-style
  single-operating-point comparisons: an apparent "improvement" can be nothing
  more than a shift in output density.
- **Dataset-dependent sensitivity.** On SuperSeg, W-F1 peaks sharply near
  BOR ≈ 1 and degrades fast off that point (annotation density is strict). On
  DialSeg711, W-F1 is flat across a broad BOR range (density barely matters) —
  the same metric encodes different implicit granularity assumptions depending
  on the dataset.
- **Threshold tuning silently reshapes density regime.** Re-evaluating published
  methods (TextTiling, a BERT-NSP coherence scorer "CSM") under one shared
  pipeline: with a fixed threshold both are conservative (BOR ≈ 0.56–0.58) on two
  datasets, but per-dataset F1-tuning shifts CSM from conservative (BOR=0.64) to
  aggressive (BOR=3.97) — a sixfold density swing that's a tuning artifact, not a
  property of the method.
- **Audited leaderboard comparisons.** Runnable re-evaluations of three
  SuperDialseg leaderboard comparisons found the reported F1/W-F1 deltas
  coincide with large positive ΔBOR shifts — consistent with the density-driven
  confound the paper identifies, rather than genuine placement improvement.
- The proposed neural scorer (fine-tuned DistilBERT, trained via synthetic
  splice-pretraining → supervised fine-tuning on 2 datasets → temperature
  calibration) is evaluated across all 8 datasets and is consistently higher
  than baselines at matched density, and maintains high purity even when it
  oversegments relative to gold — indicating it tends to subdivide *within*
  gold segments rather than cutting across them.

## Datasets and reproducibility

Evaluated across 8 dialogue datasets spanning explicit segmentation annotation
(DialSeg711, SuperDialseg, TIAGE, QMSum) and repurposed labels treated as
boundaries (MultiWOZ domain changes, DailyDialog topic labels, Taskmaster
task/subtask changes, Topical-Chat topic labels). Reference implementation and
paper source at <https://github.com/mhcoen/episodic>.

# Citations

Michael Coen, "When F₁ Fails: Granularity-Aware Evaluation for Dialogue Topic
Segmentation", arXiv:2512.17083v3 [cs.CL], 2025-12-31 —
<https://arxiv.org/pdf/2512.17083>
