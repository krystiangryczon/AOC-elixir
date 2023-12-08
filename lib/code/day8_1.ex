defmodule Advent.D08_01 do
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

  def find_next(current_key, [], nodes, steps, og_instr, goal),
    do: find_next(current_key, og_instr, nodes, steps, og_instr, goal)

  def find_next(current_key, _instructions, _nodes, steps, _og_instr, goal)
      when current_key == goal,
      do: steps

  def find_next(current_key, instructions, nodes, steps, og_instr, goal) do
    [dir | rest_instr] = instructions

    cond do
      dir == "L" ->
        find_next(
          Enum.find(nodes, fn n -> n[:key] == current_key end)[:left],
          rest_instr,
          nodes,
          steps + 1,
          og_instr,
          goal
        )

      dir == "R" ->
        find_next(
          Enum.find(nodes, fn n -> n[:key] == current_key end)[:right],
          rest_instr,
          nodes,
          steps + 1,
          og_instr,
          goal
        )

      true ->
        {:error, "You done goof"}
    end
  end
end
