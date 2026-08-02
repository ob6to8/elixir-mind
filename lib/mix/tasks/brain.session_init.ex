defmodule Mix.Tasks.Brain.SessionInit do
  @shortdoc "Print the session-init digest: open issues, matters, plans, dangling strands, top-3 priorities"

  @moduledoc """
  Render the open-work digest a fresh session should start from.

      mix brain.session_init

  Scans `meta/issues/` (status `open`), `meta/matters/` (status `open`, queued
  register rows annotated and listed first), `meta/plans/` (status `proposed` /
  `accepted` / `in-progress`), and the `## Routing` ledgers under
  `meta/threads/` (rows in state `open`/`paused`, or with a dangling question),
  then prints a markdown digest ending in a heuristic top-3 priority ranking.
  Produced on demand by the `/priorities` skill; the SessionStart hook only
  provisions the toolchain.
  """

  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    Mix.shell().info(ElixirMind.SessionInit.report())
  end
end
