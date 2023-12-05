defmodule Advent.Code5_1 do
  defp parse_line(str) do
    Enum.map(str, fn el ->
      String.split(el, " ", trim: true)
      |> Enum.map(fn el -> String.to_integer(el) end)
    end)
  end

  defp get_next_index(seed, parsed, step) do
    find_range_list(seed, Enum.at(parsed, step)[:rest])
    |> find_next_el(seed)
  end

  defp is_in_range(seed, list) do
    [_, src, range] = list
    seed >= src && seed < src + range
  end

  defp find_range_list(seed, guide) do
    guide
    |> Enum.map(fn g ->
      case is_in_range(seed, g) do
        true -> g
        _ -> nil
      end
    end)
    |> Enum.filter(fn el -> el end)
    |> Enum.flat_map(fn el -> el end)
  end

  defp find_next_el([], seed), do: seed

  defp find_next_el(list, seed) do
    [dest, src, _] = list
    dest + seed - src
  end

  defp go_through_process(seed, parsed) do
    seed
    |> get_next_index(parsed, 0)
    |> get_next_index(parsed, 1)
    |> get_next_index(parsed, 2)
    |> get_next_index(parsed, 3)
    |> get_next_index(parsed, 4)
    |> get_next_index(parsed, 5)
    |> get_next_index(parsed, 6)
  end

  def execute(inp, separator) do
    [seeds_raw | rest] =
      String.split(inp, separator <> separator, trim: true)

    parsed =
      rest
      |> Enum.map(fn el -> String.split(el, separator, trim: true) end)
      |> Enum.map(fn [h | t] ->
        [from, _, to, _] = String.split(h, ~r/[- ]/, trim: true)

        range_map =
          parse_line(t)

        %{
          from: from,
          to: to,
          rest: range_map
        }
      end)

    seeds =
      String.split(String.trim(seeds_raw), "seeds:", trim: true)
      |> hd()

    String.split(seeds, " ", trim: true)
    |> Enum.map(fn el -> go_through_process(String.to_integer(el), parsed) end)
    |> Enum.min()
  end
end
