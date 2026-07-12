---
type: reference
title: 2026-07-12-dedup-recall-probe-and-synonym-intake
description: Built mix brain.dedup_probe (the offline dedup-recall eval, gold set, first baseline plain 3/10 vs expanded 10/10), then shipped the tier-1 synonym-expanded /intake dedup change and an automated gold-harvest step, resolving the plan's three open questions toward zero operator upkeep; plan marked done.
provenance: "Claude Code session (Claude Opus 4.8), 2026-07-12; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, evals, dedup, recall, probe, intake, tooling]
timestamp: 2026-07-12
---

# 2026-07-12-dedup-recall-probe-and-synonym-intake

Verbatim render. Retained operator messages and agent responses are reproduced
**verbatim** (the delivered text); only tool calls, tool results, reasoning, and
short pre-tool narration are stripped. In-message ATX headers are demoted to bold
so they don't collide with the `## User`/`## Assistant` structure. Rendered from
context via `/capture`'s render-from-context path.

## Where this landed

The operator invoked `Run dedup-recall-probe`, which pointed at the proposed
[dedup-recall-probe plan](/meta/plans/dedup-recall-probe.md). The session built the
whole thing in two passes. First, the **instrument**: the `meta/evals/` genre, the
[gold set](/meta/evals/dedup-probe.md) (the vector-DB analysis's 14 probes re-keyed
to `sb:` ids, with `target`/`negative`/`quarantine` bands and synonym variants),
[`SecondBrain.DedupProbe`](/lib/second_brain/dedup_probe.ex) +
[`mix brain.dedup_probe`](/lib/mix/tasks/brain.dedup_probe.ex) (parser, lexical
substring backend, plain + `--expanded` scoring, baseline delta), a fixture-based
test, and a non-gating CI report step. The first live baseline — **plain 3/10,
expanded 10/10** — is the offline proof that synonym expansion recovers 7 of the 10
misses.

After a plain-language explainer, the operator answered the plan's three open
questions with a clear steer: *don't give me manual upkeep — automate it.* So the
session shipped the **tier-1 fix**: `/intake`'s dedup step now requires
synonym-expanded search (3–5 alternate phrasings), and a new `/intake` step
**automatically harvests a gold row** from the operator's own phrasing and refreshes
the baseline via a new `mix brain.dedup_probe --update-baseline` (the baseline is
generated, not hand-kept; the trend lives in git history), escalating to the operator
only on a recall regression. Both changes were mirrored in the
[intake flow doc](/meta/flows/intake.md). The plan is `done`; this resolves the
"Tier-1 not yet implemented" strand carried by the
[vector-DB recall thread](/meta/threads/2026-07-09-vector-db-recall-evaluation-and-analysis-type.md).
Shipped on branch `claude/dedup-recall-probe-qyvt7w`; all gates green (93 tests).

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Dedup-recall probe instrument — gold set, `SecondBrain.DedupProbe`, `mix brain.dedup_probe`, first baseline | closed | [dedup-probe gold set](/meta/evals/dedup-probe.md) | - |
| Tier-1 synonym-expanded `/intake` dedup + automated gold-harvest + `--update-baseline` | closed | [dedup-recall-probe plan](/meta/plans/dedup-recall-probe.md) | - |
| Plan's three open questions (evals genre, gold-harvest default, baseline cadence) | closed | [dedup-recall-probe plan](/meta/plans/dedup-recall-probe.md) | - |
| Plain-language explanation of the probe and the decisions needed | closed | `unrouted` | - |
| Open a PR when the work is done | closed | `unrouted` | - |

## User

Run dedup-recall-probe

## Assistant

Pushed to `claude/dedup-recall-probe-qyvt7w`. Here's where things landed.

**Priority appraisal (per the session-init note)**

The session-init heuristic ranks the two open operational issues and the `priority: 1` skills-compile plan on top. I'd keep that ordering — **tracked problems (orphaned-branches cleanup, the broken /news Routine) and the operator-flagged skills-compile plan outrank new work** — but your directive to "Run dedup-recall-probe" pins this plan for this session, which is what I executed. The dedup probe was the highest-leverage *new* item anyway: it's the substrate the later corpus-maintenance evals and the epistemic-overlay plan both build on.

**What I built — `mix brain.dedup_probe`**

Executed **build-order steps 1–4 plus the first baseline (step 6)** of the [dedup-recall-probe plan](/meta/plans/dedup-recall-probe.md), which is now `in-progress`:

| Artifact | What it is |
|---|---|
| `meta/evals/` + `dedup-probe.md` | New eval genre; the 14 vector-DB probes re-keyed to `sb:` ids, with `target`/`negative`/`quarantine` bands, synonym-expansion variants, adjudication notes, and a committed `## Baseline`. |
| `SecondBrain.DedupProbe` + `mix brain.dedup_probe` | Gold-doc parser, lexical (case-insensitive substring) backend over title/description/tags/body, surfaced-or-not scorer, plain + `--expanded` modes, baseline delta. |
| `dedup_probe_test.exs` | Fixture corpus + gold set pinning parsing, hit/miss, band handling, expanded recovery, and baseline-delta rendering (6 tests). |
| `ci.yml` | Non-gating report step (recall is a trend metric, not an invariant). |

