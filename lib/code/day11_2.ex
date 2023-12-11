defmodule Advent.D11_2 do
  defp find(a, _, _, result) when a == [], do: result

  defp find([head | tail], [{value, index} | rest], here, result) when here == index,
    do: find(tail, rest, index + 1, [head, value | result])

  defp find([head | tail], inserts, index, result),
    do: find(tail, inserts, index + 1, [head | result])

  defp expand_galaxy_row(universe) do
    universe
    |> Enum.with_index()
    |> Enum.filter(fn {el, _idx} -> Enum.all?(String.graphemes(el), fn el -> el == "." end) end)
    |> Enum.map(fn {_el, idx} -> idx end)
  end

  defp transpose([head | rest]) when is_list(head) do
    [head | rest]
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  defp transpose([head | rest]) when is_binary(head) do
    [head | rest]
    |> Enum.map(&String.graphemes/1)
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(fn el -> Enum.join(el, "") end)
  end

  defp expand_galaxy_col(universe) do
    universe
    |> transpose()
    |> expand_galaxy_row()
  end

  defp find_galaxies(universe) do
    universe
    |> Enum.with_index()
    |> Enum.map(fn {sublist, id_row} -> {Enum.with_index(sublist), id_row} end)
    |> Enum.map(fn {sublist, id_row} ->
      Enum.map(sublist, fn {el, id_col} -> %{el: el, x: id_row, y: id_col} end)
    end)
    |> Enum.flat_map(fn el -> el end)
    |> Enum.filter(fn el -> el[:el] == "#" end)
  end

  def count_between(v1, v2, empty_rows) do
    [min, max] = Enum.sort([v1, v2])
    length(Enum.filter(empty_rows, fn el -> el > min && el < max end))
  end

  @multi 1_000_000

  defp find_shortest(from, to, empty_rows, empty_cols) do
    {fx, fy} = from
    {tx, ty} = to
    c_col = count_between(fy, ty, empty_cols)
    c_row = count_between(fx, tx, empty_rows)
    abs(tx - fx) + abs(ty - fy) + @multi * (c_col + c_row) - (c_col + c_row)
  end

  defp sum_distances([], _, _, _), do: 0
  defp sum_distances([_], _, _, _), do: 0

  defp sum_distances([coord | tail], coords, empty_rows, empty_cols) do
    distances = Enum.map(tail, fn c -> find_shortest(coord, c, empty_rows, empty_cols) end)
    sum_distances(tail, coords, empty_rows, empty_cols) + Enum.sum(distances)
  end

  def find_sum_of_paths(inp) do
    empty_rows =
      inp
      |> expand_galaxy_row()

    empty_cols =
      inp
      |> expand_galaxy_col()

    map_of_galaxies =
      inp
      |> Enum.map(&String.graphemes/1)
      |> find_galaxies()
      |> Enum.map(fn galaxy ->
        {galaxy[:x], galaxy[:y]}
      end)

    sum_distances(map_of_galaxies, map_of_galaxies, empty_rows, empty_cols)
  end
end
