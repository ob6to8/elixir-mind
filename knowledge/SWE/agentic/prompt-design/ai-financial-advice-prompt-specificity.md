---
id: em:2afa02
type: reference
title: "Prompt specificity and demographic bias in AI financial advice (MIT Sloan)"
description: MIT Sloan research finds LLM financial advice is sound on fundamentals but weak on adaptive guidance, and that advice quality — and an estimated $50K-$100K retirement-wealth gap — hinges heavily on how specifically and expertly the user phrases their question.
resource: https://mitsloan.mit.edu/ideas-made-to-matter/ai-financial-advice-surprisingly-good-especially-if-you-ask-right-questions
provenance: "MIT Sloan, mitsloan.mit.edu, fetched 2026-08-18; surfaced via Hacker News"
tags: [prompt-design, llm-limitations, financial-advice, prompt-specificity, ai-industry]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# Prompt specificity and demographic bias in AI financial advice

MIT Sloan researchers, led by assistant professor Taha Choukhmane, tested
whether LLM-generated personal-finance advice (GPT- and Gemini-family
models) is actually good. On textbook fundamentals it holds up: the models
reliably recommend saving during working years, drawing down savings in
retirement, diversifying via stock market participation, and reducing equity
exposure with age (roughly post-45) — standard lifecycle-finance guidance.
Where it breaks down is adaptive advice: the models don't respond well to
described financial shocks (e.g. a job loss) and don't proactively suggest
portfolio rebalancing in response to changing circumstances.

## Prompt quality as the actual bottleneck

The paper's central and most transferable finding is about prompt quality,
not the model's underlying financial knowledge. When researchers fed the
models detailed, "academic-style" prompts — full financial context, explicit
stated assumptions about economic conditions — advice quality rose
substantially compared to how an ordinary user would phrase the same
question.

> "Regular people are not writing their prompts the way a finance professor
> is." — Taha Choukhmane

## The equity concern

Recommendation quality varied systematically with user demographics and with
how "financially literate" a user's phrasing signaled (including apparent
gender), and the researchers estimate this variance alone could translate
into a **$50,000-$100,000 gap in projected retirement wealth** purely from
how differently two otherwise-identical users phrase their questions. This
reframes "ask better questions" from a tip into an equity concern — the
people least equipped to write an expert-style prompt are the ones most
likely to get worse advice, compounding existing financial-literacy gaps
rather than flattening them.

# Citations

- MIT Sloan, "AI financial advice is surprisingly good, especially if you ask right questions" — <https://mitsloan.mit.edu/ideas-made-to-matter/ai-financial-advice-surprisingly-good-especially-if-you-ask-right-questions>
