---
type: tutorial
title: "Editing a document that is part authored, part generated"
description: How an edit to a glossary entry landed inside its generated route-tag excerpt log instead of its body, what the log-fidelity gate caught, and why a file with a boundary partway down is more dangerous to edit than one that is generated end to end.
provenance: "Claude Code session, 2026-07-28 — written from a mistake made and caught during the routing-ledger strand sweep"
tags: [meta, tutorial, route-tags, generated-artifacts, gates, editing]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, ledger-strand reconciliation sweep"
  why: "operator asked for a detailed walkthrough of the generated-block edit and the gate that caught it, as a durable explainer rather than a line in a thread"
  from: [/meta/threads/2026-07-28-routing-ledger-orphan-sweep-and-record-queue-split.md]
---

# Editing a document that is part authored, part generated

Most of this brain's generated files are safe to work with because the rule is
absolute: `CLAUDE.md`, [`meta/registry.md`](/meta/registry.md), and
[`meta/code-map.md`](/meta/code-map.md) are generated **end to end**, so the
instruction is simply *never hand-edit this file*. You cannot get it half right.

**Most documents are not like that.** Any document a thread route-tags carries a
generated section partway down, under an authored one — 128 of them at the time
of writing, and the count only grows:

```bash
git grep -l 'Thread excerpts — route-tagged log' HEAD -- '*.md' | wc -l
```

The rule for those is conditional — *edit above this line, never below it* — and
a conditional rule is one you can follow by accident and break by accident. This
tutorial walks through breaking it.

## What happened

While widening the [`deduplication`](/beliefs/glossary/deduplication.md) glossary
entry (`em:f17e05`), the goal was to add a paragraph saying that dedup in this
brain is an `/intake` step and that governance artifacts have no equivalent.

The file was read, a sentence about dedup's scope was located, and a paragraph
was inserted immediately after it:

```
So dedup isn't about the news feed's two dedup passes (those drop items
already surfaced). It's the *intake-side* question: "does a home for this
already exist in the bundle?"
```

That reads exactly like body prose. It is a well-formed sentence about the
term, in the voice of the entry, saying something true.

It is not body prose. It is a **quotation**, lifted verbatim from a frozen
thread and reproduced inside the entry's generated excerpt log. The paragraph
was inserted into a block the tooling owns.

## The shape of the file

Here is the boundary in the document that was edited, by line number as it
stands today (the fix added a paragraph, so the numbers sat lower at the time):

```
 1  ---
    …frontmatter…
16  ---
18  # deduplication                    ┐
    …definition…                       │  AUTHORED — edit here
31  *Seen in:* …                       ┘
33  ## Thread excerpts —               ┐
        route-tagged log               │
37  ### 2026-07-12-news-auto-          │  GENERATED — never edit
        intake-featured-items          │
41  **[`em:f17e05`]**                  │
47  …verbatim thread excerpt…          ┘
```

The authored half runs from the `# heading` to the `*Seen in:*` line. Everything
from `## Thread excerpts — route-tagged log` to end-of-file is written by
`mix brain.route_tags --materialize` from the `<routes ref="em:f17e05">` regions
of every thread that tagged this matter.

The [route-tagging policy](/meta/policy/route-tagging.md) is explicit that "the
section is **generated, not hand-kept**". The trap is not that this is
undocumented. The trap is that **the boundary is invisible to a text search.**
An edit anchored on a matched string does not know which side of line 33 it
landed on — and because the log quotes prose *about the same subject as the
entry*, the two halves read alike.

This is worth stating as its own hazard: the excerpt log is, by design, full of
sentences that sound exactly like the document they were filed into. That is
what makes it useful, and that is what makes it easy to edit by mistake.

## What the gate does

The pre-commit hook and CI both run `mix brain.route_tags`. One of its five
checks is **log fidelity**, and it does not inspect the block for plausibility —
it regenerates it and compares:

```elixir
divergent =
  for {t, sink} <- feeding_pairs(threads),
      block = get_in(sinks, [sink, :blocks, t.slug]),
      block != nil,
      regions = Enum.filter(t.regions, &(sink in doc_refs(&1.refs))),
      normalize(block) != normalize(derive_block(sink, t, regions)),
      do: "#{sink}: block for #{t.slug} diverges from its re-derivation from the tags"
```

For every (thread, sink) pair, it re-derives what the block *should* contain
from the thread's current tags and compares it to what is on disk. Any
difference is a failure. The commit was refused with:

