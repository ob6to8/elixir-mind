# evals

Evaluating LLM and agent output — benchmarks, metrics, and evaluation
methodology.

## Methodologies

- [Reading a self-published benchmark](/knowledge/SWE/evals/reading-a-self-published-benchmark.md) — six steps for deciding what a project's own benchmark establishes: find the denominator behind each percentage, match every quoted number to the suite it came from, recompute against a baseline someone would actually ship, and read the limitations section before the promotional post. `em:1f1256` _(methodology)_
- [Debugging an agent harness on weak models](/knowledge/SWE/evals/debugging-agent-harnesses-on-weak-models.md) — run the eval suite against the cheapest models on the roster, because a frontier model silently works around harness defects a weak model fails on immediately; triage each failure into contract bug, model ceiling, or provider quirk. `em:7309de` _(methodology)_
- [Split retrieval and generation evaluation for RAG, and calibrate the LLM judge](/knowledge/SWE/evals/split-retrieval-and-generation-evaluation-for-rag.md) — score retrieval mechanically against a small gold set (hit rate, MRR), score generation by groundedness against the retrieved context rather than reference overlap, and calibrate any LLM-judge against a human-scored anchor set using a different model family. `em:9baaad` _(methodology)_
- [Porting cognitive-bias paradigms into agent evals](/knowledge/SWE/evals/porting-cognitive-bias-paradigms-into-agent-evals.md) — treat the human paradigm as a stimulus-design template, not a test to pass: define the failure operationally, regenerate novel isomorph families, embed at deployment shape, measure dose-response on both sides of the revision dial, and audit the judge's own biases. `em:d5dbe1` _(methodology)_

## References

- [Decompose-then-verify factuality evaluation (FActScore, SAFE)](/knowledge/SWE/evals/decompose-then-verify-factuality.md) — atomize long-form output into facts, verify each against a knowledge source, aggregate mechanically; validated at scale by FActScore (EMNLP 2023) and SAFE/LongFact (NeurIPS 2024).
- [r/LLMDevs — "evaluation is so much harder than actually building the model wrapper"](/knowledge/SWE/evals/rag-evaluation-is-harder-than-the-pipeline-reddit-thread.md) — verbatim capture of the discussion thread the methodology above distills. `em:1394b9` _(reference)_
