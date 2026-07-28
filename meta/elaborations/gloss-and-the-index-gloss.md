---
type: elaboration
title: "gloss, glossary, and the `index.md` gloss"
description: Unpacks the terminology passage distinguishing the general sense of "gloss" (a short explanatory note) from this bundle's contract-native sense (the one-line description after a link in an index.md), and from an index file's own header prose.
provenance: "Passage composed by a Claude Code agent in the 2026-07-28 gloss-terminology session and pasted back for decomposition; expansion agent-authored via /elaborate, 2026-07-28. Etymology checked against etymonline.com."
tags: [elaboration, terminology, glossary, index, contract, okf]
timestamp: 2026-07-28
attribution:
  when: 2026-07-28T19:37:29Z
  channel: agent-authored
  agent: "Claude Code agent, /elaborate"
  why: "operator asked for a term-by-term decomposition of the passage defining gloss in the contract's sense"
---

# gloss, glossary, and the `index.md` gloss

> "A gloss is a brief explanatory note attached to something else: a short
> definition or paraphrase set beside a term or passage. Historically, marginal
> or interlinear annotations in manuscripts. A glossary is a collection of
> glosses — both from Greek glōssa (tongue/language), so they share a root, but
> "gloss" isn't an abbreviation of "glossary". […] In this repo I was using it
> in the contract's own sense: the one-line description that follows a link in
> an `index.md`. […] Everything after the em dash is the gloss."
> — agent message, 2026-07-28 session on gloss terminology

## In plain terms

A gloss is a note someone writes next to a word or sentence to say what it
means — the kind of thing scribes once squeezed into the margin of a page or
between its lines. A glossary is a set of those notes gathered up in one
place, usually at the back of a book. The two words are relatives, not
shorthand for each other: the longer one was built out of the shorter one, so
"gloss" is not a clipped "glossary".

This repository borrows the word for a particular small thing. Every folder
has a listing file, and each line of that listing is a link to something plus
a short phrase saying what it is. That short phrase is what the passage calls
a gloss, and the repository's own rulebook already uses the word that way in
two of its rules — the word was taken from the rules, not made up on the spot.

The last part of the passage clears up a slip. Two different pieces of text
describe a folder: the paragraph at the top of the folder's *own* listing
file, and the one-line phrase about that folder in its *parent's* listing.
Only the second one is a gloss. An earlier argument in that session had quoted
the first while calling it the second.

## The terms

- **gloss (general sense)** — a brief explanatory note attached to a specific
  word or passage: a definition, translation, or paraphrase supplied because
  the original is obscure, foreign, or technical. The word entered English
  through Late Latin *glossa*, "an obsolete or foreign word" needing
  explanation, from Greek *glōssa*, literally "the tongue" and by extension
  "language, a word of a language" (etymonline, *gloss* n.2). Note the
  homograph: the "shine, lustre" *gloss* is an unrelated word of Scandinavian
  or Dutch origin, cognate with *glow* (etymonline, *gloss* n.1) — the
  "superficial polish" reading of "glossing over" belongs to that one, and
  bleeds into the explanatory sense only by folk association.

- **marginal / interlinear annotation** — the two physical positions a
  manuscript gloss occupied. *Marginal*: written in the blank margin beside the
  text. *Interlinear*: written in the space between two lines, directly above
  the word it explains — the standard form for word-by-word translations of
  Latin scripture into a vernacular. The distinction is one of placement, not
  of function; both are glosses.

- **glossary** — a collection of glosses. First attested mid-14c., from Latin
  *glossarium*, "collection of glosses", from Greek *glossarion*, a diminutive
  of *glōssa* (etymonline, *glossary*). The derivation runs *gloss* → *glossary*
  (root plus the Latin `-arium` "place where things are kept" suffix), which is
  precisely why the passage's negative holds: a word cannot be an abbreviation
  of a word derived from it. In this bundle *glossary* also has a
  [repo sense](/beliefs/glossary/index.md) — the per-term `concept` documents
  under [`/beliefs/glossary/`](/beliefs/glossary/index.md), one file per term,
  maintained by [`/add-to-glossary`](/.claude/skills/add-to-glossary/SKILL.md).
  A glossary entry there and an `index.md` gloss are different artifacts that
  happen to share a root: the entry defines a *term* source-independently; the
  gloss describes *one linked document* in one listing.

- **`index.md`** — a [reserved filename](/meta/policy/reserved-filenames.md) at
  any directory level: the directory listing that makes the tree navigable
  level by level. The contract specifies its structure as "Markdown sections
  with bulleted links + one-line descriptions" and gives it **no frontmatter**
  (except the bundle-root one, which carries only `okf_version`). Those
  "one-line descriptions" are the things the two prose policies call *glosses*
  — the schema names the slot, the prose rules name the content.

- **progressive disclosure** — the reason `index.md` files exist. A reader or
  agent entering at `/index.md` sees only top-level domains, descends into the
  one that matches, and sees that level's contents, rather than being handed
  the whole tree at once. It is the mechanism behind
  [tree is the taxonomy](/beliefs/glossary/tree-is-the-taxonomy.md): the
  hierarchy plus its listings *is* the canonical taxonomy, so no separate map
  is maintained alongside it — and the gloss is the payload that makes each
  descent decision possible.

- **em dash (—)** — the punctuation mark separating the link from its gloss in
  every listing line. It is load-bearing here only as a delimiter: "everything
  after the em dash" is an operational way of pointing at the gloss, not a
  claim about typography.

