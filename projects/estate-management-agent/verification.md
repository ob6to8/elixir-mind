---
id: em:a56a3f
type: plan
title: "Estate management agent — verification architecture"
description: What the estate register borrows from elixir-mind — mint-once identity, a controlled ontology, evidence-backed facts, attributed ingestion, machine gates, generated artifacts, and a review-gated commit history — with the estate-specific ontology draft, the verify rule families, and the pieces that deliberately do not transfer.
status: proposed
tags: [projects, estate-management, verification, ontology, provenance, gates]
timestamp: 2026-08-11
attribution:
  when: 2026-08-11T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed estate-agent speccing session"
  why: "the project's founding verification record: the elixir-mind lending mapped concretely before any code exists"
---

# Estate management agent — verification architecture

The system incubates inside a repo that already runs the architecture it
needs: a machine-checked bundle of typed text documents with stable ids,
evidence-backed statements, attributed ingestion, freshness-gated generated
artifacts, and a commit graph kept as provenance. This record maps that
architecture onto the estate register — because an estate register *is* a
knowledge bundle: slow-changing structural facts, a high cost of silent
error, change bottlenecked on review — whose stakes happen to be titling and
beneficiaries rather than beliefs.

## The mapping

| elixir-mind | estate register |
|---|---|
| `em:` ids, minted once, never reused ([stable-identity](/meta/policy/stable-identity.md), `mix brain.id`) | record ids under the same contract; identity survives renames, refactors, retitles |
| controlled `type` vocabulary, growth by ratification ([controlled-type-vocabulary](/meta/policy/controlled-type-vocabulary.md)) | the ontology below, growth ratified by the principal |
| frontmatter schema + `mix brain.verify` ([frontmatter-schema](/meta/policy/frontmatter-schema.md)) | a record schema + `mix estate.verify`, rule families below |
| `claim` → `verified_by` → `source` captures ([verification-grounding](/meta/policy/verification-grounding.md), `mix brain.evidence`) | facts evidenced by captured documents: a titling record cites the statement; an extracted term cites instrument, page, and section |
| `attribution` — the immutable ingestion event ([resource-attribution](/meta/policy/resource-attribution.md)) | a per-record ingestion event; channels: `statement-import` · `document-scan` · `principal-stated` · `professional-provided` · `backfill` |
| [update-in-place](/meta/policy/update-in-place.md) | one record per real-world referent, merged rather than fragmented |
| the tree is the taxonomy, surfaced by `index.md` ([tree-is-the-taxonomy](/meta/policy/tree-is-the-taxonomy.md)) | a register tree by entity and domain, with compiled indexes |
| generated artifacts with freshness gates (`CLAUDE.md`, [the registry](/meta/registry.md), the code map) | the net-worth statement, funding report, readiness report, meeting packets, and executor binder — compiled, stamped, never hand-edited |
| policies compiled into the operating contract ([/render-contract](/.claude/skills/render-contract/SKILL.md)) | mandates compiled into the agent's operating context: the principal's steering surface |
| `meta/issues/` — tracked problems | estate issues: the unfunded trust, the stale designation, the missing successor — severity-graded, status-carrying |
| matters, one per PR ([atomic pull requests](/meta/policy/git-atomic-pull-requests.md)) | review-quantized change: every queue item is one approvable intent |
| threads and the routing ledger ([session-capture](/meta/policy/session-capture.md)) | meeting and session records: a captured CPA meeting routes its decisions into the records they affect |
| the true-merge commit graph as provenance ([merge-strategy](/meta/policy/merge-strategy.md)) | local git with review-gated true merges; commits carry the agent run and the approving principal — a fiduciary-grade audit trail |
| offline, zero-dependency gates ([elixir-coding-standards](/meta/policy/elixir-coding-standards.md)) | `estate.verify` runs offline, the canary suite beside it; gates never need the network |

## Record granularity — the one structural change

