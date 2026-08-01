---
id: em:b7deb1
type: reference
title: "Complete Beginner's Course on AI Evaluations (2025) — Aman Khan"
description: A live-build walkthrough (Peter Yang interviewing Arize's Aman Khan) of the four types of AI evals and the end-to-end process of evaluating an AI customer-support agent — from a hand-built spreadsheet golden dataset through an LLM-as-judge, to measuring judge/human match rate and iterating the underlying prompt.
resource: "https://www.youtube.com/watch?v=TL527yTpxlk"
provenance: "YouTube, Peter Yang's channel, interview with Aman Khan (Head of Product, Arize), 2025"
tags: [evals, llm-as-judge, error-analysis, evaluation-methodology, product-management, golden-dataset]
timestamp: 2026-08-01T00:00:00Z
attribution:
  when: 2026-08-01T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator pasted three AI-evals sources (a study guide, this video, Hamel Husain's FAQ) for capture into the brain"
---

# Complete Beginner's Course on AI Evaluations (2025) — Aman Khan

## Summary

This is a screen-recorded, unscripted build session rather than a lecture:
two product people evaluate a customer-support chatbot for a running-shoe
brand, live, in a spreadsheet. They start by writing an initial instruction
prompt for the bot using an AI assistant's prompt-generation tool, feeding
it copied-and-pasted product and return-policy text from the brand's real
website. They then run a handful of realistic customer questions through
that prompt, and for each answer they debate — out loud, disagreeing at
points — whether it was good, judged against three criteria they invent as
they go: did it know the right facts about the product, did it follow the
stated policy, and did it sound like the brand. That graded spreadsheet
*is* what the video calls a "golden dataset."

The second half scales the same judgment up: they upload that small labeled
spreadsheet into an evaluation platform, write a prompt asking an AI model
to hand out the same three grades automatically, and then check whether the
AI's automatic grades agree with the humans' original grades. In their own
example the AI grader agrees on factual accuracy but is far too lenient on
tone — it rates a wordy, formal response as fine, where the humans had
called it bad — which the hosts treat as a demonstration of why an AI
grader always needs a human check before anyone trusts it. They close by
walking through how a real team would ramp this from ten examples to a
hundred, then to a small percentage of live traffic, before a full launch.

## Key terms

- **The four types of eval** — the video's own taxonomy, given upfront:
  *code-based* (a deterministic check, e.g. does the response mention a
  competitor by name), *human eval* (a person grading an interaction
  thumbs-up/thumbs-down or against a rubric), *[LLM-as-judge](/beliefs/glossary/llm-as-judge.md)*
  (an AI model trained to grade like the human would, at scale), and *user
  eval* (real-world signal from actual users interacting with the live
  product — the closest of the four to a business metric).
- **Golden dataset** — the video's term for what the
  [study guide sibling document](/knowledge/SWE/evals/ai-evals-for-engineers-pms-qas-study-guide.md)
  in this bundle calls a labeled [gold set](/beliefs/glossary/gold-set.md):
  a small, hand-graded spreadsheet of (question, AI answer, human labels)
  rows, built by running real or realistic questions through the system and
  grading each response against agreed criteria.
- **Grading rubric / criteria** — in this example, three per-response
  dimensions graded good/average/bad: *product knowledge* (does it know
  the facts), *policy compliance* (does it follow the stated rules), and
  *tone* (does it sound like the brand).
- **Match rate** — comparing an [LLM-as-judge](/beliefs/glossary/llm-as-judge.md)'s
  automatic label against the human's original label on the same rows, row
  by row, to see how often they agree; the video's demo shows 100% match on
  product knowledge but a low match rate on tone, exposing that the judge's
  tone criterion was too lenient as written.
- **Prompt iteration loop** — the video's recap of the whole process as a
  cycle: write/adjust the system prompt → generate responses → grade them
  (human, then judge) → find what's wrong → adjust the prompt or the
  judge's criteria → repeat, moving from ~10 examples (fast iteration, low
  confidence) toward ~100+ examples (slower, higher confidence) as
  conviction grows.
- **Benevolent-dictator-adjacent staged rollout** — the launch sequence the
  video recommends: internal dogfooding first, then a small percentage of
  live traffic (an A/B test), watching for user complaints, before a full
  rollout — never labeled "benevolent dictator" in the video itself, but
  the same instinct as Hamel Husain's [FAQ sibling document](/knowledge/SWE/evals/llm-evals-faq-hamel-husain-shreya-shankar.md)
  that a single accountable reviewer, not a committee, should drive early
  grading decisions.

## Technical summary

The demo builds a customer-support agent prompt for a running-shoe brand
using Anthropic's Workbench prompt-generation tool, seeded with
copy-pasted product and return-policy text from the brand's real website —
illustrating that even prompt construction starts from real domain
material, not invented context. Running a handful of realistic customer
questions ("I bought the Cloud Monster shoe two months ago but want to
return it") through that prompt produces a small set of responses, which
the two hosts grade by hand into a spreadsheet against three criteria:
product knowledge, policy compliance, and tone — disagreeing openly on
several rows (e.g. whether an answer that defers a policy gap to "contact
support" is *good given the policy's own gap* or simply *bad because the
policy itself should be improved*), which the video frames as the point:
labeling is a debate that surfaces both prompt bugs and product
(policy-content) gaps, not a mechanical pass. One concrete failure surfaced
this way — the agent misjudging that 45 minutes is past a 60-minute
cancellation window — illustrates a class of error the
[study guide sibling document](/knowledge/SWE/evals/ai-evals-for-engineers-pms-qas-study-guide.md)
calls out structurally: LLMs are unreliable at arithmetic embedded in
policy reasoning, and this kind of failure is invisible without reading
individual transcripts by hand.

Once five rows are graded, that spreadsheet is uploaded into Arize as an
evaluation dataset, and an [LLM-as-judge](/beliefs/glossary/llm-as-judge.md)
prompt is written encoding the same three criteria the humans used, so the
platform can regrade every response — and any new response from a
different underlying model (the demo swaps in GPT-5 to compare) —
automatically. The video's key methodological beat is checking the judge
against the humans rather than trusting it: product-knowledge grades match
100% of the time, but tone grades match only once out of the sample,
because the judge's tone prompt does not penalize verbosity the way the
humans did. This mirrors the train/dev/test validation discipline in the
[study guide sibling document](/knowledge/SWE/evals/ai-evals-for-engineers-pms-qas-study-guide.md),
compressed to its simplest possible illustration —
label a few examples by hand, run the judge, and directly compare — without
naming TPR/TNR or a formal held-out split.

The hosts also demonstrate automated prompt optimization (asking the tool
to make the agent's responses "more friendly and less formal") and find the
result unconvincing — the rewritten prompt added more explicit formatting
rules without actually making the tone friendlier, illustrating in miniature the
[Hamel Husain FAQ sibling document](/knowledge/SWE/evals/llm-evals-faq-hamel-husain-shreya-shankar.md)'s
warning that criteria drift and prompt-optimization tools cannot substitute
for a human reading real outputs against real labels. The video closes on a staged-rollout recap: internal
testing at roughly 10 graded examples, scaling confidence toward 100+
examples, then a small percentage of live traffic before full launch — and
a closing product question left open rather than answered: when a user's
own thumbs-down disagrees with what the eval says is a good response,
which signal should a team trust, and how do you decide?

# Citations

- ["Complete Beginner's Course on AI Evaluations in 50 Minutes (2025) | Aman Khan"](https://www.youtube.com/watch?v=TL527yTpxlk),
  Peter Yang's YouTube channel, fetched (transcript + metadata) 2026-08-01.
  Chapters per the video description: 0:00 what AI evals are; 2:52 the four
  types of eval; 6:08 live demo begins; 10:29 using Anthropic's console to
  generate the prompt; 15:13 creating the evaluation criteria; 17:40 human
  labels on the golden dataset; 31:05 scaling with LLM-judge prompts; 38:21
  aligning the judge with human judgment.
