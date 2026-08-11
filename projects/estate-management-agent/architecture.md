---
id: em:d1b3c1
type: plan
title: "Estate management agent — architecture"
description: The runtime shape — the secure-financial-agent ingest zone reused as-is, a trusted core with no route out holding the register, ledger, engines, and local inference, and a single egress zone whose pseudonymizing gateway is the only path to rented frontier models — plus subsystems, task routing, storage, and the proposed build order.
status: proposed
tags: [projects, estate-management, architecture, elixir, jido, local-inference, security]
timestamp: 2026-08-11
attribution:
  when: 2026-08-11T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed estate-agent speccing session"
  why: "the project's founding runtime record: zones, subsystems, and boundary decisions fixed before any code exists"
---

# Estate management agent — architecture

The runtime shape for
[estate-management-agent](/projects/estate-management-agent.md). The hub's
premise — three security properties, bought separately — is assumed here; the
[privacy record](/projects/estate-management-agent/privacy.md) owns the
gateway's internals and the threat model.

## Desired-state topology

```
UNTRUSTED ZONE                │ TRUSTED CORE (no route out)           │ EGRESS ZONE (the only path out)
──────────────────────────────┼───────────────────────────────────────┼────────────────────────────────
intake/                       │                                       │
  statements/*.pdf            │  register   git-versioned text bundle │
  instruments/*.pdf           │             ids · evidence · history  │
  deeds, K-1s, appraisals     │  ledger     entity-aware books        │
      ↓                       │  engines    reconcile · drift ·       │
  parse worker                │             projections · staleness   │
  (secure-financial-agent     │  monitors   scheduled sweeps          │
   zone, reused: no network,  │  compile    reports · binder ·        │
   no filesystem beyond       │             packets                   │
   its in/out, ephemeral,  ───┼─→ queue     approval workflow         │
   model-free, emits          │  chat       local conversational      │
   structured records only)   │             surface                   │
                              │  web        LiveView dashboard        │
                              │  inference  local VLM · reasoner ·    │
                              │             embeddings (localhost)    │
                              │      ↓ pseudonymized task payloads    │
                              │  boundary ────────────────────────────┼─→ gateway
                              │                                       │    alias map (never leaves)
                              │                                       │    deterministic egress gate
                              │                                       │    verbatim egress log
                              │                                       │        ↓
                              │                                       │    rented frontier APIs
```

Host enforcement sits below the application: default-deny egress for every
process on the box; a single allowlisted route (the frontier endpoints) for
the gateway's own system user; dashboard and chat served only on the local
network or the principal's VPN.

## Subsystems

```
estate_agent/
├── ingest/     bytes → typed records; the secure-financial-agent parse zone, model-free
├── register/   canonical truth: typed records, mint-once ids, evidence edges, verification state
├── ledger/     double-entry books per entity; reconciliation state as first-class data
├── engines/    pure deterministic computation: drift, projections, share sums, staleness
├── mandates/   ratified policies, compiled into the agent's operating context
├── queue/      the approval workflow: proposed diffs, evidence, blast radius, decision
├── monitors/   scheduled sweeps: deadlines, renewals, staleness, life-event checklists
├── compile/    generated artifacts: statements, reports, packets, the executor binder
├── chat/       the conversational surface over the register (local models only)
├── boundary/   the egress gateway: classify, pseudonymize, gate, log, rehydrate
└── web/        LiveView: dashboard panels, the queue, the egress audit view
```

## Boundary decisions

- **The parse worker decides nothing.** Reused from
  [secure-financial-agent](/projects/secure-financial-agent/architecture.md),
  where it "converts bytes to records and has no model access" — an injected
  instruction in a document has no reader at the point of maximum privilege.
- **The register owns truth.** Nothing writes it except merges that came
  through the queue; verification state lives on the records, never in
  application memory.
- **The engines own arithmetic.** Drift, projections, reconciliation, and
  share sums are deterministic Elixir with tests — a model never performs
  load-bearing arithmetic. A correctness decision that doubles as a privacy
  lever: what egresses for synthesis rarely needs exact figures.
- **The ledger owns quantitative state**, and its reconciliation status
  propagates: every artifact compiled from unreconciled state carries the
  flag.
- **The boundary owns the only socket out.** The alias map lives inside it
  and never leaves; the egress gate is pattern-and-allowlist code — per
  secure-financial-agent, "a model-decided gate is a gate the model can be
  talked through".
- **The queue owns consequence.** Shape changes, mandate edits, titling and
  designation records, packet releases, and off-policy escalations all pass
  through it; what routes to the queue is static policy, never model
  judgment.
- **Compile owns derived artifacts.** Generated, freshness-stamped,
  regenerated on source change, never hand-edited.
- **The host owns egress denial.** Below the application, where no
  application bug can reach it.

## Task routing

