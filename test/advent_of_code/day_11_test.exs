defmodule AdventOfCode.Day11Test do
  use ExUnit.Case

  import AdventOfCode.Day11

  def test_input,
    do: """
    ...#......
    .......#..
    #.........
    ..........
    ......#...
    .#........
    .........#
    ..........
    .......#..
    #...#.....
    """

  test "part1" do
    input = test_input()
    result = part1(input)

    assert result == 374
  end

  test "part2" do
    input = test_input()
    result = part2(input)

    assert result == 82_000_210
  end
end
