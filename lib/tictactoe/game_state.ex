defmodule Tictactoe.GameState do
  alias Tictactoe.Position
  @type t() :: %__MODULE__{}

  defstruct matrix: [[:x, :x, :x], [:x, :x, :x], [:x, :x, :x]],
            player1_move: 0,
            player2_move: 0


  def new do
    %__MODULE__{}
  end

  # find_pattern_in_row caluse

  defp find_pattern_in_row([], _player, result, _index) do
    result
  end

  defp find_pattern_in_row(row, player, result, index) do
    [head | rest] = row

    result =
      if player == head do
        List.insert_at(result, -1, index)
      else
        result
      end

    find_pattern_in_row(rest, player, result, index + 1)
  end

  # find_pattern_in_matrix caluse

  defp find_pattern_in_matrix([], _, pattern) do
    pattern
  end

  defp find_pattern_in_matrix(matrix, player, pattern) when is_list(pattern) do
    [row | rest] = matrix
    pattern_found = find_pattern_in_row(row, player, [], 1)
    pattern = pattern ++ pattern_found
    find_pattern_in_matrix(rest, player, pattern)
  end

  def is_winning_pattern(pattern) do
    case pattern do
      [1, 2, 3] -> :won
      [3, 2, 1] -> :won
      [1, 1, 1] -> :won
      [2, 2, 2] -> :won
      [3, 3, 3] -> :won
      _ -> :lost
    end
  end

  @spec done?(Tictactoe.GameState.t()) :: {false, :A | :B | nil} | {true, :A | :B}
  def done?(%Tictactoe.GameState{player1_move: 3, player2_move: 2} = gamestate) do
    patternResult = find_pattern_in_matrix(gamestate.matrix, :A, [])
    |> is_winning_pattern
    {patternResult == :won, :A}
  end

  def done?(%Tictactoe.GameState{player1_move: 3, player2_move: 3} = gamestate) do
    patternResult = find_pattern_in_matrix(gamestate.matrix, :B, [])
    |> Enum.sort()
    |> is_winning_pattern
    {patternResult == :won, :B}
  end

  def done?(%Tictactoe.GameState{} = _gamestate) do
    {false, nil}
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
