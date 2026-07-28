---
id: em:97f0c3
type: concept
title: trusted execution environment
description: A hardware-enforced memory region whose contents the host operating system, hypervisor, and physical operator cannot read, paired with a signed measurement of the code running inside it.
provenance: "Agent-distilled glossary definition"
verified: false
sense: common
tags: [glossary, security, confidential-computing, tee, attestation, hardware]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /create-pull-request"
  why: "term surfaced by the confidential-computing evaluation in the secure-financial-agent session"
---

# trusted execution environment

Abbreviated **TEE**. Implementations include Intel TDX, AMD SEV-SNP, and AWS Nitro Enclaves on the CPU side, and NVIDIA H100/H200 Confidential Computing mode on the GPU side; a workload spanning both composes them, since neither protects the other's memory.

The [attestation](/beliefs/glossary/attestation.md) half is what carries the security argument. Encryption alone yields an unfalsifiable promise — a client cannot tell an enclave from a claim of one — whereas a signed measurement lets the client verify exactly what code will handle its data *before* sending any. This is the property that converts "trust the provider's terms of service" into a checkable cryptographic statement, and it is why a TEE occupies a genuinely distinct tier between owning hardware and renting it.

*Seen in:* [confidential computing for LLM inference](/knowledge/SWE/security/confidential-computing-for-llm-inference.md)
