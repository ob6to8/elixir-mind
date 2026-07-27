---
id: em:bdfa05
type: reference
title: "The Claude Certification Program — four role-based credentials and their blueprints"
description: Anthropic's certification program spans four proctored credentials (Associate, Developer, Architect Foundations, Architect Professional), each with a published exam guide stating its own domain blueprint, all scored on a 100–1,000 scale with a 720 cut and a 12-month validity period.
resource: https://anthropic-partners.skilljar.com/page/partner-certifications
provenance: "Anthropic Partner Academy certifications catalog and the four official exam guides (Version 1.0, effective July 2026)"
tags: [anthropic, certification, cca, exam, partner-network, credentials]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "the operator is studying toward the Claude Certified Architect exam; the program's structure and all four published blueprints are the primary ground for that study program"
---

# The Claude Certification Program

Anthropic's certification program launched alongside the
[Claude Partner Network](https://www.anthropic.com/news/claude-partner-network)
in March 2026. Four role-based credentials are published, each with its **own
public exam guide** (Version 1.0, effective July 2026) linked from the
[Partner Academy certifications catalog](https://anthropic-partners.skilljar.com/page/partner-certifications).

## The four credentials

| Credential | Code | Items | Fee | Domains |
|---|---|---|---|---|
| Claude Certified Associate – Foundations | `CCAO-F` | 60 | $99 | 7 |
| Claude Certified Developer – Foundations | `CCDV-F` | 53 | $125 | 8 |
| Claude Certified Architect – Foundations | `CCAR-F` | 60 | $125 | 5 |
| Claude Certified Architect – Professional | `CCAR-P` | 63 | $175 | 7 |

Common across all four: **120-minute** time limit, **scaled score of 720 on a
100–1,000 range**, **12-month validity**, proctored delivery (online or test
center) through Pearson VUE with registration via Anthropic Partner Academy.
The Associate credential "does not count toward Claude Partner Network tier
eligibility"; the other three do.

Scoring is **criterion-referenced** — measured against a fixed standard set by a
formal standard-setting study, not against other candidates. Score reports give
per-domain percent-correct, but only the total scaled score determines pass/fail.

**Renewal** is a free, non-proctored assessment on Partner Academy; a lapsed
credential requires retaking the full exam at full fee. Anthropic reserves the
right to require a full retake when exam content changes significantly.

## The blueprints

Each guide publishes its own weighted domain outline. They differ substantially
— these are genuinely different roles, not tiers of one syllabus.

**Associate – Foundations (`CCAO-F`)** — the business/technical generalist:

| # | Domain | Weight |
|---|---|---|
| 1 | Prompting and Task Execution | 14% |
| 2 | Output Evaluation and Validation | 21% |
| 3 | Product and Model Selection | 12% |
| 4 | Workflow Integration and Solution Design | 16% |
| 5 | Configuration and Knowledge Management | 12% |
| 6 | Governance, Risk, and Responsible Use | 15% |
| 7 | Troubleshooting and Optimization | 10% |

**Developer – Foundations (`CCDV-F`)** — note the pronounced concentration in
one domain, and how little weight Claude Code carries:

| # | Domain | Weight |
|---|---|---|
| 1 | Agents and Workflows | 14.7% |
| 2 | Applications and Integration | 33.1% |
| 3 | Claude Code | 3.1% |
| 4 | Eval, Testing, and Debugging | 2.6% |
| 5 | Model Selection and Optimization | 16.8% |
| 6 | Prompt and Context Engineering | 11.0% |
| 7 | Security and Safety | 8.1% |
| 8 | Tools and MCPs | 10.6% |

**Architect – Foundations (`CCAR-F`)** — the build-it credential; see the
[detailed blueprint](/knowledge/SWE/agentic/anthropic/certification/cca-foundations-exam-blueprint.md):

| # | Domain | Weight |
|---|---|---|
| 1 | Agentic Architecture & Orchestration | 27% |
| 2 | Tool Design & MCP Integration | 18% |
| 3 | Claude Code Configuration & Workflows | 20% |
| 4 | Prompt Engineering & Structured Output | 20% |
| 5 | Context Management & Reliability | 15% |

**Architect – Professional (`CCAR-P`)** — the enterprise credential, and the
contrast with Foundations is the informative part: hands-on orchestration and
tool design give way to governance, stakeholder communication, and lifecycle
management:

| # | Domain | Weight |
|---|---|---|
| 1 | Solution Design & Architecture | 17% |
| 2 | Claude Models, Prompting & Context Engineering | 13% |
| 3 | Integration | 19% |
| 4 | Evaluation, Testing & Optimization | 16% |
| 5 | Governance, Safety & Risk Management | 14% |
| 6 | Stakeholder Communication & Lifecycle Management | 14% |
| 7 | Developer Productivity & Operational Enablement | 7% |

Read across the four: **Associate** weights evaluation and governance,
**Developer** weights application integration, **Architect Foundations** weights
agentic orchestration, and **Architect Professional** weights the organizational
concerns. Only `CCAR-F` treats Claude Code configuration as a major domain (20%
against the Developer exam's 3.1%).

## Confidentiality

Every candidate accepts a non-disclosure agreement before the exam begins:

> "By accepting, you agree that all exam content, including questions, answer
> options, and scenarios, is the confidential and proprietary property of
> Anthropic, and that you will not disclose, reproduce, or distribute any
> portion of it."

The published guides — objectives, task statements, scenario descriptions,
sample questions — are public and freely usable. Actual exam items are not.

## Eligibility

Anthropic states that "Any organization that is bringing Claude to market is
eligible to join the Claude Partner Network", membership is free, and exams are
"currently available to Claude Partner Network members". **No primary source
states whether an unaffiliated individual may register** — the eligibility
language is written in terms of organizations throughout, while the Academy
catalog publishes per-exam consumer pricing.

# Citations

- [Partner Academy — certifications catalog](https://anthropic-partners.skilljar.com/page/partner-certifications)
- [Four role-based Claude certifications](https://claude.com/blog/four-role-based-claude-certifications)
- [Anthropic invests $100 million into the Claude Partner Network](https://www.anthropic.com/news/claude-partner-network)
- [Pearson VUE — Anthropic](https://www.pearsonvue.com/us/en/anthropic.html)

# See also

- [CCA Foundations exam blueprint](/knowledge/SWE/agentic/anthropic/certification/cca-foundations-exam-blueprint.md)
- [Anthropic primary-source surfaces](/meta/analysis/anthropic-primary-source-surfaces.md)
