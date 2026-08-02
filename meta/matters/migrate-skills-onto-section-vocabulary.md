---
type: matter
title: "Migrate the 18 skills onto the section vocabulary"
description: Apply the ratified vocabulary to every SKILL.md — add ## Purpose over the existing lede in all 18, rename Rules and Notes to Guardrails in three, fold capture's build section into Procedure, and demote scope-unit-of-work's six numbered top-level steps beneath one Procedure heading.
status: open
model: Claude Sonnet 5
plan: /meta/plans/skill-section-vocabulary.md
order: 2
provenance: "Claude Opus 5, scope-unit-of-work form-evaluation session"
tags: [meta, matter, skills, vocabulary, migration]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, scope-unit-of-work form-evaluation session"
  why: "the corpus must conform before the conformance gate joins CI, or the gate's own matter lands red"
  from: [/meta/threads/2026-08-02-skill-body-layout-ab-and-section-vocabulary.md]
---

# Migrate the 18 skills onto the section vocabulary

Mechanical application of
[the ratified vocabulary](/meta/plans/skill-section-vocabulary.md) across
`.claude/skills/*/SKILL.md`. Runs **after** matter 1 so the policy exists to
cite, and **before** matter 3 so that gate joins CI green.

**The full change set** — derived by fence-aware survey at `075dc82`, re-derive
against `HEAD` before starting
([structured-plan-bodies](/meta/policy/structured-plan-bodies.md) refresh rule):

| Skill | Change |
|---|---|
| all 18 | insert `## Purpose` above the existing lede prose |
| `capture` | `## Rules` → `## Guardrails`; `## Build the doc, in this order` → `## Procedure` |
| `render-contract` | `## Rules` → `## Guardrails` |
| `priorities` | `## Notes` → `## Guardrails` |
| `scope-unit-of-work` | its six numbered top-level `##` steps become `###` beneath one `## Procedure` |

**Decisions already made:**

- **Add the heading; do not rewrite the prose beneath it.** Every skill already
  opens with purpose prose — this matter gives it a name, nothing more. Rewriting
  ledes would smuggle content changes into a mechanical sweep and destroy the
  reviewability that makes it one PR.
- **`capture` is the only skill needing two structural edits**, and its
  `## File` / `## Frontmatter` / `## After writing` sections stay as they are —
  they fall in the free tier, which the gate permits.
- **No skill is renamed, no skill's `description` frontmatter changes** —
  identity is canonical in `SKILL.md` per
  [compile-skills-registry-from-skill-frontmatter](/meta/plans/compile-skills-registry-from-skill-frontmatter.md)
  and out of scope here.

**Watch for:** `capture/SKILL.md` contains heading-like lines *inside code
fences* (`## Routing`, and `# pr: <N>` in a fenced frontmatter example). They are
example content and must not be touched. A blind `sed` over `^## ` will corrupt
them.

**Verify:** `mix brain.verify` and the full gate suite. The skills registry
compiles from frontmatter, not bodies, so no contract change should result —
if `mix brain.contract --check` reports drift, something was edited that
shouldn't have been.

## Model

`Claude Sonnet 5` — well-specified execution against a fully decided mapping
table, with no open judgment: every edit is named above, and the gate suite plus
`mix brain.contract --check` bear the correctness burden. All four independent
scopings agreed on this stamp — the only unanimous one in the set. It is also
the first matter to land squarely in the roster's new **governance-prose row**
(skill bodies, index glosses, register rows → Sonnet by default), which replaces
the strained reading the earlier runs had to make: nothing mechanically checks a
`SKILL.md`'s prose, so Sonnet's "gated by the suite" qualifier did not literally
apply until that row existed.
