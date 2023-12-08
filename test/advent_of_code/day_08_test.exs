defmodule AdventOfCode.Day08Test do
  use ExUnit.Case

  import AdventOfCode.Day08

  defp test_input(),
    do: """
    RL

    AAA = (BBB, CCC)
    BBB = (DDD, EEE)
    CCC = (ZZZ, GGG)
    DDD = (DDD, DDD)
    EEE = (EEE, EEE)
    GGG = (GGG, GGG)
    ZZZ = (ZZZ, ZZZ)
    """

  defp test_input1(),
    do: """
    LLR

    AAA = (BBB, BBB)
    BBB = (AAA, ZZZ)
    ZZZ = (ZZZ, ZZZ)
    """

  # @tag :skip
  test "part1" do
    input = test_input()
    result = part1(input)

    assert result == 2
  end

  test "part1.2" do
    input = test_input1()
    result = part1(input)

    assert result == 6
  end

  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result == 6
  end
end
