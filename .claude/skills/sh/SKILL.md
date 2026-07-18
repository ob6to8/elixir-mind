---
name: sh
description: Run a shell command on the sandbox and log the exact command and its raw output back into the chat. Use when the operator says "/sh <command>", "/sh <natural-language request for a command>", or wants a command run on the host with its result echoed verbatim into the thread.
---

# /sh — run a command and log the result

Take everything after `/sh`, run it on the sandbox via the **Bash** tool, and echo the
**exact command plus its raw output** back into the chat in a fenced block. The point is
a terse trigger with a guaranteed "log the raw command + output verbatim" contract, so the
run reads cleanly in the [captured thread](/meta/policy/session-capture.md). Follow the
[operating contract](/CLAUDE.md).

This skill files **nothing** — no document, no `em:` id, no reserved-file upkeep. It is a
pass-through to the shell whose only durable trace is the chat text (which `/capture`
freezes) and the commit graph, if the command changes tracked files.

## The argument — literal or natural language

Everything after `/sh` is the request. It comes in two forms:

- **Literal command** — run it verbatim. Do not "improve", reformat, or add flags.
  - `/sh git log --oneline --graph --decorate --all` → run exactly that.
- **Natural-language request** — translate it to the single best command, then run it. This
  is the only judgment call in the skill.
  - `/sh show me the commit graph` → `git log --oneline --graph --decorate --all`
  - `/sh how much disk is free` → `df -h`
  - When the NL request is ambiguous enough that a wrong guess would waste a round-trip
    (or touch the wrong target), state the command you *would* run and ask before running
    it, rather than guessing.

## Procedure

1. **Resolve the command.** Literal → use as-is. NL → translate to one command; if the
   translation is non-obvious, show it and confirm first.
2. **Safety gate.** If the resolved command is **destructive or hard to reverse** — deletes
   or overwrites files, force-pushes, resets/`clean`s the tree, drops data, mutates remote
   state, or sends anything outward — do **not** run it silently. Show the exact command and
   confirm with the operator first, per the operating contract's default on irreversible
   actions. Read-only inspection commands (the common case) run immediately.
3. **Run it** with the Bash tool, with a one-line description of what it does.
4. **Log it back verbatim.** Echo, in the chat:
   - the exact command that ran (as a one-liner), and
   - its raw stdout/stderr, unedited, in a fenced block.
   Truncate only genuinely huge output (say so, and how it was truncated — e.g. `| head`);
   otherwise reproduce it whole. Do not summarize in place of the raw output — a short
   plain-language note *after* the block is fine, but the raw result must be present.
5. **Report failures faithfully.** Non-zero exit, missing binary, permission error — log the
   real output and say it failed. Never fabricate or predict output; if a command was not
   run (e.g. gated for confirmation), say so plainly.

## Guardrails

- **Verbatim contract.** The command and its output are reproduced exactly — this skill's
  whole value is that the thread shows what actually ran, not a paraphrase.
- **One command per invocation** is the norm; a short pipeline is fine when it's genuinely
  one logical operation. Don't fan a `/sh` out into an unbounded script.
- **Confirm before irreversible actions**, as above — the sandbox is ephemeral, but pushes,
  remote mutations, and outward sends are not.
- **Never touch `deprecated/`** (read-only per the contract).
- This skill runs commands; it does **not** file knowledge. If a run produces something worth
  keeping in the brain, that's a separate `/intake`.
