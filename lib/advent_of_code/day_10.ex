defmodule AdventOfCode.Day10 do
  alias My.Utils
  alias Advent.D10

  def part1(inp) do
    inp
    |> Utils.split_file()
    |> Enum.map(fn el -> Utils.split(el, "") end)
    |> D10.execute()
  end

  def part2(_args) do
  end
end
