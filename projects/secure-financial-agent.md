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

Tracked with their resolution paths and blocking relationships in
[spec-completion](/projects/secure-financial-agent/spec-completion.md).

- Which document-VLM variant wins **on the operator's own documents** — a
  benchmark to run at build time against a held-back set of real pages, not a
  spec-time decision.
- Operational shape of the air gap: full physical isolation versus a default-deny
  host with a designated transfer workstation.
- Where the approval gate sits in the operator's actual workflow, and what it
  costs in friction per document.

## Documents

- [Architecture](/projects/secure-financial-agent/architecture.md) — the v1 shape
- [Finish the spec before code](/projects/secure-financial-agent/spec-completion.md) — what remains, and who owns each item
- [Project docs](/projects/secure-financial-agent/index.md)

## Knowledge this project draws on

Filed to the taxonomy because each is true independent of this system — the hub
links out rather than restating:

- [Indirect prompt injection in document pipelines](/knowledge/SWE/security/indirect-prompt-injection-in-document-pipelines.md)
  — the threat model the design answers
- [Confidential computing for LLM inference](/knowledge/SWE/security/confidential-computing-for-llm-inference.md)
  — the escape hatch if a model too large to own becomes necessary
- [Open-weight frontier models, mid-2026](/knowledge/machine-learning/open-weight-frontier-models-mid-2026.md)
  — why the frontier tier is out of scope for a self-hosted system
- [Local inference serving stacks](/knowledge/SWE/llm-engineering/local-inference-serving-stacks.md)
  — the serving layer and its sizing constraints
- [Single-machine inference hardware, mid-2026](/knowledge/SWE/llm-engineering/local-inference-workstation-tiers.md)
  — the tiers the hardware decision picks from
- [Operating an air-gapped workstation](/knowledge/SWE/security/air-gapped-operations.md)
  — the operational patterns behind the isolation-posture decision
- [Jido](/beliefs/glossary/jido.md) · [llama.cpp](/beliefs/glossary/llama-cpp.md)
- [Would deploying to the BEAM — or integrating Jido 2 — benefit this brain?](/meta/analysis/beam-deployment-and-jido-2-evaluation.md)
  — the prior evaluation whose "nothing to grip" finding this workload inverts

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:f6de6f">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-27-secure-financial-agent-and-projects-namespace (2026-07-27)

3 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:f6de6f`]**  (co-feeds: `em:7da513`)

You asked for "completely secure." The honest answer is that a local model buys you **one** of the two security properties you need here, and it's not the harder one.

---

**[`em:f6de6f`]**  (co-feeds: `em:44f899 em:0d4f26`)

Your brain already concluded Jido was a poor fit *for the brain's own tooling* — see [the BEAM/Jido evaluation](https://ob6to8.github.io/elixir-mind/meta/analysis/beam-deployment-and-jido-2-evaluation.html). But read *why* it said no:

> "the BEAM's distinctive strengths (supervision of long-lived state, massive concurrency, fault-tolerant services) have nothing to grip"

**A financial document pipeline gives them everything to grip.** It's resident, stateful, long-lived, concurrent, and needs an audit trail. This is the workload that analysis said was missing. Every blocker it listed was about *this repo* — the pinned 1.14/OTP 24 floor and the zero-dependency constraint — and none applies to a separate project.

More than that, Jido's primitives map onto the security requirements almost suspiciously well:

**1. The reducer is your audit trail.** A Jido agent is pure immutable data through a single `cmd(agent, {Action, params}) → {updated_agent, directives}`. That means every decision is **replayable without an LLM and without a network call**. For financial work — where "why did it categorize this deduction that way?" is a question you may have to answer to a human — a deterministic replay of the decision sequence is worth a great deal.

**2. Actions are the capability boundary.** Actions are schema-validated functions that double as LLM tools. The model cannot invoke what no Action exposes, and params are validated *before* execution. That's OWASP's privilege minimization enforced in the type system rather than requested in a prompt — which is the whole difference, because a prompt is exactly the thing an injection attack overrides.

**3. Directives make the human-in-the-loop gate a first-class primitive.** This is the one that matters most. Side effects in Jido aren't executed inline — they're returned as **Directives**, structs the runtime interprets. So you can inspect a proposed side effect *as data* and gate it before anything happens. The recommended defense for high-consequence actions is [human confirmation that interposes a break in the automated attack chain](https://www.getmaxim.ai/articles/prompt-injection-defense-for-production-ai-agents-a-complete-2026-guide/) — a break "that cannot be bypassed by manipulating the model alone." Jido hands you the seam for free.

**4. Supervision contains a poisoned agent.** Let-it-crash means an agent whose context got contaminated dies and restarts from clean persisted state. Injection doesn't persist across a restart unless you persisted it.

---

**[`em:f6de6f`]**

The standard patterns are real: a **designated transfer workstation** for all external ingestion (deployments lacking one [introduce inconsistency and security gaps](https://www.zmanda.com/blog/air-gapped-backup-architecture-design/)), signed media with chain-of-custody, offline package mirrors, and data flowing **outward only** from the isolated zone. Verify hashes on the *air-gapped* side, so a compromised transfer box can't silently swap a file. Use an encrypted external SSD — [sneakernet gets painful past 50GB per bundle](https://localaimaster.com/blog/air-gapped-ai-deployment), and model weights blow through that.

**But I'd argue against a true physical air gap here.** Operational burden is what kills personal security systems — you'll stop using it by March. The pragmatic version gets you the same confidentiality property for a fraction of the friction:

- Run the inference server and agent in a **network namespace with no interface at all** — not firewalled, literally no route. On Linux that's `PrivateNetwork=yes` in a systemd unit; one line, and stronger than any firewall rule because there's nothing to misconfigure.
- Updates are a deliberate, manual, *separate* step where you temporarily run a networked unit to fetch and verify.
- **Backups can go to ordinary cloud storage** — encrypt at rest (LUKS/FileVault) with a key only you hold, and the provider stores ciphertext. This doesn't violate confidentiality, and it solves the hardest air-gap problem. Rehearse restores; untested backups aren't backups.
- Statements come in the way they already do — download on your normal machine, move via encrypted USB, parse in the sandbox.
