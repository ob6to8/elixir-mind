---
type: analysis
title: "Research spike: was classic epistemic AI premature rather than wrong — and does the agent era make it applicable?"
description: Tests the operator's phases hypothesis — that TMS-lineage epistemic machinery lost to scaled learning for era-contingent reasons and becomes applicable again with LLM agents — against primary sources, finding it confirmed in a sharpened form; the machinery returns as bookkeeping substrate around a stochastic reasoner while the bitter lesson keeps governing the capability half.
provenance: "Claude Fable 5 — synthesis over four parallel research subagents plus direct verification of the load-bearing sources (Sutton 2019 read in full; BeliefBank and REFLEX spans re-fetched; Doyle and de Kleer via the in-bundle captures)"
tags: [meta, analysis, research-spike, epistemics, truth-maintenance, belief-revision, bitter-lesson, neurosymbolic, agent-memory, knowledge-representation]
timestamp: 2026-08-01
attribution:
  when: 2026-08-01T23:04:48+00:00
  channel: agent-authored
  agent: "Claude Code agent, operator-commissioned research spike (cloud session)"
  why: "operator asked whether the brain's progressive reverse-engineering of early-AI epistemic systems means that work was premature rather than wrong, now becoming applicable with agents"
---

# Research spike: was classic epistemic AI premature rather than wrong?

**Question.** The operator, observing that this brain keeps re-deriving
early-AI epistemic machinery (the
[TMS](/knowledge/knowledge-management/knowledge-representation/truth-maintenance-systems.md)
is "the closest classic-AI ancestor of the epistemic-substrate idea this brain
is exploring"), asked: "we know that these systems and approaches were not
successful compared to throwing compute at neural networks (bitter lesson).
But, could it be that AI development was to happen in phases, and this early
work was just premature, and now with the state of agents is becoming
applicable again?"

**Bottom line.** Confirmed, in a sharpened form: **the TMS lineage was wrong
as an oracle and premature as a substrate.** What lost to scaled learning —
and stays lost — is hand-built knowledge and reasoning procedure *inside the
agent* as the source of capability. What was premature is the bookkeeping
layer beside the reasoner: a domain-independent service (record
justifications, maintain consistency, retract with precision, keep
provenance) that was always defined relative to an external inference
producer, and that stalled because its feeding side — the thing proposing
inferences and authoring knowledge — was brittle and economically impossible
to staff. LLMs are that missing organ. They dissolve the knowledge-acquisition
bottleneck that starved the layer, and their stochasticity gives the layer a
job it never had before: the proposer now *confabulates*, so consistency,
justification, and audit stop being efficiency optimizations and become the
trust infrastructure. The revival is measurable in both research and practice,
running from explicit citation of the classic literature (BeliefBank cites de
Kleer) to independent re-derivation of the same anatomy without the name
(REFLEX) — and independent re-derivation is the stronger evidence, since it
means the problem itself forces the shape. The bitter lesson still governs the
other half: structure whose purpose is to make the model reason better keeps
being absorbed into models, so the durable claim is for the record/audit side
only. This is a stack, not a pendulum: the neural layer supplies judgment, the
symbolic layer supplies memory, consistency, and audit.

## Method and evidence basis

Four parallel research subagents each covered one quadrant — the classic
lineage and its stall, the bitter-lesson debate, the academic revival, the
practice-side revival — under a hard rule: a quotation could be reported only
from source text fetched in-session, with fetch failures reported rather than
papered over. This session then re-verified the most load-bearing spans
directly: Sutton 2019 was read in full (course-mirror PDF of the canonical
page), the BeliefBank and REFLEX quotes were re-fetched from the arXiv full
texts, and the Doyle/de Kleer foundations quote the operator-ratified
in-bundle captures
([Doyle 1979](/knowledge/knowledge-management/knowledge-representation/doyle-1979-a-truth-maintenance-system.md),
[de Kleer 1986](/knowledge/knowledge-management/knowledge-representation/de-kleer-1986-an-assumption-based-tms.md)).
Remaining quotes are subagent-fetched verbatim spans carrying their source
URLs; PDF extraction artifacts (line-join spacing) were mechanically restored
without wording changes.

## Finding 1 — the machinery was born as a subsystem: the reasoner proposes, the TMS records

The division of labor is not a modern reinterpretation; it is the founding
definition. Doyle's 1979 abstract: "The Truth Maintenance System (TMS) is a
problem solver subsystem for performing these functions by recording and
maintaining the reasons for program beliefs"
([captured](/knowledge/knowledge-management/knowledge-representation/doyle-1979-a-truth-maintenance-system.md)).
De Kleer 1986 describes the architecture outright: "These systems forced a
clean division within the problem solver between a component solely concerned
with the rules of the domain and a component solely concerned with recording
the current state of the search (i.e., the TMS)" — and: "The basic
architectural presupposition is that the overall reasoning system consists of
two components: A problem solver which draws inferences and a TMS which
records these inferences (called justifications)"
(<https://dekleer.org/Publications/An%20Assumption-Based%20TMS.pdf>, pp.
128–129). The 1993 textbook consolidation keeps the same split: "This is an
appropriate division of labor because the TMS is responsible for managing
beliefs" (Forbus & de Kleer, *Building Problem Solvers*,
<https://qrg.northwestern.edu/BPS/BPS-Searchable.pdf>).

Two properties matter for the hypothesis. First, the layer was explicitly
**domain-independent**: "reasoning programs which take care to record the
logical justifications for program beliefs can apply several powerful, but
simple, domain-independent algorithms" (Doyle, MIT TR-419, 1978, via the MIT
DSpace record) — nothing in the design conditions on *what kind of thing* the
proposer is. Second, de Kleer named the layer's character precisely: "The ATMS
can be viewed as an intelligent cache, or a very primitive learning scheme."
A cache serves whatever computes into it. Across the five primary documents
fetched for this spike, the machinery is consistently framed as bookkeeping
serving an external inference producer; no fetched span conditions the design
on the strength of that producer (a negative scoped to those documents).

