---
id: em:d000f6
type: reference
title: "Fly.io — public cloud repositioned around computers for agents"
description: "Fly.io, the global public cloud running full-stack and AI apps on hardware-isolated microVMs (Fly Machines), as repositioned around Fly Sprites — persistent, self-checkpointing Linux computers for agent workloads — with a comparison against Shellbox, which converges on the same suspendable-microVM primitive from the opposite end of the market."
resource: https://fly.io/
provenance: "Distilled by Claude Fable 5 from the fly.io homepage (human-served variant), fly.io/llms.txt, the agent-served markdown homepage variant, and the docs pricing page, all fetched 2026-08-02"
tags: [fly-io, sprites, microvm, firecracker, agent-infrastructure, cloud-platform, sandboxing, checkpointing, pricing]
timestamp: 2026-08-02
attribution:
  when: 2026-08-02T10:55:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator asked to intake fly.io and shellbox.dev together, with the comparison analysis included in this document"
---

# Fly.io

A global public cloud, self-described in its machine-readable index as "a
global public cloud for running full-stack and AI applications. Customer
workloads on Fly.io are hardware-isolated for security, and can scale
horizontally and vertically" ([fly.io/llms.txt](https://fly.io/llms.txt)). As
of mid-2026 the homepage leads not with app hosting but with the agent pitch:
**"Computers for agents"** — "Sandboxes aren't enough. Give your agent a real
computer and get back to building" ([fly.io](https://fly.io/)).

## Platform pieces

