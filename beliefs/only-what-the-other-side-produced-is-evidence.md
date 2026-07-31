---
id: em:01abda
type: belief
title: Only what the other side produced is evidence
description: A verification step is itself testimony unless what it reads was produced by the party whose state is in question and could not have been produced by the acting side — which makes a self-generated check worse than no check, because it converts an unknown into a confident wrong answer.
depends_on: [em:674c8f]
resource: "https://www.reddit.com/r/AgentsOfAI/comments/1v87nmh/your_agent_says_done_you_check_and_nothing/"
provenance: "r/AgentsOfAI discussion thread \"Your agent says 'done.' You check and nothing actually happened.\" — commenter u/Shape_Weird, who discloses building in the space and offers the account as \"my own scar tissue rather than a survey\"; read from the operator's paste of the rendered page, since Reddit refuses unauthenticated reads (HTTP 403 over every route tried)"
tags: [belief, verification, evidence, agent-output, epistemics, instrumentation, observability]
timestamp: 2026-07-31
attribution:
  when: 2026-07-31T00:00:00Z
  channel: intake
  agent: "Claude Code agent, post-action-verification session"
  why: "the read-back prior (em:674c8f) says to verify against the source of truth but supplies no test for what counts as one; this is that test, and applying it invalidated a read-back the same session had just proposed"
---

# Only what the other side produced is evidence

[A completion claim is not evidence of completion](/beliefs/completion-claims-are-not-evidence-of-completion.md)
says to confirm a state change by reading it back. It does not say what counts as
a read. That gap is where the practice quietly fails, because a verification step
built from material the acting side generated is testimony wearing a check's
clothing — and it fails in the direction that does the most damage. The prior:
**an artifact counts as evidence only if the party holding the state produced it
and the acting side could not have produced it alone; a check that reads anything
else is not weak evidence but a source of confident wrong answers.**

The rule, and the failure that produced it:

> "evidence has to be something the other side produced that you could not have
> produced yourself. our own click is not evidence. our own rendering of their
> page is barely evidence. an id they minted, an email they sent, a network
> response they returned, those are evidence."

## Why a bad check is worse than no check

u/Shape_Weird's system submits job applications to employers' own systems, where
there is no cheap retry and no source of truth on their side of the boundary. The
first verifier matched a confirmation element in the page:

> "it worked. then i found that on one platform the same node renders on a
> validation failure as well, because the 'thanks, we got it' panel and the 'fix
> these fields' panel are the same component in two states. so the check returned
> true exactly in the case where i most needed a false. that is worse than having
> no check, because it converts an unknown into a confident wrong answer."

The asymmetry is the whole argument. An absent check leaves a known unknown, which
downstream systems and humans treat with appropriate caution. A check whose
false-positive is correlated with the failure it exists to catch *removes* that
caution precisely when it was warranted. The error is not that the check is
imperfect; it is that its imperfection is aligned with the failure mode rather
than random with respect to it.

This is why the criterion is about *provenance of the artifact* rather than
strength of the signal. "Did a success-looking thing appear?" admits self-produced
answers. "Did they mint an id?" does not.

## Absence of error is not evidence either

The inverse case took longest to find and is the more insidious of the two:

> "we count how many POSTs actually left the browser during a run. when that count
> is zero it means no request ever reached them, which means no server ever refused
> anything, which means 'no errors in this run' is describing a run in which
> nothing happened. for a long time that read as a clean run in our own logs. a
> clean run and a run where the network never fired look identical if the only
> thing you record is failures."

An instrument that records only failures cannot distinguish success from
non-occurrence, and it reports the second as the first. The remedy is a positive
count of the thing that was supposed to happen — requests that left, records that
were written, commits that landed — measured independently of whether anything
complained. The same shape as
[an instrument without a control measures itself](/beliefs/an-instrument-without-a-control-measures-itself.md):
a check that passes everything, including the empty case, is uninformative, and
its uninformativeness is invisible from its output.

Hence the closing metric, which inverts the usual reading of a quiet dashboard:
"the number i watch is errors, because a tool that never reports one is not a tool
that never fails."

## The design consequence: a third outcome that is easy to earn

The rule is unusable if the only outcomes are success and failure, because an
unobtainable confirmation then has to be forced into one of them — and it will be
forced into success, since that is what the acting side believes. The answer is a
third state, and a deliberate gradient between them:

> "nothing in our system is allowed to say applied. it may say it clicked submit.
> applied requires confirmation we did not generate, and when we cannot get it the
> answer is pending, which is a state we return often and deliberately made easier
> to earn than applied."

Two moves, and both are load-bearing. The vocabulary separates the act from its
effect — *clicked submit* is a fact about us, *applied* is a fact about them — so
the stronger word cannot be reached by narration. And making the weaker state
cheap to reach removes the pressure that would otherwise round every unconfirmed
case upward. A three-valued outcome whose middle value is grudging collapses back
to two.

## Scope

Held as a prior rather than a finding because its evidence is one practitioner's
scar tissue, offered as such — which is the
[scar-tissue lens](/beliefs/scar-tissue-lens-for-agent-failure.md) supplying its
own instance. It binds wherever a check is designed: the question to ask of any
proposed verification is not "is this check accurate?" but "who produced the thing
this check reads?" — and where the answer is *we did*, the check reports what was
already believed, in the case where that belief is wrong.
