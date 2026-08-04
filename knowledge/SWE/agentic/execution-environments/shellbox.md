---
id: em:e75bfc
type: reference
title: "Shellbox — instant Linux boxes via SSH, suspended when disconnected"
description: "Shellbox.dev sells persistent Firecracker-microVM Linux boxes reached purely over SSH — key fingerprint as account, pay-per-minute running with a near-zero parked rate — a solo-operator service on Hetzner bare metal, captured with its launch reception and post-launch iteration from the Hacker News thread."
resource: https://shellbox.dev/
provenance: "Distilled by Claude Fable 5 from shellbox.dev (synopsis page) and the Hacker News launch thread, both fetched 2026-08-02"
tags: [shellbox, ssh, microvm, firecracker, dev-environment, agent-infrastructure, hetzner, pricing, hacker-news]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T10:55:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked to intake shellbox.dev alongside fly.io, adding its HN launch thread as a good reference"
---

# Shellbox

"Instant Linux boxes via SSH" for developers and AI agents: persistent
Firecracker microVMs with no web console, no signup, and no dashboard —
"No subscription, no login — your SSH key fingerprint _is_ your account"
([shellbox.dev](https://shellbox.dev/)). The core behavior is suspend-on-
disconnect: "Stopped boxes resume from a memory snapshot on connect," so
processes and shell history survive reconnection (~3 seconds), and the
tagline economics follow — "Pay per minute for what you actually use."

## The SSH-only model

SSH is the entire interface — account, control plane, and API:

```bash
ssh shellbox.dev create dev1 x2         # create a 2-slot box
ssh dev1@shellbox.dev                   # connect (box wakes)
ssh dev1@shellbox.dev -- make test      # non-interactive command
ssh shellbox.dev list --json            # machine-readable control plane
ssh shellbox.dev create-from-oci debbox docker.io/library/debian:bookworm-slim
ssh shellbox.dev keepalive dev1         # opt out of suspend
ssh shellbox.dev cron cronbox 60 5      # scheduled wake/run
```

"Pure SSH. Works with VS Code Remote, Zed, mosh"; SCP/SFTP for files; port
forwarding and SSH agent forwarding for credentials (nothing stored on the
service). The JSON-over-SSH output makes the same surface drivable by
automation and agents.

## Box lifecycle and modes

- **Stop** (default) — suspend after a 120-second grace period on disconnect;
  memory snapshot resumes the box exactly as left.
- **Keepalive** — run 24/7 regardless of connections.
- **Wakeup** — auto-start on HTTP request to the box's endpoint; stop again
  after an idle timeout.
- **Cron** — periodic scheduled wake/run with webhook invocation.

Every box gets an automatic HTTPS endpoint with TLS, custom-domain
attachment, a per-box email endpoint, direct IPv6 while running, Docker
preinstalled, and instant duplication via copy-on-write.

## Architecture

Bare metal in Hetzner Finland (auction servers, per the creator's launch-thread
comments); more regions planned. The creator's own stack summary: "This is all
written in python and the AsyncSSH package. Firecracker for VMs with memory
mapped files for ram. Paddle for billing. Caddy as a reverse proxy for
certificates" (messh,
[HN launch thread](https://news.ycombinator.com/item?id=46638629)). Beyond
that: memory snapshots on NVMe with "resume under 1 second"; btrfs
copy-on-write reflinks behind instant cloning; Cloud Hypervisor as an
alternative backend (`--ch`) for nested virtualization; a "Core/External"
split (stateless SSH core, swappable business logic); and post-quantum key
exchange (NTRU Prime hybrid with X25519).

## Pricing

- Running: **$0.02/hour per x1 slot**, billed per minute; x2–x8 scale
  proportionally.
- Parked (stopped): **$0.50/month per x1 slot**.
- Minimum top-up $10; boxes auto-stop when the balance falls to $5 and are
  deleted at $0.
- The pitch is duty-cycle arbitrage: "cheaper than Hetzner under 186
  hrs/month" — at exactly 186 hours/month usage the bill ($4.09) matches
  Hetzner's flat rate, and below that Shellbox wins.

## Launch reception (Hacker News, early 2026)

Submitted as "Linux boxes via SSH: suspended when disconnected" by **messh**,
the creator, who engaged throughout. What the thread adds to the product page:

- **The pricing was corrected in public.** Commenters showed launch-day
  suspended pricing rivaled always-on VPS alternatives; messh conceded — "That
  is a good point actually. The suspended price has to be significantly lower
  than the alternative. I'll revise it." The current $0.50/month parked rate,
  and the keepalive mode that was only under consideration at launch, are that
  feedback landed. Later site updates (OCI images and Ubuntu 24.04 in March
  2026, Cloud Hypervisor and the JSON API in April 2026) continue the
  iteration.
- **The praise centered on interface minimalism** — e.g. exabrial: "No
  'command line tools' to install. No absurd over-complicated web APIs."
- **The concerns centered on sustainability and abuse**: whether a service
  built on Hetzner auction servers survives Hetzner's terms when customers
  misbehave; throwa356262 predicted "I suspect this service will be abused by
  all kind of people and will have to shut down." MVP gaps were visible at
  launch (SFTP "WIP", no ed25519 host key), and Paddle's ~5% billing cut was
  noted against the thin margins.
- **The market pairing**: commenters compared it to "Fly's sprites.dev" and
  exe.dev — the comparison this bundle carries in
  [Fly.io](/knowledge/SWE/agentic/execution-environments/fly-io.md), which
  reads the two as converging on the same persistent-suspendable-microVM
  primitive from opposite ends of the market.

# Citations

- Shellbox product page / synopsis — <https://shellbox.dev/#synopsis>
- "Linux boxes via SSH: suspended when disconnected", Hacker News launch
  thread with creator (messh) participation —
  <https://news.ycombinator.com/item?id=46638629>

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:e75bfc">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-02-fly-shellbox-intake-and-elixir-deployment-landscape (2026-08-02)

4 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:e75bfc`]**  (co-feeds: `em:d000f6`)

https://fly.io/
https://shellbox.dev/#synopsis

and provide an analysis that compares them - include the comparison the fly.io document

---

**[`em:e75bfc`]**

also /intake https://news.ycombinator.com/item?id=46638629
a good reference for shellbox

---

**[`em:e75bfc`]**  (co-feeds: `em:d000f6 /meta/evals/dedup-probe.md`)

Precedents are clear: product references follow the superlogical shape; the comparison lives in the fly.io doc as the operator asked (the vercel-eve doc was a `meta/analysis` only because its subject was this bundle). One dimension needs grounding before I write — pricing, which is Shellbox's whole pitch — so fetching Fly's pricing page and the Sprites product page.

---

**[`em:e75bfc`]**  (co-feeds: `em:d000f6 /meta/evals/dedup-probe.md`)

Intake complete. Both sites are now filed as reference documents in the brain, the comparison the operator asked for sits inside the fly.io document, and the HN thread is folded into the Shellbox one — all committed and pushed on `claude/fly-shellbox-comparison-n1nlya` (commit `879fe67`).

The short version of what the two turned out to be: Fly.io has repositioned its whole homepage around "Computers for agents" — its Sprites product sells persistent, self-checkpointing Linux microVMs whose bill "goes to zero when nobody's home." Shellbox is a one-person service selling the same primitive over pure SSH: Firecracker microVMs that suspend to a memory snapshot on disconnect, billed per minute, with your SSH key fingerprint as the entire account. The comparison's central finding is that a venture-scale cloud and a solo Hetzner-arbitrage operation independently converged on an identical shape — persistent suspendable microVM, snapshot resume, copy-on-write cloning, near-zero idle cost, wake-on-HTTP — which marks that as the emerging category for agent compute, distinct from ephemeral sandboxes. Where they diverge is trust topology (Fly's credential gateway and egress policy vs. Shellbox's SSH agent forwarding) and buyer (teams and platform builders vs. individual part-time developers). One capture-level detail: fly.io literally serves AI agents a different homepage than humans — Sprites setup instructions instead of marketing copy.

**What I created**

| Type | Doc | Why this type |
|---|---|---|
| `reference` | [fly-io.md](https://github.com/ob6to8/elixir-mind/blob/claude/fly-shellbox-comparison-n1nlya/knowledge/SWE/agentic/execution-environments/fly-io.md) (`em:d000f6`) | Captured/summarized external material; carries the requested `# Comparison with Shellbox` section |
| `reference` | [shellbox.md](https://github.com/ob6to8/elixir-mind/blob/claude/fly-shellbox-comparison-n1nlya/knowledge/SWE/agentic/execution-environments/shellbox.md) (`em:e75bfc`) | Captured/summarized external material, including the HN launch thread the operator added |
| — | `knowledge/SWE/agentic/execution-environments/index.md` | Listing for the new subdirectory (autonomous — a subdir under the established `agentic` domain, so nothing awaits ratification) |

**What I modified**

| File | Change |
|---|---|
| `knowledge/SWE/agentic/index.md` | Added the `execution-environments` subdirectory entry |
| `meta/evals/dedup-probe.md` | Harvested two gold rows from your phrasings ("…include the comparison the fly.io document" → both ids; "a good reference for shellbox" → `em:e75bfc`); baseline refreshed |
| `meta/registry.md` | Regenerated after minting the two ids |

**Actions I have taken**

| Action | Result |
|---|---|
| Fetched fly.io (human page, agent-served markdown variant, `llms.txt`, docs pricing), shellbox.dev, and the HN thread | All distilled with links persisted; `sprites.dev` 301s to `fly.io/sprites`, which serves agents only setup steps, so Sprites detail came from the homepage — Sprites-specific pricing is not stated on any page captured |
| Dedup search (fly.io/flyio, shellbox, microvm/firecracker, sandbox/PaaS variants) | No existing doc on either product — only survey-tier bookmarks of fly.io blog posts and passing Sprites mentions in two analyses (cross-linked from the new doc) — so both filed new |
| `mix brain.id && mix brain.registry`, `mix brain.dedup_probe --update-baseline` | Ids minted; plain-recall hits unchanged (8) with targets now 31 — no regression |
| Full pre-commit gate suite | Green: format, xref, contract, registry, codemap, verify, route-tags, glossary, lineage, 202 tests |
| Committed and pushed | `879fe67` on `claude/fly-shellbox-comparison-n1nlya` |

**Your options from here**

| # | Option | What it entails |
|---|---|---|
| 1 | `/create-pull-request` | Runs `/capture`, glossaries the thread, and opens the PR for this intake |