```
[FAIL] log fidelity: em:f17e05: block for 2026-07-12-news-auto-intake-featured-items
       diverges from its re-derivation from the tags
Route-tag verification FAILED.
```

Note what the message gives you: the sink id, the thread whose block diverged,
and the reason. That is enough to locate the edit without re-reading the diff.

This is a **failing** check, not a warning — unusual for this repo, which keeps
most editorial checks advisory. It can be blocking precisely because it has a
perfect oracle: the correct content is computable, so there is no judgment call
and no false positive to train agents into ignoring.

## The two failures it prevented

Not one bug. Two, and the second is the nastier.

**A falsified record, immediately.** The excerpt is a verbatim quotation of what
a session actually said, frozen at capture. Editing it makes the brain's record
report words no session ever produced. The document would still verify, still
render, still read fluently — it would simply be *wrong about history*, in a
corpus whose entire value proposition is that its history is trustworthy. No
link check or schema check would ever notice.

**A silently discarded edit, later.** The next time anyone ran
`mix brain.route_tags --materialize` — a routine step in `/capture`, run in most
sessions — the block would be rewritten from the thread tags and the inserted
paragraph would vanish without a trace or a message. So the intended
improvement to the glossary would have been lost too, some days later, with
nothing connecting the disappearance to the original edit.

Falsify the past now, lose the present later. Both from one plausible-looking
insertion.

## The fix

Two motions:

1. **Move the paragraph into the authored half** — above the `*Seen in:*` line,
   where a body paragraph belongs.
2. **Regenerate**: `mix brain.route_tags --materialize`, which rewrites the log
   section from the thread tags and discards the corruption.

Then re-verify:

```
[ok  ] log fidelity: 125 materialized block(s) match their re-derivation from the tags
```

(The block count climbs as threads are captured — what matters is that every
one of them matches, not the number.)

Nothing shipped wrong, and total cost was about two minutes — because the
failure was caught at the earliest possible moment by something that could not
be talked out of it.

## How to edit one of these safely

**Check for the boundary before you anchor.** If the document contains
`## Thread excerpts — route-tagged log`, it has one, and everything from that
heading down is off limits:

```bash
grep -n 'Thread excerpts — route-tagged log' <file>
```

**Then confirm your anchor sits above it.** In this file the sentence that was
anchored on sits at line 47 and the heading at line 33 — the whole mistake, in
two line numbers:

```bash
grep -n '<your anchor text>' <file>
```

**Prefer anchoring on structure over prose.** `*Seen in:*` and the `# heading`
are unambiguously body; a sentence is not. Inserting relative to a structural
marker cannot drift into the generated half.

**Beware whole-file replacement.** An edit that replaces *every* occurrence of a
string is especially dangerous here, because a phrase in the body may well also
appear in a quotation below — the log exists to collect prose on this exact
subject. One intended edit, one silent corruption.

**To change what the log says, change its source.** The block is downstream of
the thread's `<routes>` tags. If an excerpt is wrong, the tag is wrong: fix the
tag in the thread, rematerialize, and the log follows. Editing the block itself
is always the wrong move, even when the block itself is what looks wrong.

## The general lesson

A file generated end to end is easy to respect, because the rule has no
exceptions to remember. A file with a boundary partway down asks every reader
and every tool to know where that boundary is, and a text-matching edit
structurally cannot.

The brain's answer is not to demand more care. It is to make the boundary
**mechanically enforced**, so that carelessness costs a failed commit rather
than a corrupted record — which is the same reasoning that makes
[the gate suite](/meta/tutorials/the-gate-suite-and-where-it-runs.md) worth its
upkeep, and the same argument the
[coding standards](/meta/policy/elixir-coding-standards.md) make for turning
every standard with a mechanical oracle into a gate.

The incident is a small proof that the reasoning holds. An agent with the policy
in its context, that had just spent a session reasoning about generated
artifacts and staleness, still made this edit. Knowing the rule was not enough;
the check was.

## See also

- [route-tagging](/meta/policy/route-tagging.md) — the policy defining the tags,
  the log, and the verifier that owns it
- [The gate suite and where it runs](/meta/tutorials/the-gate-suite-and-where-it-runs.md)
  — every check, and which surface runs it
- [The tooling architecture](/meta/tutorials/the-tooling-architecture.md) —
  where `ElixirMind.RouteTags` sits in the parse → scan → generate → publish
  pipeline
