---
id: em:564da9
type: reference
title: "We replaced our ledger with two functions (River)"
description: "River's Elixir ledger rewrite collapses a ~40-function imperative API into two functions — get_balances/1 and record_event/2 — backed by declarative per-event balance rules, database-enforced double-entry invariants, and a zero-downtime shadow-mode migration."
resource: https://river.com/content/we-replaced-our-ledger-with-two-functions
provenance: "Vivian Mathews, River Engineering blog, published 2026-08-19"
tags: [elixir, ledger-design, event-sourcing, double-entry-accounting, api-design, zero-downtime-migration, testing, agentic-coding]
timestamp: 2026-08-21
attribution:
  when: 2026-08-21T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "featured in the operator's 2026-08-21 bulk /intake reading-list batch"
---

# We replaced our ledger with two functions

River (a Bitcoin financial institution) rebuilt the ledger tracking every
dollar and bitcoin balance, replacing an imperative API that had "bloated to
~40 functions" with a **narrow-waist API of two functions**:

```elixir
# read the truth
def get_balances(account) :: {:ok, Balances.t()} | {:error, term()}

# change the truth by recording what happened
def record_event(event, balances) :: {:ok, Balances.t()} | {:error, term()}
```

"Every buy, sell, deposit, withdrawal, transfer, payout, reclaim, etc. goes
through `record_event`." The rewrite followed the company's stated "day-zero"
principle: "if we were starting today, knowing everything we know now and
owing nothing to sunk cost, what would we build?"

## The design

Each event type implements a `BalanceRules` protocol — "pure & deterministic:
facts + current balances in, ledger entries out" — declaring the debit/credit
pairs it produces (e.g. a completed buy: decrease the USD liability, increase
the BTC liability), and the rules are versioned so historical events replay
against the rules live when they happened. Events group into named **flows**
(`wire_transfer`, `buy_order`, `ach_withdrawal`) that can reference each other
semantically — a return that points at the deposit it reverses, a deposit
linked to the recurring-order chain it's part of — giving an efficient,
tree-shaped transaction history instead of the old model's joins across
dozens of tables. Policy — "whether a client may spend funds based on payment
risk" — sits in a layer *on top of* `get_balances`, so fraud rules and new
features can change "without inheriting the blast radius of the accounting
layer."

**Structural correctness** is enforced at the schema level, not by
convention: the `ledger_entries` table requires a debit balance name, a
credit balance name, and one amount column per row, and "all our accounting
invariants (assets must equal liabilities, balances cannot go negative, we
only front what's receivable, etc.) are guarded by a single Postgres CHECK
constraint. So, any transaction that breaks the books cannot be committed."
The system is append-only; only a denormalized current-balances row updates
via optimistic locking, giving constant-time reads (~10ms p95, ~20ms p99)
regardless of an account's transaction volume.

## The migration

Rather than the standard playbook — copy history, replicate the live delta,
cut over once caught up — River inverted it: "atomic snapshot and cutover,
replicate the live data, and independently backfill the history later,"
decoupling two failure modes (a bug in the new ledger's live path vs. legacy
data that might not satisfy the new constraints) so each could iterate in
parallel. Per account, the first eligible transaction snapshotted balances
into the new ledger; from then on every transaction wrote to **both** ledgers
with pre-commit and post-commit parity checks, and any mismatch automatically
disabled the new ledger for that one account, failing open to the legacy
system — "a single mismatch quarantines a single account. Every other account
keeps going" — while the rest of the roadmap (an app redesign, a React
migration, a Postgres major-version upgrade) shipped in parallel through the
highest-volume trading days.

## Testing

Beyond unit and integration tests, two purpose-built harnesses: a
**scenario-testing DSL** expressing multi-step interaction sequences ("a
deposit that's spent before it returns, a chargeback that lands while a bill
pay is still outstanding") that runs hundreds of fuzzed scenarios in seconds
on every commit; and — "big fans of TigerBeetle" — a **simulator** driving the
real APIs with fleets of simulated users across millions of transactions,
checked against two oracles: the ledger's own invariants, and parity against
the old, known-correct ledger. "A simulator is only useful with a good oracle
to detect badness." The simulator caught roughly a dozen real bugs before
rollout, several in the new ledger itself, each one a prevented production
incident.

## Outcome and AI use

Six years of history were backfilled by consolidating ~40 legacy tables into
the new event stream, validated first against Finance's month-end audits
before being materialized into production. "24×7 agentic loops" handled the
historical-shape translation and staged verification, and colocating code
with data on a PII-scrubbed production clone cut the backfill's projected
five-week runtime to about sixteen hours. Final tally: ~150 PRs merged, +27k
net lines overall ("largely tests & tooling") against −1,265 net lines of
production code — a smaller, simpler system with more capability, built with
AI used deliberately rather than indiscriminately: "Leverage AI smartly.
Autonomy is safe where the design is sound and the failure is loud."

## Takeaways (verbatim)

- "Make invariants structural. Enforcing constraints at the schema layer
  beats application-level convention."
- "Move complexity out of the API. Narrow-waist APIs provide a strong
  contract and can be tested and verified in one place."
- "Separate truth from policy. The system that determines and enforces
  policy should be built on top of the system that records the truth."
- "Automate your resiliency. Running in shadow mode, parity checking,
  automatic mitigations, extensive monitoring, reset/retry tooling, are all
  worthwhile investments when resiliency is paramount."
- "Decouple the ways you can fail. Parallelize workstreams that could each
  sink the project and don't run them in series."
- "Leverage AI smartly. Autonomy is safe where the design is sound and the
  failure is loud."

# Citations

- Source: <https://river.com/content/we-replaced-our-ledger-with-two-functions>
