# security

Software security — vulnerability analysis, secure coding, and how LLM
assistance behaves at the boundary between defensive and misuse-adjacent work.

## References

- [Beyond Refusal — safety state and defender-side utility in LLM vulnerability analysis](/knowledge/SWE/security/beyond-refusal-safety-state-in-vulnerability-analysis.md) — a same-lineage aligned-vs-abliterated study across detection, localization, and executable repair, showing alignment's defender-side cost appears in answer quality and actionability rather than refusal rate.
- [LLMs in malware analysis — scripts have a feedback loop, reports don't](/knowledge/SWE/security/llms-in-malware-analysis-scripts-over-reports.md) — a G DATA researcher's field report on MCP-connected LLM reverse engineering: large speedups on generated scripts and bulk triage, untrustworthy reports and verdicts that five verification passes failed to fix.
- [Indirect prompt injection in document pipelines](/knowledge/SWE/security/indirect-prompt-injection-in-document-pipelines.md) — instructions embedded in documents an agent processes execute with the operator's privileges; orthogonal to where the model runs, and defended by bounding the action surface rather than filtering input. `em:7da513` _(concept)_
- [Confidential computing for LLM inference](/knowledge/SWE/security/confidential-computing-for-llm-inference.md) — composite CPU+GPU TEEs keep weights and prompts encrypted in memory and in transit at ~2–5% overhead, replacing a provider's contractual promise with a verifiable attestation. `em:f96824` _(concept)_
- [Operating an air-gapped workstation](/knowledge/SWE/security/air-gapped-operations.md) — the three flows an isolated machine still needs, and why a no-network-interface host usually beats a true air gap for one operator. `em:cc0c87` _(concept)_
