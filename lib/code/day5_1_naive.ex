defmodule Advent.Code5_1_N do
  @seeds "79 14 55 13"
  @sep "\r\n"

  defp test_inp,
    do: """
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

  defp find_next_step(seed, guide) do
    possible_idx =
      case Enum.find(guide[:rest][:src], fn entry -> entry[:el] == seed end) do
        nil -> nil
        %{el: _el, idx: idx} -> idx
        _ -> {:error, "something wrong - src"}
      end

    if(possible_idx) do
      case Enum.find(guide[:rest][:dest], fn entry -> entry[:idx] == possible_idx end) do
        nil -> possible_idx
        %{el: el, idx: _idx} -> el
        _ -> {:error, "something wrong - dest"}
      end
    else
      seed
    end
  end

  defp parse_line(str) do
    Enum.map(str, fn el ->
      String.split(el, " ", trim: true)
      |> Enum.map(fn el -> String.to_integer(el) end)
    end)
  end

  defp calculate_ranges(list) when is_list(list) do
    [d, s, r] = list

    %{
      dest: Enum.to_list(d..(d + r - 1)),
      src: Enum.to_list(s..(s + r - 1))
    }
  end

  defp go_through_process(seed, parsed) do
    seed
    |> find_next_step(Enum.at(parsed, 0))
    |> find_next_step(Enum.at(parsed, 1))
    |> find_next_step(Enum.at(parsed, 2))
    |> find_next_step(Enum.at(parsed, 3))
    |> find_next_step(Enum.at(parsed, 4))
    |> find_next_step(Enum.at(parsed, 5))
    |> find_next_step(Enum.at(parsed, 6))
  end

  def inp_parser do
    parsed =
      String.split(test_inp(), @sep <> @sep, trim: true)
      |> Enum.map(fn el -> String.split(el, @sep, trim: true) end)
      |> Enum.map(fn [h | t] ->
        [from, _, to, _] = String.split(h, ~r/[- ]/, trim: true)

        range_map =
          parse_line(t)
          |> Enum.map(fn el -> calculate_ranges(el) end)
          |> Enum.reduce(fn el, acc ->
            %{dest: acc[:dest] ++ el[:dest], src: acc[:src] ++ el[:src]}
          end)

        %{
          from: from,
          to: to,
          rest: %{
            dest:
              range_map[:dest]
              |> Enum.with_index()
              |> Enum.map(fn {el, idx} -> %{el: el, idx: idx} end),
            src:
              range_map[:src]
              |> Enum.with_index()
              |> Enum.map(fn {el, idx} -> %{el: el, idx: idx} end)
          }
        }
      end)

    String.split(@seeds, " ", trim: true)
    |> Enum.map(fn el -> go_through_process(String.to_integer(el), parsed) end)
    |> Enum.min()
  end
end
