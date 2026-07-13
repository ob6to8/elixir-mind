---
id: sb:0b648f
type: concept
title: Glossary
description: Hub for the cross-domain glossary — one concept file per term under /glossary/, accreted from threads, papers, and posts by /add-to-glossary.
provenance: "Agent-distilled definitions; each term's file cites the sources it was seen in"
verified: false
tags: [glossary, terminology, cross-domain]
timestamp: 2026-07-10
---

# Glossary

The hub for the brain's cross-domain glossary. **Each term is its own concept
file under [`/glossary/`](/glossary/index.md)** — with its own `sb:` id,
frontmatter, and *Seen in:* citations — so every definition is individually
linkable: cite a term anywhere (a response, another concept, a thread) as a
bundle-absolute link like `[route tag](/glossary/route-tag.md)` and the link
lands on the definition.

Entries are accreted by
[`/add-to-glossary`](/.claude/skills/add-to-glossary/SKILL.md) from persisted
threads, papers, posts, and filed concepts — one file per term, listed
alphabetically in [`/glossary/index.md`](/glossary/index.md). A term whose
canonical definition lives in a filed concept (or in the operating contract)
gets a [pointer entry](/glossary/pointer-entry.md), not a duplicate
definition; a term that outgrows the glossary
[graduates](/glossary/graduation.md) into the domain taxonomy, its id
travelling with it.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="sb:0b648f">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-10-add-to-glossary-skill-and-pr-wiring (2026-07-10)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`sb:0b648f`]**  (co-feeds: `.claude/skills/add-to-glossary/SKILL.md`)

Built and pushed. The `/add-to-glossary` skill now exists on `claude/add-to-glossary-skill-jz1ewh` (commit `f45940f`), with all verifiers green (`brain.verify`, `brain.route_tags`, contract check, 78 tests passing).

**What it does** (`.claude/skills/add-to-glossary/SKILL.md`): you point it at a persisted thread under `meta/threads/`, a paper or post (URL, pasted text, or PDF), or an already-filed concept. It extracts the technical terms the source actually uses — same selection bar as `/summarize-technical`'s key-terms section, so incidental nouns don't qualify — and merges one-to-three-sentence definitions into a single running glossary at the bundle root.

**Key design decisions**, since your proposal left a couple open:

- **`glossary.md`, not `glossary.json`.** The glossary is a bundle concept like any other (`type: concept`, id `sb:0b648f`), so it flows through `mix brain.verify`/`registry` and the site renderer. JSON would sit outside all of that; the entry structure (alphabetical `##` headings + a *Seen in:* citation line) is regular enough to parse mechanically if tooling ever wants it.
- **One glossary, cross-domain, at the bundle root** — listed under a new "Cross-domain" heading in the root `index.md`. A term seen in three threads and a paper gets one entry with four citations, which is the thing `/summarize-technical`'s per-document glossaries can't give you.
- **Pointer entries instead of duplicates.** A term already canonically defined by a filed concept (or by the operating contract itself, like *route tag*) gets a one-line gloss plus a link, honoring update-in-place/don't-fragment.
- **A graduation path.** When an entry outgrows a few sentences it gets filed as a proper concept via `/intake` and the glossary entry shrinks to a pointer — the glossary is a staging layer, not a terminal home.
- The whole doc stays `verified: false` (agent-authored definitions); individual claims can graduate and get grounded through the normal `verified_by` machinery.

The skill is registered in `meta/policy/skills-registry.md` with `CLAUDE.md` re-rendered via `mix brain.contract`, the empty glossary scaffold is seeded, and both `log.md` and `meta/log.md` carry dated entries. The glossary has no entries yet — a natural first run would be `/add-to-glossary` on the 2026-07-05 bootstrap thread. I didn't open a PR since you didn't ask for one; say the word (or `/create-pull-request`) and I will.

---

**[`sb:0b648f`]**  (co-feeds: `.claude/skills/add-to-glossary/SKILL.md`)

