---
type: reference
title: 2026-07-26-living-text-present-tense-policy
description: An operator challenge to "this hook used to also emit…" wording in the SessionStart hook became a ratified policy — living surfaces state the present, git narrates the past — plus a sweep that traced every genuine instance to one refactor, four cleanup edits, and a mid-session correction after the agent drafted a doctrine while recommending a policy.
provenance: "Claude Code session (Claude Opus 4.8, then Claude Opus 5), 2026-07-26; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, governance, policy, provenance, documentation, doctrine-vs-policy]
timestamp: 2026-07-26
session: https://claude.ai/code/session_016HqEGUGboxBj3A9FKcvkjz
pr: 140
---

# 2026-07-26-living-text-present-tense-policy

## Where this landed

The operator quoted the SessionStart hook's comment — "This hook **used to also
emit** the session-init digest…" — and asked three things: is there a reason to
persist that wording, isn't git history enough, and wasn't a policy created
recently to address it. The answer was that the principle *was* ratified
([retire-hand-kept-logs](/meta/plans/retire-hand-kept-logs.md) resting on
[merge-strategy](/meta/policy/merge-strategy.md)) but scoped to `log.md` files,
not to retrospective narration inline in code and docs. The operator chose to
sweep, ratify, and clean up.

The settled outcome is the policy
[living text states the present; git narrates the past](/meta/policy/living-text-is-present-tense.md)
(`section: filing`, `order: 10`), carrying the rule plus three carve-outs that
are as load-bearing as the rule itself: present-tense pointers, Chesterton's-fence
justifications for live code, and explanatory surfaces where the history *is* the
subject. The sweep found that every genuine instance traced back to a **single
refactor** — the removal of the auto-injected SessionStart digest in favor of
`/priorities` — whose residue had been re-narrated independently in four places;
each was rewritten to the present. The session-init tutorial's marked `History`
blockquote was deliberately kept as the carve-out's boundary case.

Two corrections landed mid-session. The agent drafted the artifact as a
`doctrine` while simultaneously recommending `policy`, and the operator caught
the contradiction and asked whether the formal definitions had been consulted;
they had been available and were not applied — the type was anchored on the
agent's own earlier phrasing rather than derived from the vocabulary. Second, at
capture time the policy turned out to be the graduation of an existing
`future-beliefs` entry ("an artifact states what it *is*, not what it replaced")
filed 2026-07-22, which the sweep had missed by scoping to code and policy
surfaces; that entry is now marked formalized and points at the policy.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| "used to…" wording in living text — is it already policy-covered? | closed | [living-text-is-present-tense](/meta/policy/living-text-is-present-tense.md), [future beliefs](/beliefs/future-beliefs.md) | - |
| Doctrine vs policy: which type fits an enforceable rule | closed | [doctrine](/beliefs/glossary/doctrine.md), [policy-type](/beliefs/glossary/policy-type.md) | - |
| Sweep of living surfaces; four cleanup edits from one refactor | closed | [.claude/hooks/session-start.sh](/.claude/hooks/session-start.sh), [lib/elixir_mind/session_init.ex](/lib/elixir_mind/session_init.ex), [skills-registry](/meta/policy/skills-registry.md) | - |
| Tutorial `History` note kept as the carve-out boundary case | closed | [the-session-init-digest tutorial](/meta/tutorials/the-session-init-digest.md) | - |
| Belief graduation discovered at capture time | closed | [future beliefs](/beliefs/future-beliefs.md) | - |

## User

see this  from hooks/session-start.md
"# Provision the session's toolchain — nothing more. This hook used to also emit
# the session-init digest (open work + a heuristic top-3) into every session's
# context; that appraisal now lives behind the on-demand `/priorities` skill
# (see .claude/skills/priorities/SKILL.md), so the hook's sole job is to ensure
# the Elixir/OTP toolchain is present and warm so `mix brain.*` — including the
# priorities skill, the contract compiler, and the test suite — works."

