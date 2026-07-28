defmodule Mix.Tasks.Brain.ThreadTail do
  @shortdoc "Print the last rendered exchange of a thread doc (the capture boundary)"

  @moduledoc """
  Print the role and text of a thread doc's final `## User`/`## Assistant`
  block, so a resumed `/capture` locates that text in the session log and takes
  everything after it as the un-captured remainder.

      mix brain.thread_tail meta/threads/2026-07-27-some-session.md

  Reading the boundary out of the file replaces recalling it, which is the step
  that silently drops exchanges when a session continues across several PRs.
  Route-tag markup is stripped, since it exists only in the thread doc and would
  never match the log.
  """

  use Mix.Task

  alias ElixirMind.ThreadTail

  @impl Mix.Task
  def run([path]) do
    case File.read(path) do
      {:ok, body} -> report(path, ThreadTail.last_block(body))
      {:error, reason} -> Mix.raise("cannot read #{path}: #{:file.format_error(reason)}")
    end
  end

  def run(_args), do: Mix.raise("usage: mix brain.thread_tail <path-to-thread-doc>")

  defp report(path, {:ok, {role, text}}) do
    _ = Mix.shell().info("#{path}\nlast block: ## #{role}\n")
    Mix.shell().info(text)
  end

  defp report(path, {:error, reason}), do: Mix.raise("#{path}: #{reason}")
end
