defmodule AdventOfCode.Day09 do
  alias Advent.D09_01
  alias Advent.D09_02

  def part1(inp) do
    D09_01.parse_input(inp)
    |> Enum.reduce(0, fn el, acc -> acc + (List.last(el) + D09_01.extrapolate(el, 0)) end)
  end

  def part2(inp) do
    D09_01.parse_input(inp)
    |> Enum.reduce(0, fn el, acc ->
      acc + (List.first(el) - D09_02.get_left_val(D09_02.extrapolate(el, []), 0))
    end)
  end
end
