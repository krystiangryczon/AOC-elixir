defmodule Advent.Code3_1 do
  defp at(input, pos) do
    case input do
      nil -> nil
      _ -> input |> Enum.at(pos)
    end
  end

  defp is_num(str) do
    cond do
      str == nil ->
        false

      true ->
        case Integer.parse(str, 10) do
          {num, _} -> num
          :error -> false
        end
    end
  end

  def is_valid_symbol(str) do
    case str do
      nil ->
        false

      _ ->
        cond do
          String.match?(str, ~r/[\d\.]/) -> false
          true -> true
        end
    end
  end

  defp conv_to_map(inp) do
    My.Utils.split_file(inp, "\n")
    |> Enum.map(fn el -> String.graphemes(el) end)
  end

  def check_around(inp, curr, i, j, _visited) do
    valid_around =
      is_valid_symbol(inp |> at(i - 1) |> at(j - 1)) ||
        is_valid_symbol(inp |> at(i - 1) |> at(j)) ||
        is_valid_symbol(inp |> at(i - 1) |> at(j + 1)) ||
        is_valid_symbol(inp |> at(i + 1) |> at(j - 1)) ||
        is_valid_symbol(inp |> at(i + 1) |> at(j)) ||
        is_valid_symbol(inp |> at(i + 1) |> at(j + 1)) ||
        is_valid_symbol(inp |> at(i) |> at(j - 1)) ||
        is_valid_symbol(inp |> at(i) |> at(j + 1))

    if(valid_around) do
      {true, curr}
    else
      {false, curr}
    end
  end

  def execute(input) do
    inp = conv_to_map(input)
    row_len = length(inp |> at(0)) - 1
    col_len = length(inp) - 1

    out =
      for i <- 0..col_len do
        for j <- 0..row_len do
          curr = inp |> at(i) |> at(j)

          cond do
            is_num(curr) ->
              check_around(inp, inp |> at(i) |> at(j), i, j, [{i, j, curr}])

            is_valid_symbol(curr) ->
              curr

            true ->
              curr
          end
        end
      end

    out
    |> Enum.map(fn el ->
      el |> Enum.chunk_by(&is_binary(&1))
    end)
    |> Enum.flat_map(fn el -> el end)
    |> Enum.filter(fn el -> !is_binary(List.first(el)) end)
    |> Enum.filter(fn sublist -> Enum.any?(sublist, fn {k, _v} -> k == true end) end)
    |> Enum.map(fn sublist ->
      Enum.reduce(sublist, "", fn {_k, v}, acc -> acc <> v end)
    end)
    |> Enum.reduce(0, fn e, acc -> acc + is_num(e) end)
  end
end
