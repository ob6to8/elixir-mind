---
type: reference
title: 2026-07-27-secure-financial-agent-and-projects-namespace
description: Specced a locally-hosted agentic system for sensitive financial documents — reframing "completely secure" as two independent properties and finding the models the operator named all unrunnable at personal scale — then opened the projects namespace to incubate it, and corrected the repo's Elixir pin diagnosis twice under operator challenge.
provenance: "Claude Code session (Claude Opus 5), 2026-07-27; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, security, local-inference, jido, projects, elixir, toolchain]
timestamp: 2026-07-27
pr: 145
session: https://claude.ai/code/session_01VDZ4JhC3FsNTwkcs1ci5uo
---

# 2026-07-27-secure-financial-agent-and-projects-namespace

## Where this landed

The operator asked how to build a completely secure agentic system for tax and
banking documents, naming Kimi K3, Inkling, and GLM 5.2 as candidate local models
and asking about hosting infrastructure, current harnesses, and Jido 2. The
answer reframed the request: confidentiality and integrity are independent
properties, local hosting buys only the first, and financial documents are
attacker-influenceable input — so indirect prompt injection, not data egress, is
the load-bearing risk. All three named models were verified real and all three
rejected as personally unhostable (Kimi K3 at ~1.4TB needs roughly eighteen 80GB
accelerators just to load); Llama was ruled out entirely, Meta having ship-paused
open weights for the closed Muse line. The recommended stack is a document VLM
plus a mid-size reasoner on one workstation, with Jido 2's pure reducer, typed
Actions, and directives-as-data supplying the audit trail and the approval gate.

Two corrections landed under operator challenge, both on the Elixir pin. The
first answer said "don't raise it" on the assumption that the sandbox base image
was fixed; the operator pushed back, and investigation showed Elixir 1.14 is
simply what `apt install elixir` yields on Ubuntu 24.04 — arriving through an
environment setup script the operator controls, not a base image. A separate
correction retracted the recommendation of `pi` over Claude Code as the dev
harness: the ranking had been made on a runtime criterion (minimal auditable tool
surface) that applies only to the component touching financial data.

The operator then proposed a `project` type and learned it was already ratified
and idle — zero documents used it, and no `projects/` directory existed. What was
missing was a home, which the operator ratified, along with scoping `plan` by
what it governs. The namespace shipped with its policy, the project hub, four
knowledge documents exercising the split rule, an architecture spec, and a plan
for the toolchain raise. That last artifact tested the boundary the policy had
just drawn: the operator assumed it belonged to the project, but raising *this
repo's* pin is brain governance, so it filed to `meta/plans/`.

The session closed by transitioning to
[spec-completion](/projects/secure-financial-agent/spec-completion.md), which
records what remains before code: three decisions only the operator can close
(hardware, isolation posture, gate placement) and three documents an agent can
draft (threat model, record schema, benchmark protocol), ordered by which build
step each unblocks. Two smaller findings were judged not worth a governance
artifact — a one-off stale read from the GitHub `get_check_runs` endpoint, whose
fix belongs in the `/create-pull-request` skill rather than in `meta/issues/`,
and a branch survey that the git-branch-deletion policy had already answered.
The thread landed across three PRs — #145 opened the namespace and stamped `pr:`, #148 carried the spec-completion transition, and #155 this closing capture; `pr:` above records the origin and is not rewritten.

A closing round settled three smaller matters. A coverage audit — run because
the operator asked whether everything discussed had been persisted — found the
hardware comparison and the air-gap operational patterns living only in the
thread render and a plan's decision rows; both were generalizable, so both
filed to the taxonomy and the plan's rows now link out to them. The
git-branch-deletion policy dropped "deleted on sight" for lingering merged
branches, widened past the operator's literal ask because the failing behavior
had been the *survey*, not the deletion. And the `/create-pull-request` skill
gained a guard against the stale `get_check_runs` read, written as a live
property of the endpoint rather than an incident note — the Chesterton's-fence
carve-out in
[living-text-is-present-tense](/meta/policy/living-text-is-present-tense.md),
which keeps a justification in a living surface while the event itself stays in
the commit graph and this record.

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| The two-property reframe; injection as the real risk | closed | [indirect-prompt-injection-in-document-pipelines](/knowledge/SWE/security/indirect-prompt-injection-in-document-pipelines.md) | - |
| Open-weight frontier scale vs. self-hostability | closed | [open-weight-frontier-models-mid-2026](/knowledge/machine-learning/open-weight-frontier-models-mid-2026.md) | - |
| Serving engines and sizing constraints | closed | [local-inference-serving-stacks](/knowledge/SWE/llm-engineering/local-inference-serving-stacks.md) | - |
| Confidential computing as the middle tier | closed | [confidential-computing-for-llm-inference](/knowledge/SWE/security/confidential-computing-for-llm-inference.md) | - |
| The system's charter, decisions, and shape | paused | [secure-financial-agent](/projects/secure-financial-agent.md) | Hardware pick, isolation posture, and gate placement — all three now tracked as operator-owned decisions in the spec-completion plan |
| Jido as the runtime; why this workload inverts the prior evaluation | closed | [architecture](/projects/secure-financial-agent/architecture.md) | - |
| What remains before code begins | paused | [spec-completion](/projects/secure-financial-agent/spec-completion.md) | Three operator decisions (hardware, isolation posture, gate placement) and three drafts (threat model, record schema, benchmark protocol) |
| Stale `get_check_runs` data during CI polling | closed | [/create-pull-request skill](/.claude/skills/create-pull-request/SKILL.md) | - |
| Scoping branch deletion to deliberate cleanup | closed | [git-branch-deletion](/meta/policy/git-branch-deletion.md) | - |
| Hardware tiers and air-gap operations, surfaced by a coverage audit | closed | [workstation tiers](/knowledge/SWE/llm-engineering/local-inference-workstation-tiers.md) · [air-gapped operations](/knowledge/SWE/security/air-gapped-operations.md) | - |
| Jido primitives mapped to security requirements | closed | [Jido](/beliefs/glossary/jido.md) | - |
| A home for the idle `project` type | closed | [project-namespace](/meta/policy/project-namespace.md) | - |
| Raising the Elixir/OTP floor | paused | [raise-elixir-otp-toolchain-floor](/meta/plans/raise-elixir-otp-toolchain-floor.md) | Install method, exact-vs-range pin, and whether a second environment needs the same script |
| Harness choice for building vs. running | closed | `unrouted` | - |

## User

I would like to create a completely secure agentic system to process sensitive financial information (taxes, bank statements, etc.) I assume this would mean hosting a local model like kimi k3, thinking machines inkling, glm 5.2 or equivalent? what infra options are there for hosting? would we use Llama? present up to date harness options (open code, warp.dev, zed, pi, etc). Also what would it look like to integrate Elixir/BEAM Jido 2?

## Assistant

## First, the reframe that changes the design

<routes ref="em:7da513 em:f6de6f">
You asked for "completely secure." The honest answer is that a local model buys you **one** of the two security properties you need here, and it's not the harder one.
</routes>

| Threat | What it looks like | Does local hosting fix it? |
|---|---|---|
| **Confidentiality** — your data leaves | Tax returns, account numbers, balances sent to a third-party API and retained | **Yes.** This is exactly what self-hosting solves. |
| **Integrity** — your agent gets hijacked | A PDF contains text the model reads as instructions; the agent then does something with the tools it holds | **No.** Completely unaffected. |

