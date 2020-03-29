defmodule Tictactoe.Game do
  alias Tictactoe.UI
  alias Tictactoe.GameState
  alias Tictactoe.Position
  alias Tictactoe.Player

  @spec init :: :ok
  def init() do
    start(GameState.new())
  end

  @spec start(Tictactoe.GameState.t()) :: :ok
  def start(gamestate = %GameState{}) do
    UI.print(gamestate.matrix)
    next_turn(gamestate, {false, nil}, :A)
  end

  @spec next_turn(Tictactoe.GameState.t(), {false, any}, :A | :B) :: :ok
  def next_turn(gamestate = %GameState{}, {false, _}, :A) do
    [x, y] = UI.read_input()

    gamestate = Player.place(gamestate, %Position{x: x, y: y}, :A)
    check_status(gamestate, :A, :B)
  end

  def next_turn(gamestate = %GameState{}, {false, _}, :B) do
    [x, y] = UI.read_input()

    gamestate = Player.place(gamestate, %Position{x: x, y: y}, :B)
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
