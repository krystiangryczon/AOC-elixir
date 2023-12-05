defmodule My.Utils do
  def read_txt_file(path) do
    {:ok, content} = File.read(path)
    content |> String.split("\r\n", trim: true)
  end

  def split_file(file, on \\ "\n") do
    file |> String.split(on, trim: true)
  end

  def string_to_num_or_false(x) do
    case Integer.parse(x, 10) do
      {num, _} -> num
      :error -> false
    end
  end
end
