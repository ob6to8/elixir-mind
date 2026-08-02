---
type: analysis
title: "Research spike: do agentic failure modes map to human cognitive biases?"
description: "Answers the operator's six questions on the einstellung ↔ frame-persistence parallel: a bias mapping is a finding aid that holds at the behavioral level (probe checklists, eval templates, vocabulary) while the mechanism stays the fix locus; the mirror has four distinguishable production channels that discriminating experiments can sometimes separate but rarely settle; mechanism divergence matters exactly when acting (mitigation, assurance) and not when hunting; agentic failures should carry operational primary names with qualified human-analog cross-references; academia runs a machine-psychology replication-and-critique dialectic while industry coins operational terms and keeps two naturalized loans; and evals are where the mapping cashes out — as dose-response measurements of operationally defined failures, with the retraction-persistence probe the natural next instrument."
provenance: "Claude Code session (model undisclosed — the environment withholds the identifier from committed artifacts), 2026-08-02 — operator commissioned a research spike on mapping agentic failure modes to human cognitive biases"
tags: [meta, analysis, research-spike, cognitive-bias, failure-modes, einstellung, truth-maintenance, terminology, evals, machine-psychology]
timestamp: 2026-08-02T03:49:14Z
attribution:
  when: 2026-08-02T03:49:14Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed research spike session"
  why: "the operator posed six questions about the bias mapping; the reasoned answers and their recommendations needed to persist beyond the session"
---

# Research spike: do agentic failure modes map to human cognitive biases?

**Question.** The operator paired a cognitive-science finding — the
[einstellung effect](/knowledge/cognitive-science/biases/einstellung-effect.md),
a practiced solution approach persisting after its conditions changed — with
a field report from a sibling repository: a session frame kept steering
prose after its premise was explicitly retracted, because an append-only
context has no retraction operation, the missing faculty being classical
truth maintenance. Six questions follow: does such a resemblance aid
understanding and mitigation, and how? Is the mirroring inherited from
human-generated training data or produced by unrelated technical causes —
and can one tell? Does a mechanism mismatch beneath a behavioral match
matter? How should agentic biases be referred to? Where do industry and
academia stand? And how does this look through the lens of evals?

**Bottom line.** The mapping is a **finding aid, not an identity**: it holds
at the level of behavior and optimization pressure, where it yields probe
checklists, eval templates with known moderators, and compressed
vocabulary — and it stops at the level of mechanism, where the fixes live.
The mirror has four distinguishable production channels (corpus mimicry,
preference-tuning inheritance, architecture mechanics, convergent bounded
rationality); published discriminating experiments separate them in
favorable cases, with the current best general answer being "planted in
pretraining, swayed by finetuning," and certainty the exception. Name agent
failures operationally and cite the human analog as a qualified
cross-reference. The spike's durable artifacts are the
[mapping framework](/knowledge/SWE/agentic/failure-modes/mapping-agent-failure-modes-to-cognitive-biases.md),
the [failure-modes cluster](/knowledge/SWE/agentic/failure-modes/index.md)
with three verified claims as its evidence spine, the human-side
[cognitive-science domain](/knowledge/cognitive-science/index.md), and an
[eval-porting methodology](/knowledge/SWE/evals/porting-cognitive-bias-paradigms-into-agent-evals.md).

## 1. What a resemblance buys

A genuine behavioral parallel transfers four assets, in descending order of
reliability: a **hypothesis checklist** (the heuristics-and-biases catalog
as a directed probe list — CogBench and BiasBuster are this transfer,
industrialized); **paradigms with known moderators** (Luchins' set-forming
trials port directly to agent evals, and the human literature predicts
which knobs strengthen the effect — predictions cheap to test for
transfer); **compressed communication** ("einstellung-like" transmits the
shape in a word); and **mitigation-transfer hypotheses** (the weakest:
Luchins' "don't be blind" warning maps to fresh-look prompting, which
helps some, but the strongest agent-side mitigations have no human analog
and are invisible from inside the human frame). The costs are the mirror
image: mechanism misattribution steering fixes wrong, construct
non-transfer under perturbation, and anthropomorphism creep. All six are
developed with their evidence in the
[mapping framework](/knowledge/SWE/agentic/failure-modes/mapping-agent-failure-modes-to-cognitive-biases.md).

