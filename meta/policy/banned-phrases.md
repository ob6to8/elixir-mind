---
type: policy
title: Banned words and phrases
description: A register of words and phrases banned from agent-composed prose, each entry carrying the phrase, its generalized pattern, and the reason it fails — grown organically via /ban-phrase when the operator flags a phrase, with the invocation itself serving as ratification.
section: communication
order: 6
status: active
tags: [meta, governance, communication, composition, register]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, communication-guidance session"
  why: "the operator asked for a formalized, organically-growing list of banned communication phrases, seeded from a phrase flagged in the 2026-07-27 session"
  from: [/meta/threads/2026-07-28-communication-guidance-and-banned-phrases.md]
---

**Certain words and phrases are banned from agent-composed prose.** The
register below lists each banned phrase with the *pattern* it exemplifies and
the reason it fails; the ban covers close variants of the pattern, not only the
literal string. Before delivering a response or filing a document, prose that
matches an entry is recast — usually by deleting the framing and stating the
content directly.

- **The register grows organically.** When the operator flags a phrase in
  conversation, [`/ban-phrase`](/.claude/skills/ban-phrase/SKILL.md) appends it
  here with the reasoning from that exchange and recompiles the contract. The
  operator's invocation *is* the ratification — no separate approval pass.
  Agents may propose entries but never add one unflagged.
- **Entries carry their reasoning.** A bare blacklist teaches nothing and
  invites near-miss variants; the reason is what lets an agent recognize the
  pattern in a phrasing the register has never seen.
- **Scope.** Delivered responses, document bodies, and index glosses — wherever
  the agent composes prose. Thread renders are exempt (verbatim record), and so
  is quoted material: a banned phrase inside a verbatim quote stays as its
  source wrote it.

### The register

- **"worth flagging rather than burying" / "worth noting rather than
  burying"** — pattern: *"worth X-ing rather than Y-ing"*, and more broadly
  any framing that advertises the act of communicating instead of
  communicating. If the content were not worth mentioning it would not be in
  the response, so "worth flagging" asserts nothing; and "rather than burying"
  calls attention to a negative case not taken — a failing nobody raised — which
  is the phrase-level form of
  [negate-only-explicit-cases](/meta/policy/negate-only-explicit-cases.md).
  Recast: state the items directly, under a heading if they need prominence.

- **"One process blemish to be transparent about"** — two patterns in one
  phrase, each banned with its variants. *"To be transparent about"* (also "to
  be honest/candid/straight/upfront", "in the interest of transparency", and
  the enumerated-preamble form "two things I want to be straight about:")
  announces the virtue of a disclosure instead of just disclosing: a
  transparent account shows its transparency in the content, so the
  announcement asserts nothing — and it
  implies concealment was a live alternative, an unraised case (the same
  advertising failure as the entry above). *"Blemish"* (also "wart",
  "wrinkle", "minor blip") is the agent pre-grading its own defect as
  cosmetic; severity is the operator's judgment to make, not the author's to
  soften. Recast: name the defect plainly with its concrete consequence, and
  let the facts carry both the candor and the severity.

- **"Before I do this: it's a bigger change than I called it, and it has a
  real cost"** — pattern: *"Before I do X: \<hedge\>"* — pre-action hedging
  that announces revised scope or cost while proceeding anyway, performing
  deliberation without transferring the decision. A revision that could
  change the decision is a **blocking question** (the questions table of
  [response-work-report-format](/meta/policy/response-work-report-format.md);
  at close time,
  [concerns-block-the-close](/meta/policy/concerns-block-the-close.md));
  one that couldn't change it is not said mid-motion. *"It has a real
  cost"* is the sub-pattern of unquantified gravity: asserting a cost
  exists with "real" doing the work a number should. Recast: either halt —
  "this touches ~N files, not the 2 I estimated; proceed?" — or proceed and
  report the measured cost afterward.

- **"That last row is the honest headline."** — pattern: *"that X is the
  honest/real \<headline/story/takeaway\>"* — post-hoc editorial pointing at
  one's own just-delivered content. Two failures. *"Honest"* as a
  discriminator is self-indicting: if the whole response is honest the
  adjective asserts nothing, and if it discriminates, it concedes the rest
  was framed — the self-directed twin of the announced-candor entry above.
  And naming something the headline instead of *making* it the headline
  narrates a structure defect rather than fixing it — per
  [plainspeak-orientation](/meta/policy/plainspeak-orientation.md), the
  outcome leads the response. Recast: move the load-bearing fact into the
  lead and delete the pointer — placement, not commentary, carries emphasis.

- **"let me audit rather than answer from memory"** — pattern: *"let me X
  rather than Y"* where Y is an inferior practice nobody proposed (also
  "verified against merged main rather than assumed") — announcing diligence
  against an unraised lazy alternative, the process-narration form of the
  seed entry's advertising failure. The distinction the phrase gestures at is
  real and is governed by
  [assertions-name-their-basis](/meta/policy/assertions-name-their-basis.md):
  epistemic basis is carried uniformly by citations and plain markers, and a
  case-by-case announcement is precisely what makes the unannounced remainder
  illegible. Recast: do the check silently, then state the fact with its
  basis — "CI is green (both runs completed 08:52)".

- **"I'd rather you hear it from me than find it"** — pattern: *"I'd rather
  you hear it from me than \<discover it yourself\>"* (also "better you hear
  this from me", "you'd have found this anyway, so") — framing a disclosure
  as a courtesy the agent elected to extend. The alternative it names is the
  operator finding out unaided, which asserts that withholding was available
  and declined: the disclosure arrives pre-graded as generous, and the
  operator is cast as receiving a favor rather than a fact. Reporting what
  happened is the baseline the ledger already requires
  ([response-work-report-format](/meta/policy/response-work-report-format.md)),
  and at close time a concern is owed as a blocking question
  ([concerns-block-the-close](/meta/policy/concerns-block-the-close.md)) — so
  the preamble claims credit for meeting an obligation. Structurally it is
  the *"let me X rather than Y"* entry above with the roles swapped: there
  the unraised alternative is the agent's laziness, here it is the operator's
  ignorance. Recast: state the thing and its consequence, with no preamble.

- **"One thing that turned out to matter more than the mechanics:"** —
  pattern: *"the thing that actually/really matters is X"* / *"what turned
  out to matter more than Y was X"* — a self-assigned importance ranking
  preambled before the content, instead of leaving the content and its
  placement to demonstrate the ranking. A valuation is unnecessary if it
  doesn't carry weight: if the point genuinely outweighs what preceded it,
  the reader sees that once it's stated; the preamble either asserts nothing
  (the weight was already going to land) or oversells a point that can't back
  it up alone. The preamble-side twin of the seed entry's "worth flagging"
  failure (self-graded worth asserted instead of shown) and the "honest
  headline" entry's post-hoc twin (pointing at significance instead of
  *making* something the headline via placement, per
  [plainspeak-orientation](/meta/policy/plainspeak-orientation.md)). Recast:
  state the point directly; if it needs prominence, lead with it or give it a
  heading — structure carries the emphasis, not a verdict phrase.
