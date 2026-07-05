defmodule Mix.Tasks.Brain.Verify do
  @shortdoc "Verify the bundle: conformance, stable ids, and verified_by evidence edges"

  @moduledoc """
  Run the machine checks over the knowledge bundle (see `SecondBrain.Verifier`):
  OKF conformance, stable-id presence/uniqueness/format, `verified_by` edge
  resolution, and grounding of every `verified: true`.

      mix brain.verify
  """

  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    case SecondBrain.Verifier.run() do
      :ok ->
        Mix.shell().info("Bundle verifies: ids, edges, and grounding all check out.")

      {:error, errors} ->
        Mix.shell().error("Bundle verification FAILED:\n\n" <> Enum.join(errors, "\n"))
        exit({:shutdown, 1})
    end
  end
end
