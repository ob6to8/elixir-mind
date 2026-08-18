---
id: em:a77fb7
type: reference
title: "Qwen 3.8 27B — capable vision/code local model, undermined by default overthinking"
description: Alibaba's Apache-2.0, 27B, vision-capable open-weight model shows strong bounding-box detection, code generation, and SVG generation on consumer hardware, but defaults to maximum reasoning effort, wasting minutes and tens of thousands of tokens on trivial prompts.
resource: https://huggingface.co/Qwen/Qwen3.8-27B-FP8
provenance: "Hugging Face model card; Simon Willison's hands-on review (simonwillison.net, 2026-08-16); surfaced via Hacker News and simonwillison.net"
tags: [qwen, alibaba, open-weights, local-models, reasoning-effort, vision-language, simon-willison]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# Qwen 3.8 27B — capable vision/code local model, undermined by default overthinking

Alibaba's Qwen research lab released **Qwen 3.8 27B** on 2026-08-16: 27B
parameters, Apache 2.0 licensed, vision-capable, supporting a
262,144-token maximum context — small enough to run on a single consumer/
prosumer GPU or a high-end Mac, in contrast to the multi-hundred-billion
parameter MoE models (Kimi K3, Inkling, GLM-5.2) that define the current
open-weight frontier but require multi-node hardware to self-host. At 17GB
(Q4_K_M quantized) it fits comfortably on a consumer laptop.

## Strengths

Hands-on testing (Simon Willison, via LM Studio on a MacBook Pro and an
NVIDIA DGX Spark) found real strengths: precise bounding-box object
detection on photographs (0-1000 scale, correctly bounding pelicans in
test images), functional autonomous code generation and testing through his
"Pi" coding-agent framework against a real codebase, and unusually careful
SVG generation — a pelican-riding-a-bicycle test image with anatomically
considered leg and wing placement, superior to prior local models.

## The problem: the default reasoning effort

The headline practical flaw is that the model defaults to `xhigh` reasoning
effort and applies it indiscriminately. A prompt as trivial as "draw an SVG
of a circle" triggered several minutes of unnecessary deliberation — elaborate
unrequested reasoning about "geometric studies" with gradients and
animations. The pelican-bicycle SVG task took **21 minutes and 22,276
reasoning tokens** with default settings versus **137 seconds with reasoning
disabled**, at no meaningful quality loss for the simpler task. Willison's
recommendation: run the model on `low` or no reasoning initially, despite
reasoning improving code-generation accuracy in some cases.

## Performance

Local throughput ran 15-30 tokens/second in LM Studio (~72% faster with
multi-token prediction), versus roughly 184 tokens/second on hosted frontier
APIs — impressive for local hardware but not yet a drop-in cloud
replacement without manual reasoning-effort tuning.

## Discussion context

Threads discussing the release compared Qwen 3.8 27B against Google's Gemma
4 12B as the two standout "punches-above-its-weight" local models of the
moment — but several commenters argued the comparison may be unfair to
Gemma 4, since Google, Unsloth, and llama.cpp have shipped
configuration/template regressions that degrade Gemma 4's actual
out-of-the-box performance. Separately, Qwen's reasoning traces use a
distinctively terse, article-dropping phrasing style, which one commenter
speculated could interact poorly with speculative-decoding (multi-token
prediction) efficiency.

# Citations

- Qwen3.8-27B-FP8 model card (Hugging Face) — <https://huggingface.co/Qwen/Qwen3.8-27B-FP8>
- Simon Willison, "Qwen 3.8 27B is excellent, but it defaults to overthinking things" (2026-08-16) — <https://simonwillison.net/2026/Aug/16/qwen-38-27b/>

# See also

- [Open-weight frontier models, mid-2026](/knowledge/machine-learning/open-weight-frontier-models-mid-2026.md)
