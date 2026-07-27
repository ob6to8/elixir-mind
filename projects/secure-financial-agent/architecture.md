---
id: em:0d4f26
type: plan
title: "Secure financial agent — architecture"
description: The v1 shape for the locally-hosted financial document agent: a two-zone split with sandboxed parsing, a Jido reducer whose side effects are data rather than calls, an operator approval gate on the consequential ones, and a local inference server on a host with no route out.
status: proposed
tags: [projects, architecture, security, jido, elixir, local-inference, document-processing]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, secure-financial-agent architecture session"
  why: "the project's first design record, capturing the two-zone shape and the boundary decisions before any code is written"
---

# Secure financial agent — architecture

The design record for [secure-financial-agent](/projects/secure-financial-agent.md).
Its premise — that confidentiality and integrity are bought separately, and that
local hosting buys only the first — is stated on the hub and assumed here.

## Desired-state topology

```
UNTRUSTED ZONE                    │ TRUSTED ZONE
──────────────────────────────────┼────────────────────────────────────────
ingest/                           │
  statements/*.pdf                │
  forms/*.pdf                     │
  exports/*.csv                   │
      ↓                           │
  parse worker                    │
  · no network namespace          │
  · no filesystem beyond its in/out
  · ephemeral, one document per run
  · emits structured records only ┼──→ Jido AgentServer (supervised)
                                  │      cmd(agent, {Action, params})
                                  │        ↓ pure reducer, no side effects
                                  │      {updated_agent, [Directive]}
                                  │        ↓
                                  │      directive classifier
                                  │        ├─ benign  → execute
                                  │        └─ consequential → approval queue
                                  │                              ↓ operator
                                  │                            execute
                                  │        ↓
                                  │      Actions (typed, schema-validated)
                                  │        ↓
                                  │      inference server (vLLM or SGLang)
                                  │      OpenAI-compatible, localhost only
                                  │
                                  │  host egress: DENY ALL
```

## Boundary decisions

One line per layered responsibility, so the seams are explicit:

- **The parse worker detects nothing and decides nothing.** It converts bytes to
  records and has no model access. Keeping conversion model-free means an
  injected instruction in a PDF has no reader at the point where it is most
  dangerous.
- **The reducer owns decisions, never side effects.** `cmd/2` is pure: it returns
  an updated agent and a list of Directives. No I/O, no model call, no write.
  This is what makes a categorization replayable and auditable without an LLM.
- **The classifier owns the gate, not the agent.** Whether a Directive is
  consequential is decided by the runtime against a static policy, never by the
  model — a model-decided gate is a gate the model can be talked through.
- **Actions own side effects, and own validation.** Every capability the system
  has is an Action with a parameter schema; anything not expressed as an Action
  cannot happen. Validation runs before execution, not inside it.
- **The host owns egress.** The inference server and agent run without a route
  out. Not firewalled — no interface. Enforcement belongs below the application,
  where no application bug can reach it.
- **Persistence owns recovery, not correctness.** State is rehydrated on crash;
  a poisoned context dies with the process rather than persisting.

## Why Jido fits this specifically

The [prior evaluation](/meta/analysis/beam-deployment-and-jido-2-evaluation.md)
found the BEAM had "nothing to grip" in this brain, because every workload was a
one-shot batch task. This workload inverts each of those findings: it is
resident, stateful, concurrent, and needs an audit trail. Concretely —

| Requirement | Jido primitive |
|---|---|
| Auditable, replayable decisions | the pure `cmd/2` reducer — no model or network needed to re-run a decision |
| Capability minimization | Actions as schema-validated functions; the capability set *is* the module list |
| A gate that a prompt cannot argue past | Directives are returned as data and interpreted by the runtime, so approval sits outside the model's reach |
| Containing a poisoned agent | supervision; the process dies and restarts from clean persisted state |
| Scheduled batch runs | durable in-house cron since 2.1.0 |

The gating property is the load-bearing one. Because side effects are **data
returned from a pure function** rather than calls made inside one, the approval
break is structural rather than a convention the implementation must remember to
honor.

## Anchors

- **Runtime**: Jido 2.x, its own mix project (this repo's zero-dependency
  constraint and toolchain floor both bar it here — see
  [raise-elixir-otp-toolchain-floor](/meta/plans/raise-elixir-otp-toolchain-floor.md)).
- **Cognition**: `jido_ai` over `req_llm`, base URL pointed at the local server.
  `req_llm` sits on `Req`, so retargeting is configuration, not a fork — but it
  is the single dependency under all inference and should be treated as such.