Done — restructured and pushed (commit `b61ee57`, now part of PR #35). Each glossary term is its own concept file under `/glossary/`, so I can now cite definitions exactly the way you described: a response can link [route tag](/glossary/route-tag.md), [pointer entry](/glossary/pointer-entry.md), or [verified_by](/glossary/verified-by.md), and clicking lands on the definition — on GitHub and on the Pages site alike.

How the pieces landed:

- **Seven term files** under `/glossary/`, each a full bundle concept with its own minted `sb:` id, frontmatter, definition, and *Seen in:* citations. `glossary/index.md` lists them alphabetically with one-line descriptions.
- **`/glossary.md` stayed, repurposed as the hub.** It couldn't simply be deleted: it's `sb:0b648f`, the route-tag sink for this session's thread, and it carries the generated excerpt log — ids are immutable and the verifier re-derives that log. So it now describes the system and points into the directory, and all existing links to it still resolve.
- **Graduation got more elegant.** Since every term is already a concept, an outgrown term no longer needs re-filing via `/intake` — the file just *moves* into the domain taxonomy, its id travels with it, and a pointer stub stays at `/glossary/<slug>.md` so old glossary links keep landing somewhere useful.
- **The `/add-to-glossary` skill** was updated to the per-term model (kebab-slug files, per-file merge rules, index upkeep) and gained a "Citing terms in responses" section: link a term's first use in a response, not every occurrence. The skills-registry policy, `CLAUDE.md`, `/create-pull-request`'s step 2, the root `index.md`, and the registry are all in sync, and every gate passes (verify, route tags, contract/registry checks, 78 tests).

One governance note: `glossary/` is a new top-level directory, which the taxonomy protocol normally has me propose rather than create — your message was the proposal and direction here, and the whole shape ships in PR #35 for you to ratify or push back on in review. From here on, just ask for "glossary links" in any answer and I'll cite terms inline; anything I define along the way can be `/add-to-glossary`'d into its own linkable file.

### 2026-07-11-belief-decomposition-analysis-and-epistemic-prior-art (2026-07-11)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`sb:0b648f`]**

Done — both pieces committed and pushed (`9665b73`, all verifiers green). The glossary run over the eight epistemic docs added **29 term files**, taking the glossary from 78 to 107 terms.

**New full entries (20):**

- *TMS cluster:* non-monotonic reasoning, dependency-directed backtracking, well-founded support, environment (ATMS), label (ATMS), nogood, paraconsistency
- *Multi-sense entries:* **justification** and **assumption** — each with numbered TMS / GSN / Toulmin senses, since the same word means structurally different things across the three literatures (the collision the source captures surfaced)
- *Argumentation:* warrant, defeasibility
- *Logic:* entailment (logical consequence), semidecidability, soundness and completeness, description logic, ontology (knowledge representation)
- *Evals:* atomic fact, decontextualization, LLM-as-judge, F1@K

**Pointer entries (9)** — terms canonically defined in the filed references, per the pointer rule: truth maintenance system, Toulmin model, assurance case, Goal Structuring Notation, first-order logic, OWL, FActScore, SAFE, decompose-then-verify. Each gives a one-paragraph gloss and defers to its reference.

**No merges needed** into pre-existing entries — the five terms from earlier today (bipartite graph, ungrounded inference, etc.) already carried the right citations, and nothing in the new docs added a genuinely new sense to older entries.

The **`/summarize-technical` amendment** is also in: key-terms sections now link term names to existing glossary entries while keeping their source-local definitions — codifying exactly the split we agreed on (glossary = cross-domain canonical; key terms = how *this* source uses the word). The new entries' cross-links (e.g. warrant → justification, nogood → minimal inconsistent subset, SAFE → decontextualization → atomic fact) mean the epistemics vocabulary now forms a small connected subgraph of its own, which is fitting.

One scan-worthy spot for you: the multi-sense **justification** and **assumption** entries are where I exercised the most editorial judgment — worth a glance to confirm the sense boundaries read right to you.
