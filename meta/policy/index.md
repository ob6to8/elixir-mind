# Policy

Governance rules as first-class OKF documents (`type: policy`). These are the
**source of truth** for the operating contract: `/CLAUDE.md` is compiled from them via
`mix brain.contract`. Edit policy here — never hand-edit `CLAUDE.md`.

Each policy declares the contract `section` it renders into and its `order` within
that section.

This directory stays flat, so filenames carry the grouping: when several policies
govern one domain, they share a kebab-case filename prefix (e.g. `git-`) so the
domain reads as a group in listings. Single-policy domains adopt the prefix from
the start if siblings are plausible.

## composition
- [document-anatomy](/meta/policy/document-anatomy.md) — the repo root is the bundle; a document is frontmatter + body; ID is path minus `.md`
- [frontmatter-schema](/meta/policy/frontmatter-schema.md) — the controlled frontmatter fields and their requirement levels
- [resource-attribution](/meta/policy/resource-attribution.md) — the `attribution` map: the ingestion event (when/channel/agent/why, plus governance `from`) recorded on every doc
- [reserved-filenames](/meta/policy/reserved-filenames.md) — `index.md` structure; `log.md` reserved by OKF but not kept in this bundle

## directory-structure
- [directory-hierarchy](/meta/policy/directory-hierarchy.md) — unix-like, kebab-case; create the natural path even for one document
- [tree-is-the-taxonomy](/meta/policy/tree-is-the-taxonomy.md) — the tree + `index.md` files are the canonical taxonomy
- [taxonomy-evolution-protocol](/meta/policy/taxonomy-evolution-protocol.md) — subdirs autonomous; new top-level dirs ratified

## filing
- [capture-knowledge-cite-the-source](/meta/policy/capture-knowledge-cite-the-source.md) — capture the distilled knowledge, keep the raw source as a citation (the knowledge-layer half of [fit each layer to its purpose](/meta/doctrine/fit-each-layer-to-its-purpose.md))
- [update-in-place](/meta/policy/update-in-place.md) — search first; update rather than fragment
- [filenames-and-cross-linking](/meta/policy/filenames-and-cross-linking.md) — kebab-case slugs; bundle-absolute links
- [response-resource-links](/meta/policy/response-resource-links.md) — Pages links in docs, GitHub links in agent threads: delivered responses cite the GitHub blob URL (branch while unmerged, `main` after), viewable at any merge state; doc bodies keep bundle-absolute paths the site renders, with the Pages URL as the durable citation for merged docs
- [link-processing](/meta/policy/link-processing.md) — links enter only once processed; summarize oversized sources
- [maintain-reserved-files](/meta/policy/maintain-reserved-files.md) — update `index.md` after filing; the commit carries the change narrative
- [persist-plans](/meta/policy/persist-plans.md) — approved plans are persisted as `type: plan` docs under `meta/plans/`, not left in chat
- [structured-plan-bodies](/meta/policy/structured-plan-bodies.md) — a plan's shape is encoded as trees, file-tree diffs, and signatures at outline level; prose keeps the problem, rationale, alternatives, and open questions
- [plan-vs-capture](/meta/policy/plan-vs-capture.md) — persist a prospective plan only for deferred/cold-handoff/cross-session work; in-session work is recorded by its commit and thread capture
- [merge-strategy](/meta/policy/merge-strategy.md) — PRs land via a true merge commit only; squash/rebase disallowed because commit history is provenance
- [provenance-lives-in-metadata](/meta/policy/provenance-lives-in-metadata.md) — bodies and index glosses never restate sourcing the frontmatter already records; a source appears in prose only as a plain link when it is load-bearing content (the test: does removing it lose meaning, or only credit?)
- [negate-only-explicit-cases](/meta/policy/negate-only-explicit-cases.md) — a negative statement earns its place only when the case it negates is explicit (raised in-document, a default the reader would assume, or a rule being overridden); otherwise state the rule positively, and an edit that removes a negation's referent recasts the negation in the same motion
- [governance-artifact-routing](/meta/policy/governance-artifact-routing.md) — which governance type to file (analysis/tutorial/issue/todo/plan/doctrine/policy), downstream of plan-vs-capture
- [response-work-report-format](/meta/policy/response-work-report-format.md) — report work in tables (created/modified/actions/questions/options), past tense, prose for judgment
- [living-text-is-present-tense](/meta/policy/living-text-is-present-tense.md) — living surfaces state the present; retrospective "used to…" narration belongs in the commit graph, not inline
- [quote-primary-sources](/meta/policy/quote-primary-sources.md) — load-bearing source phrases are reproduced verbatim and immediately cited, so quotation and synthesis are never confusable
- [prefer-established-terminology](/meta/policy/prefer-established-terminology.md) — standard terms of art over bespoke coinages; bespoke terms are glossaried at first use and never churned retroactively

## type-vocabulary
- [controlled-type-vocabulary](/meta/policy/controlled-type-vocabulary.md) — the controlled, deliberately-growing list of document `type` values

## verification
- [stable-identity](/meta/policy/stable-identity.md) — immutable `em:xxxxxx` ids; edges reference ids; `meta/registry.md` is compiled
- [verification-grounding](/meta/policy/verification-grounding.md) — provenance immutable; `verified` requires grounding; evidence edges live only in `verified_by`

## conformance
- [okf-conformance](/meta/policy/okf-conformance.md) — the OKF v0.1 conformance conditions

## skills
- [skills-registry](/meta/policy/skills-registry.md) — available skills and where new ones go

## session-workflow
- [session-capture](/meta/policy/session-capture.md) — `/capture` renders a session into a distilled thread doc, on demand
- [routing-ledger](/meta/policy/routing-ledger.md) — the per-thread `## Routing` dispatch table (pointers and states only)
- [route-tagging](/meta/policy/route-tagging.md) — `<routes ref="em:…">` tags materialize a re-derivable excerpt log into each referenced document

## git-workflow
- [git-branch-deletion](/meta/policy/git-branch-deletion.md) — head branches are deleted on PR merge; the default branch and unmerged branches need operator approval

## tooling-standards
- [elixir-coding-standards](/meta/policy/elixir-coding-standards.md) — coding conventions for the Elixir tooling and the admission rule for new guardrails; a recurring agent miss updates this policy, never only the offending change
