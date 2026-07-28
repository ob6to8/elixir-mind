---
id: em:6e97e5
type: plan
title: "Secure financial agent — finish the spec before code"
description: The remaining spec work between the architecture record and the first line of code: three decisions the operator owns, three documents an agent can draft, and the dependency order that says which build-order step each one unblocks.
status: proposed
tags: [projects, planning, security, spec, threat-model, hardware, benchmarking]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, secure-financial-agent architecture session"
  why: "operator elected to keep speccing in this repo and deferred code, so the remaining spec work needed a durable record rather than living in a closing session"
---

# Secure financial agent — finish the spec before code

[architecture](/projects/secure-financial-agent/architecture.md) fixes the
*shape* — two zones, a pure reducer, directives-as-data, a host with no route
out. It does not fix enough to build from. This plan enumerates what remains,
who owns each item, and which build-order step each unblocks.

**The standing constraint:** no code until the spec is complete. That is an
operator decision, and it is what makes this plan worth persisting — the work is
deferred, so the context that produced it will be cold when it resumes.

## Current state

```
projects/secure-financial-agent.md          # hub: premise, decisions, open questions
projects/secure-financial-agent/
  index.md
  architecture.md                           # shape, boundary decisions, build order
  spec-completion.md                        # this plan
```

## Desired state

```
projects/secure-financial-agent/
  index.md
  architecture.md
  spec-completion.md
+ threat-model.md          # NEW  what this system defends against, and what it accepts
+ record-schema.md         # NEW  the parse worker's output contract
+ benchmark-protocol.md    # NEW  how model variants are chosen against real pages
~ ../secure-financial-agent.md   # MODIFIED  open questions resolved into decisions
```

## Decisions the operator owns

An agent cannot close these; each needs a fact only the operator holds.

| # | Decision | What resolves it | Blocks |
|---|---|---|---|
| D1 | **Hardware** — DGX Spark (128GB unified, CUDA, $4,699), RTX PRO 6000 Blackwell (96GB GDDR7, ~$8.5k + host), or Mac Studio M3 Ultra (up to 512GB, no CUDA) | Budget, and whether interactive latency matters or overnight batch suffices — see [the tier comparison](/knowledge/SWE/llm-engineering/local-inference-workstation-tiers.md). The CUDA question is load-bearing: Apple Silicon rules out vLLM and SGLang, leaving MLX or llama.cpp | build steps 2–3 |
| D2 | **Isolation posture** — full physical air gap, or a default-deny host with no network interface on the inference and agent processes | Tolerance for sneakernet updates and a transfer workstation — see [air-gapped operations](/knowledge/SWE/security/air-gapped-operations.md). The pragmatic case is that operational burden, not attack surface, is what ends personal security systems | build step 1 |
| D3 | **Gate placement** — where operator approval sits in the real workflow, and its friction cost per document | Only observable against actual volume: how many documents per session, and how many directives per document would queue | build step 4 |

D1 and D2 are cheap to defer no further — both gate the first build step. D3 can
stay open into step 3, since every Action until then is read-only.

## Documents an agent can draft

| # | Doc | Content | Unblocks |
|---|---|---|---|
| S1 | `threat-model.md` | Adversaries in scope (document authors, a compromised parse dependency, a supply-chain model swap) and explicitly *out* (physical seizure, a malicious operator, silicon backdoors). Trust boundaries and what crossing each requires. The accepted-risk list is the point — an unbounded threat model produces no design | steps 1, 4 |
| S2 | `record-schema.md` | The parse worker's output contract: field types, provenance-per-field (which page and region a value came from), a confidence signal, and the encoding of "could not extract." This is the untrusted/trusted interface, so it is where the isolation property is either kept or lost | step 1 |
| S3 | `benchmark-protocol.md` | How held-back real pages become a model choice: the page set and how it is held back, the extraction tasks scored, the scoring method, and the acceptance bar. Written *before* seeing results, so the bar is not fitted to the winner | step 2 |

S2 is the highest-value of the three and the natural next artifact: it is the
first build step's contract, and specifying it forces the isolation boundary to
be concrete rather than a diagram.

## Order

```
D1 ──┐
D2 ──┼──→ S1 threat-model ──→ S2 record-schema ──→ [build step 1: parse worker]
     └──→ S3 benchmark-protocol ─────────────────→ [build step 2: inference server]
D3 ──────────────────────────────────────────────→ [build step 4: the gate]
```

S1 precedes S2 because the record schema's provenance and confidence fields
exist to serve threat-model requirements; writing the schema first would invent
them speculatively.

## Scope boundaries

- **Nothing here is code.** Every item is a document. The first code is build
  step 1, and it starts only once D1, D2, S1, and S2 are closed.
- **Model variants stay unchosen.** Naming a specific Qwen3-VL size now would
  pre-empt S3, whose entire purpose is to make that choice from evidence rather
  than from a spec-time guess.
- **Generalizable findings still file to the taxonomy.** Anything learned while
  writing these that holds independent of this system — an attack class, a
  hardware fact — goes to `knowledge/` per the
  [projects-namespace policy](/meta/policy/project-namespace.md), and these docs
  link out to it.

## Open questions

- Does the parse worker emit one record per document or per logical entity (a
  statement yielding many transactions)? Decided in S2; it shapes every
  downstream Action signature.
- Is the approval queue durable across restarts, or session-scoped? Durable is
  the safer default but adds persistence the v1 may not otherwise need.
- Should extraction confidence gate automatic categorization, or only surface in
  review? Bears on whether low-confidence extractions can reach an Action at all.
