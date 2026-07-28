---
id: em:28fac6
type: reference
title: "Open-weight frontier models, mid-2026 — the scale that outran self-hosting"
description: A landscape snapshot of the open-weight frontier as of July 2026, where Chinese labs hold the crown, Meta has left the field, and the leading models have grown past what any individual can run — making "open weights" and "locally runnable" two different properties.
provenance: "Distilled from coverage of the Kimi K3, Inkling, and GLM-5.2 releases and open-weight retrospectives, fetched 2026-07-27"
tags: [open-weights, moe, self-hosting, kimi, glm, inkling, llama, model-landscape]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, secure-financial-agent architecture session"
  why: "the model-tier decision for a locally-hosted system needed the current open-weight landscape, which is true independent of that system"
---

# Open-weight frontier models, mid-2026 — the scale that outran self-hosting

Three releases in six weeks reset the open-weight frontier, and together they
make a point that the phrase "open weights" obscures: **weights being downloadable
says nothing about whether you can run them.**

## The three current releases

| Model | Lab | Released | Architecture | License |
|---|---|---|---|---|
| **Kimi K3** | Moonshot AI | 2026-07-26 | 2.8T total, 16 of 896 experts active, Kimi Delta Attention + Attention Residuals, native vision, 1M context | unrestricted download |
| **Inkling** | Thinking Machines Lab | 2026-07-15 | 975B total / 41B active, 66-layer decoder-only, 6 of 256 experts + 2 shared, text/image/audio, 1M context | Apache 2.0 |
| **GLM-5.2** | Zhipu / Z.ai | 2026-06-13 | 753B MoE (~40B active), 1M context, 131K output | MIT |

Kimi K3 is the first open model in the 3-trillion-parameter class, reported by
Moonshot to land ahead of GPT-5.5 and Claude Opus 4.8 but behind Claude Fable 5.
Its Stable LatentMoE framework claims ~2.5× the scaling efficiency of K2.
Inkling is positioned differently — it debuted at 41 on the Artificial Analysis
Intelligence Index, and its pitch is not raw capability but suitability as a
**customization base**: multimodal, efficient thinking, and available for
fine-tuning on Thinking Machines' Tinker platform. GLM-5.2 is the coding
specialist, ranking second globally on Code Arena and trailing Claude Opus 4.8 by
about one point across three independent long-horizon coding evaluations.

## The active-parameter trap

MoE architectures report two parameter counts, and the smaller one is a **speed**
figure, not a memory figure. All experts must be resident in memory even though
only a few fire per token, so VRAM sizing uses **total** parameters. Inkling's
"41B active" does not make it a 41B-class deployment; it is a 975B-class one.

This is the single most common self-hosting sizing error, and it is what makes
the table above so much more forbidding than the active counts suggest:

- **Kimi K3** ships at ~1.4TB in MXFP4 — roughly **eighteen 80GB accelerators
  just to load**, before reserving anything for context or concurrency. An
  eight-card Blackwell node (1.5TB) barely fits the weights with nothing to
  spare. At 16-bit the same weights would need ~5.6TB.
- **Inkling** and **GLM-5.2** land near 500GB and 400GB respectively at 4-bit —
  better, still multi-node.

MXFP4 runs natively on NVIDIA Blackwell and AMD MI400 silicon, which is what
makes distribution at this scale coherent at all. But FP4 is **not yet a
production default**: calibration tooling is still maturing and accuracy varies
by model and task, so a 4-bit quant of a frontier model warrants end-to-end
evaluation before it is trusted.

## Meta has left the field

Meta ship-paused open-weight Llama and redirected frontier work to the closed
**Muse** line, the first Meta Superintelligence Labs release. Scout and Maverick
have continued unchanged since April 2025; Behemoth stalled in training and never
shipped. Llama 4 remains the most-searched Western open model, but building on
the line in 2026 means building on an abandoned one.

