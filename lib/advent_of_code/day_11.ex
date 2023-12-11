defmodule AdventOfCode.Day11 do
  alias My.Utils
  alias Advent.D11_1
  alias Advent.D11_2

  def part1(inp) do
    inp
    |> Utils.split_file()
    |> D11_1.find_sum_of_paths()
  end

  def part2(inp) do
    inp
    |> Utils.split_file()
    |> D11_2.find_sum_of_paths()
  end
end