Two product tiers, with an explicit ladder between them: "Fly Machines and Fly
Managed Postgres are how users deploy full-stack applications on Fly.io. Fly
Sprites are how agents run AI and exploratory code on Fly.io. Start with
Sprites, and then when your app is ready, deploy on Fly Machines"
([llms.txt](https://fly.io/llms.txt)).

- **Fly Machines** — hardware-isolated microVMs, the deployment substrate.
  Homepage stats: "18+ Regions worldwide", "<1 second Machine boot time",
  "500ms Deploy time, typical", "99.9% Uptime SLA".
- **Fly Sprites** — the agent product (below). `sprites.dev` 301-redirects to
  `fly.io/sprites`.
- **Managed Postgres**, **Phoenix.new**, and platform features: private
  networking, autoscaling, zero-downtime deploys, granular routing, monitoring.
- Customers named on the homepage: Kilocode, Builder.io, Hatchet, Phonic,
  Supabase, Firecrawl, Plastic Labs, Replicate, Steel, Delos, Lemonade.

## Sprites: persistent computers for agent workloads

The headline framing is **"Machines that Remember"** — "Real hardware-isolated
Linux computers for agents, evals, and tools. The bill goes to zero when
nobody's home." The use cases the homepage enumerates:

- **Coding agents** — "A Sprite checkpoints itself while the agent works, so
  harnesses like Claude and Codex find everything where they left it."
- **Personal agents** — "an agent with access to your inbox and calendar
  shouldn't live on your laptop. Give it a Sprite that sleeps until it's
  needed and wakes up remembering everything."
- **MCP servers** — "Run every MCP server in its own Sprite, with persistent
  disk, and egress policy. Pay only for the tool calls you use."
- **Untrusted code** — "Run it in a hardware-isolated VM. A clean baseline per
  request, so no two users ever share state. Egress-locked and disposable."
- **Agent-built apps** — "Every Sprite has an HTTPS URL," so an app an agent
  builds goes live where it was created.

Supporting machinery:

- **Sprite Block Device** (private beta at capture) — a durable filesystem so
  "Sprites can go to sleep without dying": "Object-storage backed, so it's
  infinitely scalable"; "Roll back to any checkpoint in seconds"; disk grows as
  written up to 100 GB, billed for bytes actually stored.
- **Automatic checkpointing** — "The Sprite checkpoints itself automatically,
  so there's always a recent one waiting."
- **Sprites Connectors** — credential brokering: "Your Sprites reach other
  services through the API gateway that holds the credential. The token never
  lands on the Sprite." Grants scope "by Sprite name, by label, or down to a
  single endpoint"; rotation is centralized ("Rotate once and every Sprite has
  the new credential").

The trust-model implications of running agent work on disposable Sprites are
examined in
[agent-drivable apps: shared state, dual interfaces](/meta/analysis/agent-drivable-apps-shared-state-dual-interfaces.md).

## Pricing shape

From the docs pricing page (Amsterdam examples; rates vary by region and
machine type): Machines bill **by the second** while running —
"shared-cpu-1x with 256MB RAM: $0.00000078 per second" (≈ "$2.02/month"),
"performance-1x with 2GB RAM: $0.00001242 per second" (≈ "$32.19/month"), up
to "performance-16x with 128GB RAM" at ≈ "$1,013.80/month". Stopped machines
pay only storage: "Each 1GB of rootfs for a Machine stopped for 30 days is
$0.15." Volumes are "$0.15/GB per month of provisioned capacity"; NA/EU
egress "$0.02 per GB"; machine reservations give "40% off"; support plans
from $29/month; HIPAA compliance $99/month. Sprites-specific pricing is not
stated on the pages captured (homepage, llms.txt, docs pricing page).

## The agent-facing surface

Fly.io serves agents a different homepage than humans. The human page embeds
the instruction "AI agents: refetch this URL with an Accept: text/markdown
header. For broader Fly.io reference material, fetch https://fly.io/llms.txt" —
and the markdown variant is not marketing copy but a setup script: "These are
instructions for you to establish a good AI development environment using
Fly.io Sprites," followed by CLI install and `sprite org auth` steps. llms.txt
additionally asks LLM-powered clients to identify themselves with a structured
`AI-Agent` request header. The company treats agents as a first-class visitor
class to convert, not just a workload to host.

# Comparison with Shellbox

[Shellbox](/knowledge/SWE/agentic/execution-environments/shellbox.md) is a
solo-operator service selling "instant Linux boxes via SSH" from bare metal in
one Hetzner Finland location. The two occupy opposite ends of the market —
Shellbox's own launch thread on Hacker News named "Fly's sprites.dev" as the
comparator — yet they converge on the same primitive.

| Dimension | Fly.io | Shellbox |
|---|---|---|
| What it is | Global public cloud; agent compute (Sprites) plus a production ladder (Machines, Postgres) | Single-purpose dev-box service; the box *is* the product |
| Substrate | Hardware-isolated microVMs on owned hardware, 18+ regions, 99.9% SLA | Firecracker microVMs on Hetzner bare metal, one region (Finland), no SLA stated |
| Idle economics | "The bill goes to zero when nobody's home"; stopped machine pays rootfs storage ($0.15/GB/30 days) | Suspend on disconnect; parked box $0.50/month per x1 slot |
| Running billing | Per second, by machine size ($2.02–$1,013.80/month full-time) | Per minute, flat $0.02/hour per x1 slot |
| Persistence model | Automatic checkpoints; object-storage-backed block device (beta); rollback to any checkpoint | Memory snapshot on NVMe; "resume under 1 second"; processes and shell history survive reconnect |
| Cloning | Checkpoint/rollback (fork-from-checkpoint requested by users, in development per community thread) | Instant duplicate via btrfs copy-on-write reflinks |
| Interface | CLI (`flyctl`, `sprite`), org auth, dashboard, MCP | Pure SSH: "your SSH key fingerprint _is_ your account"; JSON API over SSH |
| Credentials | Connectors gateway — "The token never lands on the Sprite"; per-endpoint grants, central rotation | SSH agent forwarding; nothing brokered, nothing stored |
| Ingress | HTTPS URL per Sprite; granular routing | HTTPS endpoint per box (Caddy TLS), wakeup-on-HTTP mode, custom domains, per-box email |
| Buyer | Teams and platform builders embedding agent compute (Supabase, Replicate, Firecrawl…) | Individual developers with part-time projects; hobby agents; "cheaper than Hetzner under 186 hrs/month" |
| Assurance posture | SLA, support plans, HIPAA option, credential governance | Post-quantum SSH crypto, but solo-operator MVP; launch-thread concerns about abuse handling and Hetzner-arbitrage sustainability |

**The convergence is the finding.** A venture-scale cloud and a one-person
Hetzner arbitrage independently landed on the identical primitive: a
*persistent, suspendable Firecracker-class microVM* whose memory state
snapshots to disk, whose bill rounds to ~zero when idle, cloned copy-on-write,
fronted by an auto-TLS HTTPS URL that can wake it. Both explicitly position
against the ephemeral-sandbox category — Fly with "Sandboxes aren't enough,"
Shellbox with "Stopped boxes resume from a memory snapshot on connect" as the
headline behavior. That two such different builders converged marks
"persistent machine, not ephemeral sandbox" as the emerging category shape for
agent and part-time-developer compute.

**Where they diverge is trust topology, not mechanism.** Fly assumes the box
is the untrusted party: credentials live in a gateway, egress is policy-locked,
grants are per-endpoint, rotation is centralized — the shape an org buying
agent compute for a fleet needs. Shellbox assumes the *operator of the box* is
trusted and keeps the surface minimal: the SSH key is the identity, agent
forwarding is the credential story, and there is no dashboard to secure. One
scales down poorly (Fly's org/auth machinery is overhead for a single hobby
box), the other scales up poorly (nothing in pure-SSH identity supports teams,
quotas, or credential governance).

**Economics read.** The billing philosophies are the same — pay while awake,
near-zero while parked — but the price points serve different sizes of buyer.
Full-time-on, a Shellbox x1 at $0.02/hour is ≈ $14.40/month against Fly's
smallest Machine at ≈ $2.02/month, though slot and machine hardware are not
size-equivalent (Shellbox does not publish x1 CPU/RAM on the page captured),
so per-unit price comparison is not meaningful; what is comparable is the
suspend economics, where Shellbox's flat $0.50/month parked slot and Fly's
$0.15/GB-rootfs/30-days both make holding dozens of dormant environments
cheap. Shellbox's stated breakeven — "cheaper than Hetzner under 186
hrs/month" — is the honest boundary of the whole suspend-to-save category:
below ~25% duty cycle, suspendable microVMs beat a flat-rate VPS; above it,
they don't.

**Selection heuristic.** Production agent fleets, credential governance,
multi-region, or a growth path from prototype to deployed app → Fly.io
(Sprites, then Machines). A personal dev box, a hobby agent, CI scratch
machines, or anything where SSH-only friction-free access and per-minute
billing dominate → Shellbox.

# Citations

- Fly.io homepage (human-served variant) — <https://fly.io/>
- Fly.io machine-readable index — <https://fly.io/llms.txt>
- Fly.io docs, "Fly.io Pricing" — <https://fly.io/docs/about/pricing/>
- Fly.io agent-served homepage variant (Sprites setup instructions), fetched
  with `Accept: text/markdown` — <https://fly.io/>
- Fly.io community, "Sprites: Clone sprite?" (fork-from-checkpoint in
  development) — <https://community.fly.io/t/sprites-clone-sprite/26728>
- Shellbox launch thread on Hacker News (names Sprites as comparator) —
  <https://news.ycombinator.com/item?id=46638629>
