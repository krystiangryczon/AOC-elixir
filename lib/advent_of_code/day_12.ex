defmodule AdventOfCode.Day12 do
  alias Advent.D12

  def part1(inp) do
    D12.parse_input(inp)
    |> Enum.map(&D12.count/1)
    |> Enum.reduce(0, fn el, acc -> acc + el end)
  end

  def part2(_args) do
  end
end