## Finding 2 — what failed was the feeding side, and for capacity reasons

The stall has a named diagnosis from the founders themselves, and it locates
the failure outside the maintenance layer. Feigenbaum, 1977: "the acquisition
of domain knowledge was the bottleneck problem in the building of
applications-oriented intelligent agents"
(<https://www.ijcai.org/Proceedings/77-2/Papers/092.pdf>). Lenat &
Feigenbaum, 1987, on brittleness: expert systems "operate on a high plateau of
knowledge and competence until they reach the extremity of their knowledge;
then they fall off precipitously to levels of ultimate incompetence"
(<https://www.ijcai.org/Proceedings/87-2/Papers/122.pdf>). Kautz's 2022
retrospective joins the two to the winter: "The second unsolved challenge for
the expert system approach was named the 'knowledge acquisition bottleneck.'
Capturing all but the narrowest domains required a huge number of rules. Not
only was it difficult or impossible to recruit and train enough experts to
write enough rules, but once the knowledge bases became large they inevitably
became full of inconsistencies and errors." And: "Many commercial deployments
of expert systems were discontinued when they proved too costly to maintain"
("The Third AI Summer," AI Magazine 2022,
<https://henrykautz.com/papers/AI%20Magazine%20-%202022%20-%20Kautz%20-%20The%20third%20AI%20summer%20%20AAAI%20Robert%20S%20%20Engelmore%20Memorial%20Lecture.pdf>).

Kautz also states the phase structure the operator hypothesized, as his own
reading of the history: "Each AI Winter was caused by backlash against
unfulfilled promises - unfulfilled because the methods of the time ran into
technical roadblocks. Science continued on quietly during the winters, finding
ways around the roadblocks and devising complete approaches and algorithms."
And: "The winters can be viewed as times of contemplation and integration that
advance through the synthesis of new and old ideas."

The joining of the halves — sound domain-independent maintenance machinery,
starved by an infeasible feeding side — is this analysis's synthesis, not a
claim any single fetched source makes. But each half is primary-sourced, and
the bottleneck's shape (hand authorship of knowledge and justifications does
not scale; large hand-fed stores rot into inconsistency) is exactly the
half LLMs address, which is Finding 4.

## Finding 3 — the bitter lesson indicts the in-agent half, and its own text places knowledge artifacts in the outside world

Sutton's essay (read in full for this spike) is precise about its target: "1)
AI researchers have often tried to build knowledge into their agents, 2) this
always helps in the short term, and is personally satisfying to the
researcher, but 3) in the long run it plateaus and even inhibits further
progress, and 4) breakthrough progress eventually arrives by an opposing
approach based on scaling computation by search and learning"
(<http://www.incompleteideas.net/IncIdeas/BitterLesson.html>). The indicted
move is building knowledge and mechanism-imitation *into the agent* as a
capability strategy: "We have to learn the bitter lesson that building in how
we think we think does not work in the long run."

The essay's own ontology then does something useful for this question. On the
contents of minds: "All these are part of the arbitrary, intrinsically-complex,
outside world. They are not what should be built in"; and "We want AI agents
that can discover like we can, not which contain what we have discovered." A
knowledge bundle that an agent *operates on* — reads, audits, revises with
general methods — is on the **outside-world side** of Sutton's boundary: it is
not built into the agent, and the agent does not contain it. The essay
discusses capability domains throughout (chess, Go, speech, vision) and
nowhere discusses verification, audit, or trusting outputs — a negative scoped
to the full essay text, which this session holds. The lesson is a claim about
how capability is produced; it is silent about the record-keeping humans need
to check what a capable system asserts.

Brooks's contemporaneous objection names the general pattern for where
hand-built structure goes under scaling: "It is sleight of hand in moving the
human intellectual work to somewhere else"
(<https://rodneybrooks.com/a-better-lesson/>) — relocated, not eliminated.
The relocation targets observed since are the subject of Finding 6.

## Finding 4 — the LLM is the missing organ: it dissolves the bottleneck and creates the layer's new job

The two failure causes of Finding 2 are the two things LLMs change. On
authoring cost: the knowledge-engineering literature now says so in the
classic vocabulary — ontology learning had been investigated "as a possible
way to address the knowledge acquisition bottleneck," where the pre-LLM state
of the art "require[d] significant human expert labor," and LLM methods are
projected to "significantly reduce human expert time and effort" (Shimizu &
Hitzler 2024, arXiv 2411.09601); a 2025 survey names "Expert dependency and
rigidity" among the classic bottlenecks and states "The advent of Large
Language Models (LLMs) introduces a transformative paradigm for overcoming
these bottlenecks" (arXiv 2510.20345). On brittleness: the proposer beside the
maintenance layer is no longer a plateau-and-precipice rule base but a general,
gracefully-degrading reasoner.

The exchange is not one-sided. The new proposer is stochastic and
confabulates, so the classic layer's services change character: consistency
enforcement, justification recording, and precise retraction were *efficiency*
services to a sound-but-slow symbolic prover; to an unsound-but-cheap neural
proposer they are *soundness* services. Kambhampati's position paper states
the strong form: "auto-regressive LLMs cannot, by themselves, do planning or
self-verification," with soundness "inherited from the soundness of the
correctness (hard) critics" in a "Generate-Test-Critique loop" (LLM-Modulo,
arXiv 2402.01817). The strong form is contested — Finding 6's R1 evidence
shows self-checking behavior emerging from RL on outcome-checkable tasks —
but the architectural conclusion (an external sound layer is what converts
plausible generation into trustworthy assertion) is the same division of labor
as Finding 1 with the components' strengths inverted.

## Finding 5 — the revival is measurable, from explicit citation down to independent re-derivation

The evidence runs along a ladder of explicitness, and both ends support the
hypothesis differently.

**Explicit citation.** BeliefBank (EMNLP 2021) embeds a frozen LM in "a
broader system that also includes an evolving, symbolic memory of beliefs – a
BeliefBank – that records but then may modify the raw PTLM answers," with "a
reasoning component – a weighted MaxSAT solver – [that] revises beliefs that
significantly clash with others" — and grounds the design in the classic
literature by name: "Prior work in AI, including in formal logic (Genesereth
and Nilsson, 1987), belief maintenance (De Kleer, 1986; Dechter and Dechter,
1988), and uncertainty (Pearl, 1986), offers models for how beliefs can be
managed" (arXiv 2109.14723, spans re-verified this session). The de Kleer
reference is the same ATMS paper captured in this bundle as
[em:d82615](/knowledge/knowledge-management/knowledge-representation/de-kleer-1986-an-assumption-based-tms.md).