is there a reason we should persist "this used to..." wording about functionality that has been deprecated? isn't this documented enough in the git history? i have seen several examples like this. wasn't there a policy created recently to address this?

## Assistant

You're right on both counts — the instinct is sound, and there *is* an established principle that speaks to it. But it's worth being precise about what exists, because there isn't a policy that directly names this case.

<routes ref="em:1b3c79 meta/policy/living-text-is-present-tense.md">
### What the brain already ratified

The closest ratified rule is **[retire-hand-kept-logs](/meta/plans/retire-hand-kept-logs.md)** (done, 2026-07-11) resting on **[merge-strategy](/meta/policy/merge-strategy.md)**: *the true-merge commit graph is the single provenance layer; the change narrative belongs in commit messages.* The operator's own ratifying argument was exactly yours:

> *"the only true guarantee is one source of truth… why is git history not enough? If we can't define [the log's unique value] discretely, better to remove the liability."*

And its "Demonstrated failure avenue" is precisely the risk here:

> *Stale-but-greppable prose gets retrieved and trusted as current state.*

That's the whole hazard of a comment like *"This hook used to also emit the digest…"* — it's a miniature hand-kept changelog embedded in a comment, the same liability the log purge removed, just at a smaller scale and in a spot the purge didn't sweep.

So: **the principle is ratified, but it was scoped to `log.md` files, not to retrospective narration living inside code comments and doc prose.** There is no dedicated policy or doctrine saying "don't narrate deprecated behavior in living text." What you're noticing is that principle's logic reaching past the specific artifacts it was written against.
</routes>

<routes ref="em:1b3c79">
### One caveat before a blanket sweep

Not all "used to" wording is pure history. There's a real distinction:

- **Retrospective narration** — "This hook *used to also emit* the session-init digest." This is the changelog fragment. Git owns it; drop it.
- **Present-tense pointer** — "the appraisal *now lives behind* `/priorities`." This tells a present reader *where the functionality went*, which git history does *not* surface at a glance. That's load-bearing and worth keeping.

The hook comment mixes both. Trimmed, it stays useful without the archaeology:

```bash
# Provision the session's toolchain — nothing more. The session-init appraisal
# (open work + heuristic top-3) is not emitted here; it lives behind the
# on-demand `/priorities` skill (.claude/skills/priorities/SKILL.md). This
# hook's sole job is to ensure the Elixir/OTP toolchain is present and warm...
```

Same information a reader needs, minus the "used to."
</routes>

### My recommendation

Since you say you've seen **several** examples, this is past a one-off edit — it's a candidate for a small **doctrine** (the standing direction: *living text states present tense; git narrates the past*) that policies/reviews can cite, or at minimum a documented cleanup pass. Per the contract, adding a doctrine/policy is a change to the shape of the brain that you ratify, so I won't create one unilaterally.

How would you like to proceed? A few options:

1. **Sweep first** — I grep the living surfaces (`.claude/`, `lib/`, `meta/policy`, `meta/flows`, doc bodies) for retrospective-narration instances, show you the list, and we decide per-instance. Good if you want to see the actual scope before committing to a rule.
2. **Ratify a doctrine** — I draft a `type: doctrine` (something like *"living text is present-tense; git carries the past"*) under `meta/doctrine/`, you ratify, then the sweep executes against it as the citing authority.
3. **Both** — sweep to size the problem, then ratify the doctrine so it doesn't recur, then clean up.

I'd lean toward **3**, since the branch name (`deprecated-wording-docs`) suggests you already intend this as real work rather than just a question. Which do you want?

## User

3

## Assistant

Good. Starting with the sweep to size the problem. I'll scan the *living* surfaces only — code, policies, flows, tutorials, doctrine, skills, and knowledge/belief doc bodies — and deliberately exclude the frozen/by-design-historical records (`meta/threads/`, `meta/plans/`, `meta/analysis/`, `meta/issues/`, `meta/dev-history.md`, `deprecated/`).

