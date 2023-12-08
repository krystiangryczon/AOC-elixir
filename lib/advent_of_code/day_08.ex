defmodule AdventOfCode.Day08 do
  alias Advent.D08
  alias Advent.D08_02

  def part1(inp) do
    parsed = inp |> D08.parse_input()
    D08.find_next("AAA", parsed[:instructions], parsed[:nodes], 0, parsed[:instructions], "ZZZ")
  end

  def part2(inp) do
    parsed = inp |> D08.parse_input()

    start_points =
      parsed[:nodes]
      |> Enum.map(fn el -> el[:key] end)
      |> Enum.filter(fn el -> String.ends_with?(el, "A") end)
      |> Enum.map(fn startp ->
        D08_02.find_next(
          startp,
          parsed[:instructions],
          parsed[:nodes],
          0,
          parsed[:instructions],
          "Z"
        )
      end)
      |> D08_02.calculate_lcm()
  end
end