**Structural re-derivation without the name.** REFLEX (EMNLP 2023) builds "a
belief graph using a backward-chaining process to materialize relevant model
beliefs ... and their inferential relationships," then "identif[ies] and
minimize[s] contradictions in that graph using a formal constraint reasoner,"
with "the LLM itself remain[ing] frozen, with belief revision occurring in the
rational (belief graph) layer above it" (arXiv 2305.14250, spans re-verified
this session). That is the JTMS anatomy — belief nodes, justification
structure, contradiction-driven minimal repair — yet the phrase "truth
maintenance" appears nowhere in the paper's full text (searched over the
complete v2 extraction, title through appendices; it cites factor graphs and
MaxSAT instead). Between them sit Maieutic Prompting (tree of generated
explanations, weighted MAX-SAT truth assignment; arXiv 2205.11822) and
Entailer (materialized model beliefs supporting answers via entailment chains;
arXiv 2210.12217). The one recent paper with "truth maintenance" in an
LLM-context title — ∀uto∃∨∧L, ICLR 2025 (arXiv 2410.08437) — uses the phrase
for a different concept (semantic preservation across formal-language round
trips). The name survives at the edges while the anatomy is rebuilt in the
center: the re-invention is substantially independent, which is stronger
evidence than deliberate revival — the problem itself forces the shape.