The second one is the real risk in *this specific* application, and it's easy to miss. Financial documents are not trusted input. A brokerage statement, a vendor invoice, a 1099 emailed to you — these are documents **an outside party controls the contents of**. That's the textbook setup for indirect prompt injection: malicious instructions embedded in external content an agent is told to process. The 2026 track record is not reassuring — [GitHub Copilot's CVE-2025-53773](https://dev.to/waxell/the-trusted-document-problem-why-indirect-prompt-injection-is-now-your-ai-agents-1-security-risk-5c14) (CVSS 9.6) was RCE via exactly this mechanism, and CNCERT found [~21,000 exposed OpenClaw instances](https://atlan.com/know/prompt-injection-attacks-ai-agents/) silently leaking API keys and conversation logs to injected instructions.

<routes ref="em:7da513">
So: run the model locally *for confidentiality*, but understand that the security of this system is decided by **what the agent is allowed to do**, not by where the weights sit. That's the part your Jido question turns out to be the right answer to — I'll come back to it.
</routes>

---

## The models you named: all three are wrong for this, for different reasons

<routes ref="em:28fac6">
I checked each. They're real, they're recent, and none of them is what you want.

| Model | Released | Size | Why not |
|---|---|---|---|
| **Kimi K3** | July 26, 2026 | 2.8T total, 16/896 experts active, 1M ctx | **1.4TB** in MXFP4 — [~18× 80GB accelerators just to load](https://www.techi.com/kimi-k3-open-weights-inference-economics/), before any context. An 8×Blackwell node (1.5TB) "barely fits the weights with almost nothing to spare." Not personally self-hostable. |
| **TML Inkling** | July 15, 2026 | 975B total / 41B active, Apache 2.0, multimodal | The active-param count is a *speed* number, not a *memory* number — you still resident all 975B. ~500GB at 4-bit. It's explicitly positioned as [a base for fine-tuning via Tinker](https://artificialanalysis.ai/articles/thinking-machines-has-released-inkling-the-new-leading-u-s-open-weights-model), debuting at 41 on the AA index — not a frontier reasoner. |
| **GLM-5.2** | June 13, 2026 | 753B / ~40B active, **MIT**, 1M ctx | The best of the three for this, and the license is the most permissive available. Still ~400GB at 4-bit. |

**Llama: don't.** Meta [ship-paused open-weight Llama](https://www.digitalapplied.com/blog/open-weight-models-h1-2026-retrospective-deepseek-qwen-llama) and pivoted frontier work to the closed Muse line. Behemoth never shipped. Building a 2026 system on Llama means building on an abandoned line.
</routes>

### The sizing mistake worth avoiding

The common error in MoE sizing is [using active params instead of total](https://www.spheron.network/blog/best-open-source-llms-self-host-2026-vram-guide/) — all experts must be resident. Every model above is a multi-node deployment.

**But look at what the workload actually is.** Processing tax documents and bank statements is: OCR → structured extraction → classification → arithmetic → summarization. That is *not* frontier reasoning. It's the workload the small-model tier has been crushing all year:

- **Document layer**: [Qwen2.5-VL-7B](https://presenc.ai/research/best-open-weight-ocr-document-ai-models-2026) is the dominant general document-AI model (OCR + layout + tables + chart extraction in one). For high-volume pure text, GOT-OCR2 does it in **580M params**. LightOnOCR if you want the smallest/fastest/cleanest.
- **Reasoning layer**: a 30–120B dense or small-MoE model for categorization and Q&A over the extracted structured data.

That whole stack fits on **one machine**, runs air-gapped, and will outperform a badly-quantized frontier model you can barely fit. Reach for GLM-5.2 later if you find a genuine reasoning ceiling — but design so the big model is optional.

---

## Infra options, as a ladder

| Tier | What | Cost | Confidentiality |
|---|---|---|---|
| **0. Workstation** ← *recommended* | [RTX PRO 6000 Blackwell, 96GB GDDR7 ECC](https://www.newegg.com/insider/nvidia-rtx-pro-6000-blackwell-workstation-96gb-gddr7-for-serious-local-ai/) (~$8.5k) · [DGX Spark, 128GB unified](https://www.blogarama.com/internet-blogs/1385826-codersera-blog/77195228-local-llm-hardware-showdown-june-2026-dgx-spark-strix-halo-rtx-6000-pro-max) ($4,699) · Mac Studio M3 Ultra (819 GB/s, largest single-machine unified memory outside enterprise) | $4k–15k one-time | **Total.** Air-gappable. |
| **1. Single-tenant bare metal** | Rented dedicated GPU box, your disk encryption, no hypervisor neighbors | $1–3/GPU-hr | High — but the host operator is in your trust boundary |
| **2. Confidential computing** | Intel TDX / AMD SEV-SNP + [H100/H200 in CC mode](https://www.spheron.network/blog/confidential-gpu-computing-nvidia-tee-encrypted-vram/): encrypted VRAM, TLS-like CPU↔GPU channel, composite attestation. [NVIDIA publishes 2–5% overhead](https://appscale.blog/en/blog/confidential-computing-ai-inference-tees-nitro-enclaves-nvidia-h100-h200-2026) | Cloud GPU + ~10% | **This is the credible way to run a 400GB+ model without owning it.** Azure Confidential GPU VMs, Phala, AWS Nitro Enclaves. |
| **3. Zero-retention API** | Enterprise API with contractual no-training/no-retention | Cheapest | Contractual, not technical |

<routes ref="em:f96824">
Tier 2 is the underrated one. It's how you'd use GLM-5.2 at full size without a $200k rack, and attestation gives you a *cryptographic* claim rather than a promise.
</routes>

<routes ref="em:f5914d">
### Serving stack

- **vLLM** — the production default. PagedAttention, continuous batching, and it takes FP8/MXFP4/NVFP4/INT4/GPTQ/AWQ/GGUF.
- **SGLang** — [lower latency than vLLM for structured JSON output, tool calls, and agent loops](https://builderai.tools/blog/state-of-open-source-llm-inference-engines-2026). Your workload is *exactly* structured extraction and tool calls, so benchmark this one seriously.
- **llama.cpp / Ollama** — laptop tier and CPU offload. `llama-server` gives an OpenAI-compatible endpoint, which matters below.

One caveat worth respecting: **FP4 is not the production default yet** — calibration tooling is still maturing and accuracy varies by model and task. Validate on your own documents before trusting a 4-bit quant with your taxes.
</routes>

---

## Harnesses — but note these are the wrong *category*

Everything you named (opencode, Warp, Zed, pi) is a **coding** harness. They're for *building* the system, not for *being* it. You do not want your tax pipeline running inside an interactive dev tool with `bash` and `write` in its tool list.

**For building it:**

| Harness | Fit |
|---|---|
| **pi** ([badlogic/pi-mono](https://www.npmjs.com/package/@mariozechner/pi-coding-agent)) | **Best fit.** Radical minimalism — [four built-in tools: read, write, edit, bash](https://explainx.ai/blog/pi-minimal-agent-harness-mario-zechner-guide-2026), everything else via TypeScript extensions. Built precisely because Claude Code's feature velocity made behavior unpredictable. A tool surface you can hold in your head is a tool surface you can audit. 62k+ stars. |
| **OpenCode** | Also strong. Go, [75+ providers including local via Ollama](https://www.firecrawl.dev/blog/best-ai-coding-agents), and explicitly **does not store your code or context** — designed for exactly the "can't send source to third parties" case. |
| **Zed** | Fast editor, GPL v3, agent interop via the open **ACP** standard (20+ agents, JetBrains). Good if you want editor-centric. |
| **Warp** | **Skip for this.** It rebranded to an "Agentic Development Environment" — cloud agents (Oz), session sharing, team knowledge in Warp Drive. Every one of those features is a data-egress path. Wrong tool for a confidential workload. |

**For the production pipeline: write your own.** Which brings us to your last question, and it's the best one you asked.

---

## Jido 2 / BEAM — this is where it gets interesting

<routes ref="em:44f899 em:f6de6f em:0d4f26">
Your brain already concluded Jido was a poor fit *for the brain's own tooling* — see [the BEAM/Jido evaluation](https://ob6to8.github.io/elixir-mind/meta/analysis/beam-deployment-and-jido-2-evaluation.html). But read *why* it said no:

> "the BEAM's distinctive strengths (supervision of long-lived state, massive concurrency, fault-tolerant services) have nothing to grip"

**A financial document pipeline gives them everything to grip.** It's resident, stateful, long-lived, concurrent, and needs an audit trail. This is the workload that analysis said was missing. Every blocker it listed was about *this repo* — the pinned 1.14/OTP 24 floor and the zero-dependency constraint — and none applies to a separate project.

More than that, Jido's primitives map onto the security requirements almost suspiciously well:

**1. The reducer is your audit trail.** A Jido agent is pure immutable data through a single `cmd(agent, {Action, params}) → {updated_agent, directives}`. That means every decision is **replayable without an LLM and without a network call**. For financial work — where "why did it categorize this deduction that way?" is a question you may have to answer to a human — a deterministic replay of the decision sequence is worth a great deal.

**2. Actions are the capability boundary.** Actions are schema-validated functions that double as LLM tools. The model cannot invoke what no Action exposes, and params are validated *before* execution. That's OWASP's privilege minimization enforced in the type system rather than requested in a prompt — which is the whole difference, because a prompt is exactly the thing an injection attack overrides.

**3. Directives make the human-in-the-loop gate a first-class primitive.** This is the one that matters most. Side effects in Jido aren't executed inline — they're returned as **Directives**, structs the runtime interprets. So you can inspect a proposed side effect *as data* and gate it before anything happens. The recommended defense for high-consequence actions is [human confirmation that interposes a break in the automated attack chain](https://www.getmaxim.ai/articles/prompt-injection-defense-for-production-ai-agents-a-complete-2026-guide/) — a break "that cannot be bypassed by manipulating the model alone." Jido hands you the seam for free.

**4. Supervision contains a poisoned agent.** Let-it-crash means an agent whose context got contaminated dies and restarts from clean persisted state. Injection doesn't persist across a restart unless you persisted it.
</routes>

### The shape

```
Untrusted zone            │ Trusted zone
──────────────────────────┼──────────────────────────────
PDF/CSV ingest            │
  ↓                       │
Sandboxed parse ──────────┼──→ structured data (no free text
(no net, no fs, ephemeral)│      into the reasoning context)
                          │        ↓
                          │  Jido AgentServer (supervised)
                          │    cmd/2 reducer → Directives
                          │        ↓
                          │    approval gate  ← you
                          │        ↓
                          │    Actions (typed, whitelisted)
                          │        ↓
                          │  local vLLM/SGLang, OpenAI-compatible
                          │  ↑ egress firewall: DENY ALL
```

Two details that carry weight:

- **Parse in a sandbox.** [Document conversion is itself the attack surface](https://medium.com/@securityhandyman/the-hidden-attack-vector-securing-document-conversions-in-agentic-ai-architectures-1e32b0cecee7) — the PDF→markdown preprocessing step, before the model sees anything. Run it with no network, no filesystem, ephemeral.
- **Default-deny egress at the OS level.** Don't trust the agent not to exfiltrate; make exfiltration impossible. This is the single highest-value control in the whole design, and it costs one firewall rule.

### The Jido caveats, stated plainly

- **Toolchain floor**: Elixir 1.17+/OTP 26+. Your brain repo is pinned at 1.14/OTP 24 — so this is a **separate mix project**, not an addition here.
- **`req_llm` is the single throat for all cognition.** Every inference goes through it. The upside for you: it sits on `Req`, so pointing it at a local OpenAI-compatible endpoint (vLLM or `llama-server`) is a base-URL config, not a fork.
- **No distribution.** `jido_cluster` [remains unpublished on hex](https://github.com/agentjido/jido) — re-checked as recently as your 2026-07-26 thread. Irrelevant here: this is a single-node personal workload, and one BEAM node holds millions of processes.
- **Maturity**: 2.x stable since Feb 2026, ~4.4k downloads/week. Young. Read the source of anything load-bearing.

---

## What I'd actually build

1. **One workstation, air-gapped**, default-deny egress. RTX PRO 6000 (96GB) or DGX Spark.
2. **Qwen2.5-VL-7B for extraction** (or GOT-OCR2 for pure text), a 30B-class model for reasoning. Skip the giants until something concretely fails.
3. **SGLang** serving, OpenAI-compatible — benchmark against vLLM on your structured-output path.
4. **Jido 2 in a separate mix project** as the agent runtime. Typed Actions as the capability list, Directives gated for anything that writes or leaves the box.
5. **pi** as the dev harness while you build it.
6. Revisit **GLM-5.2 on a confidential-computing tier** only if you hit a real reasoning ceiling. MIT license, and TDX+H100 attestation is a genuine security claim rather than a promise.

The thing to internalize: steps 1 and 4 are the security. Steps 2 and 3 are just performance.

---

### Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | File this as an `analysis` under `meta/analysis/` | It's a reasoned judgment on a question against evidence — the routing table's `analysis` row. Would cross-link the existing BEAM/Jido evaluation and update the Jido glossary's *Seen in* |
| 2 | Persist the architecture as a `plan` | If you intend to build it — captures build order and decisions for a future cold-context session |
| 3 | `/intake` the model releases | Kimi K3, Inkling, and GLM-5.2 are all filing-worthy for `knowledge/machine-learning/` on their own merits |
| 4 | Nothing — this was a question | The commit graph and a `/capture` at session close are the record |

**Sources:** [Kimi K3 economics](https://www.techi.com/kimi-k3-open-weights-inference-economics/) · [Kimi K3 overview](https://huggingface.co/blog/ResterChed/kimi-k3-model-overview-mxfp4-quantization-open-wei) · [Inkling analysis](https://artificialanalysis.ai/articles/thinking-machines-has-released-inkling-the-new-leading-u-s-open-weights-model) · [Inkling model card](https://thinkingmachines.ai/model-card/inkling/) · [GLM-5.2](https://www.eigent.ai/blog/glm-5-2) · [Open-weight H1 2026 recap](https://www.digitalapplied.com/blog/open-weight-models-h1-2026-retrospective-deepseek-qwen-llama) · [Inference engines 2026](https://builderai.tools/blog/state-of-open-source-llm-inference-engines-2026) · [VRAM tier guide](https://www.spheron.network/blog/best-open-source-llms-self-host-2026-vram-guide/) · [Hardware showdown](https://www.blogarama.com/internet-blogs/1385826-codersera-blog/77195228-local-llm-hardware-showdown-june-2026-dgx-spark-strix-halo-rtx-6000-pro-max) · [Confidential AI inference](https://appscale.blog/en/blog/confidential-computing-ai-inference-tees-nitro-enclaves-nvidia-h100-h200-2026) · [Confidential GPU computing](https://www.spheron.network/blog/confidential-gpu-computing-nvidia-tee-encrypted-vram/) · [Best AI coding agents](https://www.firecrawl.dev/blog/best-ai-coding-agents) · [pi harness](https://explainx.ai/blog/pi-minimal-agent-harness-mario-zechner-guide-2026) · [Zed vs Warp](https://soloterm.com/zed-vs-warp) · [The trusted document problem](https://dev.to/waxell/the-trusted-document-problem-why-indirect-prompt-injection-is-now-your-ai-agents-1-security-risk-5c14) · [Prompt injection defense guide](https://www.getmaxim.ai/articles/prompt-injection-defense-for-production-ai-agents-a-complete-2026-guide/) · [Document conversion attack vector](https://medium.com/@securityhandyman/the-hidden-attack-vector-securing-document-conversions-in-agentic-ai-architectures-1e32b0cecee7) · [Open-weight OCR models](https://presenc.ai/research/best-open-weight-ocr-document-ai-models-2026) · [Jido](https://github.com/agentjido/jido)

## User

what about raising the pin of this repo to elixir 1.17+/OTP 26+? I would like to keep the speccing of this system here as long as possible. 

1. you say you'd build a workstation, but above you seemed to lean towards option 2 confidential computing, which I assume is a secure cloud option? or was that only for frontier models?
2. confirm qwen
3. greek to me, approved
4. agree - but we punt on actually writing code until everything is specced here
5. unclear why to use pi vs claude code to build as cc is what i have used to build this repo
6. noted


I think there should be a new type - projects. this would be for the development of specs, info, and research for projects/systems that will built outside of this repo. the idea is that this knowledge system could live in one place and evolve without duplication occurring across repos, or at least not until the architecture here has settled and been broken out into a standalone dev library. the idea is that all research and dev towards this project could both build out the knowledge layer as research is being done as well as draw from it. So yes, this could technically be an analysis - though it would belong to this project, which should have some sort of home as a type. Thoughts?

## Assistant

## The pin: don't raise it, and you don't need to

Two separate things got tangled here.

**Speccing this system in the repo requires zero Elixir changes.** Specs are markdown. The pin gates *running* Jido code here, not documenting it. So your actual goal — "keep the speccing of this system here as long as possible" — is unblocked today.

**And raising it right now would actively break things.** I checked what this container ships:

```
Erlang/OTP 25 [erts-13.2.2.5]
Elixir 1.14.0 (compiled with Erlang/OTP 24)
```

`mix.exs` declares `elixir: "~> 1.14"`, and both `ci.yml` and `pages.yml` pin `otp-version: "25"` / `elixir-version: "1.14"`. Raise the requirement to `~> 1.17` and `mix` refuses to run *in this sandbox* — which means every Claude Code web session loses `brain.verify`, `brain.contract`, the pre-commit hook, and the SessionStart hook, until the image catches up. You'd break the working environment to enable something you're not doing yet.

Worth being clear about what the pin was never blocking, either: even at 1.17+, Jido still can't come into this repo, because the **zero-dependency constraint** is the real blocker and it's load-bearing (`mix.exs` says why — the toolchain "runs offline in any sandbox"). Jido would pull `req_llm` → `Req` → the HTTP stack into a project whose entire design premise is that it has no deps. The pin was the least of the three blockers.

**Raise it when something concrete needs it, and check the runner image first.** 1.14 is from Sept 2022 and is genuinely old, so this isn't "never" — it's "not for this reason."

---

## 1. Confidential computing vs. workstation — I was ambiguous, here's the rule

Yes, CC is a cloud option: your workload runs in someone else's datacenter, but inside a hardware-encrypted enclave with attestation, so the host operator theoretically can't read VRAM.

I listed it at tier 2 as **the fallback for models too big to own** — and since I'm recommending the small-model stack, you don't hit that case. The decision rule:

> **Can the model fit on hardware you physically possess?** If yes → workstation, always. If no → confidential computing is how you use a bigger one without trusting a provider's promise.

For personal tax and banking documents, the workstation wins on every axis simultaneously — cheaper (one-time vs. per-hour), strictly more private (no attestation to reason about, no enclave escape research to track, air-gappable), and simpler. CC only becomes interesting if you later decide you need GLM-5.2 at full size. Treat it as a documented escape hatch, not part of the v1 design.

## 2. Qwen — confirmed, but I gave you a stale version

Correcting myself: **Qwen3-VL**, not Qwen2.5-VL. That earlier search surfaced an out-of-date article and I passed it through without catching it.

- [Qwen3-VL](https://github.com/QwenLM/Qwen3-VL) — dense at 2B/4B/8B/32B, MoE at 30B-A3B/235B-A22B, all **Apache 2.0**. Native 256K context, expandable to 1M. 32 languages, robust to low light/blur/tilt, improved long-document structure parsing.
- Built-in document tasks are exactly your workload: document parsing, text localization, information extraction, **table parsing**, formula recognition.
- The [flagship 235B-A22B rivals Gemini 2.5 Pro](https://qwen3-vl.com/) on OCR and document comprehension — but you want **8B or 32B**, which is the point: it fits your workstation with room to spare.
- Newer still: [Qwen3.5 (Feb 2026)](https://www.mindstudio.ai/blog/what-is-qwen-3-5-alibaba-open-weight-model) added a 0.8B–27B dense lineup plus MoE variants, Apache 2.0, with [Qwen3.5-VL](https://docs.nvidia.com/nemo/megatron-bridge/nightly/models/vlm/qwen35-vl.html) in the family.

The one thing I won't assert without evidence: which specific variant is best *on your documents*. Bank statement layouts and IRS forms are their own domain. That's a benchmark to run at build time — hold 20 real pages back as a test set — not a spec-time decision.

## 5. pi vs. Claude Code — use Claude Code, I conflated two things

Fair challenge, and you're right. I collapsed two different harnesses into one recommendation:

- **The harness that builds the system** — writes Elixir, edits specs, never touches a bank statement. Threat model: none beyond normal development. **Use Claude Code.** You know it, it built this repo, and switching costs you fluency for no security gain.
- **The runtime that processes financial documents** — that's the Jido thing you'd write, and it's not a coding harness at all.

pi's minimal 4-tool surface is an auditability argument, and auditability only matters for the *second* one. Since you're punting on code anyway (#4), this is moot for now. Revisit only if you later want the dev loop itself air-gapped.

---

## The `project` type — it already exists

Here's the thing: `project` is **already in the ratified vocabulary**. From [controlled-type-vocabulary](https://github.com/ob6to8/elixir-mind/blob/claude/secure-local-financial-agent-o1dm5a/meta/policy/controlled-type-vocabulary.md):

> `project` — an active, goal-bounded effort.

It's been in the seed list since the beginning. I grepped: **zero documents use it**, and there's no `projects/` directory. So this isn't a type proposal needing ratification — the type is ratified and idle. What's missing is a **home and a convention**, which is a directory question, and creating a new top-level directory *is* the thing [taxonomy-evolution-protocol](https://ob6to8.github.io/elixir-mind/meta/policy/taxonomy-evolution-protocol.html) says you ratify.

That's a much smaller ask than what you thought you were making.

### The design

Reuse the pattern already proven by the glossary — hub doc beside a directory:

```
projects/
  index.md                          # reserved listing, no frontmatter
  secure-financial-agent.md         # type: project, em: id, status — THE HUB
  secure-financial-agent/
    index.md
    architecture.md                 # the spec
    threat-model.md
    model-selection.md              # incl. the benchmark results
```

The hub carries the `em:` id, a `status`, the charter, and — critically — **links out** rather than restating.

### The anti-duplication rule, which is the whole point

Your stated goal is that research both builds *and* draws from the knowledge layer. That works if the split is explicit:

| Content | Home | Test |
|---|---|---|
| True regardless of this project | `knowledge/` (em: id) | "Kimi K3 is 2.8T params" · "indirect prompt injection via document conversion" · "TEE attestation for GPU inference" |
| True only *for this system* | `projects/<slug>/` | "we chose Qwen3-VL-8B because it benchmarked best on our statements" · the build order · the threat model |

So today's research yields *both*: a handful of `knowledge/machine-learning/` docs on the model releases and `knowledge/SWE/security/` on injection defense — reusable by any future project — plus a project spec that cites them. The next project that needs "what's the state of open weights" reads the knowledge doc; it doesn't re-research. **That's the mechanism**, and it's the same "fit each layer to its purpose" doctrine already in the contract.

It also makes the eventual break-out clean: when this graduates to a standalone repo, `projects/<slug>/` is what you export, and the `knowledge/` docs stay — which is exactly the sequencing you described.

### Two wrinkles I'd rather flag than silently decide

**1. `plan` vs. project-scoped design docs.** The vocabulary says `plan` "lives under `meta/plans/`" and [governance-artifact-routing](https://github.com/ob6to8/elixir-mind/blob/claude/secure-local-financial-agent-o1dm5a/meta/policy/governance-artifact-routing.md) routes design records there. But `meta/` is governance of *this brain* — a spec for an external system isn't that. My recommendation: `meta/plans/` stays brain-scoped, and project-internal design docs live in `projects/<slug>/` as `type: plan`. Needs a one-line vocabulary amendment saying so.

**2. Bundle namespace, so `em:` ids and `attribution`.** Unlike `inbox/`, `survey/`, and `journal/` — which are non-bundle staging tiers — `project` is a first-class bundle type sitting beside `area` in the vocabulary. Ids matter here precisely *because* of the break-out: a stable id survives the move to another repo where the path won't.

Both are cheap. The work is: create `projects/` + index, write `meta/policy/project-namespace.md`, amend the vocabulary, run `/render-contract`, then file the hub and today's research.

---

### Questions you need to answer

| # | Question | My recommendation |
|---|---|---|
| 1 | Ratify `projects/` as a new top-level directory? | **Yes** — the type is already ratified and idle; this just gives it a home. Structure as above. |
| 2 | Do project-scoped design docs live in `projects/<slug>/` as `type: plan`, keeping `meta/plans/` brain-scoped? | **Yes** — `meta/` is governance of the brain, not of external systems. One-line vocabulary amendment. |

### Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | Ratify, then I build the namespace and file this session's output | `projects/` + policy + `/render-contract`, then the `secure-financial-agent` hub, the architecture spec, and the `knowledge/` docs the research yielded |
| 2 | Ratify the directory only; file research as `knowledge/` now, spec later | Splits the work — knowledge layer lands immediately, project layer waits |
| 3 | Amend the pin separately as its own change | Not recommended now, per above — but could be filed as a `todo` with the runner-image check as its precondition |

## User

ok sounds good, but why exactly does elixir need to be pinned to 1.14? wouldn't it just break active images, but new images would be built fine with 1.17?

1. 

2. I guess i would assume we just start with the latest Qwen? what workstation would have the recommended specs? how do you handle updates backups and data transfer with an air gapped machine?

5. what do you think led to the conflation? what is meant by "Revisit only if you later want the dev loop itself air-gapped."?


re: questions:

1. yes
2. yes

## Assistant

All gates green. Here are your answers.

## The pin — you were right, my reasoning was wrong

I assumed the base image was fixed and outside your control. It isn't. Here's what's actually true:

```
elixir  1.14.0.dfsg-2   from  archive.ubuntu.com/ubuntu noble/universe
erlang-base  1:25.3.2.8+dfsg-1ubuntu4.6
Ubuntu 24.04.4 LTS (Noble Numbat)
```

**The pin is at 1.14 because that is exactly what `apt install elixir` yields on Ubuntu 24.04.** It was never a decision — it's a distro default that `mix.exs` and both workflows were written to match. Elixir isn't even in Claude Code's [documented pre-installed tools](https://code.claude.com/docs/en/claude-code-on-the-web) (Python, Node, Ruby, PHP, Java, Go, Rust, C/C++, Docker, Postgres, Redis — no BEAM), so it's arriving via a setup script on this environment.

And setup scripts are yours: *"To add packages that aren't pre-installed, use a setup script. The script's output is cached, so packages you install there are available at the start of every session without reinstalling."*

So your model is correct — new sessions would pick up 1.17 fine. The one refinement: it doesn't happen automatically from a repo edit, because the setup script lives in **environment config, not the repo**. Which makes this an ordered change, not a one-liner:

1. Update the environment setup script to install Elixir 1.17+/OTP 26 (Erlang Solutions repo, or asdf/mise — not `apt`, which will keep handing you 1.14).
2. Start a session, confirm `elixir --version`.
3. *Then* bump `mix.exs` and the `elixir-version`/`otp-version` pins in `ci.yml` and `pages.yml`.

Order matters: reverse it and a session starts, `mix` refuses the version, and every brain task is dead until you fix the script. That was the real content of my warning — I just attributed it to the wrong cause.

Worth noting it still doesn't unblock Jido *here* — the zero-dependency constraint is the binding one, and this sandbox is capped at 4 vCPU / 16 GB RAM / 30 GB disk, so it could never run a local model regardless. Spec here, run on the workstation. But raising the pin is cheap, overdue (1.14 is from Sept 2022), and worth doing on its own merits.

## 2. Qwen, hardware, and air-gap ops

<routes ref="em:28fac6">
**Start with the latest, yes** — [Qwen3-VL](https://github.com/QwenLM/Qwen3-VL) (Apache 2.0; dense 2B/4B/8B/32B, MoE 30B-A3B/235B-A22B), or [Qwen3.5-VL](https://docs.nvidia.com/nemo/megatron-bridge/nightly/models/vlm/qwen35-vl.html) from the Feb 2026 family. Plan around **32B**; drop to 8B if it benchmarks equivalently on your documents, which it may well.
</routes>

### Workstation

Budget both models resident simultaneously plus KV cache — Qwen3-VL is native 256K context, and long documents eat cache.

| Build | Memory | Price | Trade |
|---|---|---|---|
| **DGX Spark** ← default | 128GB unified LPDDR5X | $4,699 | Full CUDA, so vLLM/SGLang run first-class. Lower bandwidth than GDDR7 → slower decode, which barely matters for batch document processing |
| **RTX PRO 6000 Blackwell** | 96GB GDDR7 ECC | ~$8,565 + host (~$12–14k built) | Much higher bandwidth. Buy this if you want interactive latency, not overnight batches |
| **Mac Studio M3 Ultra** | up to 512GB unified, 819 GB/s | varies | Largest single-machine memory outside enterprise; silent, low-power, doubles as a daily driver. But no CUDA — MLX or llama.cpp, not vLLM/SGLang |

Your workload is a few hundred pages a few times a year plus ad-hoc queries. Latency is nearly irrelevant; memory capacity and correctness are not. That's why the Spark is the default pick. One honesty note: I don't have measured tok/s for Qwen3-VL-32B on Spark specifically — if you can benchmark before buying, do; otherwise favor the machine that's useful for other things too.

### Updates, backups, transfer — and a recommendation against full air-gapping

<routes ref="em:f6de6f em:cc0c87">
The standard patterns are real: a **designated transfer workstation** for all external ingestion (deployments lacking one [introduce inconsistency and security gaps](https://www.zmanda.com/blog/air-gapped-backup-architecture-design/)), signed media with chain-of-custody, offline package mirrors, and data flowing **outward only** from the isolated zone. Verify hashes on the *air-gapped* side, so a compromised transfer box can't silently swap a file. Use an encrypted external SSD — [sneakernet gets painful past 50GB per bundle](https://localaimaster.com/blog/air-gapped-ai-deployment), and model weights blow through that.

**But I'd argue against a true physical air gap here.** Operational burden is what kills personal security systems — you'll stop using it by March. The pragmatic version gets you the same confidentiality property for a fraction of the friction:

- Run the inference server and agent in a **network namespace with no interface at all** — not firewalled, literally no route. On Linux that's `PrivateNetwork=yes` in a systemd unit; one line, and stronger than any firewall rule because there's nothing to misconfigure.
- Updates are a deliberate, manual, *separate* step where you temporarily run a networked unit to fetch and verify.
- **Backups can go to ordinary cloud storage** — encrypt at rest (LUKS/FileVault) with a key only you hold, and the provider stores ciphertext. This doesn't violate confidentiality, and it solves the hardest air-gap problem. Rehearse restores; untested backups aren't backups.
- Statements come in the way they already do — download on your normal machine, move via encrypted USB, parse in the sandbox.
</routes>

Full air gap stays available if you later decide the threat model warrants it. I've filed this as an open question on the hub rather than pre-deciding it.

## 5. What led to the conflation

I drew the distinction — "these are coding harnesses, they're for building the system, not being it" — and then in the very next breath ranked them on the *runtime* criterion anyway: minimal auditable tool surface. That criterion only applies to the thing that touches financial data. A dev harness should be ranked on fluency, capability, and how well you know it, and on those Claude Code obviously wins for you.

The mechanism: the whole answer was pitched in a security frame, and I carried it across a boundary I had just finished drawing. Writing a distinction down isn't the same as applying it — I needed to re-check which side of the line the recommendation landed on, and didn't.

**On "revisit if you want the dev loop itself air-gapped":** Claude Code sends your source and specs to Anthropic. That's fine for specs. Two things would change it — (a) the architecture doc becomes sensitive in its own right, since it documents your security controls and is therefore a roadmap for attacking them, or (b) you want to develop while disconnected. Claude Code requires Anthropic's API, so either trigger means a harness driving a local model, and *that's* when pi or OpenCode matter. Neither trigger is active, and I'd have said so rather than leaving it as a dangling condition.

---

### What I created

| Type | Doc | Why this type |
|---|---|---|
| `policy` | [project-namespace](https://github.com/ob6to8/elixir-mind/blob/claude/secure-local-financial-agent-o1dm5a/meta/policy/project-namespace.md) | An enforceable rule that must fire unprompted in future sessions — so it compiles into the contract rather than sitting inert as a plan |
| `project` | [secure-financial-agent](https://github.com/ob6to8/elixir-mind/blob/claude/secure-local-financial-agent-o1dm5a/projects/secure-financial-agent.md) `em:f6de6f` | The hub: premise, shape, decisions, open questions. Bundle doc, so the id survives break-out |
| index | `projects/index.md`, `projects/secure-financial-agent/index.md` | Reserved listings for the new namespace |

### What I modified

| File | Thrust |
|---|---|
| `meta/policy/controlled-type-vocabulary.md` | Gave `project` a home and a status set; scoped `plan` by *what it governs* — `meta/plans/` for the brain, `projects/<slug>/` for external systems |
| `index.md` | Listed `projects/` as a top-level domain |
| `meta/policy/index.md` | Registered the new policy under `directory-structure` |
| `CLAUDE.md`, `meta/registry.md` | Regenerated |

### Actions I have taken

| Action | Result |
|---|---|
| `mix brain.id` | Minted `em:f6de6f` |
| `mix brain.contract` / `--check` | Recompiled; up to date |
| `mix brain.registry` / `--check` | Recompiled; up to date |
| `mix brain.verify` | *"Bundle verifies: ids, edges, and grounding all check out."* |
| Trimmed 5 forward-links from the hub | They pointed at knowledge docs not yet filed; left as prose so no broken links ship |

### Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | File the research as `knowledge/` docs | The four pending: open-weight frontier models mid-2026, local inference serving stacks, indirect prompt injection in document pipelines, confidential computing for LLM inference. Restores the hub's links and proves the split rule pays |
| 2 | Write the architecture spec into `projects/secure-financial-agent/` | The structured-plan-bodies treatment — trees, boundary decisions, signatures. The natural next artifact |
| 3 | File the pin raise as a `todo` | With the setup-script step as its explicit precondition |
| 4 | `/create-pull-request` | Lands the namespace before going further |

## User

Stop hook feedback:
[~/.claude/stop-hook-git-check.sh]: There are uncommitted changes in the repository. Please commit and push these changes to the remote branch.

## Assistant

Committed and pushed as `2afc1c9` on `claude/secure-local-financial-agent-o1dm5a`.

### Actions I have taken

| Action | Result |
|---|---|
| `git add -A` + commit | `2afc1c9` — 9 files (4 new, 5 modified) |
| Pre-commit gate suite | All passed: format, xref, contract/registry/codemap freshness, `brain.verify`, route tags, glossary, lineage, `mix test --warnings-as-errors` (183 tests, 0 failures) |
| `git push -u origin claude/secure-local-financial-agent-o1dm5a` | New branch tracking origin |

Two warnings surfaced but are editorial-only and pre-existing — the glossary description/body overlap list, and a ledger cross-check on `2026-07-13-execute-branch-transplant-ports`. Neither was introduced by this change and neither fails the build.

I did not open a PR — that was option 4 and you haven't selected it. Say the word (or `/create-pull-request`) and I'll run the full capture → glossary → attribution-stamp → PR motion.

### Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | File the four researched `knowledge/` docs | Open-weight frontier models mid-2026, local inference serving stacks, indirect prompt injection in document pipelines, confidential computing for LLM inference — restores the hub's links and exercises the split rule the policy just established |
| 2 | Write the architecture spec into `projects/secure-financial-agent/` | Structured-plan-bodies treatment: current/desired trees, boundary decisions, signatures |
| 3 | File the pin raise as a `todo` | With the environment setup-script step as its stated precondition |
| 4 | `/create-pull-request` | Lands the namespace before going further |

## User

create a plan detailing the process to update elixir/otp per your instruction here

options:

1. yes file
2. yes
3. yes, but a todo within the project correct?
4. proceed, and merge

## Assistant

All nine carry unmerged commits, so the policy bars me from touching them — surfacing rather than acting.

**PR [#145](https://github.com/ob6to8/elixir-mind/pull/145) merged as `5654a39`; head branch auto-deleted.**

Thread doc: `meta/threads/2026-07-27-secure-financial-agent-and-projects-namespace.md`

### Actions I have taken

| Action | Result |
|---|---|
| `/capture` | Parsed the session log; drop rule (`len < 300 and followed_by_tool`) retained 9 blocks verbatim — 5 operator, 4 agent |
| Route tags + `--materialize` | 8 regions over the frozen body; +1 ref after fixing a ledger cross-check warning. 321 regions / 94 sink appends, fidelity re-derived |
| `/add-to-glossary` | 4 new terms: indirect prompt injection, TEE, SGLang, active parameters. None tripped the description-overlap warning |
| `attribution.from` stamping | 3 governance docs — 2 created, 1 appended |
| `mix brain.contract` / `registry` / `glossary --materialize` | Regenerated; all `--check` gates green |
| `mix brain.dev_history` | **Skipped** — refused on shallow clone (the sanctioned skip) |
| Commits `0b863b0`, `5523c20` | Full pre-commit suite green both times; 183 tests, 0 failures |
| CI on `5523c20` | All 19 steps green |
| Merge | `merge_method: "merge"` — true merge commit, per the merge-strategy policy |

### What shipped

| Type | Doc |
|---|---|
| `policy` | project-namespace |
| `project` | secure-financial-agent `em:f6de6f` |
| `plan` | architecture `em:0d4f26` (project-scoped) · raise-elixir-otp-toolchain-floor (brain-scoped) |
| `reference` | open-weight-frontier-models-mid-2026 `em:28fac6` · local-inference-serving-stacks `em:f5914d` |
| `concept` | indirect-prompt-injection-in-document-pipelines `em:7da513` · confidential-computing-for-llm-inference `em:f96824` · 4 glossary terms |

Two notes worth flagging. **The check-runs endpoint served stale data** — it reported `in_progress` for ~5 minutes after the job had actually finished at 23:13:05; `actions_get` on the job showed the truth. Worth knowing if a future session polls that endpoint and concludes CI is hung.

And the `plan` scoping decision you ratified got tested immediately, in the direction you didn't expect: the toolchain plan filed to `meta/plans/`, not the project. Raising *this repo's* Elixir pin is governance of this brain, so the policy's own rule sent it there.

### Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | Execute the toolchain plan | Step 1 is yours — pick the install method based on what your local machine uses. I can't reach the environment setup script |
| 2 | Review the 9 unmerged branches | All carry work with no other home; the policy requires your ratification before any deletion. Oldest is 9 commits ahead |
| 3 | Continue the project spec | Threat model, or the parse-worker record schema — the first build-order item |
| 4 | Resolve the two open questions on the hub | Air gap vs. default-deny host; where the approval gate sits in your workflow |

## Assistant

Stale timers cleared. Nothing changed from my last report — PR #145 is merged as `5654a39`, head branch deleted, working tree clean.

The four options from my previous message still stand whenever you want to pick one up:

| # | Option |
|---|---|
| 1 | Execute the toolchain plan (step 1 is yours — the install method, based on what your local machine uses) |
| 2 | Review the 9 unmerged `claude/*` branches — all carry work with no other home, so deletion needs your call |
| 3 | Continue the project spec — threat model, or the parse-worker record schema |
| 4 | Resolve the hub's two open questions — air gap vs. default-deny host; where the approval gate sits |

## User

where would something like "The check-runs endpoint served stale data — it reported in_progress for ~5 minutes after the job had actually finished at 23:13:05; actions_get on the job showed the truth. Worth knowing if a future session polls that endpoint and concludes CI is hung." be filed, if worth filing?

"	Review the 9 unmerged branches" - these are previous or open dev branches, why is this being surfaced here?

keep the plan, don't execute
disregard the branches

for further dev, we want to transition to a plan describing what needs to be done next and close out this thread

## Assistant

Three answers, then I'll do the transition work.

## 1. Where the check-runs finding goes

By the routing table it looks like an `issue` — "a live concern about how the brain behaves." But I'd argue against filing a governance doc at all, for two reasons.

**It's n=1 on an external API.** GitHub's check-runs endpoint served stale data once. That could be ordinary eventual consistency rather than a durable defect, and a `meta/issues/` doc asserts more confidence than one observation supports. The failure mode is also benign — a session stalls waiting, it doesn't merge red.

**More importantly, an issue doc would be inert.** The contract's own reasoning applies: *"a rule that must fire unprompted, mid-work — where an agent would not know to go looking — belongs in a policy; filing it as a plan or tutorial leaves it inert."* An agent polling CI mid-PR is not going to browse `meta/issues/` first. The place it would actually be read is [`/create-pull-request`](https://github.com/ob6to8/elixir-mind/blob/main/.claude/skills/create-pull-request/SKILL.md) step 10, which is the very instruction that sends agents to the stale endpoint:

> "poll the PR's checks (`mcp__github__pull_request_read` with `get_check_runs`) until CI is green"

So my recommendation is **a one-clause amendment to that step** — confirm a non-terminal status against `actions_get` on the job before concluding CI is still running — and no separate artifact. Living surface, present tense, read at the moment it matters. If it recurs after that, *then* it has earned an issue.

I haven't made that edit; you asked where it would go, not to do it. It's in the options table below.

## 2. The branches — you're right, that was noise

I ran that check because the git-branch-deletion policy has a clause about merged branches being "deleted on sight," and I wanted to know whether it applied. It didn't — all nine were unmerged, which is exactly the case the policy says to leave alone and never propose deleting without you.

Having established that, the correct move was to say nothing. Instead I reported the negative result as an agenda item, which converted "not my business" into something you had to spend a line dismissing. Ordinary open dev branches are not a finding.

## 3. Transition plan

Working on it now.

## Assistant

PR [#148](https://github.com/ob6to8/elixir-mind/pull/148) is open. Left unmerged — you said close out the thread, and merge is opt-in.

### What I created

| Type | Doc | Why this type |
|---|---|---|
| `plan` | spec-completion `em:6e97e5` | Deferred work with a cold-context handoff — the two conditions `plan-vs-capture` names for escalating past commit-and-capture |

### What I modified

| File | Thrust |
|---|---|
| Thread doc | Extended in place with the closing exchanges; ledger settled — architecture strand `closed`, charter and spec strands `paused` with their questions now tracked in the plan |
| Project hub | Open questions point at the plan that owns them; Documents section lists both design records |
| `secure-financial-agent/index.md` | Listed the plan |

### Actions I have taken

| Action | Result |
|---|---|
| Restarted branch from `main` | #145 had merged, so per the merged-PR rule this is a fresh change, not a stack. Base is now `d08abf2` (#147 landed meanwhile) |
| Full gate suite | Green — 328 route-tag regions, 98 sink appends, 183 tests, 0 failures |
| Opened PR #148 | Not merged |

One judgment worth surfacing: I set the two remaining hub questions to `paused` rather than `closed`, because they aren't resolved — they're **relocated** into the plan with owners and blocking relationships attached. Marking them closed would claim progress that didn't happen.

The plan's own ordering makes one substantive claim you may want to check: that the threat model has to precede the record schema. The reasoning is that provenance-per-field and a confidence signal are only justifiable against stated threats, so drafting the schema first would produce fields chosen by intuition. If you'd rather get the schema down first as the more concrete artifact, that's a defensible inversion — it just means accepting those fields provisionally.

### Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | Merge #148 | One word |
| 2 | Amend `/create-pull-request` step 10 | The `get_check_runs` cross-check — small, and the only place it'd be read |
| 3 | Answer D1/D2 | Both gate build step 1; D1 is mostly budget, D2 is mostly friction tolerance |
| 4 | Have me draft S1 (threat model) | The first agent-ownable item, unblocked today |

## User

re:"So my recommendation is a one-clause amendment to that step — confirm a non-terminal status against actions_get on the job before concluding CI is still running — and no separate artifact. Living surface, present tense, read at the moment it matters. If it recurs after that, then it has earned an issue." - would this be stronger with provenance attribution that spawned its creation (ie. this event?)

i think we should avoid a general "delete merged branches on site" and save it for cleanup sessions. lets make that change

1 - not yet
2 - unsure
3 - not seeing d2/d2, relist
4 - is this persisted in a plan or todo? trying to wrap this session up, while also making certain everything covered has been persisted

## Assistant

Pushed to PR #148. Answers to your four:

## 1. Provenance on the skill amendment — yes, but as a *why*, not an attribution

Good instinct, and the contract already draws the line. Two policies collide here and one carves out the answer.

`living-text-is-present-tense` forbids retrospective narration in operational surfaces — a skill file shouldn't say "added after a 2026-07-27 incident." But it explicitly carves out **Chesterton's-fence justifications**:

> "A comment explaining why live code still exists ... justifies present code and reads as *this is why this exists*, not as a changelog. Keep."

That's exactly this case. A bare "cross-check with `actions_get`" reads as arbitrary ceremony and invites a future agent to trim it. So the amendment should carry its reason **as a present-tense fact about the endpoint**, not as an event:

> …poll the PR's checks until CI is green — the `get_check_runs` endpoint can report `in_progress` for a job that has already completed, so confirm a non-terminal status against `actions_get` on the job before concluding CI is still running.

The *event* provenance lives where `provenance-lives-in-metadata` puts it: the commit message and the thread doc. One origin, one home. Putting the date in the skill body would be a shadow copy of the record layer.

## 2. Branch deletion — changed

`meta/policy/git-branch-deletion.md` no longer says "deleted on sight." Replaced with:

> **Deletion belongs to the merge motion, not to later sessions.** A merged branch noticed in passing is left alone: cleaning up someone else's leftovers is not part of the work at hand, and surveying branches to find them turns an unrelated session into an audit. Sweeping merged branches is its own deliberate cleanup task, run when the operator asks for one — and a session that is not that task does not survey, propose, or report on branch state.

I widened it past what you literally asked. Your fix addresses deletion; my actual failure was the *survey* — I ran the check, then reported it. Barring deletion alone would have left the noise intact. Contract recompiled.

## 3. D1–D3, relisted

<routes ref="em:6e97e5 em:a01073">
They're in `spec-completion.md`, which is on the unmerged PR #148 branch — not on `main` yet, which is likely why you couldn't find them.
</routes>

| | Decision | The real question | Blocks |
|---|---|---|---|
| **D1** | **Hardware** — DGX Spark (128GB unified, CUDA, $4,699) · RTX PRO 6000 Blackwell (96GB GDDR7, ~$8.5k + host) · Mac Studio M3 Ultra (up to 512GB, **no CUDA**) | Budget, and batch vs. interactive. The CUDA axis is the trap: Apple rules out vLLM and SGLang, so it's a serving-stack choice disguised as a hardware one | build steps 2–3 |
| **D2** | **Isolation posture** — full physical air gap vs. a host where the inference and agent processes have no network interface at all | How much operational friction you'll actually sustain. Encrypted-at-rest backups to ordinary cloud storage resolve the hardest flow, since the provider holds only ciphertext | build step 1 |
| **D3** | **Gate placement** — where approval sits in your real workflow, and its cost per document | Only answerable against volume: documents per session, directives per document | build step 4 |

## 4. S1 is in the plan, and the audit found two real gaps

S1 (threat model) is item S1 of `spec-completion.md` (`em:6e97e5`) — a plan, not a todo, correctly: the *approach* still needs deciding, which is the plan/todo discriminator.

But your instinct to check coverage was right, because the audit **found two things discussed at length and never persisted outside the thread render**:

| Gap | Now filed |
|---|---|
| Hardware tier comparison | `local-inference-workstation-tiers.md` `em:a01073` |
| Air-gap update/backup/transfer patterns | `air-gapped-operations.md` `em:cc0c87` |
| Qwen3-VL / Qwen3.5 sizes and OCR capability | Extended the existing landscape doc in place, rather than fragmenting |

Both were generalizable, so by the split rule they belonged in the taxonomy, not buried in a plan's decision rows. D1 and D2 now link out to them instead of carrying the reasoning inline. Everything substantive from this session is now on disk.

### Your options from here

| # | Option | What it entails |
|---|---|---|
| 1 | Merge #148 | Now carries the plan, the branch policy change, and the coverage close-out |
| 2 | The skill amendment | I'd add it with the why-clause above — say the word |
| 3 | Answer D1/D2 | Both gate build step 1 |
| 4 | Draft S1 | Unblocked today, but it's the natural start of a *next* session rather than this one |

## User

2, then merge
is there anything about 3/4 that needs to be persisted in this pr?

## Assistant

Merged as `9f63491`. Head branch auto-deleted (that setting was confirmed working on #145).

## On 3/4 — no, nothing needs persisting

I checked rather than assuming, and both are already fully captured:

**D1–D3** exist as decision rows in `spec-completion.md`, each carrying its owner, the question that resolves it, and what it blocks. The *reasoning* behind them now lives in the two knowledge docs they link out to — so a cold-context session reads the hardware tiers and air-gap patterns from the taxonomy rather than re-deriving them. Leaving the decisions unanswered isn't a gap; holding them open across sessions with their context attached is precisely the plan's job.

**S1** exists as its own row with the content sketch already written — adversaries in scope, adversaries explicitly out, trust boundaries, and the note that the accepted-risk list is the point. Drafting it is next-session work, and nothing about *not having drafted it* is information worth recording.

The one thing I looked for specifically: anything said in chat about these that never reached a doc. The closest candidate was my D1 recommendation (Spark as the default for batch workloads), and the general form of that reasoning is in the hardware doc — *"a batch pipeline that runs overnight is capacity-bound and barely notices bandwidth"* — so the inference is reproducible from what's filed. The specific pick stays yours by design.

## Session complete

| Landed | |
|---|---|
| PR [#145](https://github.com/ob6to8/elixir-mind/pull/145) → `5654a39` | The projects namespace, its policy, the project hub, four knowledge docs, the architecture spec, the toolchain plan, the thread capture, four glossary terms |
| PR [#148](https://github.com/ob6to8/elixir-mind/pull/148) → `9f63491` | The spec-completion plan, two more knowledge docs closing the coverage gap, the branch-deletion policy change, the CI-polling amendment, the thread close-out |

Three governance changes came out of your corrections rather than the original task — the branch-deletion scoping, the CI-polling guard, and the `plan` scoping rule. All three are now in the contract or the skill, so they bind future sessions rather than living in this transcript.

When you pick this up, the entry point is `projects/secure-financial-agent.md` → `spec-completion.md`. D1 and D2 are the cheapest unlocks; S1 is the first thing I can draft without you.

## Assistant

All timers cleared. Nothing changed since my last report — both PRs are merged (`5654a39`, `9f63491`) and the working tree is clean.

Worth noting for next time: I over-scheduled those waits. I fired a fresh sleep timer before each CI poll, which left four armed at once when CI finished on the first or second check — hence the trailing notifications. One timer at a time, re-armed only if the poll shows work still in flight, would have been the right shape.

Session is complete. The pickup point is `projects/secure-financial-agent.md` → `spec-completion.md`, where D1 and D2 are the cheapest unlocks and S1 is the first item I can draft without you.

