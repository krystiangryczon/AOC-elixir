defmodule AdventOfCode.Day10Test do
  use ExUnit.Case

  import AdventOfCode.Day10

  def test_input1,
    do: """
    ..F7.
    .FJ|.
    SJ.L7
    |F--J
    LJ...
    """

  test "part1" do
    input = test_input1()
    result = part1(input)

    assert result == 8
  end

  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result
  end
end
