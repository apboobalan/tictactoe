defmodule Tictactoe.Game do
  use Agent
  alias Tictactoe.GameState

  @spec start(atom | {:global, any} | {:via, atom, any}) :: {:error, any} | {:ok, pid}
  def start(gamename) do
    Agent.start(fn -> GameState.new() end, name: gamename)
  end

  defp next_player(:A), do: :B

  defp next_player(:B), do: :A

  @spec next_turn(atom | pid | {atom, any} | {:via, atom, any}, integer) ::
          {false, any} | {true, any}
  def next_turn(gamename, position) do
    GameState.mark_position(gamename, position)
    game_status = GameState.done?(get_state(gamename))
    Agent.update(gamename, fn gamestate -> %GameState{gamestate | player: next_player(gamestate.player)} end)
    game_status
  end

  @spec get_state(atom | pid | {atom, any} | {:via, atom, any}) :: any
  def get_state (gamename) do
    Agent.get(gamename, & &1)
  end

  @spec kill_game(atom | pid | {atom, any} | {:via, atom, any}) :: :ok
  def kill_game(gamename) do
    Agent.stop(gamename, :normal)
  end
end
