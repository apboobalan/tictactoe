defmodule PlayerTest do
  use ExUnit.Case
  doctest Tictactoe.Player
  alias Tictactoe.Player
  alias Tictactoe.GameState
  alias Tictactoe.Position

  test "replace the coin in position" do
    state = GameState.new()
    {result, state} = Player.place(state, %Position{x: 1, y: 2}, :A)
    actual = state.matrix |> Enum.at(1) |> Enum.at(2)
    assert actual == :A
    assert result == :ok
    assert state.player1_move == 1
    assert state.player2_move == 0
  end

  test "return error if position is occupied" do
    state = %GameState{matrix: [[:x, :x, :x], [:x, :x, :A], [:x, :x, :x]]}
    {result, state} = Player.place(state, %Position{x: 1, y: 2}, :B)
    actual = state.matrix |> Enum.at(1) |> Enum.at(2)
    assert actual == :A
    assert result == :error
    assert state.player1_move == 0
    assert state.player2_move == 0
  end
end
