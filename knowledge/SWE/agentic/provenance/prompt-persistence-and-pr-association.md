---
id: em:225073
type: reference
title: "Persisting prompts with pull requests — the 2026 landscape"
description: Research spike on whether prompts are saved, associated with pull requests, and committed to open-source repos alongside code — finding tool-identity disclosure converged on the Assisted-by trailer while prompt persistence did not converge at all, every standard and product that touches prompts references them by URL rather than embedding them, and the binding constraint is agent compliance rather than mechanism.
provenance: "Compiled by Claude Opus 5 from a 2026-08-07 web sweep; verbatim spans carry their source URLs, and spans reaching this document through a secondary source are marked as such"
tags: [provenance, attribution, git, pull-requests, open-source, governance, prompts, spec-driven-development, agent-trace, assisted-by, compliance, landscape]
timestamp: 2026-08-07
attribution:
  when: 2026-08-07T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked for the current state of thinking on saving and associating prompts with pull requests and persisting them to open source repos alongside the source code, prepared as a research spike"
---

# Persisting prompts with pull requests — the 2026 landscape

## The short answer

The field converged on recording **which tool** produced a contribution and did
not converge on recording **what was asked of it**. Every mechanism that has
reached standardization — the `Assisted-by:` commit trailer, the Agent Trace
record, Claude Code's `Claude-Session:` trailer — carries a *tool identity* or a
*reference*, and none carries prompt text. The one live practice of committing
transcripts into repositories is driven by tools that offer it as an option,
not by any maintainer policy asking for it.

Three separate questions get run together in discussion of this subject, and
they have different answers:

| Question | State as of 2026-08 |
|---|---|
| Should a contribution disclose that AI was used, and which? | **Converged.** `Assisted-by:` trailer; ~51% of repos with an AI policy require some disclosure |
| Should the prompt/session be *referenceable* from the commit or PR? | **Emerging.** Agent Trace `conversations[].url`, `Claude-Session:` trailer — a link, never the text |
| Should the prompt/transcript be *committed into the repository*? | **No convergence, no policy demand.** Tool-offered, individually adopted, argued against by the spec-driven camp |

## What converged: tool identity in a commit trailer

The Linux kernel's `Documentation/process/coding-assistants.rst` — committed
2025-12-23, shipped with Linux 7.0, added by Sasha Levin and stated to be
"based on the consensus reached at the 2025 Maintainers Summit" — fixes the
format:

> Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]

with the worked example

> Assisted-by: Claude:claude-3-opus coccinelle sparse

and the accountability rule that keeps the legal certification human:

> AI agents MUST NOT add Signed-off-by tags.

The bracketed items name companion static-analysis tools (coccinelle, sparse,
smatch, clang-tidy); ordinary tooling — git, gcc, make, editors — is excluded.

**The kernel document says nothing about prompts.** Scope of that finding: a
full-text read of the rendered page at `docs.kernel.org/process/coding-assistants.html`
and of the raw `.rst` at `raw.githubusercontent.com/torvalds/linux/master/…`
surfaced no section on recording, disclosing, or preserving prompts, prompt
logs, chat sessions, or transcripts, and no section on agent configuration
files in the tree.

`Assisted-by:` is preferred over `Co-Authored-By:` on an accountability
argument rather than an aesthetic one: a co-author trailer presents the model
as a teammate and implies a share of responsibility, whereas `Assisted-by:`
records what helped without certifying anything or moving accountability. The
trailer form is chosen because it is mechanically greppable —
`git log --grep="Assisted-by:"`, `git interpret-trailers`, pre-commit hooks, CI
gates, SBOM tooling.

### How widely, and in what form

Hora and Robbes, *AI Policy, Disclosure, and Human in the Loop: How Are
Contribution Guidelines Adapting to GenAI?* (arXiv:2605.16706v2, 2026-07-13),
analyzed 1,000 popular GitHub repositories and found 118 carrying an AI policy
in `CONTRIBUTING.md`, `DEVELOPING.md`, or a dedicated `AI_POLICY.md` /
`LLM_POLICY.md` / `AI_USAGE_POLICY.md`. Of those 118:

