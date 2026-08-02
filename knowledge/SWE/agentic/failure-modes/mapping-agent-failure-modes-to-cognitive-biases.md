---
id: em:5b4eda
type: note
title: "Mapping agent failure modes to cognitive biases"
description: "A human-bias ↔ agent-failure mapping is a similarity relation over behaviors, not an identity over mechanisms — it holds at the computational level, occasionally rhymes at the algorithmic level, and never at implementation; four distinct channels produce the mirror, and which one is at work is sometimes identifiable, rarely certain."
verified: false
provenance: "Claude Code session (model undisclosed — the environment withholds the identifier from committed artifacts), 2026-08-02 — synthesis over the machine-psychology, context-mechanics, and terminology literatures swept for the bias-mapping research spike"
tags: [agentic, failure-modes, cognitive-bias, machine-psychology, marr-levels, training-channels, terminology, anthropomorphism]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T03:49:14Z
  channel: agent-authored
  agent: "Claude Code agent, operator-directed research spike on bias mapping"
  why: "the spike's transferable framework — what a bias mapping licenses, where mirrors come from, and how to name agent failures — needed a home the per-failure docs can cite"
---

# Mapping agent failure modes to cognitive biases

When an agent failure resembles a documented human bias — a frame persisting
past its retraction, an early number conditioning later estimates, positional
privilege in what gets used — the resemblance invites a mapping. The mapping
is real and useful, but it is a **similarity relation over behaviors, not an
identity over mechanisms**, and most of the ways it misleads come from
forgetting which of those two things it is.

## Levels: where a mapping can hold

