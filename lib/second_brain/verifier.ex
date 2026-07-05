defmodule SecondBrain.Verifier do
  @moduledoc """
  Machine checks over the knowledge bundle's identity and verification layer.

  Rules enforced (each violation is a human-readable error string):

    1. Every bundle concept has parseable frontmatter and a non-empty `type`
       (OKF conformance) — surfaced via `SecondBrain.Registry.scan/1`.
    2. Every bundle concept carries a stable `id` matching `sb:[0-9a-f]{6}`;
       ids are unique.
    3. Every `verified_by` reference resolves to an existing id, and every
       referenced concept is itself `verified: true`.
    4. `verified: true` requires grounding: the concept must have a `resource`
       (primary evidence, e.g. a source excerpt's official URL) or a non-empty
       `verified_by` (derived evidence). No ungrounded "verified".
  """

  alias SecondBrain.Registry

  @spec run(String.t()) :: :ok | {:error, [String.t()]}
  def run(root \\ File.cwd!()) do
    {entries, scan_errors} = Registry.scan(root)
    by_id = entries |> Enum.reject(&is_nil(&1.id)) |> Map.new(&{&1.id, &1})

    errors =
      scan_errors ++
        Enum.flat_map(entries, fn e ->
          type_errors(e) ++ id_errors(e) ++ edge_errors(e, by_id) ++ grounding_errors(e)
        end)

    if errors == [], do: :ok, else: {:error, errors}
  end

  defp type_errors(%{type: type, path: path}) do
    if type in [nil, ""], do: ["#{path}: missing or empty `type`"], else: []
  end

  defp id_errors(%{id: nil, path: path}) do
    ["#{path}: missing stable `id` — mint one with `mix brain.id`"]
  end

  defp id_errors(%{id: id, path: path}) do
    if id =~ Registry.id_format(),
      do: [],
      else: ["#{path}: malformed id #{inspect(id)} (expected sb:xxxxxx hex)"]
  end

  defp edge_errors(%{verified_by: refs, path: path}, by_id) do
    Enum.flat_map(refs, fn ref ->
      case by_id[ref] do
        nil -> ["#{path}: verified_by #{ref} does not resolve to any concept"]
        %{verified: true} -> []
        %{path: target} -> ["#{path}: verified_by #{ref} (#{target}) is not itself verified"]
      end
    end)
  end

  defp grounding_errors(%{verified: true, resource: nil, verified_by: [], path: path}) do
    ["#{path}: verified: true but no grounding (needs `resource` or `verified_by`)"]
  end

  defp grounding_errors(_), do: []
end