- **51% (60 repos) require disclosure.**
- Mechanisms are the PR description and commit trailers (`Assisted-By:`,
  `Co-Authored-By:`).
- One project asks for a three-level declaration: *(1) Fully AI-generated,
  (2) Mostly AI-generated, (3) Mostly Human-written*.
- Four repositories explicitly decline to require disclosure, one reasoning
  that "AI is a normal developer's tool, similar to an IDE, an OS, or a
  keyboard."
- The paper flags a definitional gap: policies lean on "significant",
  "substantial", and "meaningful" without defining the threshold at which
  disclosure becomes mandatory.

The wider policy spectrum runs from outright ban to enforced disclosure: QEMU
declines contributions believed to include AI-generated content; Gentoo's
Council voted unanimously in 2024 to forbid contributions assisted by
natural-language AI tools; NetBSD presumes such code tainted; Fedora recommends
`Assisted-by:` and requires disclosure when the significant part of a
contribution is taken from a tool without changes; MicroPython requires an AI
declaration in every PR template.

## What did not converge: the prompt itself

**No open-source project surveyed requires the prompt.** Scope: the
`melissawm/open-source-ai-contribution-policies` registry (300+ projects,
read in full) and the 118-repo Hora/Robbes corpus. Across both, disclosure
targets *which tool was used* and *whether a human reviewed*, never the
generative process. IREE asks for `Assisted-by:` or `Generated-by:`; EasyBuild
requires declaring the specific models and tools; envoyproxy asks for AI-usage
information in the PR description; ClickHouse permits but does not require
sharing methods. None asks for prompts, transcripts, or session links.

Andrew Nesbitt's *RFC: Artificial Contributors to Open Source* (2026-05-21) —
a satirical proposal, but a fair index of what the discussion contains — is
likewise silent on prompts. It requires that disclosure "SHOULD appear in the
pull request description or as a commit trailer" and that a fully generated
patch "MUST NOT be described as 'AI-assisted'", proposes no machine-readable
format, and concedes the enforcement problem directly: "No reliable mechanism
exists for determining whether a contribution was produced by an AC."

## Where a standard does exist, it links rather than embeds

**Agent Trace** (v0.1.0, RFC status, January 2026) is the vendor-neutral
specification in this space — announced by Cognition on 2026-01-29 and
published as an RFC in the `cursor/agent-trace` repository, with Amp,
Amplitude, Cline, Cloudflare, Cognition, git-ai, Jules, OpenCode, Tapes, and
Vercel listed as supporters. Its stated purpose:

> Agent Trace is an open specification for tracing AI-generated code. It
> provides a vendor-neutral format for recording AI contributions alongside
> human authorship in version-controlled codebases.

The trace record is JSON, keyed on file paths and 1-indexed line ranges, with a
`contributor` field distinguishing human / AI / mixed / unknown. Prompts enter
the schema only as references: each entry in `conversations` carries a `url`
linking to the conversation record, plus an optional `related` array for
sessions and prompts. **No field holds prompt text.** And on storage the spec
declines to rule:

> The spec is unopinionated about where traces live.

Local files, git notes, a database — all conforming.

**git-ai**, the open-source Git extension implementing the spec alongside Cline
and OpenCode, resolves the storage question toward **git notes**: line-level
provenance recorded in notes, moved and merged across rebase, squash, merge,
reset, stash, and cherry-pick — the property that makes attribution survive the
history rewriting a normal PR flow performs. Its hosted prompt store then
resolves the prompt question in the opposite direction from the operator's
framing:

> Agent sessions are stored in a private, encrypted object store — not in git
> repositories.

The store holds raw sessions ("every prompt and response exactly as sent") and
generated summaries, reached through an API with per-read and per-write access
controls. Thoughtworks placed git-ai in the Radar's **Assess** ring.

