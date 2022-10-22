defmodule ApiWeb.UserView do
  use ApiWeb, :view

  alias ApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{
      success: true,
      data: %{users: render_many(users, UserView, "user.json")}
    }
  end

  def render("show.json", %{user: user}) do
    %{
      success: true,
      data: %{user: render_one(user, UserView, "user.json")}
    }
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email
    }
  end
end
