---
type: reference
title: 2026-07-27-llm-security-intakes-and-two-evaluation-beliefs
description: Two LLM-security intakes opened a new knowledge/SWE/security/ directory — the Beyond Refusal aligned-vs-abliterated paper and G DATA's malware-analysis field report — and the pair yielded fifteen glossary terms plus two ratified evaluation beliefs: coverage and quality must be measured jointly, and review is not an oracle.
provenance: "Claude Code session (Claude Opus 5), 2026-07-27; verbatim retained messages — tool calls, tool results, reasoning, and short pre-tool narration stripped"
tags: [meta, thread, intake, security, llm-safety, evaluation, beliefs, glossary]
timestamp: 2026-07-27
session: https://claude.ai/code/session_0113yunPXwKMEQQbUw8Tnzf5
---

# 2026-07-27-llm-security-intakes-and-two-evaluation-beliefs

## Where this landed

Two `/intake` invocations, both on LLM-security material, that turned out to
converge. The first was arXiv:2607.05842, a same-lineage study comparing an
aligned instruction-tuned model against its refusal-ablated descendant across a
task ladder from vulnerability detection to executable patch validation; the
second was Karsten Hahn's G DATA field report on using MCP-connected LLMs for
real malware analysis. Neither had bundle coverage, and neither fit an existing
directory, so the session opened
[`knowledge/SWE/security/`](/knowledge/SWE/security/index.md) — a subdirectory
under the already-established `SWE` domain, autonomous under the
taxonomy-evolution protocol, and ratified by the operator when flagged.

The convergence is what made the session more than two captures. The paper
measures models answering security questions ~97% of the time while differing
substantially in whether those answers are correct or actionable — a gap the
refusal-rate metric cannot see. The field report hits the same gap from inside a
workflow and locates where it closes: generated *scripts* are trustworthy because
they execute, generated *reports* are not, and five explicit verification passes
still left frequent errors in the report's highest-stakes fields.

The operator ratified extracting both halves as beliefs. `em:06de36`
([coverage and quality must be measured jointly](/beliefs/coverage-and-quality-must-be-measured-jointly.md))
generalizes the paper's `U(y) = C(y)·Q(y)` decomposition into an evaluation prior
about *what to measure*. `em:2ecdd2`
([review is not an oracle](/beliefs/review-is-not-an-oracle.md)) takes the field
report's five-pass result as its empirical case and governs *what counts as
having checked* — filed as a sibling rather than a dependent, since neither
follows from the other. Both were noted as already load-bearing in the repo: the
gate admission rule and the verification-grounding policy are the second belief
encoded as machine-enforced rules.

Two judgment calls were surfaced rather than buried. The G DATA post was
distilled as structured prose instead of the `/summarize-technical` layered body,
on the grounds that its value is workflow judgment rather than a jargon-dense
formalism the three-part structure exists to unpack. And
[invisible degradation](/beliefs/glossary/invisible-degradation.md) was left
untouched despite the post's "silent degradation" arguably being the same concept
applied to model output — that entry's canonical description is scoped to corpus
rot, and broadening it would have rewritten rather than extended it; the new
belief and `proof-of-vulnerability` cross-link to it instead.

Fifteen glossary terms were added from the paper's vocabulary across four
clusters, and no dedup-recall regression appeared across either intake (plain
6/15, steady).

## Routing