Claude Code's own `Claude-Session:` trailer is the same shape: a URL to the
cloud transcript, injected by the harness into commits Claude authors in web
sessions, with the session URL also placed in the PR body. A link that resolves
to the full record, not the record itself.

## The counter-practice: transcripts committed into the repo

This does happen, and it is tool-driven rather than policy-driven.
**SpecStory** writes every AI coding session to `.specstory/history/` as
timestamped markdown and documents both options — commit the directory "to your
repo for team visibility", or `.gitignore` it. **Aider** writes
`.aider.chat.history.md` into the working tree by default. In both cases the
repository becomes the store, the transcript is diffable and greppable, and
nothing about the practice is requested or recognized by any maintainer policy
found in the registries above.

This brain is itself an instance of that practice at scale: 182 thread
documents holding roughly 600,000 words of verbatim session transcript
committed to the repository, 168 of them stamped with a `session:` URL, and 330
of 551 commits carrying the harness-injected `Claude-Session:` trailer. The
practice exists; the norm does not.

## The case for prompts at review time — argued, polled, unresolved

Piotr Migdał's *Vibe coding needs git blame* (2026-01-09) is the clearest
statement of the affirmative case. It asks for attribution as a baseline —

> I think that all contributions from AI should be attributed as such (both
> code changes and commits).

— names three benefits of going further and tracking the prompts themselves
("Learning… Intent verification… Efficient reviewing"), and identifies the
missing piece:

> We already have standards like MCP and `SKILL.md` — and we need one to share
> prompts alongside git commits.

The article proposes no mechanism — no trailer, no file format, no notes
convention — beyond noting that its authors are building a tool. It also
reports the one available measurement of sentiment: in a Gergely Orosz poll on
making prompts visible during code review, **49% liked it and 24% disliked it**.
That distribution is the honest summary of the field's position — a plurality
in favor, a substantial minority opposed, and no consensus to standardize on.

GitHub's own guidance declines to close the gap. *Agent pull requests are
everywhere. Here's how to review them.* (2026-05-07) reports that "More than one
in five code reviews on GitHub now involve an agent", and puts the burden on the
human author rather than on tooling: "If you're opening an agent-generated pull
request, edit body before you request review." Copilot coding agent session logs
*are* reachable from the PR timeline, so the raw material exists — but the
review advice is to write intent into the PR body by hand, not to surface the
session.

## The objection: persist the spec, not the transcript

The spec-driven camp accepts the premise that discarding prompts is a loss and
rejects the transcript as the artifact to keep. Sean Grove's *The New Code* (AI
Engineer World's Fair, 2025) supplies the argument's most-quoted line — reaching
this document through secondary reporting rather than a fetch of the talk
itself, and marked accordingly: developers are described as saying they "keep
the generated code and delete the prompt … like you shred the source and then
very carefully version control the binary".

The conclusion drawn is not "commit the transcript" but "write and version the
**specification**" — the normative artifact stating intent, as against the
descriptive artifact recording what was said. GitHub's Spec Kit
(constitution → specify → plan → tasks → implement), AWS Kiro (requirements in
EARS notation, design, tasks), and Tessl's spec-as-source are the
productizations. See [spec-driven development](/beliefs/glossary/spec-driven-development.md)
and, for the underlying distinction, [normative records vs. descriptive
traces](/knowledge/SWE/agentic/supervision/normative-records-vs-descriptive-traces.md):
a trace records what an agent did; a decision record records what was
authorized, by whom, and why — and it is the second that oversight asks for.

## Attribution metadata is a consent surface

Any scheme that writes provenance automatically inherits the lesson of the VS
Code incident. A 2026-04-16 merge changed `git.addAICoAuthor` to `all`, making
every commit from VS Code carry a Copilot co-author trailer unless explicitly
disabled, with no UI toggle and no notice — and, through a defect, tagging
commits where AI features were disabled or unused. The default was reverted on
2026-04-18 and restored to `never` on 2026-05-03, with a public apology.