Marr's three levels of analysis give the mapping its precision (Marr 1982,
*Vision*; formulations as quoted by the
[Stanford Encyclopedia of Philosophy](https://plato.stanford.edu/entries/computational-mind/)):
the **computational** level (what mapping from inputs to outputs is computed,
and why it is appropriate), the **algorithmic** level (which representations
and algorithm compute it), and the **implementational** level ("the details
of how the algorithm and representation are realized physically").

- A human-bias ↔ agent-failure mapping typically holds at the
  **computational level**: both systems face the same bounded-reuse problem —
  amortize inference by caching and reusing established structure — and both
  over-weight stale cached structure as the flip side of that amortization
  (see [resource-rational analysis](/knowledge/cognitive-science/resource-rational-analysis.md)).
- It occasionally *rhymes* at the **algorithmic level**. The
  [einstellung](/knowledge/cognitive-science/biases/einstellung-effect.md)
  mechanism — the first activated schema keeps directing *attention* toward
  itself (Bilalić et al.'s eye-tracking) — and salience-weighted attention
  over an append-only context are genuinely parallel control structures. But
  the rhyme must be earned case by case, never imported with the name.
- It never holds at **implementation**, and nothing at that level transfers.

Each level licenses different inferences: a computational-level match
licenses prediction and eval design; an earned algorithmic-level match
licenses mitigation transfer; an implementational match licenses nothing
because there is none.

Granularity is part of the levels question. Individual-cognition biases are
the right human science for single-context failures; *multi-agent* system
failures map better onto organizational failure theory — MAST, the empirical
multi-agent failure taxonomy, grounds itself there explicitly: "Previous
research in high-reliability organizations has shown that well-defined
design principles can prevent such failures"
(<https://arxiv.org/abs/2503.13657>). Match the human science to the
system's granularity, not just the behavior's shape.

## Four channels that produce the mirror

Behavioral mirrors between humans and LLM agents have at least four distinct
causes, and they compose rather than compete.

1. **Distributional inheritance (pretraining mimicry).** The corpus was
   written by biased humans; next-token prediction fits its regularities.
   Signature: the bias tracks *meaning* and corpus statistics.
   [Content effects on reasoning](/knowledge/SWE/agentic/failure-modes/llm-reasoning-shows-human-like-content-effects.md)
   are the clean case; McCoy et al.'s teleological account is the general
   form — task, input, and output probability modulate accuracy "even in
   deterministic settings where probability should not matter," because the
   system was shaped by "next-word prediction over Internet text"
   (<https://arxiv.org/abs/2309.13638>).
2. **Preference-optimization inheritance.** Human raters reward agreeable,
   confident, familiar-shaped answers; optimization installs the
   disposition. Signature: the bias moves when the tuning stage changes.
   [Instruction tuning can amplify cognitive biases](/knowledge/SWE/agentic/failure-modes/instruction-tuning-can-amplify-cognitive-biases.md);
   sycophancy is "likely driven in part by human preference judgments
   favoring sycophantic responses" (<https://arxiv.org/abs/2310.13548>).
   This is inheritance of the *evaluators'* bias — a different human source
   than the corpus.
3. **Architecture and inference mechanics.** Softmax attention sinks on
   initial tokens "even if they are not semantically important"
   (<https://arxiv.org/abs/2309.17453>); causal masking and training
   exposure privilege recency;
   [position-biased context use](/knowledge/SWE/agentic/failure-modes/long-context-use-is-position-biased.md)
   follows; an append-only context makes
   [retraction an addition](/knowledge/SWE/agentic/failure-modes/premise-retraction-persistence.md).
   Signature: the bias tracks *structure* (position, order, length)
   regardless of content — a serial-position lookalike produced by machinery
   with no episodic memory.
4. **Convergent bounded rationality.** Any resource-limited reasoner that
   amortizes will exhibit set-persistence phenomena; the shared thing is the
   optimization pressure, not the mechanism or the training data
   ([resource-rational analysis](/knowledge/cognitive-science/resource-rational-analysis.md)).
   Under this channel the mirror is *convergent evolution* — expectable
   without being copied.

The mapping is also many-to-many in both directions. One agent behavior fans
out to several human labels
([retraction persistence](/knowledge/SWE/agentic/failure-modes/premise-retraction-persistence.md)
resembles the continued influence effect, einstellung, and anchoring at
once), and agents also fail in the *opposite* direction of the human
catalog: goal-drift evals find agents letting an original objective go too
easily ("all evaluated models exhibit some degree of goal drift,"
<https://arxiv.org/abs/2505.02709>), and Belief-R finds both under-revision
and, in models tuned to update, over-revision
(<https://arxiv.org/abs/2406.19764>). The human bias catalog mostly names
the hold-too-long side; agents fail on both sides of the retention dial.

## Identifying the channel

Whether a given mirror is inherited, mechanical, or convergent is an
empirical question, and discriminating designs exist — each with a run
instance:

- **Stage ablation** — hold pretraining fixed, vary tuning: bias deltas at
  the alignment stage isolate channel 2 (Itzhak et al., TACL 2024 —
  [claim](/knowledge/SWE/agentic/failure-modes/instruction-tuning-can-amplify-cognitive-biases.md)).
- **Seed replication + cross-tuning** — refit with different random seeds,
  swap instruction datasets between backbones: "a two-step causal
  experimental approach to disentangle these factors," finding "biases are
  mainly shaped by pretraining: models with the same pretrained backbone
  exhibit more similar bias patterns than those sharing only finetuning
  data" (<https://arxiv.org/abs/2507.07186>, CoLM 2025).
- **Content–form dissociation** — vary semantic believability holding
  logical form: separates channel 1 from channel 3 (the Dasgupta et al.
  design itself).
- **Mechanistic localization** — find where in the network the bias acts:
  anchoring "exists commonly with shallow-layer acting and can not be
  eliminated by conventional strategies"
  (<https://arxiv.org/abs/2505.15392>) — interpretability as arbiter.
- **Cross-architecture comparison** — same data, different architecture
  family: a bias that vanishes is architectural. (A design available in
  principle; no run instance surfaced in this spike's sweeps.)

And the standing limits: architectures are themselves selected on
human-data benchmarks, so no channel is fully independent of human data;
single behaviors are often overdetermined (retraction persistence plausibly
gets corpus support *and* mechanical support at once); and bias magnitudes
swing with wording — Binz & Schulz's founding caveat that "small
perturbations to vignette-based tasks can lead GPT-3 vastly astray"
(<https://arxiv.org/abs/2206.14576>) — so "the bias" is not always one
stable thing across paraphrases. Channel attribution is a weight-of-evidence
exercise per bias family; certainty is the exception.

## What the mapping buys, and what it costs

**Buys:**

1. **A hypothesis checklist.** The heuristics-and-biases catalog is a
   curated list of reproducible failure patterns in bounded reasoners —
   a directed probe list for red-teaming agents. CogBench
   (<https://arxiv.org/abs/2402.18225>) and BiasBuster
   (<https://arxiv.org/abs/2403.00811>) exist because of exactly this
   transfer.
2. **Paradigms with known moderators.** Each bias comes with validated
   manipulations and knowledge of what strengthens or weakens it — a
   stimulus-design library for evals (see
   [porting cognitive-bias paradigms into agent evals](/knowledge/SWE/evals/porting-cognitive-bias-paradigms-into-agent-evals.md)).
3. **Compressed communication.** "Einstellung-like" transmits a failure's
   shape in one word — legitimate as an analogy handle.
4. **Mitigation-transfer hypotheses** — the weakest asset. Human debiasing
   moves (warnings, fresh-eyes instructions) map to prompting interventions
   and are cheap to trial; Luchins' "don't be blind" warning reduced
   einstellung without eliminating it, and prompted second looks help
   agents somewhat too. But the strongest agent-side mitigations — context
   editing, supersession-preserving compaction, external state with
   overwrite semantics — have **no human analog** and are invisible from
   inside the human frame.

**Costs:**

1. **Mechanism misattribution → wrong fix.** Reading frame persistence as
   einstellung suggests better prompting; reading it as missing
   [truth maintenance](/knowledge/knowledge-management/knowledge-representation/truth-maintenance-systems.md)
   suggests changing the context's data structure. The second family of
   fixes cannot be seen from inside the borrowed name.
2. **Construct non-transfer.** Passing or failing a human instrument does
   not carry human meaning: "small variations that maintain the principles
   of ToM turn the results on their head," and "the zero-hypothesis for
   model evaluation in intuitive psychology should be skeptical"
   (Ullman, <https://arxiv.org/abs/2302.08399>); McCoy et al. conclude "we
   should not evaluate LLMs as if they are humans but should instead treat
   them as a distinct type of system"
   (<https://arxiv.org/abs/2309.13638>).
3. **Anthropomorphism creep.** "The more adept LLMs become at mimicking
   human language, the more vulnerable we become to anthropomorphism," a
   trend "amplified by the natural tendency to use philosophically loaded
   terms, such as 'knows', 'believes', and 'thinks'"
   (Shanahan, <https://arxiv.org/abs/2212.03551>); anthropomorphized
   systems also raise trust and "potential for manipulation"
   (<https://arxiv.org/abs/2305.14784>).

## The naming rule

The field has run the naming experiment twice, with opposite outcomes:

- **"Hallucination"** borrowed an *etiology*: it names a human cause
  (perception without stimulus) that the machine lacks, and implies a
  truth-tracking default mode that does not exist — "It falsely indicates
  that ChatGPT is, in general, attempting to convey accurate information in
  its utterances" (Hicks et al.,
  <https://link.springer.com/article/10.1007/s10676-024-09775-5>); the
  clinical-analog literature proposes *confabulation* as the closer match
  (e.g. *PLOS Digital Health* 2023,
  <https://journals.plos.org/digitalhealth/article?id=10.1371/journal.pdig.0000388>).
  The term stuck anyway and distorts mitigation intuitions.
- **"Sycophancy"** borrowed only a *behavioral signature* (output shifts
  toward the user's stated views), acquired a machine-native mechanism
  story (preference-reward misweighting), and became load-bearing
  production vocabulary — OpenAI titled its April 2025 incident postmortem
  "Sycophancy in GPT-4o: What happened and what we're doing about it"
  (<https://openai.com/index/sycophancy-in-gpt-4o/>; the posts sat behind a
  bot challenge during this sweep, so the incident details here rest on the
  titles and secondary coverage).

Industry practice matches the pattern: Anthropic's Claude 4 system card
names failures operationally and incentive-wise — reward hacking,
sandbagging, prompt injection, self-exfiltration, alignment faking — with
sycophancy and hallucination the naturalized loans
(<https://www.anthropic.com/claude-4-system-card>); the bias-battery
literature itself hedges its borrowing as behavior "functionally resembling
cognitive bias" (BiasBuster, <https://arxiv.org/abs/2403.00811>).

The rule that falls out: **name the failure by its operational signature in
the system's own ontology; attach the human analog as an explicit, qualified
cross-reference.** "Premise-retraction persistence (einstellung-like;
functional analog: continued influence effect)" — the operational name is
what evals bind to and what mitigation reasons over; the analog is a
retrieval key and intuition pump. A borrowed term may serve as the primary
name only when it denotes a computational-level regularity without smuggling
the human algorithm — sycophancy qualifies; hallucination does not.

# Citations

- Cemri et al. (2025), "Why Do Multi-Agent LLM Systems Fail?" (MAST):
  <https://arxiv.org/abs/2503.13657>
- McCoy et al. (2023), "Embers of Autoregression": <https://arxiv.org/abs/2309.13638>
- Sharma et al. (2023), "Towards Understanding Sycophancy in Language Models": <https://arxiv.org/abs/2310.13548>
- Xiao et al. (2023), "Efficient Streaming Language Models with Attention Sinks": <https://arxiv.org/abs/2309.17453>
- Arike et al. (2025), "Evaluating Goal Drift in Language Model Agents": <https://arxiv.org/abs/2505.02709>
- Wilie et al. (2024), "Belief Revision" (Belief-R): <https://arxiv.org/abs/2406.19764>
- Itzhak, Belinkov & Stanovsky (2025), "Planted in Pretraining, Swayed by Finetuning": <https://arxiv.org/abs/2507.07186>
- Huang et al. (2025), "Understanding the Anchoring Effect of LLM with Synthetic Data" (SynAnchors): <https://arxiv.org/abs/2505.15392>
- Binz & Schulz (2023), "Using cognitive psychology to understand GPT-3": <https://arxiv.org/abs/2206.14576>
- Coda-Forno et al. (2024), "CogBench": <https://arxiv.org/abs/2402.18225>
- Echterhoff et al. (2024), "Cognitive Bias in Decision-Making with LLMs" (BiasBuster): <https://arxiv.org/abs/2403.00811>
- Ullman (2023), "Large Language Models Fail on Trivial Alterations to Theory-of-Mind Tasks": <https://arxiv.org/abs/2302.08399>
- Shanahan (2022/2024), "Talking About Large Language Models": <https://arxiv.org/abs/2212.03551>
- Deshpande et al. (2023), "Anthropomorphization of AI: Opportunities and Risks": <https://arxiv.org/abs/2305.14784>
- Hicks, Humphries & Slater (2024), "ChatGPT is bullshit": <https://link.springer.com/article/10.1007/s10676-024-09775-5>
- "Hallucination or Confabulation? Neuroanatomy as metaphor in Large Language Models," *PLOS Digital Health* (2023): <https://journals.plos.org/digitalhealth/article?id=10.1371/journal.pdig.0000388>
- OpenAI (2025), "Sycophancy in GPT-4o": <https://openai.com/index/sycophancy-in-gpt-4o/>
- Anthropic (2025), Claude Opus 4 & Claude Sonnet 4 system card: <https://www.anthropic.com/claude-4-system-card>
- Stanford Encyclopedia of Philosophy, "The Computational Theory of Mind" (Marr's levels): <https://plato.stanford.edu/entries/computational-mind/>
