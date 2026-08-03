# Execution environments

Compute services agents and developers run code on: persistent, suspendable
microVM platforms (the category one step beyond ephemeral sandboxes), their
isolation and credential models, and their idle-time economics.

## Contents

- [Fly.io](/knowledge/SWE/agentic/execution-environments/fly-io.md) — the
  global public cloud repositioned around "computers for agents": Fly Sprites
  (persistent, self-checkpointing Linux microVMs) atop the Machines platform —
  includes the comparison against Shellbox
- [Shellbox](/knowledge/SWE/agentic/execution-environments/shellbox.md) —
  solo-operator service selling instant Firecracker-microVM Linux boxes over
  pure SSH: key fingerprint as account, pay-per-minute, suspended when
  disconnected