**First baseline, measured live against the corpus: plain 3/10, expanded 10/10.** That gap is the real, offline, repeatable measurement of the recall the tier-1 `/intake` synonym-expansion change is expected to recover — 7 of 10 natural-phrasing queries miss under plain lexical search (e.g. "context pollution" → the concept says "poisoning"; "lost in the middle" → "context rot") but are recovered once the recorded variants are searched. When the **plain** figure starts degrading as concepts are added, that's your quantified trigger for tier-2 embedding dedup.

All gates pass (92 tests, format, contract/registry/verify/route_tags/site).

**What I deliberately left for you — step 5 + the plan's open questions**

I stopped short of the tier-1 `/intake` change (synonym-expansion dedup + the gold-harvest step) because it's operator-facing workflow gated on the plan's unresolved questions. Two genuinely branch the work:

- **Q2 — gold-harvest default:** should `/intake` append a gold row on *every* filing (opt-out, grows the set fastest) or *only when you ask* (opt-in, less per-intake upkeep)?
- **Q3 — baseline cadence:** update the committed `## Baseline` on *every* run that changes it (honest) or *deliberately* after intake batches (readable trend)?

Q1 (ratify `meta/evals/` as a genre) I treated as ratified — the plan states that accepting it ratifies the directory, and directing me to run the plan is that acceptance; say the word if you'd rather it live elsewhere.

Want me to proceed with step 5 once you've answered Q2/Q3, and/or open a PR for what's here?

## User

Explain to me in plain terms what is happening and what you need from me.

## Assistant

Here's the plain-language version.

**What this is about**

Your "second brain" is a big pile of notes. When you paste in something new, the assistant is supposed to first check: *"Do I already have a note about this?"* — so it updates the existing note instead of creating a near-duplicate. That check is called **dedup** (de-duplication).

The problem: that check currently works by simple word-matching. If your old note calls something "poisoning" but you search for "pollution," the match fails and you'd end up with two notes about the same thing. As the pile grows, this gets worse. Right now it doesn't bite because *you* still remember where everything is — but that memory won't scale.

**What I just built**

A **measuring stick** — a small tool (`mix brain.dedup_probe`) that checks how good that duplicate-finding actually is. It runs a list of realistic searches ("stale branch," "lost in the middle," etc.) and counts how many find the right existing note.

The first measurement, run against your real notes:

- **Plain word-matching: 3 out of 10** searches found the right note. (7 missed.)
- **With synonyms added: 10 out of 10.**

That gap is the whole point. It proves, with a real number, that teaching the assistant to *also search for synonyms* would fix most of the misses — cheaply, with no fancy database. And now that the measuring stick exists, it'll re-run automatically so you'll get a warning if things ever get worse.

This is all done, tested, and pushed to your branch. It changes nothing about how your notes work today — it just *measures*.

**What I need from you**

Three small decisions before I do the *next* part (actually teaching intake to search for synonyms). I recommend the option in bold each time:

1. **New folder `meta/evals/` for these measuring sticks** — I created it. Fine to keep, or should this live somewhere else? (**Keep it.**)

2. **When should the assistant record a new test question?** Every time you paste something in (grows the test set fast, but adds a tiny step to every paste), or **only when you ask** (less clutter)? (**Only when you ask.**)

3. **When should the "official score" be updated?** Every run automatically, or **only deliberately** so the trend stays readable? (**Deliberately.**)

And one bigger yes/no: **do you want me to go ahead and build the synonym-search improvement to intake** (the part that turns that 3/10 into something close to 10/10 in real use)? And separately, **should I open a pull request** for what's already done so you can review it on GitHub?

I can ask these as clickable options if that's easier — just say the word.

## User

Pr can be done when all this work is done. Yes. Build the synonym search improvement intake. Regarding the questions, one, yes. Two and three, I'm not exactly sure because I'm not exactly sure what you would want from me to upkeep that process. So I either need very clear instructions about what I need to do and when I need to do it, or we should set this up to be automated.

## Assistant

<routes ref="/meta/plans/dedup-recall-probe.md .claude/skills/intake/SKILL.md">
Understood. Let me lock in the decisions the way you asked — **you do nothing manually; the agent automates all of it**:

- **Q1** ✓ `meta/evals/` stays.
- **Q2 (gold-harvest):** automatic on every `/intake` — the agent records the test row itself using your own words for the thing, and skips silently if your intake had no natural phrasing to harvest. No step for you.
- **Q3 (baseline):** the score becomes a *generated* number refreshed by a command (`--update-baseline`) the agent runs during intake, so it's never hand-edited; the trend lives in git history; and the agent pings you *only* when recall drops (that's the one moment a decision is actually yours). No schedule, no manual edit.

Let me look at the intake skill I'll be editing, then build.
</routes>
