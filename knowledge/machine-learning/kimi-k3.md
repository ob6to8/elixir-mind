---
id: em:68d1b3
type: reference
title: "Kimi K3 (Moonshot AI) — the 2.8T open-weight frontier model and what its release changes"
description: Moonshot's 2.8T-parameter native-multimodal agentic model, released 2026-07-26 under a revenue-tiered license, is the leading open-weight model and the first to arrive both frontier-class and expensive to run.
resource: https://huggingface.co/moonshotai/Kimi-K3
provenance: "Moonshot AI model card on Hugging Face, fetched 2026-07-28; benchmark standing from Artificial Analysis; license terms from the LICENSE file in the model repository"
tags: [kimi, moonshot, open-weights, moe, mxfp4, quantization, model-license, ai-economics, agentic-models]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked what the implications of Kimi K3 releasing its weights are, and to file the model card with the analysis attached"
---

# Kimi K3 (Moonshot AI) — the 2.8T open-weight frontier model and what its release changes

## In plain terms

Moonshot AI published the full weights of Kimi K3 on 2026-07-26 — a
2.8-trillion-parameter multimodal agentic model that scores third overall on the
Artificial Analysis Intelligence Index, behind only Fable 5 and GPT-5.6 Sol, and
comfortably ahead of every other [open-weight](/beliefs/glossary/open-weights.md)
model. Anyone may download it.

Two things complicate the obvious reading. The weights are 1.4TB even in 4-bit,
so "downloadable" and "runnable" have come apart entirely — the model needs a
multi-node GPU cluster, not a workstation. And the license is not MIT: it is
permissive up to revenue thresholds, above which a separate commercial agreement
with Moonshot is required. The release is best read as Moonshot taking the
top of the open leaderboard while keeping a claim on the businesses that resell
inference from it.

## What was released

| Property | Value |
|---|---|
| Total parameters | 2.8T |
| Activated per token | 104B |
| Layers | 93 (1 dense, 69 KDA, 24 Gated MLA) |
| Experts | 896 total, 16 selected per token, 2 shared |
| Attention | Kimi Delta Attention (KDA) + Gated MLA + Attention Residuals |
| Context | 1,048,576 tokens (1M) |
| Vocabulary | 160K |
| Vision encoder | MoonViT-V2 (401M) |
| Weight format | MXFP4 weights, MXFP8 activations, quantization-aware from the SFT stage |
| On-disk size | ~1.4TB (vs ~5.6TB at FP16) |
| Released | 2026-07-26 |
| License | Kimi K3 License (revenue-tiered) |

Three architectural pieces carry the efficiency claim. **Kimi Delta Attention**
replaces quadratic attention in most layers with a hybrid linear mechanism, which
is what makes a 1M context tractable. **Attention Residuals** are described in the
community write-up as "a drop-in replacement for standard residual connections",
letting a layer pull representations from arbitrary earlier layers. **Stable
LatentMoE** routes 16 of 896 experts in latent space with quantile load balancing
and soft dropping of overflow tokens; Moonshot reports roughly 2.5× the scaling
efficiency of Kimi K2.

The [quantization](/beliefs/glossary/quantization.md) choice is itself notable:
the model is trained quantization-aware "starting from the supervised fine-tuning
stage, not post-training quantization", so MXFP4 is the *native* format rather
than a lossy afterthought. MXFP4 runs natively on NVIDIA Blackwell and AMD MI400
silicon.

## Where it lands

On the Artificial Analysis Intelligence Index, Kimi K3 scores **57** — third
overall, "comparable to Opus 4.8 and GPT-5.5 but remains behind Fable 5 and
GPT-5.6 Sol", and well clear of the open field (GLM-5.2 at 51, DeepSeek V4 Pro at
44). On the AA-Briefcase agentic-knowledge benchmark it reaches **1543 Elo**,
second only to Fable 5's 1574 and above GPT-5.6 Sol (1501) and Claude Opus 4.8
(1347). Moonshot's own card reports GPQA Diamond 93.5%, Terminal-Bench 2.1 88.3%,
BrowseComp 91.2%, OSWorld-Verified 84.8%, and MCPMark-Verified 94.5%.

