defmodule My.Utils do
  def read_txt_file(path) do
    {:ok, content} = File.read(path)
    content |> String.split("\r\n", trim: true)
  end

  def split_file(file) do
    file |> String.split("\n", trim: true)
  end
end
