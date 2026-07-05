defmodule SecondBrain.Frontmatter do
  @moduledoc """
  Parser for the small YAML-frontmatter subset used by OKF concept documents in
  this bundle. Deliberately dependency-free: it handles scalars (string, integer,
  boolean), quoted strings, and inline `[a, b, c]` lists — which is everything the
  bundle's frontmatter uses. It is a tolerant *consumer* per OKF §5: unknown keys
  are preserved as strings.

  A document is `---\\n<yaml>\\n---\\n<body>`. `parse/1` returns
  `{:ok, %{frontmatter: map, body: string}}` or `{:error, reason}`.
  """

  @doc "Parse a full document (frontmatter + body)."
  @spec parse(binary) :: {:ok, %{frontmatter: map, body: binary}} | {:error, term}
  def parse(content) when is_binary(content) do
    case split(content) do
      {:ok, yaml, body} -> {:ok, %{frontmatter: parse_yaml(yaml), body: body}}
      {:error, _} = err -> err
    end
  end

  @doc "Like `parse/1` but raises on malformed input."
  @spec parse!(binary) :: %{frontmatter: map, body: binary}
  def parse!(content) do
    case parse(content) do
      {:ok, result} -> result
      {:error, reason} -> raise ArgumentError, "invalid frontmatter document: #{inspect(reason)}"
    end
  end

  # --- splitting -----------------------------------------------------------

  defp split(content) do
    normalized = String.replace(content, "\r\n", "\n")

    case normalized do
      "---\n" <> rest -> split_after_open(rest)
      _ -> {:error, :missing_frontmatter}
    end
  end

  defp split_after_open(rest) do
    case String.split(rest, "\n---\n", parts: 2) do
      [yaml, body] -> {:ok, yaml, body}
      # frontmatter block that ends the file with a trailing `\n---`
      [only] ->
        case String.split(only, "\n---", parts: 2) do
          [yaml, body] -> {:ok, yaml, String.trim_leading(body, "\n")}
          _ -> {:error, :unterminated_frontmatter}
        end
    end
  end

  # --- yaml subset ---------------------------------------------------------

  defp parse_yaml(yaml) do
    yaml
    |> String.split("\n")
    |> Enum.reduce(%{}, fn line, acc ->
      trimmed = String.trim(line)

      cond do
        trimmed == "" -> acc
        String.starts_with?(trimmed, "#") -> acc
        true -> put_pair(acc, trimmed)
      end
    end)
  end

  defp put_pair(acc, line) do
    case String.split(line, ":", parts: 2) do
      [key, raw] -> Map.put(acc, String.trim(key), coerce(String.trim(raw)))
      [_key] -> acc
    end
  end

  defp coerce("true"), do: true
  defp coerce("false"), do: false

  defp coerce("[" <> _ = list) do
    list
    |> String.trim_leading("[")
    |> String.trim_trailing("]")
    |> String.split(",")
    |> Enum.map(&unquote_scalar(String.trim(&1)))
    |> Enum.reject(&(&1 == ""))
  end

  defp coerce(value) do
    case Integer.parse(value) do
      {int, ""} -> int
      _ -> unquote_scalar(value)
    end
  end

  defp unquote_scalar(<<?", rest::binary>>), do: String.trim_trailing(rest, "\"")
  defp unquote_scalar(<<?', rest::binary>>), do: String.trim_trailing(rest, "'")
  defp unquote_scalar(value), do: value
end
