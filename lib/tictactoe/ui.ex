defmodule Tictactoe.UI do
  @spec print([maybe_improper_list]) :: :ok
  def print([] = _matrix) do
    IO.puts("Printing Done")
  end

  def print(matrix) when is_list(matrix) do
    [current_row | rest] = matrix
    print_row(current_row)
    print(rest)
  end

  defp print_row([] = _row) do
    IO.puts("End of Print row")
  end

  defp print_row(row) when is_list(row) do
    IO.inspect(row)
  end

  @spec read_input :: [binary]
  def read_input() do
    IO.gets("Input the position by Row,Column formate. Ex 1,1 or 1,2")
    |> String.replace("\n", "")
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end
