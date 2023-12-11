defmodule Advent.D10 do
  defp is_pipe(spot) do
    case spot do
      "." -> :dirt
      "S" -> :start
      _ -> :pipe
    end
  end

  @pipe %{
    "|" => [:top, :bottom],
    "-" => [:left, :right],
    "L" => [:top, :right],
    "J" => [:top, :left],
    "7" => [:bottom, :left],
    "F" => [:bottom, :right]
  }

  @pipes %{
    left: ["-", "L", "F"],
    right: ["-", "J", "7"],
    bottom: ["|", "L", "J"],
    top: ["|", "F", "7"]
  }

  @dir %{
    top: [0, -1],
    right: [1, 0],
    left: [-1, 0],
    bottom: [0, 1]
  }

  defp opposite(dir) do
    case dir do
      :right -> :left
      :left -> :right
      :top -> :bottom
      :bottom -> :top
      _ -> {:error, "opposite not working"}
    end
  end

  defp move(maze, curr, coming_from, step) do
    pipe_name = curr[:v]

    if(is_pipe(pipe_name) == :start) do
      step
    else
      [dir1, dir2] = @pipe[pipe_name]

      if(coming_from == dir1) do
        new_x = curr[:x] + List.first(@dir[dir2])
        new_y = curr[:y] + List.last(@dir[dir2])

        move(
          maze,
          %{
            v: Enum.at(Enum.at(maze, new_y), new_x),
            x: new_x,
            y: new_y
          },
          opposite(dir2),
          step + 1
        )
      else
        new_x = curr[:x] + List.first(@dir[dir1])
        new_y = curr[:y] + List.last(@dir[dir1])

        move(
          maze,
          %{
            v: Enum.at(Enum.at(maze, new_y), new_x),
            x: new_x,
            y: new_y
          },
          opposite(dir1),
          step + 1
        )
      end
    end
  end

  defp get_startpoint_index(maze) do
    [index_of_start] =
      maze
      |> Enum.with_index()
      |> Enum.map(fn {sublist, idx} ->
        s = Enum.find_index(sublist, fn el -> el == "S" end)

        case s do
          nil -> nil
          _ -> {s, idx}
        end
      end)
      |> Enum.filter(fn el -> el end)

    {x, y} = index_of_start
    %{x: x, y: y}
  end

  defp get_first_pipe(starting_point) do
    Enum.map(@dir, fn {dir, specs} ->
      new_x = starting_point[:x] + List.first(specs)
      new_y = starting_point[:y] + List.last(specs)
      %{dir: dir, x: new_x, y: new_y}
    end)
  end

  def execute(maze) do
    first_pipe =
      get_first_pipe(get_startpoint_index(maze))
      |> Enum.filter(fn el ->
        el[:x] >= 0 && el[:y] >= 0 && is_pipe(Enum.at(Enum.at(maze, el[:y]), el[:x])) == :pipe
      end)
      |> Enum.filter(fn el ->
        Enum.any?(@pipes[el[:dir]], fn p -> Enum.at(Enum.at(maze, el[:y]), el[:x]) == p end)
      end)
      |> List.first()

    move(
      maze,
      %{
        v: Enum.at(Enum.at(maze, first_pipe[:y]), first_pipe[:x]),
        x: first_pipe[:x],
        y: first_pipe[:y]
      },
      opposite(first_pipe[:dir]),
      1
    )
    |> div(2)
  end
end
