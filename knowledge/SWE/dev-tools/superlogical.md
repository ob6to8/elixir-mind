---
id: em:fed9ce
type: reference
title: "Superlogical (Mitchell Hashimoto's new company)"
description: A developer-tools startup founded by Mitchell Hashimoto (Ghostty, HashiCorp) and three cofounders, building "a durable session around the work itself" — a multiplexer meant to unify human, automated, and AI-agent work across local, remote, and production environments — launching first with a modern terminal multiplexer built atop libghostty.
resource: https://www.superlogical.com/
provenance: "Distilled from Mitchell Hashimoto's founding post at mitchellh.com/writing/superlogical and the product overview at superlogical.com, both fetched 2026-07-29"
tags: [terminal, terminal-multiplexer, ghostty, developer-tools, startup, hashicorp]
timestamp: 2026-07-29
attribution:
  when: 2026-07-29T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator pasted the Superlogical launch post and product site for capture"
---

# Superlogical

A new company from Mitchell Hashimoto (HashiCorp cofounder — Vagrant, Terraform,
Vault; creator of the [Ghostty](/beliefs/glossary/terminal-emulator.md) terminal
emulator) and three cofounders: Jack Pearkes (former VP Engineering, HashiCorp),
Alasdair Monk (former VP Design, Vercel), and Hector Simpson (interface designer,
Poolside/Vercel/Heroku). Backed by Notable Capital, Amplify Partners, and
individual investors including Patrick Collison and Tobias Lütke.

## Origin

Hashimoto left HashiCorp in 2023 and, after a period focused on fatherhood and
philanthropy, kept building software "just for the love of it." That hobbyist work
grew into Ghostty, which went from a throwaway experiment to daily-use software
for millions; in 2025 he donated it to a nonprofit so it would remain, in his
words, "forever an open building block that everyone can build on and learn
from." Ghostty now has roughly a dozen core maintainers and fifty localization
contributors. Superlogical grew out of questions Hashimoto developed while
building Ghostty about terminal adoption and what comes after it.

## Thesis

Software work today is fragmented across environments (local, remote, production)
and modes (interactive human work, automated processes, AI agents), and the
company's pitch is that this fragmentation is an infrastructure gap, not an
inherent cost — the missing piece is "a durable session around the work itself."
That framing is close kin to this bundle's
[shared state, dual interfaces](/beliefs/glossary/shared-state-dual-interfaces.md)
concept: a persistent session as the shared substrate multiple interfaces
(human UI, agent API) attach to, rather than each mode getting its own
disconnected surface.

## First product

A modern [terminal multiplexer](/beliefs/glossary/terminal-multiplexer.md):

- Persistent sessions that survive disconnection
- Web and native (macOS/iOS) clients
- Built-in session sharing
- Improved scrollback, selection, and scrolling over traditional multiplexers (tmux/screen)

It is built atop `libghostty` as a public component — consuming the same
MIT-licensed library available to anyone else and upstreaming improvements,
rather than forking it privately.

## Status

Pre-launch: accepting email signups for beta access as of this capture. No
pricing published.

# Citations

- Mitchell Hashimoto, "Superlogical", mitchellh.com, 2026-07-29 —
  <https://mitchellh.com/writing/superlogical>
- Superlogical product site —
  <https://www.superlogical.com/>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:fed9ce">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-07-29-superlogical-intake-and-mitchellh-channel (2026-07-29)

1 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:fed9ce`]**  (co-feeds: `survey/channels.md`)

Pushed successfully. Per contract, I'm not opening a PR since none was requested.

**What I created**

| Doc | Type | Why this type |
|---|---|---|
| `knowledge/SWE/dev-tools/superlogical.md` (`em:fed9ce`) | `reference` | Captured/summarized external material (Hashimoto's founding post + product site) |
| `knowledge/SWE/dev-tools/index.md` | — | New subdirectory listing (autonomous — subdir under the established `SWE` domain) |

**What I modified**

| File | Change |
|---|---|
| `knowledge/SWE/index.md` | Added the new `dev-tools` subdirectory entry |
| `survey/channels.md` | Added `mitchellh.com` under Independent blogs, pointed at the new Superlogical doc |
| `meta/registry.md` | Regenerated after minting the new id |

**Actions I have taken**

| Action | Result |
|---|---|
| Fetched both URLs | Distilled into one `reference` doc (Superlogical's thesis, founders, first product, funding) |
| Dedup search (Superlogical/Hashimoto/Ghostty/terminal multiplexer) | No existing doc — filed new |
| `mix brain.id && mix brain.registry` | Minted `em:fed9ce` |
| `mix brain.dedup_probe --update-baseline` | No natural operator phrasing to harvest as a gold row (bare URLs); recall unchanged (6/19), no regression |
| `mix brain.verify` + full pre-commit gate suite | All green, including tests |
| Committed and pushed | `1efd752` on `claude/mitchell-hedlund-writing-channel-a8gxje` |

No new directory outside an established top-level domain was needed, so nothing here awaits ratification.
