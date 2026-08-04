defmodule Mix.Tasks.Brain.Regen do
  @shortdoc "Re-derive every committed generated artifact from its sources"

  @moduledoc """
  One motion to re-derive all committed generated artifacts — the contract
  (`CLAUDE.md`), the registry, the code map, the flow-lineage views, the
  glossary index, the route-tag excerpt logs, and the dedup-probe baseline.
  Exists for the moment after a merge in which the `regen` driver of
  `.gitattributes` auto-resolved a generated artifact as `ours`: the file is
  then stale by construction, and this task restores it from the merged
  sources before the pre-commit/CI freshness gates judge the merge commit.

      mix brain.regen
  """

  use Mix.Task

  @generators [
    {"brain.contract", []},
    {"brain.registry", []},
    {"brain.codemap", []},
    {"brain.lineage", []},
    {"brain.glossary", ["--materialize"]},
    {"brain.route_tags", ["--materialize"]},
    {"brain.dedup_probe", ["--update-baseline"]}
  ]

  @impl Mix.Task
  def run(_args) do
    Enum.each(@generators, fn {task, args} ->
      _ = Mix.Task.run(task, args)
      Mix.Task.reenable(task)
    end)
  end
end
