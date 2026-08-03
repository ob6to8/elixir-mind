---
id: em:ec728d
type: reference
title: "MAST: Multi-Agent System Failure Taxonomy (\"Why Do Multi-Agent LLM Systems Fail?\")"
description: "UC Berkeley's empirically-grounded taxonomy of 14 multi-agent LLM system failure modes across 3 categories, built from 1,600+ annotated execution traces across 7 MAS frameworks."
resource: "https://arxiv.org/abs/2503.13657"
provenance: "Distilled from the arXiv abstract and paper body (2503.13657v3), fetched 2026-08-03; layered breakdown via /summarize-technical"
tags: [evals, agentic, multi-agent-systems, failure-taxonomy, MAS, berkeley, mast, agent-supervision]
timestamp: 2026-08-03
attribution:
  when: 2026-08-03T00:00:00Z
  channel: intake
  agent: "Claude Code agent, /intake"
  why: "operator asked to find and capture the Berkeley multi-agent-failure taxonomy paper (evals)"
---

# MAST: Multi-Agent System Failure Taxonomy

## Summary

Multi-agent LLM systems (several LLM agents coordinating on a task) are
popular, but benchmarks show they barely outperform a single agent — and
often fail outright, 41% to 86.7% of the time across state-of-the-art
systems in this study. Nobody had a principled account of *why*. This paper
builds one: the researchers had expert annotators read 150 execution traces
from real multi-agent systems (ChatDev, MetaGPT, AG2, HyperAgent, and
others) and tag every distinct way the system went wrong. That process
converged on **14 recurring failure modes**, grouped into **3 categories** —
problems baked into the system's design, breakdowns in how agents talk to
each other, and inadequate checking of the work before calling it done. The
authors validated the taxonomy against 1,600+ traces total (with high
agreement between human annotators, and between an LLM-based annotator and
the humans), then used it diagnostically: two case-study systems tweaked
according to what the taxonomy revealed most often broke them gained 9.4–15.6
percentage points, using the *same underlying models* — the fix was
architectural, not a bigger model.

## Key terms

- **Multi-Agent System (MAS)** — several LLM-driven agents (often with
  distinct roles) coordinating, via conversation or a shared protocol, to
  complete one task.
- **MAST (Multi-Agent System Failure Taxonomy)** — this paper's classification
  scheme: 14 failure modes (FM-1.1 … FM-3.3) clustered into 3 failure
  categories (FC1–FC3).
- **MAST-Data** — the accompanying dataset: 1,600+ annotated execution traces
  across 7 popular MAS frameworks, spanning coding, math, and general agent
  tasks, and models GPT-4, Claude 3, Qwen2.5, and CodeLlama.
- **Grounded Theory** — the qualitative-research method used to *derive* the
  taxonomy: rather than proposing categories up front, annotators tagged 150
  traces and let the 14 modes emerge from repeated patterns, refined over
  several rounds until inter-annotator agreement stabilized.