The einstellung case shows the aid concretely: the human mechanism —
attention captured by the first activated schema, *through sincere
intention to search* — predicts that an agent's frame persistence should
survive sincere instructions to reconsider, and that mitigation must change
what is attended (context surgery), not what is intended (prompted
diligence). The human finding pointed at the right structural variable
before any agent experiment ran. That is the mapping earning its keep.

## 2. Where the mirror comes from — and whether one can tell

Four channels produce human-shaped agent bias, and they compose:
**distributional inheritance** (the corpus is us — evidenced by
[content effects](/knowledge/SWE/agentic/failure-modes/llm-reasoning-shows-human-like-content-effects.md)),
**preference-optimization inheritance** (the raters are us — evidenced by
[tuning-stage amplification](/knowledge/SWE/agentic/failure-modes/instruction-tuning-can-amplify-cognitive-biases.md)
and sycophancy), **architecture and inference mechanics** (nothing human
about it — evidenced by
[position bias](/knowledge/SWE/agentic/failure-modes/long-context-use-is-position-biased.md)
and attention sinks), and **convergent bounded rationality** (the pressure
is shared, not the substrate —
[resource-rational analysis](/knowledge/cognitive-science/resource-rational-analysis.md)).

Can one tell for certain? The discriminating designs exist and have been
run: stage ablation, seed-replicated cross-tuning ("biases are mainly
shaped by pretraining: models with the same pretrained backbone exhibit
more similar bias patterns than those sharing only finetuning data,"
<https://arxiv.org/abs/2507.07186>), content–form dissociation, and
mechanistic localization (anchoring acting in shallow layers). So the
question is empirically tractable — but three limits keep "certain" rare:
the channels interact (architectures were themselves selected on human-data
benchmarks), single behaviors are overdetermined (retraction persistence
plausibly draws corpus support *and* mechanical support at once), and bias
magnitudes are prompt-sensitive enough that "the bias" is not always one
stable object. The honest posture is weight-of-evidence per bias family.
For the operator's motivating case, the mechanical account is the
better-supported one — the failure tracks context structure, and the
[benchmarks show](/knowledge/SWE/agentic/failure-modes/premise-retraction-persistence.md)
revision failing by coherence and position rather than by provenance — but
a corpus contribution cannot be excluded, and nothing about the mitigation
changes if both are true.

## 3. Same behavior, different mechanism — does it matter?

It matters exactly when you act on the mapping, and barely at all when you
merely hunt with it.

- **For prediction**, a behavioral match plus transferred moderators
  licenses short-range extrapolation; mechanism mismatch caps it (agent
  biases swing across prompts and model versions in ways human biases do
  not).
- **For mitigation**, mechanism is nearly everything. Read as einstellung,
  frame persistence invites prompting interventions; read as missing
  [truth maintenance](/knowledge/knowledge-management/knowledge-representation/truth-maintenance-systems.md),
  it invites structural ones — supersession-preserving compaction, living
  state outside the transcript, fresh-context handoff, dependency tracking
  around the model. The second family is where the leverage is, and the
  human name cannot see it. This repo is itself an instance: its
  present-tense living surfaces and compiled contract are retraction
  operations at the artifact layer — truth-maintenance discipline
  implemented in the harness, not the model.
- **For assurance**, mechanism sets the failure envelope — when the bias
  does *not* fire — and envelopes, not anecdotes, are what certification
  reasons over.
- **And the divergence is sometimes smaller than it looks.** The einstellung
  mechanism (first schema capturing attention) and salience-weighted
  attention over an append-only buffer are parallel control structures; the
  CIE's structural core — *a retraction is an addition that must out-compete
  the original trace* — is literally true of both substrates. Algorithmic-
  level rhymes like these are worth checking per case, because where they
  hold, human moderator knowledge transfers better than the null hypothesis
  predicts.

## 4. How to refer to agentic biases

**Operational primary name, qualified analog cross-reference.** The field
ran this experiment twice: "hallucination" borrowed a human etiology the
machine lacks and now distorts both public understanding and mitigation
intuitions; "sycophancy" borrowed only a behavioral signature, acquired a
machine-native mechanism story, and became load-bearing production
vocabulary. The discriminator is Marr-shaped: borrowings pitched at the
computational level (an input–output regularity plus a pressure) transfer
safely; borrowings that smuggle the human algorithmic story (perception,
memory, belief) mislead. Evidence and the vendor-vocabulary inventory are
in the
[mapping framework](/knowledge/SWE/agentic/failure-modes/mapping-agent-failure-modes-to-cognitive-biases.md)'s
naming section.

For this bundle the pattern is: file the failure under its operational name
([premise-retraction persistence](/knowledge/SWE/agentic/failure-modes/premise-retraction-persistence.md)),
and let the body cite
[einstellung](/knowledge/cognitive-science/biases/einstellung-effect.md) and
the [continued influence effect](/knowledge/cognitive-science/biases/continued-influence-effect.md)
as functional analogs — which is also what
[prefer-established-terminology](/meta/policy/prefer-established-terminology.md)
yields when applied at both levels: the psych term is the established
handle *for the analogy*, and the operational name is built from
established systems vocabulary (retraction, truth maintenance) rather than
fresh coinage. Elevating this from filed practice to a standing rule would
be a policy change and is left to ratification (recommendation 2 below).

## 5. Where the field stands

**Academia** has a named subfield — machine psychology — running a
replication-and-critique dialectic: batteries reproduce framing, belief
bias, decoy/certainty effects, anchoring, and sycophancy in models
(Binz & Schulz; Itzhak; Dasgupta; CogBench), while the critique wing
(Ullman's perturbation fragility, contamination worries, Embers'
"distinct type of system" conclusion) polices what a replication may be
taken to mean. Meanwhile the agent-failure taxonomies that engineers
actually use avoid individual-psych vocabulary: MAST grounds multi-agent
failure in *organizational* failure theory (high-reliability
organizations), TRAIL and AgentErrorTaxonomy classify by agent module
(memory, reflection, planning, action), and the belief-revision line
(Belief-R, knowledge-conflict studies, retraction studies) formalizes the
operator's exact question with no psych terms at all. **Industry** coins
operational and incentive terms (reward hacking, sandbagging, prompt
injection, alignment faking; context rot, context poisoning, attention
budget) and keeps exactly two naturalized psych loans — hallucination
(contested) and sycophancy (functional). The two vocabularies run mostly
parallel; the bridge literature is thin. Scope note: the industry-side
inventory rests on the pages fetched in this spike's sweeps — Anthropic's
Claude 4 system card and DeepMind's safety pages; OpenAI's posts were
unreachable (HTTP 403) and are represented by titles and secondary
coverage only.

## 6. Through the lens of evals

Evals are where the mapping pays or does not. What the psych tradition
contributes is a **design library** — manipulations, moderators, controls,
minimal pairs — and what it cannot contribute is the norm: canonical
stimuli are in-corpus (a famous vignette measures recall of the
literature), single-prompt effect sizes are noise under paraphrase, and a
chat-shaped battery does not certify behavior inside a 200k-token tool
loop, which is where agent biases actually bite. The procedure that
survives those objections — operational definition first, regenerated
perturbation families, deployment-shaped embedding, dose-response curves
measured on **both sides of the dial** (under- and over-revision), judge
bias audited — is filed as
[porting cognitive-bias paradigms into agent evals](/knowledge/SWE/evals/porting-cognitive-bias-paradigms-into-agent-evals.md).
Two structural points close the loop: an eval *is* the operational
definition of the failure, which makes the naming question low-stakes once
a good eval exists; and the sweep located no prominent benchmark jointly
targeting classic biases and long-context tool use — the deployment-shaped
bias eval is open ground, and the retraction-persistence probe (plant →
build → retract → measure leakage) is this bundle's natural first
instrument, in the style of the existing
[fetch-fidelity probe](/meta/evals/fetch-fidelity-probe.md).

## Recommendations

1. **Adopt the two-level citation habit now, informally:** operational
   primary names for agent failures, human analogs as qualified
   cross-references — the failure-modes cluster filed in this spike models
   the pattern.
2. **If the habit should bind future sessions, ratify it as policy** — a
   short naming rule under `meta/policy/` citing the mapping framework;
   until then it binds nothing.
3. **The natural next instrument is a retraction-persistence probe** under
   `meta/evals/`, per the eval methodology's dose-response design — measure
   this environment's own agents before trusting any imported number.
4. **When a new agent failure is observed, file the human analog only as a
   link, never as the filename** — the analog fan-out (einstellung / CIE /
   anchoring all matching one behavior) shows labels cannot be identities.