The sweep is done, and it tells a cleaner story than "scattered rot." After dropping false positives, almost every genuine instance traces to **one refactor** — the removal of the auto-injected SessionStart digest in favor of `/priorities`. That single change left "used to / no longer / the old / now lives behind" residue in five different living surfaces, each independently re-narrating the same history.

### Sweep results

**Genuine retrospective narration — trim to present tense (all one event):**

| Surface | Current wording | Why it's a liability |
|---|---|---|
| `.claude/hooks/session-start.sh:4` | "This hook **used to also emit** the session-init digest… now lives behind `/priorities`" | changelog embedded in a comment |
| `.claude/skills/priorities/SKILL.md:9` | "the on-demand **successor to the old** SessionStart digest… **no longer injected** automatically" | the on-demand fact is present; the "old/no longer" framing is git's job |
| `lib/elixir_mind/session_init.ex:6` | "(it is **no longer auto-injected**… the hook **now only** provisions the toolchain)" | moduledoc only needs "produced on demand by /priorities" |
| `meta/policy/skills-registry.md:82` | "on-demand **successor to the old** SessionStart digest (**no longer** auto-injected…)" | this is contract *source* — trimming it means a `/render-contract` recompile |

**Keep — these look like the pattern but carry present-tense value (the carve-outs the doctrine must protect):**

- `lib/elixir_mind/lineage.ex:26` — "`parse_lineage_block/1` remains **only as** the migration reader the backfill used to use." This is a Chesterton's-fence: it justifies why live code still exists. Deleting it makes the function look dead. **Keep.**
- `lib/elixir_mind/dev_history.ex`, `backfill.ex` — "pre-PR era / pre-policy squash era" are *domain concepts the code classifies commits into*, not narration. **Keep.**
- doctrine argumentation ("no longer comes for free"), a `>` quote in engineer-as-orchestrator, "previously deployed site stays live" (runtime mechanism), "Used to resolve links" (purpose, not past tense), `route_tags` "no longer fed" (a live condition), test names — **all false positives.**

**The one boundary case worth your call:**

- `meta/tutorials/the-session-init-digest.md:27` has an explicit `> **History.**` blockquote narrating the removal. A tutorial is read to *understand*, and here the coupling change is arguably part of the subject. This is exactly where "present-tense only" meets "sometimes the history *is* the point." My read: a tutorial/doctrine may keep a **clearly-marked, bounded** history aside when the change is the subject — but that permission is what makes the other four (operational/reference surfaces) *not* qualify. I'd keep this one and let it define the boundary in the doctrine.

### Drafted doctrine (for your ratification)

Here's the direction I'd persist. It's deliberately a generalization of the already-ratified [retire-hand-kept-logs](/meta/plans/retire-hand-kept-logs.md) principle — from dedicated `log.md` files down to inline narration:

```markdown
# Living text states the present; git narrates the past

A **living surface** — code, code comments, operational skills, reference docs,
the compiled contract — is read to act on the system *as it is now*. Every
sentence in it should therefore be true of the present. The commit graph is
already the brain's single change-narrative layer (merge-strategy,
retire-hand-kept-logs): retrospective narration embedded in living text — "this
used to X", "the old Y", "was removed in favor of Z" — is a second, hand-kept
history layer at comment scale, and it fails the same way the purged logs did:
it goes stale silently and gets retrieved as current state.

## The direction

**When you change the system, rewrite the living text to describe the new
present — do not append a note about what it used to be.** Git holds the before;
the commit message carries the why-we-changed-it. The living surface carries only
what is.

## The carve-outs — what is NOT retrospective narration

- **Present-tense pointers.** "The appraisal lives behind `/priorities`" tells a
  reader where the functionality *is now* — load-bearing, keep. Test: does the
  sentence tell the reader something they must know to act *today*, or only what
  changed?
- **Chesterton's-fence justifications.** A comment explaining why live code still
  exists ("kept only as the migration reader for X") justifies present code and
  reads as "this is why this exists," not as a changelog. Keep.
- **Explanatory surfaces where the history is the subject.** A `tutorial` or
  `doctrine` may carry a clearly-marked, bounded history aside when the change
  itself is what's being explained. That permission is exactly why operational
  and reference surfaces — which are read to act, not to learn the backstory —
  get none.

## What it commits the brain to

- On any change, update the living text to the new present; don't accrete "used
  to" sentences beside it.
- Code reviews and cleanup passes may cite this direction when trimming
  retrospective narration from living surfaces.
- It generalizes retire-hand-kept-logs from log *files* to inline narration, and
  serves the same single-provenance-layer intent as merge-strategy.
```

