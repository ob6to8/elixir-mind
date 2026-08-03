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

## Thread excerpts — route-tagged log

Append-only, per-thread, date-stamped excerpts, generated from the `<routes ref="em:d000f6">` regions of the threads that fed this matter and re-derivable via `mix brain.route_tags` — never hand-edit.

### 2026-08-02-fly-shellbox-intake-and-elixir-deployment-landscape (2026-08-02)

5 tagged region(s), lifted whole. Refs shown are the full ref-set of each region (this matter plus any it co-feeds).

**[`em:d000f6`]**  (co-feeds: `em:e75bfc`)

https://fly.io/
https://shellbox.dev/#synopsis

and provide an analysis that compares them - include the comparison the fly.io document

---

**[`em:d000f6`]**  (co-feeds: `em:e75bfc /meta/evals/dedup-probe.md`)

Precedents are clear: product references follow the superlogical shape; the comparison lives in the fly.io doc as the operator asked (the vercel-eve doc was a `meta/analysis` only because its subject was this bundle). One dimension needs grounding before I write — pricing, which is Shellbox's whole pitch — so fetching Fly's pricing page and the Sprites product page.

---

**[`em:d000f6`]**  (co-feeds: `em:e75bfc /meta/evals/dedup-probe.md`)

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

---

**[`em:d000f6`]**

fly is one of the larger hosts for elixir apps and beam deployments. if at some point they were to sunset fly machines, what would be other options for elixir deployments? and what would it look like to roll your own, or use aws?

---

**[`em:d000f6`]**  (co-feeds: `/meta/analysis/beam-deployment-and-jido-2-evaluation.md /meta/plans/thin-jido-brain-host.md`)

Both checks landed: Gigalixir is alive and current, and the bundle's existing BEAM analysis covers *this repo's* (non-)deployment, not the general landscape — so here's the assessment. Answering your three questions in turn.

Your premise is well-grounded, and today's capture sharpens it: Fly employs the Phoenix ecosystem heavily (Phoenix.new is a first-party Fly product, "Phoenix Files" is a Fly article series), and the official Phoenix docs feature a Fly deployment guide. The sunset scenario itself deserves calibration though: Machines are the substrate *under* Sprites — sunsetting them would hollow out the agent product too — so the realistic risk visible in the homepage pivot we just captured is attention drift away from the app-hosting business, not a shutdown. Basis for what follows: the Fly and Gigalixir facts were checked today; the rest is training knowledge through early 2026, marked where it's load-bearing.

The structural reason this is a survivable event: what Fly actually provides an Elixir app decomposes into four replaceable things — compute, a private network that makes clustering trivial (their 6PN mesh + internal DNS is why `dns_cluster` is a one-liner there), managed Postgres, and anycast geo-routing. And BEAM apps are unusually portable because `mix release` produces a self-contained artifact (ERTS bundled — the server needs no Elixir, no Erlang, no runtime toolchain).

> what would be other options for elixir deployments?

Four tiers, by how much of Fly's job each replaces:

- **BEAM-aware PaaS — Gigalixir.** The only like-for-like: "Distributed clustering, Remote Console, and production observer without extra configuration," no forced daily restarts that "wipe your GenServer state, ETS, or cachex data" (checked today — site current, Jan 2026 posts, Postgres 18 support). The counterweight is concentration risk of a different kind: it's a small company, much smaller than Fly.
- **Generic container PaaS with private networking — Render, Railway.** Both give apps a private network, which is the one thing clustering needs; `libcluster` (Gossip or DNS strategy) does the rest. Heroku is the weak option here — standard dynos have no inter-dyno networking (no distributed Erlang) plus daily restarts; only Private Spaces lifts that, at enterprise pricing (recalled, unchecked).
- **Self-hosted PaaS on rented VMs — Coolify, Dokku, or Kamal on Hetzner/DO.** The post-Heroku indie default: you own the boxes, the tool gives you the git-push/deploy ergonomics. This is the same duty-cycle logic as the Shellbox doc inverted — always-on production load is exactly where flat-rate VMs win.
- **Kubernetes anywhere.** `libcluster`'s Kubernetes strategy (headless-service selector) is the most battle-tested clustering path in the ecosystem; EKS/GKE work identically. You pay the K8s complexity tax for it.

