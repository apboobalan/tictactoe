defmodule Tictactoe do
  alias Tictactoe.Game

  # @moduledoc """
  # Documentation for `Tictactoe`.
  # """

  # @doc """
  # Hello world.

  # ## Examples

  #     iex> Tictactoe.hello()
  #     :world

  # """
  # def hello do
  #   :world
  # end

  def start do
    Game.init()
  end
end