- **Serving**: [vLLM or SGLang](/knowledge/SWE/llm-engineering/local-inference-serving-stacks.md);
  benchmark SGLang first, since structured extraction and tool loops are what it
  optimizes for.
- **Models**: a document VLM plus a mid-size reasoner, both resident. Variant
  selection is a build-time benchmark against held-back real pages, not a
  spec-time choice — see
  [the mid-2026 landscape](/knowledge/machine-learning/open-weight-frontier-models-mid-2026.md)
  for why the frontier tier is out of scope.
- **Threat model**:
  [indirect prompt injection in document pipelines](/knowledge/SWE/security/indirect-prompt-injection-in-document-pipelines.md).
- **Escape hatch if a larger model becomes necessary**:
  [confidential computing](/knowledge/SWE/security/confidential-computing-for-llm-inference.md).

## Build order

1. Parse worker and record schema — no model, no agent. Independently testable.
2. Local inference server, benchmarked on held-back real pages, model variants
   chosen from the results.
3. Jido agent with a deliberately minimal Action set (read records, categorize,
   answer) — every Action read-only.
4. The directive classifier and approval queue, before any write-capable Action
   exists.
5. Write-capable Actions, one at a time, each entering through the gate.

The ordering is the point: the gate is built **before** the first capability that
needs it, so there is no window in which the system can act unsupervised.

## Decisions and alternatives

- **Small models over frontier.** The workload is extraction, classification,
  and arithmetic. Frontier open weights are multi-node deployments and buy
  nothing here.
- **Own hardware over confidential computing.** CC is the answer to "run a model
  too large to own." Where the model fits on hardware you possess, owning it is
  simpler and more private. Recorded as an escape hatch, not a tier.
- **Default-deny host over a physical air gap — proposed, not settled.** A full
  air gap imposes sneakernet updates and a transfer workstation; the operational
  burden is the most likely cause of abandonment. A host with no egress route
  plus encrypted-at-rest backups to ordinary storage delivers the same
  confidentiality property at a fraction of the friction, since the backup target
  holds only ciphertext. Open on the hub.
- **Rejected: filtering documents for injected instructions.** No reliable
  classifier exists for "is this text an instruction." Bounding the action
  surface is the defense; sanitizing input is the attacker's game.

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:0d4f26">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-27-secure-financial-agent-and-projects-namespace (2026-07-27)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:0d4f26`]**  (co-feeds: `em:44f899 em:f6de6f`)

Your brain already concluded Jido was a poor fit *for the brain's own tooling* — see [the BEAM/Jido evaluation](https://ob6to8.github.io/elixir-mind/meta/analysis/beam-deployment-and-jido-2-evaluation.html). But read *why* it said no:

> "the BEAM's distinctive strengths (supervision of long-lived state, massive concurrency, fault-tolerant services) have nothing to grip"

**A financial document pipeline gives them everything to grip.** It's resident, stateful, long-lived, concurrent, and needs an audit trail. This is the workload that analysis said was missing. Every blocker it listed was about *this repo* — the pinned 1.14/OTP 24 floor and the zero-dependency constraint — and none applies to a separate project.

More than that, Jido's primitives map onto the security requirements almost suspiciously well:

**1. The reducer is your audit trail.** A Jido agent is pure immutable data through a single `cmd(agent, {Action, params}) → {updated_agent, directives}`. That means every decision is **replayable without an LLM and without a network call**. For financial work — where "why did it categorize this deduction that way?" is a question you may have to answer to a human — a deterministic replay of the decision sequence is worth a great deal.

**2. Actions are the capability boundary.** Actions are schema-validated functions that double as LLM tools. The model cannot invoke what no Action exposes, and params are validated *before* execution. That's OWASP's privilege minimization enforced in the type system rather than requested in a prompt — which is the whole difference, because a prompt is exactly the thing an injection attack overrides.

**3. Directives make the human-in-the-loop gate a first-class primitive.** This is the one that matters most. Side effects in Jido aren't executed inline — they're returned as **Directives**, structs the runtime interprets. So you can inspect a proposed side effect *as data* and gate it before anything happens. The recommended defense for high-consequence actions is [human confirmation that interposes a break in the automated attack chain](https://www.getmaxim.ai/articles/prompt-injection-defense-for-production-ai-agents-a-complete-2026-guide/) — a break "that cannot be bypassed by manipulating the model alone." Jido hands you the seam for free.

**4. Supervision contains a poisoned agent.** Let-it-crash means an agent whose context got contaminated dies and restarts from clean persisted state. Injection doesn't persist across a restart unless you persisted it.
