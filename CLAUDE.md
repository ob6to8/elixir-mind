<!--
  GENERATED FILE — do not edit by hand.
  Source of truth: meta/preamble.md + meta/policy/*.md
  Regenerate:      mix brain.contract
  Verify (CI):     mix brain.contract --check
-->

# Operating Contract — Elixir Mind (OKF)

This repository is a personal **second brain** stored as an
[Open Knowledge Format](/knowledge/knowledge-management/open-knowledge-format.md)
(**OKF v0.1**) bundle, named **elixir-mind**. Every agent that operates here — including fresh, sandboxed
agents spun up from the Claude Code app — MUST read and follow this contract. It is
the backbone that keeps the brain consistent as it grows.

The operator is the human. The agent files and organizes;
the operator ratifies changes to the *shape* of the brain.
The contract binds agents, not the operator: its rules are obligations on agent
behavior, which the operator authors and ratifies but is never subject to.

> **This file is a generated artifact.** It is compiled from
> [`meta/preamble.md`](/meta/preamble.md) and the `type: policy` documents under
> [`meta/policy/`](/meta/policy/index.md). Do **not** edit it by hand — edit the
> source policies and run `mix brain.contract` (see the `/render-contract` skill).

---

## 1. What the brain is made of

- **The repo root is the OKF bundle.** Documents live at the root and in
  subdirectories. `.claude/` (skills), `meta/` (governance), the Elixir tooling
  (`mix.exs`, `lib/`, `test/`), and `deprecated/` (archived legacy content,
  read-only) sit alongside but are **not** part of the knowledge bundle.
- **A document** is a single UTF-8 markdown file with two parts:
  1. **YAML frontmatter** (required), delimited by `---`.
  2. **Markdown body** (distilled prose; no required sections).
- **Document ID** = file path minus `.md` (e.g. `areas/health.md` → `areas/health`).
- **Terminology: "document", not "concept".** The OKF spec calls this unit a
  *concept document*, but the anatomy above is purely structural — nothing in it
  guarantees concept-like content. This bundle therefore says **document** for
  the unit and reserves **`concept`** for the controlled `type` of that name (a
  definition or mental model). When reading the OKF spec, its "concept" is this
  bundle's "document".

_Source: [`meta/policy/document-anatomy.md`](/meta/policy/document-anatomy.md)_

Frontmatter fields:

| Field | Requirement | Notes |
|-------|-------------|-------|
| `id` | **Mandatory** (bundle documents) | Stable opaque identifier, `em:` + 6 hex chars. Immutable once minted (`mix brain.id`); see the identity-and-verification section. |
| `type` | **Mandatory** | From the controlled vocabulary (see the type-vocabulary section). Non-empty. |
| `title` | Strongly recommended | Human-readable display name. |
| `description` | Strongly recommended | Single-sentence summary. |
| `resource` | When applicable | URI uniquely identifying the underlying/source asset (e.g. the original URL). |
| `provenance` | When applicable | Where the content came from (e.g. "Claude Opus 4.8, chat thread"). Distinct from `resource`: this is the *origin of the statement*, not a canonical asset URI. |
| `launch` | **Mandatory** on `visualization` | Filename of the document's same-directory sibling `.html` — the self-contained artifact the reader opens. A bare filename, never a path or URL. Distinct from `resource`: that names an *external source asset the document captures*, this names *the document's own artifact*. Machine-enforced (exists, sibling, `.html`); an error on any other type. |
| `verified` | Only on agent statements | Boolean, and **only for agent-authored statements** (`claim`/`note`/`concept`). `false` = asserted but not checked; `true` = checked and backed by a non-empty `verified_by`. **Omit** on captures — a document that stores a link (`resource`) is not verifiable. Default `false` for AI-generated statements. |
| `verified_by` | When verified via evidence | Inline YAML list of stable ids (typically `source` captures) that jointly support this statement; targets must **exist** (they need not themselves be `verified`). The only committed representation of evidence edges. |
| `attribution` | **Mandatory** (bundle documents and governance docs) | Structured map recording the ingestion event — `when`/`channel`/`agent`/`why`, plus append-only `from` on governance docs. Immutable once written (except `from`). See the resource-attribution policy. |
| `tags` | Recommended | YAML list of categorization strings. |
| `timestamp` | Recommended | ISO 8601 datetime of last meaningful change. |

Arbitrary extra keys are allowed and must be preserved.

_Source: [`meta/policy/frontmatter-schema.md`](/meta/policy/frontmatter-schema.md)_

**Attribution — the ingestion event, recorded on the doc.** Every bundle document
(everything with an `em:` id) and every governance doc carries an `attribution`
frontmatter map recording how it entered the brain (see the
[attribution plan](/meta/plans/resource-attribution-property.md) for the design
record):

```yaml
attribution:
  when: 2026-07-13T14:02:00Z
  channel: auto-intake
  agent: "Claude Code agent, /research daily Routine"
  why: "featured in the 2026-07-13 digest under agents/orchestration; reason-tag: impactful"
  from: [/meta/threads/2026-07-13-example.md]   # governance docs only
```

| Sub-key | Holds | Form |
|---------|-------|------|
| `when` | The ingestion instant | ISO 8601 (date minimum; datetime preferred) |
| `channel` | *How* it entered — the pathway | Controlled: `intake` · `auto-intake` · `glossary` · `agent-authored` · `backfill` (grows by operator ratification, like `type`) |
| `agent` | *Who* acted — the operator, or the agent and the automation context it ran in. Names the **pathway, not the model** (the model is in the commit trailer) | Free text, one line |
| `why` | Why it was deemed worth filing | Free text, one sentence (optional when `channel: backfill` — never invented) |
| `from` | **Governance docs only.** The doc(s) this entry was extracted from — the thread it came out of, and/or the document that resulted from that thread | Inline YAML list of refs, route-tag style: an `em:` id (document) or a bundle-absolute path (thread/governance doc); targets must exist |

- **Immutable event, one carve-out.** The event sub-keys
  (`when`/`channel`/`agent`/`why`) are written once at filing and never
  rewritten — update-in-place merges bump `timestamp`, not attribution.
  Governance `from` is **append-only**: later sessions that substantively
  revise a doc add their thread (stamped by `/create-pull-request` after
  `/capture`, when the thread path exists), never remove or rewrite entries.
- **Orthogonal to the neighboring fields.** `resource` = *what asset* (canonical
  URI); `provenance` = *where the content came from* (author/origin, possibly
  predating the brain); `attribution` = *how it got here* (the ingestion event);
  `timestamp` = *when it last changed*. Attribution is not a log: the commit
  graph stays the single change-narrative layer, and this is one write-once
  record, not a maintained history.
- **Scope and exemptions.** Required on all bundle documents and on governance
  docs (`from` required on ratification-flow docs — `plan`, `analysis`,
  `elaboration`, `issue`; permitted absent only where no source doc exists).
  Exempt — and it is an **error** for them to carry `attribution`: thread docs
  (they *are* the session record; `pr:` is their anchor), `inbox/` digests
  (dated and self-describing by construction), the `survey/` tier (bookmark
  registers) and the `journal/` tier (dated operator entries, both
  self-describing by construction like `inbox/`), and generated artifacts
  (`CLAUDE.md`, `meta/registry.md`, `index.md` listings).
- **Machine-enforced.** `mix brain.verify` checks shape (parseable map, valid
  `when`/`channel`, non-empty `agent`, `why` per the backfill rule), `from` ref
  resolution, exemption placement, and presence.

_Source: [`meta/policy/resource-attribution.md`](/meta/policy/resource-attribution.md)_

Reserved filenames (any directory level):

- **`index.md`** — directory listing for progressive disclosure. Markdown sections
  with bulleted links + one-line descriptions. **No frontmatter** — except the
  bundle-root `index.md`, which carries only `okf_version: "0.1"`.
- **`log.md`** — reserved by OKF (chronological change history; tolerate one when
  consuming a foreign bundle), but **this bundle does not keep hand-written logs**:
  the true-merge commit graph is the single provenance layer (see the
  merge-strategy policy and the
  [retire-hand-kept-logs plan](/meta/plans/retire-hand-kept-logs.md)). Do not
  create `log.md` files or append log entries; the change narrative belongs in
  commit messages. (The generated `## Thread excerpts — route-tagged log`
  sections inside documents are unrelated — they are compiled, CI-verified
  artifacts and stay.)

_Source: [`meta/policy/reserved-filenames.md`](/meta/policy/reserved-filenames.md)_

---

## 2. Directory structure — unix-like, domain-agnostic, evolving

- Organize documents into a **unix-like hierarchy**: lowercase, kebab-case directory
  names (short, established acronyms like `SWE` may stay uppercase); each directory
  holds a coherent set of related documents.
- **Create the natural directory path even for a single document.** Do not flatten to
  avoid nesting — a lone note about git belongs in `knowledge/SWE/version-control/git/`, not
  dumped at the root. Depth that mirrors the real structure of the knowledge is good.

_Source: [`meta/policy/directory-hierarchy.md`](/meta/policy/directory-hierarchy.md)_

- **The tree *is* the taxonomy.** The directory hierarchy — surfaced through `index.md`
  files at every level (progressive disclosure, rooted at `/index.md`) — is the
  canonical taxonomy. Keep those `index.md` files current; do not maintain a separate
  map that drifts.
- **Policy vs. instance.** `CLAUDE.md` holds the *policy* (this contract — the `type`
  vocabulary and frontmatter schema), compiled from `meta/policy/`. The tree holds the
  *instance*. Governance (`meta/`) is a separate namespace from the knowledge taxonomy.
- The taxonomy is **not fixed**. It **emerges bottom-up** and evolves
  **collaboratively**. There is no pre-imposed schema to satisfy.

_Source: [`meta/policy/tree-is-the-taxonomy.md`](/meta/policy/tree-is-the-taxonomy.md)_

The taxonomy-evolution protocol (important):

- Filing a document into an **existing** directory, or creating **subdirectories
  under an already-established top-level domain**, → the agent does this
  **autonomously** (create the path and each new directory's `index.md`).
- Creating a **new top-level directory** (or renaming/moving/merging directories) is
  a change to the *shape* of the brain → the agent **proposes it and waits for the
  operator to ratify** before creating it. Explain the proposed name, where it
  sits, and why the existing tree doesn't fit.
- On creation, add each new directory's `index.md` and list new top-level dirs
  in the root `index.md`.

_Source: [`meta/policy/taxonomy-evolution-protocol.md`](/meta/policy/taxonomy-evolution-protocol.md)_

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

_Source: [`meta/policy/project-namespace.md`](/meta/policy/project-namespace.md)_

---

## 3. Filing conventions

**Capture the knowledge, cite the source.** When you file a knowledge document,
capture the *knowledge*, not the raw noise. A document has a clear title, a
one-sentence `description`, and a clean body. Keep the original material as a
`resource` URI and/or under a `# Citations` section — not as the whole document.

This is the knowledge-layer half of
[fit each layer to its purpose](/meta/doctrine/fit-each-layer-to-its-purpose.md):
a document consulted to *understand a subject* is fit for purpose when it is
concise and queryable, so here you distill hard and relegate the raw source to a
citation. The record-layer half — where fidelity, not concision, is the goal, and
material is kept verbatim-minus-noise — is governed separately by
[session-capture](/meta/policy/session-capture.md); do not apply this filing rule
to thread docs.

_Source: [`meta/policy/capture-knowledge-cite-the-source.md`](/meta/policy/capture-knowledge-cite-the-source.md)_

**Update in place; don't fragment.** Before creating a file, **search the bundle**
for an existing document on the same subject. If one exists, update it (merge new
info, bump `timestamp`) instead of creating a near-duplicate.

_Source: [`meta/policy/update-in-place.md`](/meta/policy/update-in-place.md)_

- **Filenames**: kebab-case slug derived from the title
  (`open-knowledge-format.md`). Use a `YYYY-MM-DD-` prefix **only** for inherently
  time-ordered entries (journal/log-style notes); topical documents stay purely
  topical.
- **Cross-link** related documents with markdown links. Prefer bundle-absolute paths
  (begin with `/`, e.g. `[OKF](/knowledge/knowledge-management/open-knowledge-format.md)`). Links are
  untyped edges; the prose carries the meaning. Broken links are tolerated but avoid
  creating them.

_Source: [`meta/policy/filenames-and-cross-linking.md`](/meta/policy/filenames-and-cross-linking.md)_

**Pages links in docs, GitHub links in agent threads.** Two surfaces, two link
schemes (operator-ratified 2026-07-27):

- **Agent threads → GitHub links, always.** When an agent's **delivered
  response** (chat to the operator, a PR body, an issue comment — anything
  read outside a checkout) references a document in the brain, cite its
  GitHub **blob URL** — at `main` for a merged, unchanged document, at the
  session branch otherwise — never a bundle-absolute or relative repo path,
  and never a Pages URL. A blob URL is viewable at **any** merge state, which
  is exactly when the operator audits; a Pages URL is live only after merge
  and deploy. (A branch blob link dies when the merged branch is deleted;
  that is accepted — the thread's moment has passed, and the document's
  durable home is its Pages URL.)
- **Docs → Pages links.** Cross-links *inside* document bodies stay
  bundle-absolute markdown paths per
  [filenames-and-cross-linking](/meta/policy/filenames-and-cross-linking.md);
  the site rewrites them to relative `.html` at build time, so on the
  rendered site every doc link *is* a Pages link. Never hardcode live URLs
  into document bodies. The Pages URL is the **durable, canonical form for a
  merged document** cited outside a session (sharing, external references).

**Get the URL from the tool, never by hand.** `mix brain.url` prints the
right URL for each surface — always run it; hand-construction is exactly what
produces dead links:

- **`mix brain.url --thread <path>`** — the agent-thread form: the blob URL
  at the ref whose tree holds the current content (`main` when merged and
  unchanged, else the current branch).
- **`mix brain.url --pages <path>`** — the canonical Pages URL for durable
  external citation of merged docs (bundle path `P.md` →
  `https://ob6to8.github.io/elixir-mind/P.html`; a directory's `index.md` → `…/<dir>/index.html`;
  governance `meta/…` docs render too).
- **Bare `mix brain.url <path>`** — whichever resolves and shows the current
  content (Pages when live and unchanged vs `origin/main`, else blob).

**Mechanics.** The bundle is published to GitHub Pages at
**`https://ob6to8.github.io/elixir-mind/`** (`mix brain.site` → `pages.yml`, deploying **only from
the default branch** — the reason unmerged docs have no live page). The base
URL lives in config (`config/config.exs` →
`ElixirMind.SiteConfig.base_url/0`); it is the single source of truth, and
this contract's copy is compiled in from it. Resources under directories the
site excludes (`deprecated/`, `.claude/`, `lib/`, `test/`) have no page ever;
`mix brain.url` cites those by blob URL in every mode rather than fabricating
a Pages URL.

_Source: [`meta/policy/response-resource-links.md`](/meta/policy/response-resource-links.md)_

- **No bare URLs as bundle documents.** A link becomes a bundle
  [`reference`](/meta/policy/controlled-type-vocabulary.md) — filed into the taxonomy,
  distilled, cross-linked, carrying an `em:` id — only once it has been **processed**
  (fetched and summarized/captured). Never file a bare, unprocessed URL as a bundle
  document: distill it into a reference, or park it in the survey tier below. The two
  levels are the point — a link is either *ingested* (a filed reference) or *surveyed*
  (a bookmark), never dumped raw into the taxonomy.
- **The survey tier — the one sanctioned staging exception.** Links worth keeping but
  not worth fully ingesting yet live in [`survey/`](/survey/index.md) as **bookmarks**:
  rows in a register (`survey/bookmarks.md`), each **fetched, one-line-summarized, and
  tagged** by [`/bookmarks`](/.claude/skills/bookmarks/SKILL.md) — enough metadata to be
  surfaced by a topic query, without the distill-file-cross-link cost of a reference. A
  bookmark is *surveyed, not parked bare*; the summary + tags are mandatory, so the tier
  never degrades into a link graveyard. `survey/` is a **non-bundle namespace** (no `em:`
  ids, never verified, outside the taxonomy) like `inbox/` and `meta/`, so a bookmark
  makes no claim on the tree. It is a distinct staging level, **not** a new bundle
  `type` — bookmarks are register rows, and the register reuses `type: reference` (as
  `inbox/` digests do).
- **Promotion is the bridge back to the taxonomy.** A surveyed bookmark graduates to a
  filed `reference` via [`/intake`](/.claude/skills/intake/SKILL.md) (driven by
  `/bookmarks promote`); that is the single point where the full distill pass runs and
  the knowledge-layer filing rule
  ([capture the knowledge, cite the source](/meta/policy/capture-knowledge-cite-the-source.md))
  re-engages. The register row records the graduation (`status: promoted → <link>`) so
  the staging debt stays visible and countable rather than all-or-nothing.
- **Oversized linked resources**: if a linked source is too large to reasonably copy,
  **write a faithful summary** as the document body and **persist the link** in the
  `resource` frontmatter field (and/or `# Citations`) so nothing is lost.

_Source: [`meta/policy/link-processing.md`](/meta/policy/link-processing.md)_

**Maintain the reserved files**: after filing, update the directory's `index.md`
(create it if missing). The change itself is recorded by the commit — write the
commit message at the semantic level ("intake X", "ratify Y"); there is no
`log.md` to append to (see the reserved-filenames policy).

_Source: [`meta/policy/maintain-reserved-files.md`](/meta/policy/maintain-reserved-files.md)_

**Persist plans; don't leave them in the conversation.** A design spec or
implementation plan is a durable record of *decisions and their rationale* — the
shape of a change, the alternatives weighed, and the build order. That record must
survive the session that produced it. Chat scrolls off and the agent scratchpad is
session-isolated and reclaimed, so a plan that lives only there is lost the moment
the session ends.

- **When.** Whenever the operator approves a plan of any substance — a new
  subsystem, a genre or policy change, a multi-step build — persist it before
  acting on it. A throwaway one-liner is not a plan; a design worth a review pass
  is.
- **Where.** As a `type: plan` document under [`meta/plans/`](/meta/plans/index.md)
  (governance namespace — no `em:` id, outside the identity registry, like
  `tutorials` and `threads`). Filename is a kebab-case slug of the title.
- **What it holds.** The problem, the decisions and their reasoning, the artifact
  shape, and the build order — plus any commissioned design review (e.g. a
  research spike) recorded with its verdict, so the *why-it's-shaped-this-way*
  travels with the plan. Deferred phases (things planned but not yet built) stay in
  the same doc under an explicit "deferred" heading until they graduate into their
  own plan when built.
- **How the shape is written.** When the plan's subject has structure (code, a
  skill's flow, the bundle tree), its shape sections follow
  [structured-plan-bodies](/meta/policy/structured-plan-bodies.md): trees,
  file-tree diffs, and signatures for the shape; prose for the problem,
  rationale, alternatives, and open questions.
- **Lifecycle.** A plan carries a `status` (`proposed` · `accepted` · `in-progress`
  · `done` · `superseded`). Done and superseded plans are kept, not deleted — the
  decision history is the point.
- **Reserved files.** After adding or updating a plan, update
  [`meta/plans/index.md`](/meta/plans/index.md), same as any filed document.

_Source: [`meta/policy/persist-plans.md`](/meta/policy/persist-plans.md)_

**Encode a plan's shape as structured artifacts; keep prose for the why.** When
a plan's subject has structure — code, a skill's control flow, the bundle tree,
a frontmatter schema — the *shape of the change* is written as compact
structured artifacts, not described in paragraphs. Prose still carries the
problem, the rationale, the alternatives weighed, and the open questions
(unchanged from [persist-plans](/meta/policy/persist-plans.md)); the artifacts
carry the shape. Rationale, held as beliefs: each artifact
"is a decision you'd otherwise be making implicitly during code review — at the
most expensive possible time to change your mind"
([em:6c7e85](/beliefs/plan-artifacts-surface-implicit-review-decisions.md),
quoting [wsff.md](https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/wsff.md)),
and the artifacts "compress the *decisions* (interfaces, layout, call order)
while leaving function bodies to the agent"
([em:a96688](/beliefs/plan-artifacts-compress-decisions-not-bodies.md)).

**The artifact kit** — use what the change calls for, in this order:

1. **Current-state tree, then desired-state tree** — the flow or structure as it
   is, then as it should be (behavior → layer → anchor per level). Equivalent
   encoding: one tree in `diff` syntax (`+`/`-`/`~` lines) when the delta is
   small. For changes to an existing flow, the flow doc under
   [`meta/flows/`](/meta/flows/index.md) *is* the current-state record — cite
   it instead of restating it.
2. **File-tree diff** — where new and modified files live (`# NEW` / `# MODIFIED`
   annotations with a one-clause purpose each).
3. **Call/flow trees** — for control-flow changes, the production topology *and*
   the test topology (which seams are substituted under test), separately.
4. **Signatures** — types and specs for the key new functions; in the Elixir
   tooling, literal `@spec` lines per the
   [coding standards](/meta/policy/elixir-coding-standards.md).
5. **Boundary decisions** — one bullet per layered responsibility: which layer
   detects the condition, owns side effects, persists state.
6. **Anchors last** — concrete file paths, function names, abstractions to
   reuse, and the tests that should cover the flow are attached *after* the
   trees, never before, so the plan is anchored to intended behavior rather
   than incidental existing code.
7. **Decision list** — recommended shape, alternatives rejected, open questions
   and assumptions. This closes every structured plan.

**The granularity bound.** Artifacts stay at signature/tree/outline level —
interfaces, layout, call order — and stop there, because "a spec that is
sufficiently detailed to generate code with a reliable degree of quality is
roughly the same length and detail as the code itself"
([em:1eebdf](/beliefs/spec-detail-approaches-code-length.md), quoting
[Dex Horthy](https://x.com/dexhorthy/status/2033980486813684181)) — and such a
spec gets no separate review pass
([em:0c4913](/beliefs/dont-review-code-length-specs.md)). A plan whose
pseudocode has crept to code granularity is over-specified, not thorough.

**The refresh rule.** A structured plan binds to concrete names, so a deferred
plan's anchors can go stale as `main` moves. Executing any structured plan
therefore begins with a **refresh step**: re-derive the current-state tree
against `HEAD`, diff it against the plan's, and update anchors before building.
Anchors-last (item 6) is what keeps this step cheap — the stale layer is
segregated, not woven through the prose.

**Scope.** Applies to plans whose subject has structure; a plan for a pure
policy or doctrine change may be all prose (its "shape" is the rule text
itself). Retrofit of pre-existing plans is governed by the
[retrofit plan](/meta/plans/retrofit-plans-to-structured-bodies.md), not
demanded by this policy.

_Source: [`meta/policy/structured-plan-bodies.md`](/meta/policy/structured-plan-bodies.md)_

**Two records of a change sit in different tenses.** A `type: plan`
([persist-plans](/meta/policy/persist-plans.md)) is **prospective** — decisions
and their rationale written *before* the work, so a session that lacks the
context can execute it. A thread doc
([session-capture](/meta/policy/session-capture.md)) is **retrospective** — the
frozen record of what a session *actually did*, produced at its close. The
commit graph ([merge-strategy](/meta/policy/merge-strategy.md)) is the third
layer: the durable *what-changed*, cited by SHA. Choosing between "persist a
plan" and "just do it" is choosing whether the work needs the prospective
artifact or whether the retrospective ones suffice.

**Default: execute in-session; the commit and the capture are the record.** When
this session holds the context and can finish the work, a plan doc is a
redundant third copy of decisions the commit message and thread render already
carry. Persisting one then is pure overhead, and worse, it *invites* a future
session to re-derive settled work.

**Escalate to a prospective plan when any of these hold:**

- **Deferred.** The work will not run in this session. Whatever context justified
  it goes cold the moment the session ends, so the decisions must be written down
  to survive — this is the core [persist-plans](/meta/policy/persist-plans.md)
  case.
- **Cold-context handoff.** The work will be executed by a *fresh* agent that
  does not share this session's reasoning. A plan is the context-transfer
  vehicle; without it the fresh agent restarts the thinking (and may re-land on a
  worse answer).
- **Cross-session build order.** The work is large enough to span sessions and
  needs an explicit sequence — a new subsystem, a genre or policy change, a
  multi-step migration — where the *order* itself is a decision worth recording.
- **Substantial standalone design.** The decisions and alternatives are weighty
  enough to deserve a first-class, queryable doc rather than being buried in a
  thread render, *even if* the work also runs now.

**The discriminator is context-transfer, not effort.** A mechanical task is not
plan-worthy merely because it touches many files, once its approach is decided
and validated in-session — hand a fresh agent a fully-solved task and the plan
adds nothing but a re-derivation risk. Conversely, a small but *deferred* or
*cold-handoff* decision is plan-worthy precisely because its context will not
survive. Ask "will the executor share this session's context?" — if yes, execute
and let the commit and capture record it; if no, persist the plan first.

_Source: [`meta/policy/plan-vs-capture.md`](/meta/policy/plan-vs-capture.md)_

**Merge with a true merge commit; never squash or rebase.** The commit graph is
a **provenance layer**, not an implementation detail: session-authored commits
carry the session trailer linking them to the agent session that produced them,
durable docs
(plans, thread docs, logs) cite commits by SHA, and `git blame` is the answer to
"which session changed this and why". A squash-merge lands a brand-new commit
and abandons the originals — severing commit → session traceability and turning
cited SHAs into garbage once the branch is deleted; a rebase-merge rewrites them.
A true merge wires the branch's real history into `main`'s ancestry, so the
cited SHAs stay reachable forever and the branch is safe to delete (see
[why a true merge keeps cited commits reachable](/meta/tutorials/why-a-true-merge-keeps-cited-commits-reachable.md)).

- Agents merging a PR (UI, MCP tools, or API) must use the **merge** method —
  never `squash` or `rebase`, even when they are enabled in repo settings.
- Never rewrite shared history; the usual noise argument for squashing does not
  apply here — agent commits are already atomic and deliberately messaged.
- For a one-line-per-PR reading of `main`, use `git log --first-parent` instead
  of flattening history at the merge boundary.

**The session trailer is harness-injected — protect the setting.** The
`Claude-Session: <url>` git trailer that links a commit to the cloud session
that produced it is added automatically by Claude Code (v2.1.179+) to commits
Claude authors in web sessions, and the PR body gets the session URL on its own
line — no agent action required. Since v2.1.182 the setting
`attribution.sessionUrl: false` disables both. One innocuous-looking line in a
committed settings file would therefore silently sever commit → session
traceability for every future session:

- **Never set `attribution.sessionUrl` to `false`** in any committed settings
  file (`.claude/settings.json` or similar). An agent that finds it set does not
  "clean it up" in either direction silently — it surfaces the finding and
  proposes removal to the operator.

**Known coverage gaps — the trailer is strong evidence, not an invariant.**
Three classes of commit legitimately lack the trailer: commits predating the
feature's arrival in this repo (before 2026-07-07); auto-generated merge
commits (`git merge` default messages, the GitHub merge button) — the harness
injects the trailer only into commit messages Claude authors; and commits from
local-terminal sessions, which are authored under the operator's local git
identity and have no cloud transcript URL. For all of these the **PR is the
fallback anchor**: the PR body carries the session URL, and the thread doc's
`pr:` stamp (see the session-capture policy) links the session record back to
how it landed. Do not treat a missing trailer as evidence a commit bypassed an
agent session.

_Source: [`meta/policy/merge-strategy.md`](/meta/policy/merge-strategy.md)_

**Provenance lives in metadata, not body prose.** A document's sourcing is
already recorded structurally — `provenance` (where the content came from),
`attribution` (how it entered, including the `from` back-link to its thread) —
so the body must not restate it. No "from the first journal entry", no
"distilled from thread X", no "at operator direction" in body prose, and none
in the `index.md` gloss that lists the doc. The body states the knowledge;
the metadata states the origin.

- **The test: does the sentence lose meaning, or only credit, if the reference
  is removed?** A *credit-only* reference is metadata and belongs in
  frontmatter. A *load-bearing* reference — a citation supporting a claim, the
  grounding analysis a doctrine is judged against, a document the reader must
  follow to understand the argument — stays, as a plain cross-link per
  [filenames-and-cross-linking](/meta/policy/filenames-and-cross-linking.md),
  without acknowledgement framing around it.
- **Why.** Acknowledgement prose is a shadow copy of the attribution record:
  unchecked where the metadata is machine-verified, stale-prone where
  governance `from` is append-only, and a leak of record-layer content into
  the knowledge layer (see
  [fit each layer to its purpose](/meta/doctrine/fit-each-layer-to-its-purpose.md)).
  One origin, one home.
- **Scope.** Bundle documents, governance docs, and their index glosses alike.
  Thread docs are exempt — they *are* the record, and their narrative sections
  legitimately speak in terms of who said and did what. Frontmatter fields
  (`provenance`, `attribution.why`) are the sanctioned home for origin prose
  and are untouched by this rule.

_Source: [`meta/policy/provenance-lives-in-metadata.md`](/meta/policy/provenance-lives-in-metadata.md)_

**Choosing the artifact is a second question, not the first.**
[plan-vs-capture](/meta/policy/plan-vs-capture.md) answers *whether* to persist
anything: when this session holds the context and can finish the work, the commit
and the thread capture are the record, and a doc is a redundant third copy. Only
once persistence is warranted does this policy apply — *which* governance type.

**The discriminator.** Ask what the thing fundamentally **is**, not how big it is:

| If the thing is… | File it as | Lives in |
|---|---|---|
| a reasoned judgment answering a question, against evidence | `analysis` | [`meta/analysis/`](/meta/analysis/index.md) |
| a durable explainer meant to be read start to finish | `tutorial` | [`meta/tutorials/`](/meta/tutorials/index.md) |
| something *wrong* — a defect, or a live concern about how the brain behaves | `issue` | [`meta/issues/`](/meta/issues/index.md) |
| work to deliver — a plain task or a whole PR-shaped unit, approach already decided | `matter` | [`meta/matters/`](/meta/matters/index.md) |
| a *proposed change* whose design/decisions must be recorded before executing | `plan` | [`meta/plans/`](/meta/plans/index.md) |
| a standing *direction* that shapes judgment without prescribing an action | `doctrine` | [`meta/doctrine/`](/meta/doctrine/index.md) |
| an enforceable *rule* for how the brain operates | `policy` | [`meta/policy/`](/meta/policy/index.md) |

**The pairs that actually get confused:**

- **issue vs. matter** — an issue is a *problem to diagnose* (something behaves
  wrongly; the fix may not be known). A matter is *work to do* (the approach is
  known; it just needs doing). "Merges keep conflicting" is an issue; "wire the
  hook in the session-start script" is a matter.
- **matter vs. plan** — if the *approach* needs deciding, it is a plan; if only
  the *doing* remains, it is a matter. A plan that would contain no decisions is
  a matter.
- **analysis vs. plan** — an analysis concludes with a *judgment* ("X is the
  better shape, and here is why"); a plan commits to *work* ("build X in this
  order"). An analysis whose residue is action may be retyped as a plan rather
  than duplicated.
- **plan vs. policy** — a plan is a *one-off intended change*; a policy is a
  *standing rule*. If it should bind future sessions, it is a policy.

**Persistence and reach are different axes — choose deliberately.** A `policy`
compiles into `CLAUDE.md` and is therefore in **every** fresh agent's context
automatically; every other governance type is discovered only when something goes
looking ([`/priorities`](/.claude/skills/priorities/SKILL.md),
[`/issue`](/.claude/skills/issue/SKILL.md), [`/plan`](/.claude/skills/plan/SKILL.md),
or a link). So a rule that must fire **unprompted, mid-work** — where an agent
would not know to go looking — belongs in a policy; filing it as a plan or tutorial
leaves it inert. Conversely, keep policies **terse**: the contract is loaded in
full every session, so put the rule in the policy and the reasoning, worked
examples, and background in a cross-linked `tutorial` or `analysis`.

**One artifact per matter.** Per [update-in-place](/meta/policy/update-in-place.md),
search before filing: extend the existing doc when one already covers the matter,
rather than creating a near-duplicate in a different genre.

_Source: [`meta/policy/governance-artifact-routing.md`](/meta/policy/governance-artifact-routing.md)_

**Living text states the present; git narrates the past.** A **living surface** —
code, code comments, operational skills, reference docs, the compiled contract —
is read to act on the system *as it is now*, so every sentence in it should be
true of the present. The commit graph is already the brain's single
change-narrative layer ([merge-strategy](/meta/policy/merge-strategy.md),
[retire-hand-kept-logs](/meta/plans/retire-hand-kept-logs.md)): retrospective
narration embedded in living text — "this used to X", "the old Y", "was removed
in favor of Z" — is a second, hand-kept history layer at comment scale, and it
fails the same way the purged `log.md` files did — it goes stale silently and
gets retrieved and trusted as current state. This is that lesson generalized from
dedicated log *files* down to inline narration.

**The rule.** When you change the system, rewrite the living text to describe the
new present — do not append a note about what it used to be. Git holds the
before; the commit message carries the why-it-changed. The living surface carries
only what is.

**The carve-outs — what is *not* retrospective narration:**

- **Present-tense pointers.** "The appraisal lives behind `/priorities`" tells a
  reader where the functionality *is now* — load-bearing, keep. Test: does the
  sentence tell the reader something they must know to act *today*, or only what
  changed?
- **Chesterton's-fence justifications.** A comment explaining why live code still
  exists ("kept only as the migration reader for X") justifies present code and
  reads as *this is why this exists*, not as a changelog. Keep.
- **Explanatory surfaces where the history is the subject.** A `tutorial` or
  `doctrine` may carry a clearly-marked, bounded history aside when the change
  itself is what it explains. That permission is exactly why operational and
  reference surfaces — read to act, not to learn the backstory — get none.

Records that are historical *by construction* — `plan`, `analysis`, `issue`,
thread docs, `deprecated/`, generated history like `meta/dev-history.md` — are
not living surfaces and are out of scope; narrating the past is their job.

_Source: [`meta/policy/living-text-is-present-tense.md`](/meta/policy/living-text-is-present-tense.md)_

**Prefer established terminology; coin bespoke terms only when nothing
established fits.** When naming a genre, a `type`, an artifact, a mix task, or
a concept, reach for the standard term of art (*flow*, *plan*, *glossary*,
*digest*) before inventing repo-specific vocabulary. Every bespoke term is a
tax on future readers and agents: it must be learned, glossaried, and
disambiguated against the standard term it displaced — and an agent
encountering it cold will guess its meaning from the nearest established sense
anyway.

- **The test.** Before coining, ask: does an established term denote this
  thing, even approximately? An approximate standard term with a one-line
  qualification beats an exact bespoke one (*"flow doc — the touch-sequence of
  a canonical run"* over a novel coinage).
- **When bespoke is warranted** — the concept is genuinely novel to this
  bundle (e.g. *route tag*) — define it in the
  [glossary](/beliefs/glossary/index.md) at first use, with `sense: repo`.
- **No retroactive churn.** An existing name is not renamed to a "better" term
  without operator ratification: renames are shape changes
  ([taxonomy-evolution-protocol](/meta/policy/taxonomy-evolution-protocol.md)),
  and a rename's cost (links, skills, muscle memory) usually exceeds a
  marginal terminology gain.

_Source: [`meta/policy/prefer-established-terminology.md`](/meta/policy/prefer-established-terminology.md)_

**A work item identified mid-session but not executed in it is filed in the
same turn that identifies it — chat is not a backlog.** The moment a session
names work it will not do now — "I'll do X later", "this should eventually
Y", a defect noticed in passing, an edit deferred to a future session — the
item gets a durable home before the turn ends: a `matter`, `plan`, or `issue`
per [governance-artifact-routing](/meta/policy/governance-artifact-routing.md) —
with a row in the [matters register](/meta/matters.md) when the
[matter](/beliefs/glossary/matter.md) is committed to the delivery queue
(an open matter outside the register is backlog). A deferral that
lives only in the conversation has no surfacing mechanism — it survives
exactly as long as someone remembers it
([a surface that must be remembered will be forgotten](/beliefs/remembered-surfaces-are-forgotten-surfaces.md)).

- **Same turn, not at close.**
  [concerns-block-the-close](/meta/policy/concerns-block-the-close.md) binds
  the *closing* flow — its scope line deliberately leaves mid-session
  reporting alone — and its close-time inventory runs on whatever the
  session still remembers. Filing at the naming moment removes the
  remembering step; the close then verifies that filings exist instead of
  performing them. This policy is that rule's mid-session extension.
- **The trigger is naming the deferral, not the item's size.**
  [plan-vs-capture](/meta/policy/plan-vs-capture.md) already forces
  plan-scale deferred work into a persisted plan; this rule closes the
  task-scale gap beneath it — the small "later" too minor for a plan.
  A filing can be a three-line backlog matter or one register row; smallness
  is a reason to file cheaply, never to skip filing.
- **A ledger strand records the deferral; it does not queue it.** A captured
  thread's `open`/`paused` routing rows are the record layer
  ([routing-ledger](/meta/policy/routing-ledger.md)), and the
  [matter-queue plan](/meta/plans/matter-queue-and-present-matters.md)
  rejected them as the work queue. Execution finds work in the filed
  artifacts and the register; an item filed in-turn leaves the eventual
  ledger row simply routing to it.
- **Boundaries.** Work executed in-session needs no filing — the commit and
  the capture record it
  ([plan-vs-capture](/meta/policy/plan-vs-capture.md)). Options offered but
  not chosen are not yet work items; one becomes filable the moment the
  operator picks it and defers it, or the agent commits to it. An item that
  already has a home is pointed at or extended, never re-filed
  ([update-in-place](/meta/policy/update-in-place.md)).
- **Scope.** Agent-identified and operator-directed deferrals alike, in
  every session. How findings are *raised* keeps its existing shape — this
  policy binds the disposition of named work, not the reporting of it.

_Source: [`meta/policy/deferred-work-is-filed.md`](/meta/policy/deferred-work-is-filed.md)_

---

## 4. Communication — composing responses and prose

**Lead with a plainspeak orientation; keep the technical register after it.**
A delivered response of any density — one that reports work, presents a
finding, or leans on artifacts and concepts the operator is not already
holding in mind from the immediate conversation — opens with a short
**plainspeak orientation**: what just happened, where things now stand, and
what (if anything) needs deciding, in common words. The technical
presentation follows at full density, unchanged — the orientation is a
runway to it, never a replacement for it.

- **Onboard before terminology.** The reader must meet the general thrust
  before meeting the terms. Within the orientation, name an artifact by what
  it does before (or alongside) its repo name — "the file that lists every
  merged PR (`meta/dev-history.md`)" — and defer repo coinages to the
  technical half entirely where the plain description carries the point.
- **One presentation, then the other — never interleaved phrase-by-phrase.**
  The orientation is a whole, short account (a paragraph or two), after which
  the technical presentation stands on its own. Phrase-level unpacking is a
  different tool and stays on demand:
  [`/elaborate`](/.claude/skills/elaborate/SKILL.md).
- **The orientation is a derivation, not a second account.** It restates the
  technical content at lower resolution; it must not introduce claims,
  caveats, or decisions the technical half lacks. This is the response-surface
  form of the *one canonical level plus anchored derivations* rule from the
  [three-level documentation plan](/meta/plans/three-level-documentation.md),
  whose committed plain tier serves the same reader on the document surface.
- **Calibrate by density, not length.** Conversational turns, simple answers,
  and responses whose terms are all live in the current exchange need no
  separate orientation — an orientation over three plain sentences is
  ceremony. The trigger is referential density: when following the response
  requires holding artifacts or concepts the conversation has not just
  established, orient first.
- **Placement.** The orientation opens the response, above any
  [work-report tables](/meta/policy/response-work-report-format.md); tables
  and technical prose keep their existing form beneath it.

_Source: [`meta/policy/plainspeak-orientation.md`](/meta/policy/plainspeak-orientation.md)_

**When a turn produces work, report it as a ledger.** A response that creates or
modifies artifacts, or reaches a decision point, closes with tabular sections
rather than narrating the same facts in prose. Tables make what-happened and
what's-open scannable; prose buries them.

**Applies when** the turn created/modified files, took consequential actions, or
needs an operator decision. **Does not apply** to conversational turns, quick
factual answers, or single trivial edits — five empty tables are ceremony. Include
only the sections that have content.

| Section | Holds | Columns |
|---|---|---|
| **What I created** | new artifacts | type · doc · why this type |
| **What I modified** | changed files | file · thrust of the change (one line) |
| **Actions I have taken** | what was already done | action · result |
| **Questions you need to answer** | **blocking** — work cannot proceed without an answer | # · question · my recommendation |
| **Your options from here** | **non-blocking** — directions the operator may pick | # · option · what it entails |

**The rules that make it work:**

- **Prose still carries judgment.** Tables are the ledger of *what happened* and
  *what's open*; analysis, reasoning, and recommendations stay in prose. Never
  compress an argument into a cell.
- **Questions and options are different tables.** A question is *blocking* — the
  agent is stuck without an answer. An option is *non-blocking* — the agent could
  proceed and is offering a direction. Collapsing them hides which one it is.
- **Report in the past tense, not the future.** Work the agent is authorized to do
  is **done before the response**, then reported as completed with its result —
  not announced as an intention ("I'll now…") that makes the operator wait a turn
  for nothing.
- **Past-tense reporting never widens authorization.** The act-then-report rule
  applies only to already-authorized work. Anything irreversible, outward-facing,
  or outside what the operator asked for still requires asking **first** — and per
  [session-capture](/meta/policy/session-capture.md), that ask is ordinary chat
  text, never a UI dialog element.
- **State every recommendation.** Each question carries the agent's recommended
  answer, so the operator can ratify rather than re-derive.
- **No duplication.** A matter appears in exactly one section — a blocking
  question is not restated as an option, and a completed action is not repeated in
  prose above the table.

_Source: [`meta/policy/response-work-report-format.md`](/meta/policy/response-work-report-format.md)_

**Quote primary sources verbatim; mark the boundary between quotation and
synthesis.** When a delivered response or a document body leans on what a
source says — a policy, a doctrine, an external article or post, a code
comment, an operator message — reproduce the load-bearing phrase **verbatim**,
in quotation marks or a blockquote, and follow it immediately with a citation
of the artifact it was quoted from. A reader must never have to wonder whether
a phrase is the source's claim or the agent's synthesis: quoted text is the
source's, everything outside the quotes is the agent's, and the citation makes
the boundary checkable.

- **Citation form follows the surface.** Inside document bodies, cite by
  bundle-absolute markdown link (per
  [filenames-and-cross-linking](/meta/policy/filenames-and-cross-linking.md));
  in delivered responses, link per
  [response-resource-links](/meta/policy/response-resource-links.md) (live URL
  via `mix brain.url`, never a bare repo path); external sources cite their
  URL.
- **Never blend.** Do not paraphrase inside quotation marks, splice two
  passages into one quote, or silently normalize wording. An elision is marked
  (`…`); an insertion is bracketed. If only a paraphrase will fit, drop the
  quotation marks and let it stand as synthesis — attributed, but visibly not
  verbatim.
- **Take the quote from the source's own text, never from a summary of it.** A
  fetch that answers a question in prose can interpolate a comparison the source
  never made, and the interpolation is indistinguishable from a quotation once
  it is in your notes. Before a figure is quoted, or is used to back
  `verified: true`, re-read the source demanding the **verbatim span**; a span
  that cannot be produced does not get quotation marks. Whether the demand
  actually changes what a fetch returns is measured by the
  [fetch fidelity probe](/meta/evals/fetch-fidelity-probe.md).
- **Quote at the phrase, not the page.** The rule serves precision, not bulk:
  lift the shortest span that carries the claim. Wholesale copying stays
  governed by [capture-knowledge-cite-the-source](/meta/policy/capture-knowledge-cite-the-source.md).
- **Beliefs and claims extracted from sources** always retain the verbatim
  source phrase in their body alongside the citation (see the seed beliefs
  under [`/beliefs/`](/beliefs/index.md) for the pattern), so the extraction
  remains auditable against its origin.

_Source: [`meta/policy/quote-primary-sources.md`](/meta/policy/quote-primary-sources.md)_

**Negative findings name their scope.** A statement that something *does not
exist*, *is not stated anywhere*, or *could not be found* is a claim about a
search space, not about the world. Report it **relative to the space actually
searched**. "I found no pricing on the docs site or the corporate site" is
honest and actionable; "no primary source states the price" is a claim about
every source, and is sayable only when the sources were enumerated first.

- **The test: could the reader reconstruct what was checked?** If yes, the
  finding is scoped and a reader can extend the search. If the sentence would
  survive unchanged no matter how little was looked at, it is overclaiming.
- **Escalate before a decision rests on it.** When a negative finding is
  load-bearing — it justifies building something, retracting something, or
  telling the operator a thing is unavailable — enumerate the search space
  first, or say plainly that the enumeration was not done. An unscoped negative
  that turns out false corrupts every artifact built on it.
- **Search returns a finite result set.** Absence within it is evidence about
  the query, not about what exists. Scoped tools — a `site:`-filtered search, a
  grep over one directory, a single fetched page — silently encode a guess
  about where the answer lives; when the guess is wrong the tool reports
  nothing and the guess never surfaces.
- **Scope.** Delivered responses and document bodies alike, including a filed
  `claim` whose content is a non-existence assertion — its body carries the
  search space. Thread renders are exempt (verbatim record).

Distinct from
[negate-only-explicit-cases](/meta/policy/negate-only-explicit-cases.md), which
governs *rhetorical* negation in prose (whether a negative sentence has an
anchor). This governs *epistemic* negation: whether a negative claim has been
earned. A worked example, and the seven-host source map that motivated it, is
in
[Anthropic's primary-source surfaces](/meta/analysis/anthropic-primary-source-surfaces.md).

_Source: [`meta/policy/negative-findings-name-their-scope.md`](/meta/policy/negative-findings-name-their-scope.md)_

**Negate only an explicit case.** A negative statement — "no X", "never Y",
"not by Z-ing" — is a reference: it points at the case it rules out. It earns
its place only when that case is **explicit**: raised in the same document, a
live alternative the reader would otherwise assume, or a standing rule being
overridden. Absent an explicit case, state the rule positively — an unanchored
negation is an orphaned reference, gesturing at an argument the reader cannot
see.

- **The test: can the reader point at what is being negated?** If the case is
  named nearby, assumed by default, or contract-bound elsewhere (link it), the
  negation is anchored and does real work. If answering "who said anything
  about that?" requires context outside the document, recast the sentence as
  the positive rule.
- **Negations fossilize.** An anchored negation loses its anchor when a later
  edit removes the referent — a provenance sweep, a trim, a refactor — and the
  stump reads as an argument with a missing party. An edit that removes a
  negation's referent must recast the negation in the same motion, not leave
  the stump.
- **Scope.** Document bodies, index glosses, and agent responses alike —
  wherever the agent composes prose. Thread renders are exempt (verbatim
  record). Anchored negations remain fully legitimate and load-bearing —
  contrast pairs ("cache, never know"), guardrails negating a named temptation,
  and overrides of stated defaults are the pattern working as intended.

_Source: [`meta/policy/negate-only-explicit-cases.md`](/meta/policy/negate-only-explicit-cases.md)_

**Certain words and phrases are banned from agent-composed prose.** The
register below lists each banned phrase with the *pattern* it exemplifies and
the reason it fails; the ban covers close variants of the pattern, not only the
literal string. Before delivering a response or filing a document, prose that
matches an entry is recast — usually by deleting the framing and stating the
content directly.

- **The register grows organically.** When the operator flags a phrase in
  conversation, [`/ban-phrase`](/.claude/skills/ban-phrase/SKILL.md) appends it
  here with the reasoning from that exchange and recompiles the contract. The
  operator's invocation *is* the ratification — no separate approval pass.
  Agents may propose entries but never add one unflagged.
- **Entries carry their reasoning.** A bare blacklist teaches nothing and
  invites near-miss variants; the reason is what lets an agent recognize the
  pattern in a phrasing the register has never seen.
- **Scope.** Delivered responses, document bodies, and index glosses — wherever
  the agent composes prose. Thread renders are exempt (verbatim record), and so
  is quoted material: a banned phrase inside a verbatim quote stays as its
  source wrote it.

### The register

- **"worth flagging rather than burying" / "worth noting rather than
  burying"** — pattern: *"worth X-ing rather than Y-ing"*, and more broadly
  any framing that advertises the act of communicating instead of
  communicating. If the content were not worth mentioning it would not be in
  the response, so "worth flagging" asserts nothing; and "rather than burying"
  calls attention to a negative case not taken — a failing nobody raised — which
  is the phrase-level form of
  [negate-only-explicit-cases](/meta/policy/negate-only-explicit-cases.md).
  Recast: state the items directly, under a heading if they need prominence.

- **"One process blemish to be transparent about"** — two patterns in one
  phrase, each banned with its variants. *"To be transparent about"* (also "to
  be honest/candid/straight/upfront", "in the interest of transparency", and
  the enumerated-preamble form "two things I want to be straight about:")
  announces the virtue of a disclosure instead of just disclosing: a
  transparent account shows its transparency in the content, so the
  announcement asserts nothing — and it
  implies concealment was a live alternative, an unraised case (the same
  advertising failure as the entry above). *"Blemish"* (also "wart",
  "wrinkle", "minor blip") is the agent pre-grading its own defect as
  cosmetic; severity is the operator's judgment to make, not the author's to
  soften. Recast: name the defect plainly with its concrete consequence, and
  let the facts carry both the candor and the severity.

- **"Before I do this: it's a bigger change than I called it, and it has a
  real cost"** — pattern: *"Before I do X: \<hedge\>"* — pre-action hedging
  that announces revised scope or cost while proceeding anyway, performing
  deliberation without transferring the decision. A revision that could
  change the decision is a **blocking question** (the questions table of
  [response-work-report-format](/meta/policy/response-work-report-format.md);
  at close time,
  [concerns-block-the-close](/meta/policy/concerns-block-the-close.md));
  one that couldn't change it is not said mid-motion. *"It has a real
  cost"* is the sub-pattern of unquantified gravity: asserting a cost
  exists with "real" doing the work a number should. Recast: either halt —
  "this touches ~N files, not the 2 I estimated; proceed?" — or proceed and
  report the measured cost afterward.

- **"That last row is the honest headline."** — pattern: *"that X is the
  honest/real \<headline/story/takeaway\>"* — post-hoc editorial pointing at
  one's own just-delivered content. Two failures. *"Honest"* as a
  discriminator is self-indicting: if the whole response is honest the
  adjective asserts nothing, and if it discriminates, it concedes the rest
  was framed — the self-directed twin of the announced-candor entry above.
  And naming something the headline instead of *making* it the headline
  narrates a structure defect rather than fixing it — per
  [plainspeak-orientation](/meta/policy/plainspeak-orientation.md), the
  outcome leads the response. Recast: move the load-bearing fact into the
  lead and delete the pointer — placement, not commentary, carries emphasis.

- **"let me audit rather than answer from memory"** — pattern: *"let me X
  rather than Y"* where Y is an inferior practice nobody proposed (also
  "verified against merged main rather than assumed") — announcing diligence
  against an unraised lazy alternative, the process-narration form of the
  seed entry's advertising failure. The distinction the phrase gestures at is
  real and is governed by
  [assertions-name-their-basis](/meta/policy/assertions-name-their-basis.md):
  epistemic basis is carried uniformly by citations and plain markers, and a
  case-by-case announcement is precisely what makes the unannounced remainder
  illegible. Recast: do the check silently, then state the fact with its
  basis — "CI is green (both runs completed 08:52)".

- **"I'd rather you hear it from me than find it"** — pattern: *"I'd rather
  you hear it from me than \<discover it yourself\>"* (also "better you hear
  this from me", "you'd have found this anyway, so") — framing a disclosure
  as a courtesy the agent elected to extend. The alternative it names is the
  operator finding out unaided, which asserts that withholding was available
  and declined: the disclosure arrives pre-graded as generous, and the
  operator is cast as receiving a favor rather than a fact. Reporting what
  happened is the baseline the ledger already requires
  ([response-work-report-format](/meta/policy/response-work-report-format.md)),
  and at close time a concern is owed as a blocking question
  ([concerns-block-the-close](/meta/policy/concerns-block-the-close.md)) — so
  the preamble claims credit for meeting an obligation. Structurally it is
  the *"let me X rather than Y"* entry above with the roles swapped: there
  the unraised alternative is the agent's laziness, here it is the operator's
  ignorance. Recast: state the thing and its consequence, with no preamble.

- **"One thing that turned out to matter more than the mechanics:"** —
  pattern: *"the thing that actually/really matters is X"* / *"what turned
  out to matter more than Y was X"* — a self-assigned importance ranking
  preambled before the content, instead of leaving the content and its
  placement to demonstrate the ranking. A valuation is unnecessary if it
  doesn't carry weight: if the point genuinely outweighs what preceded it,
  the reader sees that once it's stated; the preamble either asserts nothing
  (the weight was already going to land) or oversells a point that can't back
  it up alone. The preamble-side twin of the seed entry's "worth flagging"
  failure (self-graded worth asserted instead of shown) and the "honest
  headline" entry's post-hoc twin (pointing at significance instead of
  *making* something the headline via placement, per
  [plainspeak-orientation](/meta/policy/plainspeak-orientation.md)). Recast:
  state the point directly; if it needs prominence, lead with it or give it a
  heading — structure carries the emphasis, not a verdict phrase.

_Source: [`meta/policy/banned-phrases.md`](/meta/policy/banned-phrases.md)_

**A closing flow ends clean or not at all.** Invoking
[`/create-pull-request`](/.claude/skills/create-pull-request/SKILL.md) is the
operator closing the thread. From that moment, every concern the session
still holds — a process irregularity, an improvisation no policy sanctions, a
check that was skipped, a judgment call left open — is a **blocker**: the
flow halts before the irreversible step and the concern is put to the
operator, instead of surfacing in the report after the merge ("one thing I'd
flag…", "two notes on how I worked…"), which converts a finished close back
into an open thread.

- **The test: would the closing report present it as something the operator
  must react to?** Then it blocks now. Before opening the PR — and again
  before merging, for anything that emerged in between — inventory such
  items; if any exist, stop the flow and present them as blocking questions
  with recommendations, per
  [response-work-report-format](/meta/policy/response-work-report-format.md).
- **The disposition is the operator's.** Fix it now, file it as an
  issue/matter, or proceed accepting it — the agent recommends but does not
  choose. Unilaterally filing an issue and mentioning it post-merge is the
  pattern this policy exists to stop.
- **The session's driving question is answered before the close, not after.**
  When the operator's ask has a success criterion ("does a fresh session now
  see it?"), verifying it is part of the work: it runs before `/capture`, so
  the answer lands in the thread doc and the PR. A post-merge "the answer is
  now yes" is work delivered outside every record.
- **Post-capture chat is outside every record — so the close persists or
  points, never deposits.** The closing report postdates the thread capture:
  nothing said only there is discoverable later, and the operator's memory is
  exactly what this system exists to offload. Beyond the completion facts,
  every sentence in a closing report must point at a durable home — the plan,
  a matter, an issue, the thread doc. Next-session context ("for whenever you
  pick this up, step 2 is…") is the failure signature: that content belongs in
  the artifact [`/priorities`](/.claude/skills/priorities/SKILL.md) reads,
  filed before the close, with the close at most pointing at it. A statement
  with no durable home that doesn't warrant one goes unsaid. The operator
  never has to ask "is this persisted, or does it only exist in this thread?"
- **Merged means done.** The post-merge report announces the completed close —
  PR number, merge SHA, thread doc name — and introduces nothing new. A
  trailing wakeup (a CI wait timer, a stray notification) that fires after
  the merge and only confirms completion is cleared silently, with no report
  at all when nothing is actionable.
- **Scope.** Operator-invoked closing flows. Mid-session reporting keeps its
  existing shape — findings raised while work is still open are ordinary
  content, and raising them *early* is exactly what this policy rewards.

_Source: [`meta/policy/concerns-block-the-close.md`](/meta/policy/concerns-block-the-close.md)_

**An assertion the operator might act on names its basis — checked or
recalled.** When a delivered response states a fact, the prose makes the
basis legible: **checked** in this session — cite what was checked ("CI is
green — both `verify` runs completed at 08:52"); or **recalled** from
memory/training — mark it plainly ("from memory, unchecked: …"). The
distinction is carried **uniformly and structurally**, by citations and
markers, so the reader can trust the *absence* of a marker exactly as much
as its presence.

- **The trigger is actionability, not completeness.** Conversational prose
  and reasoning need no markers; a fact that could change what the operator
  does next — a state of CI, a file's contents, a price, a version, a "that
  already merged" — does. When such a fact is cheap to check, check it rather
  than mark it recalled.
- **A recommendation names the premise it would fall with.** A recommendation
  is not a fact and takes no basis marker, but it nearly always rests on one:
  a belief about the operator's setup, the contents of a file, what a skill
  already does. When that premise is **unchecked** *and* the recommendation
  would reverse without it, name it inline ("assuming your sessions run
  Opus-tier, …") or check it before writing the recommendation down —
  checking is usually one tool call, and always cheaper than the round-trip
  it saves. The failure is structural rather than occasional: a
  recommendation is produced *alongside* the options it ranks, so it inherits
  the least verification of anything in the response while being formatted as
  the most decision-relevant. This is what makes the ledger's
  ratify-rather-than-re-derive invitation
  ([response-work-report-format](/meta/policy/response-work-report-format.md))
  safe to accept: the operator can see what the recommendation is standing
  on, instead of having to ask a question to find out.
- **Uniform practice, never episodic narration.** Announcing the diligence
  case-by-case ("let me audit rather than answer from memory" — see the
  banned-phrases register) is the anti-pattern this rule replaces: selective
  announcement implies every unannounced statement has unknown basis, which
  is the opposite of what a basis convention is for.
- **Relation to the neighboring rules.** This is the general case of a
  family:
  [negative-findings-name-their-scope](/meta/policy/negative-findings-name-their-scope.md)
  is its negative-claim instance (the basis of a "not found" is the space
  searched);
  [quote-primary-sources](/meta/policy/quote-primary-sources.md) marks the
  quotation/synthesis boundary;
  [verification-grounding](/meta/policy/verification-grounding.md) encodes
  basis for *filed* statements (`verified`/`verified_by`). This policy covers
  the remaining surface: ephemeral assertions in delivered responses.

_Source: [`meta/policy/assertions-name-their-basis.md`](/meta/policy/assertions-name-their-basis.md)_

**Answer a multi-subject message inline, under quotes of its subjects.** When
an operator message carries more than one subject — several questions,
corrections, or decisions in one message — the response takes the **email
inline-reply form**: each subject's load-bearing passage is quoted verbatim
as a blockquote, and the answer sits directly beneath its quote, keeping the
operator's order. A single-subject message keeps ordinary prose.

- **The quote is the referent, so it is verbatim.** Lift the shortest span
  that identifies the subject (elisions marked `…`); never paraphrase inside
  the quotation — each answer is audited against the operator's own wording.
  This is [quote-primary-sources](/meta/policy/quote-primary-sources.md)
  applied with the operator's message as the source.
- **Answers stay under their quotes.** A subject is answered where it is
  quoted, not deferred to a summary the operator must re-map onto their
  questions; cross-subject synthesis, when needed, follows the interleaved
  body rather than replacing it.
- **Composes with the response conventions, in this order.** A
  [plainspeak orientation](/meta/policy/plainspeak-orientation.md) still
  opens a dense response, above the interleaved body; the
  [work-report tables](/meta/policy/response-work-report-format.md) still
  close it. Decisions argued under a quote appear in the questions table as
  one-line index rows pointing back to their subject — the table stays the
  ledger, the interleaved body keeps the judgment.
- **Scope.** Delivered responses to operator messages. Thread renders keep
  the delivered text verbatim, as always.

_Source: [`meta/policy/inline-reply-quoting.md`](/meta/policy/inline-reply-quoting.md)_

---

## 5. Controlled `type` vocabulary

OKF requires a `type` but registers no vocabulary. This bundle uses a **controlled
list** so the brain stays queryable. It **grows deliberately** — an agent may
propose a new type, but the operator ratifies additions (same as directories).

Seed vocabulary:

- `note` — a distilled idea, observation, or thought.
- `claim` — a statement **asserted but not independently verified** (track status with
  the `verified` field; may graduate to `concept` once confirmed).
- `concept` — a definition or mental model (established/accepted).
- `reference` — external material you have **captured and summarized** (article, doc,
  video, thread). A bare URL becomes a `reference` only once processed.
- `source` — a primary source citation (paper, book, dataset).
- `person` — a person.
- `project` — an active, goal-bounded effort. Used for a system built *outside*
  this repo that incubates here: the hub doc for its specs, research, and design
  decisions, carrying a `status` (`incubating`/`active`/`broken-out`/`dormant`/
  `abandoned`). Distinct from an `area` (ongoing, no end state) and a `plan` (one
  intended change, not a whole system) — a project is a *bounded effort with its
  own body of work* (lives at `projects/<slug>.md`, beside a `projects/<slug>/`
  directory; see the projects-namespace policy).
- `area` — an ongoing responsibility or domain (no end state).
- `snippet` — a reusable command, code fragment, or template.
- `methodology` — a repeatable, prescriptive procedure or playbook: the distilled
  *how-to* for carrying out a recurring task (distinct from a `note`, which merely
  records an idea, and a `concept`, which defines a mental model).
- `visualization` — a **self-contained interactive page** the reader launches to
  manipulate a model directly: an explorable explanation, a live diagram, a
  parameter sweep. Filed as a **document pair** — the `.md` carries the `em:` id,
  the prose, and a `launch` field naming its **same-slug sibling `.html`**, which
  holds the artifact itself (inline CSS and JS, classic `<script>`, no `fetch`, no
  ES modules, no external hosts, so it opens over `file://` with no build step or
  server). Distinct from a `snippet` (a fragment to paste elsewhere, not a page to
  open), a `methodology` (the *how-to* for building one — see
  [explorable-explanations](/knowledge/knowledge-management/technical-communication/explorable-explanations.md)),
  and a `reference` (a capture of *someone else's* material, whereas a
  visualization is authored here). Filing test: *if the reader manipulates it, it
  is a `visualization`; if they read about manipulating it, it is a
  `methodology` or `reference`.* Machine-checked — `mix brain.verify` rejects a
  missing `launch`, or one whose target is absent, non-sibling, or not `.html`.
- `policy` — a governance rule for how the brain operates; the source from which
  `CLAUDE.md` is compiled (lives under `meta/policy/`).
- `tutorial` — a long-form explanatory note meant to be read start to finish (the
  "why"/"how" behind the tooling or a topic); distinct from a terse `note` and from
  a `reference` capture of external material (lives under `meta/tutorials/`).
- `issue` — a tracked operational problem, defect, or open concern about how the
  brain or its tooling/automation behaves, recorded for future reference and
  follow-up. Carries a `status` (`open`/`resolved`/`wontfix`); distinct from a
  `policy` (a rule) and a `note` (a distilled idea) — an issue is a *problem to
  track* (lives under `meta/issues/`).
- `plan` — intended work on the brain or its tooling: a design/decision record for a
  proposed change, capturing motivation, the shape of the change, scope boundaries,
  and open questions, so a future session can execute it. Carries a `status`
  (`proposed`/`accepted`/`in-progress`/`done`/`superseded`); distinct from an `issue`
  (a *problem* to track) and a `methodology` (a *repeatable* how-to) — a plan is a
  *one-off intended change*. Addressed by what it governs: a plan for **this brain
  or its tooling** lives under `meta/plans/`; a plan for a system built **outside**
  this repo lives under `projects/<slug>/` (see the projects-namespace policy).
- `analysis` — a point-in-time evaluation or decision-support write-up: a question
  investigated against evidence (often the live bundle itself), yielding findings and
  a recommendation, filed so the reasoning and its conclusion persist. Distinct from a
  `plan` (intended *work* to execute), a `tutorial` (explanatory *how/why*), and a
  `note` (a distilled idea) — an analysis is a *reasoned judgment on a question*
  (lives under `meta/analysis/`).
- `matter` — the review-quantized unit of work: one coherent intent a
  reviewer can approve or reject as a whole (one matter per PR, per
  [atomic pull requests](/meta/policy/git-atomic-pull-requests.md)), filed
  as a self-contained handoff packet — the intent plus the decisions already
  made, with refs carrying the detail — so a fresh thread can deliver it.
  Spans the scale from a plain small task (a title, a sentence of packet)
  to a plan-emitted build step. Carries a `status`
  (`open`/`done`/`cancelled`) and a `model` — the
  [roster](/meta/model-roster.md) value for the model that should *deliver*
  it, stamped at scoping time and **prospective and advisory**, distinct from
  `provenance`, which retrospectively names the model that *wrote the doc*
  (the determination behind the stamp lives in a `## Model` body section, not
  in frontmatter; the stamp binds matters scoped from its ratification onward,
  and a matter filed before it renders unstamped); when a plan's build order
  emits it, also a `plan` (the bundle-absolute path of that plan) and an
  `order` (integer position in that plan's own sequence) — both keys omitted
  on a standalone matter. Queued-ness is register membership, never a
  status: an open matter listed in [the matter register](/meta/matters.md)
  is committed and globally ordered; an open matter outside it is **backlog**
  (filed, awaiting queueing or pickup). Distinct from a `plan` (a *decision
  record* whose build order emits matters — a matter is the delivery unit
  itself and needs no plan behind it), an `issue` (a tracked *problem* that
  may never become work; an issue spawns a matter when its fix is decided),
  and a `methodology` (a *repeatable* how-to — a matter is done once) — a
  matter is *work to deliver, shaped to fit review* (lives under
  `meta/matters/`, governance namespace, no `em:` id).
- `elaboration` — a persisted expansion of a technical **phrase or short passage**:
  the quoted target, definitions of the terms it uses, and a less technical overview
  of the concepts and actions it describes — produced by `/elaborate` and back-linked
  to its originating session via `attribution.from` once that session is
  captured (`/create-pull-request` stamps it). Distinct from a glossary `concept` (one
  *term*, source-independent) and a `tutorial` (long-form, standalone subject) — an
  elaboration unpacks *one specific mouthful in context* (lives under
  `meta/elaborations/`).
- `doctrine` — a persisted **intention statement**: a guiding principle or direction
  that shapes how the brain and its agents are designed and prioritized — the "why"
  that informs judgment without prescribing a specific enforceable action. Doctrine
  sits *above* policy: a `policy` implements doctrine as a concrete, machine- or
  operator-enforceable rule, and plans, analyses, and priority rankings may cite a
  doctrine as the direction they serve. Distinct from a `policy` (an enforceable
  *rule*), an `analysis` (a *reasoned judgment on a question*), and a `note` (a
  distilled *idea*) — a doctrine is a *standing direction* (lives under
  `meta/doctrine/`). Filing test: teleological (*what standing direction the brain
  serves*) files as `doctrine`; a value-laden prior about the world files as
  `belief`.
- `belief` — an operator-held, value-laden **decision prior**: a statement held
  *true enough to guide action* even where unverifiable, uncertain, or normative.
  Sits **parallel to `doctrine`**, not beneath it — a belief is
  epistemic-with-values ("I hold that the world works this way"), a doctrine is
  teleological (the brain's own standing direction). A `belief` stays **outside
  the verification ladder**: it never carries `verified`; one that turns out to be
  empirically checkable is refiled as a `claim` (and may then graduate) — the type
  boundary *is* the test. Distinct from a `claim` (on the verification ladder,
  expects evidence) and a `note` (not citable as a prior). Filing test:
  *epistemic (what is true) files as `claim`/`concept`; value-laden prior (what I
  act as if is true) files as `belief`; teleological (what standing direction)
  files as `doctrine`.* Beliefs are bundle documents with `em:` ids (live under
  `/beliefs/`).

If nothing fits, propose a new type rather than forcing a bad one.

_Source: [`meta/policy/controlled-type-vocabulary.md`](/meta/policy/controlled-type-vocabulary.md)_

---

## 6. Identity & verification

- **Every bundle document carries a stable `id`** in frontmatter: the bundle's
  id-namespace prefix + 6 lowercase hex chars — currently `em:` (e.g. `em:4c9e1f`).
  The **6-hex tail is the immutable identity**: minted once (`mix brain.id`), never
  changed, and never reused, even if the file moves, is renamed, or is superseded.
  Identity survives refactors; paths don't have to.
- **The prefix is a namespace token, not part of a document's identity.** It is
  **opaque** — nothing may depend on its letters carrying meaning — and it changes
  only by an **operator-ratified, bundle-wide migration** that rewrites every id in
  one deterministic, tail-preserving pass, never per-id. One such migration has
  occurred: **2026-07, the `sb:` prefix → `em:`** (mirroring the repository rename
  second-brain → elixir-mind), swapping the prefix on every id while preserving each
  6-hex tail verbatim, so a historical `sb:`-prefixed token denotes exactly the `em:`
  id sharing its tail. A future prefix change would follow the same
  ratify-then-migrate path; absent one, the prefix is fixed.
- **Typed edges reference ids, not paths.** Structured frontmatter references
  (`verified_by`, and future typed edges) point at stable ids as an inline YAML list.
  Prose links in bodies still use ordinary markdown paths.
- **The per-file `id` is canonical; the registry is compiled.**
  [`meta/registry.md`](/meta/registry.md) — the id → path view — is a generated
  artifact (`mix brain.registry`, checked in CI with `--check`), exactly like
  `CLAUDE.md`. Never hand-edit it.

_Source: [`meta/policy/stable-identity.md`](/meta/policy/stable-identity.md)_

- **Provenance and verification are orthogonal.** `provenance` records where a
  statement came from and is **immutable history** — verifying a statement never
  rewrites its provenance.
- **Verification is only for agent-authored statements.** `verified: true` applies
  to a statement the agent distilled from a thread (a `claim`, `note`, or `concept`)
  and asserts it has been **checked against evidence**. A document that stores a
  link — anything carrying a `resource` — is a **capture**, not a statement:
  verification is **not possible** for it, so a capture never carries `verified`
  (omit the field). `mix brain.verify` rejects `verified: true` on any document that
  has a `resource`, and rejects a `verified` field (either value) on any type
  outside `claim`/`note`/`concept` — the statement-type restriction is
  machine-enforced, not editorial.
- **`verified: true` requires evidence, never its own link.** A verified statement
  must carry a non-empty `verified_by` pointing at the captures (and/or other
  statements) that support it. Storing a `resource` on the statement itself proves
  nothing and is disallowed. `mix brain.verify` enforces both halves.
- **Evidence edges live in `verified_by` only** — an inline list of stable ids whose
  targets must **exist**. Targets are typically `source` captures, which are *not*
  themselves `verified` — they are trusted evidence, not verified statements. Do not
  duplicate the edge list in prose: the verification narrative is **derived on
  demand** (`mix brain.evidence <id>`), never committed, so there is exactly one
  source of truth for what supports a statement.
- **Verify technical claims from primary sources.** Extract the supporting passages
  from authoritative documentation into `type: source` captures (verbatim quotes;
  `resource` = the official URL; provenance = extracted from that resource). The
  capture stores the link and text but is **not** marked `verified`. Aggregate the
  captures via `verified_by` on the claim, which flips the **claim** to
  `verified: true`. A `claim` grounded this way may graduate to `concept`.

_Source: [`meta/policy/verification-grounding.md`](/meta/policy/verification-grounding.md)_

**An agent-authored document names the model that produced it.**
[capability-matched-model-selection](/meta/doctrine/capability-matched-model-selection.md)
directs the strongest models to motions where "the output *is* the judgment and
there is no oracle behind it" — but selection "**cannot be enforced**: it is a
runtime act". Attribution is its enforceable shadow, and this rule fixes where
that shadow falls on a **document**.

**What the commit graph already covers, and what it does not.** The harness
injects `Co-Authored-By: Claude <Name> <Version>` alongside `Claude-Session:` on
commits Claude authors, so the model is already recorded per *commit* for the
majority of this repo's history. Two gaps remain, and they are what this rule
addresses — not the absence of any record:

- **A trailer attributes a commit, not a document.** One commit routinely touches
  several documents written across a session; the trailer assigns all of them to
  one model even where the motions differed in weight. The audit
  capability-matched-model-selection wants is per-artifact.
- **A document is read outside its git history.** On the published site, after a
  move, or when quoted elsewhere, the trailer is not present. A document that
  travels carries only its own frontmatter.

**The rule.**

- **Who records.** An agent-authored **governance** document (under `meta/`) or
  **statement** document (`claim` · `note` · `concept`) whose
  `attribution.channel` is `agent-authored` or `auto-intake` names its producing
  model in `provenance`. An operator-authored document does not; a capture of
  external material attributes its *source*, and names a model only if one
  produced the distillation.
- **One form — the trailer's display form** (`Claude Opus 4.8`,
  `Claude Fable 5`), so the document-level and commit-level records join on the
  same string. Do not coin a second form: a field that reads three ways cannot be
  grepped, counted, or trended, and the repo's existing `provenance` fields
  already split across display names, ids, and bare "Claude Code session".
- **An undisclosed model is stated, never omitted.** A session that cannot
  determine its model, or that runs in an environment withholding the identifier
  from committed artifacts, writes `model undisclosed` in `provenance`. Omission
  and a guess are both defects: omission makes an unattributable document
  indistinguishable from an unremarkable one, and a guess corrupts the field the
  audit reads. This is *silence is not success*
  ([escape-rate plan](/meta/plans/auto-intake-escape-rate-sampling.md)) applied
  to attribution.
- **It is an attestation, not a measurement.** A session writes its own
  identifier; the repository cannot verify it. A checker can establish
  **presence and form**, never truthfulness — so read the field as self-reported
  provenance, evidence about authorship rather than proof of it.
- **Scope is forward-looking.** The rule binds documents filed from its
  ratification onward. The existing corpus is mixed — many agent-authored
  governance documents name no model — and a retrofit sweep is its own decision,
  not an obligation imposed here (the posture
  [structured-plan-bodies](/meta/policy/structured-plan-bodies.md) takes toward
  pre-existing plans).
- **Enforcement is editorial today.** Presence-and-form is mechanically checkable
  and is the natural shape of a future `mix brain.verify` rule or warn-only
  report; until one exists this binds agent judgment, as the oracle-less
  [coding standards](/meta/policy/elixir-coding-standards.md) conventions do. A
  checker earns a gate on the standing admission rule, not automatically.

This refines [resource-attribution](/meta/policy/resource-attribution.md), which
holds that `attribution.agent` names "the **pathway, not the model** (the model
is in the commit trailer)". That division stands: the pathway belongs in
`attribution`, and the model belongs in `provenance` — beside the *content's*
origin, which is what it is. Why it became worth ratifying is recorded in
[three agent-substrate talks read against this brain](/meta/analysis/agent-substrate-talks-read-against-this-brain.md):
under fan-out the reviewing node's tier is the property most worth auditing
afterward, and an unrecorded tier is the audit that cannot be run.

_Source: [`meta/policy/model-attribution.md`](/meta/policy/model-attribution.md)_

---

## 7. Conformance (keep the bundle valid)

A bundle conforms to OKF v0.1 when:

1. Every non-reserved `.md` file has parseable YAML frontmatter.
2. Every frontmatter block has a non-empty `type`.
3. Reserved files (`index.md`, `log.md`) follow their structures when present.

Be a tolerant **consumer**: never reject the bundle for missing optional fields,
unknown types, extra frontmatter keys, broken links, or absent `index.md` files.

_Source: [`meta/policy/okf-conformance.md`](/meta/policy/okf-conformance.md)_

---

## 8. Skills

- **`/intake`** — process pasted content into one or more filed documents. See
  `.claude/skills/intake/SKILL.md`. This is the primary way knowledge enters the
  brain.
- **`/render-contract`** — recompile `CLAUDE.md` from `meta/policy/*.md` after editing
  any policy. See `.claude/skills/render-contract/SKILL.md`. `CLAUDE.md` is a
  generated artifact — never hand-edit it.
- **`/capture`** — persist the current session as a **distilled** thread doc under
  `meta/threads/`: substantive exchanges only (tool calls, reasoning, and short
  pre-tool narration stripped), then a routing ledger and route tags over the frozen
  body. This is the session-persistence skill. See `.claude/skills/capture/SKILL.md`.
- **`/summarize-technical`** — produce a three-part layered breakdown of a technical
  paper/article/spec: a plain-language summary, a glossary of its key technical terms,
  then an integrated technical summary reusing those terms. See
  `.claude/skills/summarize-technical/SKILL.md`.
- **`/elaborate`** — unpack a technical **phrase or short passage** (from the
  conversation, a doc, a commit message, or pasted text): define the terms it uses and
  give a less technical overview of the concepts and actions it describes, delivered
  in chat **and persisted** as a `type: elaboration` doc under
  [`meta/elaborations/`](/meta/elaborations/index.md) (governance namespace, no `em:`
  id; link glossary terms that already exist; hand off to `/add-to-glossary` to
  persist new ones per-term). The doc's `attribution.from` back-link to its
  originating session is set later by `/create-pull-request`, never by this skill.
  The phrase-scale sibling of `/summarize-technical`. See
  `.claude/skills/elaborate/SKILL.md`.
- **`/add-to-glossary`** — scan a persisted thread (`meta/threads/`), a paper, a post,
  or a filed document; extract the technical terms it actually uses; and merge distilled
  definitions into the glossary — **one `concept` document per term** under
  [`/beliefs/glossary/`](/beliefs/glossary/index.md) (hub: [`/beliefs/glossary.md`](/beliefs/glossary.md)), each with
  its own `em:` id and *Seen in:* citations, so any response or document can cite a
  term by link (pointer entries defer to filed documents instead of duplicating them).
  Also invoked automatically by `/create-pull-request` on the thread doc its
  `/capture` step writes. See `.claude/skills/add-to-glossary/SKILL.md`.
- **`/research`** — generate today's **inbox**: a daily candidate feed of research, articles,
  papers, and resources matched against the brain's taxonomy, grouped by category and
  reason-tagged (`recent`/`impactful`/`influential`/`groundbreaking`/`buzz`) — then
  **auto-intake the featured items** into the bundle via `/intake`. The digest is the
  dated record in the non-bundle `inbox/` namespace (no `em:` ids); its featured items
  graduate into filed documents in the same run, bounded to the known tree (items needing
  a new top-level domain are deferred for operator ratification) and attributed
  `channel: auto-intake` for the operator's post-intake editorial pass. See
  `.claude/skills/research/SKILL.md`.
- **`/bookmarks`** — process the **survey tier**: links the operator wants kept but not
  yet fully ingested. The operator drops raw URLs under **Pending** in the register
  (`survey/bookmarks.md`); a bare `/bookmarks` fetches each, writes a one-line summary
  and topical tags, and moves it to **Surveyed** (`status: surveyed`) — a non-bundle
  namespace (no `em:` ids) like `inbox/`. `/bookmarks list [surveyed|promoted|all]`
  reviews the register; `/bookmarks promote <url>` runs `/intake` to distill and file
  the link as a bundle `reference`, then records the graduation on the row. The
  lower-effort staging sibling of `/intake` (see the
  [link-processing](/meta/policy/link-processing.md) survey-tier carve-out). See
  `.claude/skills/bookmarks/SKILL.md`.
- **`/create-pull-request`** — run `/capture` to completion, run `/add-to-glossary`
  over the captured thread doc, **stamp the thread into `attribution.from`** (append
  the just-captured thread's path to the `from` list of every governance doc the
  session created or substantively revised — the append-only carve-out of the
  resource-attribution policy), then commit the current working changes, push the
  branch, and open a pull request — so the frozen thread doc, the glossary updates it
  feeds, and each governance doc's trace back to its session all ship in the same
  PR. Invoking the skill **is** the authorization to open the PR (no separate
  confirmation gate); PR-template detection and the GitHub MCP tools handle the
  rest. **Merging is opt-in, off by default:** a bare invocation ends with the PR
  open and handed back to the operator; passing a `merge` argument
  (`/create-pull-request merge`) has the skill drive CI to green and true-merge it.
  See `.claude/skills/create-pull-request/SKILL.md`.
- **`/sync-branch-with-main`** — fetch `origin/main` and merge it into the current
  working branch, keeping a feature branch current so its diff reflects only its own
  changes and a later PR merges cleanly. Refuses to run on `main`; surfaces conflicts
  rather than blindly resolving them; retries only on network errors. See
  `.claude/skills/sync-branch-with-main/SKILL.md`.
- **`/priorities`** — list the brain's open work as a prioritized appraisal: runs
  `mix brain.session_init` (open issues, open matters, active plans, dangling ledger
  strands) and closes with a heuristic top-3 the agent refines with judgment — the
  on-demand appraisal of open work, produced when asked rather than injected at
  session start. Read-only. See `.claude/skills/priorities/SKILL.md`.
- **`/issue`** — list `type: issue` tracked problems under `meta/issues/`, grouped by
  `status` (default `open`). The issues-only slice of `/priorities`; read-only
  (filing an issue stays inline per the contract). See `.claude/skills/issue/SKILL.md`.
- **`/plan`** — list `type: plan` design/decision records under `meta/plans/`, grouped
  by `status` (default `active` = proposed/accepted/in-progress). The plans-only slice
  of `/priorities`; read-only (persisting a plan stays inline per the persist-plans
  policy). See `.claude/skills/plan/SKILL.md`.
- **`/journal`** — file the operator's daily journal entry: everything following the
  invocation is the entry body, transcribed faithfully (only dictation noise cleaned —
  the operator's voice is inviolable) into a dated `type: note` doc at
  `journal/YYYY-MM-DD.md` (one file per day; same-day additions append). `journal/` is
  a **non-bundle namespace** like `inbox/` and `survey/`: no `em:` ids, no
  `attribution` (machine-enforced exempt), anchored by date rather than inbound
  links, outside the taxonomy — the operator's synthesis practice, on the record
  layer. `/journal list` reviews recent entries; every filed entry receives a
  two-part response by default — an editorial read, then a substantive follow-up
  (the operator opts out per entry: "file only") — delivered in chat and persisted
  verbatim below the entry under a marked `## Response` heading — operator voice
  above, agent voice below, never interleaved. See `.claude/skills/journal/SKILL.md`.
- **`/ban-phrase`** — add an operator-flagged word or phrase to the
  [banned-phrases register](/meta/policy/banned-phrases.md) (verbatim phrase,
  generalized pattern, the reasoning from the flagging exchange, and a recast),
  dedup against existing patterns, and recompile the contract so the entry binds
  every future session; the operator's invocation is the ratification.
  `/ban-phrase list` renders the register read-only. See
  `.claude/skills/ban-phrase/SKILL.md`.
- **`/matter`** — work the [matter register](/meta/matters.md): bare `/matter`
  consumes the top queued matter under the approval-gated protocol (print the
  row and its doc's packet as the record, state the approach, wait for operator
  approval in chat, deliver, then flip the doc `done` and drop the row — the
  landing `pr:` stamped into the done doc at close, once
  `/create-pull-request` opens it, with `mix brain.matters` verifying
  register↔doc agreement and warning on a missing stamp);
  `/matter list [queue|backlog|done|all]` renders the queue and, beneath it,
  the backlog (open matter docs with no register row, sorted by soft integer
  `priority:` where present); `/matter create` files a matter doc under
  [`meta/matters/`](/meta/matters/index.md) — backlog by default, queued only
  when the operator states a position. One matter per PR
  ([atomic-pull-requests](/meta/policy/git-atomic-pull-requests.md)); matter
  docs are governance (no `em:` ids). See `.claude/skills/matter/SKILL.md`.
- **`/scope-unit-of-work`** — scope a described unit of work into the artifacts
  a fresh thread can deliver: either a **single matter** (one reviewable intent,
  approach already decided) or a **plan with sequenced matters** (several
  separately-approvable intents, and/or decisions worth recording first), with
  everything following the invocation taken as the spec. Each emitted matter is
  stamped with the model that should **deliver** it (`model:` frontmatter, the
  determination in a `## Model` body section), chosen per matter from
  [the model roster](/meta/model-roster.md) — the operator's preference data —
  under [capability-matched-model-selection](/meta/doctrine/capability-matched-model-selection.md).
  The unit is filed **unsequenced** (backlog: matter docs, no register row)
  unless invoked as `/scope-unit-of-work sequence`, which is the operator's
  ratification to append it to [the register](/meta/matters.md) — matters
  emitted by a plan always carry that plan's internal `order`, and the queue
  never inverts it. Scopes and stops; delivery stays with `/matter`. See
  `.claude/skills/scope-unit-of-work/SKILL.md`.
- **`/review-pr`** — render an ask-vs-delivered audit of the current session as two
  tables: every request the operator made (with a done/partial/not-done/declined/
  superseded status), and what the agent actually did, with the files touched and
  whether each landed in a commit or is still in the working tree. **Both columns
  rest on artifacts, never on recall**: the asks are enumerated from the session
  transcript (`~/.claude/projects/…/<session-id>.jsonl`) and the delivered work
  from `git log`/`git diff` against `origin/main` — an asks column built from a
  context-compaction summary drops the asks made before the boundary, silently,
  which is the failure the skill exists to catch — so the audit is evidence
  rather than the session's own testimony
  (see [normative records vs. descriptive
  traces](/knowledge/SWE/agentic/supervision/normative-records-vs-descriptive-traces.md));
  gaps in either direction are reported in prose beneath. Read-only — it opens,
  merges, and modifies nothing, and is meant to precede the operator's own PR
  review. See `.claude/skills/review-pr/SKILL.md`.

New skills are added under `.claude/skills/<name>/SKILL.md`.

_Source: [`meta/policy/skills-registry.md`](/meta/policy/skills-registry.md)_

---

## 9. Session capture, routing & route tags

A working session (a **thread**) is non-linear: it touches many matters, pauses
some on open questions, and routes each matter's synthesized content into a
durable per-topic page. **`/capture`** freezes that session into a readable
record so it can be resumed from the record instead of from memory.

- **On demand, not a hook.** Capture is an agent-invoked skill you run once, at
  session close (or when you say "capture this") — never a per-turn hook. See
  `.claude/skills/capture/SKILL.md`.
- **Retained text is verbatim; only the noise is stripped.** Keep **every
  exchange** and drop *only*: tool calls and results; reasoning/thinking; and an
  assistant text block that is *both* under ~300 chars *and* followed by a tool
  call (short pre-tool narration). **Everything kept is reproduced verbatim** —
  the delivered text of each operator message and agent response, never summarized
  or paraphrased. Everything else is kept — any longer block, any block *in
  isolation* (nothing after it in the turn calls a tool: a closing reply or
  standalone remark) **even when short**, and all text in a tool-less turn.
  Operator messages are kept as said, minus empty ones and `<…>`-prefixed
  system/slash wrappers. The drop rule is exactly cb `transcript_hook.py`'s
  `len < 300 and followed_by_tool`. "Distilled" here means the *noise* is dropped,
  not that the kept text is condensed; `/capture` strips noise, not substance, and
  is the sole session-persistence skill.
- **Interact with the operator in the chat, not a UI element — this covers
  permission requests too.** Pose every question, and every request for
  permission or approval, to the operator as ordinary `## Assistant` chat
  text — never rely on a UI dialog element (the `AskUserQuestion` question box,
  or a tool-permission popup) as the channel. `/capture` renders only the
  delivered message stream, so anything raised in a dialog element, and the
  answer the operator gives in it, never enter that stream: both are lost from
  the thread doc and every downstream artifact routed from it. Keeping the
  exchange inline is what lets capture retain it verbatim. The UI elements have
  also proven **flaky** in these sessions — a tool-permission popup can misfire
  and register as a rejection the operator never made — so routine tools are
  allowlisted in [`.claude/settings.json`](/.claude/settings.json)
  (`permissions.allow`) to keep that popup out of the loop, and any decision the
  agent still needs is asked in text.
- **The output is a thread doc** at `meta/threads/YYYY-MM-DD-<slug>.md`,
  `type: reference`, in the governance namespace (no `em:` id). It carries, in
  order: frontmatter, a short narrative section (what the session was, where it
  landed), the **routing ledger** (`## Routing`), then the `## User`/`##
  Assistant` render body. Route tags are applied last, over the now-frozen body.
- **Update in place: a continued session appends to its existing thread doc.**
  A session that is captured and PR'd, then continues, extends that **same**
  file rather than opening a second one — the blocks already written stay
  frozen, and only the un-captured exchanges are appended.
  **Derive the append boundary; never recall it.** The doc's final rendered
  block *is* the boundary: `mix brain.thread_tail <path>` prints it, and
  locating that text in the session log yields exactly the remainder. Recalling
  where the previous capture stopped is what silently drops exchanges — the
  render stays well-formed either way, so the miss is invisible until someone
  counts. (Filed as the general case in
  [a surface that must be remembered will be forgotten](/beliefs/remembered-surfaces-are-forgotten-surfaces.md).)
- **The thread records its PR (`pr:`), not its branch.** Once the session's PR
  is opened, its number is stamped into the thread's frontmatter as `pr: <N>`
  (set by `/create-pull-request`, not `/capture` — the number doesn't exist
  until the PR is opened). The **PR is the durable anchor**: session branches
  are ephemeral and deleted after merge (per the git-branch-deletion policy),
  and the pre-policy squash era left the original branch commits unreachable
  entirely — so the PR number is the only stable link from a thread back to how
  it landed. The branch name is deliberately **not** recorded.
  - **`pr:` is write-once — it records the *origin* PR, and a session that spans
    several PRs keeps that origin.** When a session is captured and PR'd, then
    continues — later turns extend the *same* thread doc in place (per the
    [session-capture](/meta/policy/session-capture.md) update-in-place rule) and
    land in a *follow-up* PR — the thread's `pr:` is **not** rewritten to the new
    number. It stays the PR in which the thread doc was first opened and stamped;
    the follow-up PR(s) are recorded in the thread's **narrative prose**, not in
    frontmatter. The reasoning: the origin `pr:` is already relied upon downstream
    — governance docs cite the thread by its origin landing, cross-links and git
    history reference it — so overwriting it would orphan that linkage and defeat
    the anchor's one job, a stable link back to how the thread first landed.
    Follow-up PRs stay discoverable through the thread doc's own commit history,
    and naming them in prose keeps the human reader oriented without a
    multi-valued frontmatter field. (This refines `/create-pull-request`'s
    "stamp `pr:`" step: stamp on the *first* PR that opens the thread; on a
    later PR that only re-touches an already-stamped thread, record it in prose
    instead.)
- **The thread also records its session (`session:`) — the full-fidelity escape
  hatch.** At capture time, `/capture` stamps the cloud session's transcript URL
  into the thread's frontmatter as `session: <url>`, derived from the
  `CLAUDE_CODE_REMOTE_SESSION_ID` environment variable (the id's `cse_` prefix
  becomes the URL's `session_` prefix:
  `https://claude.ai/code/session_<tail>`). The thread doc is the *distilled*
  record; the session URL points at the *raw* transcript on claude.ai — useful
  precisely when the distillation turns out to have dropped something later
  needed. It is deliberately the **weaker anchor**: account-bound (viewable only
  by the operator logged into claude.ai, unreadable by agents), and deletable —
  it complements `pr:`, never substitutes for it. Write-once at capture, never
  rewritten. When the variable is unset (local-terminal sessions have no cloud
  transcript), the key is **omitted** — never invented, never guessed.
  Threads captured before this rule were backfilled **only from recorded
  evidence** — a thread's own capture commit carries the `Claude-Session:`
  trailer, and a squash-era thread whose trailer was lost recovers the URL from
  its PR body (found via the thread's `pr:` anchor). A thread predating the
  trailer feature entirely, or produced by a local-terminal session, has no
  recorded URL and correctly stays bare. Backfill from recorded evidence only;
  never infer or guess a URL for a thread that lacks one.
- **Freeze then tag.** Because capture runs once at close, the body is frozen
  when written; tagging and ledger upkeep are one finalization motion over that
  frozen body, not a per-turn rewrite.

_Source: [`meta/policy/session-capture.md`](/meta/policy/session-capture.md)_

Every captured thread carries a **`## Routing`** section: a per-thread dispatch
table with one row per topic the session touched. It is a **router, never a
digest** — it answers exactly one question: *what would I need to know to reply
to this thread without re-reading it?*

Four columns:

| Column | Holds |
|--------|-------|
| **Topic** | what the strand is about, one line |
| **State** | `open` (live) · `paused` (waiting on a dangling question) · `closed` (resolved; nothing further expected) |
| **Routed to** | a markdown link to the document that absorbed the strand's content, or `unrouted` |
| **Dangling** | the open question, when `open`/`paused` (else `-`) |

- **Pointers and states only — never content.** Synthesized content lands in the
  routed-to document; if it also lived in the ledger the ledger would become
  a stale shadow copy of that doc. State (the strand) and routed-to (the
  dispatch) are orthogonal: a strand can be routed yet still `open`, or `closed`
  and `unrouted`.
- **Routed-to targets are documents** — bundle or governance, of any `type` —
  linked by bundle-absolute path (e.g. `[foo](/knowledge/SWE/…/foo.md)`). The
  route-tagging cross-check reads this column to confirm every row routed to a
  **bundle** document (one carrying a stable `em:` id) is covered by a tag;
  governance targets carry no id and drop out of that check (see the
  route-tagging policy).
- **In-doc, maintained at capture time.** The ledger is a section of the thread
  doc itself (not a sibling file), written and updated by `/capture` in the same
  motion that routes content — routing and ledger update are one act, not a
  regeneration step that can be forgotten.

_Source: [`meta/policy/routing-ledger.md`](/meta/policy/routing-ledger.md)_

Mark each region of a finalized thread body with the document(s) its content
feeds, so a matter's cross-thread discussion aggregates into one place. The tag
is an inline `<routes ref="...">` region, applied over the **frozen** body as
the last motion of `/capture`.

```
<routes ref="em:4c9e1f lib/elixir_mind/route_tags.ex">
... one paragraph, feeding a document and back-linking a code path ...
</routes>
```

Settled properties:

- **Keyed on canonical ids, never free-text topics.** A ref is a document's
  stable **`em:` id** (the aggregating sink — it accretes the log) or a **path**
  (a non-aggregating back-link to code or a file — no log). Ids, not phrases, so
  two threads about the same matter emit the same string and the cross-thread
  join is exact. This mirrors the identity rule that typed edges reference ids,
  not paths.
- **Per-paragraph, multi-ref, lifted whole.** A paragraph feeding two matters
  carries both refs on one region (never nested regions). The tag boundary *is*
  the auditable selection — no within-region trimming. A region must not cross a
  `## User`/`## Assistant` turn boundary.

**The doc-side log.** Each referenced document carries a
**`## Thread excerpts — route-tagged log`** section: an append-only, per-thread,
date-stamped block for every thread that tags it, each block lifting the tagged
regions whole (ATX headers demoted to bold). Each block quotes a *frozen* thread,
so it never goes stale; the section is **generated, not hand-kept** — `mix
brain.route_tags --materialize` writes it from the current tags.

**The verifier owns it.** `mix brain.route_tags` (see `ElixirMind.RouteTags`)
runs beside `mix brain.verify` in CI and the pre-commit hook. It re-derives each
sink's log from the current tags and **fails on divergence**, converting the
log's freshness from procedural to structural, and checks tag wellformedness,
ref resolution, and per-sink block presence. Tag *coverage* — whether every
feeding paragraph was tagged — has no mechanical oracle and stays editorial; a
routing-ledger cross-check lifts it to row granularity and **warns** (never
fails).

**Freeze on matter-resolution.** A document accepts new excerpt blocks while its
matter is unresolved and freezes acceptance when the matter resolves — per
matter, not on archival.

_Source: [`meta/policy/route-tagging.md`](/meta/policy/route-tagging.md)_

**A thread carries one scoped unit, and revision of what it delivered enters
as a new one.** The enforceable half of
[scoped units, corrected forward](/meta/doctrine/scoped-units-corrected-forward.md):
narrated revision instructions are the last class of decision that lives only
in a transcript, and they reach one instance where a scoped correction reaches
the type.

- **Two entry points, once.** A working thread begins either by delivering a
  queued [matter](/beliefs/glossary/matter.md)
  ([`/matter`](/.claude/skills/matter/SKILL.md)) or by scoping a described unit
  ([`/scope-unit-of-work`](/.claude/skills/scope-unit-of-work/SKILL.md)) —
  which may be persisted for a later thread or executed in this one. The thread
  does not take on a second unit.
- **What may join the thread.** Only two things: **revision matters** that
  extend the initial unit's implementation, and **infrastructure the thread's
  own context requires**. No matter is executed or defined that does not
  naturally extend from one of those. A thread so shaped is *topic-canonical* —
  a unit, its implementation, the revision matters it authored, and the
  infrastructure it needed — and lands as one pull request.
- **No narrated feedback on work the thread has done.** A change to what this
  thread already produced enters as a new `/scope-unit-of-work` unit, not as
  instructions in the conversation. The pull request stands as written; the
  correction is a following unit.
- **In-flight completion is not revision.** Before the unit's pull request is
  opened, correcting work *inside its approved scope*, and fixing anything the
  gate suite rejects, is part of delivering it. The test is one question: was
  it in the approved scope and done wrong (finish it), or outside it (scope
  it)? The write-run-fix loop of a single delivery is never a revision.
- **A revision identified at review time is filed before the pull request
  merges.** Correcting forward requires the forward correction to exist as an
  artifact; otherwise accepted bloat becomes permanent bloat. This extends
  [concerns block the close](/meta/policy/concerns-block-the-close.md) one step
  past the open.
- **Artifact count is not evidence of overhead.** If what was filed is
  necessary under these rules, it is necessary. Suspected duplication or
  inefficiency is scoped as an *analysis of the system*, never resolved by
  suppressing artifacts mid-thread.

**Queue position — binds all queueing, not only revisions.** A matter is
sequenced at the **head** of [the register](/meta/matters.md) by default, and
placed lower only when it genuinely requires preceding rows to land first
(a plan's internal `order` is such a dependency and is never inverted).
**Nothing is appended to the tail.** Tail-parking encodes "I don't want to
forget this but cannot rank it", which is precisely an **unsequenced backlog
matter** — filed, findable, unranked. Reserving the register for head
insertions and stated dependencies is what makes its order carry real
prioritization: every row was either the top priority when queued, or as high
as its dependencies allowed.

_Source: [`meta/policy/revision-enters-through-scoping.md`](/meta/policy/revision-enters-through-scoping.md)_

---

## 10. Git workflow

- **Session branches are ephemeral; the default branch is durable.** Work enters
  the repo on a short-lived head branch (e.g. `claude/<slug>`) and lands in the
  default branch via a pull request. The branch is scaffolding, not history — the
  merge is the record.
- **Delete the head branch when its PR merges.** A merged branch is fully contained
  in the default branch's history, so deleting it loses nothing (its commits stay
  reachable through the merge, and GitHub can restore the branch). Deletion is part
  of the merge motion: prefer the repository's **"Automatically delete head
  branches"** setting; failing that, delete the branch manually right after
  merging.
- **Deletion belongs to the merge motion, not to later sessions.** A merged
  branch noticed in passing is left alone: cleaning up someone else's leftovers
  is not part of the work at hand, and surveying branches to find them turns an
  unrelated session into an audit. Sweeping merged branches is its own
  deliberate cleanup task, run when the operator asks for one — and a session
  that is not that task does not survey, propose, or report on branch state.
- **Never delete without the operator:** the default branch (never), and any branch
  carrying **unmerged** commits — including branches whose PR was closed without
  merging. Those hold work with no other home; propose deletion and wait for the
  operator to ratify, as with any destructive change.

_Source: [`meta/policy/git-branch-deletion.md`](/meta/policy/git-branch-deletion.md)_

**One matter per pull request.** A **matter** is one coherent intent a
reviewer can approve or reject as a whole: an intake batch on one subject, a
policy adoption, an analysis, a feature with its tests, a refactor. The test
is independence — *if the operator could plausibly want to merge one part
while rejecting another, those are two matters.* This implements the
delivery half of [verified increments](/meta/doctrine/verified-increments.md):
generation is cheap and review attention is the bottleneck, so work is shaped
to fit review, not batched to amortize it.

- **Size is a signal, never the gate.** There is no line cap: a large diff
  carrying one mechanical intent — a rename, a regeneration, a format sweep,
  a verbatim thread capture — is one reviewable decision, while a small diff
  carrying two separable decisions still splits. Treat unexplained bulk as a
  smell to justify, not a threshold to enforce.
- **Splits stop at the green boundary.** Never split where each half cannot
  compile and pass the suite alone, and never sever a change from its tests —
  atomicity in the one-matter sense outranks smallness.
- **Generated artifacts ride their source change.** A contract recompile
  travels with its policy edit, the registry with its minting, index updates
  with their filing — a regeneration is part of the matter that caused it.
- **Sessions deliver sequentially.** Finish a matter, open its PR
  (`/create-pull-request`, scoped to that matter), and start the next matter
  after it lands; a session holding several finished, unmerged matters says
  so and hands the remainder to the operator instead of silently widening the
  open PR. Follow-up PRs from one session are the expected shape — the thread
  doc's `pr:` stays the origin PR and later PRs land in narrative prose, per
  the session-capture policy.
- **The daily `/research` run is one matter by construction** (digest plus its
  auto-intakes), as is any operator-directed batch with a single stated
  purpose.

_Source: [`meta/policy/git-atomic-pull-requests.md`](/meta/policy/git-atomic-pull-requests.md)_

---

## 11. Elixir tooling — coding standards

**This contract is the coding-standards file.** The Elixir tooling (`lib/`,
`test/`, the `mix brain.*` tasks) is held to the same anti-drift bar as the
bundle it maintains: an agent reaches for whatever pattern it has already seen,
so yesterday's substandard addition becomes tomorrow's precedent unless a
standard announces the violation. The repo's answer is the one it applies to
knowledge: every standard with a **mechanical oracle** is a
[gate](/meta/tutorials/the-gate-suite-and-where-it-runs.md); standards without
one are written here. **A recurring agent miss is fixed by updating this policy
and recompiling the contract, never only in the offending change** — a miss
fixed only in-line is a miss re-fixed forever. (Absorbed from
[Guarding Against AI Drift](/knowledge/SWE/agentic/code-quality/guarding-against-ai-drift.md)
and the transferable half of
[Zornek's LocalCents standards](/knowledge/SWE/agentic/code-quality/elixir-coding-conventions-localcents.md).)

**The structural layer — build gates.** Warnings are non-negotiable in both
compilation and tests (`mix compile --warnings-as-errors`,
`mix test --warnings-as-errors`); source is canonically formatted
(`mix format --check-formatted`); and compile-time coupling between modules is
banned outright (`mix xref graph --label compile-connected --fail-above 0` —
the count is zero today and the gate keeps it there). CI additionally lints its
own workflow files with **actionlint**.

**Admission rule for new guardrails.** A check earns a gate when its **signal
beats its upkeep** *and* it runs offline as a plain `mix` task with no
dependencies (per
[why the toolchain runs offline](/meta/tutorials/why-the-toolchain-runs-offline.md)).
One carve-out: hygiene checks on CI's own configuration (actionlint) run
CI-only, since their subject exists only there. The **intentional gaps** are
deliberate, not oversights: no Credo, no Dialyzer, no Sobelow/mix_audit, no
CI-gated coverage — each would break the zero-dependency stance for signal the
small `lib/` doesn't yet warrant (and coverage stays exploratory, never a gate,
on the merits). Re-evaluate if the toolchain ever takes on dependencies or
`lib/` grows past what review holds.

**The bundle's constraint checks stay hand-written Elixir; no declarative
shapes layer.** `mix brain.verify` (with the route-tag and glossary verifiers)
already *is* a closed-world constraint checker over the bundle's typed graph —
controlled value sets, type-disjointness, conditional cardinality, and
referential integrity across `em:` ids. Re-expressing those rules in a
declarative constraint language ([SHACL](/beliefs/glossary/shacl.md) over
RDF.ex/SPARQL.ex, or any equivalent) is **declined**, not deferred: it would add
dependencies and a graph-materialization step to buy declarativeness the numbered
moduledoc already provides. This gap is bounded by *authorship*, not size — it
holds while the shapes are few, stable, and written by the same people who write
the verifier, and is worth re-opening only if domain constraints ever churn
rapidly or come from authors who do not write Elixir. Grounded in the
[ontology-guardrails analysis](/meta/analysis/ontology-guardrails-vs-schema-validation.md).

**Conventions (editorial — no oracle, so hold the line in review):**

- **`@impl` names the behaviour; never `@impl true`.** Every `run/1` carries
  `@impl Mix.Task` (the codebase already conforms); a future behaviour callback
  names its behaviour the same way.
- **Name `@spec` arguments whose type doesn't reveal their role.** The test:
  can a reader tell what the argument is from its type alone? If not
  (`binary()`, `String.t()`, `integer()`, `map()`, `keyword()`, `term()`),
  write `name :: type`, matching the function's actual parameter name. Leave a
  self-describing domain type bare (`Policy.t()`, `DateTime.t()`) unless two of
  the same type sit side by side. When a spec wraps, stack one argument per
  line with the return type on its own line after `::`.
- **Moduledocs are load-bearing.** `mix brain.codemap` compiles
  [`meta/code-map.md`](/meta/code-map.md) from them, so a moduledoc is written
  summary-first and carries the *why*, not a restatement of the code; editing
  one means regenerating the code map (the freshness gate catches the miss).
- **Don't restate what a `@spec` already states.** `@doc` prose carries
  behavior and the *condition* under which each branch happens — named
  semantically ("a `:stale` result when the artifact lags its sources"), never
  a transcription of the return tuple.
- **Comments carry durable *why* and never restate the signature.** Future-work
  asides become `meta/matters/` or `meta/issues/` entries, not `TODO` comments.
- **Discard an ignored return with `_ = expr`** so the disinterest is explicit,
  never a bare dangling expression.
- **Test through the narrowest public surface** — a module's API or the mix
  task boundary — reaching into internals only for a guarantee the surface
  can't express; flows get scenario tests (see the
  [testing methodology](/knowledge/SWE/testing/elixir-mind-testing-methodology.md)).

_Source: [`meta/policy/elixir-coding-standards.md`](/meta/policy/elixir-coding-standards.md)_
