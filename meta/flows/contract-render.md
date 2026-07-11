---
type: note
title: Contract render — compile CLAUDE.md from the policies
description: The end-to-end flow for changing a rule of the brain — edit a type-policy source doc, recompile CLAUDE.md via mix brain.contract, and let the --check gates hold the compiled contract structurally current — the touch-sequence, actor boundaries, the gate suite, and the tests that pin the compiler.
tags: [meta, governance, contract, policy, compilation, flow, workflow]
timestamp: 2026-07-11
---

# Contract render — compile CLAUDE.md from the policies

The connective doc for how the brain's *rules* change: every agent reads
`/CLAUDE.md`, but nobody writes it — it is **compiled** from
`meta/preamble.md` + the `type: policy` docs under `meta/policy/`, and two
`--check` gates keep the compiled artifact from ever drifting from its sources.
This doc narrates that flow end to end; the rules, procedure, and mechanism
have their own homes.

> **The three artifacts (and the sources of truth — point, don't restate):**
> - **Rules** → the policies themselves (`meta/policy/*.md`), plus the
>   [tree-is-the-taxonomy](/meta/policy/tree-is-the-taxonomy.md) policy that
>   declares `CLAUDE.md` the compiled *policy* layer.
> - **Procedure** → the [`/render-contract` skill](/.claude/skills/render-contract/SKILL.md).
> - **Mechanism + proof** → [`SecondBrain.Contract`](/lib/second_brain/contract.ex) /
>   [`SecondBrain.Policy`](/lib/second_brain/policy.ex) and the
>   `mix brain.contract [--check]` task, pinned by
>   [`test/second_brain/contract_test.exs`](/test/second_brain/contract_test.exs)
>   (this flow predates the `*_scenario_test.exs` naming; the contract tests
>   *are* its scenario — render shape, ordering, trace links, and the
>   ok→stale round-trip).

---

## 1. The problem

The operating contract must be one document every agent reads first — but its
rules accrete one decision at a time, each with its own history and rationale.
Hand-editing one big file rots: rules lose their provenance, edits collide, and
nothing catches a contract that silently disagrees with the decision record.
So the rules live as individual `type: policy` documents (one file, one rule,
one trace link) and `CLAUDE.md` is a **generated artifact** — the same
generated-not-hand-kept discipline as `meta/registry.md` and the route-tag
excerpt logs.

---

## 2. The pipeline

```
   a rule changes (operator ratifies; agent edits)
          │
          ▼
   meta/policy/<rule>.md        (type: policy · section · order · body)
   meta/preamble.md             (fixed framing, rendered body-only)
          │  mix brain.contract
          ▼
   CLAUDE.md                    (banner + preamble + 8 numbered sections,
          │                      each policy under its section, in order,
          │                      with a _Source:_ trace link)
          │  mix brain.contract --check     (CI · pages gate · pre-commit)
          ▼
   a stale compile fails the build before it can mislead an agent
```

The **whole pipeline is deterministic** — unusually for a flow, there is no
judgment layer between source and artifact. The judgment lives *upstream*
(what should the rule say? — operator-ratified per the
[taxonomy-evolution protocol](/meta/policy/taxonomy-evolution-protocol.md))
and the compile is pure function of the sources.

---

## 3. The touch-sequence (a canonical run)

| # | Actor | Action | Files touched | Checked by |
|---|-------|--------|---------------|------------|
| 1 | operator | Ratify the rule change (new rule, edit, supersession, new `section`) | — | editorial |
| 2 | agent | Edit or add the policy doc: `type: policy`, `title`, `section` (one of the 8 keys in `contract.ex`), integer `order`, body | `meta/policy/<rule>.md` | tool (loader raises on a missing field, wrong type, or unknown section) |
| 3 | agent | Update `meta/policy/index.md` if a doc was added/renamed | `meta/policy/index.md` | editorial |
| 4 | tool | `mix brain.contract` — load all non-superseded policies, group by section, sort by `(section, order, id)`, render banner + preamble + sections + trace links | `CLAUDE.md` | test (render shape) |
| 5 | tool | `mix brain.contract --check` — byte-compare a fresh render against disk | — (reads) | **tool** + CI |
| 6 | agent | Dated entry in `meta/log.md`; commit the policy source **and** the regenerated `CLAUDE.md` together | `meta/log.md` | editorial |

Steps 4–5 are the spine; CI (`ci.yml`), the Pages deploy gate (`pages.yml`),
and the pre-commit hook all run step 5, so a hand-edited or stale `CLAUDE.md`
cannot land or deploy.

---

## 4. Invariants

- **Never hand-edit `CLAUDE.md`** — it is overwritten on the next compile; the
  edit belongs in a policy doc.
- **Every rule carries its trace link** — each rendered policy ends with
  `_Source: meta/policy/<id>.md_`, so a reader of the contract can always find
  the editable source.
- **Sections are a closed set** — the 8 `{key, heading}` pairs in
  `SecondBrain.Contract.@sections` are canonical; an unknown `section` raises
  at compile time rather than rendering into the void.
- **Supersession, not deletion** — a policy with `status: superseded` stays on
  disk (decision history) but drops out of the compile.
- **Source and artifact ship together** — one commit carries both, so no
  revision of the repo has a contract that disagrees with its sources.

---

## 5. Verify — the gates and what pins the compiler

`mix brain.contract --check` runs in three places: **CI** on every push/PR,
the **Pages deploy gate** (see [site-build-and-deploy](/meta/flows/site-build-and-deploy.md)),
and the **pre-commit hook**. On divergence it prints the first differing line —
enough to see whether the drift is a hand-edit or a forgotten recompile.

[`contract_test.exs`](/test/second_brain/contract_test.exs) pins the compiler:
policies render grouped by section and ordered, with the banner and trace
links; `check/1` round-trips ok→stale after tampering; an unknown section and
a non-policy `type` both raise. The editorial residue is small: whether the
rule's *prose* says what the operator ratified — no machine can check that.
