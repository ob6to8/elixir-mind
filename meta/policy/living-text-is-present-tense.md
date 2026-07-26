---
type: policy
title: Living text states the present; git narrates the past
description: A living surface — code, comments, operational skills, reference docs, the compiled contract — describes the system as it is now; retrospective narration ("this used to X", "the old Y") is a second hand-kept history layer that belongs in the commit graph, not inline.
section: filing
order: 10
status: active
tags: [meta, governance, provenance, documentation, dry, single-source-of-truth]
timestamp: 2026-07-26
attribution:
  when: 2026-07-26T21:54:59Z
  channel: agent-authored
  agent: "Claude Code agent, deprecated-wording-docs session"
  why: "operator noticed 'this used to…' narration accreting in living code and docs and asked whether a policy should stop it; ratified as the inline-narration generalization of retire-hand-kept-logs"
---
**Living text states the present; git narrates the past.** A **living surface** —
code, code comments, operational skills, reference docs, the compiled contract —
is read to act on the system *as it is now*, so every sentence in it should be
true of the present. The commit graph is already the brain's single
change-narrative layer ([merge-strategy](/meta/policy/merge-strategy.md),
[retire-hand-kept-logs](/meta/plans/retire-hand-kept-logs.md)): retrospective
narration embedded in living text — "this used to X", "the old Y", "was removed
in favor of Z" — is a second, hand-kept history layer at comment scale, and it
fails the same way the purged `log.md` files did — it goes stale silently and
gets retrieved and trusted as current state. This is that lesson generalized from
dedicated log *files* down to inline narration.

**The rule.** When you change the system, rewrite the living text to describe the
new present — do not append a note about what it used to be. Git holds the
before; the commit message carries the why-it-changed. The living surface carries
only what is.

**The carve-outs — what is *not* retrospective narration:**

- **Present-tense pointers.** "The appraisal lives behind `/priorities`" tells a
  reader where the functionality *is now* — load-bearing, keep. Test: does the
  sentence tell the reader something they must know to act *today*, or only what
  changed?
- **Chesterton's-fence justifications.** A comment explaining why live code still
  exists ("kept only as the migration reader for X") justifies present code and
  reads as *this is why this exists*, not as a changelog. Keep.
- **Explanatory surfaces where the history is the subject.** A `tutorial` or
  `doctrine` may carry a clearly-marked, bounded history aside when the change
  itself is what it explains. That permission is exactly why operational and
  reference surfaces — read to act, not to learn the backstory — get none.

Records that are historical *by construction* — `plan`, `analysis`, `issue`,
thread docs, `deprecated/`, generated history like `meta/dev-history.md` — are
not living surfaces and are out of scope; narrating the past is their job.
