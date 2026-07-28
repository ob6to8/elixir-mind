---
id: em:9ab7c5
type: concept
title: trust-state inversion
description: An open-source component becoming unsafe to depend on not because its code changed but because the trust relationships around it collapsed — a governance failure invisible to code-scanning security tools.
provenance: "Agent-distilled glossary definition; term coined by Hans de Raad (OpenNovations) in the captured article"
verified: false
tags: [glossary, supply-chain-security, open-source-governance, trust]
sense: common
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: glossary
  agent: "Claude Code agent, /add-to-glossary via /create-pull-request"
  why: "term surfaced by the 2026-07-27 scar-tissue session's trust-state-inversion intake"
---

# trust-state inversion

Canonically captured in this bundle as
[trust-state inversion: when clean code doesn't mean a safe dependency](/knowledge/SWE/agentic/supply-chain-security/trust-state-inversion.md)
(`em:f3beb0`, the filed reference distilling de Raad's article) — this entry
is a pointer. The capture holds the 2026 GSD-framework case (maintainer
disappearance and rug-pull with a clean codebase throughout; the risk was
retained control of the npm publishing channel), the seven-dimension maturity
framework proposed for agentic-era open source, and the recommended
operational loops. The inversion is between the two things scanners assume
move together: the code's state (unchanged, clean) and the component's
trustworthiness (collapsed).

*Seen in:* [2026-07-27 scar-tissue session](/meta/threads/2026-07-27-scar-tissue-drift-doctrine-and-link-policy.md)

*See also:* [scar tissue](/beliefs/glossary/scar-tissue.md) (the session's other trust-decay mode — internal to the agent rather than the dependency graph)
