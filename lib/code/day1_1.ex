defmodule Advent.Code1_1 do
  def is_num(x) do
    case Integer.parse(x, 10) do
      {num, _} -> num
      :error -> false
    end
  end

  @spec get_left(str: String.t()) :: integer()
  def get_left(""), do: 0

  def get_left(str) do
    if String.length(str) > 0 do
      [h | t] = String.split(str, "", trim: true)

      if !!is_num(h) do
        is_num(h)
      else
        get_left(Enum.join(t))
      end
    end
  end

  def get_right(str) do
    get_left(String.reverse(str))
  end

  def sum(str) do
    Integer.to_string(get_left(str)) <> Integer.to_string(get_right(str))
  end

  def sum_list(str_list) do
    Enum.reduce([0 | str_list], fn el, acc -> acc + is_num(sum(el)) end)
  end
end
