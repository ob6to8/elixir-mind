---
id: em:5084c8
type: plan
title: "Estate management agent — product spec"
description: What the system does and refuses to do — the capability contracts for register, ledger, portfolio, legal, monitors, and readiness; the mandate mechanism the principal steers by; the interface; the autonomy split; and the aid-not-advice boundary stated structurally as a closed list of output genres.
status: proposed
tags: [projects, estate-management, product, spec, agents, finance]
timestamp: 2026-08-11
attribution:
  when: 2026-08-11T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed estate-agent speccing session"
  why: "the project's founding behavior record: what the system does, how it behaves, and what the principal sees, fixed before any code exists"
---

# Estate management agent — product spec

What the system does, how it is expected to behave, and what the principal
sees. The [architecture](/projects/estate-management-agent/architecture.md),
[privacy](/projects/estate-management-agent/privacy.md), and
[verification](/projects/estate-management-agent/verification.md) records fix
how it is built; the [hub](/projects/estate-management-agent.md) carries the
premise and the open questions the operator owns.

## Who it serves

- **The principal** — the estate's owner and the system's operator. Every
  consequential change is theirs to approve; every output is addressed to
  them unless they hand it onward.
- **The household** — spouse and heirs, as scoped read-only viewers
  (deferred past v1; the two-principal household is an open question with
  real property-law consequences).
- **The professional bench** — attorney, CPA, broker or advisor, insurance
  agent, corporate trustee. In v1 they are readers of compiled packets the
  principal transmits, never direct users. The system makes them more
  effective: complete records in, well-formed questions in, decisions and
  advice back — with the advice recorded, attributed, and dated in the
  register.

The positioning in one line: **the memory and coordination layer of a family
office, for a principal who does not want to staff one** — a single point of
reference that outlives any one advisor relationship, account migration, or
document generation.

## The boundary: aid, never advice

The system's outputs are drawn from a closed genre list. Everything it
produces is one of:

| Genre | What it is | Example |
|---|---|---|
| **record** | a typed, evidence-backed register entry | "account ···9921 is titled to the family revocable trust, per the June statement" |
| **reconciliation** | ledger state checked against an external statement | "all seven accounts reconciled for June; one $1,204 break open on ···4410" |
| **computation** | a deterministic result under a ratified mandate | the drift report against the investment-policy bands |
| **monitor** | a deadline, renewal, staleness, or threshold alert | "the umbrella policy lapses in 21 days" |
| **brief** | facts plus formed questions, addressed to a named professional | a Roth-conversion fact packet for the CPA |
| **draft** | a non-operative document for human review | a letter of instruction; a meeting agenda |
| **compiled artifact** | a generated report assembled from the register | the net-worth statement; the executor binder |

