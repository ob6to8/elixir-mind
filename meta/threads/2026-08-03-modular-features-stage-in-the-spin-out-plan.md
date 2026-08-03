---
type: reference
title: 2026-08-03-modular-features-stage-in-the-spin-out-plan
description: The operator's à la carte sub-services question answered — feasible, but as manifest feature flags in the one library rather than packages or services — and, on the operator's option-1 pick, the spin-out plan amended with the deferred modular-features stage (feature triples, two riders on Phases 2–3, a second-consumer trigger) and the parent plan's Phase 2 pointed at the spec-structure rider.
provenance: "Claude Code session (Claude Fable 5), 2026-08-03; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, architecture, spin-out, modularity, plans]
timestamp: 2026-08-03
session: https://claude.ai/code/session_01HPhAHEVnjjcNbievKMZRSZ
pr: 247
---

# 2026-08-03-modular-features-stage-in-the-spin-out-plan

## Where this landed

The operator asked whether the mechanism, once spun out into its own repo,
could decompose further into sub-services adoptable à la carte (route-tagging
as the example), naming the formal-definition benefit and the over-engineering
risk. The assessment: feasible, and the codebase is already close — a kernel
plus mutually independent feature modules, with the three composition points
(compiled contract, gate union, skills directory) already in single-tenant
form — but the right shape is manifest feature flags in the one library, not
packages or services, with physical packaging deferred behind a
second-consumer trigger and each feature's formal definition banked in the
Phase 2 metadata-profile spec. The operator picked option 1 (amend the
spin-out plan). Delivery required fast-forwarding the branch through 19 merged
PRs (the todo→matter migration and new session-workflow policies) and
re-auditing at `684530d`, which added `SessionInit` as a second aggregating
reporter and the plans-index timestamp reordering. Landed as commit `cf3f442`:
the deferred modular-features stage in the spin-out plan (feature triples, the
dependency DAG, mechanism-vs-instance per feature, the two riders, open
question 8), the Phase 2 spec-structure rider on the parent plan, and the
reordered index glosses. Closed with `/create-pull-request merge`.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| À la carte modularization of the spun-out library — feature triples, manifest flags, packaging held behind a second-consumer trigger | closed | [library spin-out plan](/meta/plans/library-spin-out-and-dependency-distribution.md) | - |
| Phase 2 metadata-profile spec structured as a core profile plus per-feature extensions | closed | [bundle/library separation plan](/meta/plans/separate-okf-bundle-and-elixir-mind-library.md) | - |

## User

<routes ref="meta/plans/library-spin-out-and-dependency-distribution.md">
this is a long term architectural question - once the mechansim and system is broken out into its own repo (which /knowledge would be a consumer of), would it be possible to further break that down into sub-services that could compile into the meta-structure? if so, this would allow people to adopt aspects of the repo a la carte, ie. for instance the system of route-tagging. this would also force all of the features here to be formally defined. the risk i would imagine could be over-engineering. thoughts?
</routes>

## Assistant

<routes ref="meta/plans/library-spin-out-and-dependency-distribution.md meta/plans/separate-okf-bundle-and-elixir-mind-library.md">
## Assessment

Plain version first: yes, this is feasible, and the codebase is closer to that shape than you might expect — the tooling is already a small kernel plus feature modules that don't reference each other, and the "meta-structure" you'd compile into (the contract, the CI gates, the skills folder) already has exactly the composition points a modular design needs. Where I'd push back is on two words: "services" (nothing here has a runtime — these would be optional *features* of one library, composing at compile/check time) and "further break down into repos/packages" as the near-term move. The à la carte property can be had much more cheaply as feature flags in the per-bundle config, with physical packaging deferred until a second real consumer exists. The formal-definition benefit you name is real, and it can be banked early without paying the packaging cost.

### Where this sits in the existing trajectory

