defmodule Advent.Code2_1 do
  def conditions(),
    do: %{
      red: 12,
      green: 13,
      blue: 14
    }

  @spec is_possible(String.t(), String.t(), any()) :: integer()
  def is_possible(game, color, color_symbol) do
    [_, data] = String.split(game, ":")
    draws = String.split(data, ";")

    possible =
      draws
      |> Enum.map(fn draw -> Regex.run(~r/\d+ #{color}/, draw) end)
      |> Enum.filter(fn el -> el != nil end)
      |> Enum.flat_map(fn el -> el end)
      |> Enum.map(fn el ->
        case String.split(el, " ", parts: 2) do
          [num, _] ->
            {_, maximum} = Map.fetch(conditions(), color_symbol)
            {real_num, _} = Integer.parse(num)

            if(maximum >= real_num) do
              true
            else
              false
            end

          [] ->
            false
        end
      end)
      |> Enum.filter(fn el -> el != true end)
      |> length() == 0

    if(possible) do
      1
    else
      0
    end
  end

  def extract_id(game) do
    [game_id, _] = String.split(game, ":")
    [_, id] = String.split(game_id, " ")
    {result, _} = Integer.parse(id)
    result
  end

  def sum(str_list) do
    Enum.reduce(str_list, 0, fn el, acc ->
      acc +
        case is_possible(el, "red", :red) + is_possible(el, "green", :green) +
               is_possible(el, "blue", :blue) do
          3 ->
            extract_id(el)

          _ ->
            0
        end
    end)
  end
end
