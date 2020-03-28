defmodule Tictactoe.Game do
  alias Tictactoe.UI
  alias Tictactoe.GameState
  alias Tictactoe.Position
  alias Tictactoe.Player

  @spec init :: none
  def init() do
    start(GameState.new())
  end

  @spec start(any) :: none
  def start(gamestate = %GameState{}) do
    UI.print(gamestate.matrix)
    next_turn(gamestate, false, :A)
  end

  def next_turn(gamestate = %GameState{}, false, :A) do
    [x, y] = UI.read_input()
    handle_turn_result(Player.place(gamestate, %Position{x: x, y: y}, :A), :A, :B)
  end

  def next_turn(gamestate, false, :B) do
    [x, y] = UI.read_input()
    handle_turn_result(Player.place(gamestate, %Position{x: x, y: y}, :B), :B, :A)
  end

  def next_turn(gamestate = %GameState{}, :won, player) do
    IO.puts("Player #{player} won")
  end

  def next_turn(gamestate, true, _) do
    UI.print(gamestate.matrix)
  end


  defp handle_turn_result({:ok, gamestate} = turnResult, _currentPlayer, nextPlayer) do
    UI.print(gamestate.matrix)
    next_turn(gamestate, GameState.done?(gamestate), nextPlayer)
  end

  defp handle_turn_result({:error, gamestate} = turnResult, currentPlayer, _) do
    IO.puts("Invalid move")
    next_turn(gamestate, GameState.done?(gamestate), currentPlayer)
  end
end
