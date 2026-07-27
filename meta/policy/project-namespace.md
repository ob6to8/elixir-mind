---
type: policy
title: The projects namespace
description: Systems built outside this repo get a `type: project` hub under `/projects/`, with project-specific design in a sibling directory and every generalizable finding filed to the knowledge taxonomy instead — so research done for a project accrues to the brain rather than to one repo.
section: directory-structure
order: 4
status: active
tags: [meta, governance, projects, taxonomy, namespace]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-ratified in session"
  why: "operator ratified a home for the long-idle `project` type so external-system specs can incubate here without duplicating research across repos"
---
**A system built outside this repo still incubates here.** Specs, research, and
design decisions for an external system are filed as a `type: project` hub under
[`/projects/`](/projects/index.md), so the knowledge accrues to the brain while
the system is still forming — and does not have to be re-derived once it breaks
out into its own repository.

**Shape** — hub doc beside a directory, mirroring the
[glossary](/beliefs/glossary.md) pattern:

```
projects/<slug>.md        # type: project — the hub: charter, status, links out
projects/<slug>/          # supporting docs: architecture, threat model, plans
projects/<slug>/index.md  # reserved listing
```

The hub is a **bundle document** — it carries an `em:` id and `attribution` like
any other, because the id is exactly what survives the eventual break-out to
another repo when the path will not. It carries a `status`
(`incubating` · `active` · `broken-out` · `dormant` · `abandoned`).

**The split rule — this is the whole point.** Every finding produced while
working a project is filed by *what it is*, not by *what prompted it*:

| The finding is… | Files to | Test |
|---|---|---|
| true regardless of this project | the knowledge taxonomy, with an `em:` id | a model's parameter count; an attack class; how a protocol works |
| true only *for this system* | `projects/<slug>/` | why *this* system chose *that* model; its threat model; its build order |

The hub **links out** to the knowledge documents rather than restating them.
Research done for a project therefore pays twice — once into the project, once
into the taxonomy where the next project reads it instead of re-researching —
and duplication is prevented at the point of filing rather than reconciled
later. This is
[fit each layer to its purpose](/meta/doctrine/fit-each-layer-to-its-purpose.md)
applied across the project/knowledge boundary.

**Project-scoped design records stay in the project.** A `type: plan` for an
external system lives at `projects/<slug>/`, not
[`meta/plans/`](/meta/plans/index.md): `meta/` governs *this brain*, and a
design record for something built elsewhere is not governance of the brain.
[persist-plans](/meta/policy/persist-plans.md),
[structured-plan-bodies](/meta/policy/structured-plan-bodies.md), and
[plan-vs-capture](/meta/policy/plan-vs-capture.md) bind such a plan unchanged —
only its address differs.

**Break-out is the success condition, not an exit.** When a project graduates to
its own repository, `projects/<slug>/` is what ports; the knowledge documents it
cites stay here and keep serving every other project. Mark the hub
`status: broken-out` and record where it went — the hub remains the brain's
durable pointer to a system it no longer holds.
