defmodule ElixirMind.ThreadTail do
  @moduledoc """
  Locate the last rendered exchange in a thread doc, so a resumed `/capture`
  derives its boundary instead of recalling it.

  Capture appends to an existing thread doc when a session continues past its
  first PR, which makes "where did the previous capture stop?" a question asked
  once per continuation. Answering it from memory drops exchanges silently —
  the render still looks well-formed, and only a manual read catches the gap.
  The answer is already in the file: the final `## User` or `## Assistant`
  block is the boundary, and matching it against the session log yields exactly
  the un-captured remainder.

  Route-tag markup is stripped from the returned text because the tags exist
  only in the thread doc — leaving them in would defeat the match against the
  log they are meant to enable.
  """

  @heading ~r/^## (User|Assistant)\s*$/
  @route_tag ~r/^<\/?routes(\s|>)/

  @doc """
  Split a thread doc body into the role and text of its final rendered
  exchange.

  Returns `{:error, reason}` when the body carries no `## User` or
  `## Assistant` heading at all — a thread doc that was never rendered, or a
  path that is not a thread doc.
  """
  @spec last_block(body :: binary) :: {:ok, {binary, binary}} | {:error, binary}
  def last_block(body) when is_binary(body) do
    lines = String.split(body, "\n")

    lines
    |> Enum.with_index()
    |> Enum.filter(fn {line, _i} -> Regex.match?(@heading, line) end)
    |> List.last()
    |> case do
      nil ->
        {:error, "no `## User` or `## Assistant` heading found"}

      {line, index} ->
        [_, role] = Regex.run(@heading, line)
        {:ok, {role, text_after(lines, index)}}
    end
  end

  defp text_after(lines, index) do
    lines
    |> Enum.drop(index + 1)
    |> Enum.reject(&Regex.match?(@route_tag, &1))
    |> Enum.join("\n")
    |> String.trim()
  end
end
