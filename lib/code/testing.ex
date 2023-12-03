defmodule Advent.Parser do
  import NimbleParsec

  # date =
  #   integer(4)
  #   |> ignore(string("-"))
  #   |> integer(2)
  #   |> ignore(string("-"))
  #   |> integer(2)

  # time =
  #   integer(2)
  #   |> ignore(string(":"))
  #   |> integer(2)
  #   |> ignore(string(":"))
  #   |> integer(2)
  #   |> optional(string("Z"))

  tester =
    integer(2)
    |> optional(string("kk"))
    |> string("cock")

  defparsec(:tester, tester, debug: true)
end

# Advent.Parser.datetime("2010-04-17T14:12:34Z")
# => {:ok, [2010, 4, 17, 14, 12, 34, "Z"], "", %{}, {1, 0}, 20}
