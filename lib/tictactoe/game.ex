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
    next_turn(gamestate, false, :A, :B)
  end

  def next_turn(gamestate = %GameState{}, false, currentPlayer, nextPlayer) do
    [x, y] = UI.read_input()
    handle_turn_result(Player.place(gamestate, %Position{x: x, y: y}, currentPlayer), currentPlayer, nextPlayer)
  end

  # def next_turn(gamestate, false, :B) do
  #   [x, y] = UI.read_input()
  #   handle_turn_result(Player.place(gamestate, %Position{x: x, y: y}, :B), :B, :A)
  # end

  def next_turn(_gamestate = %GameState{}, true, _currentPlayer, nextPlayer) do
    IO.puts("Player #{nextPlayer} won")
  end

  def next_turn(gamestate, true, _) do
    UI.print(gamestate.matrix)
  end


  defp handle_turn_result({:ok, gamestate} = turnResult, currentPlayer, nextPlayer) do
    UI.print(gamestate.matrix)
    {gameDone, player} = GameState.done?(gamestate)
    next_turn(gamestate, gameDone, nextPlayer, currentPlayer)
  end

  defp handle_turn_result({:error, gamestate} = turnResult, currentPlayer, nextPlayer) do
    IO.puts("Invalid move")
    next_turn(gamestate, false, currentPlayer, nextPlayer)
  end
end
