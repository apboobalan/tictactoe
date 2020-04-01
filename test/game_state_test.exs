defmodule GameStateTest do
  use ExUnit.Case
  doctest Tictactoe.GameState
  alias Tictactoe.GameState

  defp test_player_win(matrix) do
    state = %GameState{
      matrix: matrix
    }

    assert GameState.done?(state) == {true, :A}
  end

  test "win cases " do
    Enum.each(
      [
        [:A, :x, :x, :A, :x, :x, :A, :x, :x],
        [:x, :A, :x, :x, :A, :x, :x, :A, :x],
        [:x, :x, :A, :x, :x, :A, :x, :x, :A],
        [:A, :A, :A, :x, :x, :x, :x, :x, :x],
        [:x, :x, :x, :A, :A, :A, :x, :x, :x],
        [:x, :x, :x, :x, :x, :x, :A, :A, :A],
        [:A, :x, :x, :x, :A, :x, :x, :x, :A],
        [:x, :x, :A, :x, :A, :x, :A, :x, :x]
      ],
      &test_player_win/1
    )
  end

  test "game not over" do
    state = %GameState{
      matrix: [:A, :x, :x, :x, :A, :x, :x, :A, :x]
    }

    assert GameState.done?(state) == {false, nil}
  end

  test "replace the coin in position" do
    state = GameState.new()
    {result, state} = GameState.mark_position(state, 2)
    actual = state.matrix |> Enum.at(2)
    assert actual == :A
    assert result == :ok
  end

  test "return error if position is occupied" do
    state = %GameState{matrix: [:x, :x, :x, :x, :x, :A, :x, :x, :x], player: :B}
    {result, state} = GameState.mark_position(state, 5)
    actual = state.matrix |> Enum.at(5)
    assert actual == :A
    assert result == :error
  end
end
