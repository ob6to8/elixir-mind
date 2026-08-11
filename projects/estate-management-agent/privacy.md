---
id: em:925461
type: plan
title: "Estate management agent — privacy architecture"
description: What may leave the box, in what form, through what mechanism — sensitivity tiers, the pseudonymizing gateway and its deterministic egress gate, the canary discipline, a threat model that includes the agent itself, key management and executor continuity, and the linkage residual the design accepts.
status: proposed
tags: [projects, estate-management, privacy, security, threat-model, pseudonymization, egress]
timestamp: 2026-08-11
attribution:
  when: 2026-08-11T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed estate-agent speccing session"
  why: "the project's founding privacy record: tiers, gateway, and threat model fixed before any code exists"
---

# Estate management agent — privacy architecture

What may leave the box, in what form, through what mechanism, and against
which adversaries. The premise is the hub's third property — **disclosure
control** — layered on the confidentiality and integrity properties
[secure-financial-agent](/projects/secure-financial-agent.md) established.
The general pattern this instantiates is filed to the taxonomy as
[hybrid inference with pseudonymized egress](/knowledge/SWE/security/hybrid-inference-pseudonymized-egress.md);
this record fixes the estate-specific choices.

## The posture in one table

| Data | Where it lives | What may egress |
|---|---|---|
| raw documents, images, scans | encrypted blob store, local | never — no form, no tier |
| the register and ledger: identities, numbers, terms | the local text bundle and its projections | derived, pseudonymized task payloads only, through the gateway |
| compiled packets for professionals | local, until the principal transmits | by the principal's hand, per packet, after review |
| general-knowledge questions | — | freely, still logged |

## Sensitivity tiers

| Tier | Contents | Handling |
|---|---|---|
| **T0 — identity** | legal names, dates of birth, SSN/TIN/EINs, account numbers, addresses, credentials and keys, signatures, document images, medical content in directives | never egresses in any form; excluded from frontier payloads by construction and re-checked by the gate |
| **T1 — structure and quantity** | the estate graph, balances and shares, instrument terms, dates | egresses only pseudonymized: stable aliases for referents, free text generalized, amounts bucketed unless the task class needs exactness |
| **T2 — general** | questions with no estate referent | egresses freely, logged |

Classification is local and conservative: unclassified content takes T1
treatment or stricter, and T0 patterns hard-block regardless of
classification.

## The gateway pipeline

1. **Route** — does the task need frontier at all? The
   [task-routing table](/projects/estate-management-agent/architecture.md)
   sends most work to local models or plain code.
2. **Transform** — referents swap to aliases from the locally-held map
   (`person-3`, `trust-B`, `account-17`); free text generalizes ("the lake
   house" → "secondary residence"); amounts bucket by default.
3. **Gate** — deterministic and model-free: T0 pattern scanners (identifier
   formats), a register-derived denylist (every name, address, and number
   the register knows, with variants), and an allowlist for structured
   fields. It fails closed. Per secure-financial-agent's classifier rule —
   "a model-decided gate is a gate the model can be talked through"
   ([architecture](/projects/secure-financial-agent/architecture.md)) — this
   gate is code.
4. **Log** — the outbound payload and the response, verbatim, append-only,
   hash-chained; the dashboard renders the log as "everything that has ever
   left", which is the trust feature the whole posture hangs on.
5. **Rehydrate** — aliases resolve locally on the way back. An alias-shaped
   token that does not resolve is a tripwire (the model invented a
   referent); frontier output lands as **draft for review**, never directly
   as a verified record.

## Canary discipline

The register seeds synthetic canary records — a fake person, account, and
address with distinctive strings. The test suite drives representative tasks
end-to-end and fails if a canary ever appears in an egress fixture; the
runtime gate carries the same patterns as a hard block. The gate is thereby
tested against the system's behavior, not merely against a specification of
it.

## Threat model

| Adversary / failure | Vector | Controls | Residual |
|---|---|---|---|
| frontier provider: retention, breach, training | egressed payloads | tiers; pseudonymization; amount bucketing; zero-data-retention terms; minimal task classes | structural linkage — see below |
| document authors: indirect injection | a crafted statement, instrument, or attachment | the ingest zone: model-free sandboxed parse, typed capabilities, gated side effects ([threat record](/knowledge/SWE/security/indirect-prompt-injection-in-document-pipelines.md)) | content aimed at the *principal's* judgment, surfaced in review |
| network adversary | inbound access or exfiltration | no inbound listeners beyond the VPN; default-deny egress; one allowlisted route for the gateway user | — |
| physical theft | the box and its disks | full-disk encryption; per-store keys; revocable, scoped frontier API keys | powered-on seizure |
| over-shared packets | disclosure beyond a professional's need | role-scoped packet compilation; T0 masked by default; a per-recipient disclosure log | the recipient's own systems |
| **the agent itself**: hallucinated facts, misfiling, wrong reads | any output | the verification ladder (facts need evidence); deterministic engines for arithmetic; the queue on consequence; citation discipline in chat | wrong-but-evidenced reads (bad extraction) — mitigated by page-pinned extraction and spot review |
| principal incapacity or death | the system becomes inaccessible exactly when most needed | escrowed recovery (below); the binder documents access; drills rehearse it | escrow compromise, accepted and scoped |
| supply chain | a poisoned dependency or model weights | pinned dependencies; checksummed weights; updates as a deliberate, separate step per [air-gapped operations](/knowledge/SWE/security/air-gapped-operations.md) | — |

## The linkage residual

Stable aliases make frontier context coherent across calls — and coherence
is linkage: a provider that retained every payload could reconstruct a
pseudonymized shadow of the estate's *shape* (structure, magnitudes,
timing), even with every identifier stripped. The design accepts a bounded
version of this and mitigates it: per-matter alias scopes with periodic
rotation (traded against cross-session coherence), bucketed amounts by
default, zero-retention contract terms, and a disclosure mandate that can
pin any task class to local-only. What the payloads alone can never yield is
identity — T0 never crosses. And the zero-egress posture remains available
wholesale: with the disclosure mandate set to "none", the system degrades
gracefully to secure-financial-agent's stance, at some cost in synthesis
quality.

## Keys, backups, continuity

- **At rest**: full-disk encryption plus per-store keys (register, blobs,
  ledger); the alias map and the egress log under the gateway's own key.
- **Backups**: encrypted snapshots to ordinary offsite storage — the
  provider holds ciphertext only — with restores rehearsed on a schedule;
  the stance secure-financial-agent recorded for the same problem.
- **Continuity**: the system is itself an estate asset. A sealed recovery
  path — credentials and instructions escrowed with counsel or in a bank
  box — is documented in the executor binder, and the readiness drill
  rehearses executor access. The principal's death must not orphan the
  record that exists to survive it.

## Open questions

- The default alias posture: stable-until-rotated versus per-matter scopes —
  the coherence/linkage trade.
- The default amount treatment: bucketed versus exact-on-request, per task
  class.
- Whether the local chat surface masks T0 by default (screens are seen over
  shoulders).
- Zero-data-retention terms per candidate provider, and what verification of
  those terms is worth.
- Per-recipient watermarking of packets.