- **bundle-absolute path** — the link form inside the quoted line
  (`/knowledge/SWE/agentic/index.md`): a path beginning at the bundle root
  rather than relative to the current file, per
  [filenames-and-cross-linking](/meta/policy/filenames-and-cross-linking.md).
  See [bundle-absolute link](/beliefs/glossary/bundle-absolute-link.md).

- **"the contract's own sense" / contract-native** — the
  [operating contract](/beliefs/glossary/operating-contract.md) is the root
  `CLAUDE.md` every agent auto-loads at session start. It is a
  [compiled contract](/beliefs/glossary/compiled-contract.md), generated from
  `meta/preamble.md` and the `type: policy` documents under `meta/policy/` by
  `mix brain.contract`. Calling a term *contract-native* asserts it is already
  in that binding text — so an agent using it is applying vocabulary it was
  handed, not coining one. The claim is checkable: `gloss`/`glosses` appears in
  the compiled `CLAUDE.md` at the two scope lines quoted below.

- **[provenance-lives-in-metadata](/meta/policy/provenance-lives-in-metadata.md)**
  — the policy holding that a document's sourcing lives in frontmatter
  (`provenance`, `attribution`) and must not be restated in prose. It binds the
  gloss explicitly: no "from the first journal entry", no "distilled from
  thread X" — "and none in the `index.md` gloss that lists the doc". That
  sentence is the passage's first citation, and it is the term's usage in a
  *scope* clause: the policy is naming the gloss as a surface it governs.

- **[negate-only-explicit-cases](/meta/policy/negate-only-explicit-cases.md)**
  — the policy holding that a negative statement ("no X", "never Y") earns its
  place only when the case it rules out is explicit. Its scope line reads
  "Document bodies, index glosses, and agent responses alike". Same role as the
  citation above: the plural *index glosses* is used without definition, which
  is what makes it contract-native rather than improvised — the contract treats
  the reader as already knowing the word.

- **header prose (of an `index.md`)** — the title and free paragraph at the top
  of a listing file, before its `## Contents` section. In
  [`design-rationale/index.md`](/knowledge/knowledge-management/design-rationale/index.md)
  this is the paragraph beginning "Capturing the *why* behind design
  decisions…". It is the directory describing *itself*, at whatever length it
  needs; it is not a gloss.

- **parent index** — the listing one level up, which is where a directory's
  gloss actually lives. `agentic/`'s gloss is the line in
  [`knowledge/SWE/index.md`](/knowledge/SWE/index.md); `design-rationale/`'s is
  the line in `knowledge/knowledge-management/index.md`. A directory is
  glossed *by its parent*, never by itself.

## What's actually happening

The passage does three things in sequence.

**First, it settles the ordinary meaning and its etymology.** A gloss is an
annotation — historically written into a manuscript beside or above the words
it explains — and a glossary is a gathered collection of such annotations.
Both descend from Greek *glōssa*. The specific claim being denied is a natural
but wrong inference: that "gloss" is casual shorthand for "glossary", the way
"app" is for "application". The derivation runs the other direction — Latin
took *glossa* and added the `-arium` suffix to name a place where glosses are
collected — so the shorter word is the parent, not a clipping of the child. One
qualification the passage compresses: in the lexicographic line, *glōssa*'s
operative sense is already the specialized "obsolete or foreign word", not the
literal "tongue". "Tongue/language" is the root sense from which that
specialization grew, so the parenthetical is right about the origin while
skipping a step.

**Second, it names which sense was in play.** The agent had used "gloss" of a
repository artifact, and the passage points at the exact one: in each folder's
`index.md`, every content line is a bulleted link followed by an em dash and a
short phrase. That trailing phrase is the gloss. The example line is lifted
verbatim from `knowledge/SWE/index.md`, where the folder `agentic/` is listed
with the phrase "AI agents, their runtimes, vendors, and the practices they
change".

The passage then defends the word choice, and the defence is the substantive
part. Under
[prefer-established-terminology](/meta/policy/prefer-established-terminology.md),
a bespoke coinage is a tax — it has to be learned and glossaried, and an agent
meeting it cold will guess its meaning from the nearest standard term anyway.
So the question "did you improvise this?" has real stakes. The answer is
evidential: two policies already use the word in their **scope** clauses,
declaring what surfaces they govern. `provenance-lives-in-metadata` bans
sourcing prose "in the `index.md` gloss that lists the doc";
`negate-only-explicit-cases` applies to "Document bodies, index glosses, and
agent responses alike". Neither defines the term — both assume it. Since these
policies are compiled into `CLAUDE.md`, every agent loads that usage at session
start, which is what makes the sense *contract-native*: it arrives with the
rules rather than being invented per session.

**Third, it retracts a misreading.** Earlier in that session an argument was
made about "the cluster it leaves behind" — that argument itself is not in the
pasted excerpt, so what is being corrected is the *evidence* it cited, not its
conclusion. The correction is a category fix between two texts that both
describe a directory:

| Text | Where it lives | What it is |
|---|---|---|
| header prose | at the top of the directory's **own** `index.md` | the directory describing itself, paragraph-length |
| gloss | the **parent** directory's `index.md`, after the em dash | one line, describing this directory as one option among siblings |

The earlier argument had quoted `design-rationale/index.md`'s opening
paragraph while calling it a gloss. Both texts describe the same directory,
which is what makes the confusion easy — but they answer different questions
and are held to different standards. Header prose orients a reader who has
already arrived; a gloss must be short and discriminating enough to let a
reader who has *not* arrived choose between siblings at a branch point. That
is the progressive-disclosure job, and it is why the distinction is worth
keeping straight rather than treating the two as interchangeable descriptions.