"Recommendation" is not on the list, and that absence is the design: an
advice-shaped ask does not produce a hedged answer, it produces a **brief** —
the relevant facts with citations, the question formed the way the
professional needs it, and an agenda entry. The system computes
*consequences* of stated assumptions on request ("at the current gifting
rate, the annual exclusion is exhausted in March"); it does not select among
futures for the principal.

Two grounds, held together:

- **Regulatory** *(an assumption set for counsel review, marked unverified —
  the spec's own standard applied to itself).* Personalized securities
  recommendations implicate investment-adviser regulation; drafting operative
  instruments implicates unauthorized-practice doctrines; tax positions
  belong to the CPA of record. A personal tool used by its owner sits under
  lighter obligations than a product sold to others — the spec holds the
  product-grade boundary anyway, because repositioning later is expensive and
  the second ground does not soften.
- **Epistemic.** Estate decisions are consequential, irreversible, and
  oracle-poor — the conditions under which unreviewed model judgment fails
  worst. The professionals are the oracle. The system's job is to make their
  review cheap, complete, and fast.

## Mandates: how the principal steers

A **mandate** is a ratified policy document the system computes under: the
investment policy statement (targets, bands, constraints, tax budget), entity
budgets, trust distribution policies, the disclosure policy (which task
classes may egress at which sensitivity tier), and escalation thresholds
(what wakes the principal versus what waits for the digest). Mandates are
authored with the relevant professional, enter through the approval queue,
and are versioned like everything else; the current mandate set compiles into
the agent's working context — its operating contract — so a course change is
a reviewed mandate edit rather than chat-by-chat drift.

## Capabilities and expected behavior

### Register — the system of record

- Every material fact — an account's titling, a beneficiary designation, a
  fiduciary appointment, an asset's ownership — is a typed record with a
  stable id, an ingestion event, and evidence edges to captured source
  documents; the
  [verification record](/projects/estate-management-agent/verification.md)
  fixes the semantics.
- Answers cite. Every factual sentence in chat or a report names its records
  and their verification status; an unverified fact renders flagged, and a
  fact the register lacks is answered as absent — scoped to what was
  searched, never padded from model memory.
- Filing is autonomous inside the existing shape (a new statement for a
  known account); anything that changes the estate's shape — a new entity,
  account, person, or record type — queues for approval.

### Ledger — books and budgets

- Entity-aware double-entry: the household, each trust, and each LLC keeps
  its own books; consolidated views compile across them.
- Every account reconciles monthly against its statement; a reconciliation
  break is a first-class open item, and every report compiled from
  unreconciled state carries the flag visibly.
- Budgets are mandates; the ledger tracks variance and projects cash needs —
  tax dates, premiums, capital calls, distributions, tuition — far enough
  ahead that liquidity gaps surface before they are urgent.

### Portfolio — policy, drift, worksheets

- The investment policy statement is a mandate; the system computes drift
  against its bands continuously and reports exposure: concentration,
  liquidity, asset location, currency.
- When drift exceeds a band, the system produces a **rebalancing
  worksheet**: tax-lot-aware, wash-sale-annotated, gains-budget-checked,
  formatted for the broker to execute — addressed to the principal and
  transmitted by the principal. The system holds no trading credentials and
  never places orders.
- Security selection, market timing, and "should I buy X" convert to briefs
  for the advisor.

### Legal — instruments, funding, administration

- Instrument custody: executed wills, trust instruments, powers of attorney,
  healthcare directives, deeds, operating agreements — versioned, execution
  status tracked (draft / executed / superseded), the physical location of
  wet-ink originals recorded, recording status for deeds.
- Term extraction: parties, powers, distribution standards, situs, amendment
  provisions — each extracted term a claim pinned to the page and section of
  the source instrument, so counsel can check the reading in seconds.
- The funding tracker holds intended titling (per the estate plan) against
  actual titling (per statements and deeds) and raises a severity-graded
  issue on every mismatch — the classic unfunded-trust failure becomes a
  standing, visible gap instead of a discovery at death.
- The administration calendar tracks notices, accountings, trustee actions,
  and filings per entity, each with an owner and an evidence-of-completion
  capture.
- For any legal question: a brief for counsel — instrument provisions quoted
  verbatim, register facts attached, the question formed. Operative drafting
  stays with counsel.

### Monitors — deadlines and drift

- A master calendar with lead-time policies per deadline class: tax dates,
  required distributions, option windows, insurance renewals,
  registered-agent renewals, trust distribution dates, document review
  cadences.
- Staleness sweeps: appraisal age per asset class, designation review after
  life events, instrument review after a fixed interval or a move between
  states.
- Life-event protocols: a declared marriage, birth, death, divorce,
  relocation, or liquidity event triggers a checklist — register updates,
  designation reviews, professional consultations to schedule — worked
  through the queue like any other change.

### Readiness — gaps and the binder

- Continuous gap analysis, severity-graded: unfunded trusts, stale or
  conflicting designations, missing successor fiduciaries, absent healthcare
  directives, uninsured assets, single-person knowledge (only the principal
  knows where a thing is), and settlement-liquidity shortfall — the last
  labeled *estimate, for professional review*.
- The **executor binder** is a compiled artifact, regenerated on register
  change: what exists and where, who to call, what happens in the first 72
  hours and the first 30 days of incapacity or death, and how the survivors
  and the executor reach the system itself. It is always current because it
  is never hand-maintained.
- Readiness is rehearsed: a **drill** compiles the binder, walks the
  incapacity and death paths against the current register, and files every
  gap it finds as an issue.

## Scenario vignettes

**Statement day.** A brokerage PDF lands in the intake folder. The sandboxed
parser emits records; the ledger matches the known account and reconciles;
positions update with the statement as evidence; drift recomputes. One
holding's balance disagrees with the ledger by $1,204 — a reconciliation
break opens and appears in the queue and the digest. Nothing left the box.

**Beneficiary audit.** "Do any accounts still name my brother?" The register
answers from designation records with citations and verification dates: two
accounts; one designation last evidenced three years ago; one contingent
share that conflicts with the current will's residue clause — and the
conflict already exists as an open issue with a counsel brief attached.

**Funding gap.** A deed capture shows the lake house titled personally; the
estate plan intends trust titling. The funding tracker raises a
high-severity issue and prepares the counsel brief: the instrument's funding
provision quoted, the deed cited, the retitling steps counsel would own
listed as questions.

**Rebalance.** Quarterly drift breaches the equity band. The engine produces
the worksheet: lots selected under the gains budget, wash-sale windows
flagged, the trade list formatted for the broker. It waits in the queue; the
principal approves; a PDF lands in their outbox to forward. The system
placed nothing.

**Advice-shaped ask.** "Should I convert $200k of the IRA this year?" The
reply is a brief: current balances and basis with citations, year-to-date
realized income from the ledger, prior conversions, the current-year figures
the CPA will ask for — marked *register facts only; the tax judgment is the
CPA's* — the question formed, and an agenda entry added for the next CPA
meeting. The system computes consequences of stated assumptions on request;
it does not answer "should."

## Interface

**Conversation** — the primary surface: chat with the full-context local
agent (voice deferred). Every factual sentence carries citations; unverified
facts render flagged; "not in the register" is a first-class answer that
names what was searched.

**Dashboard** — Phoenix LiveView, served only on the box's own network:

- the net-worth statement (as-of, with reconciliation status inline)
- the entity map (ownership, titling, and roles as a navigable graph)
- the calendar (deadlines with lead-time status)
- the approval queue
- issues (the estate's open gaps, severity-sorted)
- the egress audit (everything that has ever left the box, verbatim)
- readiness (score, binder freshness, last drill)

**The approval queue** — every consequential change is a reviewable item:
the proposed diff, the evidence behind it, the blast radius (which records
and artifacts recompile), and the agent's stated reason. Approve, edit, or
reject; batch where routine. Shape changes, mandate edits, titling and
designation records, disclosures, and frontier escalations outside standing
policy always queue.

**Documents** — in: a watched intake folder (a dedicated forwarding address
is deferred) feeding the sandboxed parser. Out: compiled packets — the
net-worth statement, the funding report, a meeting packet per professional,
the binder — generated as PDFs the principal transmits. v1 sends nothing
outbound itself.

**Alerts** — severity-tiered per the escalation mandate: wake-me-now to the
principal's devices, everything else to the daily digest.

**Deferred**: voice, read-only mobile, a professional portal with scoped
logins, custodian data feeds.

## The autonomy split

| Autonomous | Through the queue only | Never |
|---|---|---|
| file facts with evidence into the existing shape; reconcile; recompute derived artifacts; run sweeps and drills; draft briefs and packets | create entities, accounts, people, or types; edit mandates; write titling, designation, or role records; release any packet; escalate to frontier outside the disclosure mandate | execute trades; move money; sign, file, or record documents; communicate with third parties; recommend |

## Non-goals (v1)

Custody or execution of any kind; money movement; autonomous outbound
communication; a professional-facing portal; multi-family or multi-tenant
operation; tax preparation; operative legal drafting; replacing the
professional bench. The deferred interface items above are non-goals for v1
only.

## Open questions

- Jurisdiction and property regime: the spec assumes US law generally;
  community-property treatment changes titling and designation semantics.
- The two-principal household: joint operators, or one principal with a
  scoped view?
- Product posture: personal tool or productized — the boundary holds either
  way, but compliance review, terms, and the disclosure mandate's defaults
  differ.
- Statement ingestion cadence: manual drops (v1) versus custodian feeds
  (deferred; credentialed read-only feeds re-open the threat model).
- Naming (tracked on the hub).

## Decision list

- **A closed genre list over advice-with-disclaimers.** A disclaimer
  modifies a recommendation's framing, not its existence; the boundary has
  to be visible in the artifact type itself, or it erodes one hedged answer
  at a time.
- **Briefs as the universal escape.** Every refused genre converts to a
  brief — the ask is never dropped, it is re-addressed.
- **Mandates over conversational steering.** Chat is where a mandate is
  drafted; only ratified mandates steer computation.
- **Rejected: autonomous execution with caps** ("trades under $10k
  auto-place"). Irreversibility does not scale down cleanly, and the first
  automated order changes the system's regulatory character.
- **Rejected: cloud-first v1 with a local retrofit later.** The privacy
  posture is the product; building under it is cheaper than migrating to it.
