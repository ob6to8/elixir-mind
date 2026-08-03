---
id: em:8c84dc
type: concept
title: adversarial-verification
description: Checking a conclusion by commissioning a second, independent pass whose instruction is to refute it rather than confirm it — the claim is accepted only if it survives, so the check can fail where a "does this look right?" review structurally cannot.
provenance: "Agent-distilled glossary definition, 2026-08-03 plan-corpus audit session"
verified: false
tags: [glossary, evals, verification, agents, orchestration, methodology]
sense: common
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T16:20:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary over the plan-corpus-audit thread"
  why: "the audit's own method rests on the pattern and the term recurs across the council-round work and the Workflow quality patterns without a definition anywhere in the bundle"
---

# adversarial-verification

The load-bearing detail is the **instruction**, not the second pass. An
agent asked to review a finding tends to reconstruct the reasoning that
produced it and agree; the same agent told to *break* the finding goes
looking for the disconfirming artifact instead. Only the second framing
puts the verifier's effort on the side where a false claim would show up,
which is why an unrefuted verdict carries information that an approving
review does not.

Acceptance is therefore asymmetric: surviving refutation is evidence,
while failing to be refuted by a confirmation-seeking pass is nearly
none. Uncertainty short of refutation is recorded as a caveat rather than
counted as a kill, so the pattern does not simply invert into
reject-by-default.

Common elaborations: running several refuters and killing on a majority;
giving each a **distinct lens** (correctness, security, does-it-reproduce)
when a claim can fail in more than one way, since diversity catches what
redundancy cannot; and spending the pass only on verdicts that would
rewrite a record, where being wrong is expensive.

Its structural limit is the oracle. A refuter can only reach what it can
read — artifacts, history, a running suite — so a claim whose only
evidence is what the same session wrote is unfalsifiable by this method,
and commissioning a pass against it manufactures confidence rather than
testing it.

Distinguish from [fan-out](/beliefs/glossary/fan-out.md), which is about
running work concurrently and says nothing about what the workers are
asked to do, and from
[decompose-then-verify](/beliefs/glossary/decompose-then-verify.md), which
atomizes one long output into statements each checked against a source —
that pattern's unit is the statement and its oracle is the source, whereas
this pattern's unit is the conclusion and its oracle is the attack.

*Seen in:* [council-round suitability](/meta/analysis/council-round-suitability.md)
and [the /council skill plan](/meta/plans/council-skill.md), whose review
protocol is this pattern with dispositions as the gate;
[the plan-corpus audit](/meta/analysis/plan-corpus-audit.md), which routed
every mark-done/mark-superseded/fold verdict to a refuter and re-ran the
two that died mid-pass rather than reporting them unverified.
