defmodule Tictactoe.UI do
  
  def print([] = _matrix) do
    IO.puts("Printing Done")
  end

  defp transform(x, position) when x == :x, do: position

  defp transform(x, position), do: x

  def print(matrix) when is_list(matrix) do
    for i <- [0, 1, 2] do
      for j <- [0, 1, 2] do
        matrix |> Enum.at(i * 3 + j) |> transform(i * 3 + j + 1) |> IO.write
        IO.write "  "
      end
      IO.puts ""
    end
    
  end

  
  def read_input(player) do
    IO.gets("Player #{player} Turn")
    |> String.replace("\n", "")
    |> String.to_integer
  end
end
