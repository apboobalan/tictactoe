defmodule GameStateTest do
  use ExUnit.Case
  doctest Tictactoe.GameState
  alias Tictactoe.GameState

  test "return false if none of the players made 3 moves" do
    assert GameState.done?(%GameState{player1_move: 2, player2_move: 2}) == {false, nil}
  end

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

  test "player_1 lost" do
    state = %GameState{
      matrix: [[:A, :x, :x], [:x, :A, :x], [:x, :A, :x]],
      player1_move: 3,
      player2_move: 2
    }

    assert GameState.done?(state) == {false, :A}
  end

  test "should return won if pattern matches" do
    assert GameState.is_winning_pattern([1, 2, 3]) == :won
    assert GameState.is_winning_pattern([1, 1, 1]) == :won
    assert GameState.is_winning_pattern([2, 2, 2]) == :won
    assert GameState.is_winning_pattern([3, 3, 3]) == :won
  end
end
