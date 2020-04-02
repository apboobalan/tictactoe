defmodule Tictactoe.GameState do
  use Agent
  @type t() :: %__MODULE__{}

  defstruct matrix: [:x, :x, :x, :x, :x, :x, :x, :x, :x], player: :A

  def new, do: %__MODULE__{}

  def game_status([x, x, x, _, _, _, _, _, _]) when x != :x, do: x
  def game_status([_, _, _, x, x, x, _, _, _]) when x != :x, do: x
  def game_status([_, _, _, _, _, _, x, x, x]) when x != :x, do: x
  def game_status([x, _, _, x, _, _, x, _, _]) when x != :x, do: x
  def game_status([_, x, _, _, x, _, _, x, _]) when x != :x, do: x
  def game_status([_, _, x, _, _, x, _, _, x]) when x != :x, do: x
  def game_status([x, _, _, _, x, _, _, _, x]) when x != :x, do: x
  def game_status([_, _, x, _, x, _, x, _, _]) when x != :x, do: x
  def game_status(_anythingelse), do: nil

  defp has_space(matrix) do
    Enum.member?(matrix, :x)
  end

  def done?(%__MODULE__{matrix: matrix}) do
    IO.inspect(self())
    playerWon = game_status(matrix)
    hasSpace = has_space(matrix)
    {game_ended?(playerWon, hasSpace), playerWon}
  end

  def game_ended?(player_won, has_next_move),
    do: player_won == :A || player_won == :B || !has_next_move

  defp is_position_free(matrix, position) when is_integer(position) do
    matrix |> Enum.at(position) == :x
  end

  def mark_position(agent, position) when is_integer(position) do
    gamestate = Agent.get(agent, & &1)

    {status, matrix} =
      replace(
        gamestate.matrix,
        position,
        gamestate.player,
        is_position_free(gamestate.matrix, position)
      )

    Agent.update(agent, fn gamestate -> %__MODULE__{gamestate | matrix: matrix} end)
    status
  end

  def replace(row, position, player, true) when is_integer(position) do
    {:ok, List.replace_at(row, position, player)}
  end

  def replace(row, _position, _player, false) do
    {:error, row}
  end
end