The cost of those numbers is the part the headline scores hide. On AA-Briefcase
K3 "averages a cost of $10.57 per task" and 56.4 minutes per task — about 2.5×
Fable 5's wall-clock — burning 120k output tokens across 83 turns where Fable 5
takes 67 and GPT-5.6 Sol 50.

Reliability tracks separately from capability. On AA-Omniscience, K3 hallucinates
on **51% of its non-correct responses**, up from K2.6's 39% even as accuracy rose
from 33% to 46% — the pattern expected when benchmarks "systematically reward
guessing over admitting uncertainty".

## The license

The Kimi K3 License reads as MIT for most of its length — use, copy, modify,
merge, publish, distribute, sublicense, sell, fine-tune, and build derivatives —
and then adds two thresholds:

- **Model-as-a-Service revenue gate.** A licensee (with affiliates) whose MaaS
  business exceeds **$20M USD in aggregate revenue over any consecutive 12
  months** must enter a separate agreement with Moonshot AI before any commercial
  use.
- **Branding requirement.** A product exceeding **100M monthly active users or
  $20M monthly revenue** must prominently display "Kimi K3" in its user
  interface.

**Exempt:** purely internal use never exposed to third parties, and access
through Moonshot's own products or its certified inference partners. Artificial
Analysis classifies the result as "Commercial Use Restricted" rather than open
source.

## Key terms

- **[Mixture of Experts](/beliefs/glossary/mixture-of-experts.md)** — only a
  subset of the network's parameters fires per token.
- **[Active parameters](/beliefs/glossary/active-parameters.md)** — the fired
  subset. A speed figure, not a memory figure; all 2.8T must be resident.
- **MXFP4 / MXFP8** — microscaling 4- and 8-bit floating point, per-block scale
  factors, hardware-native on Blackwell and MI400.
- **QAT (quantization-aware training)** — training the model to compensate for
  quantization error rather than compressing a finished model.
- **KDA (Kimi Delta Attention)** — hybrid linear attention replacing quadratic
  attention in most layers.
- **[Open weights](/beliefs/glossary/open-weights.md)** — downloadable
  parameters, which says nothing about license permissiveness or runnability.

## Implications of the weight release

*Agent-authored assessment, drawn from the sources cited below.*

**1. The open-to-closed gap is now measured in months, not model generations.**
The leading open model is third overall and beats two of the three Western
flagships on an agentic benchmark. Nathan Lambert puts a number on it: "The key
fact is that either the open-to-closed or American-to-Chinese model performance
gap has been reduced from the debated 6-9 months to something shorter, say 3-5
months." Every architecture decision that assumed a closed model was necessary
for frontier-grade agentic work now needs re-justifying on grounds other than
capability.

**2. Open no longer implies cheap — and that inverts the margin-collapse
thesis.** This is the most consequential and least-reported change. K3's API
prices at **$3.00 / $15.00 per MTok**, exactly Claude Sonnet 5's pricing and
roughly 3–4× its own predecessor K2.6 ($0.95 / $4.00). The
[margin-collapse argument](/knowledge/ai-industry/ai-margin-collapse-glm-5-2.md)
rested on open models matching frontier quality "at a fraction of the price" with
frictionless switching; K3 matches the quality and declines the discount. Chinese
labs are repositioning frontier models as premium goods rather than loss-leading
commoditizers. The pressure on closed-lab margins is now a *floor* effect — a
credible fallback exists — rather than the price collapse the thesis predicted.
The cheap tier still exists (DeepSeek V4 Pro at $0.04/task against K3's $0.94 on
the same index) but it is no longer where the open frontier lives.

**3. "Open weights" and "self-hostable" have fully separated.** At 1.4TB the
model needs roughly eighteen 80GB accelerators just to load, before any context
or concurrency; an eight-card Blackwell node at 1.5TB "barely fits the weights
with almost nothing to spare". The binding constraint is memory capacity and
bandwidth, not compute. So the immediate beneficiaries are inference providers,
clouds, and large enterprises — not individuals — and this release deepens rather
than reverses the pattern already recorded in
[open-weight frontier models, mid-2026](/knowledge/machine-learning/open-weight-frontier-models-mid-2026.md).
For anyone sizing a self-hosted system, K3 changes nothing: the runnable frontier
is still the 7B–120B tier.