### Before I write anything — one decision

You said "ratify a **doctrine**," and I've drafted it as one. But doctrine docs are *not* compiled into `CLAUDE.md`, so agents won't see this by default the way they see policies. Its parent (retire-hand-kept-logs, merge-strategy) all live as **policy** — compiled into the contract, with behavioral teeth. Given you want this to actually stop the pattern recurring, I'd lean **policy** over doctrine.

**Which do you want?**
- **Policy** (my recommendation) — lands in `meta/policy/`, gets compiled into `CLAUDE.md` via `/render-contract`, so every agent sees it. Consistent with its retire-hand-kept-logs lineage.
- **Doctrine** — lands in `meta/doctrine/` as a standing direction; more "why" than "rule," but invisible in the contract.

Confirm doctrine-vs-policy (and whether you agree the tutorial history-note stays as the boundary case), and I'll write the governance doc + run the four cleanup edits + recompile the contract, all on this branch.

## User

if you lean policy over doctrine, then why did you create a doctrine?
what is the formal definition of each, and did you consider that before making the decision?
was the formal definition of each successfully surfaced to you while deciding, or is that something we need to investigate?

## Assistant

You've caught a real inconsistency, and the honest answers aren't flattering to my process. Let me take them in order.

**Why did I draft a doctrine while recommending policy?**

