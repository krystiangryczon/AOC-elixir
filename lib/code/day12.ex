defmodule Advent.D12 do
  def produce_possibilities(list, acc) do
    first = Enum.find_index(list, fn el -> el == "?" end)

    if(Enum.any?(list, fn el -> el == "?" end)) do
      relpaced_with_hash = List.replace_at(list, first, "#")
      relpaced_with_dot = List.replace_at(list, first, ".")

      new_acc =
        acc ++
          [relpaced_with_hash] ++ [relpaced_with_dot]

      produce_possibilities(relpaced_with_hash, new_acc) ++
        produce_possibilities(relpaced_with_dot, new_acc)
    else
      acc
    end
  end

  def count(spring) do
    String.graphemes(spring[:data])
    |> produce_possibilities([])
    |> Enum.filter(fn el -> !Enum.any?(el, fn i -> i == "?" end) end)
    |> Enum.map(fn el -> Enum.join(el, "") |> String.split(".", trim: true) end)
    |> Enum.map(fn sublist -> Enum.map(sublist, fn i -> String.length(i) end) end)
    |> Enum.filter(fn el -> el === spring[:nums] end)
    |> length()
    |> div(2)
  end

  def parse_input(inp) do
    inp
    |> My.Utils.split_file("\n")
    |> Enum.map(fn el -> My.Utils.split(el) end)
    |> Enum.map(fn [data, nums] ->
      %{
        data: data,
        nums: My.Utils.split(nums, ",") |> Enum.map(&My.Utils.string_to_num_or_false/1)
      }
    end)
  end
end
