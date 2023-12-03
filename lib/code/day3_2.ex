defmodule Advent.Code3_2 do
  defp at(input, pos) do
    case input do
      nil -> nil
      _ -> input |> Enum.at(pos)
    end
  end

  defp get_num_or_str(str) do
    cond do
      str == nil ->
        false

      is_tuple(str) ->
        str

      true ->
        case Integer.parse(str, 10) do
          {num, _} -> num
          :error -> str
        end
    end
  end

  defp is_num(str) do
    cond do
      str == nil ->
        false

      true ->
        case Integer.parse(str, 10) do
          {_, _} -> 1
          :error -> 0
        end
    end
  end

  def is_gear(str) do
    case str do
      nil ->
        false

      _ ->
        cond do
          String.match?(str, ~r/[\*]/) -> true
          true -> false
        end
    end
  end

  defp conv_to_map(inp) do
    My.Utils.split_file(inp, "\r\n")
    |> Enum.map(fn el -> String.graphemes(el) end)
  end

  def check_around(inp, curr, i, j, visited) do
    current = inp |> at(i) |> at(j)

    valid_around =
      is_num(inp |> at(i - 1) |> at(j - 1)) +
        is_num(inp |> at(i - 1) |> at(j)) +
        is_num(inp |> at(i - 1) |> at(j + 1)) +
        is_num(inp |> at(i + 1) |> at(j - 1)) +
        is_num(inp |> at(i + 1) |> at(j)) +
        is_num(inp |> at(i + 1) |> at(j + 1)) +
        is_num(inp |> at(i) |> at(j - 1)) +
        is_num(inp |> at(i) |> at(j + 1))

    if(valid_around) do
      {"*", valid_around}
    else
      {false, curr}
    end
  end

  def test_input,
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

  def execute(input) do
    inp = conv_to_map(input)
    row_len = length(inp |> at(0)) - 1
    col_len = length(inp) - 1

    visited = []

    out =
      for i <- 0..col_len do
        for j <- 0..row_len do
          curr = inp |> at(i) |> at(j)

          cond do
            is_gear(curr) ->
              check_around(inp, inp |> at(i) |> at(j), i, j, [{i, j, curr}])

            is_gear(curr) ->
              curr

            true ->
              curr
          end
        end
      end

    out
    |> Enum.map(fn sublist -> Enum.map(sublist, fn el -> get_num_or_str(el) end) end)
    |> Enum.map(fn el ->
      el |> Enum.chunk_by(&is_binary(&1))
    end)

    # |> Enum.flat_map(fn el -> el end)
    # |> Enum.filter(fn el -> !is_binary(List.first(el)) end)
    # |> Enum.filter(fn sublist -> Enum.any?(sublist, fn {k, _v} -> k == true end) end)
    # |> Enum.map(fn sublist ->
    #   Enum.reduce(sublist, "", fn {_k, v}, acc -> acc <> v end)
    # end)
    # |> Enum.reduce(0, fn e, acc -> acc + is_num(e) end)
  end
end
