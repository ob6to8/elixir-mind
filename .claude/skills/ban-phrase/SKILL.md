---
name: ban-phrase
description: Add an operator-flagged word or phrase to the banned-phrases register in meta/policy/banned-phrases.md and recompile the contract, or list the register. Use when the operator says "/ban-phrase", "ban that phrase", "add that to the banned list", "never say X again", or flags a phrasing as one the agent must stop using.
---

# /ban-phrase — grow the banned-phrases register

Maintain the register in
[`meta/policy/banned-phrases.md`](/meta/policy/banned-phrases.md): the list of
words and phrases banned from agent-composed prose, each entry carrying its
generalized pattern and the reasoning that bans it. The register grows
**organically** — an entry is born when the operator flags a phrase in
conversation, and the operator's invocation of this skill *is* the
ratification. Follow the [operating contract](/CLAUDE.md).

## Dispatch

- `/ban-phrase <phrase> [— reason]` → **Add** (below).
- `/ban-phrase list` → **List** (below).
- Bare `/ban-phrase` right after the operator criticized a phrasing → **Add**,
  deriving the phrase and reason from that exchange.

---

## Add

1. **Derive the entry from the conversation.** The organic case is the
   operator flagging a phrase the agent just used, so the exchange itself is
   the source material:
   - **The phrase** — verbatim, as flagged or as the agent wrote it.
   - **The pattern** — generalize the literal string to the family of
     variants the ban covers ("worth X-ing rather than Y-ing"), so near
     misses are caught.
   - **The reason** — from the operator's criticism, distilled to a sentence
     or two. Keep the operator's argument, not a euphemized paraphrase of it.
     Where the reason instantiates an existing policy (e.g.
     [negate-only-explicit-cases](/meta/policy/negate-only-explicit-cases.md)),
     link it.
   - **The recast** — one clause on what to write instead.
   If any of these cannot be derived from the argument or the conversation,
   ask the operator in chat before filing.
2. **Dedup.** Check the register for an entry whose pattern already covers
   the phrase. If one does, extend that entry (add the variant, sharpen the
   pattern) rather than filing a near-duplicate.
3. **Append the entry** to the `### The register` list in
   `meta/policy/banned-phrases.md`, matching the existing entry shape
   (bold phrase, pattern, reason, recast). Bump the policy's `timestamp`.
   Leave `attribution` untouched — it records the policy's ingestion, not
   each entry's.
4. **Recompile the contract.** Run `/render-contract`
   (`mix brain.contract`) so the new entry binds every future session.
5. **Verify & report.** Run `mix brain.verify` and `mix brain.contract
   --check`. Report the entry as filed, quoting it back.

## List

Read `meta/policy/banned-phrases.md` and render the register to the operator
as-is — phrase, pattern, reason per entry, plus the count. Read-only.

## Guardrails

- **Operator-flagged only.** An agent noticing an ugly phrase proposes a ban
  in chat; it enters the register only on the operator's say-so. The
  invocation is the ratification — no second confirmation pass.
- The register lives in the policy body — there is no sidecar file to drift.
- `CLAUDE.md` is generated: never hand-edit it; always recompile.
- Never touch `deprecated/`.
