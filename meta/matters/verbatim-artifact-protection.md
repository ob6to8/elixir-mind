---
type: matter
title: "Protect verbatim artifacts from whole-file regeneration"
description: Document the measured whole-file-rewrite fidelity failure — a Write regenerates every character, so quoted material inside a rewritten file is paraphrased rather than preserved — and scope this brain's implementation of the shared verbatim-integrity specification, since its verbatim surfaces (thread captures, route-tag excerpt logs, quoted sources) have no oracle protecting them today.
status: open
model: Claude Opus 5
provenance: "Claude Fable 5, socrates-genesis session"
tags: [meta, matter, fidelity, verbatim, tooling, gates, write-vs-edit]
attribution:
  when: 2026-08-05T01:30:00Z
  channel: agent-authored
  agent: "Claude Code agent, socrates-genesis session"
  why: "the operator directed filing this as an unsequenced matter after a research spike measured the failure in this repo's sibling and found the brain's own verbatim surfaces unguarded"
timestamp: 2026-08-05
---

# Protect verbatim artifacts from whole-file regeneration

**Deliver:** (a) a filed record of the failure mode and its evidence, and (b) a
scoping of what it would take to build the checksum-verification logic as a
**standalone library** rather than as another bespoke `mix brain.*` task.

## The failure, measured

A whole-file `Write` on an existing document does not preserve the parts it was
not meant to change. There is no byte-copy path in generation: every character
of a `Write` is resampled from context, so any quoted material inside the file
is *paraphrased*, not preserved. `Edit` is structurally different — it performs
string replacement on the file on disk, so untouched bytes never pass through
the model's output at all.

Measured instance (direction repo, `socrates/type-system.md`, 2026-08-04): a
block explicitly labelled "reproduced verbatim as the founding artifact" went
from **1377 → 662 characters, a 52% byte loss**, in a `Write` intended to
preserve it. Lost: embedded instructions, longhand notation, two shorthand
proposals, and an uncertainty note. Blast radius, same file: the `Edit`-based
restore touched **7 hunks confined to one region**; the `Write` touched **15
hunks across the whole file**.

The rule is already stated at the harness level — the
[tools reference](https://code.claude.com/docs/en/tools-reference) says *"For
partial changes to an existing file, Claude uses Edit instead of Write"* — and
it failed anyway, which is the point:
[a natural-language rule is not a gate](/meta/policy/elixir-coding-standards.md).
The same failure is reported publicly in
[claude-code issue #27137](https://github.com/anthropics/claude-code/issues/27137)
(opened 2026-02-20, **closed as not planned**), where a Write dropped a
structural index and the agent's own audit missed it because it checked for
deleted *files*, not lost content *within* files.

## Why this brain is exposed

Three surfaces here are valuable precisely as exact bytes, and a paraphrase of
any of them is corruption that no current check would catch:

- **Thread docs** under [`meta/threads/`](/meta/threads/index.md) — the
  [session-capture](/meta/policy/session-capture.md) policy requires retained
  text be "reproduced verbatim… never summarized or paraphrased."
- **Route-tag excerpt logs** — regions "lifted whole" into sink documents.
- **Quoted source spans** in filed references, governed by
  [quote-primary-sources](/meta/policy/quote-primary-sources.md).

Note the asymmetry that explains why this is rarely anyone's rule: code has an
oracle. A regenerated function is either semantically identical (harmless) or
breaks the build (loud). Prose has no compiler, so drift passes silently. Only
repos that keep verbatim artifacts can learn this lesson.

**Partial coverage already exists, and it is the model for the fix.**
`mix brain.route_tags` re-derives every sink's excerpt log from the current tags
and **fails on divergence** — a working verbatim oracle for one artifact class.
Nothing equivalent guards thread docs or quoted spans.

## What to scope

1. **The library shape.** A protected-region manifest (path + region delimiters
   or line span + content hash) and a verifier that fails on divergence.
   Language and packaging are open — Elixir would fit this repo's gate suite,
   but the operator's stated intent is a *standalone* library usable outside it,
   which argues for a zero-dependency CLI. Decide whether it ships as a
   library + thin task, or a binary the gate shells out to.
2. **Region marking.** How a protected span is declared: sentinel comments,
   frontmatter-declared line ranges, or whole-file protection by path glob.
   Sentinels survive edits; line ranges do not.
3. **Hash discipline.** What is hashed (raw bytes vs. normalized), and how an
   *intended* change to a verbatim region is ratified rather than blocked
   forever — the manifest needs an update path that is deliberate, not routine.
4. **The complementary preventive layers**, and whether any belong here:
   a `settings.json` deny rule (`"deny": ["Write(meta/threads/**)"]`) or a
   `PreToolUse` hook denying `Write` on protected paths — both verified
   available; the hook can explain the refusal to the agent.
5. **~~Whether socrates should host it.~~ Settled 2026-08-05: neither system
   hosts it.** The operator ruled out a dependency in either direction — this
   brain must not bundle to socrates, nor socrates to this brain. The shared
   thing is a **specification** (manifest format, hash discipline, verifier
   contract), implemented natively by each consumer: a `mix` task here beside
   the existing gates, a plugin capability and `PreToolUse` hook there. The
   architectural sketch lives at
   [`design/verbatim-integrity.md`](https://github.com/ob6to8/socrates/blob/main/design/verbatim-integrity.md)
   in the socrates repo; this matter scopes the elixir-mind implementation of
   it. The precedent is OKF: a format this repo implements, not a library it
   imports.

## Notes

Unsequenced by operator direction: filed as a backlog matter, no register row.
The evidence, the four enforcement layers, and the docs citations are held in
the research spike recorded in this session's thread doc.
