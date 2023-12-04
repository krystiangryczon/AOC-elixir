defmodule Advent.Code4_1 do
  def execute(inp) do
    inp
    |> Enum.map(fn el ->
      [_, data] = String.split(el, ": ", trim: true)
      data
    end)
    |> Enum.map(fn el -> String.split(el, " | ", trim: true) end)
    |> Enum.map(fn sublist ->
      Enum.map(sublist, fn e -> String.split(e, " ", trim: true) end)
    end)
    |> Enum.map(fn [el, mn] -> %{winning: el, my: mn} end)
    |> Enum.map(fn row ->
      w = MapSet.new(row[:winning])
      m = MapSet.new(row[:my])

      MapSet.intersection(w, m)
    end)
    |> Enum.map(fn el -> length(MapSet.to_list(el)) end)
    |> Enum.filter(fn el -> el != 0 end)
    |> Enum.reduce(0, fn el, acc -> (acc + :math.pow(2, el - 1)) |> round end)
    |> dbg()
  end
end
