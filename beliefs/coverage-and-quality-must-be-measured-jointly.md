---
id: em:06de36
type: belief
title: Coverage and quality must be measured jointly, or degradation hides behind availability
description: An evaluation that scores only whether a system produced an answer cannot see a system whose answers got worse — availability and correctness are one measurement, and reporting either alone is a metric that a degraded system passes.
provenance: "Claude Code session, 2026-07-27 — synthesized while intaking the Beyond Refusal paper (arXiv:2607.05842), whose coverage×quality decomposition generalizes past its security setting; ratified as a belief by the operator in the same session"
tags: [belief, evaluation, metrics, measurement, degradation]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, arXiv:2607.05842 intake session — operator-directed belief filing"
  why: "operator directed extracting the coverage×quality decomposition as a belief generalizing past the security setting"
---

# Coverage and quality must be measured jointly, or degradation hides behind availability

A system under evaluation can fail in two ways that a single metric cannot
separate: it can decline to answer, or it can answer badly. Measuring only the
first — response rate, uptime, completion rate, non-refusal — produces a number
that a thoroughly degraded system passes cleanly, because every degraded answer
still counts as an answer. The prior: **treat "did it respond" and "was the
response any good" as two factors of one measurement**, and distrust any headline
figure that reports only the first.

The formulation that names it comes from
[Beyond Refusal](/knowledge/SWE/security/beyond-refusal-safety-state-in-vulnerability-analysis.md),
where defender-side utility decomposes as `U(y) = C(y)·Q(y)` — coverage times
answer quality, with unusable answers scoring zero. Its sharpest statement of the
consequence, quoted verbatim:

> "A model that rarely refuses but produces incorrect localization or unusable
> patches may be no more useful to defenders than one that refuses frequently."

That paper measured it in a setting where the stakes make the point unusually
legible — it argues that in security deployment "availability, correctness, and
actionability are not merely usability concerns; they are security-relevant
properties of the system" — and found the effect empirically: both model states
answered ~97% of the time while differing substantially in whether those answers
were correct or actionable. The refusal-rate metric saw nothing.

The belief is held as an evaluation prior rather than a finding about language
models, because the failure shape is not specific to them. Any measurement that
counts *events* while assuming their *quality* is constant inherits it: a test
suite scored by tests-run, a retrieval layer scored by hit count, a pipeline
scored by throughput. It is the measurement-side counterpart of
[invisible degradation](/beliefs/glossary/invisible-degradation.md) — degradation
that emits no signal is degradation that the instrument was not built to emit a
signal for.

The practical consequence is a design rule for any metric this brain adopts:
where a quality dimension exists, multiply it in and let unusable output score
zero, so a single number cannot be satisfied by volume alone. This is the same
reasoning that makes
[decompose-then-verify](/knowledge/SWE/evals/decompose-then-verify-factuality.md)
score claims rather than responses.

# Citations

- Li, Qiu, Peng, Fan, Fu, Ding & Feng, "Beyond Refusal: A Same-Lineage Study of
  Aligned and Abliterated LLMs for Vulnerability Analysis", arXiv:2607.05842v1
  [cs.SE], 7 Jul 2026 — <https://arxiv.org/abs/2607.05842>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:06de36">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-27-llm-security-intakes-and-two-evaluation-beliefs (2026-07-27)

2 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:06de36`]**

1 - approve
2 - create
3 - proceed

then /intake https://blog.gdatasoftware.com/2026/03/38381-llm-malware-analysis

---

**[`em:06de36`]**  (co-feeds: `em:a1ec42`)

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
