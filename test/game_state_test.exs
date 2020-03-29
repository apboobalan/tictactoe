defmodule GameStateTest do
  use ExUnit.Case
  doctest Tictactoe.GameState
  alias Tictactoe.GameState

  defp test_player_win(matrix) do
    state = %GameState{
      matrix: matrix,
      player1_move: 3,
      player2_move: 2
    }

    assert GameState.done?(state) == {true, :A}
  end

  test "player_1 win" do
    Enum.each(
      [
        [[:A, :x, :x], [:x, :A, :x], [:x, :x, :A]],
        [[:A, :x, :x], [:A, :x, :x], [:A, :x, :x]],
        [[:x, :A, :x], [:x, :A, :x], [:x, :A, :x]],
        [[:x, :x, :A], [:x, :x, :A], [:x, :x, :A]],
        [[:x, :x, :A], [:x, :A, :x], [:A, :x, :x]]
      ],
      &test_player_win/1
    )
  end

  test "game not over" do
    state = %GameState{
      matrix: [[:A, :x, :x], [:x, :A, :x], [:x, :A, :x]],
      player1_move: 3,
      player2_move: 2
    }

    assert GameState.done?(state) == {false, nil}
  end
end