**Stated as lineage.** CoALA derives language agents from the classic control
machinery explicitly: "we draw on the rich history of cognitive science and
symbolic artificial intelligence," with production systems presented as "an
analog of the problem that LLMs solve" and Soar-style cognitive architectures
imported as the design frame (arXiv 2309.02427). Kautz frames the era itself
as the synthesis: "A banner inscribed \"Neuro-Symbolic Reasoning\" could fly
over all of the metaphorical armies of AI."

**Frontier practice.** AlphaProof "couples a pre-trained language model with
the AlphaZero reinforcement learning algorithm," generating candidates that
are checked in Lean, where "proofs involving mathematical reasoning can be
formally verified for correctness" (DeepMind, 2024) — the generate/verify
division at the frontier of the scaling program itself.

**Production agent memory.** Zep/Graphiti ships belief revision as a product:
"The introduction of new edges can invalidate existing edges in the database.
The system employs an LLM to compare new edges against semantically related
existing edges to identify potential contradictions," invalidating (not
deleting) the losers with validity intervals (arXiv 2501.13956); its README
headlines "When information changes, old facts are invalidated — not deleted."
MemGPT revives the OS memory hierarchy ("drawing inspiration from hierarchical
memory systems in traditional operating systems," arXiv 2310.08560); A-MEM
adopts the Zettelkasten by name with "memory evolution" revising old notes
(arXiv 2502.12110); GraphRAG has the LLM "derive an entity knowledge graph
from the source documents" as the index for answering (arXiv 2404.16130);
HippoRAG orchestrates "LLMs, knowledge graphs, and the Personalized PageRank
algorithm" under a named memory theory (arXiv 2405.14831). A 2025 survey
independently files Zep and A-MEM together under knowledge graphs as "a
dynamic memory substrate" for agents (arXiv 2510.20345) — practitioners
already see these strands as one program.

**Demand side.** Lenat & Marcus's desiderata for trustworthy AI are the TMS
property list argued forward: "for each step the provenance of the knowledge
used can be documented and audited," and "To be trustworthy, an AI needs to be
able to assimilate new information and revise its earlier beliefs and earlier
answers" (arXiv 2308.04445). Anthropic productized evidence-linked assertion
as the Citations API: "Claude can now provide detailed references to the exact
sentences and passages it uses to generate responses, leading to more
verifiable, trustworthy outputs" (<https://claude.com/blog/introducing-citations-api>).

## Finding 6 — the counter-current: capability scaffolds keep being absorbed, and the absorption itself runs on verifiers

The bitter lesson is not finished operating, and the hypothesis only survives
with this half stated. DeepSeek-R1 is the cleanest recent instance: reasoning
behaviors "are not explicitly programmed but instead emerge as a result of the
model's interaction with the reinforcement learning environment," while the
team's hand-built guidance structures were abandoned — process reward models
because "once a model-based PRM is introduced, it inevitably leads to reward
hacking," and MCTS because token generation "presents an exponentially larger
search space" (arXiv 2501.12948). Anthropic's engineering guidance is a
weak-form bitter lesson for scaffolding: "the most successful implementations
use simple, composable patterns rather than complex frameworks." Langlais
reports the strong form from inside the labs: "all major progress in
autonomous systems will be through redesigning the models in the first place"
(<https://vintagedata.org/blog/posts/model-is-the-product>). And Silver &
Sutton extend the lesson from hand-built methods to hand-supplied data:
"Ultimately, experiential data will eclipse the scale and quality of human
generated data" ("Welcome to the Era of Experience," 2025).

But the same sources locate what the absorption consumes and does not
replace. R1's abandoned scaffolds were *reasoning* aids; the piece that stayed
hand-built is the rule-based outcome verifier steering the RL. Jason Wei
states this as a law: "Verifier's rule: The ease of training AI to solve a
task is proportional to how verifiable the task is," because "ability to
verify solutions is equivalent to ability to create an RL environment"
(<https://www.jasonwei.net/blog/asymmetry-of-verification-and-verifiers-law>).
Shunyu Yao draws the same boundary from the frontier: "The second half of AI —
starting now — will shift focus from solving problems to defining problems. In
this new era, evaluation becomes more important than training"
(<https://ysymyth.github.io/The-Second-Half/>). Verification-side structure is
not what the bitter lesson washes away; it is what the washing-away runs on.
One basis caveat, stated plainly: none of the fetched bitter-lesson-side
sources discusses truth maintenance or belief-revision overlays by name, so
"the record/audit side survives" is an inference from the evidenced scope of
these sources, not a claim any of them makes about the TMS lineage itself.

## Verdict

The phases hypothesis is **confirmed with a boundary**, and the boundary can
be stated in one line: **the TMS lineage's reasoner role was wrong; its
substrate role was premature.**

- *Wrong, and stays wrong:* hand-authored domain content and hand-designed
  reasoning procedure inside the agent as the source of capability. That is
  what the bitter lesson indicts, what the expert-system collapse falsified
  economically, and what R1-style training keeps re-falsifying at the
  scaffolding level.
- *Premature, and now applicable:* the domain-independent bookkeeping layer
  beside the reasoner — justification recording, consistency maintenance,
  precise retraction, provenance. It stalled because hand authorship could
  not feed it and the reasoner beside it was brittle; both constraints were
  era-contingent, and Kautz's roadblock reading of the winters says as much
  about the field generally. The LLM supplies cheap authorship and graceful
  proposing, and its confabulation converts the layer from an efficiency
  device into trust infrastructure. The complementarity is structural, not
  nostalgic: each side supplies exactly what the other lacks.
- *The shape of the return:* a stack, not a pendulum. In every verified
  revival instance the neural component proposes and the symbolic component
  records, checks, or retracts — none of the fetched systems returns symbolic
  inference to the oracle seat.

The operator's framing — "progressively reverse-engineering traditional/early
AI epistemic systems and applying them in practice" — matches how the field at
large is behaving, mostly without knowing it: BeliefBank cites the lineage;
REFLEX, Zep, and A-MEM rebuild it unnamed. Re-derivation under a different
name is the strongest available evidence that the machinery answers the
problem rather than the fashion.

## What this means for this brain

The spike validates the substrate this bundle already runs, and points at its
next mechanism.

- **Validated by the boundary.** The bundle's machinery sits on the surviving
  side of every line the evidence draws: `verified_by` evidence edges are
  justification structure; `mix brain.verify` is the mechanical consistency
  gate; write-once `attribution`/`provenance` is the audit record; the
  operator-facing orientation (record for human audit, never oracle) is
  exactly the function the capability-absorption current cannot touch. The
  [derived-not-authored boundary](/meta/analysis/belief-decomposition-derived-vs-authored.md)
  is independently confirmed by the failure evidence: Kautz's "once the
  knowledge bases became large they inevitably became full of inconsistencies
  and errors" is the authored-store failure this bundle already diagnosed in
  its own two prior iterations.
- **The lineage names the next mechanism: retraction propagation.** Doyle's
  dependency-directed backtracking computes the blast radius of a withdrawn
  premise. This bundle's verifier checks that `verified_by` targets *exist*,
  not that they still *support* — a source capture can change or be
  superseded without its dependent claims noticing. Staleness propagation
  along evidence edges is already the
  [epistemic-overlay plan](/meta/plans/epistemic-overlay.md)'s integrity line
  and the [glossary's blast-radius concept](/beliefs/glossary/blast-radius.md);
  the spike adds that this is not an embellishment of the substrate but the
  half of the TMS design the bundle has not yet built.
- **The warning attaches to the other half.** Any structure here whose purpose
  is to make the model reason better — hand-designed reasoning workflows,
  elaborate prompting scaffolds — should be treated as expiring: that is the
  half R1 absorbed and Langlais describes the labs absorbing. The durable
  investment is the record/verify/audit layer the operator reads.
- **Prior in-bundle judgments line up.** The
  [OWL analysis](/meta/analysis/owl-and-the-belief-layer.md) already
  concluded the fitting formal cores are "the filed nonmonotonic prior art
  (TMS/ATMS, Dung argumentation) with the LLM as local entailment oracle";
  this spike supplies the external evidence that the field is converging on
  the same division.

# Citations

Classic lineage (primary):

- Jon Doyle, "A Truth Maintenance System," *Artificial Intelligence* 12(3),
  1979 — [in-bundle capture](/knowledge/knowledge-management/knowledge-representation/doyle-1979-a-truth-maintenance-system.md);
  MIT AIM-521 record: <https://dspace.mit.edu/handle/1721.1/5733>
- Jon Doyle, *Truth Maintenance Systems for Problem Solving*, MIT TR-419,
  1978: <https://hdl.handle.net/1721.1/6926>
- Johan de Kleer, "An Assumption-based TMS," *Artificial Intelligence* 28(2),
  1986 — [in-bundle capture](/knowledge/knowledge-management/knowledge-representation/de-kleer-1986-an-assumption-based-tms.md);
  author's copy: <https://dekleer.org/Publications/An%20Assumption-Based%20TMS.pdf>
- Forbus & de Kleer, *Building Problem Solvers*, MIT Press 1993:
  <https://qrg.northwestern.edu/BPS/BPS-Searchable.pdf>

The stall (primary and retrospective):

- Feigenbaum, "The Art of Artificial Intelligence," IJCAI 1977:
  <https://www.ijcai.org/Proceedings/77-2/Papers/092.pdf>
- Lenat & Feigenbaum, "On the Thresholds of Knowledge," IJCAI 1987:
  <https://www.ijcai.org/Proceedings/87-2/Papers/122.pdf>
- Kautz, "The Third AI Summer," *AI Magazine* 43(1), 2022:
  <https://henrykautz.com/papers/AI%20Magazine%20-%202022%20-%20Kautz%20-%20The%20third%20AI%20summer%20%20AAAI%20Robert%20S%20%20Engelmore%20Memorial%20Lecture.pdf>

Bitter lesson and its debate:

- Sutton, "The Bitter Lesson," 2019:
  <http://www.incompleteideas.net/IncIdeas/BitterLesson.html>
- Brooks, "A Better Lesson," 2019: <https://rodneybrooks.com/a-better-lesson/>
- Silver & Sutton, "Welcome to the Era of Experience," 2025 (DeepMind chapter
  preprint)
- DeepSeek-AI, "DeepSeek-R1," 2025: <https://arxiv.org/abs/2501.12948>
- Anthropic, "Building Effective Agents," 2024:
  <https://www.anthropic.com/engineering/building-effective-agents>
- Langlais, "The Model is the Product," 2025:
  <https://vintagedata.org/blog/posts/model-is-the-product>
- Wei, "Asymmetry of verification and verifier's rule," 2025:
  <https://www.jasonwei.net/blog/asymmetry-of-verification-and-verifiers-law>
- Yao, "The Second Half," 2025: <https://ysymyth.github.io/The-Second-Half/>

Academic revival:

- Kassner et al., "BeliefBank," EMNLP 2021: <https://arxiv.org/abs/2109.14723>
- Jung et al., "Maieutic Prompting," EMNLP 2022:
  <https://arxiv.org/abs/2205.11822>
- Tafjord et al., "Entailer," EMNLP 2022: <https://arxiv.org/abs/2210.12217>
- Kassner et al., "Language Models with Rationality" (REFLEX), EMNLP 2023:
  <https://arxiv.org/abs/2305.14250>
- Kambhampati et al., "LLMs Can't Plan, But Can Help Planning in LLM-Modulo
  Frameworks," ICML 2024: <https://arxiv.org/abs/2402.01817>
- Sumers et al., "Cognitive Architectures for Language Agents" (CoALA), TMLR
  2024: <https://arxiv.org/abs/2309.02427>
- Karia et al., "∀uto∃∨∧L," ICLR 2025: <https://arxiv.org/abs/2410.08437>
- Lenat & Marcus, "Getting from Generative AI to Trustworthy AI," 2023:
  <https://arxiv.org/abs/2308.04445>
- Google DeepMind, "AI achieves silver-medal standard solving International
  Mathematical Olympiad problems," 2024:
  <https://deepmind.google/discover/blog/ai-solves-imo-problems-at-silver-medal-level/>

Practice revival:

- Rasmussen et al., "Zep: A Temporal Knowledge Graph Architecture for Agent
  Memory," 2025: <https://arxiv.org/abs/2501.13956>; Graphiti README:
  <https://github.com/getzep/graphiti>
- Packer et al., "MemGPT," 2023: <https://arxiv.org/abs/2310.08560>
- Park et al., "Generative Agents," 2023: <https://arxiv.org/abs/2304.03442>
- Xu et al., "A-MEM: Agentic Memory for LLM Agents," 2025:
  <https://arxiv.org/abs/2502.12110>
- Edge et al., "From Local to Global: A Graph RAG Approach," 2024:
  <https://arxiv.org/abs/2404.16130>
- Jimenez Gutierrez et al., "HippoRAG," 2024: <https://arxiv.org/abs/2405.14831>
- Shimizu & Hitzler, "Accelerating Knowledge Graph and Ontology Engineering
  with Large Language Models," 2024: <https://arxiv.org/abs/2411.09601>
- Bian, "LLM-Empowered Knowledge Graph Construction: A Survey," 2025:
  <https://arxiv.org/abs/2510.20345>
- Anthropic, "Introducing Citations on the Anthropic API," 2025:
  <https://claude.com/blog/introducing-citations-api>
