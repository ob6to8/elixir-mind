---
id: em:1aa70a
type: reference
title: "Frontier research: agents, reliability, world models, and human-AI augmentation (Kushal Chakrabarti)"
description: An independent AI researcher's essay arguing capability scaling alone leaves structural problems unaddressed, illustrated with his own findings on instruction-file bloat, model-scale-inverse reliability, and simulation-based world models.
resource: https://www.obviouslywrong.org/p/frontier-research
provenance: "obviouslywrong.org, Kushal Chakrabarti, fetched 2026-08-21"
tags: [evals, ai-safety, reliability, agentic-coding, essay]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# Frontier research: agents, reliability, world models, and human-AI augmentation

Kushal Chakrabarti surveys his own independent research across four
domains, arguing AI progress needs work on structural problems that stay
invisible if the only thing being tracked is capability scaling.

## Agents — catastrophic remembering

Instruction files (agentic-coding "READMEs") balloon because deleting an old
instruction risks a regression once its rationale is forgotten. His fix:
"adding comments encoding instructions' latent reasoning" cuts "99.3% excess
instructions and buy[s] back ~23% instruction-following" — the argument that
if English becomes a form of code for agents, it needs the same kind of
comments code does. This is the essay-length framing of the finding detailed
in full in
[Why Does CLAUDE.md Keep Growing? Catastrophic Remembering in Agentic
Coding](/knowledge/SWE/evals/catastrophic-remembering-claude-md-growth.md).

## Reliability — bigger isn't more trustworthy

Chakrabarti challenges the assumption that larger models are inherently more
reliable, arguing hallucination is closer to noise than to a knowledge gap.
He reports that as models scale, "capability improves by 2-7x, yet knowledge
degradation worsens by 3-39x" — reliability scaling *inversely* to capability
on his measure. Treating a model's attention heads as competitive agents
requiring internal coordination is reported to improve reliability by up to
18%.

## World models and human-AI augmentation

Practical work at Opendoor is cited as evidence that simulation-capable
models outperform standard prediction approaches at real-estate market
scale, and that treating regulatory/compliance overhead as a source of
training signal (rather than pure friction) benefits both the model and the
compliance function.

## Conclusion

The essay's throughline: AI advancement needs robust evaluation frameworks,
internal model coordination mechanisms, and human-AI collaboration design —
not capability scaling alone.

# Citations

- <https://www.obviouslywrong.org/p/frontier-research> — essay
