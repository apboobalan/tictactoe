defmodule Tictactoe.Game do
  use Agent
  alias Tictactoe.UI
  alias Tictactoe.GameState

  @spec init :: pid
  def init() do
    # agent = IO.gets("Enter Game name")
    # |> String.replace("\n", "")
    # |> String.to_atom
    {:ok, agent} = Agent.start_link(fn -> GameState.new() end)
    # IO.inspect pid
    start(agent)
  end

  defp next_player(:A), do: :B

  defp next_player(:B), do: :A


  def start(agent) do
    # IO.inspect self()
    matrix = Agent.get(agent, fn state -> state.matrix end )
    UI.print(matrix)
    IO.puts("Input the position by number strat from 1 - 9. Ex. 1, 7, 8")
    next_turn(agent, {false, nil})
  end

  def next_turn(agent, {false, _}) do
    # IO.inspect(self())
    gamestate = Agent.get(agent, fn state -> state end)
    position = UI.read_input(gamestate.player) - 1
    status = GameState.mark_position(agent, position)
    check_status(status, agent)
  end

  def next_turn(_agent, {true, nil}) do
    IO.puts("Game Tie")
  end

  def next_turn(_agent, {true, player}) do
    IO.puts("Player #{player} won")
  end

  defp check_status(:ok, agent) do
    gamestate = Agent.get(agent, & &1)
    UI.print(gamestate.matrix)
    game_status = GameState.done?(gamestate)
    Agent.update(agent, fn gamestate -> %GameState{gamestate | player: next_player(gamestate.player)} end);
    next_turn(agent, game_status)
  end

  defp check_status(:error, agent) do
    IO.puts("Invalid move")
    next_turn(agent, {false, nil})
  end
end
