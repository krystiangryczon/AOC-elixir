defmodule Advent.D09_01 do
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

  @sep "\n"
  def parse_input(inp) do
    inp
    |> String.split(@sep, trim: true)
    |> Enum.map(fn sublist ->
      Enum.map(String.split(sublist, " ", trim: true), fn el ->
        My.Utils.string_to_num_or_false(el)
      end)
    end)
  end
end
