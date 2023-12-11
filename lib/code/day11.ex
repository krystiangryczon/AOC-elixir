defmodule Advent.D11_1 do
  defp find(a, _, _, result) when a == [], do: result

  defp find([head | tail], [{value, index} | rest], here, result) when here == index,
    do: find(tail, rest, index + 1, [head, value | result])

  defp find([head | tail], inserts, index, result),
    do: find(tail, inserts, index + 1, [head | result])

  defp expand_galaxy_row(universe) do
    indexes_of_empty_rows =
      universe
      |> Enum.with_index()
      |> Enum.filter(fn {el, _idx} -> Enum.all?(String.graphemes(el), fn el -> el == "." end) end)

    Enum.reverse(find(universe, indexes_of_empty_rows, 0, []))
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
    |> transpose()
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

  defp find_shortest(from, to) do
    {fx, fy} = from
    {tx, ty} = to
    abs(tx - fx) + abs(ty - fy)
  end

  defp sum_distances([], _), do: 0
  defp sum_distances([_], _), do: 0

  defp sum_distances([coord | tail], coords) do
    distances = Enum.map(tail, fn c -> find_shortest(coord, c) end)
    sum_distances(tail, coords) + Enum.sum(distances)
  end

  defp possible_connections(galactics) do
    [head | rest] = galactics

    if(length(rest) > 1) do
      [{head, rest}, possible_connections(rest)]
    else
      [{head, rest}]
    end
  end

  def find_sum_of_paths(inp) do
    map_of_galaxies =
      inp
      |> expand_galaxy_row()
      |> expand_galaxy_col()
      |> Enum.map(&String.graphemes/1)
      |> find_galaxies()
      |> Enum.map(fn galaxy ->
        {galaxy[:x], galaxy[:y]}
      end)

    sum_distances(map_of_galaxies, map_of_galaxies)
  end
end
