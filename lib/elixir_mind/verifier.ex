defmodule ElixirMind.Verifier do
  @moduledoc """
  Machine checks over the knowledge bundle's identity and verification layer.

  Rules enforced (each violation is a human-readable error string):

    1. Every bundle concept has parseable frontmatter and a non-empty `type`
       (OKF conformance) — surfaced via `ElixirMind.Registry.scan/1`.
    2. Every bundle concept carries a stable `id` matching `em:[0-9a-f]{6}`;
       ids are unique.
    3. Every `verified_by` reference resolves to an existing id. (Targets are
       typically `source` captures, which are not themselves `verified` — they
       are trusted evidence, not verified statements.)
    4. Verification is only for agent-authored statements. A concept that stores
       a link (has a `resource`) is a capture and cannot be `verified: true`.
    5. `verified: true` requires evidence: a non-empty `verified_by`. A statement
       is never "grounded" by a `resource` of its own — storing a link proves
       nothing.
    6. The `verified` field (either value) may only appear on statement types
       (`claim`/`note`/`concept`) — captures, sources, and every other type
       omit it entirely.
    7. Every glossary term file (a bundle concept under `beliefs/glossary/`)
       carries a `sense` field classifying where the term's usage lives:
       `common` (portable — the wider world uses it this way), `repo` (this
       brain's own vocabulary), or `dual` (both senses, defined common-first).
       The field is not policed outside the glossary.
    8. `attribution` (see `ElixirMind.Attribution`) is well-formed wherever
       it appears — valid `when`/`channel`, non-empty `agent`, `why` per the
       backfill rule — `from` appears on governance docs only and every ref
       resolves, exempt files carry no attribution, and (once the backfill
       lands) every bundle concept and governance doc carries the field.
    9. Every `visualization` names its artifact in `launch`, and that artifact
       exists on disk beside it: a bare `.html` filename, never a path or URL,
       so the pair travels together and the launch link cannot dangle. The
       field is an error on any other type — nothing else has an artifact to
       launch.
    10. Every directory's *existing* `index.md` lists every doc and immediate
        subdirectory filed beside it (see `ElixirMind.Links.unlisted_errors/1`).
        A directory with no `index.md` at all stays advisory (`mix brain.verify`
        still prints it as a docs-freshness warning, per OKF conformance); this
        rule only fires once an index exists and has fallen behind.
  """

  alias ElixirMind.{Attribution, Links, Registry}

  @statement_types ~w(claim note concept)
  @glossary_dir "beliefs/glossary/"
  @senses ~w(common repo dual)
  @launch_type "visualization"

  @spec run(String.t(), keyword) :: :ok | {:error, [String.t()]}
  def run(root \\ File.cwd!(), opts \\ []) do
    {entries, scan_errors} = Registry.scan(root)
    by_id = entries |> Enum.reject(&is_nil(&1.id)) |> Map.new(&{&1.id, &1})

    errors =
      scan_errors ++
        Enum.flat_map(entries, fn e ->
          type_errors(e) ++
            id_errors(e) ++
            edge_errors(e, by_id) ++
            grounding_errors(e) ++
            sense_errors(e) ++
            launch_errors(e, root) ++ Attribution.bundle_errors(e, by_id, root, opts)
        end) ++
        Attribution.governance_errors(root, by_id, opts) ++
        Links.unlisted_errors(root)

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
      else: ["#{path}: malformed id #{inspect(id)} (expected em:xxxxxx hex)"]
  end

  defp edge_errors(%{verified_by: refs, path: path}, by_id) do
    Enum.flat_map(refs, fn ref ->
      if Map.has_key?(by_id, ref),
        do: [],
        else: ["#{path}: verified_by #{ref} does not resolve to any concept"]
    end)
  end

  # A concept that stores a link is a capture, not a verifiable statement.
  defp grounding_errors(%{verified: true, resource: res, path: path}) when not is_nil(res) do
    [
      "#{path}: verified: true but stores a link (`resource`) — captures are " <>
        "trusted evidence, not verifiable statements"
    ]
  end

  # A verified statement must be backed by evidence, never by its own link.
  defp grounding_errors(%{verified: true, verified_by: [], path: path}) do
    ["#{path}: verified: true but no evidence (needs a non-empty `verified_by`)"]
  end

  # Verification is only for agent-authored statements: any `verified` value on
  # a non-statement type is an error (the field is omitted, not set to false).
  defp grounding_errors(%{verified: v, type: type, path: path})
       when is_boolean(v) and type not in @statement_types do
    [
      "#{path}: `verified` on type #{inspect(type)} — verification is only for " <>
        "agent statements (claim/note/concept); omit the field"
    ]
  end

  defp grounding_errors(_), do: []

  # Every glossary term is classified by where its usage lives; the field is
  # required there and ignored everywhere else.
  defp sense_errors(%{sense: sense, path: @glossary_dir <> _ = path}) do
    cond do
      sense in @senses ->
        []

      is_nil(sense) ->
        [
          "#{path}: missing `sense` — every glossary term is classified " <>
            "(common/repo/dual)"
        ]

      true ->
        ["#{path}: invalid sense #{inspect(sense)} (expected common, repo, or dual)"]
    end
  end

  defp sense_errors(_), do: []

  # A visualization is a document pair: the artifact it launches must exist
  # beside it, so the pair moves together and the launch link cannot dangle.
  defp launch_errors(%{type: @launch_type, launch: launch, path: path}, root) do
    cond do
      launch in [nil, ""] ->
        [
          "#{path}: missing `launch` — a visualization names the sibling .html " <>
            "the reader opens"
        ]

      Path.basename(launch) != launch ->
        [
          "#{path}: launch #{inspect(launch)} is not a bare filename — the " <>
            "artifact is a sibling, not a path or URL"
        ]

      Path.extname(launch) != ".html" ->
        ["#{path}: launch #{inspect(launch)} is not a .html file"]

      not File.regular?(Path.join([root, Path.dirname(path), launch])) ->
        ["#{path}: launch #{inspect(launch)} does not exist beside it"]

      true ->
        []
    end
  end

  # Nothing but a visualization has an artifact to launch.
  defp launch_errors(%{launch: launch, type: type, path: path}, _root)
       when not is_nil(launch) do
    [
      "#{path}: `launch` on type #{inspect(type)} — only a visualization " <>
        "launches an artifact; omit the field"
    ]
  end

  defp launch_errors(_, _), do: []
end