| Topic | State | Routed to | Dangling |
|---|---|---|---|
| Beyond Refusal paper — safety state vs. defender-side utility | closed | [beyond-refusal-safety-state-in-vulnerability-analysis](/knowledge/SWE/security/beyond-refusal-safety-state-in-vulnerability-analysis.md) | - |
| G DATA field report — LLMs in malware analysis | closed | [llms-in-malware-analysis-scripts-over-reports](/knowledge/SWE/security/llms-in-malware-analysis-scripts-over-reports.md) | - |
| New `knowledge/SWE/security/` directory; operator ratification | closed | [security index](/knowledge/SWE/security/index.md) | - |
| Coverage × quality as a portable evaluation prior | closed | [coverage-and-quality-must-be-measured-jointly](/beliefs/coverage-and-quality-must-be-measured-jointly.md) | - |
| Review is not an oracle — extracted as a second, sibling belief | closed | [review-is-not-an-oracle](/beliefs/review-is-not-an-oracle.md) | - |
| Fifteen glossary terms from the paper's vocabulary | closed | [glossary index](/beliefs/glossary/index.md) | - |
| Layered-body vs. structured-prose choice for a field report | closed | `unrouted` | Whether the security directory should be internally consistent in body format |
| `invisible-degradation` left un-broadened | paused | `unrouted` | Whether the model-output sense warrants a second paragraph on [that entry](/beliefs/glossary/invisible-degradation.md) or a distinct term |

## User

/intake https://arxiv.org/pdf/2607.05842

## Assistant

<routes ref="em:72d927">
The paper is filed. It's a same-lineage study — the same model with and without its refusal behavior surgically removed — asking whether safety alignment costs defenders anything on real vulnerability work. The finding worth carrying: refusal rate is nearly identical (~97% usable answers both ways), so the cost is invisible to the metric everyone reports. It shows up instead in the *quality* of answers that were given, and it inverts with task depth — the aligned model wins shallow classification under plain wording, the ablated one wins code-grounded localization and, on Java repair, produces 67.8% usable patches against 29.9%. The reversal is driven by prompt wording: the aligned model's usable Vul4J answers collapse from 32 to 8 as the request shifts from plain code review to professional security vocabulary, with zero validated repairs under either security-explicit frame.

One thing I deliberately kept in the body rather than smoothing over: the Java advantage does **not** generalize. Under neutral prompting the aligned model leads at every gate on C/C++ and edges Python. The honest claim is narrower than the abstract's framing suggests, so the technical summary states the bound explicitly.

I opened `knowledge/SWE/security/` for this. That's a subdirectory under the already-established `SWE` domain, so the taxonomy protocol makes it autonomous — flagging it because it's still a shape change you may want to weigh in on. Neither `llm-engineering` (inference and retrieval) nor `evals` (evaluation methodology) is really about software security, and I expect this directory to attract siblings — CyberSecEval, the Defensive Refusal Bias paper it extends.

**What I created**

| Type | Doc | Why this type |
|---|---|---|
| `reference` | beyond-refusal-safety-state-in-vulnerability-analysis (`em:72d927`) | External material captured and summarized; matches how VeriCache and other arXiv papers are filed |
| — | knowledge/SWE/security/index.md | Reserved directory listing for the new subdirectory |

**What I modified**

| File | Thrust |
|---|---|
| `knowledge/SWE/index.md` | Added the `security` row |
| `meta/registry.md` | Recompiled for the new id |
| `meta/evals/dedup-probe.md` | Baseline refreshed |

**Actions I have taken**

| Action | Result |
|---|---|
| Fetched the paper in full via alphaXiv | Captured completely — no summarization loss; distilled with the `/summarize-technical` three-part body |
| Synonym-expanded dedup search (abliteration, refusal, over-refusal, safety alignment, CWE, Vul4J, cyber, guardrail) | No existing document; created new rather than merged |
| `mix brain.id`, `brain.registry`, `brain.verify` | Minted `em:72d927`; bundle verifies clean |
| `mix brain.dedup_probe --update-baseline` | Plain recall 6/15 — no change, no regression |
| Committed and pushed to `claude/arxiv-2607-05842-intake-4w8hv3` | Full gate suite green (183 tests, route tags, glossary, contract) |

No gold row was harvested — the intake was a bare URL with no natural phrasing of yours to record, and the probe's upkeep rule says skip rather than invent one.

**Your options from here**

| # | Option | What it entails |
|---|---|---|
| 1 | Ratify or rename `knowledge/SWE/security/` | It's live; a rename now is cheap, later it's a shape change with link cost |
| 2 | `/add-to-glossary` on the new doc | Roughly a dozen terms have no entry — abliteration, refusal direction, CWE, patch-validation funnel, PoV pass, line-F1 |
| 3 | Extract the coverage×quality decomposition as a `belief` | It generalizes past security as an evaluation prior; currently only prose in "Why it matters for the brain" |
| 4 | `/create-pull-request` | Capture the session, glossary the thread, and open the PR |
</routes>