Piece-by-piece substitution for the rest of Fly's bundle: Fly Postgres → Neon/Supabase/Crunchy/RDS; anycast + `fly-replay` routing → Cloudflare in front (or AWS Global Accelerator); LiteFS/volumes → managed PG, or SQLite + Litestream — which is open source and runs anywhere, so its Fly affiliation isn't a dependency.

> and what would it look like to roll your own

Elixir has the easiest roll-your-own story of any mainstream stack, because the release *is* the deployment unit — Erlang shipped telecom hardware this way for decades:

- **Pipeline:** CI builds `mix release` in a container matching the target distro → rsync the tarball to the VM → systemd unit runs `bin/myapp start`. That's the whole thing; rollback is re-pointing a symlink at the previous release.
- **Ingress:** Caddy (automatic TLS) or nginx in front of Bandit/Cowboy; websockets pass through untouched.
- **Clustering:** put nodes on a private LAN (Hetzner vSwitch, DO VPC) or a Tailscale/WireGuard overlay, then `libcluster` Gossip for small fleets; pin the distribution port and start with `-start_epmd false` so you firewall exactly one port.
- **Deploys:** restart-based with LiveView's auto-reconnect is the community norm; blue-green with a proxy flip if you can't drop connections. Hot code upgrades exist but almost nobody runs them in production — the ceremony outweighs the benefit.
- **State:** keep the VMs stateless — managed Postgres, or SQLite + Litestream replicating to object storage for small apps.
- **What you take on:** OS patching, monitoring (PromEx → Grafana is the idiomatic stack), log shipping, backups you actually restore-test, and being your own on-call. The reward: two Hetzner VMs plus a load balancer run ~€15–30/month for capacity that costs several times that on any PaaS at steady load (recalled pricing, order-of-magnitude).

> or use aws?

Three viable shapes, ranked by BEAM-fit (all recalled from training; AWS specifics are stable but verify limits before committing):

1. **EC2 + releases** — the roll-your-own above with AWS primitives: an ASG of instances from a Packer-baked AMI (or CodeDeploy pulling from S3), clustering via the community `libcluster_ec2` tag strategy or DNS polling against a private hosted zone, ALB in front. The ALB's 60-second idle timeout sits above Phoenix's 30-second channel heartbeat, so LiveView works with defaults; sticky sessions are unnecessary once PubSub is clustered.
2. **ECS on Fargate** — the pragmatic managed middle. Tasks in `awsvpc` mode get real VPC IPs, so distributed Erlang works task-to-task; discovery via Cloud Map + `libcluster`'s DNS strategy, distribution port pinned, EPMD off. No instances to patch.
3. **EKS** — the most-trodden clustered-BEAM path if you already carry K8s competence; otherwise it's the biggest ops surface of the three for the same result.

**Avoid for LiveView-shaped apps:** Lambda and App Runner. Scale-to-zero and per-request execution models fight the BEAM's core assumption — long-lived stateful processes — and App Runner has no inter-instance networking, so clustering is off the table entirely. What AWS makes harder than Fly is multi-region (Global Accelerator, inter-region VPC peering for distribution, cross-region PG replicas — real work); most teams settle for single-region multi-AZ, which candidly matches what most Fly Elixir apps actually ran. What it makes easier: RDS maturity, IAM, compliance artifacts. The cost floor (small instance + ALB + RDS ≈ $45+/month) sits well above Hetzner's, and buys managedness.

One connection to this repo's own stake: the brain's Elixir layer has no deployment exposure today — [the BEAM/Jido evaluation](https://github.com/ob6to8/elixir-mind/blob/main/meta/analysis/beam-deployment-and-jido-2-evaluation.md) established it's a batch toolchain whose runtime is Claude Code sessions plus CI. But the [thin Jido host plan](https://github.com/ob6to8/elixir-mind/blob/main/meta/plans/thin-jido-brain-host.md) opens with "The brain's automation host is rented" — if that host is ever built, this landscape is exactly its deployment-target decision, and the tiers above are the menu.

This assessment currently lives only in this thread. If you want it durable, say the word and I'll file it as a knowledge doc (it's general Elixir-deployment knowledge, so it would go in the taxonomy — likely a new subdirectory under `knowledge/SWE/`, which I'd propose for ratification) — or leave it for `/capture` to freeze with the session.

Unrelated housekeeping: two MCP connectors in this session (Cloudflare Developer Platform, alphaXiv) need authorization via your claude.ai connector settings before their tools work here; nothing in this answer needed them.
