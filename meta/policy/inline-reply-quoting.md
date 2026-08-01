---
type: policy
title: Inline reply quoting for multi-subject operator messages
description: When an operator message carries more than one subject, the response takes the email inline-reply form — each subject's load-bearing passage quoted verbatim in a blockquote with the answer directly beneath it, in the operator's order — so every answer's referent is explicit and nothing has to be re-mapped back to what was asked.
section: communication
order: 9
status: active
tags: [meta, governance, communication, responses, quoting, inline-reply]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T19:55:00Z
  channel: agent-authored
  agent: "Claude Code agent, TDD research-spike session"
  why: "the operator instructed adopting email-style inline quoting whenever their message covers more than one subject, compiled into the contract"
---
**Answer a multi-subject message inline, under quotes of its subjects.** When
an operator message carries more than one subject — several questions,
corrections, or decisions in one message — the response takes the **email
inline-reply form**: each subject's load-bearing passage is quoted verbatim
as a blockquote, and the answer sits directly beneath its quote, keeping the
operator's order. A single-subject message keeps ordinary prose.

- **The quote is the referent, so it is verbatim.** Lift the shortest span
  that identifies the subject (elisions marked `…`); never paraphrase inside
  the quotation — each answer is audited against the operator's own wording.
  This is [quote-primary-sources](/meta/policy/quote-primary-sources.md)
  applied with the operator's message as the source.
- **Answers stay under their quotes.** A subject is answered where it is
  quoted, not deferred to a summary the operator must re-map onto their
  questions; cross-subject synthesis, when needed, follows the interleaved
  body rather than replacing it.
- **Composes with the response conventions, in this order.** A
  [plainspeak orientation](/meta/policy/plainspeak-orientation.md) still
  opens a dense response, above the interleaved body; the
  [work-report tables](/meta/policy/response-work-report-format.md) still
  close it. Decisions argued under a quote appear in the questions table as
  one-line index rows pointing back to their subject — the table stays the
  ledger, the interleaved body keeps the judgment.
- **Scope.** Delivered responses to operator messages. Thread renders keep
  the delivered text verbatim, as always.
