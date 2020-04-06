defmodule Tictactoe.Game do
  use Agent
  alias Tictactoe.GameState

  @spec start(atom | {:global, any} | {:via, atom, any}) :: {:error, any} | {:ok, pid}
  def start(gamename) do
    Agent.start(fn -> GameState.new() end, name: gamename)
  end

  def add_player(gamename) do
    gamestate = get_state(gamename)
    add_player_internal(gamestate, gamename)
  end

  defp add_player_internal(%GameState{player_count: 2}, _gamename) do
    :error
  end

  defp add_player_internal(%GameState{player_count: player}, gamename) when player < 2 do
    Agent.update(gamename, fn state -> %{state | player_count: state.player_count + 1} end )
    :ok
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

  def is_game_alive? (gamename) do
    Process.whereis(gamename) != nil
  end

  @spec kill_game(atom | pid | {atom, any} | {:via, atom, any}) :: :ok
  def kill_game(gamename) do
    kill_agent(gamename, is_game_alive?(gamename))
  end

  defp kill_agent(name, true) do
    Agent.stop(name, :kill)
  end

  defp kill_agent(_name, false) do
    :error
  end

end