Four of the five leading open-weight families now come from Chinese labs —
DeepSeek, Moonshot, Zhipu, and Alibaba — and they have collectively closed the
coding and reasoning gap with the closed frontier.

## The consequence

Open weights at this scale are open to **whoever can afford the hardware to keep
them that way**. For an individual or a small team, the practical open-weight
frontier is not the models above; it is the 7B–120B tier that fits one machine,
where Qwen, Gemma, and the mid-size MoEs live. Choosing a model for a
self-hosted system is therefore a hardware-budget decision first and a capability
decision second — and for workloads that are extraction, classification, or
structured output rather than frontier reasoning, the smaller tier is not a
compromise.

# Citations

- <https://www.techi.com/kimi-k3-open-weights-inference-economics/> — Kimi K3 inference economics and the 1.4TB figure
- <https://huggingface.co/blog/ResterChed/kimi-k3-model-overview-mxfp4-quantization-open-wei> — Kimi K3 architecture and MXFP4
- <https://www.interconnects.ai/p/kimi-k3-the-open-weights-escalation> — Nathan Lambert on the open-weights escalation
- <https://thinkingmachines.ai/model-card/inkling/> — Inkling model card
- <https://artificialanalysis.ai/articles/thinking-machines-has-released-inkling-the-new-leading-u-s-open-weights-model> — Inkling independent evaluation
- <https://www.eigent.ai/blog/glm-5-2> — GLM-5.2 specifications
- <https://www.digitalapplied.com/blog/open-weight-models-h1-2026-retrospective-deepseek-qwen-llama> — H1 2026 open-weight retrospective and the Meta pivot
- <https://www.spheron.network/blog/best-open-source-llms-self-host-2026-vram-guide/> — VRAM sizing and the active-parameter error

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:28fac6">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-27-secure-financial-agent-and-projects-namespace (2026-07-27)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:28fac6`]**

I checked each. They're real, they're recent, and none of them is what you want.

| Model | Released | Size | Why not |
|---|---|---|---|
| **Kimi K3** | July 26, 2026 | 2.8T total, 16/896 experts active, 1M ctx | **1.4TB** in MXFP4 — [~18× 80GB accelerators just to load](https://www.techi.com/kimi-k3-open-weights-inference-economics/), before any context. An 8×Blackwell node (1.5TB) "barely fits the weights with almost nothing to spare." Not personally self-hostable. |
| **TML Inkling** | July 15, 2026 | 975B total / 41B active, Apache 2.0, multimodal | The active-param count is a *speed* number, not a *memory* number — you still resident all 975B. ~500GB at 4-bit. It's explicitly positioned as [a base for fine-tuning via Tinker](https://artificialanalysis.ai/articles/thinking-machines-has-released-inkling-the-new-leading-u-s-open-weights-model), debuting at 41 on the AA index — not a frontier reasoner. |
| **GLM-5.2** | June 13, 2026 | 753B / ~40B active, **MIT**, 1M ctx | The best of the three for this, and the license is the most permissive available. Still ~400GB at 4-bit. |

**Llama: don't.** Meta [ship-paused open-weight Llama](https://www.digitalapplied.com/blog/open-weight-models-h1-2026-retrospective-deepseek-qwen-llama) and pivoted frontier work to the closed Muse line. Behemoth never shipped. Building a 2026 system on Llama means building on an abandoned line.

---

**[`em:28fac6`]**

**Start with the latest, yes** — [Qwen3-VL](https://github.com/QwenLM/Qwen3-VL) (Apache 2.0; dense 2B/4B/8B/32B, MoE 30B-A3B/235B-A22B), or [Qwen3.5-VL](https://docs.nvidia.com/nemo/megatron-bridge/nightly/models/vlm/qwen35-vl.html) from the Feb 2026 family. Plan around **32B**; drop to 8B if it benchmarks equivalently on your documents, which it may well.
