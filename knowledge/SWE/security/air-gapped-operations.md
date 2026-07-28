---
id: em:cc0c87
type: concept
title: "Operating an air-gapped workstation"
description: The three flows an isolated machine still needs — updates in, backups out, working data in — and why the pragmatic middle ground of a no-network-interface host usually beats a true air gap for a single operator.
verified: false
tags: [security, air-gap, isolation, backups, operations, data-diode]
timestamp: 2026-07-27
attribution:
  when: 2026-07-27T00:00:00Z
  channel: agent-authored
  agent: "Claude Code agent, secure-financial-agent architecture session"
  why: "the isolation-posture decision for a locally-hosted system needed the operational patterns, which hold independent of that system"
---

# Operating an air-gapped workstation

An air gap is easy to establish and hard to keep. The difficulty is not the
isolation — it is that an isolated machine still needs three flows, and each one
is a hole someone must cut deliberately rather than accidentally.

## The three flows

**Updates in.** No `apt update`, no package install, no model pull. The
established patterns are signed media with cryptographic chain-of-custody,
one-way data diodes, offline package mirrors refreshed from controlled sources,
and a **designated transfer workstation** through which all external ingestion
passes. Designating one is load-bearing: architectures lacking a defined
transfer host introduce inconsistency and security gaps, because ingestion then
happens ad hoc through whatever machine is nearest. Verify hashes **on the
isolated side**, so a compromised transfer host cannot substitute a file
undetected.

**Backups out.** The invariant is directional: when connectivity between the
isolated and non-isolated zones is required, it flows one way only — outward —
enforced by a data diode or strict unidirectional firewall rules. Encrypt at
rest with a key held only on the isolated side, and the backup *target* can then
be ordinary cloud storage, since the provider holds ciphertext. This is the
cheapest resolution of the hardest air-gap problem, and it is frequently missed
by designs that treat all external storage as forbidden. Rehearse restores;
untested backups are not backups.

**Working data in.** The routine flow and the risky one, since it is also the
injection vector for anything the machine will process.

## Scale is what breaks it

Sneakernet degrades with volume. Past roughly 50GB per quarterly bundle, optical
media becomes impractical and encrypted external SSDs are the working answer —
and model weights blow through that threshold on their own. Mature deployments
add secure transfer gateways, multi-person authorization, automated validation,
and periodic restore rehearsals, all of which are proportionate for an
organization and disproportionate for one person.

## The pragmatic middle, and why it usually wins

For a single operator, the binding constraint is **operational burden, not
attack surface** — a workflow that demands a transfer workstation and quarterly
signed bundles gets abandoned, and an abandoned control protects nothing. A
weaker-on-paper posture that is actually followed beats a stronger one that is
not.

The middle ground: run the sensitive processes in a **network namespace with no
interface at all**. Not firewalled — no route, nothing to misconfigure, and
stronger than a rule because there is no rule to get wrong. On Linux this is one
directive in a systemd unit. Updates become a deliberate, separate, manual step
under a networked unit, and encrypted backups flow outward to ordinary storage.

A true physical air gap remains the right answer where the threat model includes
an adversary who can reach the network at all — but that is a threat model to
state explicitly, not a default to assume.

# Citations

- <https://www.zmanda.com/blog/air-gapped-backup-architecture-design/> — directional flow, transfer workstations, maturity levels
- <https://www.opswat.com/blog/maintaining-an-air-gap-with-a-data-diode> — data diodes and one-way transfer
- <https://localaimaster.com/blog/air-gapped-ai-deployment> — sneakernet bundles and the volume ceiling
- <https://corvusintell.com/blog/secure-cloud/air-gapped-deployment-defense/> — update-delivery patterns and best practices
- <https://owlcyberdefense.com/blog/how-can-siem-work-with-air-gapped-networks/> — unidirectional egress from isolated zones
