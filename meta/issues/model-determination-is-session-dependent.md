---
type: issue
title: "A matter's `model:` stamp is session-dependent on exactly the matters where the tier choice costs most"
description: Four independent scoping runs over one identical unit of work agreed unanimously on the mechanical matter's model but split 3–1 on both judgment-weighted matters, so the roster's determination procedure yields a reproducible answer only where the answer barely matters.
status: open
provenance: "Claude Opus 5, scope-unit-of-work form-evaluation session"
tags: [meta, issue, models, roster, matters, scoping, evals, reproducibility]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, scope-unit-of-work form-evaluation session"
  why: "an A/B eval of the skill's body layout produced four independent scopings of one unit as a side effect, and the model stamps disagreed in a pattern the single-run case could never have surfaced"
  from: [/meta/threads/2026-08-02-skill-body-layout-ab-and-section-vocabulary.md]
---

# A matter's `model:` stamp is session-dependent

[`model:`](/meta/model-roster.md) is meant to be a controlled, queryable datum —
the roster's recommendation for the session that will deliver a matter. Four
scoping runs over the **same** unit of work, using the **same** roster, produced
stamps that agree only on the matter where the tier hardly matters.

## The evidence

Eight subagent runs (Claude Sonnet 5, worktree-isolated) scoped four specs under
two layouts of [`/scope-unit-of-work`](/.claude/skills/scope-unit-of-work/SKILL.md).
Four of them scoped one identical spec — a skill-heading vocabulary, which each
independently split into ratify → migrate → gate:

| Emitted matter | run 1 | run 2 | run 3 | run 4 | agreement |
|---|---|---|---|---|---|
| 1 · ratify the vocabulary | Fable 5 | Fable 5 | Fable 5 | **Opus 5** | 3/4 |
| 2 · migrate the skills | Sonnet 5 | Sonnet 5 | Sonnet 5 | Sonnet 5 | **4/4** |
| 3 · build the gate | Opus 5 | **Sonnet 5** | Opus 5 | Opus 5 | 3/4 |

Every run reasoned explicitly and cited repo precedent. The divergences are not
carelessness — they are two defensible readings of the same rows:

- **Matter 1** is either canonical policy prose whose "output *is* the artifact"
  (Fable) or a boundary decision the other two matters bind to, with no oracle
  behind a bad category scheme (Opus).
- **Matter 3** is either `lib/` tooling with a silent failure mode (Opus) or
  well-specified CI wiring against a pattern the repo already repeats (Sonnet).

The one unanimous row is the purely mechanical one. **The procedure is
reproducible exactly where reproducibility is worth least.**

## Why it happens

The roster's four questions sort a motion by *canonical · judgment · oracle ·
derivational*, and a real matter routinely scores on several at once. The
roster's tie-break — "stamp the weight of its **hardest** motion" — assumes the
motions are rankable, but "canonical prose" and "unoracled judgment" sit in
different dimensions, not on one scale, so Fable-vs-Opus has no rule to resolve
it. Two runs independently reported the same gap in their own words: the
roster's "Send here" column has no entry that maps onto editing a skill body,
and Sonnet's row is qualified "gated by `mix brain.verify`/the suite", which
does not apply to prose nothing mechanically checks.

## Why it matters beyond tidiness

- **`/matter list` renders the stamp**, so a reader ranking work by cost sees a
  number that would have been different had another session scoped it.
- **The queued backfill** ([backfill-model-stamps-on-matter-docs](/meta/matters/backfill-model-stamps-on-matter-docs.md))
  will apply this procedure across ~30 open docs in one pass, freezing one
  session's readings as if they were determinations.
- **[capability-matched-model-selection](/meta/doctrine/capability-matched-model-selection.md)
  rests its auditability on the attribution shadow.** An audit against a
  session-dependent recommendation cannot distinguish a mis-selection from a
  coin-flip in the baseline.

## Candidate fixes — none yet chosen

1. **Add the missing row.** The roster has no bucket for governance-prose edits
   (skills, indexes, glosses). Naming one would resolve the Fable/Opus split
   directly, and is the cheapest option.
2. **Make the tie-break a rule rather than a metaphor.** Replace "hardest
   motion" with an explicit precedence over the four questions, so two runs
   scoring the same matter on the same axes must land the same way.
3. **Let the field admit the uncertainty.** The roster already allows
   `model: undetermined`; it is currently framed for "cannot determine",
   not "two tiers are equally defensible", and no run used it.
4. **Accept it and downgrade the field's status** — document `model:` as an
   advisory hint rather than a queryable datum, and stop treating cross-doc
   consistency as meaningful.

Option 1 is the smallest change that removes the observed divergence; option 2
is what makes the field reproducible in general. They compose.

## Ruling — option 1 adopted, 2026-08-02

The operator adopted **option 1**. [The roster](/meta/model-roster.md) now
carries a governance-prose row sending skill bodies, index glosses, and register
rows to Sonnet 5 by default, with two boundaries stated so the row is decidable
rather than merely present: policies and doctrine are **excluded** (canonical
bodies, still Fable's, however small the edit), and an edit whose *content* is a
fresh decision rather than the rendering of a made one is stamped by the
decision's weight, not as prose.

**What that closes**, and what it does not:

- **Closed** — the gap both eval runs hit directly: a pure `SKILL.md`-body edit
  had no row, and Sonnet's "gated by the suite" qualifier did not literally
  apply to prose nothing mechanically checks. It has a home now.
- **Closed** — the matter-1 Fable/Opus split, by the exclusion rather than by
  the new row: writing a policy stays Fable's regardless of size, so the
  reading that produced the Opus dissent no longer competes.
- **Open** — the general case. Option 2 (an explicit precedence over the four
  questions) is **not** adopted, so a matter scoring on two axes still resolves
  by the "hardest motion" metaphor. The boundary clause added here decides one
  recurring collision — prose versus the decision inside it — not the family.
- **Unmeasured** — whether the divergence rate actually falls. The instrument
  that found it ([skill body layout A/B](/meta/evals/skill-body-layout-ab.md))
  can be re-run against the amended roster; nobody has.

This issue stays **open** on the residual. It interacts with the accepted
[separate-the-model-roster-concerns](/meta/plans/separate-the-model-roster-concerns.md)
plan, which will move this procedure to a policy and the enumeration to config —
the new row and its boundaries port with it.

## Scope of the finding

Four runs, one spec, one model tier (Sonnet 5), one roster revision. The
disagreement is demonstrated, not its rate: nothing here establishes how often
divergence occurs across the corpus, and a stronger model may or may not
converge. Both are measurable, and neither was measured.
