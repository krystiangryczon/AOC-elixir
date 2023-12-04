defmodule Advent.Code4_2 do
  def find_winning_cards_count([], _current), do: 0
  def find_winning_cards_count(_list, nil), do: 0

  def find_winning_cards_count(list, curr_el) do
    Enum.slice(list, (curr_el[:id] + 1)..(curr_el[:id] + curr_el[:wins]))
    |> Enum.reduce(1, fn el, ac -> ac + find_winning_cards_count(list, el) end)
  end

  def execute(inp) do
    parsed =
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
      |> Enum.with_index()
      |> Enum.map(fn {el, idx} -> %{id: idx, wins: MapSet.size(el)} end)

    parsed
    |> Enum.reduce(0, fn el, acc -> acc + find_winning_cards_count(parsed, el) end)
  end
end
