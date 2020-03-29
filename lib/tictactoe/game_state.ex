defmodule Tictactoe.GameState do
  alias Tictactoe.Position
  @type t() :: %__MODULE__{}

  defstruct matrix: [[:x, :x, :x], [:x, :x, :x], [:x, :x, :x]],
            player1_move: 0,
            player2_move: 0

  def new do
    %__MODULE__{}
  end

  def game_status([[:A, :A, :A], [_, _, _], [_, _, _]]) do
    :A
  end

  def game_status([[_, _, _], [:A, :A, :A], [_, _, _]]) do
    :A
  end

  def game_status([[_, _, _], [_, _, _], [:A, :A, :A]]) do
    :A
  end

  def game_status([[:A, _, _], [:A, _, _], [:A, _, _]]) do
    :A
  end

  def game_status([[_, :A, _], [_, :A, _], [_, :A, _]]) do
    :A
  end

  def game_status([[_, _, :A], [_, _, :A], [_, _, :A]]) do
    :A
  end

  def game_status([[:A, _, _], [_, :A, _], [_, _, :A]]) do
    :A
  end

  def game_status([[_, _, :A], [_, :A, _], [:A, _, _]]) do
    :A
  end

  def game_status([[:B, :B, :B], [_, _, _], [_, _, _]]) do
    :B
  end

  def game_status([[_, _, _], [:B, :B, :B], [_, _, _]]) do
    :B
  end

  def game_status([[_, _, _], [_, _, _], [:B, :B, :B]]) do
    :B
  end

  def game_status([[:B, _, _], [:B, _, _], [:B, _, _]]) do
    :B
  end

  def game_status([[_, :B, _], [_, :B, _], [_, :B, _]]) do
    :B
  end

  def game_status([[_, _, :B], [_, _, :B], [_, _, :B]]) do
    :B
  end

  def game_status([[:B, _, _], [_, :B, _], [_, _, :B]]) do
    :B
  end

  def game_status([[_, _, :B], [_, :B, _], [:B, _, _]]) do
    :B
  end

  def game_status(_anythingelse) do
    nil
  end

  defp has_space([], result) do
    result
  end

  defp has_space(matrix, result) do
    [head | tail] = matrix
    has_space(tail, result || Enum.member?(head, :x))
  end

  @spec done?(Tictactoe.GameState.t()) :: {false, :A | :B | nil} | {true, :A | :B | nil}
  def done?(gamestate = %__MODULE__{}) do
    playerWon = game_status(gamestate.matrix)
    hasSpace = has_space(gamestate.matrix, false)
    {playerWon == :A || playerWon == :B || !hasSpace, playerWon}
  end

  @spec replace(any, Tictactoe.Position.t(), any, boolean) :: {:error, any} | {:ok, [any]}
  def replace(row, position = %Position{}, player, true) do
    {:ok, List.replace_at(row, position.y, player)}
  end

  def replace(row, _position = %Position{}, _player, false) do
    {:error, row}
  end

  @spec update_move(Tictactoe.GameState.t(), any, :error | :ok) :: Tictactoe.GameState.t()
  def update_move(gameState = %__MODULE__{}, :A, :ok) do
    %__MODULE__{gameState | player1_move: gameState.player1_move + 1}
  end

  def update_move(gameState = %__MODULE__{}, :B, :ok) do
    %__MODULE__{gameState | player2_move: gameState.player2_move + 1}
  end

  def update_move(gameState = %__MODULE__{}, _, :error) do
    gameState
  end
end
