defmodule Tictactoe.Game do
  alias Tictactoe.UI
  alias Tictactoe.GameState

  @spec init :: :ok
  def init() do
    start(GameState.new())
  end

  defp next_player(:A), do: :B

  defp next_player(:B), do: :A

  @spec start(Tictactoe.GameState.t()) :: :ok
  def start(gamestate = %GameState{}) do
    UI.print(gamestate.matrix)
    IO.puts("Input the position by number strat from 1 - 9. Ex. 1, 7, 8")
    next_turn(gamestate, {false, nil})
  end

  @spec next_turn(Tictactoe.GameState.t(), {false, any} | {true, any}) :: :ok
  def next_turn(gamestate = %GameState{}, {false, _}) do
    position = UI.read_input(gamestate.player) - 1
    gamestate = GameState.mark_position(gamestate, position)
    check_status(gamestate)
  end

  def next_turn(_gamestate = %GameState{}, {true, nil}) do
    IO.puts("Game Tie")
  end

  def next_turn(_gamestate = %GameState{}, {true, player}) do
    IO.puts("Player #{player} won")
  end

  defp check_status({:ok, gamestate}) do
    UI.print(gamestate.matrix)
    game_status = GameState.done?(gamestate)
    gamestate = %GameState{gamestate | player: next_player(gamestate.player)}
    next_turn(gamestate, game_status)
  end

  defp check_status({:error, gamestate}) do
    IO.puts("Invalid move")
    next_turn(gamestate, {false, nil})
  end
end
