defmodule ApiWeb.AuthJSON do
  @moduledoc """
  Renders authentication data.
  """

  alias ApiWeb.UserJSON

  @doc """
  Renders authentication.
  """
  def show(%{auth: %{user: user, token: token}}) do
    %{user: user}
    |> UserJSON.show()
    |> Map.update(:data, nil, &Map.new(user: &1, token: token))
  end

  def show(%{auth: auth}), do: auth
end
