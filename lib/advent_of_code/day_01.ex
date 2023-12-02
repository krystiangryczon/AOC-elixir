defmodule AdventOfCode.Day01 do
  def part1(input) do
    Advent.Code1_1.sum_list(My.Utils.split_file(input))
  end

  def part2(input) do
    Advent.Code1_2.sum_list(My.Utils.split_file(input))
  end
end