elixir-mind verifies at document level. The register keeps that property by
**reifying high-stakes facts as their own records**: a titling, a
beneficiary designation, a fiduciary role is a first-class record carrying
its endpoints, its effective dates, and its own evidence — never a field
buried inside an account document, where one `verified` flag would have to
speak for many facts at once. Fast-changing quantities move out of the
register entirely: balances and transactions live in the **ledger**, whose
verification regime is reconciliation against statement captures rather than
`verified_by` edges. Two data temperatures, two regimes, one evidence store.

## Ontology draft (v0 — grows by ratification)

| Type | One line |
|---|---|
| `person` | a natural person: principal, family, beneficiary, professional |
| `entity` | a legal person: trust, LLC, partnership, foundation |
| `account` | a custodial container at an institution |
| `asset` | a thing owned: real property, vehicle, private interest, collectible, IP, crypto |
| `liability` | a debt: mortgage, loan, line of credit |
| `insurance-policy` | a policy: life, umbrella, property and casualty |
| `instrument` | an executed legal document: will, trust instrument, POA, healthcare directive, deed, operating agreement |
| `titling` | reified: who holds what, in which capacity, effective when |
| `designation` | reified: a beneficiary designation, tiered, with shares |
| `role` | reified: a fiduciary appointment — trustee, successor, executor, agent |
| `mandate` | a ratified policy the system computes under |
| `source` | captured evidence: statement, appraisal, filing, correspondence |
| `issue` | a gap or defect in the estate, severity-graded |
| `brief` | facts plus formed questions, addressed to a professional |
| `event` | a declared life event that triggers protocols |

Edges (typed, referencing ids): `owns` (with share), `secures`, `insures`,
`governs` (mandate → scope), `evidences` (source → record: the `verified_by`
edge), `supersedes` (instrument versioning), `concerns` (issue/brief/event →
records). Titling, designation, and role carry their endpoints as fields —
they *are* edges, reified so each can be evidenced and verified alone.

## `estate.verify` — rule families

1. **Schema**: parseable records, controlled types, required fields per
   type.
2. **Identity**: id presence, format, uniqueness; mint-once.
3. **References**: every edge resolves; no dangling endpoints.
4. **Verification semantics**: a fact claiming `verified` carries evidence;
   captures are trusted evidence, never themselves verified — the
   elixir-mind rule, kept as-is.
5. **Cardinality and sums**: every account has current titling; every trust
   has a current trustee (warn on a missing successor); designation tiers
   sum to 100%; ownership shares sum to 100%.
6. **Temporal consistency**: no current fact evidenced solely by a
   superseded instrument; effective-date ordering holds.
7. **Freshness**: per-class staleness windows — appraisals by asset class,
   statements by account, designation review after life events, instrument
   review cadence — warnings that escalate to issues.
8. **Reconciliation propagation**: artifacts compiled from unreconciled
   ledger state carry the flag.
9. **Generated-artifact freshness**: the binder, statements, and reports
   match their sources, or the gate fails.
10. **Index completeness**: every directory listing covers its contents.

The egress canary suite
([privacy record](/projects/estate-management-agent/privacy.md)) runs beside
these as the red-team half of the gate suite.

## What does not transfer

- **The hosted forge and the public site.** elixir-mind lives on GitHub and
  publishes Pages; the register's git remotes are local and encrypted, and
  its "site" is the LiveView dashboard, served to the box's own network
  only. The review flow transfers anyway: the approval queue is the pull
  request, reproduced locally over the same git substrate.
- **The public research feed.** A holdings-matched news digest is a
  conceivable later task class at tier T2; deferred, and recorded here so it
  is not re-derived.
- **The single-ratifier model changes name, never shape.** The principal
  replaces the operator as ratifier. Professional input does not become a
  second verification value: counsel's confirmation of a reading enters as a
  `professional-provided` evidence capture on the record it confirms —
  provenance, never a parallel truth channel.

## Open questions

- Per-term claim records for instrument extractions (recommended) versus one
  record per instrument with field-level evidence.
- Whether the ledger adopts Beancount's checker as an additional free gate
  (tracked in the
  [architecture record](/projects/estate-management-agent/architecture.md)).
- The register's id-namespace prefix, chosen at break-out; the prefix is
  opaque by the lending's own rule, so nothing will depend on the choice.
