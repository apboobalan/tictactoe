defmodule Tictactoe.Player do
  alias Tictactoe.GameState
  alias Tictactoe.Position

  defp is_position_free(gamestate, position) do
    gamestate.matrix |> Enum.at(position.x) |> Enum.at(position.y) == :x
  end


  @spec place(Tictactoe.GameState.t(), Tictactoe.Position.t(), any) ::
          {:error, Tictactoe.GameState.t()} | {:ok, Tictactoe.GameState.t()}
  def place(gamestate = %GameState{}, position = %Position{}, player) do
    row = Enum.at(gamestate.matrix, position.x)
    {status, row} = GameState.replace(row, position, player, is_position_free(gamestate, position))
    gamestate = %GameState{gamestate | matrix: List.replace_at(gamestate.matrix, position.x, row)}
    {status, GameState.update_move(gamestate, player, status)}
  end
end
