defmodule AdventOfCode.Day07Test do
  use ExUnit.Case

  import AdventOfCode.Day07

  defp test_inp,
    do: """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    """

  # @tag :skip
  test "part1" do
    input = test_inp()
    result = part1(input)

    assert result == 6440
  end

  test "part2" do
    input = test_inp()
    result = part2(input)

    assert result == 5905
  end
end
