defmodule Api.Accounts.User.Update do
  @moduledoc false
  alias Api.Accounts.User
  alias Api.Repo

  @doc false
  def call(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end
end
