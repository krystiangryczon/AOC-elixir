defmodule Advent.Code6_1 do
  @sep "\n"
  defp parse_input(inp, sep) do
    [time, distance] =
      String.split(inp, sep, trim: true)
      |> Enum.map(fn el -> String.split(el, ~r/[(Time:)(Distance:)]/) end)
      |> Enum.map(fn sublist -> Enum.filter(sublist, fn el -> String.length(el) != 0 end) end)
      |> Enum.map(fn sublist ->
        Enum.map(sublist, fn el -> String.split(el, " ", trim: true) end)
      end)
      |> Enum.flat_map(fn el -> el end)
      |> Enum.map(fn sublist ->
        Enum.map(sublist, fn el -> My.Utils.string_to_num_or_false(el) end) |> Enum.with_index()
      end)

    time
    |> Enum.map(fn {t_el, idx} ->
      {d_el, idx} = Enum.at(distance, idx)
      %{time: t_el, distance: d_el, idx: idx}
    end)
  end

  defp calculate(row) do
    Enum.to_list(0..row[:time])
    |> Enum.filter(fn el -> el * (row[:time] - el) > row[:distance] end)
    |> Enum.count()
  end

  def execute(inp) do
    parse_input(inp, @sep)
    |> Enum.map(fn el -> calculate(el) end)
    |> Enum.reduce(fn el, acc -> acc * el end)
  end
end
