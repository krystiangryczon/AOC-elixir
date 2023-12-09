defmodule Advent.D09_01 do
  alias My.Utils

  defp calc_next([], next), do: next

  defp calc_next(curr, next) do
    if(length(curr) > 1) do
      [h | t] = curr
      [h2 | _] = t
      calc_next(t, [h - h2 | next])
    else
      next
    end
  end

  def extrapolate(line, acc) do
    if(Enum.all?(line, fn el -> el == 0 end)) do
      acc
    else
      next = calc_next(Enum.reverse(line), [])
      extrapolate(next, acc + List.last(next))
    end
  end

  def parse_input(inp) do
    inp
    |> Utils.split_file()
    |> Enum.map(fn sublist ->
      Enum.map(Utils.split(sublist), fn el ->
        Utils.string_to_num_or_false(el)
      end)
    end)
  end
end
