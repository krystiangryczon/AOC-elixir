defmodule Advent.Code2_2 do
  def get_max_balls(game, color) do
    [_, data] = String.split(game, ":")
    draws = String.split(data, ";")

    draws
    |> Enum.map(fn draw -> Regex.run(~r/\d+ #{color}/, draw) end)
    |> Enum.filter(fn el -> el != nil end)
    |> Enum.flat_map(fn el -> el end)
    |> Enum.map(fn el ->
      [num, _] = String.split(el)
      {result, _} = Integer.parse(num, 10)
      result
    end)
    |> Enum.max()
  end

  def extract_id(game) do
    [game_id] = String.split(game, ":")
    [_, id] = String.split(game_id, " ")
    {result, _} = Integer.parse(id)
    result
  end

  def sum(str_list) do
    Enum.reduce(str_list, 0, fn el, acc ->
      acc +
        get_max_balls(el, "red") * get_max_balls(el, "green") *
          get_max_balls(el, "blue")
    end)
  end
end
