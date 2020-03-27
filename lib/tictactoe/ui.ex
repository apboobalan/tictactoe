defmodule Tictactoe.UI do
  def print(state = []) do
    IO.puts("Printing Done")
  end

  def print(state) do
    [current_row | rest] = state
    print_row(current_row)
    print(rest)
  end

  defp print_row(row = []) do
    IO.puts("End of Print row")
  end

  defp print_row(row) when is_list(row) do
    [element | rest] = row
    IO.inspect(row)
    # print_row(rest)
  end
end