Because the two decisions happened in the wrong order. In my earlier message I offered option 3 with the words "I draft a `type: doctrine`," and when I sat down to write the draft I anchored on that phrasing and produced it in the doctrine mold. Only *after* drafting did I actually think about the discriminator that matters (doctrine isn't compiled into `CLAUDE.md`) — and that thought pointed at policy. So the recommendation formed *after* the artifact and contradicted it. I should have flagged that and not handed you a draft whose type my own reasoning disagreed with. (To be precise about state: I didn't *persist* a doctrine — nothing was written to disk; it's chat-only text pending your ratification. But drafting it in that shape and headlining it "doctrine" is the error you're pointing at, and "I didn't write a file" doesn't excuse it.)

<routes ref="em:6a9e78 em:fa15e7">
**The formal definitions.** Both are in the controlled-type-vocabulary, verbatim:

- **`policy`** — "a governance rule for how the brain operates; the source from which `CLAUDE.md` is compiled (lives under `meta/policy/`)."
- **`doctrine`** — "a persisted **intention statement**: a guiding principle or direction that shapes how the brain and its agents are designed and prioritized — the 'why' that informs judgment **without prescribing a specific enforceable action**. Doctrine sits *above* policy: a `policy` **implements** doctrine as a concrete, machine- or operator-enforceable rule…"

The discriminator is right there: **prescribes a specific enforceable action → policy; informs judgment without prescribing one → doctrine.** My draft's core ("rewrite living text to the new present; do not append a note about what it used to be") *is* a concrete, operator-enforceable-in-review action. By the definition, that's a policy. It also shares a parent lineage (merge-strategy, retire-hand-kept-logs) that is entirely policy. So applying the definition, policy is the correct fit — and notably, the "agents see it in the contract" argument I led with earlier is the *weaker* reason; the definitional one is the real one.
</routes>

**Did I consider the definitions before deciding, and were they surfaced?**

Surfaced: yes. They were in my context the whole time — the full `CLAUDE.md`, including that vocabulary, is in the operating contract I was given. So there's **no surfacing gap to investigate**; this isn't a tooling failure. Considered at decision time: no — not rigorously. I defaulted to my earlier "doctrine" phrasing instead of deriving the type from the definition. That's a reasoning lapse on my part, not a missing input. The fix is procedural and entirely on me: derive the type from the definition *before* drafting, not after.

**Corrected recommendation:** make it a **policy** under `meta/policy/`, recompile the contract. The deepest "why" it serves — one source of truth, the commit graph as the single provenance layer — is *already* doctrine-level intent embodied in merge-strategy; this new artifact is the concrete rule *implementing* that intent for inline text, which is exactly the "policy implements doctrine" relationship the definition describes. A separate doctrine would be redundant with what merge-strategy already carries.

Want me to proceed on that basis — write it as a policy, keep the tutorial history-note as the stated boundary case, run the four cleanup edits, and `/render-contract`?

## User

proceed
then

## Assistant

Done — committed as `a47e6fd` and pushed to `claude/deprecated-wording-docs-up9g7g`.

### What landed

**The policy** — [`meta/policy/living-text-is-present-tense.md`](https://github.com/ob6to8/elixir-mind/blob/claude/deprecated-wording-docs-up9g7g/meta/policy/living-text-is-present-tense.md), `section: filing`, `order: 10` (right after merge-strategy, whose single-provenance principle it generalizes). Compiled into `CLAUDE.md`, so agents actually see it — the reason policy beat doctrine.

It carries the three carve-outs, which matter as much as the rule: present-tense pointers, Chesterton's-fence justifications for live code, and explanatory surfaces where the history *is* the subject. Plus an explicit scope note that `plan`/`analysis`/`issue`/threads/`deprecated/` are historical by construction and out of scope.

**The four cleanups** — every genuine instance traced to a single refactor (the auto-injected SessionStart digest → `/priorities`), which had left residue in four places:

| File | Before → after |
|---|---|
| `.claude/hooks/session-start.sh` | "This hook **used to also emit**…" → "The session-init appraisal **is not emitted here**; it lives behind `/priorities`" |
| `.claude/skills/priorities/SKILL.md` | "successor to the **old** SessionStart digest… **no longer** injected" → "produced here, on demand… not injected into a session's opening context" |
| `lib/elixir_mind/session_init.ex` | "**no longer** auto-injected… hook **now only**…" → "not injected into a session's opening context (the hook only provisions the toolchain)" |
| `meta/policy/skills-registry.md` | "successor to the **old** SessionStart digest (**no longer** auto-injected)" → "the on-demand appraisal, produced when asked rather than injected at session start" |

Kept deliberately: the `> **History.**` blockquote in [`the-session-init-digest.md`](https://github.com/ob6to8/elixir-mind/blob/claude/deprecated-wording-docs-up9g7g/meta/tutorials/the-session-init-digest.md) — it's a tutorial, the coupling change is part of what it explains, and it now stands as the named boundary case. Also kept the `lineage.ex` "migration reader" comment (Chesterton's fence) and the `dev_history.ex` "pre-PR era" strings (domain concepts the code classifies by, not narration).

**Gates:** contract `--check` up to date, `brain.verify` clean, `brain.route_tags` clean, 180 tests / 0 failures. The one route-tags warning is pre-existing and editorial, on an unrelated 2026-07-13 thread.

### Two things worth your attention

**The sweep was narrower than "several examples" suggested** — not because the instinct was wrong, but because one refactor had scattered its residue across five surfaces. That's the actual failure mode this policy prevents: a single change re-narrated independently in every file it touched. Worth knowing the mechanism, since the next refactor will do the same unless the policy catches it.

**No PR opened** — you said "proceed" to the plan, which didn't include one. When you want it, `/create-pull-request` will capture this session, glossary it, stamp the thread into the policy's `attribution.from`, and open the PR in one motion. Given this session produced a governance doc, running that skill (rather than a bare PR) is the right close — the `from` back-link is part of the contract's attribution rules and only that flow sets it.
