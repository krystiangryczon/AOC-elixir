defmodule Advent.D08_02 do
  def calculate_lcm(numbers) do
    numbers
    |> Enum.reduce(1, &lcm/2)
  end

  defp lcm(a, b) do
    div(a * b, gcd(a, b))
  end

  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))

  def find_next(current_key, [], nodes, steps, og_instr, goal),
    do: find_next(current_key, og_instr, nodes, steps, og_instr, goal)

  def find_next(current_key, _instructions, _nodes, steps, _og_instr, goal)
      when current_key == goal,
      do: steps

  def find_next(current_key, instructions, nodes, steps, og_instr, goal) do
    [dir | rest_instr] = instructions

    if(String.ends_with?(current_key, "Z")) do
      steps
    else
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
end
