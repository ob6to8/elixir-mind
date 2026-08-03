defmodule ElixirMind.Matters do
  @moduledoc """
  Machine checks over the matters layer: the register (`meta/matters.md`) —
  the order-only pointer view whose one authored datum is the global delivery
  order — against the matter docs under `meta/matters/` it points at (see
  the matter-docs plan and the `matter` entry of
  `meta/policy/controlled-type-vocabulary.md`).

  Rules enforced (`run_checks/1`; each is a named check result):

    1. **Register shape** — every table row in the register is a queue row:
       four cells; `#` cells run 1..N contiguously from the top; the Matter
       cell links a `/meta/matters/*.md` doc; the Type cell is `independent`
       or a `[planned](…)` link; the Order cell is `-` or an integer; no doc
       is queued twice.
    2. **Ref resolution and doc shape** — every queue row's doc exists; every
       matter doc parses, is `type: matter`, and carries a `status` in
       open/done/cancelled; `plan`/`order` appear together or not at all,
       with `plan` resolving to an existing doc and `order` a positive
       integer; a `pr` key, when present, is a positive integer.
    3. **Row↔doc agreement** — a queued doc is `status: open`; the row's
       Type cell names exactly the doc's `plan` (`independent` ⇔ no `plan`);
       the Order cell mirrors the doc's `order` (`-` ⇔ absent).
    4. **Plan-order inversion** — the global queue never inverts a plan's
       internal sequence: rows whose docs share a `plan` appear in ascending
       `order`.
    5. **Landing metadata** (warn, never fail) — a `status: done` matter doc
       records the PR that landed it (`pr: <N>`). The `/matter` close flow
       stamps the number at `/create-pull-request` time, after the doc is
       already flipped `done`, so a doc awaiting its stamp is a warning, not
       a failure.

  `queue_positions/1` is the tolerant read of the same register consumed by
  `ElixirMind.SessionInit` — doc path → row position, skipping anything
  malformed. The strictness lives in `run_checks/1`; the digest, like every
  bundle consumer, degrades quietly per OKF conformance.
  """

  alias ElixirMind.Frontmatter

  @register "meta/matters.md"
  @matters_dir "meta/matters"
  @statuses ~w(open done cancelled)

  @link_re ~r/^\[[^\]]+\]\(([^)\s]+)\)$/
  @doc_path_re ~r{^/meta/matters/[^/]+\.md$}

  @type status :: :ok | :warn | :fail
  @type result :: {String.t(), status, String.t()}

  @doc """
  Run all checks against the bundle at `root`. Returns results in check
  order; a missing register file passes every check vacuously (the docs-side
  shape checks still run over whatever is filed).
  """
  @spec run_checks(root :: String.t()) :: [result]
  def run_checks(root \\ File.cwd!()) do
    rows = register_rows(root)
    docs = scan_docs(root)
    by_path = Map.new(docs, &{&1.path, &1})

    [
      check_register_shape(rows),
      check_refs_and_doc_shape(rows, docs, by_path, root),
      check_agreement(rows, by_path),
      check_inversion(rows, by_path),
      check_landing(docs)
    ]
  end

  @doc """
  Doc path (bundle-absolute) → queue position, from the register's rows.
  Tolerant: malformed rows are skipped, and a missing register yields an
  empty map.
  """
  @spec queue_positions(root :: String.t()) :: %{optional(String.t()) => pos_integer()}
  def queue_positions(root \\ File.cwd!()) do
    for %{pos: pos, doc_path: path} <- register_rows(root),
        is_integer(pos) and is_binary(path),
        into: %{},
        do: {path, pos}
  end

  # ---------------------------------------------------------------------
  # Register parsing
  # ---------------------------------------------------------------------

  defp register_rows(root) do
    case File.read(Path.join(root, @register)) do
      {:ok, content} ->
        content
        |> String.split("\n")
        |> Enum.map(&String.trim/1)
        |> Enum.filter(&String.starts_with?(&1, "|"))
        |> Enum.map(&split_cells/1)
        |> Enum.reject(&header_or_separator?/1)
        |> Enum.map(&parse_row/1)

      _ ->
        []
    end
  end

  defp split_cells(line) do
    line
    |> String.trim_leading("|")
    |> String.trim_trailing("|")
    |> String.split("|")
    |> Enum.map(&String.trim/1)
  end

  defp header_or_separator?([]), do: true
  defp header_or_separator?(["#" | _]), do: true
  defp header_or_separator?([first | _]), do: Regex.match?(~r/^:?-+:?$/, first)

  defp parse_row([pos, matter, type, order] = cells) do
    %{
      raw: raw(cells),
      cell_count: 4,
      pos: parse_int(pos),
      doc_path: link_target(matter),
      type: parse_type(type),
      order: parse_order(order)
    }
  end

  defp parse_row(cells) do
    %{
      raw: raw(cells),
      cell_count: length(cells),
      pos: nil,
      doc_path: nil,
      type: :malformed,
      order: :malformed
    }
  end

  defp raw(cells), do: "| " <> Enum.join(cells, " | ") <> " |"

  defp parse_int(cell) do
    case Integer.parse(cell) do
      {n, ""} when n > 0 -> n
      _ -> nil
    end
  end

  defp link_target(cell) do
    case Regex.run(@link_re, cell) do
      [_, target] -> target
      _ -> nil
    end
  end

  defp parse_type("independent"), do: :independent

  defp parse_type(cell) do
    case link_target(cell) do
      nil -> :malformed
      target -> {:planned, target}
    end
  end

  defp parse_order("-"), do: :none

  defp parse_order(cell) do
    case parse_int(cell) do
      nil -> :malformed
      n -> {:ok, n}
    end
  end

  # ---------------------------------------------------------------------
  # Doc scanning
  # ---------------------------------------------------------------------

  # File.ls rather than Path.wildcard: wildcard quietly matches nothing when
  # the root path contains non-latin1 codepoints (a legal root — ExUnit tmp
  # dirs named after unicode test names hit this).
  defp scan_docs(root) do
    dir = Path.join(root, @matters_dir)

    case File.ls(dir) do
      {:ok, names} -> names |> Enum.sort() |> scan_docs(dir, root)
      _ -> []
    end
  end

  defp scan_docs(names, dir, root) do
    names
    |> Enum.filter(&String.ends_with?(&1, ".md"))
    |> Enum.reject(&(&1 in ~w(index.md log.md)))
    |> Enum.map(fn name ->
      abs_path = Path.join(dir, name)
      path = "/" <> Path.relative_to(abs_path, root)

      case File.read!(abs_path) |> Frontmatter.parse() do
        {:ok, %{frontmatter: fm}} ->
          %{
            path: path,
            parsed: true,
            type: fm["type"],
            status: fm["status"],
            plan: fm["plan"],
            order: fm["order"],
            pr: fm["pr"]
          }

        _ ->
          %{path: path, parsed: false, type: nil, status: nil, plan: nil, order: nil, pr: nil}
      end
    end)
  end

  # ---------------------------------------------------------------------
  # Checks
  # ---------------------------------------------------------------------

  defp check_register_shape(rows) do
    dup_errors =
      rows
      |> Enum.map(& &1.doc_path)
      |> Enum.reject(&is_nil/1)
      |> Enum.frequencies()
      |> Enum.filter(fn {_, n} -> n > 1 end)
      |> Enum.map(fn {path, n} -> "#{path} queued #{n} times" end)

    positions = Enum.map(rows, & &1.pos)
    expected = Enum.to_list(1..length(rows)//1)

    contiguity_errors =
      if positions == expected or Enum.any?(positions, &is_nil/1),
        do: [],
        else: ["`#` cells read #{inspect(positions)}, expected #{inspect(expected)}"]

    row_errors = Enum.flat_map(rows, &row_shape_errors/1)

    finish(
      "register shape",
      row_errors ++ contiguity_errors ++ dup_errors,
      "#{length(rows)} queue row(s) well-formed"
    )
  end

  defp row_shape_errors(%{cell_count: n, raw: raw}) when n != 4,
    do: ["#{n} cell(s), expected 4: #{raw}"]

  defp row_shape_errors(row) do
    Enum.reject(
      [
        if(is_nil(row.pos), do: "`#` cell is not a positive integer: #{row.raw}"),
        cond do
          is_nil(row.doc_path) ->
            "Matter cell is not a markdown link: #{row.raw}"

          not Regex.match?(@doc_path_re, row.doc_path) ->
            "Matter link is not a /meta/matters/*.md doc: #{row.doc_path}"

          true ->
            nil
        end,
        if(row.type == :malformed,
          do: "Type cell must be `independent` or a `[planned](…)` link: #{row.raw}"
        ),
        if(row.order == :malformed, do: "Order cell must be `-` or an integer: #{row.raw}")
      ],
      &is_nil/1
    )
  end

  defp check_refs_and_doc_shape(rows, docs, by_path, root) do
    ref_errors =
      for %{doc_path: path} <- rows,
          is_binary(path),
          not Map.has_key?(by_path, path),
          do: "queue row points at a missing doc: #{path}"

    doc_errors = Enum.flat_map(docs, &doc_shape_errors(&1, root))

    finish(
      "ref resolution + doc shape",
      ref_errors ++ doc_errors,
      "#{length(docs)} doc(s) well-formed, all queue refs resolve"
    )
  end

  defp doc_shape_errors(%{parsed: false, path: path}, _root),
    do: ["#{path}: unparseable frontmatter"]

  defp doc_shape_errors(doc, root) do
    Enum.reject(
      [
        if(doc.type != "matter",
          do: "#{doc.path}: type is #{inspect(doc.type)}, expected \"matter\""
        ),
        if(doc.status not in @statuses,
          do:
            "#{doc.path}: status is #{inspect(doc.status)}, expected one of #{Enum.join(@statuses, "/")}"
        ),
        case {doc.plan, doc.order} do
          {nil, nil} ->
            nil

          {nil, _} ->
            "#{doc.path}: `order` without `plan` — the keys appear together or not at all"

          {_, nil} ->
            "#{doc.path}: `plan` without `order` — the keys appear together or not at all"

          {plan, order} ->
            plan_pair_error(doc.path, plan, order, root)
        end,
        if(not is_nil(doc.pr) and not (is_integer(doc.pr) and doc.pr > 0),
          do: "#{doc.path}: `pr` is #{inspect(doc.pr)}, expected a positive integer"
        )
      ],
      &is_nil/1
    )
  end

  defp plan_pair_error(path, plan, order, root) do
    cond do
      not (is_binary(plan) and String.starts_with?(plan, "/")) ->
        "#{path}: `plan` is #{inspect(plan)}, expected a bundle-absolute path"

      not File.exists?(Path.join(root, String.trim_leading(plan, "/"))) ->
        "#{path}: `plan` does not resolve: #{plan}"

      not (is_integer(order) and order > 0) ->
        "#{path}: `order` is #{inspect(order)}, expected a positive integer"

      true ->
        nil
    end
  end

  defp check_agreement(rows, by_path) do
    errors =
      rows
      |> Enum.filter(&(is_binary(&1.doc_path) and Map.has_key?(by_path, &1.doc_path)))
      |> Enum.flat_map(fn row ->
        doc = by_path[row.doc_path]
        if doc.parsed, do: agreement_errors(row, doc), else: []
      end)

    finish("row↔doc agreement", errors, "every queued row matches its doc's status/plan/order")
  end

  defp agreement_errors(row, doc) do
    Enum.reject(
      [
        if(doc.status != "open", do: "#{doc.path}: queued but status is #{inspect(doc.status)}"),
        case {row.type, doc.plan} do
          {:independent, nil} ->
            nil

          {:independent, plan} ->
            "#{doc.path}: row says independent but doc has plan: #{inspect(plan)}"

          {{:planned, target}, nil} ->
            "#{doc.path}: row links plan #{target} but doc has none"

          {{:planned, plan}, plan} ->
            nil

          {{:planned, target}, plan} ->
            "#{doc.path}: row links plan #{target} but doc has #{inspect(plan)}"

          _ ->
            nil
        end,
        case {row.order, doc.order} do
          {:none, nil} -> nil
          {:none, order} -> "#{doc.path}: row Order is `-` but doc has order: #{order}"
          {{:ok, n}, n} -> nil
          {{:ok, n}, order} -> "#{doc.path}: row Order is #{n} but doc has #{inspect(order)}"
          _ -> nil
        end
      ],
      &is_nil/1
    )
  end

  defp check_inversion(rows, by_path) do
    errors =
      rows
      |> Enum.filter(&is_integer(&1.pos))
      |> Enum.sort_by(& &1.pos)
      |> Enum.map(&by_path[&1.doc_path])
      |> Enum.filter(&(&1 != nil and is_binary(&1.plan) and is_integer(&1.order)))
      |> Enum.group_by(& &1.plan)
      |> Enum.flat_map(fn {plan, docs} ->
        docs
        |> Enum.chunk_every(2, 1, :discard)
        |> Enum.filter(fn [a, b] -> a.order >= b.order end)
        |> Enum.map(fn [a, b] ->
          "#{plan}: #{a.path} (order #{a.order}) is queued above #{b.path} (order #{b.order})"
        end)
      end)

    finish("plan-order inversion", errors, "the queue preserves every plan's internal order")
  end

  defp check_landing(docs) do
    missing =
      for %{status: "done", pr: nil, path: path} <- docs,
          do: "#{path}: done without a landing `pr:`"

    case missing do
      [] -> {"landing metadata", :ok, "every done doc records its landing PR"}
      _ -> {"landing metadata", :warn, itemize(missing)}
    end
  end

  defp finish(name, [], ok_detail), do: {name, :ok, ok_detail}
  defp finish(name, errors, _), do: {name, :fail, itemize(errors)}

  defp itemize([error]), do: error
  defp itemize(errors), do: "\n      " <> Enum.join(errors, "\n      ")
end
