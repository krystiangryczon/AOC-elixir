defmodule Advent.Code5_2 do
  def test_input(),
    do: """
    seeds: 79 14 55 13
    
    seed-to-soil map:
    50 98 2
    52 50 48
    
    soil-to-fertilizer map:
    0 15 37
    37 52 2
    39 0 15
    
    fertilizer-to-water map:
    49 53 8
    0 11 42
    42 0 7
    57 7 4
    
    water-to-light map:
    88 18 7
    18 25 70
    
    light-to-temperature map:
    45 77 23
    81 45 19
    68 64 13
    
    temperature-to-humidity map:
    0 69 1
    1 0 69
    
    humidity-to-location map:
    60 56 37
    56 93 4
    """

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

  def list_by_interval(seeds, fr, to) do
    Enum.to_list(
      String.to_integer(Enum.at(seeds, fr))..(String.to_integer(Enum.at(seeds, fr)) +
                                                String.to_integer(Enum.at(seeds, to)))
    )
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
      |> String.split(" ", trim: true)

    p =
      list_by_interval(seeds, 0, 1)

    # ++
    #   list_by_interval(seeds, 2, 3) ++
    #   list_by_interval(seeds, 4, 5) ++
    #   list_by_interval(seeds, 6, 7) ++
    #   list_by_interval(seeds, 8, 9) ++
    #   list_by_interval(seeds, 10, 11) ++
    #   list_by_interval(seeds, 12, 13) ++
    #   list_by_interval(seeds, 14, 15) ++
    #   list_by_interval(seeds, 16, 17) ++
    #   list_by_interval(seeds, 18, 19)
    # Advent.Code5_2.execute AdventOfCode.Input.get!(5), "\n"
    p
    |> Enum.map(fn el -> go_through_process(el, parsed) end)
    |> Enum.min()
  end
end
