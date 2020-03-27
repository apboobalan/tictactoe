defmodule Tictactoe.GameState do
  defstruct matrix: [[:x, :x, :x], [:x, :x, :x], [:x, :x, :x]],
            player1_move: 0,
            player2_move: 0

  # find_pattern_in_row caluse

  defp find_pattern_in_row([], player, result, index) do
    result
  end

  defp find_pattern_in_row(row, player, result, index) do
    [head | rest] = row

    result =
      if player == head do
        List.insert_at(result, -1, index)
      else
        result
      end

    find_pattern_in_row(rest, player, result, index + 1)
  end

  # find_pattern_in_matrix caluse

  defp find_pattern_in_matrix([], player, pattern) do
    pattern
  end

  defp find_pattern_in_matrix(matrix, player, pattern) when is_list(pattern) do
    [row | rest] = matrix
    pattern_found = find_pattern_in_row(row, player, [], 1)
    pattern = pattern ++ pattern_found
    find_pattern_in_matrix(rest, player, pattern)
  end

  def is_winning_pattern(pattern) do
    result =
      case pattern do
        [1, 2, 3] -> :won
        [1, 1, 1] -> :won
        [2, 2, 2] -> :won
        [3, 3, 3] -> :won
        _ -> :lost
      end
  end

  def done?(%Tictactoe.GameState{player1_move: 3, player2_move: 2} = gamestate) do
    find_pattern_in_matrix(gamestate.matrix, :A, [])
    |> Enum.sort()
    |> is_winning_pattern
  end

  def done?(%Tictactoe.GameState{player1_move: 3, player2_move: 3} = gamestate) do
    find_pattern_in_matrix(gamestate.matrix, :B, [])
    |> Enum.sort()
    |> is_winning_pattern
  end

  def done?(%Tictactoe.GameState{} = gamestate) do
    false
  end
end
