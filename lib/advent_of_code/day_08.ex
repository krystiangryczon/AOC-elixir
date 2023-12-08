defmodule AdventOfCode.Day08 do
  alias Advent.D08

  def part1(inp) do
    parsed = inp |> D08.parse_input()
    D08.find_next("AAA", parsed[:instructions], parsed[:nodes], 0, parsed[:instructions])
  end

  def part2(_args) do
  end
end
