defmodule Advent.Code1_2 do
  def is_num(x) do
    case Integer.parse(x, 10) do
      {num, _} -> num
      :error -> false
    end
  end

  def combine(str) do
    Integer.to_string(digit_from_left(str)) <> Integer.to_string(digit_from_right(str))
  end

  def get_digits,
    do: [
      {1, "one"},
      {2, "two"},
      {3, "three"},
      {4, "four"},
      {5, "five"},
      {6, "six"},
      {7, "seven"},
      {8, "eight"},
      {9, "nine"}
    ]

  def digit_from_left(str) do
    {n, num_text} =
      Enum.map(get_digits(), fn {k, v} ->
        case :binary.match(str, v) do
          {i, _} -> {i, k}
          :nomatch -> false
        end
      end)
      |> Enum.filter(fn el -> el != false end)
      |> Enum.min(fn -> {String.length(str), 0} end)

    from_start_to_smallest = String.slice(str, 0..(n + 1))

    digit =
      String.graphemes(from_start_to_smallest)
      |> Enum.map(fn x -> is_num(x) end)
      |> Enum.filter(fn x -> x != false end)

    cond do
      length(digit) > 0 -> hd(digit)
      length(digit) == 0 -> num_text
    end
  end

  def digit_from_right(str) do
    {n, num_text} =
      Enum.map(get_digits(), fn {k, v} ->
        case :binary.matches(str, v) do
          [] -> false
          :nomatch -> false
          x -> {hd(Tuple.to_list(hd(Enum.reverse(x)))), k}
        end
      end)
      |> Enum.filter(fn el -> el != false end)
      |> Enum.max(fn -> {0, 0} end)

    from_biggest_to_end = String.slice(str, n..(String.length(str) + 1))

    digit =
      String.graphemes(from_biggest_to_end)
      |> Enum.map(fn x -> is_num(x) end)
      |> Enum.filter(fn x -> x != false end)

    cond do
      length(digit) > 0 -> List.last(digit)
      length(digit) == 0 -> num_text
    end
  end

  def sum_list(str_list) do
    Enum.reduce([0 | str_list], fn el, acc ->
      acc + is_num(combine(el))
    end)
  end
end
