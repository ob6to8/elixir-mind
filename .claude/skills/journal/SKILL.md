---
name: journal
description: File the operator's dictated or typed daily journal entry — progress, status, insights, todos, observations about this repo's development and its subject matter — as a dated entry under journal/. Use when the operator says "/journal" followed by entry text, "journal this", "add to my journal", or "journal entry". Everything following the invocation is the entry body, kept in the operator's voice.
---

# /journal — the operator's daily journal

Maintain the **journal tier** at [`journal/`](/journal/index.md): dated, first-person
entries by the operator about this repo — development progress and status, conceptual
and organizational insights, to-dos, observations — and about the subject matter the
repo contains (software development and AI). Follow the
[operating contract](/CLAUDE.md).

The journal is the operator's **synthesis practice**: its purpose is that the operator,
not the agent, does the intellectual work of recalling, connecting, and articulating.
The agent's job here is faithful stenography and filing — never summarizing, never
improving the prose, never substituting its own synthesis for the operator's.

`journal/` is a **non-bundle namespace** like `inbox/` and `survey/`: entries carry
**no `em:` id**, are never verified, carry **no `attribution`** (machine-enforced
exempt, like inbox digests — a dated entry is self-describing by construction), and
make no claim on the knowledge taxonomy. Entries are anchored by their date, not by
inbound links (`mix brain.orphans` excludes them by design).

## Dispatch

- `/journal <entry text>` (the default — everything after the invocation is the
  entry body) → **File** (below).
- `/journal list [n]` → **List** the most recent `n` entries (default 7). Read-only.
- `/journal respond` (or the operator asks for a response after filing) →
  **Respond** (below).

---

## File

1. **The body is everything following the invocation.** Do not ask what to include;
   the prompt *is* the entry. If the prompt mixes an entry with separate instructions
   to the agent (e.g. "…that is the end of the journal entry. Now do X"), the entry
   ends where the operator says it ends; the rest is instruction, not journal.
2. **Transcribe faithfully; clean only dictation noise.** Entries are often dictated.
   Fix obvious speech-to-text artifacts — misheard proper nouns, spelled-out numbers
   where numerals are natural, stray filler ("Um,"), typos, transcription glitches —
   and break the text into paragraphs at its natural seams. **Never** rephrase,
   condense, reorder, or editorialize: the entry is the operator's voice, and the
   knowledge-layer distillation rule
   ([capture the knowledge, cite the source](/meta/policy/capture-knowledge-cite-the-source.md))
   does **not** apply here — like thread docs, the journal is a record layer where
   fidelity beats concision. When a cleanup is a judgment call, keep the operator's
   wording.
3. **Ask when the dictation is genuinely ambiguous.** If a passage is garbled
   enough that any faithful reading is a guess — dropped words, a mishearing
   with more than one plausible intent — file the entry with the most
   conservative minimal reading, then flag each such spot to the operator with
   a clarifying question (quote the dictated text and the reading chosen).
   Never silently guess a meaning, and never block filing on the answer:
   correct the entry in place when the operator replies.
4. **One file per day** at `journal/YYYY-MM-DD.md` (today's date — the inherently
   time-ordered case of the filenames policy). If today's entry already exists,
   **append** the new material under a `---` rule inside the same file and bump
   `timestamp` — update in place, don't fragment the day.
5. **Shape:**
   ```
   ---
   type: note
   title: "Journal — YYYY-MM-DD"
   description: <one sentence naming the entry's main threads — written by the agent, the one place summary is allowed>
   tags: [journal, <2–4 topical kebab-case tags drawn from the entry>]
   timestamp: <today, ISO 8601>
   ---

   # Journal — YYYY-MM-DD

   <the entry body, operator's voice>
   ```
   No `em:` id, no `attribution`, no `verified` — ever. `provenance` (e.g.
   "dictated by the operator") is optional and rarely needed.
6. **Cross-link lightly.** Where the entry names a document that already exists in
   the bundle, link it (bundle-absolute path) at first mention — a navigation aid,
   not an edit. Do not create documents, glossary terms, or todos from the entry
   unasked; if an entry contains something that plainly wants to be a
   [`todo`](/.claude/skills/todo/SKILL.md) or an intake, *offer* it after filing.
7. **Maintain reserved files.** Add the entry (newest first) to
   [`journal/index.md`](/journal/index.md): date link + the one-line description.
8. **Verify & report.** Run `mix brain.verify`. Report the path written and any
   cleanups you made that were more than mechanical.

## List

Read `journal/*.md` (skip `index.md`), newest first; render date, description, and
link for the requested count. Read-only.

## Respond

Only when the operator asks (never by default). Unless the operator directs
otherwise, respond in two parts:

1. **Editorial read** — a critical evaluation of the entry's communication style and
   expressivity: what lands, what blurs, how it could be edited or reformulated.
   Honest, specific, quoting the entry; not a rewrite unless asked.
2. **Substantive follow-up** — the agent's own engagement with the entry's ideas:
   extensions, counterpoints, connections to what the brain already holds, questions
   worth carrying forward.

Deliver the response in chat **and persist it verbatim into the same day's file**,
appended below the entry body under a `---` rule and a
`## Response — Claude (YYYY-MM-DD)` heading (demote the response's own headings
beneath it as needed; content stays verbatim as delivered). The delineation is the
rule: everything above the response heading is operator voice; everything below it
is agent voice — never interleave the two. Do not hardcode live or branch URLs into
the persisted response; cite bundle documents by bundle-absolute path.

## Guardrails

- **The operator's voice is inviolable.** No summarizing, no tightening, no style
  fixes beyond dictation noise. Entries are recorded verbatim, with only
  transcription errors fixed. In the entry body, the `description` frontmatter line
  is the only agent-written text; agent responses live exclusively in the marked
  `## Response` section below the entry.
- **Never mint an `em:` id, never add `attribution`** — `journal/` is exempt and
  `mix brain.verify` errors if attribution is present.
- One file per day; append, don't fragment.
- Keep entries OKF-conformant: parseable frontmatter, non-empty `type: note`.
- Never touch `deprecated/`.