## User

<routes ref="em:06de36">
1 - approve
2 - create
3 - proceed

then /intake https://blog.gdatasoftware.com/2026/03/38381-llm-malware-analysis
</routes>

## Assistant

<routes ref="em:a1ec42 em:06de36">
All three items landed, plus the second intake. Pushed to `claude/arxiv-2607-05842-intake-4w8hv3`.

The G DATA post turned out to be a strong pairing with the paper rather than an unrelated capture. Both find the same gap from opposite directions: the paper measures models answering security questions ~97% of the time while varying widely in whether the answers are right; Hahn hits that from inside a real workflow and — this is the part worth keeping — names the subset where the gap closes. Generated scripts either run or throw. Reports don't, and his five verification passes still left frequent errors in exactly the fields a report exists to convey. That makes "review is not an oracle" the load-bearing finding, and it slots directly into the belief you asked me to extract.

Two judgment calls I'd flag rather than bury:

I did **not** use the layered `/summarize-technical` body for the G DATA post. Its value is workflow judgment and concrete failure modes, not a jargon-dense formalism that the plain-summary→terms→technical-summary structure exists to unpack. Forcing it would have padded a field report into a shape it doesn't have. Say the word if you'd rather it match the paper's structure for consistency within the directory.

I also left `invisible-degradation` untouched. The malware post's "silent degradation" is arguably the same concept applied to model output rather than corpus rot, but that entry's description is specifically scoped to corpus rot, and broadening it would have rewritten an existing canonical overview rather than extending it. I cross-linked to it from the new belief and from `proof-of-vulnerability` instead.

**What I created**

| Type | Doc | Why this type |
|---|---|---|
| `belief` | Coverage and quality must be measured jointly (`em:06de36`) | Normative evaluation prior, not an empirical claim — it prescribes how to measure, so it sits outside the verification ladder |
| `reference` | LLMs in malware analysis (`em:a1ec42`) | External material captured and summarized |
| 15 × `concept` | Glossary terms under `/beliefs/glossary/` | One file per term, individually linkable |

The glossary terms, by cluster — safety state: `abliteration`, `refusal-direction`, `over-refusal`, `safety-state`, `jailbreak`, `dual-use`. Security/repair: `common-weakness-enumeration`, `proof-of-vulnerability`, `automated-program-repair`, `patch-validation-funnel`, `vulnerability-localization`. Evaluation: `same-lineage-comparison`, `prompt-sensitivity`. Serving stack: `llama-cpp`, `gguf`.

**Actions I have taken**

| Action | Result |
|---|---|
| Ratified `knowledge/SWE/security/` | Now holds two documents |
| Fetched the G DATA post twice | Second pass for technical specifics the first summarized away |
| Dedup search on malware/reverse-engineering/oracle phrasings | No existing coverage |
| `mix brain.id`, `registry`, `glossary --materialize`, `verify` | 17 ids minted total; bundle verifies clean |
| `mix brain.dedup_probe --update-baseline` | 6/15 plain — steady across both intakes, no regression |
| Three commits pushed | Full gate suite green each time |

No new glossary entry tripped the body-repetition check — the warnings listed are all pre-existing files.

**Your options from here**

| # | Option | What it entails |
|---|---|---|
| 1 | `/create-pull-request` | Capture the session, glossary the thread, stamp `attribution.from`, open the PR |
| 2 | Review the belief's phrasing | It's the first belief not sourced from a wsff/Horthy lineage; worth checking it reads as yours |
| 3 | Extract a second belief on oracles | "Review is not an oracle" is arguably a distinct prior from the coverage×quality one, currently only prose in `em:a1ec42` |
</routes>

## User

<routes ref="em:2ecdd2">
3 - yes, commit to a belief
2 - approved
1 - proceed when done with above, then merg
</routes>
