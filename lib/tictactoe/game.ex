defmodule Tictactoe.Game do
  alias Tictactoe.UI
  alias Tictactoe.GameState

  @spec init :: :ok
  def init() do
    start(GameState.new())
  end

  def start(gamestate = %GameState{}) do
    UI.print(gamestate.matrix)
    IO.puts("Input the position by number strat from 1 - 9. Ex. 1, 7, 8")
    next_turn(gamestate, {false, nil}, :A)
  end

  def next_turn(gamestate = %GameState{}, {false, _}, :A) do
    position = UI.read_input(:A) - 1
    gamestate = GameState.mark_position(gamestate, position, :A)
    check_status(gamestate, :A, :B)
  end

  def next_turn(gamestate = %GameState{}, {false, _}, :B) do
    position = UI.read_input(:B) - 1
    gamestate = GameState.mark_position(gamestate, position, :B)
    check_status(gamestate, :B, :A)
  end

  def next_turn(_gamestate = %GameState{}, {true, nil}, _) do
    IO.puts("Game Tie")
  end

  def next_turn(_gamestate = %GameState{}, {true, player}, _) do
    IO.puts("Player #{player} won")
  end

  defp check_status({:ok, gamestate}, _currentPlayer, nextPlayer) do
    UI.print(gamestate.matrix)
    gameStatus = GameState.done?(gamestate)
    next_turn(gamestate, gameStatus, nextPlayer)
  end

  defp check_status({:error, gamestate}, currentPlayer, _nextPlayer) do
    IO.puts("Invalid move")
    next_turn(gamestate, {false, nil}, currentPlayer)
  end
end
