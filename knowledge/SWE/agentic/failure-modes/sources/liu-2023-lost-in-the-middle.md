---
id: em:42f3a0
type: source
title: "Liu et al. (2023), \"Lost in the Middle\" — abstract"
description: "arXiv abstract of the TACL study finding that language-model performance is highest when relevant information sits at the beginning or end of the input context and degrades significantly in the middle, even for explicitly long-context models."
resource: https://arxiv.org/abs/2307.03172
provenance: "Extracted verbatim from https://export.arxiv.org/abs/2307.03172 (arXiv mirror of the abstract page), fetched 2026-08-02"
tags: [source, long-context, position-bias, serial-position, llm-behavior, primary-source]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T03:41:25Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed research spike on bias mapping"
  why: "the position-bias claim needed its primary source captured before being marked verified"
---

# Liu et al. (2023), "Lost in the Middle" — abstract

Nelson F. Liu, Kevin Lin, John Hewitt, Ashwin Paranjape, Michele Bevilacqua,
Fabio Petroni, Percy Liang, "Lost in the Middle: How Language Models Use Long
Contexts." arXiv:2307.03172; the arXiv comments field notes "Accepted for
publication in Transactions of the Association for Computational Linguistics
(TACL), 2023".

Abstract, verbatim:

> While recent language models have the ability to take long contexts as
> input, relatively little is known about how well they use longer context.
> We analyze the performance of language models on two tasks that require
> identifying relevant information in their input contexts: multi-document
> question answering and key-value retrieval. We find that performance can
> degrade significantly when changing the position of relevant information,
> indicating that current language models do not robustly make use of
> information in long input contexts. In particular, we observe that
> performance is often highest when relevant information occurs at the
> beginning or end of the input context, and significantly degrades when
> models must access relevant information in the middle of long contexts,
> even for explicitly long-context models. Our analysis provides a better
> understanding of how language models use their input context and provides
> new evaluation protocols for future long-context language models.
