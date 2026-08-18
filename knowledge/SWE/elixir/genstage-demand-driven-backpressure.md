---
id: em:ef34f0
type: reference
title: "GenStage's demand-driven backpressure (a visual explainer)"
description: GenStage's producer/consumer protocol expresses backpressure as a count, not a rate — a consumer tells a producer how many events it may send, never how fast — with :max_demand and :min_demand as the two knobs governing when it re-asks and how much work stays in flight.
resource: https://andrealeopardi.com/posts/genstage-demand-visualized/
provenance: "Andrea Leopardi's blog (andrealeopardi.com), posted 2026-08-07; discussed on r/elixir"
tags: [elixir, genstage, backpressure, otp, beam, concurrency, flow-control, broadway]
timestamp: 2026-08-18
attribution:
  when: 2026-08-18T00:00:00Z
  channel: intake
  agent: "operator via /intake, Claude Code session"
  why: "operator batch-pasted a reading list of ~63 links for filing"
---

# GenStage's demand-driven backpressure

GenStage solves one problem: a producer that can emit data faster than a
consumer can absorb it. A pipeline with a fast producer and a fixed-rate
consumer either grows an unbounded queue until memory gives out, or drops
work — if work enters a system faster than it leaves for long enough,
something inside the system must keep growing, reject work, or slow the
input.

## Demand is a count, not a rate

GenStage's fix: the producer may send only what the consumer asks for. That
ask is *demand* — a plain integer. Demand of six means the consumer wants six
events. Critically, the consumer does not say "send n events per second," it
says "you may send n more events." This decouples the protocol from timing
entirely — a slow consumer naturally throttles a fast producer because it
simply asks less often, with no rate negotiation involved.

## `:max_demand` and `:min_demand`

A consumer subscribes to a producer with two subscription options:

- **`:max_demand`** — the maximum events in flight for the subscription, and
  the size of the first request.
- **`:min_demand`** — the remaining-demand threshold that triggers the next
  request.

Worked example: `[max_demand: 6, min_demand: 2]`. The consumer starts with an
outstanding request for 6. As it processes events, remaining demand counts
down; the moment it hits 2 (4 events consumed), the consumer issues a new
request for 4 more (`max_demand - min_demand`), refilling toward 6. The
producer never inspects "is the consumer almost ready" — it purely tracks
this number.

Because producer and consumer are separate BEAM processes, the producer can
fetch the next batch while the consumer is still working through the tail of
the current one — the refill request fires early enough that new events
arrive exactly when needed, with zero idle time on either side.

## The three roles

- **producer** — implements `handle_demand/2`; receives an integer, returns
  up to that many events.
- **consumer** — implements `handle_events/3`; sends demand, receives events.
- **producer-consumer** — both; sits mid-pipeline and mostly forwards demand
  upstream.

```elixir
defmodule Counter do
  use GenStage

  def start_link(initial), do: GenStage.start_link(__MODULE__, initial, name: __MODULE__)

  @impl true
  def init(counter), do: {:producer, counter}

  @impl true
  def handle_demand(demand, counter) when demand > 0 do
    events = Enum.to_list(counter..(counter + demand - 1))
    {:noreply, events, counter + demand}
  end
end

defmodule Printer do
  use GenStage

  @impl true
  def init(:ok) do
    opts = [subscribe_to: [{Counter, max_demand: 6, min_demand: 2}]]
    {:consumer, :ok, opts}
  end

  @impl true
  def handle_events(events, _from, state) do
    Enum.each(events, &IO.inspect/1)
    {:noreply, [], state}
  end
end
```

## Demand and concurrency are separate knobs

GenStage supports many-to-many subscriptions. Each consumer tracks its own
demand independently, and the producer's dispatcher tracks demand
per-subscription — the default `DemandDispatcher` routes each event to
whichever subscribed consumer currently holds the highest outstanding
demand. This is not round-robin: three consumers with identical
`max_demand`/`min_demand` but different processing speeds each ask again at
their own pace, so a faster consumer naturally receives more work without
any central load-balancing logic.

## Limits

Demand only governs flow inside a GenStage pipeline — it cannot slow an
external source (SQS, Kafka, a socket) that keeps delivering regardless. The
producer's job is to decide when it fetches from that source, letting
unconsumed data sit in the external system's own storage until the pipeline
is ready. GenStage also does not guarantee a producer emits exactly current
demand — it may over-return and buffer the excess internally, so a hard
memory bound still requires deliberately choosing a buffer size and overflow
policy.

[Broadway](https://hexdocs.pm/broadway) is declarative GenStage — a packaged
abstraction over the same protocol with ready-made queue connectors.

# Citations

- Source: <https://andrealeopardi.com/posts/genstage-demand-visualized/>
- Discussion: <https://www.reddit.com/r/elixir/comments/1vhxagp/elixirs_genstage_demand_a_visual_explainer/>
