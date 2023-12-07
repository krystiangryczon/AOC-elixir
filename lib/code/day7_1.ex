defmodule Advent.Code7_1 do
  @sep "\n"

  def value_sort(char) do
    order = %{
      "A" => 13,
      "K" => 12,
      "Q" => 11,
      "J" => 10,
      "T" => 9,
      "9" => 8,
      "8" => 7,
      "7" => 6,
      "6" => 5,
      "5" => 4,
      "4" => 3,
      "3" => 2,
      "2" => 1
    }

    Map.get(order, char, :infinity)
  end

  defp get_hand_strength(hand) do
    # the bigger number the stronger hand
    splitted = Enum.sort(Enum.frequencies(String.graphemes(hand)))

    cond do
      # five of a kind
      Enum.any?(splitted, fn {_, count} -> count == 5 end) -> 10006
      # four of a kind
      Enum.any?(splitted, fn {_, count} -> count == 4 end) -> 10005
      # full house
      Enum.any?(splitted, fn {_, count} -> count == 3 end) && length(splitted) == 2 -> 10004
      # 3 of a kind
      Enum.any?(splitted, fn {_, count} -> count == 3 end) && length(splitted) == 3 -> 10003
      # 2 pairs
      Enum.any?(splitted, fn {_, count} -> count == 2 end) && length(splitted) == 3 -> 10002
      # 1 pair
      Enum.any?(splitted, fn {_, count} -> count == 2 end) && length(splitted) == 4 -> 10001
      # high card
      Enum.all?(splitted, fn {_, count} -> count < 2 end) -> 10000
      true -> IO.inspect(splitted)
    end
  end

  def judge_hand(play) do
    Map.merge(play, %{str: get_hand_strength(play[:hand])})
  end

  def execute(inp) do
    inp
    |> String.split(@sep, trim: true)
    |> Enum.map(fn el ->
      [hand, bid] = String.split(el, " ", trim: true)

      %{
        hand: hand,
        bid: bid
      }
    end)
    |> Enum.map(fn play -> judge_hand(play) end)
    |> Enum.sort_by(
      fn el -> [el[:str] | String.graphemes(el[:hand]) |> Enum.map(&value_sort/1)] end,
      &>/2
    )
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {el, idx}, acc ->
      acc + (idx + 1) * My.Utils.string_to_num_or_false(el[:bid])
    end)
  end
end
