---
type: analysis
title: Top-down code review + documentation staleness audit (2026-07-11)
description: A full review of the Elixir toolchain (lib, mix tasks, tests, CI, hooks, skills) cross-referenced against every documentation surface for staleness — verdict, the confirmed findings and their fixes, the minor observations left as notes, and the five flow docs the review produced as a byproduct.
provenance: "Claude Code session, 2026-07-11 — operator-requested top-down review; staleness sweep partly delegated to a parallel read-only subagent, every reported finding independently re-verified"
tags: [meta, analysis, code-review, staleness, tooling, flows]
timestamp: 2026-07-11
---

# Top-down code review + documentation staleness audit (2026-07-11)

**Question.** Is the toolchain correct, and does the documentation still
describe the system that actually exists? (Byproduct mandate: think in terms
of `meta/flows/` and document undocumented flows along the way.)

**Verdict.** The system is in unusually good health. All gates were green at
review start (79 tests after this review's addition; verify, contract,
registry, route-tag checks all pass), every "generated, never hand-kept"
artifact matched its re-derivation, and the three tutorials' concrete claims
about exclusion lists, check counts, and workflow steps match the code
exactly. The review confirmed **two code defects** (one fixed, one filed as an
issue), **one code-vs-policy contradiction** (fixed), and **three stale doc
claims** (fixed). Everything else surveyed — README, `meta/index.md`, both
existing flow docs, the skills registry, glossary counts, plan/issue statuses,
registry header — checks out against the code as of `d830fd9`.

---

## 1. Confirmed findings and their dispositions

### F1 — Markdown renderer: link syntax inside a code span rendered live (fixed)

`SecondBrain.Markdown.inline/2` extracted **links before code spans**, so
inline code that *displays* link syntax — `` `[route tag](/glossary/route-tag.md)` ``
— rendered as a live `<a>` inside `<code>` instead of staying literal.
Reproduced against the live renderer; affected real pages (the glossary hub,
`glossary/index.md`, the compiled contract, `filenames-and-cross-linking` and
`routing-ledger` policies, two skills). The existing "markdown inside a code
span is left literal" test only covered emphasis.

