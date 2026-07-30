# Elaborations

Persisted expansions of technical phrases and short passages, produced by
[`/elaborate`](/.claude/skills/elaborate/SKILL.md). Each doc quotes its target
phrase, then unpacks it in three parts: a jargon-free restatement, definitions
of the terms it uses (linking [`/beliefs/glossary/`](/beliefs/glossary/index.md) files and
defining concepts rather than re-inventing them), and a less technical
walkthrough of the concepts and actions described.

Each elaboration is a `type: elaboration` doc in the governance namespace (no
`em:` id). Once the session that prompted it is captured, the doc carries a
**`thread`** frontmatter field back-linking the persisted thread under
[`meta/threads/`](/meta/threads/index.md) — set by
[`/create-pull-request`](/.claude/skills/create-pull-request/SKILL.md) after
its `/capture` step, so every elaboration can be traced to the conversation
that needed it.

Distinct from the sibling genres: a [`glossary`](/beliefs/glossary.md) entry defines
one *term*, source-independent; a [`tutorial`](/meta/tutorials/index.md)
explains a standalone subject long-form; an elaboration unpacks *one specific
mouthful in its context*.

## Contents

- [RPC-driving shines at interrogation rather than editing](/meta/elaborations/rpc-interrogation-as-sensor.md) —
  unpacks why agent control of a live editor over its RPC socket pays off as a
  read channel (querying LSP diagnostics and editor state as a sensor) rather
  than a write channel, and why the read half is the part likely to be absorbed
  into the mainstream agent↔editor bridges.
- [it's scriptable (so it integrates with agents rather than embedding a chatbot UI)](/meta/elaborations/neovim-scriptable-agent-integration.md) —
  unpacks the scriptability clause from the 2026-07-30 Neovim staying-power
  answer: why an editor with a programmable surface (Lua + RPC socket) lets
  coding agents plug in as external clients, versus editors that embed an AI
  chat panel as a vendor-shipped feature.
- [two-directional materialize with unconditional orphan-block removal](/meta/elaborations/two-directional-materialize.md) —
  unpacks the P1 work-package phrase from the code-review hardening plan: the
  route-tag log materializer removing generated content whose source tags
  vanished, automatically and without a flag (proposed 2026-07-11, built
  2026-07-12).
- [The crossing signal: the first query real work produces that grep plus generated indexes cannot express](/meta/elaborations/crossing-signal-learned-from-real-demand.md) —
  unpacks the derived-views doctrine's crossing-signal sentence: what makes a
  query inexpressible in the file-plus-index architecture, and why the doctrine
  waits for a real one instead of constructing a test.
