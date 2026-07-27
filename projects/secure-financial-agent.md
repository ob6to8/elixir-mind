---
id: em:f6de6f
type: project
title: Secure financial agent
description: A locally-hosted agentic system for processing sensitive financial documents — taxes, bank statements — designed so confidentiality comes from default-deny egress and integrity comes from a typed capability boundary, rather than from trusting the model.
status: incubating
tags: [projects, security, local-inference, agents, elixir, jido, finance]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed architecture session"
  why: "operator opened the projects namespace to incubate this system's specs and research here before it breaks out into its own repo"
---

# Secure financial agent

A personal, locally-hosted agentic system that ingests financial documents — tax
forms, bank and brokerage statements — and performs extraction, categorization,
and question-answering over them, without the documents ever leaving hardware the
operator physically possesses.

## The premise the design rests on

Two security properties are in play, and they are independent:

| Property | Failure looks like | Solved by |
|---|---|---|
| **Confidentiality** | statements reach a third party and are retained | local hosting + default-deny egress |
| **Integrity** | a document's contents are read as instructions and the agent acts on them | a typed capability boundary + gated side effects |

Only the first is addressed by choosing a local model, and it is the easier one.
Financial documents are **attacker-influenceable input** — a vendor invoice, an
emailed 1099, a brokerage PDF are all authored by someone else — which makes
indirect prompt injection the load-bearing risk, and it is entirely unaffected by
where the weights sit.

The system is therefore designed so that **what the agent is permitted to do**,
not what the model decides, is the security boundary.

## Shape

```
Untrusted zone                  │ Trusted zone
────────────────────────────────┼─────────────────────────────────────
PDF / CSV ingest                │
  ↓                             │
sandboxed parse ────────────────┼──→ structured data only
(no net, no fs, ephemeral)      │      ↓
                                │  agent runtime (supervised, resident)
                                │    pure reducer → proposed side effects
                                │      ↓
                                │    approval gate  ← operator
                                │      ↓
                                │    typed, whitelisted capabilities
                                │      ↓
                                │  local inference server (OpenAI-compatible)
                                │  ↑ egress firewall: DENY ALL
```

Two controls carry most of the weight: **document parsing happens in the sandbox,
before the model sees anything** (the conversion step is itself an attack
surface), and **egress is default-denied at the OS level**, so exfiltration is
impossible rather than merely discouraged.

## Decisions so far

| Decision | Choice | Rationale |
|---|---|---|
| Hosting tier | own workstation | fits the model tier below; cheaper and strictly more private than any cloud option |
| Model tier | small — a document VLM plus a mid-size reasoner | the workload is extraction, classification, and arithmetic, not frontier reasoning |
| Frontier models | rejected for v1 | all current open-weight frontier models are multi-node deployments |
| Confidential computing | documented escape hatch, not v1 | only relevant if a model too large to own becomes necessary |
| Agent runtime | Jido 2 on the BEAM, in its own mix project | supervision, a replayable reducer, and side-effects-as-data map onto the audit and gating requirements |
| Dev harness | Claude Code | it does not touch financial data, so the threat model is ordinary development |

## Open questions

- Which document-VLM variant wins **on the operator's own documents** — a
  benchmark to run at build time against a held-back set of real pages, not a
  spec-time decision.
- Operational shape of the air gap: full physical isolation versus a default-deny
  host with a designated transfer workstation.
- Where the approval gate sits in the operator's actual workflow, and what it
  costs in friction per document.

## Documents

- [Project docs](/projects/secure-financial-agent/index.md)

## Knowledge this project draws on

Already filed:

- [Jido](/beliefs/glossary/jido.md) · [llama.cpp](/beliefs/glossary/llama-cpp.md)
- [Would deploying to the BEAM — or integrating Jido 2 — benefit this brain?](/meta/analysis/beam-deployment-and-jido-2-evaluation.md)
  — the prior evaluation whose "nothing to grip" finding this workload inverts

Researched and awaiting intake to the taxonomy, each true independent of this
system: open-weight frontier models as of mid-2026; local inference serving
stacks; indirect prompt injection in document pipelines; confidential computing
for LLM inference.
