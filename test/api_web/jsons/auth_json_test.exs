defmodule ApiWeb.AuthJSONTest do
  use ApiWeb.ConnCase

  import Api.Factories.UserFactory

  alias ApiWeb.Auth.AuthHandler
  alias ApiWeb.AuthJSON

  describe "show/1 returns success" do
    setup [:build_user, :build_auth]

    test "with auth data", %{user: user, token: token} do
      assert %{data: auth_data} = AuthJSON.show(%{auth: %{user: user, token: token}})

      assert auth_data.user.id == user.id
      assert auth_data.user.name == user.name
      assert auth_data.user.email == user.email
      assert auth_data.user.inserted_at == user.inserted_at
      assert auth_data.user.updated_at == user.updated_at
      assert auth_data.token == token
    end
  end

  defp build_user(_) do
    :user
    |> insert()
    |> then(&{:ok, user: &1})
  end

  defp build_auth(%{user: user}) do
    Map.new()
    |> Map.put("email", user.email)
    |> Map.put("password", user.password)
    |> AuthHandler.authenticate_user()
  end
end