**Fix:** extract code spans first and restore them last
([markdown.ex](/lib/second_brain/markdown.ex), `inline/2`); a link label
containing a code span still works because the label's code placeholder
survives link extraction. Regression test added
([markdown_test.exs](/test/second_brain/markdown_test.exs), "link syntax
inside a code span is left literal").

### F2 — `mix brain.evidence` contradicted the grounding policy (fixed)

For a concept with no `verified_by` but a `resource`, the task printed
"**Grounded directly by resource:** …" — the exact claim
[verification-grounding](/meta/policy/verification-grounding.md) rejects ("a
statement is never grounded by its own link; storing a link proves nothing").
The verifier enforces the policy correctly; only the narrative output
contradicted it. **Fix:** the note now reads "Capture — stores resource: …
(trusted evidence, not a verifiable statement)."
([brain.evidence.ex](/lib/mix/tasks/brain.evidence.ex)).

### F3 — `materialize` cannot remove orphaned excerpt blocks (filed, open)

When a sink loses its **last** feeding thread, `run_checks/1` rightly fails on
the orphan block, but `--materialize` never visits unfed sinks, so no tool
path clears it — the only remedy is the hand-edit the section header forbids.
Filed with reproduction and a design direction as
[route-tags-materialize-leaves-orphan-blocks](/meta/issues/route-tags-materialize-leaves-orphan-blocks.md);
not fixed inline because whole-section deletion is a design decision
(interacts with freeze-on-resolution, which is editorial today).

### F4–F6 — Stale documentation claims (all fixed)

- **F4** [`render-contract` skill](/.claude/skills/render-contract/SKILL.md)
  listed 6 valid contract sections; `contract.ex` defines **8** (`verification`
  and `session-workflow` were missing — both live, holding 5 policies between
  them). A policy authored per the skill's list would have looked invalid.
- **F5** [why-the-toolchain-runs-offline](/meta/tutorials/why-the-toolchain-runs-offline.md)
  said the SessionStart hook "runs `mix brain.contract`"; the hook runs
  `mix compile` to warm the cache and only *mentions* `brain.contract` in its
  ready message. The offline argument stands; the named command was wrong.
- **F6** [`meta/flows/index.md`](/meta/flows/index.md) still contrasted the
  genre against "`specs`" — the genre renamed to `plans` when spec/plan were
  unified.

One dangling reference was left deliberately: root `log.md`'s historical entry
linking `/meta/session-workflow.md` (deleted in the flows collapse) — frozen
log entries stay as written per the repo's own convention.

---

## 2. Minor observations (noted, no action)

Code — all defensible as-is, recorded so a future session doesn't re-derive
them:

- `Frontmatter` supports only inline `[a, b]` lists, not dash lists — by
  design (the schema says "inline YAML list"), but nothing *rejects* a dash
  list; it silently parses as no value for the key. Tolerable under
  tolerant-consumer, worth remembering when hand-writing frontmatter.
- The verifier does not restrict `verified` to statement types
  (`claim`/`note`/`concept`) — a resource-less `source` marked
  `verified: true` with edges would pass. The policy's type restriction is
  editorial today; the enforced invariants (capture ≠ verified, verified ⇒
  evidence) are the load-bearing ones.
- `RouteTags.parse_log_section/1` ends a section at the next `## ` heading
  while `replace_section/2` ends at `#` *or* `##` — an h1 immediately after a
  log section would be read as part of the blocks by one and preserved by the
  other. No concept doc currently does this.
- `ledger_doc_sinks/3` parses *every* pipe-table row in a thread doc, not just
  the `## Routing` section's — a non-ledger table whose 4th column links to a
  concept could produce a spurious warn-level ledger-coverage message. Warn
  only, never fails.
- `mix brain.id` requires `---\n` (LF) at byte 0; a CRLF file parses in
  `Frontmatter` (which normalizes) but would refuse minting. Cosmetic
  asymmetry.
- `mix brain.route_tags`'s closing line says "all check out" even when a
  warn-level result printed above it; the warning is visible either way.
- `Markdown.hr?/1` accepts exactly `---`/`***`/`___` (plus spaced variants) —
  a 4-dash rule renders as a paragraph. No bundle doc uses one.
- `Site.json_string/1` doesn't escape control characters below U+0020 other
  than `\n`/`\r`/`\t`; `plain_text/1`'s whitespace collapse makes this
  unreachable in practice.
- `pages.yml` repeats only the four *bundle-integrity* gates, not `mix test` /
  format — intentional and documented in the gating tutorial; noted because
  the workflow comment says "the same integrity checks CI runs", which is
  precise only on that reading.

Docs/tests — genuinely strong: the scenario-test pattern (in-code fixtures,
structured + targeted assertions, live-bundle guard) is applied consistently;
`route_tags_test.exs` has one red test per failure mode; the escaping
properties are pinned; the generated artifacts are all `--check`-guarded in
CI, the pages gate, and pre-commit.

---

## 3. Byproduct: the flows genre grew from 2 to 7

The review walked every multi-step action of the brain; the five that lacked a
flow doc now have one, each following the genre's three-artifact model and
honest about where its deterministic spine ends:

- [contract-render](/meta/flows/contract-render.md) — fully deterministic;
  judgment lives upstream in ratification.
- [site-build-and-deploy](/meta/flows/site-build-and-deploy.md) — fully
  unattended; the deploy gate makes "live site" ≡ "verified bundle".
- [news-inbox](/meta/flows/news-inbox.md) — almost all judgment; the
  structural guarantee is the registry's namespace exclusion.
- [add-to-glossary](/meta/flows/add-to-glossary.md) — intake's spine, shared
  pin; the judgment layer is extract/dedup/define.
- [create-pull-request](/meta/flows/create-pull-request.md) — a composition of
  capture + glossary + the git/GitHub tail; capture-before-commit is the
  load-bearing ordering.

Both pipelines the flows plan named as anticipated follow-ups (the status note
of [flows-genre-and-scenario-testing](/meta/plans/flows-genre-and-scenario-testing.md))
are among them. The pre-existing flows' naming convention
(`<flow>_scenario_test.exs`) was not retrofitted onto contract/site — their
existing module tests already pin those spines, and the new flow docs say so
explicitly rather than demanding duplicate test files.

**Recommendation.** Two follow-ups worth an operator decision: (1) settle the
orphan-block design in F3 and extend `materialize/1` accordingly; (2) decide
whether the verifier should enforce the statement-type restriction on
`verified` (cheap to add, but it hardens an editorial rule into a gate).
Everything else is healthy; no structural drift found between the contract,
the policies, the tooling, and the tree.