- **Inter-annotator agreement (Cohen's κ)** — the paper's reliability check on
  its own taxonomy: κ=0.88 among human experts building it, κ=0.79 on unseen
  systems/benchmarks (generalization check), and κ=0.77 between the LLM
  annotator and human experts.
- **LLM-as-a-Judge pipeline** — the scalable annotator the paper builds once
  the taxonomy is fixed: an LLM (OpenAI o1) labels new traces against MAST's
  14 modes, reaching agreement with human annotation close to human-human
  agreement, which is what lets MAST-Data scale past what manual annotation
  alone could cover.

### FC1 — System design issues (5 modes)
Failures baked in before execution even starts — ambiguous specs, bad
architecture.
- **FM-1.1 Disobey task specification** — the system does something other than
  what the task asked for.
- **FM-1.2 Disobey role specification** — an agent acts outside the
  responsibilities it was assigned.
- **FM-1.3 Step repetition** — the system redoes work it already completed.
- **FM-1.4 Loss of conversation history** — context needed later drops out of
  what an agent can see.
- **FM-1.5 Unaware of termination conditions** — the system doesn't recognize
  when it should stop.

### FC2 — Inter-agent misalignment (6 modes)
Failures in the *coordination* between agents during execution — the largest
category.
- **FM-2.1 Conversation reset** — the interaction restarts, discarding
  progress.
- **FM-2.2 Fail to ask for clarification** — an agent proceeds on an
  ambiguous instruction instead of asking.
- **FM-2.3 Task derailment** — the conversation drifts away from the actual
  goal.
- **FM-2.4 Information withholding** — an agent has information another agent
  needs and doesn't share it.
- **FM-2.5 Ignored other agent's input** — one agent's contribution is
  dropped by another.
- **FM-2.6 Reasoning-action mismatch** — an agent's stated reasoning doesn't
  match what it actually does.

### FC3 — Task verification (3 modes)
Failures in checking the work.
- **FM-3.1 Premature termination** — the system stops before the task is
  actually complete.
- **FM-3.2 No or incomplete verification** — output ships without adequate
  checking.
- **FM-3.3 Incorrect verification** — a check runs but reaches the wrong
  verdict (e.g. approves broken output).

## Technical summary

The authors formalize MAS failure analysis as an annotation problem and solve
it with Grounded Theory: 6 expert annotators independently coded 150 traces
from 5 MAS frameworks (~20 hours per expert), iteratively resolving
disagreements across three rounds of inter-annotator-agreement (IAA) study
(~10 hours) until reaching κ=0.88 on a converged 14-mode taxonomy, organized
into FC1 (system design issues — specification and architecture failures
originating before or independent of inter-agent interaction), FC2
(inter-agent misalignment — breakdowns in the information flow and
coordination during execution), and FC3 (task verification — inadequate
detection/correction of errors, including premature termination). The
taxonomy was then validated for generalization on two new MAS (OpenManus,
Magentic-One) against two new benchmarks (MMLU, GAIA), holding at κ=0.79.

To scale annotation beyond manual expert labeling, the authors built a
few-shot LLM-as-a-Judge pipeline (backed by OpenAI o1) that labels traces
against the fixed 14-mode taxonomy, reaching κ=0.77 agreement with human
experts — close enough to substitute for human annotation at scale. This
pipeline produced MAST-Data: 1,600+ annotated traces (a 210-trace subset with
full human annotation) across 7 MAS frameworks (including ChatDev, MetaGPT,
HyperAgent, AppWorld, AG2, Magentic-One, OpenManus), spanning GPT-4, Claude 3,
Qwen2.5, and CodeLlama, over coding, math, and general-agent tasks. Measured
failure rates ranged 41%–86.7% depending on system and benchmark. The paper's
headline finding is architectural, not capability-bound: applying targeted
interventions informed by which FM/FC dominated a system's failures (in
ChatDev and AG2-MathChat case studies) produced +9.4% to +15.6% task
performance gains using identical underlying models — i.e. the ceiling on
these systems was mostly organizational/design, not the LLM's raw
capability, echoing high-reliability-organization theory's framing of
failure as a property of structure, not just of components. The authors
release MAST, MAST-Data, and the LLM annotator publicly, positioning MAST as
a diagnostic starting point (not an exhaustive catalog) for MAS reliability
engineering.

## Why it is in this brain

This is the primary empirical grounding for diagnosing *why* an
orchestrator/subagent architecture in this brain's own agentic-systems
research might underperform: the FC2 (inter-agent misalignment) category in
particular gives named failure modes — reasoning-action mismatch,
information withholding, ignored input — that map directly onto concerns
already tracked here around
[the observer-subagent pattern](/knowledge/SWE/agentic/anthropic/claude-code/observer-subagent-pattern.md),
[agent teams](/knowledge/SWE/agentic/anthropic/claude-code/agent-teams.md), and
[scar-tissue behavioral drift](/knowledge/SWE/agentic/agentic-loop/scar-tissue-behavioral-drift-in-long-running-agents.md).
FC3 (task verification) is the closest primary-literature counterpart to this
bundle's own verification-grounding policy and
[the gate suite](/meta/tutorials/the-gate-suite-and-where-it-runs.md) — MAST's
"no or incomplete verification" and "incorrect verification" modes are
exactly the failure classes a mechanical gate exists to close off.

# Citations

- Cemri, Pan, Yang, Agrawal, Chopra, Tiwari, Keutzer, Parameswaran, Klein,
  Ramchandran, Zaharia, Gonzalez, Stoica, *Why Do Multi-Agent LLM Systems
  Fail?* (NeurIPS 2025, Datasets & Benchmarks Track):
  <https://arxiv.org/abs/2503.13657>
