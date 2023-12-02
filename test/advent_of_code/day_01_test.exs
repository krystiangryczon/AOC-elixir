defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  defp test_case1,
    do: """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """

  test "part1" do
    input = test_case1()
    result = part1(input)

    assert result == 142
  end

  defp test_case2,
    do: """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """

  test "part2" do
    input = test_case2()
    result = part2(input)

    assert result == 281
  end
end