**4. The license is a business model aimed at the intermediaries, not the
users.** The revenue gate and branding clause bite precisely on the
model-as-a-service resellers the release depends on for distribution, while the
internal-use exemption leaves ordinary enterprise deployment untouched. This is
Meta's old 700M-MAU clause generalized into a revenue tier, and it is a coherent
answer to the free-rider problem in open-weight releases: give the weights away,
monetize whoever builds a business on serving them. Expect imitation. The
practical consequence for most readers is that K3 is effectively permissive; the
practical consequence for the ecosystem is that "open-weight" now spans a
license spectrum wide enough that the term alone carries no legal information.

**5. Downloadable weights resolve the data-residency objection.** The standing
enterprise counterargument to Chinese frontier models — that inference runs in a
jurisdiction with unacceptable data-handling exposure — is answered by weights
you can run in your own. Combined with the internal-use exemption, this is a real
unlock for regulated sectors that could not touch the API. It converts a
compliance blocker into a hardware-budget problem.

**6. The architecture disclosure may outlast the weights.** KDA, Attention
Residuals, Stable LatentMoE, and MXFP4 QAT-from-SFT are now public and
studyable, and Lambert notes the ~2.5× scaling-efficiency gain was achieved with
"orders of magnitude less capital" than American labs deploy. Weights depreciate
within months; a demonstrated efficiency technique propagates into everyone
else's next training run. Shipping a frontier model natively in 4-bit also sets a
distribution norm — the question moves from "how much does this quant cost you?"
to "was it trained this way?"

**7. Read the index score and the reliability separately.** K3 climbed the
leaderboard while its hallucination rate rose 39% → 51%. A model that is third in
the world and confidently wrong half the time it is wrong is a specific
operational hazard, and it argues for domain-specific evaluation before
deployment rather than leaderboard-driven selection.

**The open question.** Whether an expensive open model exerts the same pressure a
cheap one does. If Moonshot's pricing holds and other Chinese labs follow it
upward, the open frontier stops being a price weapon and becomes an
optionality guarantee — valuable as insurance against lock-in and for jurisdictional
control, but far less corrosive to closed-lab economics than the 2025–early-2026
trajectory implied.

# Citations

- <https://huggingface.co/moonshotai/Kimi-K3> — the model card: architecture, benchmarks, deployment notes
- <https://huggingface.co/moonshotai/Kimi-K3/blob/main/LICENSE> — the Kimi K3 License text
- <https://huggingface.co/blog/ResterChed/kimi-k3-model-overview-mxfp4-quantization-open-wei> — MXFP4 QAT, KDA, AttnRes, Stable LatentMoE
- <https://www.interconnects.ai/p/kimi-k3-the-open-weights-escalation> — Nathan Lambert on the gap compression and capital efficiency
- <https://artificialanalysis.ai/models/kimi-k3> — Intelligence Index standing (57, third overall)
- <https://artificialanalysis.ai/articles/kimi-k3-agentic-knowledge-benchmark> — AA-Briefcase Elo, cost and time per task
- <https://the-decoder.com/kimis-open-model-k3-nears-gpt-5-6-sol-and-fable-5-while-signaling-the-end-of-super-cheap-chinese-ai/> — the pricing shift away from cheap Chinese inference
- <https://kili-technology.com/blog/kimi-k3s-benchmarks-and-hallucinations----what-that-tells-us-about-ai-evaluation> — AA-Omniscience hallucination rates and the benchmark-reliability gap
- <https://www.techi.com/kimi-k3-open-weights-inference-economics/> — the 1.4TB footprint and accelerator requirements
- <https://www.digitalapplied.com/blog/kimi-k3-open-weights-shipped-license-restrictions-2026> — license restrictions in context