| Workload | Runs on | Why |
|---|---|---|
| document parsing and extraction | sandbox + local document VLM | raw documents never leave; benchmark protocol per secure-financial-agent |
| classification and filing proposals | local mid-size reasoner | full estate context permitted locally |
| retrieval and embeddings | local | the corpus is the estate |
| arithmetic: reconciliation, drift, projections | plain Elixir, no model | deterministic, testable, oracle-checkable |
| routine chat over the register | local reasoner | full fidelity, zero egress |
| heavy synthesis: briefs, scenario narratives, multi-instrument summaries | frontier, through the gateway | the quality gap is real; payloads pseudonymized at tier T1 |
| general-knowledge questions | frontier, through the gateway | tier T2 — no estate referent, still logged |
| the system's own development | frontier dev harness | no estate data in the dev loop, per secure-financial-agent |

## Storage

- **Register**: a plain-text, OKF-style typed-document bundle under git —
  local remotes only; every change a commit that came through the queue; the
  [verification record](/projects/estate-management-agent/verification.md)
  fixes its semantics. Backups are encrypted snapshots to ordinary offsite
  storage, ciphertext only.
- **Ledger**: a plain-text journal; Beancount's format is the candidate (an
  established plain-text double-entry ecosystem whose checker becomes a free
  gate) — open question below.
- **Projections**: derived, disposable indexes — full-text and embedding —
  rebuilt from the canonical text at will;
  [elixir-agent-memory](/projects/elixir-agent-memory.md) is this layer's
  design.
- **Originals**: an encrypted, content-addressed blob store for source PDFs
  and scans; register captures point at content hashes.
- **Egress log**: append-only and hash-chained; rendered in the dashboard.

## Local inference

The model set follows secure-financial-agent — a document VLM for
extraction, a mid-size reasoner for chat and classification, an embedder —
served per
[local inference serving stacks](/knowledge/SWE/llm-engineering/local-inference-serving-stacks.md)
and chosen by the same benchmark-on-own-documents protocol
([spec-completion S3](/projects/secure-financial-agent/spec-completion.md)).
The frontier lane changes the sizing question: the box needs a competent
extractor and a conversational reasoner, never frontier-class local
capability, so the
[workstation-tier decision](/knowledge/SWE/llm-engineering/local-inference-workstation-tiers.md)
can land mid-tier. Self-hosting the open-weight frontier tier stays out of
scope for the reasons recorded in
[the mid-2026 landscape](/knowledge/machine-learning/open-weight-frontier-models-mid-2026.md).

## Runtime

Elixir on the BEAM: one modular-monolith application with the subsystems as
contexts; Oban for schedules; Phoenix LiveView for the web surface; Req for
the gateway's HTTP. The agent runtime adopts the Jido-2 pattern for the
reasons secure-financial-agent
[recorded](/projects/secure-financial-agent/architecture.md): the pure
reducer is the audit trail, Actions are the capability boundary, Directives
make the queue structural, supervision contains a poisoned agent. The
gateway runs as its own OS process under its own system user — the firewall
rule that permits egress names that user and nothing else.

## Build order (proposed)

0. **Register schema + `estate.verify` + a fixture estate** — the gates
   exist before the first real record, mirroring the
   [verification lending](/projects/estate-management-agent/verification.md).
1. **Ingest zone** — port secure-financial-agent's parse worker, record
   schema, and serving benchmark (its build steps 1–2).
2. **Ledger + reconciliation** — statements land in books; breaks surface.
3. **Queue + dashboard skeleton** — before any write-capable automation
   exists, keeping secure-financial-agent's ordering: "the gate is built
   **before** the first capability that needs it".
4. **Engines + monitors** — drift, staleness, projections, the calendar.
5. **Compile** — the net-worth statement, the funding report, binder v0, and
   the first drill.
6. **Chat** — the local conversational surface with citation discipline.
7. **Boundary** — gateway, gate, and canary suite; then the first frontier
   task class (brief drafting) behind it.

Each step lands behind the control that supervises it. The build starts in
the system's own repository at break-out; spec iteration continues here
until then.

## Decisions and alternatives

- **Three zones over two.** secure-financial-agent's zero-egress posture is
  kept for everything raw; the third zone exists because synthesis tasks
  benefit from frontier quality and survive pseudonymization. The lane is
  mandate-scoped: with the disclosure mandate set to "none", the system *is*
  the two-zone posture.
- **Text-canonical register over database-canonical.** Reviewable diffs, git
  provenance, and the verification lending outweigh query convenience — the
  database is a rebuildable projection. Rejected: an event-sourced database
  as canon (auditable, but opaque to review; the queue would need a bespoke
  diff surface instead of inheriting git's).
- **Rented frontier over bigger local.** The open-weight frontier tier is a
  multi-node deployment; pseudonymized egress buys the quality without the
  rack — and without weakening the raw-data guarantee.
- **Rejected for v1: credentialed custodian feeds and portal automation.**
  Read credentials on the box widen the threat model from "documents" to
  "money-adjacent access"; manual drops first, feeds only after the queue
  and audit posture have run in anger.

## Open questions

- Beancount as the ledger format (and `bean-check` as a free gate) versus a
  native journal the register's own verifier covers.
- Projection store: Postgres with pgvector versus SQLite/FTS5 —
  [elixir-agent-memory](/projects/elixir-agent-memory.md)'s findings
  transfer, and the box is single-user.
- One agent runtime or per-subsystem agents under one supervisor.
- How mail-based intake reaches the sandbox without opening an inbound
  listener (v1: none — manual drops only).
