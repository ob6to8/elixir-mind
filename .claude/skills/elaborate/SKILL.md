---
name: elaborate
description: Expand a technical phrase, sentence, or short description — define the terms it uses and give a less technical overview of the concepts and actions it describes. Use when the operator says "/elaborate", "elaborate on that", "what does that mean", "unpack that", or "explain that in plain terms" about a phrase or passage (from the conversation, a doc, a commit message, or pasted text). For a whole paper/article/spec use /summarize-technical; to persist definitions into the glossary use /add-to-glossary.
---

# /elaborate — unpack a technical phrase in plain terms

Take a compact piece of technical language — a phrase, a sentence, a short
passage — and expand it so a reader outside the subfield understands both the
**vocabulary** (what each term means) and the **substance** (what is actually
being described or done). This is the conversational, phrase-scale sibling of
[`/summarize-technical`](../summarize-technical/SKILL.md): that skill breaks
down a whole document; this one unpacks a mouthful.

The output is **chat output** — `/elaborate` files nothing and writes nothing
into the bundle. It is the explain-it-now skill, not a capture skill.

## Input

One phrase or passage per invocation:

- **Pasted text** after `/elaborate` — a sentence from a paper, a commit
  message, a log line, an error, a fragment of documentation.
- **A pointer into the conversation** — "elaborate on that", "what does the
  second bullet mean": resolve to the exact phrase the operator means; quote it
  back so the target is unambiguous.
- **A pointer into the bundle** — a phrase inside a filed concept, thread doc,
  or policy, named by path or quote. Read the surrounding context before
  explaining; the sentence may lean on it.

If the target is ambiguous (several candidate phrases), ask which one rather
than guessing.

## Output structure

Three parts, in this order — scale each to the input (a five-word phrase needs
a few sentences per part; a paragraph may need more):

### 1. In plain terms
One short paragraph restating what the phrase says, using **no jargon at all**
— the register of `/summarize-technical`'s plain-language summary. If a
precise idea needs a technical term, describe the idea plainly here and let
part 2 name it.

### 2. The terms
Each significant technical term in the phrase, defined in one to three
sentences that bridge from what a generalist already knows to the exact term —
the same selection bar and register as
[`/add-to-glossary`](../add-to-glossary/SKILL.md): terms of art, named
methods/metrics/formalisms, and load-bearing concepts; skip plain English used
plainly. In order of appearance in the phrase.

**Check the brain first.** If a term already has a glossary file, link it
inline — `[route tag](/glossary/route-tag.md)` — and keep the in-chat
definition consistent with (or briefer than) the filed one; if it is
canonically defined by a filed concept or the operating contract, link that
instead. Define from understanding, never contradicting what the brain has
already filed — if the filed definition looks wrong, say so rather than
silently diverging.

### 3. What's actually happening
A less technical walkthrough of the **concepts and actions** the phrase
describes: who/what acts, on what, in what order, and why it matters. For a
descriptive phrase this is the mechanism behind the words; for an
action-describing one (a commit message, a pipeline step, a procedure) walk
the steps in sequence. Concrete analogies are welcome when they genuinely map;
label any simplification that loses precision ("roughly", "in effect").

## Procedure

1. **Pin the target.** Resolve exactly which phrase is being elaborated; quote
   it at the top of the reply. Read enough surrounding context (the message,
   the doc section, the diff) to know what the terms refer to *here* — many
   terms are overloaded, and the elaboration must match this usage, not the
   most common one.
2. **List the terms** worth defining before writing anything, and grep
   `/glossary/` (and the registry/concept tree) for each — existing
   definitions get linked, not re-invented.
3. **Write parts 1–3 in order.** Part 1 stays jargon-free; part 3 may use a
   term once part 2 has defined it.
4. **Offer persistence, don't perform it.** If the elaboration produced
   definitions the brain lacks and they seem durably useful, mention that
   `/add-to-glossary` can file them — but only the operator's say-so triggers
   that skill. `/elaborate` itself never touches the tree.

## Guardrails

- **Faithful to the source's meaning in context** — elaborate what the phrase
  actually says, not the general topic it gestures at. If the phrase is wrong
  or misleading, explain what it says *and* flag the problem.
- **No jargon in part 1, ever** — the "just this once" parenthetical is how
  plain summaries rot (same rule as `/summarize-technical`).
- **Link, don't duplicate** — a term the brain already defines is cited by
  bundle-absolute link; the citing-terms convention (link first use, not every
  occurrence) applies.
- **Nothing is filed** — no concept files, no glossary edits, no log entries.
  Persisting any of the output is a separate, operator-invoked `/intake` or
  `/add-to-glossary`.
- Match depth to the input: don't inflate a two-term phrase into an essay, and
  don't compress a dense paragraph into a gloss that skips half its terms.
