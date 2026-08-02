defmodule Mix.Tasks.Brain.Matters do
  @shortdoc "Verify the matter register against the matter docs it points at"

  @moduledoc """
  Verify the matters layer (see `ElixirMind.Matters` and the matter-docs
  plan): the register's queue rows are well-formed and point at existing
  matter docs, every doc's `plan`/`order`/`status`/`pr` keys are shaped per
  the vocabulary, each row's Type/Order cells agree with its doc's
  frontmatter, the global order never inverts a plan's internal sequence,
  and — at warn level — every `status: done` doc records its landing PR.

      mix brain.matters   # verify; exits non-zero on any failure

  Warnings never fail the task; only `:fail` results do.
  """

  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    results = ElixirMind.Matters.run_checks()
    Enum.each(results, &report/1)

    if Enum.any?(results, fn {_, status, _} -> status == :fail end) do
      Mix.shell().error("\nMatters verification FAILED.")
      exit({:shutdown, 1})
    else
      warns = Enum.count(results, fn {_, status, _} -> status == :warn end)

      suffix =
        if warns == 0, do: "", else: " (#{warns} warning(s) above — advisory, never failing)"

      Mix.shell().info(
        "\nMatters verify: register rows, docs, and delivery order all check out." <> suffix
      )
    end
  end

  defp report({name, status, detail}) do
    marker =
      case status do
        :ok -> "ok  "
        :warn -> "warn"
        :fail -> "FAIL"
      end

    line = "  [#{marker}] #{name}: #{detail}"

    case status do
      :fail -> Mix.shell().error(line)
      _ -> Mix.shell().info(line)
    end
  end
end
