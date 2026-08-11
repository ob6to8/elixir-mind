---
type: analysis
title: "Feature-wise audit of the machinery, and a componentization path for extraction"
description: Audits every system in the repo — toolchain, gates, skills, governance surfaces — for what demonstrably works and what doesn't, inventories the coupling that binds each feature to this bundle, and designs a staged componentization (config consolidation, a generic-core namespace split, slice-based distribution) so individual systems can be lifted into other repos.
provenance: "Claude Fable 5, Claude Code session — four-subagent audit (lib coupling, bundle census, skills portability, CI/automation) with the load-bearing figures re-checked in-session; full gate suite run green on this checkout before writing"
tags: [meta, analysis, architecture, componentization, extraction, tooling, audit]
timestamp: 2026-08-11T05:10:00Z
attribution:
  when: 2026-08-11T05:10:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-commissioned repo audit session"
  why: "operator asked for a critical feature-wise audit of the repo and a design for componentizing its systems so they can be extracted into other repos"
---

# Feature-wise audit of the machinery, and a componentization path

**Question.** Three parts: what in this repo demonstrably works and what doesn't;
a feature-by-feature census of its systems; and how the codebase would have to be
componentized for individual features to be extractable and reusable in another
repository.

**Basis.** Every figure below was measured on this checkout (merge commit of
PR #256) during the audit session unless it cites another document: the full gate
suite was run green (211 tests, 0 failures; format, xref, verify, contract,
registry, route-tag, glossary, matters, and code-map checks all passing), and the
coupling, census, skills, and CI findings come from four parallel read-only audit
passes whose load-bearing claims were re-verified directly against the files.
Prior reviews are cited rather than re-derived:
[the implementation-depth review](/meta/analysis/tooling-implementation-review.md)
(code defects),
[the epistemology review](/meta/analysis/epistemology-and-governance-review.md)
(contract-vs-enforcement desyncs),
[the development arc](/meta/analysis/development-arc-read-backwards-from-the-prs.md)
(trend lines), and
[the content-quality sample](/meta/analysis/content-quality-sample-review.md).

**Bottom line.** The machinery is in unusually good shape *where a gate can see
it*: seven generated artifacts, fourteen CI gates, and a zero-dependency
toolchain all verify green on a fresh clone, supporting ~256 PRs in 32 days. The
sharpest finding is an enforcement asymmetry: every layer a machine checks stays
true, and every layer that depends on a recurring judgment cadence has decayed
(verification 0.8% used, survey promotion 0.4%, the research feed silent for 13
days). For extraction, the codebase is architecturally ready — a wide, shallow,
cycle-free module graph over one true foundation module — but *configurationally*
unready: there is no bundle-config layer, so ~15 repo-specific constant families
are scattered over 40+ literal sites, three directory-exclusion lists disagree,
and the controlled type vocabulary is enforced nowhere in code. The right
componentization unit is not the Elixir module but the **vertical slice** (policy
text + directory convention + lib code + mix task + skill + CI step), and the
highest-leverage first step — consolidating the scattered constants into one
config module — pays for itself in this repo whether or not extraction ever
happens.

## 1. What demonstrably works

- **The generated-artifact discipline, uniformly applied.** `CLAUDE.md`,
  `meta/registry.md`, `meta/code-map.md`, `meta/flows/lineage.md`, the glossary
  `## Terms` index, the route-tag excerpt logs, and the dedup-probe baseline are
  all compiled from sources, banner-marked, freshness-checked, and — for the
  contested ones — covered by the `.gitattributes` `merge=regen` driver with
  `mix brain.regen` as the recovery motion. All fresh on this clone.
- **The gate suite as a culture, not a checklist.** 14 gating commands in CI plus
  actionlint; warnings-as-errors in compile and test; `xref` compile-coupling
  held at zero; zero dependencies (`deps: []`), so the whole suite runs offline
  in any sandbox. `lib/` contains no TODO/FIXME comments at all — deferred work
  is filed under `meta/issues/` and `meta/matters/` instead, which is rare
  discipline.
- **The policy → contract loop.** All 45 active policies compile into the
  contract; a hand edit is structurally rejected (`--check` in CI); the
  miss-becomes-policy feedback loop is demonstrably exercised (the banned-phrases
  register and `/ban-phrase` skill exist because it ran).
- **The record layer.** 182 thread docs over 32 days, 180 of 181 dated threads
  carrying a `pr:` anchor, all 181 carrying a routing ledger; 653 route-tag
  regions across 154 threads materialize into 258 sink documents, and all 262
  materialized blocks match their re-derivation. The capture-append boundary is
  derived (`mix brain.thread_tail`), not recalled.
- **Velocity with quality holding.** ~256 PRs in 32 days (≈8/day, one matter per
  PR), and the suite is still green at the end of it.
- **Standing self-measurement.** 65 filed analyses include a full code review, an
  epistemology audit, a content-quality sample, and two field comparisons — the
  repo measures itself and files the findings where the next session reads them.

## 2. What doesn't work

### 2a. The enforcement asymmetry (the headline)

The features that thrive and the features that decay sort perfectly by one
property: whether a machine gate enforces them or a recurring judgment cadence
must carry them.

| Layer | Mechanism | State (measured) |
|---|---|---|
| Route tags, registries, contract, indexes | CI gates | all green, 262/262 blocks fresh |
| Verification ladder (`verified`/`verified_by`) | agent/operator judgment per claim | **5** of 643 eligible statements verified (0.8%); 638 sit at `verified: false` |
| Survey → knowledge promotion | operator-initiated `/bookmarks promote` | **3** of 716 bookmarks promoted (0.4%) |
| Daily `/research` feed | a Claude Routine outside the repo | 4 digests ever; **silent since 2026-07-29** |
| Plan/matter delivery | session pickup | 46 of 64 plans not done (24 still `proposed`); 43 open matters, 22 of them backlog |

This is the repo's own
[remembered surfaces are forgotten surfaces](/beliefs/remembered-surfaces-are-forgotten-surfaces.md)
belief, confirmed at corpus scale: the decayed layers are exactly the remembered
ones. The [development arc](/meta/analysis/development-arc-read-backwards-from-the-prs.md)
saw the plan-accretion trend at 38 active plans; it now stands at 46. The
practical reading for componentization: **shipping a feature's code without its
gate ships the part that decays.**

### 2b. Contract mass keeps compounding

`CLAUDE.md` is 17,157 words / 126 KB — roughly 30k tokens loaded into *every*
session — compiled from 45 policies. The
[epistemology review](/meta/analysis/epistemology-and-governance-review.md)
measured it at 15,153 words and found its own terseness rule unenforced; it has
grown ~13% in the three weeks since. Communication policies alone are 22% of
rendered lines. Nothing bounds this: the register-style policies (banned
phrases) grow by design, and no policy has ever been retired
(0 of 45 superseded). Per-session context cost rises monotonically, and each
added rule dilutes attention on the rest.

### 2c. Retrieval remains the graded weakness

Known and filed —
[beyond-grep](/meta/analysis/beyond-grep-ranked-retrieval-options.md) graded
retrieval C−, specified an in-house stdlib BM25 (`mix brain.search`), and
[the vocabulary-mismatch follow-up](/meta/analysis/solving-vocabulary-mismatch-offline.md)
measured a 30 MB static-embedding tier at 25/30 recall — but the specified fix
is unbuilt while the corpus (1,517 tracked docs, 854 ids) keeps growing. The
dedup probe exists precisely to watch this gap; it is the one CI step marked
non-gating.

### 2d. The coupling scatter (measured this session; blocks extraction)

There is no bundle-config layer. `ElixirMind.SiteConfig` (two keys, URLs only)
is the only configurable surface; every other repo-specific constant is a module
attribute or inline literal in whichever module consumes it:

- **Three divergent directory-exclusion lists**: `registry.ex:22` (14 entries,
  excludes `meta/` and the staging namespaces), `links.ex:48` (10 — deliberately
  keeps `meta/`), `site_config.ex:28` (10, different order). Only `Site` reuses
  one.
- **The id scheme**: `Registry.id_format/0` is the intended single point, but
  `dedup_probe.ex:215` carries an independent copy of the regex, and
  `attribution.ex:304` / `route_tags.ex:225` pattern-match the `"em:"` prefix
  directly.
- **`meta/threads` appears at 6 sites in 4 spelling variants**;
  `beliefs/glossary` at 4 sites in 2 incompatible forms (with and without
  trailing slash, used differently).
- **Reserved filenames** (`index.md log.md README.md CLAUDE.md`): three full
  copies (`registry.ex:23`, `links.ex:49`, `orphans.ex:27`) plus six partial
  variants.
- **The controlled type vocabulary exists only as prose.** No list of allowed
  `type:` values appears anywhere in `lib/` — `mix brain.verify` accepts any
  non-empty type string. The only type sets in code are the statement types
  (`verifier.ex:46`), `"visualization"`, `"policy"`, `"matter"`, and the
  `from`-expected governance types. This is the largest single gap between the
  documented model and the enforced model, and it is also why the census still
  counts retired vocabulary (`assertion` ×10) without complaint.
- **The site brand is unconfigurable**: the string `"Elixir Mind"` is hardcoded
  at four sites in `site.ex`; no `site_title` config key exists. GitHub-specific
  grammar (blob-URL shape, PR-URL shape, merge-subject regexes ×4,
  `origin/main` literals, the `claude/…-xxxxxx` branch shape, `.nojekyll`)
  is spread over `site_config.ex`, `dev_history.ex`, `brain.url`, and
  `backfill.ex`.

### 2e. Internal duplication and inconsistency in `lib/`

Five places independently know the document format (the `Frontmatter` parser,
`Lineage.parse_lineage_block/1` — a second, nested-capable walker the flat
parser forced into existence — two `Backfill` rewriters, and `brain.id`'s
`add_id!`). Four near-identical bundle-file walkers run over three different
exclusion lists. `Matters.split_cells/1` and `DedupProbe.split_cells/1` are
byte-identical; `RouteTags` and `SessionInit` parse the `## Routing` section
with two implementations that disagree on what the heading is; the excerpt-log
heading string exists in four copies across three modules; the
warn/fail report block is pasted into three tasks. Five error-handling
conventions coexist (formatted-string lists, `{name, :ok|:warn|:fail, detail}`
tuples, bare warning lists, four different `{:stale, …}` payloads, and three
raising styles) — and tolerance for the same malformed input differs by module
(`Registry`/`Site`/`Matters` tolerate an unparseable doc; `Policy` and
`Lineage` raise on one).

### 2f. Test debt at the edges

`mix.exs` declares `test/support` in `elixirc_paths` but the directory does not
exist; a `write/3` tmp-bundle helper is copy-pasted into ~12 test files.
`Attribution.Backfill` (306 lines, mutates files in place, shells out to git)
has no test. All 20 mix tasks have no test files — including `brain.url`'s
126 lines of git-liveness branching and `brain.evidence`'s narrative renderer,
which exists only in the task. Two tests bind to the live repo rather than a
fixture (`route_tags_test.exs:491`, `dev_history_test.exs:129`) and would fail
in an extracted component.

### 2g. Residual defects and staleness

The [implementation-depth review](/meta/analysis/tooling-implementation-review.md)'s
findings stand; this pass adds: the attribution exempt list omits
`meta/code-map.md` and passes only because the code map happens to carry no
frontmatter (`attribution.ex:78` — adding frontmatter to it would break CI);
the gate-suite tutorial documents 10 of the current 14 gates (its own
description names three families; `glossary`, `matters`, `lineage`, and
`dedup_probe` are absent from it);
[the create-pull-request flow doc](/meta/flows/create-pull-request.md) still
specifies the retired `thread:` field its skill replaced with
`attribution.from`; `pages.yml` states it runs "the same bundle-integrity
checks CI runs" while omitting `matters` and `lineage`; dead code persists
(`Attribution.channels/0`, `DedupProbe.gold_path/0`, the ~100-line lineage
migration reader whose input no longer exists in the corpus); and the toolchain
pins Elixir 1.14 / OTP 25 in CI while the local binary is an OTP-24-compiled
1.14.0 running on OTP 25 — nothing exercises a modern Elixir. The `/research`
schedule lives in a Claude Routine outside version control: nothing in the repo
records that the automation exists, or would let it be reconstructed.

## 3. The feature census

Extraction grades: **A** — generic now or after config keys; **B** — ports if
the consuming repo adopts the conventions (directory layout, doc genres);
**C** — this repo's content or culture; port the pattern, not the instance.

| Feature (slice) | Code (LOC) | Gate | Skill / policy surface | Grade |
|---|---|---|---|---|
| Frontmatter parsing | `frontmatter.ex` (129) | via every gate | frontmatter-schema | **A** |
| Markdown → HTML | `markdown.ex` (494) | site build | — | **A** |
| Code map (docstrings → glossary) | `code_map.ex` (178) | `--check` | coding standards | **A** (any Elixir repo, today) |
| Contract compiler | `policy.ex` + `contract.ex` (239) | `--check` | `/render-contract`; the whole policy corpus | **A** (highest transfer value) |
| Regen + merge drivers | `brain.regen`, `.gitattributes`, session-start hook | pre-commit/CI | merge-strategy | **A** (pattern kit) |
| Dev history from merge graph | `dev_history.ex` (329) | deploy-time | merge-strategy | **A−** (GitHub grammar → config) |
| Static site + search | `site.ex` + assets + config (1,162) | CI build | response-resource-links | **A−** (brand hardcoded) |
| Stable identity + registry | `registry.ex` (179), `brain.id` | `--check` | stable-identity | **A−** (prefix + exclusions → config) |
| Link/index hygiene + orphans | `links.ex`, `orphans.ex` (289) | in verify | maintain-reserved-files | **A−** |
| URL resolver | `brain.url` (126) | — | response-resource-links | **B+** |
| Bundle verifier | `verifier.ex` (176) | verify | verification-grounding, conformance | **B+** (needs config + a check seam) |
| Session-init digest | `session_init.ex` (410) | — | `/priorities` | **B+** |
| Attribution layer | `attribution.ex` (323) + backfill (306) | in verify | resource-attribution | **B** (leave the one-shot backfill behind) |
| Matters queue | `matters.ex` (419) | matters gate | `/matter`, `/scope-unit-of-work` + policies | **B** (a generic review-quantized queue) |
| Route tags + excerpt logs | `route_tags.ex` (696) | route_tags gate | route-tagging, routing-ledger, `/capture` | **B** (most novel; needs thread conventions) |
| Session capture | `thread_tail.ex` (55) + `/capture` skill | scenario test | session-capture | **B** (mostly skill-side) |
| Glossary conventions | `glossary.ex` (343) | glossary gate | `/add-to-glossary` | **B−** (thresholds + sense taxonomy) |
| Flow lineage | `lineage.ex` (478) | `--check` | flows genre | **C** (niche; carries the dead parser) |
| Dedup-recall probe | `dedup_probe.ex` (454) | non-gating | `/intake` | **C** as instance, **B** as harness pattern |
| Skills pack | 18 skills (2,328 lines) | — | skills-registry | 2 **A** / 6 **B** / 10 **C** |

Skills portability, specifically: `sync-branch-with-main` and
`summarize-technical` port with trivial edits; `review-pr`, `render-contract`,
`issue`, `plan`, `elaborate`, and `journal` port once paths become variables;
the culture-dense ten (`capture`, `create-pull-request`, `intake`,
`add-to-glossary`, `research`, `bookmarks`, `matter`, `scope-unit-of-work`,
`priorities`, `ban-phrase`) encode this repo's governance and only make sense
where the conventions travel with them. The skills registry itself is
hand-maintained prose inside a policy — the one registry in the repo with no
mechanical registry↔disk gate — and skill bodies restate policy text at five
audited sites, which is the drift surface the
[implementation review](/meta/analysis/tooling-implementation-review.md) already
flagged from the other side.

## 4. Componentization: the unit is the vertical slice

Extracting a `.ex` file extracts the *checker*; the feature is the checker
**plus** the conventions it checks and the practice that feeds it. The matters
queue illustrates the full anatomy: `matters.ex` (checks) + `meta/matters.md` +
`meta/matters/` (conventions) + the `matter` type entry (vocabulary) +
`/matter` and `/scope-unit-of-work` (practice) + the CI step (enforcement).
Ship fewer layers and the feature arrives as either unenforced convention or
unfed machinery — and §2a is the measurement of what happens to unfed
machinery's editorial twin. So the extractable product is a set of **feature
packs**, each carrying code, seed conventions, skills, and a CI fragment
together, over a shared core.

Three consumer surfaces, in increasing distance from this repo:

1. **An Elixir repo** consumes the core as a library (path/git/hex dep) and
   keeps `mix brain.*`-style tasks.
2. **A non-Elixir repo** — the common case for a knowledge bundle — cannot run
   mix tasks at all (they require a Mix project), so reaching it takes an
   **escript build** (single executable, needs only Erlang) reading a config
   file at the bundle root. This is the real adoption constraint on the whole
   toolchain, and it is invisible from inside this repo.
3. **Seed content** (trimmed policy set, portable skills, CI workflows,
   `.gitattributes`, hooks) cannot ship in a library at all — it is a
   **template repo**, with accepted divergence after instantiation.

### Stage 0 — consolidate configuration in place (do regardless)

Introduce one config module owning what is now scattered: id prefix/format,
the (currently three) exclusion lists as one base set with per-consumer views,
reserved filenames, the namespace path map (`meta/threads`, `beliefs/glossary`,
staging tiers), attribution channels and exemptions, the contract section list
(`contract.ex:21-33` — the one piece of contract structure that is code rather
than data), the site brand/title, and the **type vocabulary** — closing the
§2d enforcement gap as a side effect, since the verifier can then warn on a
type outside the controlled list. Unify the four bundle walkers on one scan;
collapse the five error conventions toward two (hard errors + a warn tier in
the library rather than re-implemented per task); delete the dead code
(§2g). Add a coupling gate in the repo's own style: a test asserting the
generic modules contain no repo-literal strings — a mechanical oracle for a
property that would otherwise erode. Every step here is a pure refactor under
the existing gate suite, and every step improves this repo even if extraction
never happens.

### Stage 1 — the namespace split

```
lib/okf/                     # generic core — no repo literal anywhere (gate-enforced)
  config.ex                  # the struct every module takes; loaded from config/
  frontmatter.ex  markdown.ex  registry.ex  links.ex  orphans.ex
  verifier.ex  check.ex      # check.ex: behaviour so packs register rules
  contract.ex  policy.ex     # instruction compiler (output name, sections from config)
  site.ex  site/assets.ex  site_config.ex  code_map.ex  dev_history.ex
lib/okf_packs/               # convention-bound packs, config-parameterized
  attribution.ex  matters.ex  route_tags.ex  session_init.ex  thread_tail.ex  glossary.ex
lib/elixir_mind/             # this bundle: its config values + what stays
  config.ex                  # prefix "em", the tree, the vocabulary, the brand
  lineage.ex  dedup_probe.ex # repo-specific instruments
```

Task names (`mix brain.*`) stay as thin aliases, so skills and muscle memory
survive the split. The verifier gains its missing seam: today adding a rule
means editing `Verifier.run/2`'s one expression; a `Check` behaviour lets a
pack (or a consuming repo) register rules without forking the core, and gives
`Glossary`/`RouteTags`/`Matters` — currently separate gates with a different
result contract — a shared shape.

### Stage 2 — distribution

The core publishes from an in-tree package (this repo keeps its zero-external-
dependency stance — the package is its own code); an `okf` escript target
serves non-Elixir bundles; and an `okf-template` repo carries the seed content:
a trimmed policy set, the 8 portable skills with a conventions preamble, both
workflows, the hook, and `.gitattributes`. The cheapest port is
convention-over-configuration: a consumer that keeps this repo's directory
names and task names can take the culture-bound skills nearly verbatim; one
that renames anything pays for it at every skill that names a path.

### What deliberately does not extract

The 45 policies are the operator's ratified culture — the template ships a
*seed*, and each consuming repo ratifies its own. The taxonomy is content. The
lineage genre and the dedup gold set are this repo's instruments. And the
declarative-shapes route for the verifier stays declined per the
[coding standards](/meta/policy/elixir-coding-standards.md) — the `Check`
behaviour is a registration seam, not a constraint language.

### Governance routing, if pursued

Stages 0–1 are work on this brain's tooling: a `type: plan` under
[`meta/plans/`](/meta/plans/index.md) per
[persist-plans](/meta/policy/persist-plans.md). The escript, the published
package, and the template are a system built for use outside this repo, which
is exactly the [project-namespace](/meta/policy/project-namespace.md) shape: a
`projects/<slug>.md` hub, with break-out to its own repository as the success
condition.

## 5. Decision list

**Recommended.** Stage 0 unconditionally — it is a self-funding cleanup of
measured duplication and the one prerequisite every extraction path shares.
Stages 1–2 only against a named consumer: the design above assumes a concrete
second repo (or a real intent to publish) exists, and without one the split is
speculative structure. The escript surface is worth building first *if* the
first consumer is a non-Elixir repo, and skippable otherwise.

**Rejected alternatives.** An umbrella-app restructure (heavier than the
problem; the namespace split gets the same boundary for less); publishing the
toolchain as-is (the §2d couplings would force every consumer to fork);
extracting skills without their conventions (§4 — that ships the decay mode).

**Open questions.** Whether the core's name should carry the OKF spec's name or
a neutral one; whether route tags belong in the core or stay a pack (they are
the most novel feature and the most convention-hungry); and whether the
skill↔policy duplication should be solved structurally (skills compiled from
policy sources, the way the contract already is) before the skills are
templated for export — the drift findings in §2g argue yes, but that is its own
design, not a footnote to this one.
