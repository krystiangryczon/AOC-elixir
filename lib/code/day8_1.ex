defmodule Advent.D08 do
  defp parse_line(line) do
    [key, left, right] =
      line |> String.split(~r/[\s=\(\),]/) |> Enum.filter(fn el -> String.length(el) > 0 end)

    %{key: key, left: left, right: right}
  end

  @sep "\n"
  def parse_input(inp) do
    [instructions | nodes] =
      inp |> String.split(@sep) |> Enum.filter(fn el -> String.length(el) > 0 end)

    parsed_nodes = nodes |> Enum.map(fn el -> parse_line(el) end)
    %{instructions: String.graphemes(instructions), nodes: parsed_nodes}
  end

  def find_next(current_key, [], nodes, steps, og_instr),
    do: find_next(current_key, og_instr, nodes, steps, og_instr)

  def find_next("ZZZ", _instructions, _nodes, steps, _og_instr), do: steps

  def find_next(current_key, instructions, nodes, steps, og_instr) do
    [dir | rest_instr] = instructions

    cond do
      dir == "L" ->
        find_next(
          Enum.find(nodes, fn n -> n[:key] == current_key end)[:left],
          rest_instr,
          nodes,
          steps + 1,
          og_instr
        )

      dir == "R" ->
        find_next(
          Enum.find(nodes, fn n -> n[:key] == current_key end)[:right],
          rest_instr,
          nodes,
          steps + 1,
          og_instr
        )

      true ->
        IO.inspect(nodes)
    end
  end
end