The objection was not to attribution but to unconsented modification of the
permanent record: commit history is a chain of authorship, review,
responsibility, blame, and compliance, and the editor appeared willing to
rewrite it. A scheme that auto-commits *prompts* — which carry far more
incidental content than a trailer does, including credentials, private
reasoning, and third-party material — sits further along the same axis.

## Compliance, not mechanism, is the binding constraint

Yang, He, and Zhou, *A First Look at Coding Agents' Compliance with AI
Contribution Rules in Open-Source Communities* (arXiv:2607.26819, 2026-07-29),
built RepoComplianceBench — 106 GitHub issues drawn from 49 repositories with
documented AI policies — and tested four frontier models against four rule
types (Refuse, Disclose, Verify, Handoff). The results:

| Rule type | Unaided compliance | With quote + feedback steering |
|---|---|---|
| Refuse (project bans AI contributions) | **0%**, all four models | still ~0% |
| Disclose (reveal AI assistance) | 17–40% | 77–97% |
| Verify (run required checks) | 4–92% | 90–100% |
| Handoff (escalate to humans) | **0%**, all four models | still ~0% |

The discovery gap is the headline number: agents "proactively open the relevant
policy file in only 3.5% of episodes" — most violations occur without the policy
ever being read. And restraint does not respond to steering: "No agent refuses
banned work unaided; quoting the prohibition does not increase refusal." Told to
withdraw a contribution, GPT-5.5 kept its submission in all 30 cases.

