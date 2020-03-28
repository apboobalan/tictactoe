defmodule Tictactoe.Game do
  alias Tictactoe.UI
  alias Tictactoe.GameState

  def init() do
    start(GameState.new)
  end

  def start(state) do
    UI.print(state.matrix)
  end
end
