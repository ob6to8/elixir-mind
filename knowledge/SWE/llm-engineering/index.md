# LLM engineering

Techniques for making LLM inference and retrieval cheaper, faster, more
capable, or more reproducible — context pruning, attention/KV-cache
architecture, serving-stack numerics, and related serving concerns.

## References

- [Defeating Nondeterminism in LLM Inference (Thinking Machines Lab)](/knowledge/SWE/llm-engineering/defeating-nondeterminism-in-llm-inference.md) — temperature-0 inference varies not from GPU concurrency but from kernels lacking batch invariance, so a request's numerics depend on the server load it was batched with; batch-invariant kernels make 1,000 completions bitwise identical at ~1.6× latency. `em:ae82a8` _(reference)_

- [Chroma — open-source embedding/search database for AI retrieval](/knowledge/SWE/llm-engineering/chroma-vector-database.md) — serverless vector/full-text/regex/metadata search for RAG, tiering storage across memory/SSD/object storage; the retrieval-infrastructure companion to the brain's context-rot and RAG-pruning concepts. `em:ea15aa` _(reference)_
- [Pruning RAG context with a small LLM before generation (Kapa.ai)](/knowledge/SWE/llm-engineering/rag-context-pruning-with-a-small-llm.md) — a cheap LLM grades retrieved chunks and discards low scorers before the expensive generator sees them. `em:41be22` _(reference)_
- [A brief history of KV cache compression (Martin Alderson)](/knowledge/SWE/llm-engineering/kv-cache-compression-history.md) — MQA → GQA → sliding window → MLA → quantization; ~100x memory-per-token reduction since 2017. `em:266c5e` _(reference)_
- [VeriCache — turning lossy KV-cache compression into lossless inference](/knowledge/SWE/llm-engineering/vericache-lossless-kv-cache.md) — draft from the compressed cache, verify against the full cache → output identical to full-KV decoding at up to 4× throughput, over any token-dropping/quantization compressor. `em:1cac23` _(reference)_
- [Local inference serving stacks — vLLM, SGLang, llama.cpp, Ollama](/knowledge/SWE/llm-engineering/local-inference-serving-stacks.md) — the four engines divide on throughput, structured/agentic latency, and portability; a shared OpenAI-compatible endpoint makes the choice cheap to reverse. `em:f5914d` _(reference)_
- [Single-machine inference hardware, mid-2026](/knowledge/SWE/llm-engineering/local-inference-workstation-tiers.md) — the three workstation tiers, and the two axes that decide between them: capacity vs. bandwidth, and whether the CUDA-only serving engines are needed. `em:a01073` _(reference)_
- [TurboFieldfare — running Gemma 4 26B-A4B in ~2GB RAM on Apple Silicon](/knowledge/SWE/llm-engineering/turbofieldfare-gemma4-apple-silicon.md) — a purpose-built Swift/Metal runtime that streams MoE expert weights from SSD instead of RAM, running the 14.3GB checkpoint on 8GB Macs. `em:96a4d0` _(reference)_
