defmodule ApiWeb.UserViewTest do
  use ApiWeb.ConnCase, async: true

  import Phoenix.View
  import Api.Factory

  alias ApiWeb.UserView

  describe "render/3" do
    setup [:build_user]

    test "renders index.json", %{user: user} do
      assert %{success: true, data: data} = render(UserView, "index.json", users: [user])
      assert [%{id: id, email: email, name: name}] = data.users
      assert id == user.id
      assert email == user.email
      assert name == user.name
    end

    test "renders show.json", %{user: user} do
      assert %{success: true, data: data} = render(UserView, "show.json", user: user)
      assert data.user.id == user.id
      assert data.user.email == user.email
      assert data.user.name == user.name
    end

    test "renders user.json", %{user: user} do
      assert %{id: id, email: email, name: name} = render(UserView, "user.json", user: user)
      assert id == user.id
      assert email == user.email
      assert name == user.name
    end
  end

  defp build_user(_) do
    user = build(:user)

    {:ok, user: user}
  end
end
