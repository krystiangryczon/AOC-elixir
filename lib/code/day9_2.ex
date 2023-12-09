defmodule Advent.D09_02 do
  defp calc_next([], next), do: next

  defp calc_next(curr, next) do
    if(length(curr) > 1) do
      [h | t] = curr
      [h2 | _] = t
      calc_next(t, [h2 - h | next])
    else
      next
    end
  end

  def extrapolate(line, res) do
    if(Enum.all?(line, fn el -> el == 0 end)) do
      res
    else
      next = Enum.reverse(calc_next(line, []))
      extrapolate(next, [List.first(next)] ++ res)
    end
  end

  def get_left_val([], acc), do: acc

  def get_left_val(vals, acc) do
    if(length(vals) > 0) do
      [f | values] = vals
      get_left_val(values, f - acc)
    else
      acc
    end
  end
end
