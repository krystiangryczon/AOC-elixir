defmodule AdventOfCode.Day03Test do
  use ExUnit.Case

  import AdventOfCode.Day03

  defp test_input1,
    do: """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """

  test "part1" do
    input = test_input1()
    result = part1(input)

    assert result == 4361
  end

  defp test_input2,
    do: """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """

  @tag :skip
  test "part2" do
    input = test_input2()
    result = part2(input)

    assert result == 467_835
  end
end
