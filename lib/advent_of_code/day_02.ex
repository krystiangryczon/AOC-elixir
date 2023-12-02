defmodule AdventOfCode.Day02 do
  def part1(input) do
    Advent.Code2_1.sum(My.Utils.split_file(input))
  end

  def part2(input) do
    Advent.Code2_2.sum(My.Utils.split_file(input))
  end
end
