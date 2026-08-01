# Skill optimization

Treating an agent's natural-language instruction file as an artifact to be
*optimized* against a score rather than authored by judgment — text-space
optimizers, edit budgets, and the held-out gates that keep self-revision from
drifting. The model stays frozen throughout; only the text is trained. (Distinct
from [context-engineering](/knowledge/SWE/agentic/context-engineering/index.md),
which curates what enters a single context window, and from
[agent-memory](/knowledge/SWE/agentic/agent-memory/index.md), which covers what
survives between sessions.)

## References

- [SkillOpt — training the agent skill file as the trainable parameter of a frozen model (Microsoft)](/knowledge/SWE/agentic/skill-optimization/skillopt.md) — a separate optimizer model turns scored rollouts into bounded add/delete/replace edits on one markdown file, accepted only on a strict held-out improvement; best or tied on all 52 evaluated (model, benchmark, harness) cells, +23.5 points average on GPT-5.5 in direct chat. `em:42648b` _(reference)_
