---
id: em:2357ce
type: reference
title: "Going Dark — how AI bug-hunting revives the backdoor debate (Matthew Green)"
description: AI-assisted vulnerability discovery and patching is closing off law enforcement's decade-long reliance on purchased exploits, which Green argues will restart political pressure for mandated encryption backdoors — weakening systems broadly to serve narrow surveillance demand.
resource: https://blog.cryptographyengineering.com/2026/08/14/everything-is-about-to-go-dark/
provenance: "Matthew Green, cryptographyengineering.com, published 2026-08-14; surfaced via Hacker News"
tags: [security, encryption, backdoors, going-dark, ai-vulnerability-research, law-enforcement]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# Going Dark — how AI bug-hunting revives the backdoor debate

Matthew Green's argument runs through three phases.

## History

Mobile encryption (iPhone storage encryption 2010, iMessage E2E 2011,
WhatsApp's rapid rise to encrypted-by-default) shut off the easy channel for
law-enforcement data access, prompting the FBI's 2014 "Going Dark" campaign
for legally mandated backdoors. That campaign effectively ended in 2016 when,
rather than forcing Apple to weaken iPhone encryption in the San Bernardino
case, a third party simply found a way to hack the locked phone. For the
following decade, agencies relied on a commercial market for targeted
exploits (GrayKey for local unlocking, NSO Group's Pegasus for remote
exploitation) instead of pursuing backdoors — the will for legislative
backdoors evaporated because supply from the exploit market was cheap enough.

## The present shift

AI-assisted vulnerability discovery (Green names Anthropic's "Mythos" model,
temporarily export-restricted by the US government, plus OpenAI and Chinese
open-weight labs demonstrating comparable capability) is simultaneously being
turned toward defense — AI-based vulnerability scanning built directly into
CI pipelines before code ships. Green's prediction: within roughly two
years, major well-maintained software will run out of practically
exploitable remotely-reachable bugs, because the same automation that finds
bugs for attackers lets defenders close them faster than they accumulate.

## The consequence

Once the purchased-exploit market dries up, the pressure for legally
mandated backdoors — dormant since 2016 — comes back, and this time with more
institutional urgency because there's no alternative supply. Green argues
the backdoors that get built will asymmetrically weaken the systems of
whichever country demands them, since backdoors installed to satisfy one
government's legal reach don't stay contained to that jurisdiction's
adversary model — a form of self-inflicted harm arriving exactly as
defenders were finally winning the underlying security fight. The piece
offers no solution, reading as a warning about a structural dynamic rather
than a policy proposal.

# Citations

- Matthew Green, "Going Dark, and the era of law enforcement hacking" (2026-08-14) — <https://blog.cryptographyengineering.com/2026/08/14/everything-is-about-to-go-dark/>

# See also

- [How far behind the frontier are open-weight models on cyber capability (UK AISI)](/knowledge/SWE/security/open-weight-cyber-capability-gap.md)
- [OpenAI's accidental cyberattack against Hugging Face](/knowledge/SWE/security/openai-cyberattack-huggingface.md)
