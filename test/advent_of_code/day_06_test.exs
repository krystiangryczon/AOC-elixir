defmodule AdventOfCode.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Day06

  def test_input1(),
    do: """
    Time:      7  15   30
    Distance:  9  40  200
    """

  test "part1" do
    input = test_input1()
    result = part1(input)

    assert result == 288
  end

  def test_input2(),
    do: """
    Time:      71530
    Distance:  940200
    """

  test "part2" do
    input = test_input2()
    result = part2(input)

    assert result == 71503
  end
end