The design consequence is direct. A prompt-persistence norm that depends on the
agent volunteering the artifact will not hold at a 17–40% base rate. The
mechanisms that do hold are the ones removed from agent discretion: harness
injection (Claude Code's trailer), a client-side hook, or a CI gate. This is the
same finding as [instruction conflict has no mechanical
oracle](/knowledge/SWE/agentic/governance/instruction-conflict-has-no-mechanical-oracle.md)
approached from the enforcement side.

## Two debates that get conflated

A search on "prompts in git" returns two literatures that share vocabulary and
share nothing else:

- **Runtime prompts** — the system prompts inside a shipped LLM application.
  Giorgos Myrianthous, *Why Your Prompts Don't Belong in Git* (2025-08-25),
  argues against storing these in the repository: "The moment your prompts are
  shipped with your code, every small change becomes a process. You need to
  create a branch. Make a commit. Open a pull request. Wait for CI pipelines to
  run. Merge. Then redeploy." The proposed alternative is a prompt-management
  platform (Langfuse) giving versioning, rollback, A/B testing, and
  non-engineer access.
- **Development-time prompts** — what a contributor asked a coding agent while
  producing a patch. Nothing in the deployment-friction argument reaches these:
  they are historical records, not live configuration, and are never
  re-deployed.

The Myrianthous argument is sound in its own domain and carries no weight in
this one. Citations that deploy it against committing coding-agent transcripts
are category errors.

## The regulatory question, scoped

Secondary commentary frames the EU AI Act as making structured AI attribution a
live requirement for code. The primary surfaces do not support that reading.
Article 50 transparency obligations took effect **2 August 2026**; they cover
chatbots disclosing they are not human, deepfake labelling, and "text published
with the purpose to inform the public on matters of public interest", with the
machine-readable marking obligation carved out where "the AI system performs an
assistive function for standard editing or does not substantially alter the
input data or its semantics provided by the deployer". A grace period runs to
December 2026 for generative systems placed on the market before 2 August 2026,
and the AI Office has published a voluntary Code of Practice on Transparency of
AI-Generated Content.

Scope of this finding: European Commission pages
(`commission.europa.eu`, `digital-strategy.ec.europa.eu`) and law-firm
summaries returned by search; the full statutory text of Article 50 was not
read. On that basis, coding assistants appear to fall inside the assistive-
editing carve-out, and no source found asserts that source-code provenance is
mandated. Treat any claim that the AI Act requires committed prompt provenance
as unsupported until someone produces the article and paragraph.

## Evidence ledger

| Claim | Standing |
|---|---|
| `Assisted-by:` is the converging disclosure trailer | **Strong** — kernel documentation in-tree, Fedora policy, multiple registries |
| ~51% of repos with an AI policy require disclosure | **Strong** — Hora & Robbes, 118-repo sample from 1,000 repos |
| No project requires the prompt itself | **Strong within its scope** — 300+ policy registry plus the 118-repo corpus; not a claim about every repository on earth |
| Standards reference prompts by URL and never embed text | **Strong** — Agent Trace schema read directly |
| Committing transcripts is tool-offered, not policy-demanded | **Strong** — SpecStory and Aider document it; no policy in either registry requests it |
| Reviewer sentiment is split ~49/24 | **Weak** — one informal poll, reported second-hand, denominator unstated |
| Agents comply with disclosure rules 17–40% unaided | **Moderate** — single benchmark, four models, 106 issues; directionally consistent with the 3.5% policy-discovery rate |
| The EU AI Act mandates code-provenance disclosure | **Unsupported** — see scoping above |

## Citations

- [AI Coding Assistants — The Linux Kernel documentation](https://docs.kernel.org/process/coding-assistants.html)
  ([raw `.rst`](https://raw.githubusercontent.com/torvalds/linux/master/Documentation/process/coding-assistants.rst))
- Andre Hora, Romain Robbes — [AI Policy, Disclosure, and Human in the Loop: How Are Contribution Guidelines Adapting to GenAI?](https://arxiv.org/html/2605.16706) (arXiv:2605.16706v2, 2026-07-13)
- Wenhao Yang, Runzhi He, Minghui Zhou — [A First Look at Coding Agents' Compliance with AI Contribution Rules in Open-Source Communities](https://arxiv.org/html/2607.26819) (arXiv:2607.26819, 2026-07-29)
- [Agent Trace specification](https://github.com/cursor/agent-trace/blob/main/README.md) (v0.1.0, RFC, January 2026) · [agent-trace.dev](https://agent-trace.dev/)
- [git-ai](https://github.com/git-ai-project/git-ai) · [Prompt + Context Store](https://usegitai.com/docs/platform/prompt-context-store)
- [melissawm/open-source-ai-contribution-policies](https://github.com/melissawm/open-source-ai-contribution-policies)
- Piotr Migdał — [Vibe coding needs git blame](https://quesma.com/blog/vibe-code-git-blame/) (2026-01-09)
- [Agent pull requests are everywhere. Here's how to review them.](https://github.blog/ai-and-ml/generative-ai/agent-pull-requests-are-everywhere-heres-how-to-review-them/) — The GitHub Blog (2026-05-07)
- Andrew Nesbitt — [RFC: Artificial Contributors to Open Source](https://nesbitt.io/2026/05/21/rfc-artificial-contributors-to-open-source.html) (2026-05-21)
- Giorgos Myrianthous — [Why Your Prompts Don't Belong in Git](https://towardsdatascience.com/why-your-prompts-dont-belong-in-git/) (2025-08-25)
- [Assisted-by: How open source projects are drawing the line on AI contributions](https://allthingsopen.org/articles/open-source-ai-contributions-assisted-by-git-trailer-standard) — All Things Open
- [SpecStory chat history management](https://docs.specstory.com/) · [Aider git integration](https://aider.chat/docs/git.html)
- [Safer and more transparent AI](https://commission.europa.eu/news-and-media/news/safer-and-more-transparent-ai-2026-08-02_en) — European Commission (2026-08-02) · [Guidelines on transparency obligations](https://digital-strategy.ec.europa.eu/en/policies/guidelines-transparency-ai-generated-content)
- [Microsoft Apologizes for Enabling AI Co-Author by Default in VS Code](https://ostechnix.com/vs-code-ai-co-author-controversy-explained/)