Two ratification-track plans already carry stages one and two: [separate-okf-bundle-and-elixir-mind-library](https://github.com/ob6to8/elixir-mind/blob/main/meta/plans/separate-okf-bundle-and-elixir-mind-library.md) (the bundle/library delineation) and [library-spin-out-and-dependency-distribution](https://github.com/ob6to8/elixir-mind/blob/main/meta/plans/library-spin-out-and-dependency-distribution.md) (the spin-out spec: one library repo, N knowledge-base repos, a `Bundle` manifest struct, git-tag dep then Hex). Your question is a third stage layered on those: modularity *within* the library. The spin-out plan's boundary test already does the heavy conceptual lifting — "a rule a second bundle could legitimately set differently is a manifest field; one it couldn't is profile" — and stage three iterates that same test one level down, per feature instead of per library.

### Feasibility: the code is already plugin-shaped

From a sweep of cross-module references in `lib/` (aliases and qualified calls, this session): the feature modules — `RouteTags`, `Glossary`, `Attribution`, `Contract`, `Site`, `SessionInit`, `Lineage`, `DevHistory` — each depend on a four-module kernel (`Frontmatter`, `Registry`, `Links`, `SiteConfig`) and none depends on another feature module. The one aggregation point is `Verifier` (`verifier.ex:44`), which unions the check sets. So the refactor to core-plus-features is modest: the verifier becomes a check-runner, and each feature registers its checks, its mix tasks, its policy text, and its skills. This is an established architecture with established names — ESLint's core-engine-plus-rules-plus-shareable-configs, or Credo's check registry in Elixir-land — and "compile into the meta-structure" maps onto three composition points that already exist in single-tenant form: `mix brain.contract` composes CLAUDE.md from per-concern policies, CI runs the union of independent gates, and skills are per-name directories.

### The unit of modularity, and the hard boundary

The unit is not an Elixir module. A feature here is a **triple** — a gate (code), a policy (contract prose), and usually a skill (agent procedure) — plus the frontmatter keys it claims. Code and skills package cleanly. Policy text is the awkward member: policies are operator-ratified law, and some carry personal content (the banned-phrases register, the channel vocabulary). The workable posture is the one the spin-out plan already takes for vocabularies — the library ships shape and defaults, the bundle ratifies values — generalized: each feature ships a policy *template*, and an adopter ratifies it (verbatim or amended) into their own `meta/policy/`, from which *their* contract compiles. That preserves the system's premise for adopters too: adopting route-tagging means knowingly ratifying its law, not silently inheriting mine.

Your example is also the instructive one: route-tagging is one of the *deeper* features. Its refs are `em:` ids (`route_tags.ex:222`), it tags thread docs, and it cross-checks the routing ledger — so "just route-tagging" pulls in identity and session-capture as prerequisites. À la carte is real, but the menu is a DAG, not a flat list. Today those edges are implicit in policy prose; making them declared, per-feature, is most of the formalization you're pointing at.

### Over-engineering: where the line actually runs

Cheap now, and pays regardless of whether packages ever ship:

- When the parent plan's **Phase 2** (the versioned metadata-profile spec) is written, structure it as a core profile plus per-feature extensions, each declaring its frontmatter keys, checks, and dependencies on other features. That document *is* the formal definition you want — and it serves adopt-by-reading, which is realistically how the first adopters will consume this (the policies are published; people copy patterns before they install packages).
- When **Phase 3** (the `Bundle` manifest threading) executes, add a `features:` manifest field, default all-on, with checks keyed by feature. That delivers à la carte semantics inside one package: don't enable a feature → don't ratify its policy, don't get its checks or keys.

Speculative with zero external adopters, and where the risk you name would bite:

- N published packages — per-feature semver, a cross-feature compatibility matrix, release ceremony, all serving one consumer and one maintainer.
- A stable third-party plugin API (a check behaviour, a contract-fragment protocol) designed before anyone has asked to write against it. Frameworks extracted from working systems beat frameworks designed in advance of their users; the trigger for flags→packages is a second consumer who wants a partial install, not architectural completeness.
- Anything runtime-shaped — the toolchain is deliberately offline, zero-dependency plain mix tasks (`mix.exs:23-26`), and service boundaries would buy nothing it needs.

One decision on record would legitimately re-open at stage three, and it's a good marker of a cost to defer: the [coding standards](https://github.com/ob6to8/elixir-mind/blob/main/meta/policy/elixir-coding-standards.md) decline a declarative constraint layer with an explicit boundary — "it holds while the shapes are few, stable, and written by the same people who write the verifier, and is worth re-opening only if domain constraints ever churn rapidly or come from authors who do not write Elixir." External à la carte adopters are precisely authors who don't write Elixir composing constraint sets. That re-opening belongs to the future where such adopters exist, and pre-paying it now is the over-engineering scenario in concrete form.

### Your options from here

| # | Option | What it entails |
|---|--------|-----------------|
| 1 | Amend the spin-out plan with a "stage 3: modular features" section (recommended) | Records this direction plus the two riders — per-feature Phase 2 spec structure, `features:` manifest field in Phase 3 — so the stage shapes how those phases execute; contingent packaging stays explicitly deferred |
| 2 | Leave it in this thread's capture only | The discussion survives as record; the direction gets re-derived (or not) when the spin-out executes |
| 3 | File a standalone modularization plan | First-class and queryable, but over-weights a stage whose trigger (a second consumer) hasn't occurred; most of its content would duplicate the spin-out plan |

I recommend option 1: the substance of stage three is two small riders on already-planned work, which is exactly a plan amendment rather than a new plan. Say the word and I'll draft it.
</routes>

## User

1

## Assistant

<routes ref="meta/plans/library-spin-out-and-dependency-distribution.md meta/plans/separate-okf-bundle-and-elixir-mind-library.md">
The quote survives at the new tip, and the new session-workflow policies don't reshape this delivery: the operator's option-1 pick scoped this thread's one unit (amend the spin-out plan), the deferred stage-3 work gets its durable home in the plan itself, and the amendment plus its index-gloss update is one matter → one commit on this branch. Neither plan file changed in the 19 merged PRs, so my edit anchors hold. Two re-checks at the new tip — the module-graph sweep (lib/ gained `matters.ex`) and the plans index structure:

The new policies fit this delivery cleanly — one scoped unit (the amendment), its deferred work filed in the plan itself, one matter → one commit. Two adjustments from the re-checks: the module sweep at `684530d` shows a second aggregating reporter (`SessionInit` now unions the matters queue), so the section's audit sentence names both reporters; and the plans index now orders entries by timestamp within status sections, so the bumped plans move to the top. Writing the amendment now:

Done — the modular-features direction is now on the record in the spin-out plan, committed and pushed. One thing to know about how this landed: `main` had moved 19 PRs ahead of this branch (the todo→matter migration and several new session-workflow policies), so I fast-forwarded the branch first, read the new policies that bear on this work (revision-enters-through-scoping, deferred-work-is-filed, atomic PRs — this delivery fits all three as one scoped unit, one matter, one commit), and re-ran the module-graph audit at the new tip before writing the section.

The amendment adds a "Deferred: modular features — à la carte adoption" section to the [spin-out plan](https://github.com/ob6to8/elixir-mind/blob/claude/mechanism-repo-sub-services-0mzlc4/meta/plans/library-spin-out-and-dependency-distribution.md): the feature-triple unit (gate + policy template + skill), the three existing composition points, the dependency DAG with the audit stamped at `684530d`, the mechanism-vs-ratified-instance posture, the two riders (per-feature profile-spec extensions in Phase 2; a `features` manifest field in Phase 3), the second-consumer trigger guarding physical packaging, a decision list, and open question 8 on feature granularity. Two adaptations came out of the re-audit against the new tip: the section names `SessionInit` alongside `Verifier` as an aggregating reporter (it now unions the matters queue), and the plans index reshuffle follows the timestamp-ordering convention that landed while we talked.

**What I modified**

| File | Thrust of the change |
|---|---|
| `meta/plans/library-spin-out-and-dependency-distribution.md` | New deferred modular-features section + open question 8; timestamp → 2026-08-03 |
| `meta/plans/separate-okf-bundle-and-elixir-mind-library.md` | Phase 2 gains the spec-structure rider (core profile + per-feature extensions); timestamp → 2026-08-03 |
| `meta/plans/index.md` | Both entries moved to the top of Proposed per timestamp ordering; spin-out gloss extended with the new stage, parent gloss with the Phase 2 note |

**Actions I have taken**

| Action | Result |
|---|---|
| Fast-forwarded the branch to origin/main | `2aaf801` → `684530d`, clean fast-forward |
| Re-verified edit anchors, the coding-standards quote, and the module sweep at the new tip | Anchors intact; one finding folded in (`SessionInit` as second aggregator) |
| Ran the gate suite | Green — pre-commit ran format, xref, all `--check` artifacts, verify, route tags, glossary, matters, and 211 tests, 0 failures; all warnings pre-existing advisories |
| Committed and pushed | `cf3f442` on `claude/mechanism-repo-sub-services-0mzlc4`, tracking set |

The branch is ready for `/create-pull-request` whenever you want to close the thread — that flow will also capture the session and stamp `attribution.from` on both amended plans.
</routes>
