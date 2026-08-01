# workflow-decomposition

When an LLM-powered workflow should stay inside one probabilistic model call
versus decompose into deterministic parsers, rules, classifiers, and
classical ML once the shape of the task is understood — the switch-point
heuristics, cost-governance framing, and the boundary-finding work that turns
out to be the hard part.

## References

- [When an LLM workflow should have been regex, deterministic parsers, and ML models (r/LLMDevs)](/knowledge/SWE/agentic/workflow-decomposition/when-llm-workflows-should-be-deterministic.md) — switch-point heuristics from a practitioner discussion: write down the failure, stop writing evals for what a parser would guarantee, attribute wrong output to a single stage. `em:5a89af` _(reference)_
- [The AI bill is becoming a management discipline (Seldon)](/knowledge/SWE/agentic/workflow-decomposition/ai-bill-as-a-management-discipline.md) — the same decomposition argument from a cost-governance angle: AI spend needs FinOps-style discipline, and the deeper opportunity is compiling recurring LLM tasks into deterministic pipelines, not just routing to cheaper models. `em:7d4960` _(reference)_
