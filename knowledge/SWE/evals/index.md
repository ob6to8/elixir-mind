# evals

Evaluating LLM and agent output — benchmarks, metrics, and evaluation
methodology.

## Methodologies

- [Reading a self-published benchmark](/knowledge/SWE/evals/reading-a-self-published-benchmark.md) — six steps for deciding what a project's own benchmark establishes: find the denominator behind each percentage, match every quoted number to the suite it came from, recompute against a baseline someone would actually ship, and read the limitations section before the promotional post. `em:1f1256` _(methodology)_
- [Debugging an agent harness on weak models](/knowledge/SWE/evals/debugging-agent-harnesses-on-weak-models.md) — run the eval suite against the cheapest models on the roster, because a frontier model silently works around harness defects a weak model fails on immediately; triage each failure into contract bug, model ceiling, or provider quirk. `em:7309de` _(methodology)_

## References

- [Decompose-then-verify factuality evaluation (FActScore, SAFE)](/knowledge/SWE/evals/decompose-then-verify-factuality.md) — atomize long-form output into facts, verify each against a knowledge source, aggregate mechanically; validated at scale by FActScore (EMNLP 2023) and SAFE/LongFact (NeurIPS 2024).
