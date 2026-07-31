---
id: em:5787b0
type: concept
title: batch invariance
description: "The property that an inference server's numerical output for a request does not depend on which other requests it happened to be batched with — the missing ingredient that makes temperature-0 LLM inference actually deterministic."
provenance: "Agent-distilled glossary definition"
verified: false
tags: [glossary, batch-invariance, determinism, inference, reproducibility, llm-engineering]
sense: common
timestamp: 2026-07-28T18:39:50Z
attribution:
  when: 2026-07-16T12:25:27Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary"
  why: "term surfaced by the 2026-07-16 Inkling/BEAM swarm-eval spike thread"
---

# batch invariance

Standard GPU kernels for RMSNorm, matmul, and attention change their reduction order with batch shape, so the "same" forward pass yields different floating-point results under different server load — Thinking Machines' September 2025 *Defeating Nondeterminism in LLM Inference* identified this and published `batch_invariant_ops`, kernel replacements under which 1,000 identical prompts return 1,000 identical completions. SGLang extended the idea past greedy decoding with a seeded sampler (Gumbel noise from a hashed seed), giving reproducible sampling too. The payoff is twofold: **replayable evals** (an emergent multi-agent failure can be re-run bitwise from recorded seeds and ablated one variable at a time) and **stable on-policy RL** (sampler and trainer computing identical numbers keeps the policy-gradient loop from silently going off-policy). The guarantee is a property of the inference deployment, not the model — a generic shared endpoint forfeits it.

The mechanism, the kernel-level remedies, and the experiments are captured in
[Defeating Nondeterminism in LLM Inference](/knowledge/SWE/llm-engineering/defeating-nondeterminism-in-llm-inference.md).

*Seen in:* [2026-07-16 Inkling/BEAM swarm-eval spike thread](/meta/threads/2026-07-16-inkling-beam-swarm-eval-spike.md), [inkling-beam-swarm-eval-substrate analysis](/meta/analysis/inkling-beam-swarm-eval-substrate.md), [Defeating Nondeterminism in LLM Inference](/knowledge/SWE/llm-engineering/defeating-nondeterminism-in-llm-inference.md)

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:5787b0">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-28-architecture-practice-and-nondeterminism-intakes (2026-07-28)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:5787b0`]**  (co-feeds: `em:ae82a8`)

This one turned out to be a gap-filling intake rather than a new subject. The brain already *knew about* this article — it's cited from three places, including a glossary entry that summarizes its result in a paragraph — but it had never actually been read into a document. Per the brain's own rule, a URL that gets cited isn't the same as a source that's been processed, so this closes that gap: the full article is now distilled into a filed reference, and the glossary term points at it instead of at the raw link.

The article's own argument is a correction, which is what makes it worth having in full. The common explanation for why an AI model gives different answers to the same question — GPUs do math in parallel, parallel math finishes in random order, so the numbers wobble — is wrong. The actual cause is that your answer depends on how many other people were querying the server at the same moment, because the arithmetic routines quietly switch strategies based on how much work they're handed. The one-paragraph glossary entry asserted the conclusion; it didn't carry the mechanism or the falsification.

---

**[`em:5787b0`]**  (co-feeds: `em:ae82a8`)

**What I modified**

| file | thrust of the change |
|---|---|
| `beliefs/glossary/batch-invariance.md` (`em:5787b0`) | now defers to the filed reference for mechanism and experiments, keeping its own definition; the bare URL in *Seen in:* replaced with the document link |
| `knowledge/SWE/llm-engineering/index.md` | listed the new doc; gloss widened to admit reproducibility and serving-stack numerics |
| `meta/registry.md` | regenerated after minting |
